@CodeEdits
Feature: Code edits

  Background:
   #Given I am logged into the portal with the default user
    Given I am logged into the portal with user "addchargeuser1" using the default password
    And I am on the "Patient List V2" tab
    And I use the API to create a patient list named "CCList" owned by "addchargeuser1" with the following parameters
      | Type   | Name              | Value      |
      | Filter | Medical Service   | Card Group |
    And I click the "Refresh Patient List" button
    And I select "CCList" from the "Patient List" menu

#turn on all codeedit-check boxes under user sever before code edits execution
  #  Moved to CukesRunnerTest
#  Scenario: Turn on all codeedits on user server
#    And I execute the "Enable All Code Edits" query

   @type0
  Scenario Outline: Gender - Type 0
    Given I am on the "Patient List V2" tab
#    And I select "CCList" from the "Patient List" menu
    And "<Patient>" is on the patient list
    When I select patient "<Patient>" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value            |
      |Bill Area    |CodeEditTest     |
      |Svc Site     |Inpatient        |
    And I enter the CPT codes "<CPT>"
    #Enter CPT codes function not completely implemented. Need to add code for mod and qty check.
    And I click the "Validate" button in the "Charge Entry" pane
    Then the text "<Message>" should appear in the "Charge Entry" pane
    And I click the "Close" image
  Examples:
    |Patient         |CPT     |Message                                                                   |
    |Neil Heath      |00842   |The CPT 00842 is inconsistent with the patient's listed gender of Male.   |
    |Neil Heath      |00908   |No Errors Found                                                           |
    |Helen Bamberger |00842   |No Errors Found                                                           |
    |Helen Bamberger |00908   |The CPT 00908 is inconsistent with the patient's listed gender of Female. |


  @type1
  Scenario Outline: Age - Type 1
    Given "<Patient>" is on the patient list
    When I select patient "<Patient>" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value            |
      |Bill Area    |CodeEditTest     |
      |Svc Site     |Outpatient       |
    And I enter the CPT codes "<CPT>"
    And I click the "Validate" button in the "Charge Entry" pane
    Then the text "<Message>" should appear in the "Charge Entry" pane
    And I click the "Close" image

  Examples:
    |Patient         |CPT   |Message                                                                                              |
    |Test Codeedit-1 |99381 |No Errors Found                                                                                      |
    |Test Codeedit-1 |99382 |This service is inappropriate for patients age 12 months and under. Appropriate codes include: 99381 |
    |Test Codeedit-2 |99382 |No Errors Found                                                                                      |
    |Test Codeedit-2 |99381 |This service is inappropriate based on this patient's age. Appropriate codes include: 99382          |
    |Test Codeedit-3 |99387 |No Errors Found                                                                                      |
    |Test Codeedit-3 |99382 |This service is inappropriate for patients age 65 years and older. Appropriate codes include: 99387  |


  @type2
  Scenario Outline: CPT - Type 2
    Given "Helen Bamberger" is on the patient list
    When I select patient "Helen Bamberger" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value            |
      |Bill Area    |CodeEditTest     |
      |Svc Site     |Inpatient        |
    And I enter the CPT codes "<CPT>"
    And I click the "Validate" button in the "Charge Entry" pane
    Then the text "<Message>" should appear in the "Charge Entry" pane
    And I click the "Close" image
    And I click the logout button
    
    Examples:
    |CPT   |Message                                |
    |36600 |This CPT is a non-covered service.     |


  @type3
  Scenario Outline: CPT-CPT-Time - Type 3
    Given "Test Codeedit-17", admitted in the last "101" days, is on the patient list
    And patient "Test Codeedit-17" has no charges
