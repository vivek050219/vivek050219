Feature: CPOE
  This test suite includes UI and CPOE functionality scenarios
#    Feature: CPOE Validation

  Background:
     #Given I am logged into the portal with the default user
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Patient List V2" tab
    And I use the API to create a patient list named "PSList" owned by "pkadminv2" with the following parameters
      | Type   | Name            | Value      |
      | Filter | Medical Service | Card Group |
    And I click the "Refresh Patient List" button
    And I select "PSList" from the "Patient List" menu

  @UIValidation @CPOE
  Scenario: Check available clinical navigation
    Then the following clinical navigation options should be available
      | New Results    |
      | Overview       |
      | Patient Detail |
      | Visits         |
      | Allergies      |
      | Clinical Notes |
      | Medications    |
      | Lab Results    |
      | Orders         |
      | Test Results   |
      | Vitals         |
      | I/O            |

  @CPOE
  Scenario: Add patients by facility
    Given "Molly Darr" is not on the patient list
    When I select "Add Patient" from the "Actions" menu
    And I wait "3" seconds
    And I click the "Clear Criteria" button
    And I enter "5" in the "Admit in last N days" field
    And I enter "Darr" in the "Search Last Name" field
    And I enter "Molly" in the "Search First Name" field
    And I select "PKHospital-Central" from the "Facility" dropdown
    And I click the "Visit Search" button
    And I select patient "MOLLY DARR" from the "Name (\d)" column in the "Add Patient Search" table
    And I click the "Add" button in the "Add patient(s) to your patient list" pane
    And I wait "2" seconds
    And I click the "Close" button in the "Add patient(s) to your patient list" pane
    And I wait "2" seconds
    Then patient "MOLLY DARR" should be on the patient list

  @UIValidation @CPOE
  Scenario: Overview Clinical Navigation Options
    When "MOLLY DARR" is on the patient list
    Then I select patient "MOLLY DARR" from the patient list
    And I select "Overview" from clinical navigation
    Then the "Overview Clinical Notes" pane should load
    And the "Overview Visits" pane should load

  @UIValidation @CPOE
  Scenario: New Results Clinical Navigation Options
    When I select "New Results" from clinical navigation
    And "MOLLY DARR" is on the patient list
    And I select patient "MOLLY DARR" from the patient list
    And New Results display options are set
#        And I select "Most Recent Visit" from the "Clinical Timeframe" menu
    And I wait "2" seconds
    And I click the "Options" button
    And I "check" the following checkbox in the "Display Options" pane
      | Clinical Notes |
      | Test Results   |
    And I click the "Options OK" button
    And I wait "2" seconds
    Then the "Patient Summary" table should load with the following columns
      | Type                   |
      | Date                   |
      | Description (\d of \d) |
      | Details                |

  @UIValidation @CPOE
  Scenario: Patient Detail Clinical Navigation Options
    When I select "Patient Detail" from clinical navigation
    Then the "Patient Detail" pane should load
    When "MOLLY DARR" is on the patient list
    And I select patient "MOLLY DARR" from the patient list
    And the text "DARR, MOLLY" should appear in the "Name" field in the "Demographics" section of the "Patient Detail" table
    When I select "Visits" from clinical navigation
    And I wait "2" seconds
    And I select "All" from the "Visit Type" menu
    And I wait "2" seconds
    Then the "Visits" table should load with the following columns
      | Arrival (\d of \d) |
      | Provider           |
      | Discharge          |
      | Type               |
      | Reason For Visit   |
      | Billable           |

  @UIValidation @CPOE
  Scenario: Allergies Clinical Navigation Options
    When I select "Allergies" from clinical navigation
    When "MOLLY DARR" is on the patient list
    And I select patient "MOLLY DARR" from the patient list
#        And I select patient !patientlistname from the patient list
    And I select "All" from the "Allergy Type" menu
    Then the "Allergies" table should load with the following columns
      | Allergy (\d of \d) |
      | Type               |
      | Reaction           |
      | Severity           |

  @UIValidation @CPOE
  Scenario: Clinical Notes Clinical Navigation Options
    When "MOLLY DARR" is on the patient list
    And I select patient "MOLLY DARR" from the patient list
    And I select "Clinical Notes" from clinical navigation
#        And I select "Last 5 Years" from the "ClinicalTimeframe" menu
    And I click the "Clinical Notes Filter" button
    And I wait "4" seconds
    And I check the "SelectAll/SelectNone" checkbox
    And I click the "OK Filter" button
    Then the "Clinical Notes" table should load with the following columns
      | Date/Time |
      | Note Type |
      | Author    |


    #    https://jira/browse/DEV-79159
#  Medications and medication orders are not showing up in 842 due to HL7s being rejected. -- HIC 3/20/19
  @UIValidation @CPOE
  Scenario: Medications Clinical Navigation Options[DEV-79159]
    When "MOLLY DARR" is on the patient list
    And I select patient "MOLLY DARR" from the patient list
    And I select "Medications" from clinical navigation
     #And I select "Most Recent Visit" from the "Clinical Timeframe" menu
#        And I select "Last 5 Years" from the "ClinicalTimeframe" menu
#        And I click the "Medication Orders Filter" button
#        And I wait "2" seconds
#        And I check the "All" checkbox
#        And I click the "OK Filter" button
    And I select "All" from the "Medication Order Filter" menu
    Then the "Medication Orders" table should load with the following columns
      | Existing orders* |
      | Dose             |
      | Sig              |
      | Start            |
      | Stop             |
      | Last MAR event   |


  @UIValidation @CPOE
  Scenario: Lab Results Clinical Navigation Options
    When "MOLLY DARR" is on the patient list
    And I select patient "MOLLY DARR" from the patient list
    And I select "Lab Results" from clinical navigation
#        And I select "Last 5 Years" from the "ClinicalTimeframe" menu
    And I select "All" from the "Lab Type" menu
    And I select "Panel Summary" from the "Lab Results View" menu
    Then the "Lab Panels" table should load with the following columns
      | Date/Time |
      | Panel     |
      | Norm      |
      | Status    |

  @UIValidation @CPOE
  Scenario: Orders Clinical Navigation Options
    When "MOLLY DARR" is on the patient list
    Then I select patient "MOLLY DARR" from the patient list
        #When I select patient !patientlistname from the patient list
    And I select "Orders" from clinical navigation
    And I select "All" from the "Order Type" menu
    Then the "Orders" table should load with the following columns
      | Existing orders* |
      | Start            |
      | Status           |

  @UIValidation @CPOE
  Scenario: Test Results Clinical Navigation Options
    When "MOLLY DARR" is on the patient list
    Then I select patient "MOLLY DARR" from the patient list
        # When I select patient !patientlistname from the patient list
    And I select "Test Results" from clinical navigation
#        And I select "Last 5 Years" from the "ClinicalTimeframe" menu
    And I select "All" from the "Test Type" menu
        # Select first row from table to ensure the table has finished loading
    And I select "the first item" in the "Test Results" table
    Then the "Test ResultsV2" table should load with the following columns
      | Date/Time       |
      | Test (\d of \d) |
      | Status          |
    And the "Text Selected for Note" pane should load

  @UIValidation @CPOE
  Scenario: Vitals Clinical Navigation Options
    When I am on the "Admin" tab
    And I select the "Institution" subtab
    And I select "Site Administration" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    And I select "false" from the "Filters Sticky By Modules" radio list in the "Site Administration" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
