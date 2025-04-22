@PatientListV2
Feature: Patient List Version 2 display options
  Setup: Requires patient lists for each scenario already exist
  Sort scenarios use the FBC Location PKHospital-ST for population

  Background:
    Given I am logged into the portal with user "PLV2LVL3" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized

  Scenario: Standard Display Configuration
    When I select "Default Display" from the "Patient List" menu
    Given "Molly Darr" is on the patient list
    And I select "Edit" from the "Actions" menu
    And I wait "1" second
    And I select the "Display" section
    When I drag and drop the settings for the "Display" Section as follows
      | Patient Name     | Age, Gender, LOS / Scheduled / Discharge Date |
      | Location         |                                               |
      | Reason for Visit |                                               |
    And I click the "Create Patient List Save" button
    And I wait "3" seconds
    Then the visit cell for patient "DARR, MOLLY" in "Patient List" table should contain the following
      | DARR, MOLLY                 |%calcYear:12/22/1938%Y F LOS:4D |
      | 5G.501.A.PKHospital-Central |                                |
      | Acute MI                    |                                |

  Scenario: All Items Display Configuration
    When I select "Display All" from the "Patient List" menu
    Given "DISPLAY , VERVE D*" is on the patient list
   #Account number, admit date, Mrn, Referring and Consulting are not static
    Then the visit cell for patient "DISPLAY , VERVE D*" in "Patient List" table should contain the following
      | DISPLAY, VERVE D*  | %calcYear:03/16/1974%Y M LOS:%calcLOSDate date:07/17/2013 time:09:00% |
      | PKHospital-Central | 6546237350 07/17/13                                                   |
      | Display Test       |                                                                       |
      |                    | Inpatient Card Group                                                  |
      | 03/16/1974         | ADKINS, LEO RICE, DONNA                                               |
      | 5346353453         | Medicare                                                              |
      | JONES, WILLIAM     | BEST, CLARA BEASLEY, LOUISE                                           |
      | FINCH, ERIN        | VICK, FRANKLIN                                                        |
      | BLACKBURN, MIRIAM  | BlueCross BlueShield                                                  |

  Scenario: Display Patient Name only
    When I select "Display Patient Name" from the "Patient List" menu
    Given "Molly Darr" is on the patient list
    Then the visit cell for patient "MOLLY DARR" in "Patient List" table should contain the following
      | DARR, MOLLY |  |

  Scenario: Display Cell Containing Multiple Items, One Blank
    When I select "Display Blank Cell Test" from the "Patient List" menu
    Given "Molly Darr" is on the patient list
    Then the visit cell for patient "MOLLY DARR" in "Patient List" table should contain the following
      | DARR, MOLLY                 |%calcYear:12/22/1938%Y F LOS:4D |
      | 5G.501.A.PKHospital-Central | Card Group                     |
      | Acute MI                    |                                |

  Scenario: Patient List Sort Order: Patient Name Ascending
    When I select "Patient Name Sort" from the "Patient List" menu
    And I select "Edit" from the "Actions" menu
    And I wait "1" second
    And I select the "Display" section
    And I select "" from the "Secondary Sort On" dropdown
    And I select "Patient Name" from the "Sort On" dropdown
    And I wait "1" second
    And I select "A to Z" from the "Sort Order" dropdown
    And I click the "Create Patient List Save" button
    Then the "Patient List" should be sorted by "Patient Name" in "Ascending" order

  Scenario: Patient List Sort Order: Patient Name Descending
    When I select "Patient Name Sort" from the "Patient List" menu
    And I select "Edit" from the "Actions" menu
    And I wait "1" second
    And I select the "Display" section
    And I select "" from the "Secondary Sort On" dropdown
    And I select "Patient Name" from the "Sort On" dropdown
    And I wait "1" second
    And I select "Z to A" from the "Sort Order" dropdown
    And I click the "Create Patient List Save" button
    Then the "Patient List" should be sorted by "Patient Name" in "Descending" order

  Scenario: Patient List Sort Order: Location Ascending
    When I select "Location Ascending" from the "Patient List" menu
    Then the "Patient List" should be sorted by "Location" in "Ascending" order

  Scenario: Patient List Sort Order: Location Descending
    When I select "Location Descending" from the "Patient List" menu
    Then the "Patient List" should be sorted by "Location" in "Descending" order

  Scenario: Patient List Sort Order: Admitting Ascending
    When I select "Sort Test" from the "Patient List" menu
    And I select "Edit" from the "Actions" menu
    And I wait "1" second
    And I select the "Display" section
    And I select "" from the "Secondary Sort On" dropdown
    And I select "Admitting" from the "Sort On" dropdown
    And I wait "1" second
    And I select "A to Z" from the "Sort Order" dropdown
    And I click the "Create Patient List Save" button
    Then the "Patient List" should be sorted by "Admitting" in "Ascending" order

  Scenario: Patient List Sort Order: Admitting Descending
    When I select "Sort Test" from the "Patient List" menu
    And I select "Edit" from the "Actions" menu
    And I wait "1" second
    And I select the "Display" section
    And I select "" from the "Secondary Sort On" dropdown
    And I select "Admitting" from the "Sort On" dropdown
    And I wait "1" second
    And I select "Z to A" from the "Sort Order" dropdown
    And I click the "Create Patient List Save" button
    Then the "Patient List" should be sorted by "Admitting" in "Descending" order

  Scenario: Patient List Sort Order: Attending Ascending
    When I select "Sort Test" from the "Patient List" menu
    And I select "Edit" from the "Actions" menu
    And I wait "1" second
    And I select the "Display" section
    And I select "" from the "Secondary Sort On" dropdown
    And I select "Attending" from the "Sort On" dropdown
    And I wait "1" second
    And I select "A to Z" from the "Sort Order" dropdown
    And I click the "Create Patient List Save" button
    Then the "Patient List" should be sorted by "Attending" in "Ascending" order

  Scenario: Patient List Sort Order: Attending Descending
    When I select "Sort Test" from the "Patient List" menu
    And I select "Edit" from the "Actions" menu
    And I wait "1" second
    And I select the "Display" section
    And I select "" from the "Secondary Sort On" dropdown
    And I select "Attending" from the "Sort On" dropdown
    And I wait "1" second
    And I select "Z to A" from the "Sort Order" dropdown
    And I click the "Create Patient List Save" button
    Then the "Patient List" should be sorted by "Attending" in "Descending" order

  Scenario: Patient List Sort Order: Consulting Ascending
    When I select "Sort Test" from the "Patient List" menu
    And I select "Edit" from the "Actions" menu
    And I wait "1" second
    And I select the "Display" section
    And I select "" from the "Secondary Sort On" dropdown
    And I select "Consulting" from the "Sort On" dropdown
    And I wait "1" second
    And I select "A to Z" from the "Sort Order" dropdown
    And I click the "Create Patient List Save" button
    Then the "Patient List" should be sorted by "Consulting" in "Ascending" order

  Scenario: Patient List Sort Order: Consulting Descending
    When I select "Sort Test" from the "Patient List" menu
    And I select "Edit" from the "Actions" menu
    And I wait "1" second
    And I select the "Display" section
    And I select "" from the "Secondary Sort On" dropdown
    And I select "Consulting" from the "Sort On" dropdown
    And I wait "1" second
    And I select "Z to A" from the "Sort Order" dropdown
    And I click the "Create Patient List Save" button
    Then the "Patient List" should be sorted by "Consulting" in "Descending" order

  Scenario: Patient List Sort Order: Account Number Ascending
    When I select "Sort Test" from the "Patient List" menu
    And I select "Edit" from the "Actions" menu
    And I wait "1" second
    And I select the "Display" section
    And I select "" from the "Secondary Sort On" dropdown
    And I select "Account Number" from the "Sort On" dropdown
    And I wait "1" second
    And I select "A to Z" from the "Sort Order" dropdown
    And I click the "Create Patient List Save" button
    Then the "Patient List" should be sorted by "Account Number" in "Ascending" order

  Scenario: Patient List Sort Order: Account Number Descending
    When I select "Sort Test" from the "Patient List" menu
    And I select "Edit" from the "Actions" menu
    And I wait "1" second
    And I select the "Display" section
    And I select "" from the "Secondary Sort On" dropdown
    And I select "Account Number" from the "Sort On" dropdown
    And I wait "1" second
    And I select "Z to A" from the "Sort Order" dropdown
    And I click the "Create Patient List Save" button
    Then the "Patient List" should be sorted by "Account Number" in "Descending" order

  Scenario: Patient List Sort Order: Admit/Scheduled Date Ascending
    When I select "Sort Test" from the "Patient List" menu
    And I select "Edit" from the "Actions" menu
    And I wait "1" second
    And I select the "Display" section
    And I select "" from the "Secondary Sort On" dropdown
    And I select "Admit / Appointment Date" from the "Sort On" dropdown
    And I wait "1" second
    And I select "Most Recent Last" from the "Sort Order" dropdown
    And I click the "Create Patient List Save" button
    And I wait "5" seconds
    Then the "Patient List" should be sorted by "Admit/Scheduled Date" in "Ascending" order

  Scenario: Patient List Sort Order: Admit/Scheduled Date Descending
    When I select "Sort Test" from the "Patient List" menu
    And I select "Edit" from the "Actions" menu
    And I wait "1" second
    And I select the "Display" section
    And I select "" from the "Secondary Sort On" dropdown
    And I select "Admit / Appointment Date" from the "Sort On" dropdown
    And I wait "1" second
    And I select "Most Recent First" from the "Sort Order" dropdown
    And I click the "Create Patient List Save" button
    And I wait "5" seconds
    Then the "Patient List" should be sorted by "Admit/ScheduledDate" in "Descending" order

  Scenario: Patient List Sort Order: Admitting Ascending then on Location Ascending
    When I select "Sort Test" from the "Patient List" menu
    And I select "Edit" from the "Actions" menu
    And I wait "1" second
    And I select the "Display" section
    And I select "" from the "Secondary Sort On" dropdown
    And I select "Admitting" from the "Sort On" dropdown
    And I wait "1" second
    And I select "A to Z" from the "Sort Order" dropdown
    And I select "Location" from the "Secondary Sort On" dropdown
    And I wait "1" second
    And I select "A to Z" from the "Secondary Sort Order" dropdown
    And I click the "Create Patient List Save" button
    Then the "Patient List" should be first sorted by "Admitting" in Ascending order and then sorted by "Location" in Ascending order

  Scenario: Patient List Sort Order: Patient Name Ascending then on Admit/Scheduled Most Recent First
    When I select "Patient Name Sort" from the "Patient List" menu
    And I select "Edit" from the "Actions" menu
    And I wait "1" second
    And I select the "Display" section
    And I select "" from the "Secondary Sort On" dropdown
    And I select "Patient Name" from the "Sort On" dropdown
    And I wait "1" second
    And I select "A to Z" from the "Sort Order" dropdown
    And I select "Admit / Appointment Date" from the "Secondary Sort On" dropdown
    And I wait "1" second
    And I select "Most Recent First" from the "Secondary Sort Order" dropdown
    And I click the "Create Patient List Save" button
    And I wait "5" seconds
    Then the "Patient List" should be first sorted by "Patient Name" in Ascending order and then sorted by "Admit/ScheduledDate" in Ascending order

  Scenario: Patient List Sort Order: Location Descending then on Patient Name Ascending
    When I select "Location Patient Sort" from the "Patient List" menu
    And I select "Edit" from the "Actions" menu
    And I wait "1" second
    And I select the "Display" section
    And I select "" from the "Secondary Sort On" dropdown
    And I select "Location" from the "Sort On" dropdown
    And I wait "1" second
    And I select "Z to A" from the "Sort Order" dropdown
    And I select "Patient Name" from the "Secondary Sort On" dropdown
    And I wait "1" second
    And I select "A to Z" from the "Secondary Sort Order" dropdown
    And I click the "Create Patient List Save" button
    Then the "Patient List" should be first sorted by "Location" in Descending order and then sorted by "Patient Name" in Ascending order