#    The patient is already selected in above step
#    When I select patient "Test Codeedit-17" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value            |
      |Bill Area    |CodeEditTest     |
      |Svc Site     |Outpatient       |

    And I enter "<Date1>" in the "Date" field in the "Charge Entry" pane

    And I enter the CPT codes "<CPT1>" in the "Charge Entry" pane

    And I enter the ICD-10 codes "M34.0" in the "Charge Entry" pane
    And I click the "Submit" button in the "Charge Entry" pane
    #Then the "Charge Entry" pane should close
    When I refresh the clinical display
    And I wait "2" seconds
    When I select patient "Test Codeedit-17" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value            |
      |Bill Area    |CodeEditTest     |
      |Svc Site     |Outpatient       |
    And I enter "<Date2>" in the "Date" field in the "Charge Entry" pane
    And I enter the CPT codes "<CPT2>"
    And I click the "Validate" button in the "Charge Entry" pane
    Then the text "<Message>" should appear in the "Charge Entry" pane
    And I click the "Close" image
    And I click the logout button

  Examples:
    |CPT1     |CPT2     |Date1                   |Date2                   |Message                                                                                                                                                                                                                                                                                                                                                                                         |
    |99201    |99201    |%Current Date MMDDYYYY% |%Current Date MMDDYYYY% |99201 is invalid because another E&M code 99201, was already entered for this patient on this day. Only one E&M code may be entered per day, unless modifier 25 is present on one of the codes                                                                                                                                                                                                  |
    |99201    |99201-25 |%Current Date MMDDYYYY% |%Current Date MMDDYYYY% |No Errors Found                                                                                                                                                                                                                                                                                                                                                                                 |
    |99201    |99201    |%1 day ago MMDDYYYY%    |%Current Date MMDDYYYY% |No Errors Found                                                                                                                                                                                                                                                                                                                                                                                 |
    |99202    |99201    |%Current Date MMDDYYYY% |%Current Date MMDDYYYY% |99201 is invalid because another E&M code 99202, was already entered for this patient on this day. Only one E&M code may be entered per day, unless modifier 25 is present on one of the codes                                                                                                                                                                                                  |
    |99201    |99202-25 |%Current Date MMDDYYYY% |%Current Date MMDDYYYY% |No Errors Found                                                                                                                                                                                                                                                                                                                                                                                 |
    |99201    |99202    |%1 day ago MMDDYYYY%    |%Current Date MMDDYYYY% |No Errors Found                                                                                                                                                                                                                                                                                                                                                                                 |
    |11011    |99201    |%Current Date MMDDYYYY% |%Current Date MMDDYYYY% |CMS considers 99201 to be part of the global services for 11011 when billed on the same day. Consider adding modifier 25 to 99201 if it represents a significant and separately identifiable E&M service                                                                                                                                                                                        |
    |11011    |99201-25 |%Current Date MMDDYYYY% |%Current Date MMDDYYYY% |No Errors Found                                                                                                                                                                                                                                                                                                                                                                                 |
    |11011-25 |99201    |%Current Date MMDDYYYY% |%Current Date MMDDYYYY% |CMS considers 99201 to be part of the global services for 11011 when billed on the same day. Consider adding modifier 25 to 99201 if it represents a significant and separately identifiable E&M service                                                                                                                                                                                        |
    |11011    |99201    |%1 day ago MMDDYYYY%    |%Current Date MMDDYYYY% |No Errors Found                                                                                                                                                                                                                                                                                                                                                                                 |
    |10040    |99201    |%Current Date MMDDYYYY% |%Current Date MMDDYYYY% |CMS considers 99201 to be part of the global services for 10040 when billed on the same day or within a 10 day post-op window. Consider adding modifier 24 to 99201 if it is an unrelated E&M service during post-op or modifier 25 to 99201 if it is a significant and separately identifiable E&M service                                                                                     |
    |10040-25 |99201    |%Current Date MMDDYYYY% |%Current Date MMDDYYYY% |CMS considers 99201 to be part of the global services for 10040 when billed on the same day or within a 10 day post-op window. Consider adding modifier 24 to 99201 if it is an unrelated E&M service during post-op or modifier 25 to 99201 if it is a significant and separately identifiable E&M service                                                                                     |
    |10040    |99201-25 |%Current Date MMDDYYYY% |%Current Date MMDDYYYY% |No Errors Found                                                                                                                                                                                                                                                                                                                                                                                 |
    |10040    |99201-24 |%Current Date MMDDYYYY% |%Current Date MMDDYYYY% |No Errors Found                                                                                                                                                                                                                                                                                                                                                                                 |
    |10040    |99201    |%10 days ago MMDDYYYY%  |%Current Date MMDDYYYY% |CMS considers 99201 to be part of the global services for 10040 when billed on the same day or within a 10 day post-op window. Consider adding modifier 24 to 99201 if it is an unrelated E&M service during post-op                                                                                                                                                                            |
    |10040    |99201    |%11 days ago MMDDYYYY%  |%Current Date MMDDYYYY% |No Errors Found                                                                                                                                                                                                                                                                                                                                                                                 |
    |10040    |99201-25 |%10 days ago MMDDYYYY%  |%Current Date MMDDYYYY% |CMS considers 99201 to be part of the global services for 10040 when billed on the same day or within a 10 day post-op window. Consider adding modifier 24 to 99201 if it is an unrelated E&M service during post-op                                                                                                                                                                            |
    |10040    |99201-24 |%10 days ago MMDDYYYY%  |%Current Date MMDDYYYY% |No Errors Found                                                                                                                                                                                                                                                                                                                                                                                 |
    |10040-24 |99201    |%10 days ago MMDDYYYY%  |%Current Date MMDDYYYY% |CMS considers 99201 to be part of the global services for 10040 when billed on the same day or within a 10 day post-op window. Consider adding modifier 24 to 99201 if it is an unrelated E&M service during post-op                                                                                                                                                                            |
    |11451    |99201    |%Current Date MMDDYYYY% |%Current Date MMDDYYYY% |CMS considers 99201 to be part of the global services for 11451, when billed on the same day, the previous day, or within a 90 day post-op window. Consider adding modifier 24 to 99201 if it is an unrelated E&M service during post-op, modifier 25 to 99201 if it is a significant and separately identifiable E&M service, or modifier 57 to 99201 if it resulted in a decision for surgery |
    |11451-25 |99201    |%Current Date MMDDYYYY% |%Current Date MMDDYYYY% |CMS considers 99201 to be part of the global services for 11451, when billed on the same day, the previous day, or within a 90 day post-op window. Consider adding modifier 24 to 99201 if it is an unrelated E&M service during post-op, modifier 25 to 99201 if it is a significant and separately identifiable E&M service, or modifier 57 to 99201 if it resulted in a decision for surgery |
    |11451    |99201-25 |%Current Date MMDDYYYY% |%Current Date MMDDYYYY% |No Errors Found                                                                                                                                                                                                                                                                                                                                                                                 |
    |11451    |99201-24 |%Current Date MMDDYYYY% |%Current Date MMDDYYYY% |No Errors Found                                                                                                                                                                                                                                                                                                                                                                                 |
    |11451    |99201-57 |%Current Date MMDDYYYY% |%Current Date MMDDYYYY% |No Errors Found                                                                                                                                                                                                                                                                                                                                                                                 |
    |11451    |99201    |%90 days ago MMDDYYYY%  |%Current Date MMDDYYYY% |CMS considers 99201 to be part of the global services for 11451, when billed on the same day, the previous day, or within a 90 day post-op window. Consider adding modifier 24 to 99201 if it is an unrelated E&M service during post-op                                                                                                                                                        |
    |11451    |99201    |%91 days ago MMDDYYYY%  |%Current Date MMDDYYYY% |No Errors Found                                                                                                                                                                                                                                                                                                                                                                                 |
    |11451    |99201    |%Current Date MMDDYYYY% |%2 days ago MMDDYYYY%   |No Errors Found                                                                                                                                                                                                                                                                                                                                                                                 |
    |11451    |99201    |%Current Date MMDDYYYY% |%1 day ago MMDDYYYY%    |CMS considers 99201 to be part of the global services for 11451, when billed on the same day, the previous day, or within a 90 day post-op window. Consider adding modifier 57 to 99201 if it resulted in a decision for surgery                                                                                                                                                                |
    |11451    |99201-25 |%Current Date MMDDYYYY% |%1 day ago MMDDYYYY%    |CMS considers 99201 to be part of the global services for 11451, when billed on the same day, the previous day, or within a 90 day post-op window. Consider adding modifier 57 to 99201 if it resulted in a decision for surgery                                                                                                                                                                |
    |11451-57 |99201    |%Current Date MMDDYYYY% |%1 day ago MMDDYYYY%    |CMS considers 99201 to be part of the global services for 11451, when billed on the same day, the previous day, or within a 90 day post-op window. Consider adding modifier 57 to 99201 if it resulted in a decision for surgery                                                                                                                                                                |
    |11451    |99201-57 |%Current Date MMDDYYYY% |%1 day ago MMDDYYYY%    |No Errors Found                                                                                                                                                                                                                                                                                                                                                                                 |
    |11451    |99201-25 |%90 days ago MMDDYYYY%  |%Current Date MMDDYYYY% |CMS considers 99201 to be part of the global services for 11451, when billed on the same day, the previous day, or within a 90 day post-op window. Consider adding modifier 24 to 99201 if it is an unrelated E&M service during post-op                                                                                                                                                        |
    |11451    |99201-57 |%90 days ago MMDDYYYY%  |%Current Date MMDDYYYY% |CMS considers 99201 to be part of the global services for 11451, when billed on the same day, the previous day, or within a 90 day post-op window. Consider adding modifier 24 to 99201 if it is an unrelated E&M service during post-op                                                                                                                                                        |
    |11451    |99201-24 |%90 days ago MMDDYYYY%  |%Current Date MMDDYYYY% |No Errors Found                                                                                                                                                                                                                                                                                                                                                                                 |
    |11451-24 |99201    |%90 days ago MMDDYYYY%  |%Current Date MMDDYYYY% |CMS considers 99201 to be part of the global services for 11451, when billed on the same day, the previous day, or within a 90 day post-op window. Consider adding modifier 24 to 99201 if it is an unrelated E&M service during post-op                                                                                                                                                        |



  @type3a
  Scenario Outline: CPT-CPT-Time-Visit - Type 3A
    Given "Test Codeedit-17" is on the patient list
    And patient "Test Codeedit-17" has no charges