#    #Added this login step with a different admin user to force the scenario to re-login after the above Site Admin
  #    #change (which requires a re-login to take affect). -- HIC 4/16/19
    Given I am logged into the portal with user "pkadmin" using the default password
    When I am on the "Patient List V2" tab
    And I select "Card Group" from the "Patient List" menu
    And "MOLLY DARR" is on the patient list
    When I select patient "MOLLY DARR" from the patient list
    And I select "Vitals" from clinical navigation
    And I clear and enter "30" in the "Display at most" field
#        And I select "Last 5 Years" from the "ClinicalTimeframe" menu
    Then the "Vital Signs" table should load with the following columns
      | Vital Signs           |
      | Most Recent           |
      | Previous              |
      | Current 24 hour range |
    And the "Vital Detail" pane should load
    And the "Vital Graph" pane should load
    When I am on the "Admin" tab
    And I select the "Institution" subtab
    And I select "Site Administration" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    And I select "true" from the "Filters Sticky By Modules" radio list in the "Site Administration" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    #    #Added this login step with a different admin user for same reason as commented above.  -- HIC 4/16/19
    Given I am logged into the portal with user "pkadminv2" using the default password

  @UIValidation @CPOE
  Scenario: I/O Clinical Navigation Options
    When "MOLLY DARR" is on the patient list
    Then I select patient "MOLLY DARR" from the patient list
        #When I select patient !patientlistname from the patient list
    And I select "I/O" from clinical navigation
    Then the "I/O" pane should load

  @UIValidation @CPOE
  Scenario: Available options under Institution settings
    Given I am on the "Admin" tab
    And I select the "Institution" subtab
    Then the following options should be available in the "Edit Institution Settings" dropdown
      | Status Summary      |
      | Site Administration |
      | Device              |
      | Patient List        |
      | Charge Capture      |
      | eSignature          |
      | Forms               |
      | Lab Results         |
      | Medications         |
      | Clinical Notes      |
      | NoteWriter          |
      | Orders              |
      | Problem List        |
      | Test Results        |
      | Sign-Out            |
      | Vitals and I/Os     |

  @CPOE
  Scenario: CPOE (Solr) Order Search, Submit
        #Given I disable all the interaction checking options
    When I am on the "Admin" tab
    And I select the "Facility Group" subtab
    And I click the "CPOE Utilities" link in the "Facility Group Navigation" pane
    And I wait up to "10" seconds for the "Interaction Checking" field of type "MISC_ELEMENT" to be visible
    And I click the "Interaction Checking" element
    And I click the "Edit_CPOEUtilities" button
    And I wait up to "20" seconds for the "Edit Facility Group Utlity Settings Loading Icon" field of type "MISC_ELEMENT" to be invisible
    And the "Edit Facility Group Utilities Settings" pane should load
    And I edit the following settings in the "Edit Facility Group Utilities Settings" pane
      | Name                                 | Type     | Value    |
      | Non-Medication Duplicate Display     | dropdown | Disabled |
      | New Non-Medication Duplicate Display | dropdown | Disabled |
      | Medication Duplicate Display         | dropdown | Disabled |
      | New Medication Duplicate Display     | dropdown | Disabled |
      | Drug Allergy Display                 | dropdown | Disabled |
      | Contraindicated Drug Combination     | dropdown | Disabled |
      | Severe Interaction                   | dropdown | Disabled |
      | Moderate Interaction                 | dropdown | Disabled |
      | Undetermined Severity                | dropdown | Disabled |
      | Prevent Redundant Ordering           | radio    | false    |
    Then I click the "Save_EditFacility Group Utility Settings" button
    When I am on the "Patient List V2" tab
#        And patient !patientlistname should be on the patient list
    And patient "MOLLY DARR" should be on the patient list
        #And I select patient !patientlistname from the patient list
    When I select patient "MOLLY DARR" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Enter Orders" button
    And I click the "OK" button in the "Warning" pane if it exists
     #misspell this name on purpose to see if the orders are retrieved correctly
    When I enter "Tylenol" in the "Add Order" field in the "Enter Orders" pane
#        Then the following options should appear in the "Formulary Med Orders" list in the search results
#            | Tylenol 8 Hour tablet,extended release (acetaminophen)  650MG Oral Daily |
      #| Tylenol 325mg (acetaminophen)  650MG Oral X1           |
     #And I select "Tylenol 8 Hour tablet,extended release (acetaminophen)  650MG Oral Daily" from the "Formulary Med Orders" list in the search results
    And I select "Tylenol 8 Hour tablet,extended release (acetaminophen)  650MG Oral Daily" from the "Formulary Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    And I Submit the Orders
    And I select "All" from the "Order Type" menu
    And I wait "2" seconds
    And I select "Today" from the "Past Order Date" dropdown
    Then the "Orders" table should load
    And I wait "2" seconds
    And rows containing the following should appear in the "Orders" table
      | Existing orders | Start          |
      | Tylenol         | %Current Date% |


# Regualar CBC not listed in labs to order.  Created dev issue [DEV-79218].
# Only happens in 8.4.2.  Is fine in 8.4.1.3 and 8.2.1.17, in automation sites and in manual QA sites. -- HIC 3/13/19
  @CPOE
  Scenario: CPOE Duplicate Lab orders[DEV-79218]
    When I am on the "Admin" tab
    And I select the "Facility Group" subtab
    And I click the "CPOE Utilities" link in the "Facility Group Navigation" pane
    And I wait up to "10" seconds for the "Interaction Checking" field of type "MISC_ELEMENT" to be visible
    And I click the "Interaction Checking" element if it exists
    And I click the "Edit_CPOEUtilities" button
    And I wait up to "20" seconds for the "Edit Facility Group Utlity Settings Loading Icon" field of type "MISC_ELEMENT" to be invisible
    And the "Edit Facility Group Utilities Settings" pane should load
    And I edit the following settings in the "Edit Facility Group Utilities Settings" pane
      | Name                                 | Type     | Value                    |
      | Non-Medication Duplicate Display     | dropdown | Popup and Require Reason |
      | New Non-Medication Duplicate Display | dropdown | Popup and Require Reason |
      | Prevent Redundant Ordering           | radio    | true                     |
    Then I click the "Save_EditFacility Group Utility Settings" button
        #And I enable the non medication duplicate display interaction checking option
        #Given I enable prevent ordering of redundant lab tests
    And I click the logout button
    Given I am logged into the portal with user "pkadminv2" using the default password
    When I am on the "Patient List V2" tab
    And "MOLLY DARR" is on the patient list
    Then I select patient "MOLLY DARR" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Enter Orders" button
    And I click the "OK" button in the "Warning" pane if it exists
    And I enter "CBC" in the "Add Order" field in the "Enter Orders" pane
    And I select CPOE "Lab Orders" tab
    Then the following options should appear in the "Lab Orders" list in the search results
      | CBC today |
    And I select "the first item" from the "Lab Orders" list in the search results
    And I wait "5" seconds
    And I click the "DuplicatelabDontOrder" button if it exists
       #do this 2x - uncomment this if running for the first time
    When I enter "CBC" in the "Add Order" field in the "Enter Orders" pane
    And I select CPOE "Lab Orders" tab
    Then the following options should appear in the "Lab Orders" list in the search results
      | CBC today |
    And I select "the first item" from the "Lab Orders" list in the search results
    Then the text "Redundant Order" should appear in the "Duplicate Order Warning" pane
    And I wait "5" seconds
    And I click on the text "Redundant Order" in the "Duplicate Order Warning" pane
    And I wait "5" seconds
    And I click the "DuplicatelabDontOrder" button
    And I Submit the Orders
