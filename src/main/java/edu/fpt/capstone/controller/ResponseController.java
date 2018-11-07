package edu.fpt.capstone.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import edu.fpt.capstone.data.ResponseData;
import edu.fpt.capstone.entity.Version;
import edu.fpt.capstone.service.MathFormulasAdminService;
import edu.fpt.capstone.service.VersionService;

@RestController
@RequestMapping("android")
public class ResponseController {
	
	@Autowired
	VersionService versionService;
	
	@Autowired
	MathFormulasAdminService service;
	
	@RequestMapping(value = "check-database-version", method = RequestMethod.GET)
	@ResponseBody
	public List<Version> returnNewVersions(@RequestParam("currentVersionId") int userCurrentVersion) {
		return versionService.getNewVersions(userCurrentVersion);
	}
	
	@RequestMapping(value = "update-new-data", method = RequestMethod.GET)
	@ResponseBody
	public ResponseData returnNewData(@RequestParam("currentVersionId") int currentVersionId) {
		return service.getNewData(currentVersionId);
	}
}