#    When I select patient "Test Codeedit-17" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I select "the last item" from the "Visit" dropdown
    And I click the "Change Visit" button if it exists
    And I set the following charge headers
      |Name         |Value            |
      |Bill Area    |CodeEditTest     |
      |Svc Site     |Inpatient        |
    And I enter "%1 day ago MMDDYYYY% " in the "Date" field in the "Charge Entry" pane
    And I enter the CPT codes "84488"
    And I enter the ICD-10 codes "F41.1"
    And I click the "Submit" button in the "Charge Entry" pane
    And I click the "Save As Is" button in the "Confirm" pane if it exists
#    Then the "Charge Entry" pane should close
    When I refresh the clinical display
    And I wait "2" seconds
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I select "<Visit>" from the "Visit" dropdown
    And I click the "Change Visit" button if it exists
    And I set the following charge headers
      |Name         |Value            |
      |Bill Area    |CodeEditTest     |
      |Svc Site     |Inpatient        |
    And I enter "<Date>" in the "Date" field in the "Charge Entry" pane
    And I enter the CPT codes "93286"
    And I click the "Validate" button in the "Charge Entry" pane
    Then the text "<Message>" should appear in the "Charge Entry" pane
    And I click the "Close" image

  Examples:
    |Visit           |Date                    |Message                                                                                                                                    |
    |the last item   |%1 day ago MMDDYYYY%    |This visit has already been billed with an admit code. Please code this visit as a subsequent hospital care visit at the appropriate level |



  @type4
  Scenario Outline: Place of Service - Type 4
    Given "Helen Bamberger" is on the patient list
    When I select patient "Helen Bamberger" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value            |
      |Bill Area    |CodeEditTest     |
    And I set the "Svc Site" charge header to "<Site>"
    And I enter the CPT codes "<CPT>"
    And I click the "Validate" button in the "Charge Entry" pane
    Then the text "<Message>" should appear in the "Charge Entry" pane
    And I click the "Close" image

  Examples:
    |Site       |CPT    |Message                                                                                                                        |
    |Inpatient  |33240  |No Errors Found                                                                                                                |
    |Outpatient |33240  |This service is inconsistent with the selected site of service. Consider another code based on this site of service            |
    |Inpatient  |00174  |No Errors Found                                                                                                                |
    |Outpatient |00174  |This service is inconsistent with an office or other non-hospital setting. Consider another code based on this site of service |
    |Inpatient  |99205  |This service is inconsistent with an inpatient setting. Consider another code based on this site of service                    |
    |Outpatient |99205  |No Errors Found                                                                                                                |



  @type5
  Scenario Outline: CPT-Modifier - Type 5
    Given "Helen Bamberger" is on the patient list
    When I select patient "Helen Bamberger" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value            |
      |Bill Area    |CodeEditTest     |
      |Svc Site     |Inpatient        |
    And I enter the CPT codes "<CPT>"
    And I click the "Validate" button in the "Charge Entry" pane
    Then the text "<Message>" should appear in the "Charge Entry" pane
    And I click the "Close" image

  Examples:
    |CPT      |Message                                                    |
    |99233-26 |The modifier 26 is inappropriate for the selected service. |
    |99233-25 |No Errors Found                                            |


  @type6
  Scenario Outline: CPT-ICD Missing - Type 6
    Given "Helen Bamberger" is on the patient list
    When I select patient "Helen Bamberger" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value            |
      |Bill Area    |CodeEditTest     |
      |Svc Site     |Inpatient        |
    And I enter the ICD-10 codes "<ICD>"
    And I enter the CPT codes "<CPT>"
    And I click the "Validate" button in the "Charge Entry" pane
    Then the text "<Message>" should appear in the "Charge Entry" pane
    And I click the "Close" image
  Examples:
    |CPT    |ICD    |Message                                                                                                |
    |92960  |A00.9  |The diagnosis that you have selected does not meet the medical appropriateness criteria for CPT 92960. |
    |92960  |I44.30 |No Errors Found                                                                                        |



  @type7
  Scenario Outline: Referring Provider - Type 7
    Given "Helen Bamberger" is on the patient list
    When I select patient "Helen Bamberger" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value            |
      |Bill Area    |CodeEditTest     |
      |Svc Site     |Inpatient        |
    And I set the "Referring" charge header to "<Referring>"
    And I enter the CPT codes "<CPT>"
    And I click the "Validate" button in the "Charge Entry" pane
    Then the text "<Message>" should appear in the "Charge Entry" pane
    And I click the "Close" image

  Examples:
    |Referring      |CPT    |Message                                     |
    |               |99252  |This CPT requires a referring MD.           |
    |MCDREW, ANDREW |99252  |No Errors Found                             |


  @type8
  Scenario Outline: Notification - Type 8
    Given "Helen Bamberger" is on the patient list
    When I select patient "Helen Bamberger" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value            |
      |Bill Area    |CodeEditTest     |
      |Svc Site     |Inpatient        |
    And I enter the CPT codes "<CPT>"
    And I enter the ICD-10 codes "<ICD>"
    And I click the "Validate" button in the "Charge Entry" pane
    Then the text "<Message>" should appear in the "Charge Entry" pane
    And I click the "Close" image

  Examples:
    |CPT    |ICD   |Message                                                                                                                                      |
    |71010  |I50.9 |You have selected diagnosis I50.9. Be sure to fill out the CHF Assessment Form for this patient.                                             |
    |99255  |C43.9 |You have selected CPT 99255. This CPT requires very detailed documentation. Please be sure to include all information in the patient's chart |



  @type9
  Scenario Outline: Header Required - Type 9
    Given "Helen Bamberger" is on the patient list
    When I select patient "Helen Bamberger" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value            |
      |Bill Area    |CodeEditTest     |
      |Svc Site     |Inpatient        |
    And I set the "Injury Type" charge header to "<Injury>"
    And I enter the CPT codes "3111F"
    And I enter the ICD-10 codes "<ICD>"
    And I click the "Validate" button in the "Charge Entry" pane
    Then the text "<Message>" should appear in the "Charge Entry" pane
    And I click the "Close" image

  Examples:
    |Injury    |ICD      |Message                                                                                                                                                                          |
    |          |S02.0XXA |You have selected a diagnosis which is an injury code, S02.0XXA. You must choose a value for the Injury Type transaction header. ICD9s in the range 800-999.9 are Injury Codes.  |
    |Athletic  |S02.0XXA |No Errors Found                                                                                                                                                                  |


  @type10
  Scenario Outline: CPT-CPT-Time Missing - Type 10
    Given "Test Codeedit-15" is on the patient list
    And patient "Test Codeedit-15" has no charges
