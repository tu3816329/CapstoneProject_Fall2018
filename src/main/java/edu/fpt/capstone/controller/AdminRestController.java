package edu.fpt.capstone.controller;

import java.io.IOException;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import edu.fpt.capstone.entity.Chapter;
import edu.fpt.capstone.entity.Subject;
import edu.fpt.capstone.entity.Grade;
import edu.fpt.capstone.entity.Version;
import edu.fpt.capstone.service.ChapterService;
import edu.fpt.capstone.service.SubjectService;
import edu.fpt.capstone.service.GradeService;
import edu.fpt.capstone.service.LessonService;
import edu.fpt.capstone.service.MathFormulasAdminService;
import edu.fpt.capstone.service.SolutionService;
import edu.fpt.capstone.service.VersionService;

@RestController
public class AdminRestController {
	
	private static final Logger log = Logger.getLogger(AdminRestController.class);
	
	@Autowired
	ChapterService chapterService;
	
	@Autowired
	SubjectService subjectService;
	
	@Autowired
	GradeService gradeService;
	
	@Autowired
	LessonService lessonService;
	
	@Autowired
	SolutionService solutionService;
	
	@Autowired
	VersionService versionService;
	
	@Autowired
	MathFormulasAdminService mathFormulasAdminService;
	
	@RequestMapping(value = "get-grades", method = RequestMethod.GET)
	@ResponseBody
	public List<Grade> getAllGrades() {
		return gradeService.getAllGrades();
	}
	
	@RequestMapping(value = "get-subjects", method = RequestMethod.GET)
	@ResponseBody
	public List<Subject> getAllSubject() {
		return subjectService.getAllSubjects();
	}
	
	@RequestMapping(value = "load-chapters-table", method = RequestMethod.GET)
	@ResponseBody
	public List<Chapter> getAllChapters() {
		return chapterService.getAllChapters();
	}
	
	@RequestMapping(value = "save-chapters-table", method = RequestMethod.POST)
	@ResponseBody
	public boolean saveChapters(@RequestBody List<Chapter> chapters) {
		boolean isSuccess = true;
		try {
			isSuccess = chapterService.saveChapters(chapters);
		} catch (Exception e) {
			e.printStackTrace();
			isSuccess = false;
		}
		return isSuccess;
	}
	
	@RequestMapping(value = "save-chapter-image", method = RequestMethod.POST)
	@ResponseBody
	public String saveChapterImage(@RequestParam("chapterId") int chapterId, 
									@RequestParam("imageFile") MultipartFile imgFile) {
		Chapter chapter = chapterService.getChapterById(chapterId);
		Version noneVersion = versionService.getVersionById(0);
		try {
			chapter.setChapterIcon(imgFile.getBytes());
			chapter.setVersionId(noneVersion);
			chapterService.saveChapter(chapter);
		} catch (IOException e) {
			log.error(e.getLocalizedMessage());
			return "error";
		}
		return "success";
	}
}