#        And I select "All" from the "Order Type" menu
    And I wait "2" seconds
#        And I select "Today" from the "Past Order Date" dropdown
    Then the "Orders" table should load
    And rows containing the following should appear in the "Orders" table
      | Existing orders | Start          |
      | CBC             | %Current Date% |
    And I revert prevent ordering of redundant lab tests

  @CPOE
  Scenario: CPOE Order Set Maintenance Validation
    Given I am on the "Admin" tab
    When I select the "Facility Group" subtab
    And I select "DefaultFacilityGroup" from the "Facility Group" dropdown
    And the "CPOE Preferences" pane should load
#        And I select the Facility Group
    And I click the "Order Sets" link in the "Facility Group Navigation" pane
    And I enter "DISCHARGE ORDER SET" in the "OrderSet Name" field
#        And I enter !orderset in the "OrderSet Name" field
    And I click the "Search CPOE Order Set Maintenance" button
    And I wait "4" seconds
    Then the "CPOE Order Set" table should load
    And I select "DISCHARGE ORDER SET" in the "CPOE Order Set" table
#        And I select !orderset in the "CPOE Order Set" table
    And I click the "Edit CPOE Order Set Maintenance" button
    And I click "OK" in the confirmation box if it exists
    And I wait "2" seconds
    Then the following fields should display in the "Edit Order Set" pane
      | Name    | Type    |
      | Info    | element |
      | Content | element |
      | Preview | element |
    And the following should be unchecked
      | Do not popup order set |
    When I click the "Content" element
    Then the following text should appear in the "Toolbox Content" pane
      | Text         |
      | Order        |
      | Order Search |
      | Order Set    |
    When I click the "Preview" element
    Then the text "Order Set" should appear in the "Preview" pane
    And I click the "CloseEditOrderSet" button

  @donotrun
  Scenario: CPOE Order Set Order Entry Order Submit
    Given I am on the "Patient List V2" tab
     #And "Mona Angeline" is on the patient list
     #And I select patient "Mona Angeline" from the patient list
    And I select patient !patientlistname from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Enter Orders" button
     #And I enter "DISCHARGE ORDER SET" in the "Add Order" field
    And I enter !orderset in the "Add Order" field
    And I wait "2" seconds
    Then the "Order Search Results" table should load
     #And the text "DISCHARGE ORDER SET" should appear in the "Search Order Results" pane
    And the text !orderset should appear in the "Search Order Results" pane
     #And I select "DISCHARGE ORDER SET" from the "All Orders" list in the search results
    And I select !orderset from the "All Orders" list in the search results
     #And the text "DISCHARGE ORDER SET" should appear in the "OrderSet" pane
     #And I click the "Cancel..OrderSet" button
     #And I click the "Yes" button in the "Question" pane
     #Then the "OrderSet" pane should close
     #When I click the "Cancel" button in the "Order Submission" pane
    And I wait "3" seconds
    And I check the "MedOrderSet" checkbox
    And I select "Today" from the "When" multiselect in the "EditMedicationOrder" pane
    And I select "Special Inst" from the "Dose" multiselect in the "EditMedicationOrder" pane
    And I select "Daily" from the "Frequency" multiselect in the "EditMedicationOrder" pane
    And I enter "5" in the "Number of Doses" field in the "EditMedicationOrder" pane
    And I enter "test" in the "Special Instructions" field in the "EditMedicationOrder" pane
    And I click the "Enter Order OK" button in the "EditMedicationOrder" pane
    And I click the "Done with Order Set" button
    And I Submit the Orders
    And I select "All" from the "Order Type" menu
    And I wait "2" seconds
    And I select "Today" from the "Past Order Date" dropdown
    Then the "Orders" table should load
    And rows containing the following should appear in the "Orders" table
      | Existing orders                                                                                                               | Start          | Status    |
      | Child Tylenol Plus Cold-Allergy 12.5 mg-2.5 mg-160 mg/5 mL Oral Susp (diphenhyd-PE-acetaminophen) Oral Daily X 5 doses (test) | %Current Date% | Submitted |

    #TODO: This sets the SolrURL and reruns the indexer every day.  Not sure this should occur during every CPOE run.  Consider converting to a single-run setup task.
  @CPOE
  Scenario: CPOE Add Solr Indexer URL
    Given I am on the "Admin" tab
    And I select the "Facility Group" subtab
    And I click the "CPOE Preferences" link in the "Facility Group Navigation" pane
    And I wait up to "30" seconds for the "Edit CPOE Preferences" field of type "BUTTON" to be visible
    When I click the "Edit CPOE Preferences" button
    And I wait "2" seconds
    And I enter "%SolrURL%" in the "Solr Master URL" field
        #Solr Indexer URL is no longer editable as of 8.4.0: DEV-72125
#        And I enter "%SolrURL%" in the "Solr Indexer URL" field
    And I click the "Save Edit Facility Group Preferences" button
    When I click the "CPOE Utilities" link in the "Facility Group Navigation" pane
    Then the "CPOE Utility" pane should load
    And I wait up to "5" seconds for the "OHA/SearchIndex" field of type "MISC_ELEMENT" to be visible
    And I click the "OHA/SearchIndex" element
    And I click the "Interaction Checking" element
    And I click the "OHA/SearchIndex" element
    And I click the "RefreshIcon" element
    And I wait "3" seconds
#        And I check the "OHA Checkbox" checkbox
    And I click the "Run Search Indexer" button
    And I uncheck the "Run Incremental Update" checkbox
    And I click the "Run the Indexer" button
    And I click the "InformationOK" button if it exists
    Then the text "Failed" should not appear in the "Order History Analyzer" pane
    When I am on the "Patient List V2" tab
    When "MOLLY DARR" is on the patient list
    And I select patient "MOLLY DARR" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Enter Orders" button
    And I click the "OK" button in the "Warning" pane if it exists
    And I enter "Tylenol" in the "Add Order" field in the "Enter Orders" pane
    And I wait "2" seconds
    And I select CPOE "FormularyMedOrders" tab
    Then the "Formulary Med Orders" table should load
    And I select "Tylenol 8 Hour tablet,extended release (acetaminophen)  650MG Oral Daily" from the "Formulary Med Orders" list in the search results
    And I click the "Dont Order" button if it exists
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    Then the text "Tylenol" should appear in the "New Orders" pane
    When I click the "Add Order Cancel" button in the "Order Submission" pane
    And I click the "Yes" button if it exists

  @donotrun
  Scenario: CPOE Test printed email output in Patient List
     #Disable, to avoid interactions popup while placing the order
    When I disable all the interaction checking options
    And I am on the "Patient List V2" tab
    When "MOLLY DARR" is on the patient list
    And I select patient "MOLLY DARR" from the patient list
    And I select "Orders" from clinical navigation
       #Place an order
    And I click the "Enter Orders" button
    And I click the "OK" button in the "Warning" pane if it exists
    And I enter "Aspirin" in the "Add Order" field in the "Enter Orders" pane
    And I select CPOE "Formulary Med Orders" tab
    And I select "ASPIRIN EC 1 TAB  325MG Oral Daily" in the "Formulary Med Orders" table
    And I Submit the Orders
    And I select "All" from the "Order Type" menu
    And I wait "2" seconds
    And I select "Today" from the "Past Order Date" dropdown
    Then the "Orders" table should load
    And rows containing the following should appear in the "Orders" table
      | Existing orders for | Start          |
      | ASPIRIN             | %Current Date% |
    When I select "ASPIRIN EC 1 TAB 325MG Oral Daily" from the "Existing orders for*" column in the "Orders" table
    Then the "Order Detail" pane should load within "3" seconds
    When I click the "View Submission Records" link in the "Order Detail" pane
    Then the "Order Submission Records Header" pane should load within "3" seconds
    And the "Order Submission Records" table should load
    When I select "the first item" from the "Submitted(\d)" column in the "Order Submission Records" table
    And the text "%Current Date%" should appear in the "Order Submission Records Detail" pane
    When I click the "View Route Action Output" link in the "Order Submission Records Detail" pane
    And I wait "5" seconds
    Then the "Route Output and Submission Records" window should open
    And I close the "Route Output and Submission Records" window
    And I click the "Close..Order Submission Records" button
    And I enable all the interaction checking options

  @CPOE @donotrun
  Scenario: CPOE Auto Create Favorites
    When I am on the "Admin" tab
    And I select the "Facility Group" subtab
    And I click the "CPOE Utilities" link in the "Facility Group Navigation" pane
    And I click the "AutoCreateFavorites" button
    And I wait "4" seconds
