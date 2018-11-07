package edu.fpt.capstone.serviceimpl;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.fpt.capstone.entity.Version;
import edu.fpt.capstone.repository.VersionRepository;
import edu.fpt.capstone.service.VersionService;

@Service
public class VersionServiceImpl implements VersionService {

	@Autowired
	VersionRepository versionRepository;
	
	@Override
	public List<Version> getAllVersion() {
		Iterator<Version> vIterator = versionRepository.findAll().iterator();
		List<Version> versions = new ArrayList<Version>();
		for (Version v; vIterator.hasNext();) {
			v = vIterator.next();
			versions.add(v);
		}
		return versions;
	}

	@Override
	public Version upgradeVersion(Version version) {
		versionRepository.deactiveOldVersions(false);
		version.setIsCurrent(true);
		version.setId(versionRepository.getBiggestVersionId() + 1);
		return versionRepository.save(version);
	}
	
	@Override
	public List<Version> getNewVersions(int userVersion) {
		return versionRepository.getNewVersions(userVersion);
	}
	
	@Override
	public int countVersion() {
		return (int) versionRepository.count();
	}

	@Override
	public Version getVersionById(int versionId) {
		return versionRepository.findOne(versionId);
	}

	@Override
	public Version getCurrentVersion() {
		return versionRepository.getCurrentVersion();
	}
}
