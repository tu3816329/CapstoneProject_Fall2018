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
import org.springframework.web.bind.annotation.SessionAttributes;

import edu.fpt.capstone.data.SolutionTable;
import edu.fpt.capstone.data.QuestionAnswer;
import edu.fpt.capstone.data.Quizes;
import edu.fpt.capstone.entity.Chapter;
import edu.fpt.capstone.entity.Subject;
import edu.fpt.capstone.entity.Exercise;
import edu.fpt.capstone.entity.Lesson;
import edu.fpt.capstone.entity.Solution;
import edu.fpt.capstone.entity.Version;
import edu.fpt.capstone.service.ChapterService;
import edu.fpt.capstone.service.SubjectService;
import edu.fpt.capstone.service.ExerciseService;
import edu.fpt.capstone.service.GradeService;
import edu.fpt.capstone.service.LessonService;
import edu.fpt.capstone.service.MathFormulasAdminService;
import edu.fpt.capstone.service.SolutionService;
import edu.fpt.capstone.service.QuestionChoiceService;
import edu.fpt.capstone.service.QuestionService;
import edu.fpt.capstone.service.VersionService;

/**
 * Handles requests for the application home page.
 */
@Controller
@SessionAttributes(value = {"subjecttree", "gradetree", "chaptertree", "lessontree", "solutiontree", 
		"currentversion"})
public class AdminController {

	@Autowired
	MathFormulasAdminService service;

	@Autowired
	ChapterService chapterService;

	@Autowired
	SubjectService subjectService;

	@Autowired
	ExerciseService exerciseService;

	@Autowired
	GradeService gradeService;

	@Autowired
	LessonService lessonService;

