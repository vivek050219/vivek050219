Feature: Patient List Clinicals

#  Scenario: Setup
  Background:
   #Given I am logged into the portal with the default user
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Patient List V2" tab
    And I use the API to create a patient list named "Patient List Clin" owned by "pkadminv2" with the following parameters
      | Type   | Name            | Value      |
      | Filter | Medical Service | Card Group |
    And I click the "Refresh Patient List" button
    And I select "Patient List Clin" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    And "Mona Angeline" is on the patient list

  @BuildVerificationTest @Demo
  Scenario: 1. Loading of the Overview pane
   #The overview module provides a general overview of patient clinical information
    When I select patient "Molly Darr" from the patient list
    And I select "Overview" from clinical navigation
    Then the "Overview Clinical Notes" pane should load
    And the "Overview Visits" pane should load
    And the "Overview Charges" pane should load

  @BuildVerificationTest @Demo
  Scenario: 2. Loading of the Clinical Notes list
    When I select patient "Molly Darr" from the patient list
    And I select "Clinical Notes" from clinical navigation
    #And I select "Most Recent Visit" from the "Clinical Timeframe" menu
   #And I select "All" from the "Note Type" menu
    And I click the "Clinical Notes Filter" button in the "Clinical Notes Detail" pane
    And I wait "3" seconds
    And I check the "SelectAll/SelectNone" checkbox
    And I click the "OK Filter" button
    Then the "Clinical Notes" table should load with the following columns
      | Date/Time |
      | Note Type |
    And the "Text Selected for Note" pane should load

  @BuildVerificationTest
  Scenario: 3. Allergies overview
    When I select patient "Molly Darr" from the patient list
    And I select "Allergies" from clinical navigation
    And I select "All" from the "Allergy Type" menu
    Then the "Allergies" table should load with the following columns
      | Allergy (\d of \d) |
      | Type               |
      | Reaction           |
      | Severity           |

  @BuildVerificationTest @Demo
  Scenario: 4. Selected allergy details
    When I select patient "Molly Darr" from the patient list
    And I select "Allergies" from clinical navigation
    And I select "All" from the "Allergy Type" menu
    And I select "the first item" in the "Allergies" table
    Then the "Allergy Detail" pane should load

  @PatientSafety @PortalSmoke @Demo
  Scenario: 5. Allergies list contents
    When I select patient "Mona Angeline" from the patient list
    And I select "Allergies" from clinical navigation
    And I select "All" from the "Allergy Type" menu
    Then the contents of the "Allergies" clinical table should contain the results of the "Patient Allergies" query

  @BuildVerificationTest @donotrun
  Scenario: 6. Loading of the Medications pane
    When I select patient "Molly Darr" from the patient list
    And I select "Medications" from clinical navigation
    #And I select "Most Recent Visit" from the "Clinical Timeframe" menu
   #And I select "All" from the "Medication Type" menu
    And I click the "Medications Filter" button
    And I wait "2" seconds
    And I check the "ALL" checkbox
    And I click the "OKFilter" button
    Then the "Medication Orders" table should load with the following columns
      | Medication (\d of \d) |
      | Dose                  |
      | SIG                   |
      | Order Start           |
      | Order Stop            |

  @BuildVerificationTest @PortalSmoke
  Scenario: 7. Loading of the Lab Results pane
    When I select patient "Molly Darr" from the patient list
    And I select "Lab Results" from clinical navigation
    #And I select "Most Recent Visit" from the "Clinical Timeframe" menu
    And I select "All" from the "Lab Type" menu
    And I wait up to "5" seconds for the "Lab Results Loading" field of type "pane" to be invisible
    And I select "Panel Summary" from the "Lab Results View" menu
    Then the "Lab Panels" table should load with the following columns
      | Date/Time |
      | Panel     |
      | Norm      |
      | Status    |

  @BuildVerificationTest
  Scenario: 8. Displaying detailed info of the selected Lab Result
    When I select patient "Molly Darr" from the patient list
    And I select "Lab Results" from clinical navigation
    #And I select "Most Recent Visit" from the "Clinical Timeframe" menu
    And I select "All" from the "Lab Type" menu
    And I wait up to "5" seconds for the "Lab Results Loading" field of type "pane" to be invisible
    And I select "Panel Summary" from the "Lab Results View" menu
    And I select "the first item" in the "Lab Panels" table
    Then the "Panel Table" pane should load
    And the "Panel Detail" pane should load

  @PortalSmoke
  Scenario: 9. Lab Results - Expanded Panels
    Given "Mona Angeline" is on the patient list
    When I select patient "Mona Angeline" from the patient list
    And I select "Lab Results" from clinical navigation
    #And I select "Most Recent Visit" from the "Clinical Timeframe" menu
    And I select "All" from the "Lab Type" menu
    And I wait up to "5" seconds for the "Lab Results Loading" field of type "pane" to be invisible
    And I select "Expanded Panels" from the "Lab Results View" menu
    Then the "Lab Panels" table should load with the following columns
      | Date/Time  |
