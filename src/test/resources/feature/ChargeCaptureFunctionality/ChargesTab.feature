@ChargesTab
Feature: Charges tab
Scenarios for testing the various Charges tabs.

  Background:
		#Given I am logged into the portal with the default user
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Charges" tab

  @BuildVerificationTest
  Scenario: Loading of the Charges tab with correct subtabs
    Then the following subtabs should load
      | Summary               |
      | Holding Bin           |
      | Patient Charge Status |
      | Worklist              |
      | Search                |
      | Outbox                |
      | Batch Charge Entry    |

  @BuildVerificationTest
  Scenario: Loading of the Charge Summary subtab
    When I select the "Summary" subtab
    Then the "Charge Summary" pane should load

  @BuildVerificationTest
  Scenario: Loading of the Holding Bin subtab
    When I select the "Holding Bin" subtab
    Then the "Holding Bin" pane should load

  @BuildVerificationTest
  Scenario: Loading of the Patient Charge Status subtab
    When I select the "Patient Charge Status" subtab
    Then the "Patient Charge Status" pane should load

  @BuildVerificationTest
  Scenario: Loading of the Worklist subtab
    When I select the "Worklist" subtab
    Then the "Worklist" pane should load

  @BuildVerificationTest
  Scenario: Loading of the Charge Search subtab
    When I select the "Search" subtab
    Then the "Charge Search" pane should load

  @BuildVerificationTest
  Scenario: Loading of the Outbox subtab
    When I select the "Outbox" subtab
    Then the "Outbox" pane should load

  @donotrun @PortalSmoke @PCOnly
  Scenario: Outbox smoke
    Given I am logged into the portal with user "addchargeuser1" using the default password
    And I am on the "Patient List V2" tab
    And "Molly Darr" is on the patient list
    And patient "Molly Darr" has at least one charge in the outbox
    Given I am on the "Charges" tab
    When I select the "Outbox" subtab
    And I click the "Outbox Refresh" image
    And I select "All Departments" from the "Outbox Department" dropdown
    And I click the checkbox in the row with "Verve" as the value under "Billing Area" in the "Outbox" table
    And I click the "Commit" button
    Then rows starting with the following should appear in the "Batch History" table
      | Batch Name             | Creator          | Date Committed        |
			#|departmentVerve_batch_  |KADMIN, PERRY  |%Current Date MMDDYY%  |
      | departmentVerve_batch_ | USER1, ADDCHARGE | %Current Date MMDDYY% |
    When I click the "View" button in the "Quick Details" pane
    And I wait "2" seconds
    Then the following rows should appear in the "View Batch" table
      | Submission Date       | Service Date          | Procedure | Qty | Mod | Diagnoses |
      | %Current Date MMDDYY% | %Current Date MMDDYY% | 0212T     | 1   | N/A | 017.40    |
    When I click the "Print Current View" button in the "Quick Details" pane
    And I wait "2" seconds
    Then the "Print" window should open
    And the following rows should appear in the "Print Batch" table
      | Submission Date       | Service Date          | Procedure | Qty | Mod | Diagnoses |
      | %Current Date MMDDYY% | %Current Date MMDDYY% | 0212T     | 1   | N/A | 017.40    |
    When I run the AutoIt script "Print to XPS"
    Then the "Print" window should close

  @donotrun @PortalSmoke
  Scenario: Summary Smoke
    Given I am on the "Patient List V2" tab
    And "Molly Darr" is on the patient list
		#need at least one charge to exist for Verve department:
    And "Molly Darr" has a charge with a billing area of "Verve"
    Given I am on the "Charges" tab
    When I select the "Summary" subtab
		#Then the contents of the "Charges By Department" table should match the results of the "Charge Summary" query
		#sort by different column first to avoid ASC/DESC issues
    When I click the "Department" header in the "Charges By Department" table
    And I click the "Total" header in the "Charges By Department" table
    When I sort the "Charges By Department" table numerically by the "Total" column in "Ascending" order
    When I click the "Total" header in the "Charges By Department" table
    When I sort the "Charges By Department" table numerically by the "Total" column in "Descending" order
    When I click the "" header in the "Charges By Department" table
    When I sort the "Charges By Department" table numerically by the "" column in "Ascending" order
    When I click the "" header in the "Charges By Department" table
    When I sort the "Charges By Department" table numerically by the " " column in "Descending" order
#	 #click on the the number in the third column for the Verve row:
#   		And I select the " " link in the row with "Verve" as the value under "Total" in the "Charges By Department" table
    When I click the " " link in the cell with text "Verve" in the "Department" column of the "Charges By Department" table
#		And I click the link in the cell header in the table
#		When I select the "Summary" subtab
    Then the "Holding Bin" pane should load
    And "Verve" should be selected in the "Outbox Department" dropdown
    And the contents of the "Outbox" table should contain the results of the "Outbox" query filtered by "cur.department" of "Verve"
    When I select the "Summary" subtab
    And I click the value under "Total" in the row with "Verve" as the value under "Department" in the "Charges By Department" table
    Then the "Holding Bin" pane should load
    And "Verve" should be selected in the "Department" dropdown

