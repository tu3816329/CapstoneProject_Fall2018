package edu.fpt.capstone.serviceimpl;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.fpt.capstone.entity.Chapter;
import edu.fpt.capstone.entity.Division;
import edu.fpt.capstone.entity.Grade;
import edu.fpt.capstone.entity.Lesson;
import edu.fpt.capstone.entity.Version;
import edu.fpt.capstone.repository.ChapterRepository;
import edu.fpt.capstone.repository.DivisionRepository;
import edu.fpt.capstone.repository.GradeRepository;
import edu.fpt.capstone.service.ChapterService;
import edu.fpt.capstone.service.LessonService;
import edu.fpt.capstone.service.MathFormulasAdminService;
import edu.fpt.capstone.service.VersionService;
import edu.fpt.capstone.utils.WebAdminUtils;

@Service
public class ChapterServiceImpl implements ChapterService {
	
	@Autowired
	MathFormulasAdminService service;
	
	@Autowired
	ChapterRepository chapterRepository;
	
	@Autowired
	VersionService versionService;
	
	@Autowired
	LessonService lessonService;
	
	@Autowired
	DivisionRepository divisionRepository;
	
	@Autowired
	GradeRepository gradeRepository;

	@Override
	public List<Chapter> getAllChapters() {
		Iterator<Chapter> cIterator = chapterRepository.findAll().iterator();
		List<Chapter> chapters = new ArrayList<Chapter>();
		for (Chapter chapter; cIterator.hasNext();) {
			chapter = cIterator.next();
			chapters.add(chapter);
		}
		return chapters;
	}
	
	@Override
	public List<Chapter> getChaptersByDivisionAndGrade(int divisionId, int gradeId) {
		Division division = divisionRepository.findOne(divisionId);
		Grade grade = gradeRepository.findOne(gradeId);
		return chapterRepository.findByDivisionIdAndGradeId(division, grade);
	}

	@Override
	public Chapter getChapterById(int id) {
		return chapterRepository.findOne(id);
	}

	@Override
	public boolean isEqualChapter(Chapter oldChapter, Chapter newChapter) {
		return (oldChapter.getChapterName().equals(newChapter.getChapterName().trim()))
				&& (oldChapter.getDivisionId().getId() == newChapter.getDivisionId().getId())
				&& (oldChapter.getGradeId().getId() == newChapter.getGradeId().getId());
	}

	@Override
	public void saveChapters(List<Chapter> chapters) {
		for (Chapter newChapter : chapters) {
			Version noneVersion = versionService.getVersionById(0);
			if (newChapter.getId() != 0) {
				Chapter oldChapter = getChapterById(newChapter.getId());
				if (!isEqualChapter(oldChapter, newChapter)) {
					newChapter.setChapterIcon(oldChapter.getChapterIcon());
					newChapter.setVersionId(noneVersion);
					chapterRepository.save(newChapter);
				}
			} else {
				newChapter.setVersionId(noneVersion);
				chapterRepository.save(newChapter);
			}
		}
	}

	@Override
	public void deleteChapter(int chapterId) {
		Chapter chapter = getChapterById(chapterId);
		List<Lesson> lessons = lessonService.getLessonsByChapter(chapter);
		for (Lesson l : lessons) {
			lessonService.deleteLesson(l.getId());
		}
		chapterRepository.delete(chapterId);
		service.generateDeleteQuery(chapterId, WebAdminUtils.CHAPTER_TABLE);
	}

	@Override
	public void saveChapter(Chapter chapter) {
		chapterRepository.save(chapter);
	}
	
	@Override
	public List<Chapter> getNewChapters(int userVersion) {
		return chapterRepository.getNewChapters(userVersion);
	}
}