#        Then the "AutoCreateFavorites" pane should load
        #When I enter !username in the "UserName/ID" field in the "Auto-Create Favorites Search" pane
    When I enter "pkadmin" in the "UserName/ID" field in the "AutoCreateFavoritesSearch" pane
    And I click the "Search" button in the "AutoCreateFavoritesSearch" pane
        #And I select the user !username in the "Auto-Create Favorites User Search Results" pane
    And I select the user "pkadmin" in the "AutoCreateFavoritesUserSearchResults" pane
    And I click the "Add Selected Users" button in the "AutoCreate Favorites Search" pane
        #And I select the user !username in the "Auto-Create Favorites User to Edit" pane
    And I select the user "pkadmin" in the "AutoCreateFavoritesUsertoEdit" pane
    And I select "All" from the "Order Type" dropdown
#        And I select !autocreatefavesdxmltemplate from the "Favorite Config DXML Template" dropdown
#        And I enter !autocreatefavesweeks in the "Number Of Weeks" field
#        And I enter !autocreatefavesmaxfavesperdef in the "Max Favorites Per Def" field
    And I select "CPOE Auto-Create Favorites Template" from the "FavoriteConfigDXMLTemplate" dropdown
    And I enter "8" in the "NumberOfWeeks" field
    And I enter "5" in the "MaxFavoritesPerDef" field
    And I select "true" from the "Delete All Favorites" radio list
    And I click the "Yes" button in the "Question" pane if it exists
    And I click the "Run" button
     #Question pane opens twice
    And I click the "Yes" button in the "Question" pane if it exists
    And I click the "Yes" button in the "Question" pane if it exists
    And I click the "OK" button in the "Information" pane if it exists
    And I click on Refresh for the status change in AutoCreate Favorites
    And I click the "View Favorites for selected User" link in the "AutoCreateFavoritesPreferences" pane
     #commented until there are actual auto-faves created
     #Then the text "Radiology" should appear in the "ManageFavorites" pane
    Then the text "Favorites" should appear in the "ManageFavorites" pane
    When I click the "CancelAutoFav" button
     #Then the "Manage Favorites" pane should close
    And I click the "Close" button in the "AutoCreateFavorites" pane
  #Then the "Auto-CreateFavorites Preferences" pane should close
#
  @CPOE @donotrun
  Scenario: CPOE Order Definitions Export
    When I am on the "Admin" tab
    And I select the "Facility Group" subtab
    And I select "DefaultFacilityGroup" from the "Facility Group" dropdown
    And the "CPOE Preferences" pane should load
#        And I select the Facility Group
    And I click the "Order Definitions" link in the "Facility Group Navigation" pane
#        And I check the "Formulary Only" checkbox in the "CPOE Order Definition Maintenance" pane
    And I click the "Search" button in the "CPOE Order Definition Maintenance" pane
    Then the text "No Order Definitions" should not appear in the "CPOE Order Definition Maintenance" pane
    And the "CPOE Order Definitions" table should load
    When I click the "Export Data" button in the "CPOE Order Definition Maintenance" pane
    And I wait "2" seconds
    Then the "Export CPOE Order Definitions" pane should load
    When I select "csv" from the "Format" dropdown in the "Export CPOE Order Definitions" pane
    And I enter "Formularytest" in the "Destination File" field in the "Export CPOE Order Definitions" pane
    And I click the "Export" button
    And I click the "OK" button in the "Information" pane if it exists
     #And I click the "ExportCPOEOrderCancel" button in the "Export CPOE Order Definitions" pane
    Then the "PK File Download" window should open
    And I close the "PK File Download" window
    And I click the "Export CPOE Order Definitions...Download" element in the "Export CPOE Order Definitions" pane
    And I click the "CPOEFile Download" button in the "Export CPOE Order Definitions" pane
    And I handle the alert
    And I click the "ExportCPOEOrderCancel" button

# A bunch of scenarios are failing because the drug strings listed in search aren't the exact same as the strings we
#    have listed in the scenarios.
# https://jira/browse/DEV-79236
  @CPOE
  Scenario: Standard PDF routing output comparison of medication only[DEV-79236]
    Given "MOLLY DARR" is on the patient list
    And I select patient "MOLLY DARR" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Enter Orders" button
    Then the "Orders" pane should load within "1" seconds
    And I enter "Nasal Decongestant" in the "Add Order" field in the "Enter Orders" pane
#        And I select "Nasal Decongestant (PE) tablet (phenylephrine HCl) 5MG Oral" from the "NonFormulary MedOrders" list in the search results
    And I select "Nasal Decongestant (PE) tablet (phenylephrine HCl)  5MG Oral" from the "NonFormulary MedOrders" list in the search results
    And I wait "3" seconds
    And I select "Daily" from the "Frequency" multiselect in the "Edit Order" pane
    And I click the "EnterOrderOK" button in the "Edit Order" pane
    Then the "Orders" pane should load within "1" seconds
    And I Submit the Orders
#    And I select "All" from the "Order Type" menu
    And I wait "2" seconds
    And I select "Today" from the "Past Order Date" dropdown
    Then the "Orders" table should load
    When I select "Nasal Decongestant (PE) tablet (phenylephrine HCl) 5 mg Oral Daily" from the "Existing orders for" column in the "Orders" table
    And I save the Submission Record ID for the "Nasal Decongestant (PE) tablet (phenylephrine HCl) 5 mg Oral Daily" order
    Then I verify the "standard_orders" PDF output using the "StandardPDFOutput" output directory and the "ExpectedOutput" expected directory

#        [DEV-79236] - See note line 568.
  @CPOE @Demo @democpoe
  Scenario: Add Order and Validate Existing Order[DEV-79236]
#        Given I disable all the interaction checking options
    When I am on the "Admin" tab
    And I select the "Facility Group" subtab
    And I click the "CPOE Utilities" link in the "Facility Group Navigation" pane
