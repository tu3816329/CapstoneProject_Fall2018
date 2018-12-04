package edu.fpt.capstone.service;

import java.util.List;

import edu.fpt.capstone.entity.Chapter;

public interface ChapterService {

	public List<Chapter> getAllChapters();
	
	public List<Chapter> getChapterTreeData();
		
	public List<Chapter> getChaptersByDivisionAndGrade(int divisionId, int gradeId);
	
	public Chapter getChapterById(int id);
	
	public boolean isEqualChapter(Chapter oldChapter, Chapter newChapter);
	
	public void deleteChapter(int chapterId);
	
	public void saveChapter(Chapter chapter);
	
	public boolean saveChapters(List<Chapter> chapters);
	
	public boolean isDuplicateChapter(Chapter chapter);
	
	public List<Chapter> getNewChapters(int userVersion);
	
	public List<Chapter> getNoneVersionChapters();
}