#      | Panel (\d of \d) |
      | Panel      |
      | Components |
      | Norm       |
      | Status     |

  @PortalSmoke @Demo
  Scenario: 10. Lab Results - Component List
    Given "Mona Angeline" is on the patient list
    When I select patient "Mona Angeline" from the patient list
    And I select "Lab Results" from clinical navigation
    #And I select "Most Recent Visit" from the "Clinical Timeframe" menu
    And I select "All" from the "Lab Type" menu
    And I wait up to "5" seconds for the "Lab Results Loading" field of type "pane" to be invisible
    And I select "Component List" from the "Lab Results View" menu
    Then the "Lab Component List" table should load with the following columns
      | Date/Time    |
      | Panel        |
      | Component    |
#      | Component (\d of \d) |
      | Low          |
      | High         |
      | Normal Range |
      | Status       |

  @PortalSmoke
  Scenario: 11. Lab Results - Component Table
    Given "Mona Angeline" is on the patient list
    When I select patient "Mona Angeline" from the patient list
    And I select "Lab Results" from clinical navigation
    #And I select "Most Recent Visit" from the "Clinical Timeframe" menu
    And I select "All" from the "Lab Type" menu
    And I wait up to "5" seconds for the "Lab Results Loading" field of type "pane" to be invisible
    And I select "Component Table" from the "Lab Results View" menu
   #can't specify columns, since these change
    And the "Lab Component Table" table should load


  @BuildVerificationTest @Demo
  Scenario: 12. Loading of New Results pane
    When I select patient "Molly Darr" from the patient list
    And I select "New Results" from clinical navigation
    Given New Results display options are set
    When I select "Most Recent Visit" from the "Clinical Timeframe" menu
    And I click the "Options" button in the "Patient Summary" pane
    And I wait "2" seconds
    And I "check" the following
      | Clinical Notes |
      | Test Results   |
    And I click the "Options OK" button
    Then the "Patient Summary" table should load with the following columns
      | Type                   |
      | Date                   |
      | Description (\d of \d) |
      | Details                |


#  DEV-85230 -- Problems not getting marked as viewed in New Results
  @PortalSmoke @Demo
  Scenario: 13. New Results
    Given I select patient "Mona Angeline" from the patient list
    Then I select "New Results" from clinical navigation
    And New Results display options are set
    And I click the "Options" button in the "Patient Summary" pane
    And I wait "1" second
    And I "check" the following
      | Clinical Notes |
      | Test Results   |
    And I click the "Options OK" button
    And I wait "2" seconds
    Then rows starting with the following should appear in the "Patient Summary" table
      | Date                  |
      | %Current Date MMDDYY% |
    When I select "Mark All Viewed Before Today" from the "Filter Drop Down" menu
   #may give warning about something
    And I click the "OK" button in the "Information" pane if it exists
    Then rows starting with the following should appear in the "Patient Summary" table
      | Date                  |
      | %Current Date MMDDYY% |
    When I select "Mark All Viewed" from the "Filter Drop Down" menu
   #may give warning about something
    And I click the "OK" button in the "Information" pane if it exists
    And I wait "2" seconds
    Then the text "No data found" should appear in the "Patient Summary" pane


  @PortalSmoke @Demo
  Scenario: 14. Clinical Overview
   #Due to DEV-43628 issue in IE10 with pkadmin user in App03, scenario updated with user "addchargeuser1"
   #And once the issue got fixed we will revertback the code.
#    Given I am logged into the portal with user "addchargeuser1" using the default password
#    And I am on the "Patient List V2" tab
#    And "Molly Darr" is on the patient list
    When I select patient "Molly Darr" from the patient list
    And patient "Molly Darr" has at least one charge
    And I select "Overview" from clinical navigation
    Then the "Overview Visits" pane should load
    When I select "the first item" in the "Overview Visits" table
    Then the "Visit Detail" pane should load
    And the "Overview Charges" pane should load
    When I select "the first item" in the "Overview Charges" table
    Then the "Overview Charge Detail" pane should load
    Then the "Overview Clinical Notes" pane should load
    When I select "the first item" in the "Overview Clinical Notes" table
    Then the "Note Detail" pane title should contain the first item in the "Note Type" column in the "Overview Clinical Notes" table


  @BuildVerificationTest
  Scenario: 15. Verify the Display Options dialog
    When I select patient "Molly Darr" from the patient list
    And I select "New Results" from clinical navigation
    And I click the "Options" button in the "Patient Summary" pane
