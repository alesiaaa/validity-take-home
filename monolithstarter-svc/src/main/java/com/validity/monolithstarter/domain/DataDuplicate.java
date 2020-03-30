package com.validity.monolithstarter.domain;

import java.util.HashSet;
import java.util.Set;

import com.validity.monolithstarter.service.DataProcessingService.UserContactDuplicateReason;

public class DataDuplicate {
	
	private UserContact original;
	private Set<UserContact> duplicates = new HashSet<>();
	private Set<UserContactDuplicateReason> reasons = new HashSet<>();
	
	DataDuplicate(UserContact original, UserContact duplicate, UserContactDuplicateReason reason){
		this.original = original;
		addDuplicate(duplicate, reason);
	}

	public UserContact getOriginal() {
		return original;
	}
	
	public Set<UserContact> getDuplicates() {
		return duplicates;
	}
	
	public void addDuplicate(UserContact duplicate, UserContactDuplicateReason reason) {
		// Add duplicate, set prevents possible redundancy without explicitly checking
		this.duplicates.add(duplicate);
		
		// Add reason for why the duplicate exists
		this.reasons.add(reason);
	}
	
	public Set<UserContactDuplicateReason> getReasons() {
		return reasons;
	}
	
	
}