#On hold.  Case is incomplete in QC. -- Note from Chris Brachmann 02/16/17
#	@donotrun
#	Using this scenario for DEV-77277. When rerunning, run this scenario in NUC6 .-- HIC 12/13/18
  @donotrun @HoldForReview
  Scenario: Holding Bin Mark as Reviewed[DEV-77277]
	 #	This scenario is present in Hold For review feature file
    Given I am logged into the portal with user "hfr1" using the default password
    When I am on the "Patient List V2" tab
    Then I select "HFR" from the "Patient List" menu
    And I am on the "Charges" tab
    When I select the "Holding Bin" subtab
    And I select "Last 90 Days" from the "Timeframe" dropdown in the "Holding Bin" pane
    And I select "Held for Review" from the "Error Type" dropdown in the "Holding Bin" pane
    Then I click the "Show Charges" button in the "Holding Bin" pane
    And I sort the "Holding Bin" table chronologically by the "Date" column in "Descending" order
    And I select "the first item" in the "Holding Bin" table
    And I select the "Held for Review" link in the row with "Held for Review" as the value under "Edits" in the "Holding Bin" table
    Then the "Charge Details" pane should load
#		If the held charge has already been marked as reviewed, the Mark As Reviewed btn does not display.  However, if
#		the charge has yet to be reviewed, clicking the Mark As Reviewed btn closes the pane and the Cancel btn will
#		not be displayed.  -- HIC 12/13/18
    And I click the "Mark As Reviewed Charge Details" button if it exists
    And I click the "Cancel Charge Details" button if it exists
    And I select "the first item" in the "Holding Bin" table
    And I select the "Held for Review" link in the row with "Held for Review" as the value under "Edits" in the "Holding Bin" table
    Then the following fields should not display in the "Charge Details" pane
      | Name                            | Type   |
      | Mark As Reviewed Charge Details | button |
    And I click the "Cancel Charge Details" button
    And I select "the first item" in the "Holding Bin" table
    Then I click the "View Patient Details" icon
    And the "Patient Detail" pane should load
    Then I click the "Charges Left Nav" element
    And I uncheck the "Show Visits" checkbox
#	in the "Patient Detail Charges" pane
    Then the "Charge Detail" pane should load
    And the following text should appear in the "Charge Detail" pane
      | Reviewer Name         |
      | FORREVIEW, HOLD       |
      | Review Date           |
      | %Current Date MMDDYY% |


  @donotrun @PortalSmoke
  Scenario: Patient Charge Status
    Given "Molly Darr" is on the patient list
    And "Roy Blazer" is on the patient list
    And "Mona Angeline" is on the patient list
    When I select the "Patient Charge Status" subtab
    Then the "Patient Charge Status" pane should load
   #		When I uncheck the following "Include All Visits" in the "Patient Charge Status" pane
    And I uncheck the "Include All Visits" checkbox
   #		When I uncheck the following "Only Patients Missing Charges Since MMDDYY" in the "Patient Charge Status" pane
    And I uncheck the "Only Patients Missing Charges" checkbox
    And the following rows should appear in the "Patient Charge Status" table
      | Name (\d)     | %Blank%              | %Blank% | %Blank% | Location                            | %Blank% | %Current Date - 6% | %Current Date - 5% | %Current Date - 4% | %Current Date - 3% | %Current Date - 2% | %Current Date - 1% | %Current Date% |
      | AGELINE, MONA | %View Details Image% | 87Y     | F       | ICU1.PKHospital-Central (Inpatient) | LOS:4d  | %Blank%            | %Blank%            | %Add Link%         | %Add Link%         | %Add Link%         | %Add Link%         | %Add Link%     |
      | DARR, MOLLY   | %View Details Image% | 73Y     | F       | 501.PKHospital-Central (Inpatient)  | LOS:4d  | %Blank%            | %Blank%            | %Add Link%         | %Add Link%         | %Add Link%         | %Add Link%         | %Add Link%     |
		#Does this need to be updated to 'I click the "Refresh" icon...'
    When I click the "Refresh" button in the "Patient Charge Status" pane
    Then the "Patient Charge Status" table should refresh
    When I select "DARR, MOLLY" from the "Name (\d)" column in the "Patient Charge Status" table
    Then the "Patient Charge" popup should open
    And the text "DARR, MOLLY" should appear in the "Patient Charge Status Popup" pane
    And the text "DOB: 12/22/1938  73Y  F" should appear in the "Patient Charge Status Popup" pane
    And the following rows should appear in the "Dynamic Charge Details" table
      | Inpatient | Admit10/14/12 10:30:00 | #017412528 | 501.PKHospital-Central |
    When I select "%Current Date%" from the "Visit Day" column in the "Dynamic Charge Details" table
    Then the "Charge Entry" pane should load
    And I click the "Cancel" button in the "Charge Entry" pane
    Then the "Charge Entry" pane should close
    When I click the cell under "4th" in the row with "DARR, MOLLY" as the value under "Location" in the "Patient Charge Status" table
    When I select "Add" from the "4th" column in the "Dynamic Charge Details" table
    Then the "Charge Entry" pane should load
    And I click the "Cancel" button in the "Charge Entry" pane
    Then the "Charge Entry" pane should close
    When I click the "Close" button in the "Patient Charge Status Popup" pane
    Then the "Patient Charge Status Popup" pane should close
    When I select "Add" from the "%Current Date - 1%" column in the "Patient Charge Status" table
    Then the "Charge Entry" pane should load
    And I click the "Cancel" button in the "Charge Entry" pane
    Then the "Charge Entry" pane should close
    When I click the cell under "Other" in the row with "DARR, MOLLY" as the value under "%Current Date%" in the "Dynamic Charge Details" table
    Then the "Patient Charge" popup should open
    When I click the "Close" button in the "Patient Charge Status Popup" pane
    Then the "Patient Charge Status Popup" pane should close


  @PortalSmoke @Demo
  Scenario: Save And Next[DEV-43187 and FixVersion-8.0.4]
    Given I am logged into the portal with user "addchargeuser1" using the default password
    Then I am on the "Charges" tab
    And I select the "Worklist" subtab
    And I click the "Reset Criteria" button in the "Worklist" pane
    And I select "Today" from the "Timeframe" dropdown in the "Worklist" pane
    And I select "Scheduled" from the "ProviderType" dropdown in the "Worklist" pane
    And I select "- All -" from the "Dept" dropdown in the "Worklist" pane
    And I select "- All -" from the "Bill Area" dropdown in the "Worklist" pane
    And I select "Not Coded Outpatient" from the "Filter" dropdown in the "Worklist" pane
    And I check the "Include Todays Appt" checkbox in the "Worklist" pane
    And I check the "Include Charges with No Edits" checkbox in the "Worklist" pane
    And I click the "Refresh Worklist" button in the "Worklist" pane