#    Then the "Display Options" pane should load
    When I click the "Options Cancel" button
    Then the "Display Options" pane should close

  @BuildVerificationTest @Demo
  Scenario: 16. Loading of the Patient Details pane
    When I select patient "Molly Darr" from the patient list
    And I select "Patient Detail" from clinical navigation
    Then the "Patient Detail" pane should load
    And the text "DARR, MOLLY" should appear in the "Name" field in the "Demographics" section of the "Patient Detail" table
   #And the text "1234468" should appear in the "MRN" field in the "Demographics" section of the "Patient Detail" table
    And the text "12/22/1938" should appear in the "DOB" field in the "Demographics" section of the "Patient Detail" table

  @PortalSmoke
  Scenario: 17. Switch selected patient
    When I select patient "Molly Darr" from the patient list
    And I select "Patient Detail" from clinical navigation
    And I select patient "Mona Angeline" from the patient list
    Then the text "ANGELINE, MONA" should appear in the "Header" pane
    And the text "ANGELINE, MONA" should appear in the "Name" field in the "Demographics" section of the "Patient Detail" table

  @BuildVerificationTest
  Scenario: 18. Loading of the Sign-Out pane
    When I select patient "Molly Darr" from the patient list
    And I select "Sign-Out" from clinical navigation
    Then the "Sign-Out" pane should load

  @BuildVerificationTest @Demo
  Scenario: 19. Displaying of the list of visits
    When I select patient "Molly Darr" from the patient list
    And I select "Visits" from clinical navigation
    #And I select "Most Recent Visit" from the "Clinical Timeframe" menu
    And I select "All" from the "Visit Type" menu
    Then the "Visits" table should load with the following columns
      | Arrival (\d of \d) |
      | Provider           |
      | Discharge          |
      | Type               |
      | Reason For Visit   |
      | Billable           |

  @BuildVerificationTest
  Scenario: 20. Appearance of the Clinical Notes details
    When I select patient "Molly Darr" from the patient list
    And I select "Clinical Notes" from clinical navigation
    #And I select "Most Recent Visit" from the "Clinical Timeframe" menu
   #And I select "All" from the "Note Type" menu
    And I click the "Clinical Notes Filter" button in the "Clinical Notes Detail" pane
    And I "check" the following
      | Select All/Select None |
    And I click the "OK Filter" button
    And I select "the first item" in the "Clinical Notes" table
    Then the "Note Detail" pane should load


  @PortalSmoke @Demo
  Scenario: 21. Clinical Note detail verification
    When I select patient "Mona Angeline" from the patient list
    And I select "Clinical Notes" from clinical navigation
#    And I select "Last 30 Days" from the "Clinical Timeframe" menu
   #And I select "All" from the "Note Type" menu
    And I click the "Clinical Notes Filter" button in the "Clinical Notes Detail" pane
    And I wait "2" seconds
    And I "check" the following
      | Select All/Select None |
    And I click the "OK Filter" button
    Then the contents of the "Clinical Notes" clinical table should contain the results of the "Patient Notes" query filtered by "timeframe" of "Last 30 Days"
    When I select "the first item" in the "Clinical Notes" table
    Then the "Note Detail" pane should load
    Then the "Note Detail" pane title should match the first item in the "Note Type" column in the "Clinical Notes" table
    And the "Date/Time" field in the "Note Detail" clinical detail pane should match the first item in the "Date/Time" column in the "Clinical Notes" table


  @BuildVerificationTest
  Scenario: 22. Loading of the Order Status pane
    When I select patient "Molly Darr" from the patient list
    And I select "Orders" from clinical navigation
    And I select "All" from the "Order Type" menu
    Then the "Orders" table should load with the following columns
      | Existing orders* |
      | Start            |
      | Status           |


