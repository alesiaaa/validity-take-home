package com.validity.monolithstarter.service;

import java.io.File;
import java.io.FileReader;
import java.util.List;

import org.apache.commons.codec.language.Metaphone;
import org.apache.xmlbeans.impl.common.Levenshtein;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ResourceLoader;
import org.springframework.stereotype.Service;

import com.opencsv.bean.CsvToBeanBuilder;
import com.validity.monolithstarter.domain.DataResults;
import com.validity.monolithstarter.domain.UserContact;

@Service
public class DataProcessingService {

	@Autowired
	ResourceLoader resourceLoader;

	private List<UserContact> data;
	private DataResults results;

	private static Metaphone m;
	private final Logger log;

	public DataProcessingService() {
		results = new DataResults();
		m = new Metaphone();
		log = LoggerFactory.getLogger(getClass());
	}

	// Get CSV
	// Return unique and duplicate entries
	public DataResults processCsv() {
		try {
			// Grab the file from the resource folder
			// To test files other than advance.csv (like normal.csv), make sure the file is
			// available in the
			// resources/test-files directory
			File file = resourceLoader.getResource("classpath:test-files/advanced.csv").getFile();

			// Map csv to list object
			data = new CsvToBeanBuilder<UserContact>(new FileReader(file)).withType(UserContact.class).build().parse();

			// Check if more than just the header exists
			if (data != null && data.size() > 1) {

				// Remove the header
				data.remove(0);

				// Start looking for duplicates
				processData();
			}
		} catch (Exception e) {
			log.error("Unable to import file", e);
		}
		
		// Return the results
		return getResults();
	}

	// Method to process supplied data
	public void processData() {
		// Check if data is empty
		if (!data.isEmpty()) {

			// Check for duplicates
			processUserContacts();
		}
	}

	// Method to process all User Contact objects in
	private void processUserContacts() {
		// Traverse through data list to check for duplicates based on specified methods
		// For more information on each method, please see comments below
		for (int index = 0; index < this.data.size(); index++) {
			for (int i = index + 1; i < this.data.size(); i++) {
				checkRowAsString(index, i);
				checkFullName(index, i);
				checkCompanyAndLastName(index, i);
				checkEmail(index, i);
				checkPhone(index, i);
				checkAddress(index, i);
			}
		}

		// Set unique User Contact objects after duplicates have been identified
		results.setUnique(data);
	}

	// Method to check for duplicates for entire rows
	private void checkRowAsString(int userContact1, int userContact2) {
		if (levenshteinCheck(data.get(userContact1).getRowAsString(), data.get(userContact2).getRowAsString())) {
			results.addDuplicate(data.get(userContact1), data.get(userContact2),
					UserContactDuplicateReason.ROW_AS_STRING);
		}
	}

	// Method to check for duplicates via approximate matching of last name and
	// company
	private void checkCompanyAndLastName(int userContact1, int userContact2) {
		if (!data.get(userContact1).getLastName().isEmpty() && !data.get(userContact1).getCompany().isEmpty()) {
			if (metaphoneCheck(data.get(userContact1).getLastName(), data.get(userContact2).getLastName())
					&& levenshteinCheck(data.get(userContact1).getCompany(), data.get(userContact2).getCompany())) {
				results.addDuplicate(data.get(userContact1), data.get(userContact2),
						UserContactDuplicateReason.COMPANY_AND_LAST_NAME);
			}
		}
	}

	// Method to check for email duplicates
	private void checkEmail(int userContact1, int userContact2) {
		if (!data.get(userContact1).getEmail().isEmpty()) {
			// Split string by @
			String uc1Email = data.get(userContact1).getEmail().split("@")[0];
			String uc2Email = data.get(userContact2).getEmail().split("@")[0];

			// Check if the strings prepending @ matches
			if (!uc1Email.isEmpty() && !uc2Email.isEmpty() && levenshteinCheck(uc1Email, uc2Email)) {
				results.addDuplicate(data.get(userContact1), data.get(userContact2), UserContactDuplicateReason.EMAIL);
			}
		}
	}

	// Method to check for phone duplicates
	private void checkPhone(int userContact1, int userContact2) {
		if (!data.get(userContact1).getEmail().isEmpty()) {
			if (levenshteinCheck(data.get(userContact1).getPhone(), data.get(userContact2).getPhone())) {
				results.addDuplicate(data.get(userContact1), data.get(userContact2), UserContactDuplicateReason.PHONE);
			}
		}
	}

	// Method to check for address duplicates
	private void checkAddress(int userContact1, int userContact2) {

		// If short state is not listed, use zip
		if (data.get(userContact1).getState().isEmpty()) {

			// Check address 1 and zip
			if (!data.get(userContact1).getAddress1().isEmpty() && !data.get(userContact1).getZip().isEmpty()) {
				if (levenshteinCheck(data.get(userContact1).getAddress1(), data.get(userContact2).getAddress1())
						&& levenshteinCheck(data.get(userContact1).getZip(), data.get(userContact2).getZip())) {
					results.addDuplicate(data.get(userContact1), data.get(userContact2),
							UserContactDuplicateReason.ADDRESS);
				}
			}

		} else {
			// Check address 1 and state
			if (!data.get(userContact1).getAddress1().isEmpty() && !data.get(userContact1).getState().isEmpty()) {
				if (levenshteinCheck(data.get(userContact1).getAddress1(), data.get(userContact2).getAddress1())
						&& levenshteinCheck(data.get(userContact1).getState(), data.get(userContact2).getState())) {
					results.addDuplicate(data.get(userContact1), data.get(userContact2),
							UserContactDuplicateReason.ADDRESS);
				}
			}
		}
	}

	// Method to check similarity between names
	private void checkFullName(int userContact1, int userContact2) {
		// Check last name if last name is present
		if (!data.get(userContact1).getLastName().isEmpty()) {
			if (metaphoneCheck(data.get(userContact1).getFirstName(), data.get(userContact2).getFirstName())
					&& metaphoneCheck(data.get(userContact1).getLastName(), data.get(userContact2).getLastName())) {
				results.addDuplicate(data.get(userContact1), data.get(userContact2),
						UserContactDuplicateReason.FULL_NAME);
			}
		}
	}

	// Method to check how many edits would make stings match
	// Better than exact equality because this allows for minor typos
	private boolean levenshteinCheck(String str1, String str2) {
		// Allow for up to 20% error between target distance and actual
		// TODO: Need more testing to determine the ideal metric
		// or allow for user adjustment based on data set
		int targetDistance = (int) Math.round(str1.length() * 0.2);
		// Return if calculated distance is less than or equal targetDistance
		return Levenshtein.distance(str1, str2) <= targetDistance;
	}

	// Method to check if strings have similar sounds
	// Metaphone is better than Soundex as it was built for English
	// spelling/pronunciation
	// Likley not ideal for non-English data sets
	private boolean metaphoneCheck(String str1, String str2) {
		return m.isMetaphoneEqual(str1, str2);
	}

	// Method to retrieve results
	public DataResults getResults() {
		return results;
	}

	// Enum to allow for feedback on why entries are added to the duplicate list
	public enum UserContactDuplicateReason {
		ROW_AS_STRING("Row as string"), FULL_NAME("Full name"), COMPANY_AND_LAST_NAME("Company name and last name"),
		EMAIL("Email"), PHONE("Phone number"), ADDRESS("Address");

		private String reason;

		UserContactDuplicateReason(String reason) {
			this.reason = reason;
		}

		@Override
		public String toString() {
			return reason;
		}
	}
}