#    When I select patient "Test Codeedit-15" from the patient list
    When I select "Add Charge" from the "Patient Header Actions" menu
    And I select "<Visit>" from the "Visit" dropdown
    And I click the "Change Visit" button if it exists
    And I set the following charge headers
      |Name         |Value            |
      |Bill Area    |CodeEditTest     |
      |Svc Site     |Outpatient       |
    And I enter "<Date1>" in the "Date" field in the "Charge Entry" pane
    And I enter the CPT codes "<CPT1>"
    And I enter the ICD-10 codes "J86.0"
    And I click the "Submit" button in the "Charge Entry" pane
    And I click the "Save As Is" button in the "Confirm" pane if it exists
  #Then the "Charge Entry" pane should close
    When I refresh the clinical display
    And I wait "2" seconds
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I select "the first item" from the "Visit" dropdown
    And I click the "Change Visit" button if it exists
    And I set the following charge headers
      |Name         |Value            |
      |Bill Area    |CodeEditTest     |
      |Svc Site     |Outpatient       |
    And I enter "<Date2>" in the "Date" field in the "Charge Entry" pane
    And I enter the CPT codes "<CPT2>"
    And I click the "Validate" button in the "Charge Entry" pane
    Then the text "<Message>" should appear in the "Charge Entry" pane
    Then I click the "Close" image