#    DEV-85655 -- Existing meds are not getting loaded into environment from simpk
# DEV-85233 -- Can't Change or Set 'Show Orders From' and 'Thru'
  @PortalSmoke
  Scenario: 23. Order detail verification[DEV-85233][DEV-85655]
    Given I select patient "Mona Angeline" from the patient list
    Then I select "Orders" from clinical navigation
    And I select "All" from the "Order Type" menu
    And the "Orders" table should load
    When I select "Yesterday" from the "Past Order Date" dropdown
    And I select "Tomorrow" from the "Future Order Date" dropdown
   #Order query is more complex than previously thought.  Switching to hard coded values for now.
   #Then the contents of the "Orders" clinical table should match the results of the "Patient Orders" query
    Then rows containing the following should appear in the "Orders" table
      | Existing orders*                                                                                      |
      | acetaminophen tablet 325mg Oral Q6H PRN pain                                                          |
      | Aspirin Oral 81mg Daily                                                                               |
      | carvedilol tablet 25mg Oral q12h                                                                      |
      | cefepime Solution for Injection 1GM IV q12h                                                           |
      | Clopidogrel Oral 75mg Daily                                                                           |
      | Coumadin Oral 5mg Daily                                                                               |
      | furosemide 10 mg/mL Injection 20mg IV q8h                                                             |
      | Insulin-SS SC 3-11units QAC SS                                                                        |
      | Novolog Mix 70-30 FlexPen 100 unit/mL (70-30) Sub-Q (insulin asp prt-insulin aspart) 14units SubQ BID |
      | Omeprazole Oral 40mg Daily                                                                            |
      | ondansetron HCl (PF) 4 mg/2 mL Injection 4mg IV q4h PRN nausea/vomiting                               |
      | simvastatin tablet 20mg Oral qPM                                                                      |
      | Zyvox 600 mg/300 mL IV (linezolid) 600mg IV q12h                                                      |
    When I select "the first item" in the "Orders" table
    Then the text matching the first item in the "Existing orders*" column in the "Orders" table should appear in the "Order Detail" pane
    And the text in the "Order Status:" field of the "Order Detail" table should match the first item in the "Status" column in the "Orders" table
    And the text in the "Ordered By:" field of the "Order Detail" table should match the first item in the "Ordered By" column in the "Orders" table


  @BuildVerificationTest @Demo
  Scenario: 24. Loading of the Problems list
    Given patient "Molly Darr" has at least one problem
    When I select patient "Molly Darr" from the patient list
    And I select "Problems" from clinical navigation
    #And I select "Most Recent Visit" from the "Clinical Timeframe" menu
    And I select "All" from the "Problem Type" menu
    Then the "Problem List" table should load with the following columns
      | Description(\d of \d) |
      | Status                |
      | Last Used             |
      | Last Used By          |

  @BuildVerificationTest @Demo
  Scenario: 25. Loading of the Test Results list
    When I select patient "Molly Darr" from the patient list
    And I select "Test Results" from clinical navigation
    #And I select "Most Recent Visit" from the "Clinical Timeframe" menu
    And I select "All" from the "Test Type" menu
    Then the "Test Results" table should load with the following columns
      | Date/Time       |
      | Test (\d of \d) |
      | Status          |
    And the "Text Selected for Note" pane should load

  @BuildVerificationTest
  Scenario: 26. Displaying detailed info of the selected Test Result
    Given "Molly Darr" is on the patient list
    When I select patient "Molly Darr" from the patient list
    And I select "Test Results" from clinical navigation
    #And I select "Most Recent Visit" from the "Clinical Timeframe" menu
    And I select "All" from the "Test Type" menu
    And I select "the first item" in the "Test Results" table
    Then the "Test Results Detail" pane should load

  @PortalSmoke
  Scenario: 27. Clinicals Test Results
    When I select patient "Mona Angeline" from the patient list
    And I select "Test Results" from clinical navigation
    And I select "Last 30 Days" from the "Clinical Timeframe" menu
    And I select "All" from the "Test Type" menu
    Then the contents of the "Test ResultsV2" clinical table should contain the results of the "Patient Tests" query
    When I select "the first item" in the "Test ResultsV2" table
    Then the "Test Results Detail" pane should load
    Then the "Test Results Detail Header" pane title should contain the first item in the "Test (\d of \d)" column in the "Test ResultsV2" table
    And the "Status" field in the "Test Results Detail" clinical detail pane should match the first item in the "Status" column in the "Test ResultsV2" table

  @BuildVerificationTest @Demo
  Scenario: 28. Loading vitals of the selected patient
    When I select patient "Molly Darr" from the patient list
    And I select "Vitals" from clinical navigation
    #And I select "Most Recent Visit" from the "Clinical Timeframe" menu
    Then the "Vital Signs" table should load with the following columns
      | Vital Signs           |
      | Most Recent           |
      | Previous              |
      | Current 24 hour range |
    And the "Vital Detail" pane should load
    And the "Vital Graph" pane should load

  @BuildVerificationTest @Demo
  Scenario: 29. Loading IOs of the selected patient
    When I select patient "Molly Darr" from the patient list
    And I select "I/O" from clinical navigation
    #And I select "Most Recent Visit" from the "Clinical Timeframe" menu
    Then the "I/O" pane should load

  @PortalSmoke
  Scenario: 30. Clinicals IOs
    When I select patient "Molly Darr" from the patient list
    And I select "I/O" from clinical navigation
    And I select "Last 7 Days" from the "Clinical Timeframe" menu
