package edu.fpt.capstone.service;

import java.util.List;

import edu.fpt.capstone.entity.Chapter;
import edu.fpt.capstone.entity.Lesson;

public interface LessonService {

public List<Lesson> getAllLessons();
	
	public void saveLesson(Lesson lesson);
	
	public void deleteLesson(int lessonId);
	
	public List<Lesson> getLessonsByChapter(Chapter chapter);
	
	public Lesson getLessonById(int id);
}
