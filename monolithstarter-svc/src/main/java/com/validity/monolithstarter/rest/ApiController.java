package com.validity.monolithstarter.rest;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.validity.monolithstarter.domain.DataResults;
import com.validity.monolithstarter.service.DataProcessingService;

import javax.inject.Inject;

@RestController
@RequestMapping("/api")
public class ApiController {

    @Inject
    private DataProcessingService dataProcessingService;
    
    @GetMapping("/duplicates")
    private DataResults getImport() {
    	return dataProcessingService.processCsv();
    }
}
