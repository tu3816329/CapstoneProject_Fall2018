package edu.fpt.capstone.serviceimpl;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.fpt.capstone.data.MathformTable;
import edu.fpt.capstone.entity.Exercise;
import edu.fpt.capstone.entity.Lesson;
import edu.fpt.capstone.entity.Mathform;
import edu.fpt.capstone.entity.Version;
import edu.fpt.capstone.repository.MathFormRepository;
import edu.fpt.capstone.service.ExerciseService;
import edu.fpt.capstone.service.MathFormulasAdminService;
import edu.fpt.capstone.service.MathformService;
import edu.fpt.capstone.service.VersionService;
import edu.fpt.capstone.utils.WebAdminUtils;

@Service
public class MathformServiceImpl implements MathformService {

	@Autowired
	MathFormulasAdminService service;

	@Autowired
	MathFormRepository mathFormRepository;

	@Autowired
	ExerciseService exerciseService;
	
	@Autowired
	VersionService versionService;

	public List<Mathform> getAllMathforms() {
		Iterator<Mathform> iterator = mathFormRepository.findAll().iterator();
		List<Mathform> mathforms = new ArrayList<Mathform>();
		for (Mathform mathform; iterator.hasNext();) {
			mathform = iterator.next();
			mathforms.add(mathform);
		}
		return mathforms;
	}

	@Override
	public List<Mathform> getMathformTreeData() {
		List<Mathform> mathforms = getAllMathforms();
		int index = 0;
		for (Mathform mathform : mathforms) {
			mathform = new Mathform(mathform.getId(), mathform.getMathformTitle(), mathform.getLessonId());
			mathforms.set(index++, mathform);
		}
		return mathforms;
	}

	@Override
	public Mathform getMathformById(int mathformId) {
		return mathFormRepository.findOne(mathformId);
	}

	@Override
	public void saveMathform(Mathform mathform) {
		mathFormRepository.save(mathform);
	}

	@Override
	public void deleteMathform(int mathformId) {
		Mathform mathform = getMathformById(mathformId);
		List<Exercise> exercises = exerciseService.getExercisesByMathform(mathform);
		for (Exercise e : exercises) {
			exerciseService.deleteExercise(e.getId());
		}
		mathFormRepository.delete(mathform);
		service.generateDeleteQuery(mathformId, WebAdminUtils.MATHFORM_TABLE);
	}

	@Override
	public List<MathformTable> getMathformTableDataByLesson(Lesson lesson) {
		List<Mathform> mathforms = mathFormRepository.findByLessonId(lesson);
		List<MathformTable> mathFormTables = new ArrayList<MathformTable>();
		for (Mathform mathform : mathforms) {
			int numOfExs = exerciseService.getExercisesByMathform(mathform).size();
			MathformTable data = new MathformTable(mathform.getId(), mathform.getMathformTitle(), numOfExs,
					mathform.getVersionId());
			mathFormTables.add(data);
		}
		return mathFormTables;
	}

	@Override
	public List<Mathform> getMathformByLesson(Lesson lesson) {
		return mathFormRepository.findByLessonId(lesson);
	}
	
	@Override
	public List<Mathform> getNoneVersionMathforms() {
		Version noneVersion = versionService.getVersionById(0);
		List<Mathform> mathforms = mathFormRepository.findByVersionId(noneVersion);
		
		int index = 0;
		for(Mathform mathform : mathforms) {
			mathform.setMathformContent(null);
			mathforms.set(index++, mathform);
		}
		return mathforms;
	}
}