#    When I click the "Close" image
#    Then the "Charge Entry" pane should close

  Examples:
    |Visit            |CPT1    |CPT2         |Date1                   |Date2                    |Message                                                                                      |
    |the first item   |90389   |99292        |%Current Date MMDDYYYY% |%Current Date MMDDYYYY%  |CPT 99292 is an add-on code. CPT 99291 must also be entered for this patient on the same day |
    |the last item    |99291   |99292        |%2 day ago MMDDYYYY%    |%Current Date MMDDYYYY%  |CPT 99292 is an add-on code. CPT 99291 must also be entered for this patient on the same day |
    |the first item   |90389   |99292; 99291 |%Current Date MMDDYYYY% |%Current Date MMDDYYYY%  |No Errors Found                                                                              |
    |the first item   |99291   |99292        |%Current Date MMDDYYYY% |%Current Date MMDDYYYY%  |No Errors Found                                                                              |



  @type11
  Scenario Outline: Header Excluded - Type 11
    Given "Helen Bamberger" is on the patient list
    When I select patient "Helen Bamberger" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value            |
      |Bill Area    |CodeEditTest     |
      |Svc Site     |Outpatient       |
    And I set the "Injury Type" charge header to "<Injury>"
    And I enter the CPT codes "3111F"
    And I enter the ICD-10 codes "S00.00XA"
    And I click the "Validate" button in the "Charge Entry" pane
    Then the text "<Message>" should appear in the "Charge Entry" pane
    And I click the "Close" image

  Examples:
    |Injury  |Message                                                                   |
    |        |No Errors Found                                                           |
    |MVA     |The header Injury Type should be blank when using diagnosis code S00.00XA |


	@type12
  Scenario Outline: Combination Code Edits - Type 12
    Given "<Patient>" is on the patient list
    And patient "<Patient>" has no charges
    When I select patient "<Patient>" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value            |
      |Bill Area    |CodeEditTest     |
      |Svc Site     |Outpatient       |
    And I enter the CPT codes "<CPT>"
    And I enter the ICD-10 codes "<ICD>"
    And I click the "Validate" button in the "Charge Entry" pane
    Then the text "<Message>" should appear in the "Charge Entry" pane
    And I click the "Close" image

  Examples:
    |Patient          |CPT    |ICD    |Message                                                                                       |
    |Test Codeedit-9  |99203  |N39.41 |No Errors Found                                                                               |
    |Test Codeedit-11 |99203  |N39.41 |No Errors Found                                                                               |
    |Test Codeedit-3  |99479  |L94.0  |Diagnosis codes 701.0, 701.1, 701.3 and 701.4 should be limited to patients 1 to 28 days old. |
    |Test Codeedit-1  |99479  |L94.0  |No Errors Found                                                                               |
    |Test Codeedit-3  |99479  |I21.09 |No Errors Found                                                                               |

  @type12a
  Scenario Outline: Combination Code Edits, fire PQRS measure - Type 12A[DEV-46962]
    Given "Test Codeedit-10" is on the patient list
    And patient "Test Codeedit-10" has no charges
    When I select patient "Test Codeedit-10" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value            |
      |Bill Area    |CodeEditTest     |
      |Svc Site     |Outpatient       |
    And I enter the CPT codes "<CPT>"
    And I enter the ICD-10 codes "<ICD>"
    And I click the "Validate" button in the "Charge Entry" pane
    Then the text "<Message>" should appear in the "Charge Entry" pane
    And I click the "Submit" button in the "Charge Entry" pane
    Then the text "<Measure Label>" should appear in the "Measures and Questions" pane
    And I select "<Answer>" from the "PQRS" radio list
    And I click the "PQRS Submit" button in the "Measures and Questions" pane
    And I am on the "Forms" tab
    And I select the "Measures" subtab
    And I click the "Reset Criteria" button in the "Measure Search" pane
    And I select "Today" from the "Timeframe" dropdown in the "Measure Search" pane
    And I enter "<Measure>" in the "External Measure Id" field in the "Measure Search" pane
    And I click the "Search" button in the "Measure Search" pane
