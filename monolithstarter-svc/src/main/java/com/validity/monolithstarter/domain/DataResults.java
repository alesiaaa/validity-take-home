package com.validity.monolithstarter.domain;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.validity.monolithstarter.service.DataProcessingService.UserContactDuplicateReason;

public class DataResults {
	
	private List <DataDuplicate> duplicates;
	private List <UserContact> unique;
	
	public DataResults(){
		duplicates = new ArrayList<>();
		unique = new ArrayList<>();
	}
	
	public List<DataDuplicate> getDuplicates() {
		return duplicates;
	}

	public List<UserContact> getUnique() {
		return unique;
	}
	
	// Add duplicates 
	public void addDuplicate(UserContact userContact1, UserContact userContact2, UserContactDuplicateReason reason) {
		boolean exists = false;
		
		// Traverse through recorded duplicates to check for existing duplicate combinations
		for (DataDuplicate record: duplicates) {
			
			// Check if either userContact1 or userContact2 have been recorded
			if (record.getOriginal().equals(userContact1) ||
				record.getDuplicates().contains(userContact1) ||
				record.getOriginal().equals(userContact2) ||
				record.getDuplicates().contains(userContact2)) {
				
				// Mark contact as existing
				exists = true;
				
				// Determine which of the existing contact has yet to be recorded
				UserContact uc = null;
				if (!record.getOriginal().equals(userContact1) && !record.getDuplicates().contains(userContact1)) {
					uc = userContact1;
				} else {
					uc = userContact2;
				}
				
				// Add duplicate 
				record.addDuplicate(uc, reason);
			}
			
			// If record exists, get out of loop
			if (exists) {
				break;
			}
		}
		
		// New record, add normally
		if (!exists) {
			duplicates.add(new DataDuplicate(userContact1, userContact2, reason));
		}
	}
	
	// Method to get set of all decoded UserContact objects in Duplicates
	private Set<UserContact> getDuplicatesSet(){
		// Temp object to hold all suspected duplicate values
		Set <UserContact> set = new HashSet<>();
		
		// Add all recorded duplicates to a set
		for (DataDuplicate d: duplicates) {
			set.add(d.getOriginal());
			set.addAll(d.getDuplicates());
		}
		
		return set;
	}
	
	// Method to set the list of unique UserContact objects
	public void setUnique(List<UserContact> data) {
		
		// Set all UserContact values
		unique = new ArrayList<>(data);
		
		// Remove all records deemed duplicated, leaving only unique records
		unique.removeAll(getDuplicatesSet());
		
		// Sort by ID
		unique.sort((UserContact uc1, UserContact uc2)->uc1.getId().compareTo(uc2.getId()));
		
	}

}