	@Autowired
	SolutionService solutionService;

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
		model.addAttribute("gradetree", gradeService.getAllGrades());
		model.addAttribute("subjecttree", subjectService.getAllSubjects());
		model.addAttribute("chaptertree", chapterService.getChapterTreeData());
		model.addAttribute("lessontree", lessonService.getLessonTreeData());
		model.addAttribute("solutiontree", solutionService.getSolutionTreeData());
		model.addAttribute("currentversion", versionService.getCurrentVersion());
		model.addAttribute("newchapters", chapterService.getNoneVersionChapters());
		model.addAttribute("newlessons", lessonService.getNoneVersionLessons());
		model.addAttribute("newsolutions", solutionService.getNoneVersionSolutions());
		model.addAttribute("versions", versionService.getAllVersion());
		return "home";
	}

	@RequestMapping(value = "add-version", method = RequestMethod.GET)
	public String addVersion(Model model) {
		model.addAttribute("version", new Version());
		model.addAttribute("latest", versionService.getCurrentVersion());
		return "upgrade-db";
	}

	@RequestMapping(value = "upgrade-version", method = RequestMethod.POST)
	public String upgradeVersion(@ModelAttribute("version") Version version, Model model) {
		int latestVersionId = versionService.upgradeVersion(version).getId();
		service.updateDataDbVersion(latestVersionId);
		model.addAttribute("currentversion", versionService.getCurrentVersion());
		return "redirect:show-versions";
	}

	@RequestMapping(value = "show-chapters", method = RequestMethod.GET)
	public String showChapters(Model model) {
		model.addAttribute("chaptertree", chapterService.getChapterTreeData());
		return "show-chapters";
	}

	@RequestMapping(value = "delete-chapter", method = RequestMethod.GET)
	public String deleteChapter(@RequestParam("chapterId") int chapterId) {
		chapterService.deleteChapter(chapterId);
		return "redirect:show-chapters";
	}

	@RequestMapping(value = "show-lessons", method = RequestMethod.GET)
	public String showLessons(@RequestParam("chapterId") int chapterId, Model model) {
		Chapter chapter = chapterService.getChapterById(chapterId);
		model.addAttribute("chapter", chapter);
		List<Lesson> lessons = lessonService.getLessonsByChapter(chapter);
		model.addAttribute("LESSONS", lessons);
		model.addAttribute("lessontree", lessonService.getLessonTreeData());
		return "show-lessons";
	}

	@RequestMapping(value = "add-new-chapter", method = RequestMethod.GET)
	public String addChapter(@RequestParam("divId") int subjectId, Model model) {
		Subject subject = subjectService.getSubjectById(subjectId);
		Chapter chapter = new Chapter();
		chapter.setSubjectId(subject);
		model.addAttribute("chapter", chapter);
		return "add-chapter";
	}

	@RequestMapping(value = "add-new-lesson", method = RequestMethod.GET)
	public String addLesson(@RequestParam("chapterId") int chapterId, Model model) {
		Chapter chapter = chapterService.getChapterById(chapterId);
		model.addAttribute("chapter", chapter);
		Lesson lesson = new Lesson();
		lesson.setChapterId(chapter);
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
		Lesson lesson = lessonService.getLessonById(lessonId);
		model.addAttribute("lesson", lesson);
		return "edit-lesson";
	}

	@RequestMapping(value = "save-edit-lesson", method = RequestMethod.POST)
	public String saveEditLesson(@ModelAttribute("lesson") Lesson newLesson) {
		Version noneVersion = versionService.getVersionById(0);
		Lesson oldLesson = lessonService.getLessonById(newLesson.getId());
		if (!oldLesson.getTitle().equals(newLesson.getTitle())
				|| !oldLesson.getContent().equals(newLesson.getContent())) {
			oldLesson.setTitle(newLesson.getTitle());
			oldLesson.setContent(newLesson.getContent());
			oldLesson.setVersionId(noneVersion);
			lessonService.saveLesson(oldLesson);
		}
		return "redirect:show-lessons?chapterId=" + oldLesson.getChapterId().getId();
	}

	@RequestMapping(value = "delete-lesson", method = RequestMethod.GET)
	public String deleteLesson(@RequestParam("lessonId") int lessonId, @RequestParam("chapterId") int chapterId) {
		lessonService.deleteLesson(lessonId);
		return "redirect:show-lessons?chapterId=" + chapterId;
	}

	@RequestMapping(value = "show-solutions", method = RequestMethod.GET)
	public String showSolutions(@RequestParam("lessonId") int lessonId, Model model) {
		model.addAttribute("LESSONID", lessonId);
			Lesson lesson = lessonService.getLessonById(lessonId);
			List<SolutionTable> data = 
					solutionService.getSolutionTableDataByLesson(lesson);
		model.addAttribute("solutiontree", solutionService.getSolutionTreeData());
		model.addAttribute("solutions", data);
		return "show-solutions";
	}

	@RequestMapping(value = "add-solution", method = RequestMethod.GET)
	public String addSolution(@RequestParam("lessonId") int lessonId, Model model) {
		Lesson lesson = lessonService.getLessonById(lessonId);
		Solution solution = new Solution();
		solution.setLessonId(lesson);
		model.addAttribute("solution", solution);
		return "add-solution";
	}

	@RequestMapping(value = "save-new-solution", method = RequestMethod.POST)
	public String saveNewSolution(@ModelAttribute("solution") Solution solution) {
		Version noneVersion = versionService.getVersionById(0);
		Lesson lesson = lessonService.getLessonById(solution.getLessonId().getId());
		solution.setLessonId(lesson);
		solution.setVersionId(noneVersion);
		solutionService.saveSolution(solution);
		return "redirect:show-solutions?lessonId=" + lesson.getId();
	}

	@RequestMapping(value = "edit-solution", method = RequestMethod.GET)
	public String editSolution(@RequestParam("solutionId") int solutionId, Model model) {
		Solution solution = solutionService.getSolutionById(solutionId);
		model.addAttribute("solution", solution);
		return "edit-solution";
	}

	@RequestMapping(value = "save-edit-solution", method = RequestMethod.POST)
	public String saveEditSolution(@ModelAttribute("solution") Solution newSolution) {
		Version noneVersion = versionService.getVersionById(0);
		Solution oldSolution = solutionService.getSolutionById(newSolution.getId());
		if (!oldSolution.getTitle().equals(newSolution.getTitle())
				|| !oldSolution.getContent().equals(newSolution.getTitle())) {
			oldSolution.setTitle(newSolution.getTitle());
			oldSolution.setContent(newSolution.getContent());
			oldSolution.setVersionId(noneVersion);
			solutionService.saveSolution(oldSolution);
		}
		return "redirect:solution-detail?solutionId=" + oldSolution.getId();
	}

	@RequestMapping(value = "solution-detail", method = RequestMethod.GET)
	public String getSolutionDetail(@RequestParam("solutionId") int solutionId, Model model) {
		Solution solution = solutionService.getSolutionById(solutionId);
		model.addAttribute("solution", solution);
		List<Exercise> exercises = exerciseService.getExercisesBySolution(solution);
		model.addAttribute("exercises", exercises);
		return "solution-detail";
	}

	@RequestMapping(value = "delete-solution", method = RequestMethod.GET)
	public String deleteSolution(@RequestParam("solutionId") int solutionId, @RequestParam("lessonId") int lessonId) {
		solutionService.deleteSolution(solutionId);
		return "redirect:show-solutions?lessonId=" + lessonId;
	}

	@RequestMapping(value = "add-exercise", method = RequestMethod.GET)
	public String addExercise(@RequestParam("solutionId") int solutionId, Model model) {
		Solution solution = solutionService.getSolutionById(solutionId);
		Exercise exercise = new Exercise();
		exercise.setSolutionId(solution);
		model.addAttribute("exercise", exercise);
		return "add-exercise";
	}

	@RequestMapping(value = "save-new-exercise", method = RequestMethod.POST)
	public String saveExercise(@ModelAttribute("exercise") Exercise exercise) {
		Solution solution = solutionService.getSolutionById(exercise.getSolutionId().getId());
		Version noneVersion = versionService.getVersionById(0);
		exercise.setSolutionId(solution);
		exercise.setVersionId(noneVersion);
		exerciseService.saveExercise(exercise);
		return "redirect:solution-detail?solutionId=" + exercise.getSolutionId().getId();
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
		if (!oldExercise.getTopic().equals(newExercise.getTopic())
				|| !oldExercise.getAnswer().equals(newExercise.getAnswer())) {
			oldExercise.setTopic(newExercise.getTopic());
			oldExercise.setAnswer(newExercise.getAnswer());
			oldExercise.setVersionId(noneVersion);
			exerciseService.saveExercise(oldExercise);
		}
		return "redirect:solution-detail?solutionId=" + oldExercise.getSolutionId().getId();
	}

	@RequestMapping(value = "delete-exercise", method = RequestMethod.GET)
	public String deleteExercise(@RequestParam("exId") int exerciseId, @RequestParam("solutionId") int solutionId) {
		exerciseService.deleteExercise(exerciseId);
		return "redirect:solution-detail?solutionId=" + solutionId;
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
	public String showVersions(Model model) {
		model.addAttribute("versions", versionService.getAllVersion());
		return "show-versions";
	}

	@RequestMapping(value = "android/math-editor", method = RequestMethod.GET)
	public String inputMath() {
		return "math-editor";
	}
}