#can't use --following rows-- in an example
    Then the patient "Test Codeedit-10" should appear in the "Measure Search Results" pane

  Examples:
    |CPT    |ICD    |Message                                     |Measure Label  |Answer    |Measure   |
    |15736  |N39.41 |No Errors Found                             |Measure #21    |Yes       |PQRS_0021 |


  @type13
  Scenario Outline: CPT Modifier Missing - Type 13
    Given "Helen Bamberger" is on the patient list
    And patient "Helen Bamberger" has no charges
    When I select patient "Helen Bamberger" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value            |
      |Bill Area    |CodeEditTest     |
      |Svc Site     |Inpatient        |
    And I enter the CPT codes "<CPT>"
    And I click the "Validate" button in the "Charge Entry" pane
    Then the text "<Message>" should appear in the "Charge Entry" pane
    And I click the "Close" image

  Examples:
    |CPT      |Message                                                                          |
    |99222    |If you are the admitting and/or attending physician, please select modifier: AI. |
    |99222-AI |No Errors Found                                                                  |




  @type14
  Scenario Outline: Primary ICD Checking - Type 14
  #need to enable code edit type 14 just for this test
    Given I am on the "Patient List V2" tab
    And I select "CCList" from the "Patient List" menu
    And "Helen Bamberger" is on the patient list
    And patient "Helen Bamberger" has no charges