#    And I wait up to "10" seconds for the "Interaction Checking" field of type "MISC_ELEMENT" to be visible
    Then I wait "4" seconds
    And I click the "Interaction Checking" tab
#    if it exists
    And I click the "Edit_CPOEUtilities" button
    And I wait up to "20" seconds for the "Edit Facility Group Utlity Settings Loading Icon" field of type "MISC_ELEMENT" to be invisible
    And the "Edit Facility Group Utilities Settings" pane should load
    And I edit the following settings in the "Edit Facility Group Utilities Settings" pane
      | Name                                 | Type     | Value    |
      | Non-Medication Duplicate Display     | dropdown | Disabled |
      | New Non-Medication Duplicate Display | dropdown | Disabled |
      | Medication Duplicate Display         | dropdown | Disabled |
      | New Medication Duplicate Display     | dropdown | Disabled |
      | Drug Allergy Display                 | dropdown | Disabled |
      | Contraindicated Drug Combination     | dropdown | Disabled |
      | Severe Interaction                   | dropdown | Disabled |
      | Moderate Interaction                 | dropdown | Disabled |
      | Undetermined Severity                | dropdown | Disabled |
      | Prevent Redundant Ordering           | radio    | false    |
    Then I click the "Save_EditFacility Group Utility Settings" button
    When I am on the "Patient List V2" tab
    And "ROY BLAZER" is on the patient list
    And I select patient "ROY BLAZER" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Enter Orders" button
    And I enter "aspirin chewable tablet" in the "AddOrder" field
#    And I select "Aspirin Childrens chewable tablet (aspirin)  81MG Oral" from the "NonFormulary MedOrders" list in the search results
    Then I select "Aspirin Childrens chewable tablet (aspirin)  81MG Oral" from the "NonFormulary MedOrders" list in the search results
    And I select "Daily" from the "Frequency" multiselect in the "Edit Order" pane
    And I click the "Enter Order OK" button in the "Edit Order" pane
    And I Submit the Orders
    And I select "Orders" from clinical navigation
    And I wait "2" seconds
    Then rows containing the following should appear in the "Orders" table
      | Existing orders for                                               | Start          |
      | Aspirin Childrens chewable tablet (aspirin) 81 mg Oral Daily      | %Current Date% |

  @CPOE @Demo
  Scenario: Display Allergies
    When "MOLLY DARR" is on the patient list
    And I select patient "MOLLY DARR" from the patient list
    And I select "Allergies" from clinical navigation
    And I select "All" from the "Allergy Type" menu
    Then rows containing the following should appear in the "Allergies" table
      | Allergy      | Type          | Reaction    | Severity |
      | Penicillin   | Drug          | hives       | moderate |
      | Sulfonamides | Drug          | rash        | moderate |
      | Bee sting    | Environmental | anaphylaxis | severe   |

  @CPOE @Demo
  Scenario: Display Problem List
    When "MOLLY DARR" is on the patient list
    And I select patient "MOLLY DARR" from the patient list
    And I select "Problems" from clinical navigation
    And I add "coronary;kidney;heart;copd;hypertension;acute" problems to the "MOLLY DARR" patient
    Then rows containing the following should appear in the "Problem List" table
      | Description  |
      | hypertension |
      | acute        |
      | heart        |
      | copd         |
      | coronary     |
      | kidney       |

  @CPOE @Demo @donotrun
  Scenario: Add lab order
    When "MOLLY DARR" is on the patient list
    And I select patient "MOLLY DARR" from the patient list
    And I select "Orders" from clinical navigation
    And I search for the "CBC" order
    And I select CPOE "Lab Orders" tab
    And I select "CBC" from the "Lab Orders" list in the search results
    And I search for the "Coumadin tablet" order
    And I select "Coumadin tablet (warfarin) 10mg Oral Daily" from the "NonFormulary MedOrders" list in the search results
    And I select "Provider Aware - Continue as ordered" as override reason in the "Clinical Decision Support Warnings" pane if it exists
    And I click the "CDSW...OK" button if it exists
    And I fill the mandatory order details in the "Clinical Decision Support Warnings" pane if it exists
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    And I Submit the Orders

#        [DEV-79236] - See note line 568.
#  Medications and medication orders are not showing up in 842 due to HL7s being rejected. -- HIC 3/20/19
#    https://jira/browse/DEV-79159
  @CPOE @Demo
  Scenario: DC an Order[DEV-79236][DEV-79159]
    When "MOLLY DARR" is on the patient list
    And I select patient "MOLLY DARR" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Enter Orders" button in the "Orders" pane
        #mouse over the order and click discontinue button
#    And I discontinue the order with the "carvedilol tablet 25mg Oral q12h" text in the "ExistingOrders" table
    Then I discontinue the order with the "carvedilol tablet 25mg Oral q12h" text in the "ExistingOrders" table
        #Alternate steps to discontinue an order
        #And I select "carvedilol tablet 25mg Oral q12h" in the "ExistingOrders" table
        #And I click the "Discontinue" button
    Then rows containing the following should appear in the "New Orders" table
      | New Orders                       |
      | carvedilol tablet 25mg Oral q12h |
    And I Submit the Orders
      #workaround for DEV-57113 as warning message killing execution time
    And I click the "OK" button in the "Warning" pane if it exists
    #		And I click the "Cancel" button in the "Order Submission" pane
    And I click the "Yes" button if it exists

  @CPOE @Demo
  Scenario: Select General Med Admission order set
    When "MOLLY DARR" is on the patient list
    And I select patient "MOLLY DARR" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Enter Orders" button in the "Orders" pane
    And I enter "general" in the "AddOrder" field
    And I wait "2" seconds
    And I select CPOE "All" tab
    And I select "General Medicine Admission Order Set " from the "CPOEAllOrders" list in the search results
    Then the "Order Set" pane should load
        #Data needed to be created for below steps, started working on this
#        When I check the "No Code Blue" checkbox in the "Order Set" pane
#        And I click the "OK" button in the "Warning" pane
#        And I wait "2" seconds
#        And I uncheck the "Full Code Blue" checkbox in the "Order Set" pane
#        Then I check the "No Code Blue" checkbox in the "Order Set" pane
#        And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    ##		And I select the text "Add Continuous" from the "Order Sets" pane
    ##		And I select a random row from the "SearchedNonFormularyMedOrders" table
    ##		And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    #		When I check the "acetaminophen tablet 325mg Oral Q4H" checkbox in the Order Sets pane
    #		And I wait "2" seconds
    #		And I click the "Ok" button in the "Edit Medication Order" pane if it exists
    ##		And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    #		Then the checkbox "acetaminophen Rectal Suppository 650MG Rect Q4H" should be checked in the Order Sets pane
    #		When I select the order "acetaminophen tablet 325mg Oral Q4H" from the "Order Sets" pane
    #		And the "Edit Medication Order" pane should load
    #		And I select "Q6H" from the "Frequency" multiselect in the "Edit Medication Order" pane
    #		And I click the "OK" button in the "Edit Medication Order" pane
    #		And the checkbox "acetaminophen tablet 325mg Oral Q6H" should be checked in the Order Sets pane
