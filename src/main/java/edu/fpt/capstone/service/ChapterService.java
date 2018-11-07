package edu.fpt.capstone.service;

import java.util.List;

import edu.fpt.capstone.entity.Chapter;
import edu.fpt.capstone.entity.Division;

public interface ChapterService {

	public List<Chapter> getAllChapters();
	
	public List<Chapter> getChaptersByDivision(Division division);
	
	public Chapter getChapterById(int id);
	
	public boolean isEqualChapter(Chapter oldChapter, Chapter newChapter);
	
	public void deleteChapter(int chapterId);
	
	public void saveChapter(Chapter chapter);
	
	public void saveChapters(List<Chapter> chapters);
	
	public List<Chapter> getNewChapters(int userVersion);
}