#    Then the contents of the I/O table should match the results of the "Patient IOs" query

  @BuildVerificationTest
  Scenario: 31. Appearance of the Visit Details
    When I select patient "Molly Darr" from the patient list
    And I select "Visits" from clinical navigation
    And I select "All" from the "Visit Type" menu
    And I select "the first item" in the "Visits" table
    Then the "Visit Detail" pane should load

  @BuildVerificationTest
  Scenario: 32. Loading of the Charges list
    Given patient "Molly Darr" has at least one charge
    When I select patient "Molly Darr" from the patient list
    And I select "Charges" from clinical navigation
    When I select "Most Recent Visit" from the "Clinical Timeframe" menu
    And I uncheck the "Show Visits" checkbox
    Then the "Charges" table should load with the following columns
      | Date/Time |
      | Prov/Team |
      | Proc      |
      | Qty       |
      | Diag      |

#    https://jira/browse/DEV-79159
#  Medications and medication orders are not showing up in 842 due to HL7s being rejected. -- HIC 3/20/19
  @BuildVerificationTest
  Scenario: 33. Appearance of the Medications details[DEV-79159]
    When I select patient "Molly Darr" from the patient list
    And I select "Medications" from clinical navigation
     #And I select "Most Recent Visit" from the "Clinical Timeframe" menu
     #And I select "Last 5 Years" from the "ClinicalTimeframe" menu
    And I select "All" from the "Medication Order Filter" menu
#    And I click the "Medication Orders Filter" button
    And I wait "2" seconds
#    And I check the "All" checkbox
#    And I click the "OK Filter" button
    And I select "the first item" in the "Medication Orders" table
    Then the "Medication Detail" pane should load



#    12.24.19: Meds did not load from Simpk due to error thrown in dispatcher code:
#  INFO   | jvm 1    | 2019/12/24 02:04:43 | 2019-12-24 02:04:43.352 ERROR 37908 --- [      Thread-22] c.p.m.m.MedsConsumer                     : com.patientkeeper.exceptions.PatientKeeperException: findOrderDefinitionByNdc bad parameters fgId=1   drugcode=54429725
#  INFO   | jvm 1    | 2019/12/24 02:04:42 | %xwEx java.lang.StringIndexOutOfBoundsException: String index out of range: 11
#INFO   | jvm 1    | 2019/12/24 02:04:42 | 	at java.lang.String.substring(String.java:1963) ~[?:1.8.0_131]
#INFO   | jvm 1    | 2019/12/24 02:04:42 | 	at com.patientkeeper.cpoe.monaco.cds.CdsInboundCPOEHelper.findOrderDefinitionByNdc(CdsInboundCPOEHelper.java:458) [monaco-main-9.2.0-SNAPSHOT.jar:?]

#    DEV-85655 -- Existing meds are not getting loaded into environment from simpk
  @PortalSmoke
  Scenario: 34. Medications list detail verification[DEV-85655]
    When I select patient "Mona Angeline" from the patient list
    And I select "Medications" from clinical navigation
    And I wait "1" second
    And I select "All" from the "Medication Order Filter" menu
    And I wait "1" second
    When I select "the first item" in the "Medication Orders" table
    Then the text matching the first item in the "Existing orders*" column in the "Medication Orders" table should appear in the "Medication Detail" pane
    And the text in the "Start:" field of the "Medication Detail" table should match the first item in the "Start" column in the "Medication Orders" table
    And the text in the "End:" field of the "Medication Detail" table should match the first item in the "Stop" column in the "Medication Orders" table
    And the "MAR" table should load with the following columns
      | Date/Time |
      | Status    |
      | Dose      |
      | Admin By  |


  @BuildVerificationTest
  Scenario: 35. Loading of the Forms pane
    When I select patient "Molly Darr" from the patient list
    And I select "Forms" from clinical navigation
    Then the "Forms" pane should load

  @PortalSmoke
  Scenario: 36. Clinical Patient Detail
    When I select patient "Molly Darr" from the patient list
    And I select "Patient Detail" from clinical navigation
    Then the text "DARR, MOLLY" should appear in the "Name" field in the "Demographics" section of the "Patient Detail" table
    And the text "Demographics" should appear in the "Patient Detail" pane