#        And I click the "Evidence" link in the "Order Sets" pane
#        Then the "Zynx Evidence" window should open
#        And I wait "2" seconds
#        And I close the "Zynx Evidence" window
    And I click the "CancelOrderSet" button in the "Order Set" pane
    And I wait up to "10" seconds for the "Yes" field of type "BUTTON" in the "Question" pane to be visible
    And I click the "Yes" button in the "Question" pane
    And the "Question" pane should close within "5" seconds
    And I wait "2" seconds
    And I click the "AddOrderCancel" button

  @CPOE @Demo
  Scenario: Validate Nicotine Replacement Mini Order set Opens
    When "MOLLY DARR" is on the patient list
    And I select patient "MOLLY DARR" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Enter Orders" button in the "Orders" pane
    And I enter "nicotine" in the "AddOrder" field
    And I select CPOE "All" tab
    And I select "Nicotine Replacement" from the "CPOEAllOrders" list in the search results
    And I click the "Yes" button in the "Question" pane if it exists
    And I wait up to "10" seconds for the "Order Set" field of type "PANE" to be visible
    Then the "Order Set" pane should load
    And I click the "CancelOrderSet" button in the "Order Set" pane
    And I wait up to "10" seconds for the "Yes" field of type "BUTTON" in the "Question" pane to be visible
    And I click the "Yes" button in the "Question" pane
    And I click the "AddOrderCancel" button

  @CPOE @Demo
  Scenario: Enable Interaction Severity Display
    When I am on the "Admin" tab
    And I select the "Facility Group" subtab
    And I click the "CPOE Utilities" link in the "Facility Group Navigation" pane
    And I wait up to "10" seconds for the "Interaction Checking" field of type "MISC_ELEMENT" to be visible
    And I click the "Interaction Checking" element if it exists
    And I click the "Edit_CPOEUtilities" button
    And I wait up to "20" seconds for the "Edit Facility Group Utlity Settings Loading Icon" field of type "MISC_ELEMENT" to be invisible
    And the "Edit Facility Group Utilities Settings" pane should load
    And I edit the following settings in the "Edit Facility Group Utilities Settings" pane
      | Name                             | Type     | Value                    |
      | Medication Duplicate Display     | dropdown | Popup and Require Reason |
      | New Medication Duplicate Display | dropdown | Popup and Require Reason |
      | Contraindicated Drug Combination | dropdown | Popup and Require Reason |
      | Severe Interaction               | dropdown | Popup and Require Reason |
      | Moderate Interaction             | dropdown | Popup and Require Reason |
      | Undetermined Severity            | dropdown | Popup and Require Reason |
    Then I click the "Save_EditFacility Group Utility Settings" button
        #And I enable the medication duplicate display interaction checking option
        #When I enable interaction severity display


  @CPOE @Demo @donotrun
  Scenario: Modify Coumadin and Check for Non-Critical Alert
    When "MOLLY DARR" is on the patient list
    And I select patient "MOLLY DARR" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Enter Orders" button in the "Orders" pane
    And I select "Coumadin tablet (warfarin) 10mg Oral Daily" from the "Existing orders*" column in the "Existing Orders" table
    And I wait "2" seconds
    And I click the "Modify" button in the "Order Details" pane
     And I click the "Dose Other" element
#    And I select "Other" from the "Dose" multiselect in the "Order Details" pane
    And I enter "8mg" in the "Dose Other" field in the "Order Details" pane
    And I click the "Edit Orders Ok" button in the "Order Details" pane
#        And I select "Provider Aware - Continue as ordered" as override reason in the "CDSWarnings" pane if it exists
    And I click the "CDSWarnings...OK" button if it exists
    And I fill the mandatory order details in the "Clinical Decision Support Warnings" pane if it exists
    Then rows containing the following should appear in the "New Orders" table
      | New Orders                                 |
      | Coumadin tablet (warfarin) 8mg Oral Daily  |
      | Coumadin tablet (warfarin) 10mg Oral Daily |


  @CPOE @Demo
  Scenario: Order Search Critical Warning
    When "MOLLY DARR" is on the patient list
    And I select patient "MOLLY DARR" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Enter Orders" button in the "Orders" pane
    And I enter "Lasix tablet" in the "Add Order" field
    Then I select "Lasix tablet (furosemide)  20MG Oral" from the "NonFormulary MedOrders" list in the search results
    And I fill the mandatory order details in the "Edit Order" pane
    And I click the "OK" button in the "Edit Order" pane if it exists
    And I Submit the Orders
    And I wait "2" seconds
    Then I click the "Enter Orders" button in the "Orders" pane
    When I enter "aspirin" in the "Add Order" field
    And I select "Aspirin Low Dose tablet,delayed release (aspirin)  81MG Oral" from the "NonFormulary MedOrders" list in the search results
    Then the "Order Clinical Decision Support Warnings" pane should load
    And the text "Moderate Interaction" should appear in the "Order Clinical Decision Support Warnings" pane
    When I click the "Dont Order" button in the "Order Clinical Decision Support Warnings" pane
    Then the "Order Clinical Decision Support Warnings" pane should close
    And I click the "CloseX" button if it exists
    And I click the "Add Order Cancel" button
    And I click the "Yes" button if it exists


  @CPOE @Demo
  Scenario: Formulary and Non-Formulary search list
    When "MOLLY DARR" is on the patient list
    And I select patient "MOLLY DARR" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Enter Orders" button in the "Orders" pane
    And I enter "tylenol" in the "Add Order" field
    Then there should be at least "1" item on the formulary list and at least "10" items on the non formulary list
    And I click the "CloseX" button
    And I click the "Yes" button in the "Question" pane if it exists
    And I click the "Add Order Cancel" button
    And I click the "Yes" button if it exists

  @CPOE
  Scenario: Adding a non-med order string with frequency Not Specified should not display # of times [DEV-59190]
    Given I am logged into the portal with user "pkadminv2" using the default password
    When I am on the "Admin" tab
    And I select the "Facility Group" subtab
    And I select "DefaultFacilityGroup" from the "Facility Group" dropdown
    And the "CPOE Preferences" pane should load
    And I click the "Order Definitions" link in the "FacilityGroupNavigation" pane
    And I wait up to "10" seconds for the "Order Name" field of type "TEXT_FIELD" in the "CPOE Order Definition Maintenance" pane to be visible
    And I enter "CBC" in the "Order Name" field in the "CPOE Order Definition Maintenance" pane
    And I click the "Search" button in the "CPOE Order Definition Maintenance" pane
    And I select "the first item" in the "CPOEOrderDefSearchResults" table
    And I click the "Edit" button in the "CPOEOrderDefinitionDetail" pane
    And I wait "2" seconds
    And I click the "View Edit Order String" button in the "EditCPOEOrderDefinition" pane
    And I wait "2" seconds
    And I click the "CBC today" link in the "OrderStringMaintenance" pane
    And I wait "2" seconds
    And I select "Not Specified" from the "FrequencyList" multiselect in the "EditOrderString" pane
    Then the following fields should not display in the "EditOrderString" pane
      | Name    | Type    |
      | Oftimes | element |
    And I click the "Cancel" button in the "EditOrderString" pane
    And I click the "Cancel" button in the "OrderStringMaintenance" pane
    And I click the "Cancel" button in the "EditCPOEOrderDefinition" pane

  @CPOE
  Scenario: Adding a non-med order string with frequency Not Specified should not display # of times [DEV-59187]
    Given I am logged into the portal with user "pkadminv2" using the default password
    Given I am on the "Admin" tab
    When I select the "Facility Group" subtab
    And I select "DefaultFacilityGroup" from the "Facility Group" dropdown
    And the "CPOE Preferences" pane should load
    And I click the "Order Sets" link in the "Facility Group Navigation" pane
    And I enter "DISCHARGE ORDER SET" in the "OrderSet Name" field
    And I click the "Search CPOE Order Set Maintenance" button
    And I select "DISCHARGE ORDER SET" in the "CPOE Order Set" table
    And I click the "Edit CPOE Order Set Maintenance" button
    And I click "OK" in the confirmation box if it exists
    And I wait "2" seconds
    When I click the "Content" element
    And I drag the "Order Component" to section field in Edit order set pane
    And I wait up to "10" seconds for the "Order Search" field of type "TEXT_FIELD" to be visible
    And I enter "CBC today" in the "Order Search" field
    And I wait up to "10" seconds for the "All Orders" field of type "MISC_ELEMENT" to be visible
    When I click the "All Orders" element
    And I select "the first item" in the "CPOEOrderTable" table
    Then the "CPOEOrderPrototype" pane should load
    And I select "Not Specified" from the "FrequencyList" multiselect in the "CPOEOrderPrototypeContents" pane
    Then the following fields should not display in the "CPOEOrderPrototypeContents" pane
      | Name    | Type    |
      | Oftimes | element |
    And I click the "Cancel CPOEOrderPrototype" button
    And I click the "Close EditOrderSet" button
    And I click the "OrderSetYes" button

  @DevIssue @CPOE
  Scenario: CPOE Edit Order Definition Validation [AUTO-182][DEV-59624]
    When I am on the "Admin" tab
    And I select the "Facility Group" subtab
    And I click the "Order Definitions" link in the "FacilityGroupNavigation" pane
    And I enter "Novolin 70/30" in the "Order Name" field in the "CPOE Order Definition Maintenance" pane
    And I click the "Search" button in the "CPOE Order Definition Maintenance" pane
    And I select "the first item" in the "CPOEOrderDefSearchResults" table
    And I click the "Edit" button in the "CPOEOrderDefinitionDetail" pane
    And I wait "2" seconds
    And I click the "View Edit Order String" button in the "Edit CPOE Order Definition" pane
    And I click the "Cancel" button in the "Order String Maintenance" pane
    Then the following fields should display in the "Edit CPOE Order Definition" pane
      | Name   | Type   |
      | Save   | button |
      | Cancel | button |
    And I click the "Cancel" button in the "Edit CPOE Order Definition" pane