#    This method below is hard coded to these values, so added them to the Cucumber step for clarity
    And I click the Add link in the first row in the Worklist table
    And I wait "2" seconds
    And I set the following charge headers
      | Name         | Value           |
      | Billing Prov | KADMINV2, PERRY |
      | Svc Site     | Inpatient       |
      | Bill Area    | Verve           |
    And I enter the ICD-10 code "L89.509"
    And I enter the CPT code "01462"
    When I click the "Save And Next" button, then the title in the current popup should not match the previous value
    And I click the "Close" image


# #IE keeps failing to select Card Group from Pkmenu for Patient List on Charges Tab.  IE just can’t seem to click options in Pkmenus anymore.
  @PortalSmoke
  Scenario: Batch Charge Entry[DEV-43188 and FixVersion-8.0.4]
    Given I am logged into the portal with user "addchargeuser1" using the default password
    Then I am on the "Patient List V2" tab
    And I select "Card Group" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    And "Roy Blazer" is on the patient list
    And "Mona Angeline" is on the patient list
    When I am on the "Charges" tab
    Then I select the "Batch Charge Entry" subtab
		#And I enter "%Current Date MMDDYY%" in the "Date" field in the "Batch Charge Entry" pane
    And I wait "2" seconds
    And I select "Inpatient" from the "Svc Site" tabledropdown in the "Batch Charge Entry" pane
    And I select "Verve" from the "Bill Area" tabledropdown in the "Batch Charge Entry" pane
    And I select "Card Group" from the "Patient List" menu
    When I click the "Add Edit Charges" button in the "Batch Charge Entry" pane
    And I wait "2" seconds
		#And I enter "%Current Date MMDDYYYY%" in the "Date" field in the "Charge Entry" pane
		#And I set the following charge headers
		#	|Name         |Value                 |
		#	|Bill Area    |Verve                 |
		#	|Billing Prov |KADMIN, PERRY         |
		#	|Svc Site     |Inpatient             |
    Then I enter the ICD-10 code "A06.4"
    And I wait "1" second
    And I enter the CPT code "00702"
    And I wait "2" seconds
    And I click the "Submit" button in the "Charge Entry" pane
    When I sort the "Visits" table alphabetically by the "Name" column in "Ascending" order
    And I select patient "Molly Darr" from the "Name (\d)" column in the "Visits" table
    And I select patient "Roy Blazer" from the "Name (\d)" column in the "Visits" table
    And I click the "Save Charges" button
    And I wait "1" second
    And I click the "Cancel" button
#  in the "Question" pane
    Then the "Checkbox" image should be shown in the following rows in the "Visits" table
      | Displayed | Name (\d)      |
      | false     | DARR, MOLLY    |
      | false     | BLAZER, ROY    |
      | false     | ANGELINE, MONA |
    And I click the "Save Charges" button
    And I click the "OK" button in the "Question" pane
    And I wait "2" seconds
		#Left most column should have a check mark for those patients that have a charge:
    Then the "Checkbox" image should be shown in the following rows in the "Visits" table
      | Displayed | Name (\d)      |
      | true      | DARR, MOLLY    |
      | true      | BLAZER, ROY    |
      | false     | ANGELINE, MONA |