#    When I select patient "Helen Bamberger" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value            |
      |Bill Area    |CodeEditTest     |
      |Svc Site     |Inpatient        |
    And I enter the CPT codes "00842"
    And I enter the ICD-10 codes "I44.30"
    And I click the "Submit" button in the "Charge Entry" pane
  #Then the "Charge Entry" pane should close
    Given I am logged into the portal with user "lnolan" using the default password
    And I am on the "Patient List V2" tab
    And I select "CCList" from the "Patient List" menu
    And "Helen Bamberger" is on the patient list
    When I select patient "Helen Bamberger" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value            |
      |Bill Area    |CodeEditTest     |
      |Svc Site     |Inpatient        |
    And I enter the CPT codes "71010"
    And I enter the ICD-10 codes "<ICD>"
    And I click the "Validate" button in the "Charge Entry" pane
    Then the text "<Message>" should appear in the "Charge Entry" pane
    And I click the "Close" image

  Examples:
    |ICD      |Message                                                                                                      |
    |I44.30   |This diagnosis I44.30 has already been used as a primary diagnosis for this date within the same Department. |
    |I44.0    |No Errors Found                                                                                              |



  @type15
  Scenario Outline: CPT-CPT Units - Type 15
    Given "Helen Bamberger" is on the patient list
    When I select patient "Helen Bamberger" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name          |Value           |
      |Bill Area     |CodeEditTest    |
      |Svc Site      |Inpatient       |
    And I enter the CPT codes "<CPT>"
    And I click the "Validate" button in the "Charge Entry" pane
    Then the text "<Message>" should appear in the "Charge Entry" pane
    And I click the "Close" image

  Examples:
    |CPT                  |Message                                                               |
    |90461; 90696         |When using CPT 90696, a minimum of 3 units is required for CPT 90461. |
    |90461:2; 90696       |When using CPT 90696, a minimum of 3 units is required for CPT 90461. |
    |90461:3; 90696       |No Errors Found                                                       |


  @type16
  Scenario Outline: ICD-ICD-Excluded - Type 16
    Given "Helen Bamberger" is on the patient list
    When I select patient "Helen Bamberger" from the patient list
    And patient "Helen Bamberger" has no charges
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name          |Value           |
      |Bill Area     |CodeEditTest    |
      |Svc Site      |Inpatient       |
    And I enter the CPT codes "99221"
    And I enter the ICD-10 codes "<ICD>"
    And I click the "Validate" button in the "Charge Entry" pane
    Then the text "<Message>" should appear in the "Charge Entry" pane
    And I click the "Close" image

  Examples:
    |ICD           |Message                                                                                       |
    |I10; I11.0    |These codes are not allowed to be submitted together on the same charge and same service date |
    |Q03.9; I44.30 |No Errors Found                                                                               |
    |I44.30; G91.1 |No Errors Found                                                                               |



  @typeforced
  Scenario Outline: Forced vs. Non-forced Edits
    Given "Helen Bamberger" is on the patient list
    When I select patient "Helen Bamberger" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value            |
      |Bill Area    |CodeEditTest     |
      |Svc Site     |Outpatient       |
    And I enter the CPT codes "<CPT>"
    And I click the "Validate" button in the "Charge Entry" pane
    Then the text "<Message>" should appear in the "Charge Entry" pane
    And I click the "Close" image

  Examples:
    |CPT    |Message                              |
    |97811  |This is a FORCED code edit example.  |



  @typepayer
  Scenario Outline: Payer Edits
    Given "<Patient>" is on the patient list
    When I select patient "<Patient>" from the patient list
    And I select "Visits" from clinical navigation
    And I select "the first item" in the "Visits" table
    And I click the "Edit Visit" button in the "Visit Detail" pane
    And I wait "2" seconds
    And I select "<Insurance>" from the "Financial Class" dropdown
    And I click the "Save" button in the "Edit Visit" pane
    And I select "Charges" from clinical navigation
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value            |
      |Bill Area    |CodeEditTest     |
      |Svc Site     |Outpatient       |
    And I enter the CPT codes "97813"
    And I click the "Validate" button in the "Charge Entry" pane
    Then the text "<Message>" should appear in the "Charge Entry" pane
    And I click the "Close" image

  Examples:
    |Patient         |Insurance   |Message                                      |
    |Test Codeedit-7 |Medicare    |This is a SILENT FORCED code edit example.   |
    |Test Codeedit-6 |HMO         |This is a SILENT FORCED code edit example.   |
    |Test Codeedit-8 |            |This is a SILENT FORCED code edit example.   |



  @typerole
  Scenario Outline: Role Based Edits
    Given I am logged into the portal with user "<User>" using the default password
    And I am on the "Patient List V2" tab
    And I select "CCList" from the "Patient List" menu
    And "Test Codeedit-16" is on the patient list
    And patient "Test Codeedit-16" has no charges
    When I select patient "Test Codeedit-16" from the patient list
    And I select "Charges" from clinical navigation
    And I select "Most Recent Visit" from the "Clinical Timeframe" menu
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I set the following charge headers
      |Name         |Value            |
      |Bill Area    |CodeEditTest     |
      |Svc Site     |Inpatient        |
  #And I enter the CPT codes "99223;99238"
    And I enter the CPT codes "<CPT>"
    And I click the "Validate" button in the "Charge Entry" pane
    Then the text "<Message>" should appear in the "Charge Entry" pane
    And I click the "Close" image

  Examples:
    |User           |CPT        |Message                                                                                                                                                                                         |
    |lnolan         |35001;35005|This visit has both an admit and discharge charge on the same day. Only one charge should exist for this visit using a same day admit discharge CPT code 35001,35002,35005                      |
    |addchargeuser1 |99223;99238|99223 is invalid because another E&M code 99238, was already entered for this patient on this day. Only one E&M code may be entered per day, unless modifier 25 is present on one of the codes. |

#turn off all codeedit-check boxes under user sever after code edits execution
#  Moved to CukesRunnerTest
#  Scenario: Turn off all codeedits on user server
#    And I execute the "Disable All Code Edits" query