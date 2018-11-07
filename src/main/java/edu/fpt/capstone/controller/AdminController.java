package edu.fpt.capstone.controller;

import java.util.List;

import javax.annotation.PostConstruct;

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
import edu.fpt.capstone.entity.Chapter;
import edu.fpt.capstone.entity.Division;
import edu.fpt.capstone.entity.Exercise;
import edu.fpt.capstone.entity.Lesson;
import edu.fpt.capstone.entity.Mathform;
import edu.fpt.capstone.entity.Version;
import edu.fpt.capstone.service.ChapterService;
import edu.fpt.capstone.service.DivisionService;
import edu.fpt.capstone.service.ExerciseService;
import edu.fpt.capstone.service.GradeService;
import edu.fpt.capstone.service.LessonService;
import edu.fpt.capstone.service.MathFormulasAdminService;
import edu.fpt.capstone.service.MathformService;
import edu.fpt.capstone.service.QuestionChoiceService;
import edu.fpt.capstone.service.QuestionService;
import edu.fpt.capstone.service.VersionService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class AdminController {
				
	@Autowired
	MathFormulasAdminService service;
	
	@Autowired
	ChapterService chapterService;
	
	@Autowired
	DivisionService divisionService;
	
	@Autowired
	ExerciseService exerciseService;
	
	@Autowired
	GradeService gradeService;
	
	@Autowired
	LessonService lessonService;
	
	@Autowired
	MathformService mathformService;
	
	@Autowired
	QuestionChoiceService questionChoiceService;
	
	@Autowired
	QuestionService questionService;
	
	@Autowired
	VersionService versionService;
	
	@PostConstruct
	protected void init() {
		if (versionService.countVersion() == 0) {
			service.initializeData();
		}
		
	}
		
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		List<Division> divisions = divisionService.getAllDivisions();
		model.addAttribute("DIVISIONS", divisions);
		return "home";
	}
	
	@RequestMapping(value = "add-version", method = RequestMethod.GET)
	public String addVersion(Model model) {
		model.addAttribute("version", new Version());
		model.addAttribute("latest", versionService.getCurrentVersion());
		return "upgrade-db";
	}
	
	@RequestMapping(value = "upgrade-version", method = RequestMethod.POST)
	public String upgradeVersion(@ModelAttribute("version") Version version) {
		int latestVersionId = versionService.upgradeVersion(version).getId();
		service.updateDataDbVersion(latestVersionId);
		return "redirect:show-versions";
	}
	
	@RequestMapping(value = "show-chapters", method = RequestMethod.GET)
	public String showChapters() {
		return "show-chapters";
	}
	
	@RequestMapping(value = "delete-chapter", method = RequestMethod.GET)
	public String deleteChapter(@RequestParam("chapterId") int chapterId) {
		chapterService.deleteChapter(chapterId);
		return "show-chapters";
	}
	
	@RequestMapping(value = "show-lessons", method = RequestMethod.GET)
	public String showLessons(@RequestParam("chapterId") int chapterId, Model model) {
		Chapter chapter = chapterService.getChapterById(chapterId);
		model.addAttribute("chapter", chapter);
		List<Lesson> lessons = lessonService.getLessonsByChapter(chapter);
		model.addAttribute("LESSONS", lessons);
		List<Division> divisions = divisionService.getAllDivisions();
		model.addAttribute("DIVISIONS", divisions);
		return "show-lessons";
	}
	
	@RequestMapping(value = "add-new-chapter", method = RequestMethod.GET)
	public String addChapter(@RequestParam("divId") int divisionId, Model model) {
		Division division = divisionService.getDivisionById(divisionId);
		Chapter chapter = new Chapter();
		chapter.setDivisionId(division);
		model.addAttribute("chapter", chapter);
		return "add-chapter";
	}
	
	@RequestMapping(value = "add-new-lesson", method = RequestMethod.GET)
	public String addLesson(@RequestParam("chapterId") int chapterId, Model model) {
		List<Division> divisions = divisionService.getAllDivisions();
		Chapter chapter = chapterService.getChapterById(chapterId);
		model.addAttribute("chapter", chapter);
		Lesson lesson = new Lesson();
		lesson.setChapterId(chapter);
		model.addAttribute("DIVISIONS", divisions);
		model.addAttribute("lesson", lesson);
		return "add-lesson";
	}
	
	@RequestMapping(value = "save-new-lesson", method = RequestMethod.POST)
	public String saveNewLesson(@ModelAttribute("lesson") Lesson lesson) {
		Version noneVersion = versionService.getVersionById(0);
		Chapter chapter = chapterService.getChapterById(lesson.getChapterId().getId());
		lesson.setChapterId(chapter);
		lesson.setVersionId(noneVersion);
		lessonService.saveLesson(lesson);
		return "redirect:show-lessons?chapterId=" + chapter.getId();
	}
	
	@RequestMapping(value = "edit-lesson", method = RequestMethod.GET)
	public String editLesson(@RequestParam("lessonId") int lessonId, Model model) {
		List<Division> divisions = divisionService.getAllDivisions();
		model.addAttribute("DIVISIONS", divisions);
		Lesson lesson = lessonService.getLessonById(lessonId);
		model.addAttribute("lesson", lesson);
		return "edit-lesson";
	}
	
	@RequestMapping(value = "save-edit-lesson", method = RequestMethod.POST)
	public String saveEditLesson(@ModelAttribute("lesson") Lesson newLesson) {
		Version noneVersion = versionService.getVersionById(0);
		Lesson oldLesson = lessonService.getLessonById(newLesson.getId());
		if(!oldLesson.getLessonTitle().equals(newLesson.getLessonTitle())
				|| !oldLesson.getLessonContent().equals(newLesson.getLessonContent())) {
			oldLesson.setLessonTitle(newLesson.getLessonTitle());
			oldLesson.setLessonContent(newLesson.getLessonContent());
			oldLesson.setVersionId(noneVersion);
			lessonService.saveLesson(oldLesson);
		}
		return "redirect:show-lessons?chapterId=" + oldLesson.getChapterId().getId();
	}
	
	@RequestMapping(value = "delete-lesson", method = RequestMethod.GET)
	public String deleteLesson(@RequestParam("lessonId") int lessonId,
								@RequestParam("chapterId") int chapterId) {
		lessonService.deleteLesson(lessonId);
		return "redirect:show-lessons?chapterId=" + chapterId;
	}
	
	@RequestMapping(value = "show-mathforms", method = RequestMethod.GET)
	public String showMathforms(@RequestParam("lessonId") int lessonId, Model model) {
		model.addAttribute("LESSONID", lessonId);
		return "show-mathforms";
	}
	
	@RequestMapping(value = "add-mathform", method = RequestMethod.GET)
	public String addMathform(@RequestParam("lessonId") int lessonId, Model model) {
		Lesson lesson = lessonService.getLessonById(lessonId);
		Mathform mathform = new Mathform();
		mathform.setLessonId(lesson);
		model.addAttribute("mathform", mathform);
		return "add-mathform";
	}
	
	@RequestMapping(value = "save-new-mathform", method = RequestMethod.POST)
	public String saveNewMathform(@ModelAttribute("mathform") Mathform mathform) {
		Version noneVersion = versionService.getVersionById(0);
		Lesson lesson = lessonService.getLessonById(mathform.getLessonId().getId());
		mathform.setLessonId(lesson);
		mathform.setVersionId(noneVersion);
		mathformService.saveMathform(mathform);
		return "redirect:show-mathforms?lessonId=" + lesson.getId();
	}
	
	@RequestMapping(value = "edit-mathform", method = RequestMethod.GET)
	public String editMathform(@RequestParam("mathformId") int mathformId, Model model) {
		Mathform mathform = mathformService.getMathformById(mathformId);
		model.addAttribute("mathform", mathform);
		return "edit-mathform";
	}
	
	@RequestMapping(value = "save-edit-mathform", method = RequestMethod.POST)
	public String saveEditMathform(@ModelAttribute("mathform") Mathform newMathform) {
		Version noneVersion = versionService.getVersionById(0);
		Mathform oldMathform = mathformService.getMathformById(newMathform.getId());
		if(!oldMathform.getMathformTitle().equals(newMathform.getMathformTitle())
				|| !oldMathform.getMathformContent().equals(newMathform.getMathformContent())) {
			oldMathform.setMathformTitle(newMathform.getMathformTitle());
			oldMathform.setMathformContent(newMathform.getMathformContent());
			oldMathform.setVersionId(noneVersion);
			mathformService.saveMathform(oldMathform);
		}
		return "redirect:mathform-detail?mathformId=" + oldMathform.getId();
	}
	
	@RequestMapping(value = "mathform-detail", method = RequestMethod.GET)
	public String getMathformDetail(@RequestParam("mathformId") int mathformId, Model model) {
		Mathform mathform = mathformService.getMathformById(mathformId);
		model.addAttribute("MATHFORM", mathform);
		List<Exercise> exercises = exerciseService.getExercisesByMathform(mathform);
		model.addAttribute("exercises", exercises);
		return "mathform-detail";
	}
	
	@RequestMapping(value = "delete-mathform", method = RequestMethod.GET)
	public String deleteMathform(@RequestParam("mathformId") int mathformId, 
								@RequestParam("lessonId") int lessonId) {
		mathformService.deleteMathform(mathformId);
		return "redirect:show-mathforms?lessonId=" + lessonId;
	}
	
	@RequestMapping(value = "add-exercise", method = RequestMethod.GET)
	public String addExercise(@RequestParam("mathformId") int mathformId, Model model) {
		Mathform mathform = mathformService.getMathformById(mathformId);
		Exercise exercise = new Exercise();
		exercise.setMathformId(mathform);
		model.addAttribute("exercise", exercise);
		return "add-exercise";
	}

	@RequestMapping(value = "save-new-exercise", method = RequestMethod.POST)
	public String saveExercise(@ModelAttribute("exercise") Exercise exercise) {
		Mathform mathform = mathformService.getMathformById(exercise.getMathformId().getId());
		Version noneVersion = versionService.getVersionById(0);
		exercise.setMathformId(mathform);
		exercise.setVersionId(noneVersion);
		exerciseService.saveExercise(exercise);
		return "redirect:mathform-detail?mathformId=" + exercise.getMathformId().getId();
	}
	
	@RequestMapping(value = "edit-exercise", method = RequestMethod.GET)
	public String editExercise(@RequestParam("exId") int exerciseId, Model model) {
		Exercise exercise = exerciseService.getExerciseById(exerciseId);
		model.addAttribute("exercise", exercise);
		return "edit-exercise";
	}
	
	@RequestMapping(value = "save-edit-exercise", method = RequestMethod.POST)
	public String saveEditExercise(@ModelAttribute("exercise") Exercise newExercise) {
		Exercise oldExercise = exerciseService.getExerciseById(newExercise.getId());
		Version noneVersion = versionService.getVersionById(0);
		if(!oldExercise.getTopic().equals(newExercise.getTopic())
				|| !oldExercise.getAnswer().equals(newExercise.getAnswer())) {
			oldExercise.setTopic(newExercise.getTopic());
			oldExercise.setAnswer(newExercise.getAnswer());
			oldExercise.setVersionId(noneVersion);
			exerciseService.saveExercise(oldExercise);
		}
		return "redirect:mathform-detail?mathformId=" + oldExercise.getMathformId().getId();
	}
	
	@RequestMapping(value = "delete-exercise", method = RequestMethod.GET)
	public String deleteExercise(@RequestParam("exId") int exerciseId, 
								@RequestParam("mathformId") int mathformId) {
		exerciseService.deleteExercise(exerciseId);
		return "redirect:mathform-detail?mathformId=" + mathformId;
	}
	
	@RequestMapping(value = "show-questions", method = RequestMethod.GET)
	public String showQuestions(Model model) {
		List<Quizes> data = questionService.getQuizesData(0);
		model.addAttribute("QUIZES", data);
		return "show-questions";
	}
	
	@RequestMapping(value = "/load-photo", method = RequestMethod.GET, produces = MediaType.IMAGE_JPEG_VALUE)
	public ResponseEntity<byte[]> loadPhoto(@RequestParam(value = "chapterId") int chapterId) {
		Chapter chapter = chapterService.getChapterById(chapterId);
		byte[] image = chapter.getChapterIcon();
		final HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.IMAGE_JPEG);
		return new ResponseEntity<byte[]>(image, headers, HttpStatus.CREATED);
	}
	
	@RequestMapping(value = "quiz-detail", method = RequestMethod.GET)
	public String quizDetail(@RequestParam("lessonId") int lessonId, Model model) {
		Quizes quiz = questionService.getQuizesData(lessonId).get(0);
		List<QuestionAnswer> quizData = questionService.getQuizQuestionsByLesson(lessonId);
		model.addAttribute("quiz", quiz);
		model.addAttribute("qas", quizData);
		return "quiz-detail";
	}
	
	@RequestMapping(value = "add-question", method = RequestMethod.GET)
	public String addQuestion(@RequestParam("lessonId") int lessonId, Model model) {
		model.addAttribute("lessonId", lessonId);
		QuestionAnswer qa = new QuestionAnswer();
		qa.setLessonId(lessonId);
		model.addAttribute("qa", qa);
		return "add-question";
	}
	
	@RequestMapping(value = "save-quiz-question", method = RequestMethod.POST)
	public String saveNewQuestion(@ModelAttribute("qa") QuestionAnswer qa) {
		questionService.saveQuizQuestion(qa);
		return "redirect:quiz-detail?lessonId=" + qa.getLessonId();
	}
	
	@RequestMapping(value = "edit-question", method = RequestMethod.GET)
	public String editQuestion(@RequestParam("questionId") int questionId, Model model) {
		QuestionAnswer qa = questionService.getQuizQuestionByQuestionId(questionId);
		model.addAttribute("qa", qa);
		return "edit-question";
	}
	
	@RequestMapping(value = "save-edit-quiz-question", method = RequestMethod.POST)
	public String saveEditQuestion(@ModelAttribute("qa") QuestionAnswer qa) {
		questionService.saveQuizQuestion(qa);
		return "redirect:quiz-detail?lessonId=" + qa.getLessonId();
	}
	
	@RequestMapping(value = "delete-question", method = RequestMethod.GET)
	public String deleteQuizQuestion(@RequestParam("questionId") int questionId, 
									@RequestParam("lessonId") int lessonId) {
		questionService.deleteQuizQuestion(questionId);
		return "redirect:quiz-detail?lessonId=" + lessonId;
	}
	
	@RequestMapping(value = "show-versions", method = RequestMethod.GET)
	public String showVersions() {
		return "show-versions";
	}
	
	@RequestMapping(value = "android/math-editor", method = RequestMethod.GET)
	public String inputMath() {
		return "math-editor";
	}
}