#			And the text "Current Visit" should appear in the "Patient Detail" pane
    And the text "InFacility Visit" should appear in the "Patient Detail" pane
    And the text "Physicians" should appear in the "Patient Detail" pane
    And the text "Guarantor Information" should appear in the "Patient Detail" pane
    And the text "Insurance" should appear in the "Patient Detail" pane
   #Or, to be more complete, verify each field matches the data in the database for Molly Darr

  @PortalSmoke
  Scenario: 37. 0012_Clinicals_SignOut
   #Should be split into a few separate scenarios
    When I select patient "Molly Darr" from the patient list
    And I select "Sign-Out" from clinical navigation
   #Task 1:
    And I click the "Add Task" button in the "SignOut" pane
    And I wait "1" second
    And I enter "Task 1" in the "Task" field
    And I check the "High Priority" checkbox
    And I click the "SaveTask" button
   #Task 2:
    And I click the "Add Task" button in the "SignOut" pane
    And I wait "1" second
    And I enter "Task 2" in the "Task" field
    And I uncheck the "High Priority" checkbox
    And I enter "%3 days from now MMDDYY%" in the "Due Date" field
    And I click the "Save Task" button
   #Task 3:
    And I click the "Add Task" button in the "SignOut" pane
    And I wait "1" second
    And I enter "Task 3" in the "Task" field
    And I uncheck the "High Priority" checkbox
    And I select "Complete" from the "Status" dropdown
    And I enter "%Current Date%" in the "Due Date" field
    And I click the "Save Task" button
   #Verify Task 1:
    And I click the "OptionsTask" button in the "SignOut" pane
    And I wait "1" second
    And I check the "Restrict to High Priority Only" checkbox
    And I "uncheck" the following
      | Include Completed Tasks             |
      | Include Tasks with Future Due Dates |
    And I click the "Task Display Options OK" button
    And rows containing the following should appear in the "SignOut" table
      | Task*  |
      | Task 1 |
   #Verify Task 3:
    And I click the "OptionsTask" button in the "SignOut" pane
    And I wait "1" second
    And I check the "Include Completed Tasks" checkbox
    And I "uncheck" the following
      | Restrict to High Priority Only      |
      | Include Tasks with Future Due Dates |
    And I click the "Task Display Options OK" button
    And rows containing the following should appear in the "SignOut" table
      | Task*  |
      | Task 3 |
   #Verify Task 2:
    And I click the "OptionsTask" button in the "SignOut" pane
    And I wait "2" seconds
    And I check the "Include Tasks with Future Due Dates" checkbox
    And I "uncheck" the following
      | Restrict to High Priority Only |
      | Include Completed Tasks        |
    And I click the "Task Display Options OK" button
    And rows containing the following should appear in the "SignOut" table
      | Task*  |
      | Task 1 |
      | Task 2 |

  @PortalSmoke
  Scenario: 38. Clinicals Vitals
    When I select patient "Molly Darr" from the patient list
    And I select "Vitals" from clinical navigation
    And I select "Last 30 Days" from the "Clinical Timeframe" menu
   #And I select "All" from the "Vitals Filter" menu
    And I click the "Vitals Options" button
    And I wait "1" second
    And I enter "4" in the "Vital Display Interval" field
    And I click the "OptionsOK" button
    And I wait "2" seconds
    Then the patient's "Most Recent" vitals should match their values in the database

  @PortalSmoke @Demo
  Scenario: 39. Under Expanded Panels fishbone diagrams should display
    Given I select patient "Molly Darr" from the patient list
    Then I select "Lab Results" from clinical navigation
    #And I select "Most Recent Visit" from the "Clinical Timeframe" menu
    And I select "All" from the "Lab Type" menu
    When I select "Expanded Panels" from the "Lab Results View" menu
    Then the "Fishbone" table should load
    Then the "Lab Panels" table should load with the following columns
      | Date/Time  |
      | Panel      |
      | Components |
      | Norm       |
      | Status     |
    Then rows containing the following should appear in the "Lab Panels" table
      | Panel |
      | BMP   |


  @PortalSmoke @Demo
  Scenario: 40. Select BMP. Details should default below
    When I select patient "Molly Darr" from the patient list
    And I select "Lab Results" from clinical navigation
    #And I select "Most Recent Visit" from the "Clinical Timeframe" menu
    And I select "All" from the "Lab Type" menu
    And I select "Expanded Panels" from the "Lab Results View" menu
