package edu.fpt.capstone.controller;

import java.util.List;

import javax.annotation.PostConstruct;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import edu.fpt.capstone.data.QuestionAnswer;
import edu.fpt.capstone.data.Quizes;
import edu.fpt.capstone.entity.Category;
import edu.fpt.capstone.entity.Division;
import edu.fpt.capstone.entity.Exercises;
import edu.fpt.capstone.entity.Lesson;
import edu.fpt.capstone.entity.Mathform;
import edu.fpt.capstone.entity.Version;
import edu.fpt.capstone.service.MathFormulasAdminService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class AdminController {
	
	private static final Logger log = Logger.getLogger(AdminController.class);
			
	@Autowired
	MathFormulasAdminService mathFormulasAdminService;
	
	@PostConstruct
	protected void init() {
		if (mathFormulasAdminService.countVersion() == 0) {
			Version version = new Version(0, 0, "None Version", true);
			mathFormulasAdminService.addVersion(version);
		}
	}
		
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		List<Division> divisions = mathFormulasAdminService.getAllDivisions();
		model.addAttribute("DIVISIONS", divisions);
		return "home";
	}
	
	@RequestMapping(value = "add-version", method = RequestMethod.GET)
	public String addVersion(Model model) {
		model.addAttribute("version", new Version());
		model.addAttribute("latest", mathFormulasAdminService.getCurrentVersion());
		return "upgrade-db";
	}
	
	@RequestMapping(value = "upgrade-version", method = RequestMethod.POST)
	public String upgradeVersion(@ModelAttribute("version") Version version) {
		int latestVersionId = mathFormulasAdminService.addVersion(version).getId();
		mathFormulasAdminService.updateDataDbVersion(latestVersionId);
		return "redirect:show-versions";
	}
	
	@RequestMapping(value = "show-categories", method = RequestMethod.GET)
	public String showCategories() {
		return "show-categories";
	}
	
	@RequestMapping(value = "show-lessons", method = RequestMethod.GET)
	public String showLessons(@RequestParam("categoryId") int categoryId, Model model) {
		Category category = mathFormulasAdminService.getCategoryById(categoryId);
		model.addAttribute("CAT", category);
		List<Lesson> lessons = mathFormulasAdminService.getLessonsByCategory(category);
		model.addAttribute("LESSONS", lessons);
		List<Division> divisions = mathFormulasAdminService.getAllDivisions();
		model.addAttribute("DIVISIONS", divisions);
		return "show-lessons";
	}
	
	@RequestMapping(value = "add-new-category", method = RequestMethod.GET)
	public String addCategory(@RequestParam("divId") int divisionId, Model model) {
		Division division = mathFormulasAdminService.getDivisionById(divisionId);
		Category category = new Category();
		category.setDivisionId(division);
		model.addAttribute("category", category);
		return "add-category";
	}
	
	@RequestMapping(value = "add-new-lesson", method = RequestMethod.GET)
	public String addLesson(@RequestParam("categoryId") int categoryId, Model model) {
		List<Division> divisions = mathFormulasAdminService.getAllDivisions();
		Category category = mathFormulasAdminService.getCategoryById(categoryId);
		model.addAttribute("CAT", category);
		Lesson lesson = new Lesson();
		lesson.setCategoryId(category);
		model.addAttribute("DIVISIONS", divisions);
		model.addAttribute("lesson", lesson);
		return "add-lesson";
	}
	
	@RequestMapping(value = "save-new-lesson", method = RequestMethod.POST)
	public String saveNewLesson(@ModelAttribute("lesson") Lesson lesson) {
		Version noneVersion = mathFormulasAdminService.getVersionById(0);
		Category category = mathFormulasAdminService.getCategoryById(
				lesson.getCategoryId().getId()
		);
		lesson.setCategoryId(category);
		lesson.setVersionId(noneVersion);
		mathFormulasAdminService.saveLesson(lesson);
		return "redirect:show-lessons?categoryId=" + category.getId();
	}
	
	@RequestMapping(value = "edit-lesson", method = RequestMethod.GET)
	public String editLesson(@RequestParam("lessonId") int lessonId, Model model) {
		List<Division> divisions = mathFormulasAdminService.getAllDivisions();
		model.addAttribute("DIVISIONS", divisions);
		Lesson lesson = mathFormulasAdminService.getLessonById(lessonId);
		model.addAttribute("lesson", lesson);
		return "edit-lesson";
	}
	
	@RequestMapping(value = "save-edit-lesson", method = RequestMethod.POST)
	public String saveEditLesson(@ModelAttribute("lesson") Lesson newLesson) {
		Version noneVersion = mathFormulasAdminService.getVersionById(0);
		Lesson oldLesson = mathFormulasAdminService.getLessonById(newLesson.getId());
		if(!oldLesson.getLessonTitle().equals(newLesson.getLessonTitle())
				|| !oldLesson.getLessonContent().equals(newLesson.getLessonContent())) {
			oldLesson.setLessonTitle(newLesson.getLessonTitle());
			oldLesson.setLessonContent(newLesson.getLessonContent());
			oldLesson.setVersionId(noneVersion);
			mathFormulasAdminService.saveLesson(oldLesson);
		}
		return "redirect:show-lessons?categoryId=" + oldLesson.getCategoryId().getId();
	}
	
	@RequestMapping(value = "show-mathforms", method = RequestMethod.GET)
	public String showMathforms(@RequestParam("lessonId") int lessonId, Model model) {
		model.addAttribute("LESSONID", lessonId);
		return "show-mathforms";
	}
	
	@RequestMapping(value = "add-mathform", method = RequestMethod.GET)
	public String addMathform(@RequestParam("lessonId") int lessonId, Model model) {
		Lesson lesson = mathFormulasAdminService.getLessonById(lessonId);
		Mathform mathform = new Mathform();
		mathform.setLessonId(lesson);
		model.addAttribute("mathform", mathform);
		return "add-mathform";
	}
	
	@RequestMapping(value = "save-new-mathform", method = RequestMethod.POST)
	public String saveNewMathform(@ModelAttribute("mathform") Mathform mathform) {
		Version noneVersion = mathFormulasAdminService.getVersionById(0);
		Lesson lesson = mathFormulasAdminService.getLessonById(mathform.getLessonId().getId());
		mathform.setLessonId(lesson);
		mathform.setVersionId(noneVersion);
		mathFormulasAdminService.saveMathform(mathform);
		return "redirect:show-mathforms?lessonId=" + lesson.getId();
	}
	
	@RequestMapping(value = "edit-mathform", method = RequestMethod.GET)
	public String editMathform(@RequestParam("mathformId") int mathformId, Model model) {
		Mathform mathform = mathFormulasAdminService.getMathformById(mathformId);
		model.addAttribute("mathform", mathform);
		return "edit-mathform";
	}
	
	@RequestMapping(value = "save-edit-mathform", method = RequestMethod.POST)
	public String saveEditMathform(@ModelAttribute("mathform") Mathform newMathform) {
		Version noneVersion = mathFormulasAdminService.getVersionById(0);
		Mathform oldMathform = mathFormulasAdminService.getMathformById(newMathform.getId());
		if(!oldMathform.getMathformTitle().equals(newMathform.getMathformTitle())
				|| !oldMathform.getMathformContent().equals(newMathform.getMathformContent())) {
			oldMathform.setMathformTitle(newMathform.getMathformTitle());
			oldMathform.setMathformContent(newMathform.getMathformContent());
			oldMathform.setVersionId(noneVersion);
			mathFormulasAdminService.saveMathform(oldMathform);
		}
		return "redirect:show-mathforms?lessonId=" + oldMathform.getLessonId().getId();
	}
	
	@RequestMapping(value = "mathform-detail", method = RequestMethod.GET)
	public String getMathformDetail(@RequestParam("mathformId") int mathformId, Model model) {
		Mathform mathform = mathFormulasAdminService.getMathformById(mathformId);
		model.addAttribute("MATHFORM", mathform);
		return "mathform-detail";
	}
	
	@RequestMapping(value = "add-exercise", method = RequestMethod.GET)
	public String addExercise(@RequestParam("mathformId") int mathformId, Model model) {
		Mathform mathform = mathFormulasAdminService.getMathformById(mathformId);
		Exercises exercise = new Exercises();
		exercise.setMathFormId(mathform);
		model.addAttribute("exercise", exercise);
		return "add-exercise";
	}

	@RequestMapping(value = "save-new-exercise", method = RequestMethod.POST)
	public String saveExercise(@ModelAttribute("exercise") Exercises exercise) {
		Mathform mathform = mathFormulasAdminService.getMathformById(exercise.getMathFormId().getId());
		Version noneVersion = mathFormulasAdminService.getVersionById(0);
		exercise.setMathFormId(mathform);
		exercise.setVersionId(noneVersion);
		mathFormulasAdminService.saveExercise(exercise);
		return "redirect:mathform-detail?mathformId=" + exercise.getMathFormId().getId();
	}
	
	@RequestMapping(value = "edit-exercise", method = RequestMethod.GET)
	public String editExercise(@RequestParam("exId") int exerciseId, Model model) {
		Exercises exercise = mathFormulasAdminService.getExerciseById(exerciseId);
		model.addAttribute("exercise", exercise);
		return "edit-exercise";
	}
	
	@RequestMapping(value = "save-edit-exercise", method = RequestMethod.POST)
	public String saveEditExercise(@ModelAttribute("exercise") Exercises newExercise) {
		Exercises oldExercise = mathFormulasAdminService.getExerciseById(newExercise.getId());
		Version noneVersion = mathFormulasAdminService.getVersionById(0);
		if(!oldExercise.getTopic().equals(newExercise.getTopic())
				|| !oldExercise.getAnswer().equals(newExercise.getAnswer())) {
			oldExercise.setTopic(newExercise.getTopic());
			oldExercise.setAnswer(newExercise.getAnswer());
			oldExercise.setVersionId(noneVersion);
			mathFormulasAdminService.saveExercise(oldExercise);
		}
		return "redirect:mathform-detail?mathformId=" + oldExercise.getMathFormId().getId();
	}
	
	@RequestMapping(value = "show-questions", method = RequestMethod.GET)
	public String showQuestions(Model model) {
		List<Quizes> data = mathFormulasAdminService.getQuizesData(0);
		model.addAttribute("QUIZES", data);
		return "show-questions";
	}
	
	@RequestMapping(value = "/load-photo", method = RequestMethod.GET, produces = MediaType.IMAGE_JPEG_VALUE)
	public ResponseEntity<byte[]> loadPhoto(@RequestParam(value = "categoryId") int categoryId) {
		Category category = mathFormulasAdminService.getCategoryById(categoryId);
		byte[] image = category.getCategoryIcon();
		final HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.IMAGE_JPEG);
		return new ResponseEntity<byte[]>(image, headers, HttpStatus.CREATED);
	}
	
	@RequestMapping(value = "quiz-detail", method = RequestMethod.GET)
	public String quizDetail(@RequestParam("categoryId") int categoryId, Model model) {
		Quizes quiz = mathFormulasAdminService.getQuizesData(categoryId).get(0);
		List<QuestionAnswer> quizData = mathFormulasAdminService.getQuizQuestionsByCategory(categoryId);
		model.addAttribute("quiz", quiz);
		model.addAttribute("qas", quizData);
		return "quiz-detail";
	}
	
	@RequestMapping(value = "add-question", method = RequestMethod.GET)
	public String addQuestion(@RequestParam("categoryId") int categoryId, Model model) {
		model.addAttribute("categoryId", categoryId);
		QuestionAnswer qa = new QuestionAnswer();
		qa.setCategoryId(categoryId);
		model.addAttribute("qa", qa);
		return "add-question";
	}
	
	@RequestMapping(value = "save-quiz-question", method = RequestMethod.POST)
	public String saveNewQuestion(@ModelAttribute("qa") QuestionAnswer qa) {
		mathFormulasAdminService.saveQuizQuestion(qa);
		return "redirect:quiz-detail?categoryId=" + qa.getCategoryId();
	}
	
	@RequestMapping(value = "edit-question", method = RequestMethod.GET)
	public String editQuestion(@RequestParam("questionId") int questionId, Model model) {
		QuestionAnswer qa = mathFormulasAdminService.getQuizQuestionByQuestionId(questionId);
		model.addAttribute("qa", qa);
		return "edit-question";
	}
	
	@RequestMapping(value = "save-edit-quiz-question", method = RequestMethod.POST)
	public String saveEditQuestion(@ModelAttribute("qa") QuestionAnswer qa) {
		mathFormulasAdminService.saveQuizQuestion(qa);
		return "redirect:quiz-detail?categoryId=" + qa.getCategoryId();
	}
	
	@RequestMapping(value = "delete-question", method = RequestMethod.GET)
	public String deleteQuizQuestion(@RequestParam("questionId") int questionId, 
									@RequestParam("categoryId") int categoryId) {
		mathFormulasAdminService.deleteQuizQuestion(questionId);
		return "redirect:quiz-detail?categoryId=" + categoryId;
	}
	
	@RequestMapping(value = "show-versions", method = RequestMethod.GET)
	public String deleteQuizQuestion() {
		return "show-versions";
	}
}