#        [DEV-79236] - See note line 568.
  @DevIssue @CPOE
  Scenario: Only change mnemonics across order defs with same Unit of Dosing [AUTO-183][DEV-59517][DEV-79236][DEV-79236]
    And there should not be any unfinished orders
    When "MOLLY DARR" is on the patient list
    And I select patient "MOLLY DARR" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Enter Orders" button in the "Orders" pane
    And I enter "Corlanor" in the "Add Order" field in the "Enter Orders" pane
#    And I select "Zetia tablet (ezetimibe)  10MG Oral" from the "NonFormulary MedOrders" list in the search results
    Then I select "Corlanor tablet (ivabradine)  5MG Oral" from the "NonFormulary MedOrders" list in the search results
    And I wait "3" seconds
    And I click the "Dose Other" element
#    And I select "Other" from the "Dose" multiselect in the "Edit Order" pane
    And I enter "50MG" in the "Dose Other" field in the "Edit Order" pane
    And I select "Daily" from the "Frequency" multiselect in the "Edit Order" pane
    And I enter "test order" in the "Special Instructions" field in the "Edit Order" pane
    And I click the "Enter Order OK" button in the "Edit Order" pane
    And I Submit the Orders
    And I select "All" from the "Order Type" menu
#    And I select "Today" from the "Past Order Date" dropdown
    Then the following rows should appear in the "Orders" clinical table
      | Existing orders for*                                      | Start          |
      | Corlanor tablet (ivabradine) 50MG Oral Daily              | %Current Date% |


  @CPOE
  Scenario: DEV-58642:Re-order Buttons in Med Rec to be Consistent with CPOE
    #Validating Cancel button should be at last
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Card Group" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Adm Med Rec" button in the "Orders" pane
    Then the "Admission Medication Reconciliation" pane should load
    And The element "MedRecCancel" of type "button" should present in the "Admission Medication Reconciliation" pane
    And I click the "MedRecCancel" button
    And I click the "Yes" button in the "Question" pane
    And I click the "Transfer Order Rec" button in the "Orders" pane
    And I wait "5" seconds
    And The element "MedRecCancel" of type "button" should present in the "Transfer Order Reconciliation" pane
    And I click the "MedRecCancel" button
    And I click the "Yes" button in the "Question" pane
    And I click the "Discharge Med Rec" button in the "Orders" pane
    Then the "Discharge Medication Reconciliation" pane should load
    And I wait "5" seconds
    And The element "MedRecCancel" of type "button" should present in the "Discharge Medication Reconciliation" pane
    And I click the "MedRecCancel" button
    And I click the "Yes" button in the "Question" pane


  @CPOE
  Scenario: 8.4.0:DEV-71924-Remove everything OHA and remove medications from auto-generation of favorites functions
    Given I am logged into the portal with user "pkadminv2" using the default password
    When I am on the "Admin" tab
    And I select the "Facility Group" subtab
    And I click the "CPOE Utilities" link in the "Facility Group Navigation" pane
    And I click the "AutoCreateFavorites" button
    And I wait for loading to complete
    Then the following options should not be available in the "Order Type" dropdown
      | Medication |
    And I click the "Close" button in the "AutoCreateFavorites" pane
    And I select the "Tracking/Reporting" subtab
    And I click the "GlobalTasks" element in the "Tracking Report" pane
    Then the following options should be available in the "Task" dropdown
      | FAC.FAC |


  @CPOE
  Scenario: Prevent Institutions from enabling clinicals-only Medications and CPOE medications [DEV-67118]
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Patient ListV2" tab
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "New Results" from clinical navigation
    And I click the "Options" button in the "Patient Summary" pane
    And the "Display Options" pane should load
    Then the "Display Options" table should have "1" row containing the text "Medications"
    And I click the "OptionsOK" button in the "Display Options" pane


  @CPOE
  Scenario: Enforce Military Time format when adding new Frequency Definition [DEV-74879]
    Given I am logged into the portal with user "pkadminv2" using the default password
    When I am on the "Admin" tab
    And I select the "Facility Group" subtab
    And I click the "Med Frequency Definition" link in the "Facility Group Navigation" pane
    And I wait up to "5" seconds for the "Add Med Frequency Definition" field of type "BUTTON" in the "Med Frequency Definition" pane to be clickable
    Then I click the "Add Med Frequency Definition" button in the "Med Frequency Definition" pane
    And I enter "TestMedFreqDef" in the "CPOE Abbreviation" field
    And I enter "Test Med Frequency Definition" in the "CPOE Name" field
    And I enter "XX" in the "Num Hours To First Dose" field
    And I click the "TAB" key in the "Num Hours To First Dose" rich text field
    And I wait up to "5" seconds for the "OK" field of type "BUTTON" in the "Warning Message" pane to be clickable
    Then the "Warning Message" pane should appear with the text "Invalid number. Entered value must be a number."
    And I click the "OK" button in the "Warning Message" pane
    And I enter "02" in the "Num Hours To First Dose" field
          #entering non military format and verifying the warning message
    And I enter "630" in the "MedTimes" field
    And I enter "730" in the "NonMedTimes" field
    And I click the "Save" button in the "AddMedFrequencyDefinition" pane
    And I wait up to "5" seconds for the "OK" field of type "BUTTON" in the "Warning Message" pane to be clickable
    Then the "Warning Message" pane should appear with the text "Invalid Time format. Entered Value must be in 24 hour format (0900,1300,1800)."
    And I click the "OK" button in the "Warning Message" pane
           #entering non military format and verifying the warning message
    And I enter "6:30" in the "MedTimes" field
    And I enter "7:30" in the "NonMedTimes" field
    And I click the "Save" button in the "AddMedFrequencyDefinition" pane
    And I wait up to "5" seconds for the "OK" field of type "BUTTON" in the "Warning Message" pane to be clickable
    Then the "Warning Message" pane should appear with the text "Invalid Time format. Entered Value must be in 24 hour format (0900,1300,1800)."
    And I click the "OK" button in the "Warning Message" pane
          #military format with space before and/or after comma is not valid
    And I enter "0630, 1200" in the "MedTimes" field
    And I enter "0730, 1300" in the "NonMedTimes" field
    And I click the "Save" button in the "AddMedFrequencyDefinition" pane
    And I wait up to "5" seconds for the "OK" field of type "BUTTON" in the "Warning Message" pane to be clickable
    Then the "Warning Message" pane should appear with the text "Invalid Time format. Entered Value must be in 24 hour format (0900,1300,1800)."
    And I click the "OK" button in the "Warning Message" pane
          #entering comma seperated military values
    And I enter "0630,1200" in the "MedTimes" field
    And I enter "0730,1300" in the "NonMedTimes" field
    And I click the "Save" button in the "AddMedFrequencyDefinition" pane
    Then the "Warning Message" pane should not appear with the text "Invalid Time format. Entered Value must be in 24 hour format (0900,1300,1800)."


  @CPOE
  Scenario: Enforce Military Time format when editing Frequency Definition [DEV-74879]
    #dependant on previous scenario as Med frequency definition should be created for editing
    Given I am logged into the portal with user "pkadminv2" using the default password
    When I am on the "Admin" tab
    And I select the "Facility Group" subtab
    And I click the "Med Frequency Definition" link in the "Facility Group Navigation" pane
    And I wait up to "5" seconds for the "Add Med Frequency Definition" field of type "BUTTON" in the "Med Frequency Definition" pane to be clickable
    And I enter "TestMedFreqDef" in the "Frequency Definition Field Abbrev/Name" field
    And I click the "Search" button in the "Med Frequency Definition" pane
    And I select "TestMedFreqDef" in the "CPOEMedFrequencySearch" table
    And I click the "Edit" button in the "Med Frequency Definition Detail" pane
    And I enter "XX" in the "Num Hours To First Dose" field
    And I click the "TAB" key in the "Num Hours To First Dose" rich text field
    And I wait up to "5" seconds for the "OK" field of type "BUTTON" in the "Warning Message" pane to be clickable
    Then the "Warning Message" pane should appear with the text "Invalid number. Entered value must be a number."
    And I click the "OK" button in the "Warning Message" pane
    And I enter "03" in the "Num Hours To First Dose" field
      #entering non military format and verifying the warning message
    And I enter "830" in the "MedTimes" field
    And I enter "930" in the "NonMedTimes" field
    And I click the "Save" button in the "AddMedFrequencyDefinition" pane
    And I wait up to "5" seconds for the "OK" field of type "BUTTON" in the "Warning Message" pane to be clickable
    Then the "Warning Message" pane should appear with the text "Invalid Time format. Entered Value must be in 24 hour format (0900,1300,1800)."
    And I click the "OK" button in the "Warning Message" pane
     #entering non military format and verifying the warning message
    And I enter "8:30" in the "MedTimes" field
    And I enter "9:30" in the "NonMedTimes" field
    And I click the "Save" button in the "AddMedFrequencyDefinition" pane
    And I wait up to "5" seconds for the "OK" field of type "BUTTON" in the "Warning Message" pane to be clickable
    Then the "Warning Message" pane should appear with the text "Invalid Time format. Entered Value must be in 24 hour format (0900,1300,1800)."
    And I click the "OK" button in the "Warning Message" pane
      #military format with space before and/or after comma is not valid
    And I enter "0830, 1400" in the "MedTimes" field
    And I enter "0930, 1500" in the "NonMedTimes" field
    And I click the "Save" button in the "AddMedFrequencyDefinition" pane
    And I wait up to "5" seconds for the "OK" field of type "BUTTON" in the "Warning Message" pane to be clickable
    Then the "Warning Message" pane should appear with the text "Invalid Time format. Entered Value must be in 24 hour format (0900,1300,1800)."
    And I click the "OK" button in the "Warning Message" pane
      #entering comma seperated military values
    And I enter "0830,1400" in the "MedTimes" field
    And I enter "0930,1500" in the "NonMedTimes" field
    And I click the "Save" button in the "AddMedFrequencyDefinition" pane
    Then the "Warning Message" pane should not appear with the text "Invalid Time format. Entered Value must be in 24 hour format (0900,1300,1800)."
      #deleting the med definition frequency after validation
    And I click the "Delete" button in the "Med Frequency Definition Detail" pane
    And I click the "Yes" button in the "Question" pane


  @CPOE
  Scenario: Solr Search URL of a mobilizer should point to itself without necessity of configuring it [DEV-72125]
    Given I am logged into the portal with user "pkadminv2" using the default password
    When I am on the "Admin" tab
    And I select the "Facility Group" subtab
    And I click the "CPOE Preferences" link in the "Facility Group Navigation" pane
    And I wait up to "10" seconds for the "Edit CPOE Preferences" field of type "BUTTON" to be visible
    When I click the "Edit CPOE Preferences" button
    And I wait "5" seconds
    And The "Solr Search URL" "TEXT_FIELD" should be disabled
    And the value in the "Solr Search URL" field in the "Edit Facility Group Preferences" pane should be "%SolrSearchURL%"
    And I click the "Cancel Edit Facility Group Preferences" button


  @CPOE
  Scenario: 8.4.0: DEV-58756-Do Not Allow Field to be both "Hidden from Provider" and "Required for Ordering Provider"
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Admin" tab
    And I select the "Facility Group" subtab
    And I click the "Field Sets" link in the "Facility Group Navigation" pane
    And I click the "Add Field Set" button
    Then the "Add CPOE Field Set" pane should load
    And I enter "Test" in the "CPOE Field Set Abbreviation" field
    And I enter "TestCT" in the "CPOE Field Set Name" field
    And I click the "Add Fields" element
    Then the "CPOE Fields" pane should load
    And I enter "CT" in the "Field Abbrev/Name" field
    And I click the "CPOEFieldSearch" button
    And I check the "CT" checkbox
    And I click the "CPOEFieldOK" button
    And I check the following checkboxes
      | Required For Ordering Provider |
      | Hidden From Provider           |
    And I click the "CPOE FieldSet Save" button
    Then the following text should appear in the "Information" pane
      | Field: CTSCAN can't be both Hidden from Provider and Required for Ordering Provider. |
    And I click the "Information OK" button in the "Information" pane
    And I click the "CPOE FieldSet Cancel" button

  @CPOE
  Scenario: Clear Unfinished Order
    Given there should not be any unfinished orders