#    And I sort the "Lab Panels" table chronologically by the "Panel (\d of \d)" column in "Ascending" order
    When I select "BMP" from the "Panel" column in the "Lab Panels" table
    Then the "Panel BMP" pane should load


  @PortalSmoke @Demo
  Scenario: 41. Select K in the Panel Table and Component Graph should appear to the right
    Given I select patient "Molly Darr" from the patient list
    And I select "Lab Results" from clinical navigation
    #And I select "Most Recent Visit" from the "Clinical Timeframe" menu
    And I select "All" from the "Lab Type" menu
    And I select "Component Table" from the "Lab Results View" menu
    Then the "Component Graph" table should load
    When I select "K" in the "Component Graph" table
    Then the following field should display in the "Components" pane
      | Name       | Type    |
      | MulitGraph | element |


  @PortalSmoke @Demo
  Scenario: 42. Select Order again option should appear for and panel and components should appear
    Given I am logged into the portal with user "medrecuser3" using the default password
    And I am on the "Patient List V2" tab
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Lab Results" from clinical navigation
    And I select "Expanded Panels" from the "Lab Results View" menu
    And I select "the first item" in the "Lab Panels" table
    Then the following field should display in the "Panel BMP" pane
      | Name              | Type   |
      | Panel Order Again | button |


  @PortalSmoke @Demo
  Scenario: 43. Check box and lab should appear in Notes
    Given I select patient "Molly Darr" from the patient list
    And I select "Lab Results" from clinical navigation
    And I select "Panel Summary" from the "Lab Results View" menu
    Then the following field should display in the "Components" pane
      | Name            | Type    |
      | NoteWriter Icon | element |
    When I click the "NoteWriter Icon" element in the "Components" pane
    Then the checkbox should be checked in all rows in the "Lab Panels" table


#  DEV-85655 -- Existing meds are not getting loaded into environment from simpk
  @PortalSmoke @Demo
  Scenario: 44. Select a multi-graph lab component, medication, and vital, then select table view[DEV-85655]
    Given I select patient "Molly Darr" from the patient list
    Then I select "Lab Results" from clinical navigation
    And I select "Component List" from the "Lab Results View" menu
    Then the "LabComponentList" table should load
    When I select "the first item" in the "LabComponentList" table
    And I click the "MulitGraph" element in the "Components" pane
    Then the "Lab MultiGraph" table should load
    And I select "Glu" in the "Lab MultiGraph" table
#    And I select "Glyburide" in the "Medication MultiGraph" table
    And I select "Simvastatin" in the "Medication MultiGraph" table
    And I select "FSBG" in the "Vital MultiGraph" table
    When I select "TABLE" from the "MultiGraphView" radio list
    Then the "TableViewMultiGraph" table should load
    And I click the "Close Multi Graph" button


#  DEV-85655 -- Existing meds are not getting loaded into environment from simpk
  @PortalSmoke @Demo
  Scenario: 45. Select graph view and Save as a snapshot and Manage Snapshot and Make snapshot a default[DEV-85655]
    Given I select patient "Molly Darr" from the patient list
    Then I select "Lab Results" from clinical navigation
    And I select "Component List" from the "Lab Results View" menu
    Then the "Lab ComponentList" table should load
    And I click the "MulitGraph" element in the "Components" pane
    Then the "Lab MultiGraph" table should load
    And I select "Glu" in the "Lab MultiGraph" table
#    And I select "Glyburide" in the "Medication MultiGraph" table
    And I select "Simvastatin" in the "Medication MultiGraph" table
    And I select "FSBG" in the "Vital MultiGraph" table
    When I select "GRAPH" from the "Multi GraphView" radio list
    Then the "GraphView MultiGraph" pane should load
    And the following field should display in the "GraphView MultiGraph" pane
      | Name       | Type    |
      | Graph View | element |
    And I enter "Snap" in the "SnapShot" field
    And I click the "Save Snapshot" button
    And I click "OK" in the confirmation box if it exists
    When I click the "Manage Snapshots" link in the "Multi Graph" pane
    And I wait "2" seconds
    Then the "Manage Snapshot" pane should load
    And I check the "Manage Snap" checkbox
    When I click the "Make Default" button
    And I click "OK" in the confirmation box
    Then the text "Default" should appear in the "Manage Snapshot" pane
    And I check the "ManageSnap" checkbox
    And I click the "Delete" button in the "Manage Snapshot" pane
    And I click the "Yes" button
    And I click "OK" in the confirmation box
    And I click the "Close Manage Snapshots" button
    And I click the "Close Multi Graph" button


  @PortalSmoke @Demo
  Scenario: 46. Select a problem and details should display below
    Given "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Problems" from clinical navigation
    #And I select "Most Recent Visit" from the "Clinical Timeframe" menu
    And I select "All" from the "Problem Type" menu
    Then the "Problem List" table should load
    When I select "the first item" in the "Problem List" table
    Then the "ProblemDetail" pane should load


  @PortalSmoke @Demo
  Scenario: 47. Select Resolve on one of the problems and Status should update to Resolved
    When I select patient "Molly Darr" from the patient list
    And I select "Problems" from clinical navigation
    Then the "Problem List" table should load
    When I select "the first item" in the "Problem List" table
    Then the "ProblemDetail" pane should load
    When I click the "Edit" button in the "ProblemDetail" pane
    Then the "Edit Problem" pane should load
    And the following field should display in the "EditProblem" pane
      | Name    | Type    |
      | Resolve | element |
   #When I select "Resolved" from the "Resolve" radio list
    And I click the "Resolve" element in the "EditProblem" pane
    And I click the "Save Problem" button in the "EditProblem" pane
    Then the "ProblemList" table should load
    And I refresh the clinical display
    Then the text "Resolved" should appear in the "ProblemDetail" pane


  @PortalSmoke @Demo
  Scenario: 48. Select ECHO and detailed information should appear to the right
    Given "Molly Darr" is on the patient list
    When I select patient "Molly Darr" from the patient list
    And I select "Test Results" from clinical navigation
    #And I select "Most Recent Visit" from the "Clinical Timeframe" menu
    And I select "All" from the "Test Type" menu
    And I select "ECHO" from the "Test (\d of \d)" column in the "Test Results" table
    Then the "Test Results Detail" pane should load


# DEV-85255 -- Can't Search for and Order any Tests or Order Again any Tests
  @PortalSmoke @Demo
  Scenario: 49. Selecting Order again will allow you to order the test again
    Given I am logged into the portal with user "medrecuser3" using the default password
    Then I am on the "Patient List V2" tab
    And I select "MedRecPLV2" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Test Results" from clinical navigation
    And I select "All" from the "Test Type" menu
#    And I select "Chest x-ray" from the "Test (\d of \d)" column in the "Test ResultsV2" table
    And I select "Chest x-ray" from the "Test" column in the "Test ResultsV2" table
    And I wait "2" seconds
    And I click the "TestResults OrderAgain" button in the "Test Results Detail" pane
    And I wait "3" seconds
    When I click the "Radiology Tab" element
#    And I select "PORTABLE CHEST XRAY PCXR" from the "AllOrders" list in the search results
    And I select "RadOrdrGrp PORTABLE CHEST XRAY PCXR" from the "Radiology" list in the search results
    Then the text "RadOrdrGrp PORTABLE CHEST XRAY PCXR" should appear in the "New Test Orders" pane


  @PortalSmoke @Demo
  Scenario: 50. Loading IOs for the selected days the selected patient
    When I select patient "Molly Darr" from the patient list
    And I select "I/O" from clinical navigation
    And I select "Last 7 Days" from the "Clinical Timeframe" menu
    Then the "I/O" pane should load
    When I select "Current Week" from the "Clinical Timeframe" menu
    Then the "I/O" pane should load
    When I select "Last 7 Days" from the "Clinical Timeframe" menu
    Then the "I/O" pane should load


  @PortalSmoke @Demo
  Scenario: 51. Link to multi-graph should work -Vitals
    Given I am logged into the portal with user "medrecuser3" using the default password
    And I am on the "Patient List V2" tab
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Vitals" from clinical navigation
    #And I select "Most Recent Visit" from the "Clinical Timeframe" menu
    And I click the "MulitGraph" element in the "Vitals" pane
    And I wait "2" seconds
    Then the "Vital MultiGraph" table should load

  @PortalSmoke @Demo  @donotrun
  Scenario: 52. Select Print verify print preview displays in Allergies
    When I select patient "Molly Darr" from the patient list
    And I select "Allergies" from clinical navigation
    And I select "the first item" in the "Allergies" table
    Then the "Allergy Detail" pane should load
    When I click the "PrintAllergy" element in the "Allergy Detail" pane

  @PortalSmoke @Demo @donotrun
  Scenario: 53. Select Print verify print preview displays
    When I select patient "Molly Darr" from the patient list
    And I select "New Results" from clinical navigation
    Given New Results display options are set
    #When I select "Last 30 Days" from the "Clinical Timeframe" menu
    And I click the "Options" button in the "Patient Summary" pane
    And I wait "1" second
    And I "check" the following
      | Clinical Notes |
      | Medications    |
      | Problems       |
      | Test Results   |
    And I click the "OptionsOK" button
    And I select "the first item" in the "PatientSummary" table
    When I click the "PrintAllergy" element in the "PatientSummaryDetail" pane
