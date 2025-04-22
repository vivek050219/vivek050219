@CPOEInteractionChecking
Feature: CPOE Interaction Checking

  Background:
    Given I am logged into the portal with user "cadmin" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    And I use the API to create a patient list named "CPOEInteraction" owned by "cadmin" with the following parameters
      | Type   | Name            | Value      |
      | Filter | Medical Service | Card Group |
    And I click the "Refresh Patient List" button
    And I select "CPOEInteraction" from the "Patient List" menu
    And there should not be any unfinished orders

  Scenario: Pre-requisite steps
    Given I am on the "Admin" tab
    And I select the "Facility Group" subtab
    And I click the "CPOE Preferences" link in the "Facility Group Navigation" pane
    When I click the "Edit CPOE Preferences" button
    And I wait "2" seconds
    And I enter "%SolrURL%" in the "Solr Master URL" field
    #Solr Indexer URL is no longer editable as of 8.4.0: DEV-72125
    #And I enter "%SolrURL%" in the "Solr Indexer URL" field
    And I select "false" from the "Incomplete Admission Reconciliation" radio list
    And I select "false" from the "Incomplete Discharge Reconciliation" radio list
    And I click the "Save Edit Facility Group Preferences" button
    Then the "Edit Facility Group Preferences" pane should close
    #TODO: RE-enable when DEV-72790 is fixed
    When I click the "CPOE Utilities" link in the "Facility Group Navigation" pane
    And I click the "OHA/SearchIndex" element
#    And I check the "OHA Checkbox" checkbox
    And I click the "Run Search Index" button
    And I uncheck the "Run Incremental Update" checkbox
    And I click the "Run the Indexer" button
    And I click the "InformationOK" button if it exists
    Then the text "Failed" should not appear in the "Order History Analyzer" pane
    When I am on the "Patient List V2" tab
    Given there are no patients on the patient list
    When I am on the "Admin" tab
    And I select the "User" subtab
    And I search for the user "cadmin"
    And I select the user "cadmin"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "CPOE" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I edit the following user settings and I click save
      |Page |Name                     |Type  |Value |
      |CPOE |Can Enter Orders         |radio |true  |
      |CPOE |Enable Admission Med Rec |radio |true  |
      |CPOE |Enable Discharge Med Rec |radio |true  |
      |CPOE |Add Home Medications     |radio |true  |
      |CPOE |Continue Home Meds       |radio |true  |
   #This is to Enable CPOE settings under Location
    And I select the "Location" subtab
    And I select the "PKHospital-Verve" facility
    And I click the "Edit Location" button
    And I wait "2" seconds
    And the "Edit Location Prefs" pane should load
    And I select "true" from the "CPOE Enabled" radio list
    And I check the "Admission" checkbox
    And I check the "Discharge" checkbox
    And I check the "Transfer" checkbox
   # Disable Allow Hold for Admission
    And I select "false" from the "Allow Hold for Admission" radio list
    And I select "true" from the "Enable Continue Home Meds" radio list
   #Delete if any Order Definition defined
    And I click the "Delete Order Definition" image if it exists
    And I click the "Save Edit Location Pref" button

  Scenario: No Duplicate Interaction display between two New Radiology Orders
    When I am on the "Admin" tab
    And I select the "Facility Group" subtab
    And I click the "CPOE Utilities" link in the "Facility Group Navigation" pane
    And I click the "Interaction Checking" element if it exists
    And I click the "Edit_CPOEUtilities" button
    And I wait up to "20" seconds for the "Edit Facility Group Utlity Settings Loading Icon" field of type "MISC_ELEMENT" to be invisible
    And the "Edit Facility Group Utilities Settings" pane should load
    And I edit the following settings in the "Edit Facility Group Utilities Settings" pane
      |Name                                   |Type     |Value     |
      |Non-Medication Duplicate Display       |dropdown |Disabled  |
      |New Non-Medication Duplicate Display   |dropdown |Disabled  |
      |Medication Duplicate Display           |dropdown |Disabled  |
      |New Medication Duplicate Display       |dropdown |Disabled  |
      |Drug Allergy Display                   |dropdown |Disabled  |
      |Contraindicated Drug Combination       |dropdown |Disabled  |
      |Severe Interaction                     |dropdown |Disabled  |
      |Moderate Interaction                   |dropdown |Disabled  |
      |Undetermined Severity                  |dropdown |Disabled  |
      |Prevent Redundant Ordering             |radio    |false     |
    Then I click the "Save_EditFacility Group Utility Settings" button
#    When I disable the non medication duplicate display interaction checking option
#    And I disable the medication duplicate display interaction checking option
    And I enable allow multiple diets with same start date
#    And I disable prevent ordering of redundant lab tests
    And I am on the "Patient List V2" tab
    And "TEST1 CPOEPAT1" is on the patient list
    And I select patient "TEST1 CPOEPAT1" from the patient list
    And I select "Orders" from clinical navigation
    And I search for the "ABDOMINAL" order
    And I select CPOE "Radiology Orders" tab
    And I select "RadOrdrGrp ABDOMINAL AORTA" from the "Radiology Orders" list in the search results
    And I wait "2" seconds
    And I enter "R10.11" reason for the exam in the "Edit Order" pane
    And I enter "RadOrdrGrp ABDOMINAL AORTA" in the "Add Order" field in the "Enter Orders" pane
    And I select CPOE "Radiology Orders" tab
    And I select "the first item" from the "Radiology Orders" list in the search results
    Then the "Order Clinical Decision Support Warnings" pane should not load
    And I enter "R10.11" reason for the exam in the "Edit Order" pane
    And I Submit the Orders
    And rows containing the following should appear in the "Orders" table
      |Existing orders* |Start          |
      |ABDOMINAL AORTA  |%Current Date% |

  Scenario Outline: No Duplicate Interaction display between two New Nursing/Other/lab/Diet Orders
    When I am on the "Patient List V2" tab
    And "TEST2 CPOEPAT2" is on the patient list
    And I select patient "TEST2 CPOEPAT2" from the patient list
    And I select "Orders" from clinical navigation
    And I search for the "<Order>" order
    And I wait "1" second
    And I select CPOE "<Order Tab>" tab
    And I select "the first item" from the "<Search list>" list in the search results
    And I enter "<Order>" in the "Add Order" field in the "Enter Orders" pane
    And I wait "1" second
    And I select CPOE "<Order Tab>" tab
    And I select "the first item" from the "<Search list>" list in the search results
    Then the "Order Clinical Decision Support Warnings" pane should not load
    And I Submit the Orders

    Examples:
      | Order Text     | Order Tab      | Order          | Search list    |
      | Comfort Care   | Nursing Orders | Comfort Care   | Nursing Orders |
      | HOLTER MONITOR | Other Orders   | HOLTER MONITOR | Other Orders   |
      | BRAT DIET      | Diet Orders    | BRAT DIET      | Diet Orders    |
      | AMMONIA        | Lab Orders     | AMMONIA today  | Lab Orders     |

  Scenario: No Duplicate interaction display between two new Radiology orders from AMR
    When "TEST3 CPOEPAT3" is on the patient list
    And I select patient "TEST3 CPOEPAT3" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Adm Med Rec" button in the "Orders" pane
    Then the "Admission Medication Reconciliation" pane should load
    When I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
##    Then the "Search for order" pane should load within "2" seconds
    When I enter "aspirin Rectal" in the "Search for order" field in the "Search for order" pane
    And I select "aspirin Rectal Suppository  300MG" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Search for order" pane if it exists
    And I select the "Continue" radio in the row with "New: aspirin Rectal Suppository 300 mg Rect Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I click the "Add" link in the "Hospital OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "eye" in the "Hospital Search For Order" field
    And I select CPOE "Radiology Orders" tab in the "Search for order" pane
    And I select "RadOrdrGrp FOREIGN BODY EYE ONLY" from the "Searched Radiology Orders" list in the search results
    And I enter "M53.1" reason for the exam in the "Edit Medication Order" pane
    And I click the "Add" link in the "Hospital OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "RadOrdrGrp FOREIGN BODY EYE ONLY" in the "Hospital Search For Order" field in the "Search for order" pane
    And I select CPOE "Radiology Orders" tab in the "Search for order" pane
    And I select "the first item" from the "Searched Radiology Orders" list in the search results
    And I enter "M53.1" reason for the exam in the "Edit Medication Order" pane
    Then the "Clinical Decision Support Warnings" pane should not load
    When I reconcile and Submit the Orders
    Then the "Admission Medication Reconciliation" pane should close

  Scenario Outline: No Duplicate interaction display between two New Nursing/Other/Diet orders from AMR
    When "TEST4 CPOEPAT4" is on the patient list
    And I select patient "TEST4 CPOEPAT4" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Adm Med Rec" button in the "Orders" pane
    Then the "Admission Medication Reconciliation" pane should load
    When I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    Then the "Search for order" pane should load
    When I enter "<AMR Order>" in the "Search for order" field in the "Search for order" pane
    And I select "<AMR Order Search>" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Search for order" pane if it exists
    And I select the "Continue" radio in the row with "<Med Order Text>" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I click the "Add" link in the "Hospital OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "<Order>" in the "Hospital Search For Order" field
    And I wait "2" seconds
    And I select CPOE "<Order Tab>" tab in the "Search for order" pane
    And I select "the first item" from the "<Search list>" list in the search results
    And I wait "2" second
    And I click the "Add" link in the "Hospital OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "<Order>" in the "Hospital Search For Order" field
    And I wait "2" seconds
    And I select CPOE "<Order Tab>" tab in the "Search for order" pane
    And I select "the first item" from the "<Search list>" list in the search results
    Then the "Clinical Decision Support Warnings" pane should not load
    And the "Medication Reconciliation" table should have at least "1" row containing the text "<Order>"
    When I reconcile and Submit the Orders
    Then the "Admission Medication Reconciliation" pane should close

    Examples:
      | AMR Order                            | AMR Order Search                                 | Order Text           | Order Tab      | Order                         | Search list             | Med Order Text                                              |
      | acetaminophen Rectal                 | acetaminophen Rectal Suppository  120MG Rect     | Bed                  | Nursing Orders | Bed rest                      | Searched Nursing Orders | New: acetaminophen Rectal Suppository 120 mg Rect Daily     |
      | Calan tablet (verapamil)  80mg Oral  | Calan tablet (verapamil)  80MG Oral              | RESPIRATORY          | Other Orders   | RESPIRATORY THERAPY TREATMENT | Searched Other Orders   | New: Calan tablet (verapamil) 80 mg Oral Daily              |
      | Feldene                              | Feldene capsule (piroxicam)  10MG Oral           | SURGICAL LIQUID DIET | Diet Orders    | SURGICAL LIQUID DIET          | Searched Diet Orders    | New: Feldene capsule (piroxicam) 10 mg Oral Daily           |
      | Heartburn Relief tablet (cimetidine) | Heartburn Relief tablet (cimetidine)  200MG Oral | AMYLASE              | Lab Orders     | AMYLASE toda                  | Searched Lab Orders     | New: Heartburn Relief tablet (cimetidine) 200 mg Oral Daily |

  Scenario: No Duplicate interaction display between two new Radiology orders from DMR [DEV-69419]
    When "TEST5 CPOEPAT5" is on the patient list
    And I select patient "TEST5 CPOEPAT5" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Discharge Med Rec" button in the "Orders" pane
    Then the "Discharge Medication Reconciliation" pane should load
    When I click the "here" link if it exists in the "Discharge Medication Reconciliation" pane
    And I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "RadOrdrGrp KIDNEY FLOW FUNCTION" in the "Discharge Search For Order" field in the "Search for order" pane
    And I select CPOE "Radiology Orders" tab in the "Search for order" pane
    And I select "RadOrdrGrp KIDNEY FLOW FUNCTION" from the "Searched Radiology Orders" list in the search results
    And I enter "Q60.2" reason for the exam in the "Edit Medication Order" pane
    And I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table
    And I enter "KIDNEY FLOW FUNCTION" in the "Discharge Search For Order" field in the "Search for order" pane
    And I select CPOE "Radiology Orders" tab in the "Search for order" pane
    And I select "the first item" from the "Searched Radiology Orders" list in the search results
    And I enter "Q60.2" reason for the exam in the "Edit Medication Order" pane
    Then the "Clinical Decision Support Warnings" pane should not load
    When I reconcile and Submit the Orders
    Then the "Discharge Medication Reconciliation" pane should close

  Scenario Outline: No Duplicate interaction display between two new Lab/Others/Nursing orders from DMR [DEV-59378] [DEV-69419]
    When "TEST6 CPOEPAT6" is on the patient list
    And I select patient "TEST6 CPOEPAT6" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Discharge Med Rec" button in the "Orders" pane
    Then the "Discharge Medication Reconciliation" pane should load
    When I click the "here" link if it exists in the "Discharge Medication Reconciliation" pane
    And I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "<Order>" in the "Discharge Search For Order" field in the "Search for order" pane
    And I select CPOE "<Order Tab>" tab in the "Search for order" pane
    And I select "the first item" from the "<Search list>" list in the search results
    And I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table
    And I enter "<Order>" in the "Discharge Search For Order" field in the "Search for order" pane
    And I select CPOE "<Order Tab>" tab in the "Search for order" pane
    And I select "the first item" from the "<Search list>" list in the search results
    Then the "Clinical Decision Support Warnings" pane should not load
    When I reconcile and Submit the Orders
    Then the "Discharge Medication Reconciliation" pane should close

    Examples:
      | Order Tab      | Order Text | Order               | Search list             |
      | Other Orders   | Chest      | Chest Physiotherapy | Searched Other Orders   |
      | Nursing Orders | AccuChecks | AccuChecks          | Searched Nursing Orders |
      | Lab Orders     | BLOOD      | BLOOD CULTURE today | Searched Lab Orders     |
      | Diet Orders    | BRAT DIET  | BRAT DIET           | Searched Diet Orders    |

  Scenario: No Duplicate Interaction display between two New Radiology CHMOrders
    When "TEST5 CPOEPAT5" is on the patient list
    And I select patient "TEST5 CPOEPAT5" from the patient list
    And I select "Orders" from clinical navigation
   # Add any home medication AMR in order to continue in CHM page
    And I click the "Adm Med Rec" button in the "Orders" pane
    Then the "Admission Medication Reconciliation" pane should load
    When I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    Then the "Search for order" pane should load within "2" seconds
    When I enter "aspirin Rectal" in the "Search for order" field in the "Search for order" pane
    And I select "aspirin Rectal Suppository 300MG" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with "aspirin Rectal Suppository 300 mg Rect Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    When I reconcile and Submit the Orders
    Then the "Admission Medication Reconciliation" pane should close
    When I click the "Continue Home Meds" button
    And I click the "OK" button in the "Warning" pane if it exists
    Then the "Continue Home Medication" pane should load
    When I click the "Add" link in the "Hospital OrdersAdd" cell header in the "Medication Reconciliation" table
    And I enter "ABDOMINAL" in the "Hospital Search For Order" field in the "Continue Home Medication" pane
    And I select CPOE "Radiology Orders" tab in the "Search for order" pane
    And I select "ABDOMINAL AORTA" from the "Searched Radiology Orders" list in the search results
    And I enter "S35.00XD" reason for the exam in the "Continue Home Medication" pane
    And I click the "Add" link in the "Hospital OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "ABDOMINAL AORTA" in the "Hospital Search For Order" field in the "Continue Home Medication" pane
    And I select CPOE "Radiology Orders" tab in the "Search for order" pane
    And I select "the first item" from the "Searched Radiology Orders" list in the search results
    Then the "Clinical Decision Support Warnings" pane should not load
    When I enter "S35.00XD" reason for the exam in the "Continue Home Medication" pane
    And I reconcile and Submit the Orders
    Then the "Continue Home Medication" pane should close

  Scenario Outline: No Duplicate Interaction display between two New Nursing/Other/Lab/Diet CHMOrders
    When "TEST4 CPOEPAT4" is on the patient list
    And I select patient "TEST4 CPOEPAT4" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Continue Home Meds" button
    And I click the "OK" button in the "Warning" pane if it exists
#    Then the "Continue Home Medication" pane should load
    When I click the "Add" link in the "Hospital OrdersAdd" cell header in the "Medication Reconciliation" table
    And I enter "<Order>" in the "Hospital Search For Order" field in the "Continue Home Medication" pane
    And I select CPOE "<Order Tab>" tab in the "Search for order" pane
    And I select "the first item" from the "<Search list>" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    And I click the "Add" link in the "Hospital OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "<Order Text>" in the "Hospital Search For Order" field in the "Continue Home Medication" pane
    And I select CPOE "<Order Tab>" tab in the "Search for order" pane
    And I select "the first item" from the "<Search list>" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    Then the "Clinical Decision Support Warnings" pane should not load
    And I reconcile and Submit the Orders
    Then the "Continue Home Medication" pane should close

    Examples:
      | Order Text         | Order Tab      | Order              | Search list             |
      | Circulation Checks | Nursing Orders | Circulation Checks | Searched Nursing Orders |
      | PULSE OXIMETRY     | Other Orders   | PULSE OXIMETRY     | Searched Other Orders   |
      | SOFT LOW FAT DIET  | Diet Orders    | SOFT LOW FAT DIET  | Searched Diet Orders    |
      | CALCIUM today      | Lab Orders     | CALCIUM today      | Searched Lab Orders     |

  Scenario: Duplicate Interaction display between New and Existing Radiology Orders
    When I am on the "Admin" tab
    And I select the "Facility Group" subtab
    And I click the "CPOE Utilities" link in the "Facility Group Navigation" pane
    And I click the "Interaction Checking" element if it exists
    And I click the "Edit_CPOEUtilities" button
    And I wait up to "20" seconds for the "Edit Facility Group Utlity Settings Loading Icon" field of type "MISC_ELEMENT" to be invisible
    And the "Edit Facility Group Utilities Settings" pane should load
    And I edit the following settings in the "Edit Facility Group Utilities Settings" pane
      |Name                                   |Type     |Value                     |
      |Non-Medication Duplicate Display       |dropdown |Popup and Require Reason  |
      |New Non-Medication Duplicate Display   |dropdown |Popup and Require Reason  |
      |Prevent Redundant Ordering             |radio    |false                     |
    Then I click the "Save_EditFacility Group Utility Settings" button
#    Given I enable the non medication duplicate display interaction checking option
    And I disable allow multiple diets with same start date
#    And I disable prevent ordering of redundant lab tests
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    And I select "CPOEInteraction" from the "Patient List" menu
    And "TEST2 CPOEPAT2" is on the patient list
    And I select patient "TEST2 CPOEPAT2" from the patient list
    And I select "Orders" from clinical navigation
    And I search for the "BONE SURVEY" order
    And I select CPOE "Radiology Orders" tab
    And I select "RadOrdrGrp BONE SURVEY" from the "Radiology Orders" list in the search results
    And I enter "M86.10" reason for the exam in the "EditOrder" pane
    And I Submit the Orders
    And I search for the "BONE SURVEY" order
    And I select CPOE "Radiology Orders" tab
    And I select "the first item" from the "Radiology Orders" list in the search results
    Then the following text should appear in the "Order Clinical Decision Support Warnings" pane
      |Duplicate                                        |
      |There is already a "BONE SURVEY" on this patient.|
    And I click the "Dont Order" button in the "OrderClinical Decision Support Warnings" pane
    And I click the "AddOrder Cancel" button

  Scenario Outline: Duplicate Interaction display between New and Existing Nursing/Other Orders[DEV-46425]
    When "TEST5 CPOEPAT5" is on the patient list
    And I select patient "TEST5 CPOEPAT5" from the patient list
    And I select "Orders" from clinical navigation
    And I search for the "<Order Text>" order
    And I select CPOE "<Order Tab>" tab
    And I select "the first item" from the "<Search list>" list in the search results
    And I Submit the Orders
    And I click the "Enter Orders" button
    And I click the "OK" button in the "Warning" pane if it exists
    And I search for the "<Order Text>" order
    And I select CPOE "<Order Tab>" tab
    And I select "the first item" from the "<Search list>" list in the search results
    And I wait "2" seconds
#    Then the text "Duplicate" should appear in the "Order Clinical Decision Support Warnings" pane
    Then the text "Duplicate" should appear in the "Duplicate Order Warning" pane
    And the text "There is already a "<Order Text>" on this patient." should appear in the "Interaction Popup" section in the "Duplicate Order Warning" pane
    And I click the "Dont Order" button in the "Duplicate Order Warning" pane
    And I click the "AddOrder Cancel" button

    Examples:
      |Order Text     |Order Tab        |Order                |Search list      |
      |Comfort Care   |Nursing Orders   |Comfort Care         |Nursing Orders   |
      |HOLTER MONITOR |Other Orders     |HOLTER MONITOR       |Other Orders     |

  Scenario: Duplicate interaction display between New and Existing Radiology orders from AMR [DEV-59400]
    When I am on the "Patient List V2" tab
    And the patient list is maximized
    And I select "CPOEInteraction" from the "Patient List" menu
    And "TEST8 CPOEPAT8" is on the patient list
    And I select patient "TEST8 CPOEPAT8" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Adm Med Rec" button in the "Orders" pane
    Then the "Admission Medication Reconciliation" pane should load
    When I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    Then the "Search for order" pane should load within "2" seconds
    When I enter "aspirin Rectal" in the "Search for order" field in the "Search for order" pane
    And I select "aspirin Rectal Suppository  300MG" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with "New: aspirin Rectal Suppository 300 mg Rect Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I click the "Add" link in the "Hospital OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "eye" in the "Hospital Search For Order" field in the "Search for order" pane
    And I select CPOE "Radiology Orders" tab in the "Search for order" pane
    And I select "RadOrdrGrp FOREIGN BODY EYE ONLY" from the "Searched Radiology Orders" list in the search results
    And I enter "M53.1" reason for the exam in the "Edit Medication Order" pane
    And I reconcile and Submit the Orders
    And I click the "Adm Med Rec" button in the "Orders" pane
    Then the "Admission Medication Reconciliation" pane should load
    When I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    Then the "Search for order" pane should load within "2" seconds
    When I enter "aspirin Rectal Suppository  300MG" in the "Search for order" field in the "Search for order" pane
    And I select "the first item" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    And I click the "Add" link in the "Hospital OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "FOREIGN BODY EYE ONLY" in the "Hospital Search For Order" field in the "Search for order" pane
    And I select CPOE "Radiology Orders" tab in the "Search for order" pane
    And I select "the first item" from the "Searched Radiology Orders" list in the search results
    Then the "Clinical Decision Support Warnings" pane should load
    And I click the "DontOrder" button in the "Clinical Decision Support Warnings" pane
    When I click the "MedRec Cancel" button
    And I click the "Yes" button in the "Question" pane
    Then the "Admission Medication Reconciliation" pane should close

  Scenario Outline: Duplicate interaction display between New and Existing Nursing/Other orders from AMR[DEV-59393]
    When "<Patient Name>" is on the patient list
    And I select patient "<Patient Name>" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Adm Med Rec" button in the "Orders" pane
    Then the "Admission Medication Reconciliation" pane should load
    When I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    Then the "Search for order" pane should load
    When I enter "<AMR Order>" in the "Search for order" field in the "Search for order" pane
    And I select "<AMR Order Search>" from the "Searched Combined Med Orders" list in the search results
    And I select "<Frequency>" from the "Frequency" multiselect in the "Edit Medication Order" pane
    And I click the "Enter Order OK" button in the "Edit Medication Order" pane
    #		And I select the "Continue" radio in the row with "New: aspirin Rectal Suppository 300MG Rect Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I select the "Continue" radio in the row with "<HomeMed Order>" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I click the "Add" link in the "Hospital OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "<Order>" in the "Hospital Search For Order" field in the "Search for order" pane
    And I select CPOE "<Order Tab>" tab in the "Search for order" pane
    And I select "the first item" from the "<Search list>" list in the search results
    And I reconcile and Submit the Orders
    When I click the "Adm Med Rec" button in the "Orders" pane
#    Then the "Admission Medication Reconciliation" pane should load
    When I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    Then the "Search for order" pane should load
    When I enter "<AMR Order Search>" in the "Search for order" field in the "Search for order" pane
    And I select "the first item" from the "Searched Combined Med Orders" list in the search results
    And I select "<Frequency>" from the "Frequency" multiselect in the "Edit Medication Order" pane
    And I click the "Enter Order OK" button in the "Edit Medication Order" pane
    And I click the "Add" link in the "Hospital OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "<Order>" in the "Hospital Search For Order" field in the "Search for order" pane
    And I select CPOE "<Order Tab>" tab in the "Search for order" pane
    And I select "the first item" from the "<Search list>" list in the search results
    Then the "Clinical Decision Support Warnings" pane should load
    And the text "There is already a "<Order>" on this patient." should appear in the "Interaction Popup" section in the "Clinical Decision Support Warnings" pane
    And I click the "DontOrder" button in the "Clinical Decision Support Warnings" pane
    When I click the "MedRec Cancel" button
    And I click the "Yes" button in the "Question" pane
    Then the "Admission Medication Reconciliation" pane should close

    Examples:
      |Patient Name      |AMR Order         |AMR Order Search                       |Frequency |Order Text  |Order Tab        |Order                         |Search list               |HomeMed Order                                            |
      |TEST1 CPOEPAT1    |aspirin Rectal    |aspirin Rectal Suppository  300MG Rect |Daily     |Bed         |Nursing Orders   |Bed rest                      |Searched Nursing Orders   |New: aspirin Rectal Suppository 300 mg Rect Daily        |
      |TEST12 CPOEPAT12  |aspirin Rectal    |aspirin Rectal Suppository  300MG Rect |Daily     |RESPIRATORY |Other Orders     |RESPIRATORY THERAPY TREATMENT |Searched Other Orders     |New: aspirin Rectal Suppository 300 mg Rect Daily        |

  Scenario: Duplicate interaction display between existing and new Radiology orders from DMR [DEV-69419]
    When "TEST2 CPOEPAT2" is on the patient list
    And I select patient "TEST2 CPOEPAT2" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Discharge Med Rec" button in the "Orders" pane
    Then the "Discharge Medication Reconciliation" pane should load
    When I click the "here" link if it exists in the "Discharge Medication Reconciliation" pane
    And I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "LUNG PERFUSION" in the "Discharge Search For Order" field in the "Search for order" pane
    And I select CPOE "Radiology Orders" tab in the "Search for order" pane
    And I select "LUNG PERFUSION" from the "Searched Radiology Orders" list in the search results
    And I enter "J85.3" reason for the exam in the "Edit Medication Order" pane
    When I reconcile and Submit the Orders
    Then the "Discharge Medication Reconciliation" pane should close
    When I click the "Discharge Med Rec" button in the "Orders" pane
    And I click the "here" link if it exists in the "Discharge Medication Reconciliation" pane
    And I click the "Add" link if it exists in the "Discharge Medication Reconciliation" pane
    And I enter "LUNG PERFUSION" in the "Discharge Search For Order" field in the "Search for order" pane
    And I select CPOE "Radiology Orders" tab in the "Search for order" pane
    And I select "RadOrdrGrp LUNG PERFUSION" from the "Searched Radiology Orders" list in the search results
    Then the "Clinical Decision Support Warnings" pane should load
    And the following text should appear in the "Clinical Decision Support Warnings" pane
      |Duplicate                                            |
      |There is already a "LUNG PERFUSION" on this patient. |
    When I click the "Dont Order" button in the "Clinical Decision Support Warnings" pane
    Then the "Clinical Decision Support Warnings" pane should close
    When I click the "MedRec Cancel" button
    And I click the "Yes" button in the "Question" pane
        #Then the "Discharge Medication Reconciliation" pane should close

  Scenario Outline: Duplicate interaction display between existing and new Nursing/Lab/Others orders from DMR [DEV-59378] [DEV-69419]
    When "TEST2 CPOEPAT2" is on the patient list
    And I select patient "TEST2 CPOEPAT2" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Discharge Med Rec" button in the "Orders" pane
    Then the "Discharge Medication Reconciliation" pane should load
    When I click the "here" link if it exists in the "Discharge Medication Reconciliation" pane
    And I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "<Order>" in the "Discharge Search For Order" field in the "Search for order" pane
    And I select CPOE "<Order Tab>" tab in the "Search for order" pane
    And I select "the first item" from the "<Search list>" list in the search results
    And I reconcile and Submit the Orders
    Then the "Discharge Medication Reconciliation" pane should close
    When I click the "Discharge Med Rec" button in the "Orders" pane
    And I click the "here" link if it exists in the "Discharge Medication Reconciliation" pane
    And I click the "Add" link if it exists in the "Discharge Medication Reconciliation" pane
    And I enter "<Order>" in the "Discharge Search For Order" field in the "Search for order" pane
    And I select CPOE "<Order Tab>" tab in the "Search for order" pane
    And I select "the first item" from the "<Search list>" list in the search results
    Then the "Clinical Decision Support Warnings" pane should load
    And the text "Duplicates" should appear in the "Clinical Decision Support Warnings" pane
    And the text "There is already a "<Order>" on this patient." should appear in the "Interaction Popup" section in the "Clinical Decision Support Warnings" pane
    When I click the "Dont Order" button in the "Clinical Decision Support Warnings" pane
    Then the "Clinical Decision Support Warnings" pane should close
    When I click the "MedRec Cancel" button
    And I click the "Yes" button in the "Question" pane
   #Then the "Discharge Medication Reconciliation" pane should close

    Examples:
      |Order Tab       |Order Text  |Order             |Search list              |
      |Nursing Orders  |Wound       |Wound Treatments  |Searched Nursing Orders  |
      |Other Orders    |POISON      |POISON CONTROL    |Searched Other Orders    |
      |Lab Orders      |CBC         |CBC               |Searched Lab Orders      |

  Scenario: Duplicate Interaction display between New and Existing Radiology CHMOrders [DEV-59400]
    When "TEST3 CPOEPAT3" is on the patient list
    And I select patient "TEST3 CPOEPAT3" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Continue Home Meds" button
    And I click the "OK" button in the "Warning" pane if it exists
    And I click the "Add" link in the "Hospital OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "BONE AGE STUDY" in the "Hospital Search For Order" field in the "Continue Home Medication" pane
    And I select CPOE "Radiology Orders" tab in the "Search for order" pane
    And I select "RadOrdrGrp BONE AGE STUDY" from the "Searched Radiology Orders" list in the search results
    And I enter "M94.8X9" reason for the exam in the "Continue Home Medication" pane
    And I reconcile and Submit the Orders
   #try to submit already existing order
    And I click the "Continue Home Meds" button
    And I click the "OK" button in the "Warning" pane if it exists
    And I click the "Add" link in the "Hospital OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "BONE AGE STUDY" in the "Hospital Search For Order" field in the "Continue Home Medication" pane
    And I select CPOE "Radiology Orders" tab in the "Search for order" pane
    And I select "the first item" from the "Searched Radiology Orders" list in the search results
    Then the following text should appear in the "Clinical Decision Support Warnings" pane
      | Duplicate                                            |
      |There is already a "BONE AGE STUDY" on this patient.|
    And I click the "Dont Order" button in the "Clinical Decision Support Warnings" pane
    And I click the "MedRec Cancel" button
    And I click the "Yes" button in the "Question" pane
    Then the "Continue Home Medication" pane should close
    And I click the logout button

  Scenario Outline: Duplicate Interaction display between New and Existing Nursing/Other CHMOrders[DEV-46425]
    When "TEST4 CPOEPAT4" is on the patient list
    And I select patient "TEST4 CPOEPAT4" from the patient list
    And I select "Orders" from clinical navigation
 #	 #try to submit already existing order
#    And I click the "Continue Home Meds" button
#    And I click the "OK" button in the "Warning" pane if it exists
#    And I click the "Add" link in the "Hospital OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
#    And I enter "<Order>" in the "Hospital Search For Order" field in the "Continue Home Medication" pane
#    And I select CPOE "<Order Tab>" tab in the "Search for order" pane
#    And I select "the first item" from the "<Search list>" list in the search results
#    And I reconcile and Submit the Orders
    Then the "Continue Home Medication" pane should close
    When I click the "Continue Home Meds" button in the "Orders" pane
    And I click the "here" link if it exists in the "Continue Home Medication" pane
    And I click the "Add" link if it exists in the "Continue Home Medication" pane
    And I enter "<Order>" in the "Hospital Search For Order" field in the "Continue Home Medication" pane
    And I select CPOE "<Order Tab>" tab in the "Search for order" pane
    And I select "the first item" from the "<Search list>" list in the search results
    Then the "Clinical Decision Support Warnings" pane should load
    And I wait "5" seconds
    Then the text "Duplicates" should appear in the "Clinical Decision Support Warnings" pane
    And the text "There is already a "<Order>" on this patient." should appear in the "Interaction Popup" section in the "Clinical Decision Support Warnings" pane
    When I click the "Dont Order" button in the "Clinical Decision Support Warnings" pane
    And I click the "MedRec Cancel" button
    And I click the "Yes" button in the "Question" pane
   #Then the "Continue Home Medication" pane should close

    Examples:
      |Order Text          |Order Tab        |Order                   |Search list               |
      |Circulation Checks  |Nursing Orders   |Circulation Checks      |Searched Nursing Orders   |
      |PULSE OXIMETRY      |Other Orders     |PULSE OXIMETRY          |Searched Other Orders     |

  Scenario: No Duplicate Interaction display between New and Existing Diet Orders with allow multiple diet set Yes
    When I am on the "Admin" tab
    And I select the "Facility Group" subtab
    And I click the "CPOE Utilities" link in the "Facility Group Navigation" pane
    And I click the "Interaction Checking" element if it exists
    And I click the "Edit_CPOEUtilities" button
    And I wait up to "20" seconds for the "Edit Facility Group Utlity Settings Loading Icon" field of type "MISC_ELEMENT" to be invisible
    And the "Edit Facility Group Utilities Settings" pane should load
    And I edit the following settings in the "Edit Facility Group Utilities Settings" pane
      |Name                                   |Type     |Value     |
      |Non-Medication Duplicate Display       |dropdown |Disabled  |
      |New Non-Medication Duplicate Display   |dropdown |Disabled  |
      |Medication Duplicate Display           |dropdown |Disabled  |
      |New Medication Duplicate Display       |dropdown |Disabled  |
      |Prevent Redundant Ordering             |radio    |false     |
    Then I click the "Save_EditFacility Group Utility Settings" button
#    Given I disable the non medication duplicate display interaction checking option
#    And I disable the medication duplicate display interaction checking option
    And I enable allow multiple diets with same start date
#    And I disable prevent ordering of redundant lab tests
    When I am on the "Patient List V2" tab
    And the patient list is maximized
    And I select "CPOEInteraction" from the "Patient List" menu
    And "TEST3 CPOEPAT3" is on the patient list
    And I select patient "TEST3 CPOEPAT3" from the patient list
    And I select "Orders" from clinical navigation
    And I search for the "soft diet" order
    And I select CPOE "Diet Orders" tab
    And I select "the first item" from the "Diet Orders" list in the search results
    And I Submit the Orders
    And I search for the "soft diet" order
    And I select CPOE "Diet Orders" tab
    And I select "the first item" from the "Diet Orders" list in the search results
    And I Submit the Orders
    Then the "Order Clinical Decision Support Warnings" pane should not load
    And I select "Today" from the "Past Order Date" dropdown
     #Removing the validation of date temporarily
    And rows starting with the following should appear in the "Orders" table
      | Existing orders* |
      | Soft Diet        |

  Scenario: No Duplicate Interaction display between New and Existing Diet AMR Orders with allow multiple diet set Yes
    When "TEST5 CPOEPAT5" is on the patient list
    And I select patient "TEST5 CPOEPAT5" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Adm Med Rec" button in the "Orders" pane
    And I wait "10" seconds
    When I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "aspirin Rectal" in the "Search for order" field in the "Search for order" pane
    And I select "aspirin Rectal Suppository  300MG" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
   # Commenting the below steps as the order is already submitted in above scenarios
    And I select the "Continue" radio in the row with "New: aspirin Rectal Suppository 300 mg Rect Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I click the "Add" link in the "Hospital OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "BRAT DIET" in the "Hospital Search For Order" field in the "Search for order" pane
    And I select CPOE "DietOrders" tab in the "Search for order" pane
    And I select "BRAT DIET" from the "Searched Diet Orders" list in the search results
    And I reconcile and Submit the Orders
    And I select "Orders" from clinical navigation
    And I click the "Adm Med Rec" button in the "Orders" pane
    When I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "aspirin Rectal Suppository  300MG Rect" in the "Search for order" field in the "Search for order" pane
    And I select "the first item" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    And I click the "Add" link in the "Hospital OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "BRAT DIET" in the "Hospital Search For Order" field in the "Search for order" pane
    And I select CPOE "DietOrders" tab in the "Search for order" pane
    And I select "the first item" from the "Searched Diet Orders" list in the search results
    Then the "Clinical Decision Support Warnings" pane should not load
    And I reconcile and Submit the Orders
     #Removing the validation of date temporarily
    And rows starting with the following should appear in the "Orders" table
      |Existing orders*	 |
      |BRAT DIET         |

  Scenario: No Duplicate Interaction display between New and Existing Diet DMR Orders with allow multiple diet set Yes [DEV-59378]
   #Given I enable allow multiple diets with same start date
    When "TEST6 CPOEPAT6" is on the patient list
    And I select patient "TEST6 CPOEPAT6" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Discharge Med Rec" button in the "Orders" pane
    Then the "Discharge Medication Reconciliation" pane should load
    When I click the "here" link if it exists in the "Discharge Medication Reconciliation" pane
    And I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "NPO" in the "Discharge Search For Order" field in the "Search for order" pane
    And I select CPOE "Diet Orders" tab in the "Search for order" pane
    And I select "the first item" from the "Searched Diet Orders" list in the search results
    And I reconcile and Submit the Orders
    And I click the "Discharge Med Rec" button in the "Orders" pane
    When I click the "here" link if it exists in the "Discharge Medication Reconciliation" pane
    And I click the "Add" link if it exists in the "Discharge Medication Reconciliation" pane
    And I enter "NPO" in the "Discharge Search For Order" field in the "Search for order" pane
    And I select CPOE "Diet Orders" tab in the "Search for order" pane
    And I select "the first item" from the "Searched Diet Orders" list in the search results
    And I reconcile and Submit the Orders
    Then the "Discharge Medication Reconciliation" pane should close

  Scenario: No Duplicate Interaction display between New and Existing Diet CHM Orders with allow multiple diet set Yes
    When "TEST5 CPOEPAT5" is on the patient list
    And I select patient "TEST5 CPOEPAT5" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Continue Home Meds" button
    And I click the "OK" button in the "Warning" pane if it exists
    And I click the "Add" link in the "Hospital OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "DIABETIC DIET" in the "Hospital Search For Order" field in the "Continue Home Medication" pane
    And I select CPOE "Diet Orders" tab in the "Search for order" pane
    And I select "the first item" from the "Searched Diet Orders" list in the search results
    And I reconcile and Submit the Orders
   #try to submit already existing order
    And I click the "Continue Home Meds" button
    And I click the "OK" button in the "Warning" pane if it exists
    And I click the "Add" link in the "Hospital OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "DIABETIC DIET" in the "Hospital Search For Order" field in the "Continue Home Medication" pane
    And I select CPOE "Diet Orders" tab in the "Search for order" pane
    And I select "the first item" from the "Searched Diet Orders" list in the search results
    And I reconcile and Submit the Orders
    Then the "Continue Home Medication" pane should close
    #Removing the validation of date temporarily
    And rows starting with the following should appear in the "Orders" table
      |Existing orders*  |
      |DIABETIC DIET     |

  Scenario: Duplicate Interaction display between two New Diet Orders with allow multiple diet set No
    When I am on the "Admin" tab
    And I select the "Facility Group" subtab
    And I click the "CPOE Utilities" link in the "Facility Group Navigation" pane
    And I click the "Interaction Checking" element if it exists
    And I click the "Edit_CPOEUtilities" button
    And I wait up to "20" seconds for the "Edit Facility Group Utlity Settings Loading Icon" field of type "MISC_ELEMENT" to be invisible
    And the "Edit Facility Group Utilities Settings" pane should load
    And I edit the following settings in the "Edit Facility Group Utilities Settings" pane
      |Name                                   |Type     |Value                    |
      |Non-Medication Duplicate Display       |dropdown |Popup and Require Reason |
      |New Non-Medication Duplicate Display   |dropdown |Popup and Require Reason |
      |Medication Duplicate Display           |dropdown |Popup and Require Reason |
      |New Medication Duplicate Display       |dropdown |Popup and Require Reason |
      |Prevent Redundant Ordering             |radio    |false                    |
    Then I click the "Save_EditFacility Group Utility Settings" button
#    Given I enable the non medication duplicate display interaction checking option
#    And I enable the medication duplicate display interaction checking option
    And I disable allow multiple diets with same start date
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    And I select "CPOEInteraction" from the "Patient List" menu
    And "TEST3 CPOEPAT3" is on the patient list
    And I select patient "TEST3 CPOEPAT3" from the patient list
    And I select "Orders" from clinical navigation
    And I search for the "soft diet" order
    And I select CPOE "DietOrders" tab
    And I select "the first item" from the "Diet Orders" list in the search results
    And I search for the "soft diet" order
    And I select CPOE "DietOrders" tab
    And I select "the first item" from the "Diet Orders" list in the search results
    Then the "Order Clinical Decision Support Warnings" pane should load
    And the text "Another diet for the same start date/meal already exists." should appear in the "Order Clinical Decision Support Warnings" pane
    And I click the "Duplicate DontOrder" button in the "Order Clinical Decision Support Warnings" pane
    And I click the "AddOrder Cancel" button
    And I click the "Yes" button in the "Question" pane

  Scenario: Duplicate Interaction display between two New AMR Orders with allow multiple diet set No
    When "TEST1 CPOEPAT1" is on the patient list
    And I select patient "TEST1 CPOEPAT1" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Adm Med Rec" button in the "Orders" pane
    And I wait "2" seconds
    When I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "aspirin Rectal" in the "Search for order" field in the "Search for order" pane
    And I select "aspirin Rectal Suppository  300MG Rect" from the "Searched Combined Med Orders" list in the search results
    And I select "Daily" from the "Frequency" multiselect in the "Edit Medication Order" pane
    And I click the "Enter Order OK" button in the "Edit Medication Order" pane
   # Commenting the below step as the order is already submitted in above scenarios
   #And I select the "Continue" radio in the row with "New: aspirin Rectal Suppository 300MG Rect Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I click the "Add" link in the "Hospital OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "BRAT DIET" in the "Hospital Search For Order" field in the "Search for order" pane
    And I select CPOE "DietOrders" tab in the "Search for order" pane
    And I select "the first item" from the "Searched Diet Orders" list in the search results
    And I click the "Add" link in the "Hospital OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "BRAT DIET" in the "Hospital Search For Order" field in the "Search for order" pane
    And I select CPOE "DietOrders" tab in the "Search for order" pane
    And I select "the first item" from the "Searched Diet Orders" list in the search results
    Then the "Clinical Decision Support Warnings" pane should load
    And the text "Another diet for the same start date/meal already exists." should appear in the "Clinical Decision Support Warnings" pane
    And I click the "Duplicate DontOrder" button in the "Clinical Decision Support Warnings" pane
    When I click the "MedRec Cancel" button
    And I click the "Yes" button in the "Question" pane
    Then the "Admission Medication Reconciliation" pane should close

  Scenario: Duplicate Interaction display between two New Diet DMR Orders with allow multiple diet set No
    When "TEST5 CPOEPAT5" is on the patient list
    And I select patient "TEST5 CPOEPAT5" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Discharge Med Rec" button in the "Orders" pane
    Then the "Discharge Medication Reconciliation" pane should load
    When I click the "here" link if it exists in the "Discharge Medication Reconciliation" pane
    And I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "NPO" in the "Discharge Search For Order" field in the "Search for order" pane
    And I select CPOE "Diet Orders" tab in the "Search for order" pane
    And I select "the first item" from the "Searched Diet Orders" list in the search results
    And I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "NPO" in the "Discharge Search For Order" field in the "Search for order" pane
    And I select CPOE "Diet Orders" tab in the "Search for order" pane
    And I select "the first item" from the "Searched Diet Orders" list in the search results
    Then the "Clinical Decision Support Warnings" pane should load
    And the text "Another diet for the same start date/meal already exists." should appear in the "Clinical Decision Support Warnings" pane
    And I click the "Duplicate DontOrder" button in the "Clinical Decision Support Warnings" pane
    When I click the "MedRec Cancel" button
    And I click the "Yes" button in the "Question" pane
    Then the "Discharge Medication Reconciliation" pane should close

  Scenario: Duplicate Interaction display between two New Diet CHM Orders with allow multiple diet set No
    When "TEST8 CPOEPAT8" is on the patient list
    And I select patient "TEST8 CPOEPAT8" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Continue Home Meds" button
    And I click the "OK" button in the "Warning" pane if it exists
    And I click the "Add" link in the "Hospital OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "DIABETIC DIET" in the "Hospital Search For Order" field in the "Continue Home Medication" pane
    And I select CPOE "Diet Orders" tab in the "Search for order" pane
    And I select "the first item" from the "Searched Diet Orders" list in the search results
   #try to submit same order
    And I click the "Add" link in the "Hospital OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "DIABETIC DIET" in the "Hospital Search For Order" field in the "Continue Home Medication" pane
    And I select CPOE "Diet Orders" tab in the "Search for order" pane
    And I select "the first item" from the "Searched Diet Orders" list in the search results
    Then the "Clinical Decision Support Warnings" pane should load
    And the text "Another diet for the same start date/meal already exists." should appear in the "Clinical Decision Support Warnings" pane
    And I click the "Duplicate DontOrder" button in the "Clinical Decision Support Warnings" pane
    When I click the "MedRec Cancel" button
    And I click the "Yes" button in the "Question" pane
    Then the "Continue Home Medication" pane should close

  Scenario: No Duplicate Interaction display between New and Existing Diet Orders with allow multiple diet set No
    When I am on the "Admin" tab
    And I select the "Facility Group" subtab
    And I click the "CPOE Utilities" link in the "Facility Group Navigation" pane
    And I click the "Interaction Checking" element if it exists
    And I click the "Edit_CPOEUtilities" button
    And I wait up to "20" seconds for the "Edit Facility Group Utlity Settings Loading Icon" field of type "MISC_ELEMENT" to be invisible
    And the "Edit Facility Group Utilities Settings" pane should load
    And I edit the following settings in the "Edit Facility Group Utilities Settings" pane
      |Name                                   |Type     |Value     |
      |Non-Medication Duplicate Display       |dropdown |Disabled  |
      |New Non-Medication Duplicate Display   |dropdown |Disabled  |
      |Medication Duplicate Display           |dropdown |Disabled  |
      |New Medication Duplicate Display       |dropdown |Disabled  |
      |Prevent Redundant Ordering             |radio    |false     |
    Then I click the "Save_EditFacility Group Utility Settings" button
#    Given I disable the non medication duplicate display interaction checking option
#    And I disable the medication duplicate display interaction checking option
#    And I disable prevent ordering of redundant lab tests
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    And I select "CPOEInteraction" from the "Patient List" menu
    And "TEST1 CPOEPAT1" is on the patient list
    And I select patient "TEST1 CPOEPAT1" from the patient list
    And I select "Orders" from clinical navigation
    And I search for the "soft diet" order
    And I select CPOE "DietOrders" tab
    And I select "the first item" from the "Diet Orders" list in the search results
    And I Submit the Orders
    And I search for the "soft diet" order
    And I select CPOE "DietOrders" tab
    And I select "the first item" from the "Diet Orders" list in the search results
    Then the "Order Clinical Decision Support Warnings" pane should not load
    And I Submit the Orders

  Scenario: No Duplicate Interaction display between New and Existing Diet AMR Orders with allow multiple diet set No
    When "TEST2 CPOEPAT2" is on the patient list
    And I select patient "TEST2 CPOEPAT2" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Adm Med Rec" button in the "Orders" pane
    When I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "aspirin Rectal" in the "Search for order" field in the "Search for order" pane
    And I select "aspirin Rectal Suppository  300MG Rect" from the "Searched Combined Med Orders" list in the search results
    And I select "Daily" from the "Frequency" multiselect in the "Edit Medication Order" pane
    And I click the "Enter Order OK" button in the "Edit Medication Order" pane
    And I select the "Continue" radio in the row with "New: aspirin Rectal Suppository 300 mg Rect Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I click the "Add" link in the "Hospital OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "BRAT DIET" in the "Hospital Search For Order" field in the "Search for order" pane
    And I select CPOE "DietOrders" tab in the "Search for order" pane
    And I select "the first item" from the "Searched Diet Orders" list in the search results
    And I reconcile and Submit the Orders
    When I click the "Adm Med Rec" button in the "Orders" pane
    And I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "aspirin Rectal Suppository  300MG Rect" in the "Search for order" field in the "Search for order" pane
    And I select "the first item" from the "Searched Combined Med Orders" list in the search results
    And I select "Daily" from the "Frequency" multiselect in the "Edit Medication Order" pane
    And I click the "Enter Order OK" button in the "Edit Medication Order" pane
    And I click the "Add" link in the "Hospital OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "BRAT DIET" in the "Hospital Search For Order" field in the "Search for order" pane
    And I select CPOE "DietOrders" tab in the "Search for order" pane
    And I select "the first item" from the "Searched Diet Orders" list in the search results
    Then the "Clinical Decision Support Warnings" pane should not load
    And I reconcile and Submit the Orders
    And the "Admission Medication Reconciliation" pane should close

  Scenario: No Duplicate Interaction display between New and Existing Diet DMR Orders with allow multiple diet set No [DEV-59378]
    When "TEST11 CPOEPAT11" is on the patient list
    And I select patient "TEST11 CPOEPAT11" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Discharge Med Rec" button in the "Orders" pane
    Then the "Discharge Medication Reconciliation" pane should load
    When I click the "here" link if it exists in the "Discharge Medication Reconciliation" pane
    And I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "NPO" in the "Discharge Search For Order" field in the "Search for order" pane
    And I select CPOE "Diet Orders" tab in the "Search for order" pane
    And I select "the first item" from the "Searched Diet Orders" list in the search results
    And I reconcile and Submit the Orders
    And I click the "Discharge Med Rec" button in the "Orders" pane
    Then the "Discharge Medication Reconciliation" pane should load
    When I click the "here" link if it exists in the "Discharge Medication Reconciliation" pane
    And I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "NPO" in the "Discharge Search For Order" field in the "Search for order" pane
    And I select CPOE "Diet Orders" tab in the "Search for order" pane
    And I select "the first item" from the "Searched Diet Orders" list in the search results
    Then the "Clinical Decision Support Warnings" pane should not load
    And I reconcile and Submit the Orders
#		Then the "Discharge Medication Reconciliation" pane should close

  Scenario: No Duplicate Interaction display between New and Existing Diet CHM Orders with allow multiple diet set No
    When "TEST4 CPOEPAT4" is on the patient list
    And I select patient "TEST4 CPOEPAT4" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Continue Home Meds" button
    And I click the "OK" button in the "Warning" pane if it exists
    And I click the "Add" link in the "Hospital OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "DIABETIC DIET" in the "Hospital Search For Order" field in the "Continue Home Medication" pane
    And I select CPOE "Diet Orders" tab in the "Search for order" pane
    And I select "the first item" from the "Searched Diet Orders" list in the search results
    And I reconcile and Submit the Orders
   #try to submit same order
    And I click the "Continue Home Meds" button
    And I click the "OK" button in the "Warning" pane if it exists
    Then the "Continue Home Medication" pane should load
    And I click the "Add" link in the "Hospital OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "DIABETIC DIET" in the "Hospital Search For Order" field in the "Continue Home Medication" pane
    And I select CPOE "Diet Orders" tab in the "Search for order" pane
    And I select "the first item" from the "Searched Diet Orders" list in the search results
    Then the "Clinical Decision Support Warnings" pane should not load
    And I reconcile and Submit the Orders
#		Then the "Continue Home Medication" pane should close

  Scenario: Duplicate Interaction display between two New Lab Orders redundant lab test set Yes
    When I am on the "Admin" tab
    And I select the "Facility Group" subtab
    And I click the "CPOE Utilities" link in the "Facility Group Navigation" pane
    And I click the "Interaction Checking" element if it exists
    And I click the "Edit_CPOEUtilities" button
    And I wait up to "20" seconds for the "Edit Facility Group Utlity Settings Loading Icon" field of type "MISC_ELEMENT" to be invisible
    And the "Edit Facility Group Utilities Settings" pane should load
    And I edit the following settings in the "Edit Facility Group Utilities Settings" pane
      |Name                                   |Type     |Value                     |
      |Non-Medication Duplicate Display       |dropdown |Popup and Require Reason  |
      |New Non-Medication Duplicate Display   |dropdown |Popup and Require Reason  |
      |Prevent Redundant Ordering             |radio    |true                      |
    Then I click the "Save_EditFacility Group Utility Settings" button
#    Given I enable the non medication duplicate display interaction checking option
#    And I enable prevent ordering of redundant lab tests
    And I click the logout button
    Given I am logged into the portal with user "cadmin" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    And I select "CPOEInteraction" from the "Patient List" menu
    And "TEST5 CPOEPAT5" is on the patient list
    And I select patient "TEST5 CPOEPAT5" from the patient list
    And I select "Orders" from clinical navigation
    And I search for the "Albumin Lab Test" order
    And I select CPOE "Lab Orders" tab
    And I select "the first item" from the "Lab Orders" list in the search results
    And I enter "Albumin Lab Test today" in the "Add Order" field in the "Enter Orders" pane
    And I select CPOE "Lab Orders" tab
    And I select "the first item" from the "Lab Orders" list in the search results
    Then the "Order Clinical Decision Support Warnings" pane should load
    And the following text should appear in the "Order Clinical Decision Support Warnings" pane
      | Redundant Order                                                          |
      |Another "Albumin Lab Test" with the same start date/time already exists. |
    And I click the "Duplicate DontOrder" button in the "Order Clinical Decision Support Warnings" pane
    And I click the "AddOrder Cancel" button
    And I click the "Yes" button in the "Question" pane
    Then the "Enter Orders" pane should close

  Scenario: Duplicate interaction display between two new Lab AMR orders redundant lab test set Yes
    When "TEST6 CPOEPAT6" is on the patient list
    And I select patient "TEST6 CPOEPAT6" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Adm Med Rec" button in the "Orders" pane
    Then the "Admission Medication Reconciliation" pane should load
    When I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    Then the "Search for order" pane should load within "2" seconds
    When I enter "acetaminophen Rect" in the "Search for order" field in the "Search for order" pane
    And I select "acetaminophen Rectal Suppository  325MG Rect" from the "Searched Combined Med Orders" list in the search results
    And I select "Daily" from the "Frequency" multiselect in the "Edit Medication Order" pane
    And I click the "Enter Order OK" button in the "Edit Medication Order" pane
    And I select the "Continue" radio in the row with "New: acetaminophen Rectal Suppository 325 mg Rect Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I click the "Add" link in the "Hospital OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "Albumin Lab Test" in the "Hospital Search For Order" field in the "Search for order" pane
    And I select CPOE "Lab Orders" tab in the "Search for order" pane
    And I select "the first item" from the "Searched Lab Orders" list in the search results
    And I click the "Add" link in the "Hospital OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "Albumin Lab Test" in the "Hospital Search For Order" field in the "Search for order" pane
    And I select CPOE "Lab Orders" tab in the "Search for order" pane
    And I select "the first item" from the "Searched Lab Orders" list in the search results
    Then the "Clinical Decision Support Warnings" pane should load
    And the following text should appear in the "Clinical Decision Support Warnings" pane
      | Redundant Order                                                          |
      | Another "Albumin Lab Test" with the same start date/time already exists. |
    And I click the "Duplicate DontOrder" button in the "Clinical Decision Support Warnings" pane
    When I click the "MedRec Cancel" button
    And I click the "Yes" button in the "Question" pane
    Then the "Admission Medication Reconciliation" pane should close

  Scenario: Duplicate interaction display between two new Lab orders from DMR with redundant lab test set Yes
    When "TEST2 CPOEPAT2" is on the patient list
    And I select patient "TEST2 CPOEPAT2" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Discharge Med Rec" button in the "Orders" pane
    Then the "Discharge Medication Reconciliation" pane should load
    When I click the "here" link if it exists in the "Discharge Medication Reconciliation" pane
    And I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "Albumin Lab Test" in the "Discharge Search For Order" field in the "Search for order" pane
    And I select CPOE "Lab Orders" tab in the "Search for order" pane
    And I select "the first item" from the "Searched Lab Orders" list in the search results
    And I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "Albumin Lab Test" in the "Discharge Search For Order" field in the "Search for order" pane
    And I select CPOE "Lab Orders" tab in the "Search for order" pane
    And I select "the first item" from the "Searched Lab Orders" list in the search results
    Then the "Clinical Decision Support Warnings" pane should load
    And the following text should appear in the "Clinical Decision Support Warnings" pane
      | Redundant Order                                                          |
      |Another "Albumin Lab Test" with the same start date/time already exists.|
    And I click the "Duplicate DontOrder" button in the "Clinical Decision Support Warnings" pane
    When I click the "MedRecCancel" button
    And I click the "Yes" button in the "Question" pane
    Then the "Discharge Medication Reconciliation" pane should close

  Scenario: Duplicate Interaction display between two New Lab CHMOrders with redundant lab test set Yes
    When "TEST3 CPOEPAT3" is on the patient list
    And I select patient "TEST3 CPOEPAT3" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Continue Home Meds" button
    And I click the "OK" button in the "Warning" pane if it exists
    Then the "Continue Home Medication" pane should load
    And I click the "Add" link in the "Hospital OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "Albumin Lab Test" in the "Hospital Search For Order" field in the "Continue Home Medication" pane
    And I select CPOE "Lab Orders" tab in the "Search for order" pane
    And I select "the first item" from the "Searched Lab Orders" list in the search results
    And I click the "Add" link in the "Hospital OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "Albumin Lab Test" in the "Hospital Search For Order" field in the "Continue Home Medication" pane
    And I select CPOE "Lab Orders" tab in the "Search for order" pane
    And I select "the first item" from the "Searched Lab Orders" list in the search results
    Then the "Clinical Decision Support Warnings" pane should load
    And the following text should appear in the "Clinical Decision Support Warnings" pane
      | Duplicates                                             |
      | There is already a "Albumin Lab Test" on this patient. |
    And I click the "DontOrder" button in the "Clinical Decision Support Warnings" pane
    When I click the "MedRec Cancel" button
    And I click the "Yes" button in the "Question" pane
    Then the "Continue Home Medication" pane should close
    And I click the logout button

  Scenario: Duplicate Interaction display between two New Med Orders
    When I am on the "Admin" tab
    And I select the "Facility Group" subtab
    And I click the "CPOE Utilities" link in the "Facility Group Navigation" pane
    And I click the "Interaction Checking" element if it exists
    And I click the "Edit_CPOEUtilities" button
    And I wait up to "20" seconds for the "Edit Facility Group Utlity Settings Loading Icon" field of type "MISC_ELEMENT" to be invisible
    And the "Edit Facility Group Utilities Settings" pane should load
    And I edit the following settings in the "Edit Facility Group Utilities Settings" pane
      |Name                                   |Type     |Value                     |
      |Medication Duplicate Display           |dropdown |Popup and Require Reason  |
      |New Medication Duplicate Display       |dropdown |Popup and Require Reason  |
    Then I click the "Save_EditFacility Group Utility Settings" button
#    And I enable the medication duplicate display interaction checking option
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    And I select "CPOEInteraction" from the "Patient List" menu
    And "TEST4 CPOEPAT4" is on the patient list
    And I select patient "TEST4 CPOEPAT4" from the patient list
    And I select "Orders" from clinical navigation
    And I search for the "zebet tablet" order
    And I select CPOE "Medication Orders" tab
    And I select "Zebeta tablet (bisoprolol fumarate)  10MG Oral" from the "NonFormulary MedOrders" list in the search results
    And I fill the mandatory order details in the "Edit Order" pane if it exists
#    And I am on the "Patient List V2" tab
#    And I select patient "TEST4 CPOEPAT4" from the patient list
    And I search for the "Zebeta tablet (bisoprolol fumarate)  10MG Oral" order
    And I select CPOE "Medication Orders" tab
    And I select "the first item" from the "NonFormulary MedOrders" list in the search results
    Then the "Order Clinical Decision Support Warnings" pane should load
    And the text "Duplicate" should appear in the "Order Clinical Decision Support Warnings" pane
    And the text "The use of Zebeta 10 mg tablet and Zebeta 10 mg tablet may represent a duplication of drug therapy or pharmacologic effect based on their mutual association with the duplicate therapy class of Beta-Blockers (Systemic)." should appear in the "Order Clinical Decision Support Warnings" pane
    And I click the "DontOrder" button in the "Order Clinical Decision Support Warnings" pane
    And I click the "AddOrder Cancel" button
    And I click the "Yes" button in the "Question" pane
    Then the "Enter Orders" pane should close

  Scenario: Duplicate interaction display between two new Med AMR orders
    When I am on the "Admin" tab
    And I select the "Facility Group" subtab
    And I click the "CPOE Utilities" link in the "Facility Group Navigation" pane
    And I click the "Interaction Checking" element if it exists
    And I click the "Edit_CPOEUtilities" button
    And I wait up to "20" seconds for the "Edit Facility Group Utlity Settings Loading Icon" field of type "MISC_ELEMENT" to be invisible
    And the "Edit Facility Group Utilities Settings" pane should load
    And I edit the following settings in the "Edit Facility Group Utilities Settings" pane
      |Name                                   |Type     |Value                     |
      |Medication Duplicate Display           |dropdown |Popup and Require Reason  |
      |New Medication Duplicate Display       |dropdown |Popup and Require Reason  |
    Then I click the "Save_EditFacility Group Utility Settings" button
#    And I enable the medication duplicate display interaction checking option
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    And I select "CPOEInteraction" from the "Patient List" menu
    And "TEST5 CPOEPAT5" is on the patient list
    And I select patient "TEST5 CPOEPAT5" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Adm Med Rec" button in the "Orders" pane
    Then the "Admission Medication Reconciliation" pane should load
    When I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    Then the "Search for order" pane should load within "2" seconds
    When I enter "butorphanol tartrate" in the "Search for order" field in the "Search for order" pane
    And I select "butorphanol tartrate 1 mg/mL Injection  IV" from the "Searched Combined Med Orders" list in the search results
    And the "Edit Medication Order" pane should load
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with "New: butorphanol tartrate 1 mg/mL Injection IV Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    Then the "Search for order" pane should load within "2" seconds
    When I enter "butorphanol tartrate 1 mg/mL Injection  IV" in the "Search for order" field in the "Search for order" pane
    And I select "the first item" from the "Searched Combined Med Orders" list in the search results
    Then the "Clinical Decision Support Warnings" pane should load
    And the text "Duplicate" should appear in the "Clinical Decision Support Warnings" pane
    And the text "The use of butorphanol tartrate 1 mg/mL injection solution and butorphanol tartrate 1 mg/mL injection solution may represent a duplication of drug therapy or pharmacologic effect based on their mutual association with the duplicate therapy class of Opioid Analgesics- IR (with all antitussive opiates)." should appear in the "Clinical Decision Support Warnings" pane
    And I click the "DontOrder" button in the "Clinical Decision Support Warnings" pane
    When I click the "MedRec Cancel" button
    And I click the "Yes" button in the "Question" pane
  #Then the "Admission Medication Reconciliation" pane should close

  Scenario: Duplicate interaction display between two new Med orders from DMR
    When "TEST6 CPOEPAT6" is on the patient list
    And I select patient "TEST6 CPOEPAT6" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Discharge Med Rec" button in the "Orders" pane
    Then the "Discharge Medication Reconciliation" pane should load
    When I click the "here" link if it exists in the "Discharge Medication Reconciliation" pane
    And I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "interferon gamma" in the "Discharge Search For Order" field in the "Search for order" pane
    And I select "interferon gamma-1b 2 million unit/0.5 mL Sub-Q  SubQ" from the "Searched Combined Med Orders" list in the search results
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
#    And I enter "2" in the "Disp" field
#    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    And I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "interferon gamma-1b 2 million unit/0.5 mL Sub-Q  SubQ" in the "Discharge Search For Order" field in the "Search for order" pane
    And I select "the first item" from the "Searched Combined Med Orders" list in the search results
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    Then the "Clinical Decision Support Warnings" pane should load
    And the text "Duplicates" should appear in the "Clinical Decision Support Warnings" pane
    And the text "The use of interferon gamma-1b 100 mcg (2 million unit)/0.5 mL subcutaneous soln and interferon gamma-1b 100 mcg (2 million unit)/0.5 mL subcutaneous soln may represent a duplication of drug therapy or pharmacologic effect based on their mutual association with the duplicate therapy class of Interferon Gamma." should appear in the "Clinical Decision Support Warnings" pane
    And I click the "DontOrder" button in the "Clinical Decision Support Warnings" pane
    When I click the "MedRec Cancel" button
    And I click the "Yes" button in the "Question" pane
#		Then the "Discharge Medication Reconciliation" pane should close

  Scenario: Duplicate Interaction display between two New Med CHMOrders
    When "TEST5 CPOEPAT5" is on the patient list
    And I select patient "TEST5 CPOEPAT5" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Continue Home Meds" button
    And I click the "OK" button in the "Warning" pane if it exists
    Then the "Continue Home Medication" pane should load
    And I click the "Add" link in the "Hospital OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "Bontril PDM tablet (phendimetrazine tartrate)  35MG Oral" in the "Hospital Search For Order" field in the "Continue Home Medication" pane
    And I select "Bontril PDM tablet (phendimetrazine tartrate)  35MG Oral" from the "Searched NonFormulary MedOrders" list in the search results
    And the "Edit Medication Order" pane should load
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    And I click the "Add" link in the "Hospital OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "Bontril PDM tablet (phendimetrazine tartrate)  35MG Oral" in the "Hospital Search For Order" field in the "Continue Home Medication" pane
    And I select "the first item" from the "Searched NonFormulary MedOrders" list in the search results
    Then the "Clinical Decision Support Warnings" pane should load
    And the text "Duplicates" should appear in the "Clinical Decision Support Warnings" pane
    And the text "The use of Bontril PDM 35 mg tablet and Bontril PDM 35 mg tablet may represent a duplication of drug therapy or pharmacologic effect based on their mutual association with the duplicate therapy classes of Amphetamines/Anorexiants/Stimulants and Diet Aids." should appear in the "Clinical Decision Support Warnings" pane
    And I click the "DontOrder" button in the "Clinical Decision Support Warnings" pane
    When I click the "MedRec Cancel" button
    And I click the "Yes" button in the "Question" pane
  #Then the "Continue Home Medication" pane should close

  Scenario: Duplicate Interaction display between New and Existing Med Orders
    When I am on the "Patient List V2" tab
    And the patient list is maximized
    And I select "CPOEInteraction" from the "Patient List" menu
    And "TEST2 CPOEPAT2" is on the patient list
    And I select patient "TEST2 CPOEPAT2" from the patient list
    And I select "Orders" from clinical navigation
    And I search for the "Bontril PDM" order
    And I select CPOE "Medication Orders" tab
    And I select "Bontril PDM tablet (phendimetrazine tartrate)  35MG Oral" from the "NonFormulary MedOrders" list in the search results
    And I fill the mandatory order details in the "Edit Order" pane if it exists
    And I Submit the Orders
    And I search for the "Bontril PDM tablet (phendimetrazine tartrate)  35MG Oral" order
    And I select CPOE "Medication Orders" tab
    And I select "the first item" from the "NonFormulary MedOrders" list in the search results
    Then the "Order Clinical Decision Support Warnings" pane should load
    And the text "Duplicate" should appear in the "Order Clinical Decision Support Warnings" pane
    And the text "The use of Bontril PDM 35 mg tablet and Bontril PDM 35 mg tablet may represent a duplication of drug therapy or pharmacologic effect based on their mutual association with the duplicate therapy classes of Amphetamines/Anorexiants/Stimulants and Diet Aids." should appear in the "Order Clinical Decision Support Warnings" pane
    And I click the "DontOrder" button in the "Order Clinical Decision Support Warnings" pane
    And I click the "AddOrder Cancel" button
    And I click the "Yes" button in the "Question" pane if it exists
    Then the "Enter Orders" pane should close

  Scenario: Duplicate interaction display between New and Existing Med AMR orders
    When I am on the "Patient List V2" tab
    And the patient list is maximized
    And I select "CPOEInteraction" from the "Patient List" menu
    And "TEST7 CPOEPAT7" is on the patient list
    And I select patient "TEST7 CPOEPAT7" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Adm Med Rec" button in the "Orders" pane
    Then the "Admission Medication Reconciliation" pane should load
    When I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link if it exists in the "Admission Medication Reconciliation" pane
    And I enter "aspirin Rectal" in the "Search for order" field in the "Search for order" pane
    And I select "aspirin Rectal Suppository  300MG Rect" from the "Searched Combined Med Orders" list in the search results
    And the "Edit Medication Order" pane should load
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
#    And I select "Daily" from the "Frequency" multiselect in the "Edit Medication Order" pane
#    And I click the "Enter Order OK" button in the "Edit Medication Order" pane
    And I select the "Continue" radio in the row with "New: aspirin Rectal Suppository 300 mg Rect Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I click the "Add" link in the "Hospital OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "basiliximab IV Solution  10MG IV" in the "Hospital Search For Order" field in the "Search for order" pane
    And I select "the first item" from the "Searched NonFormulary MedOrders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    And I reconcile and Submit the Orders
    And I click the "Adm Med Rec" button in the "Orders" pane
    Then the "Admission Medication Reconciliation" pane should load
    When I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    When I enter "Zetia tablet (ezetimibe)  10MG" in the "Search for order" field in the "Search for order" pane
    And I select "the first item" from the "Searched Combined Med Orders" list in the search results
    And I select "Daily" from the "Frequency" multiselect in the "Edit Medication Order" pane
    And I click the "Enter Order OK" button in the "Edit Medication Order" pane
    And I click the "Add" link in the "Hospital OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "basiliximab IV Solution  20MG IV" in the "Hospital Search For Order" field in the "Search for order" pane
    And I select "the first item" from the "Searched NonFormulary MedOrders" list in the search results
    Then the "Clinical Decision Support Warnings" pane should load
    And the text "Duplicate" should appear in the "Clinical Decision Support Warnings" pane
    And the text "The use of basiliximab 10 mg intravenous solution and basiliximab 20 mg intravenous solution may represent a duplication of drug therapy or pharmacologic effect based on their mutual association with the duplicate therapy classes of Immunosuppress., T-Cell Fxn Inhibiting Monoclonal Antibodies, Immunosuppressants - Monoclonal and Polyclonal Antibodies, and Monoclonal Antibody Immunosuppressives." should appear in the "Clinical Decision Support Warnings" pane
    And I click the "DontOrder" button in the "Clinical Decision Support Warnings" pane
    When I click the "MedRec Cancel" button
    And I click the "Yes" button in the "Question" pane
    Then the "Admission Medication Reconciliation" pane should close

  Scenario: Duplicate interaction display between New and Existing Med orders from DMR
    When I am on the "Admin" tab
    And I select the "Facility Group" subtab
    And I click the "CPOE Utilities" link in the "Facility Group Navigation" pane
    And I click the "Interaction Checking" element if it exists
    And I click the "Edit_CPOEUtilities" button
    And I wait up to "20" seconds for the "Edit Facility Group Utlity Settings Loading Icon" field of type "MISC_ELEMENT" to be invisible
    And the "Edit Facility Group Utilities Settings" pane should load
    And I edit the following settings in the "Edit Facility Group Utilities Settings" pane
      |Name                                   |Type     |Value                     |
      |Non-Medication Duplicate Display       |dropdown |Disabled                  |
      |New Non-Medication Duplicate Display   |dropdown |Disabled                  |
      |Medication Duplicate Display           |dropdown |Popup and Require Reason  |
      |New Medication Duplicate Display       |dropdown |Popup and Require Reason  |
      |Contraindicated Drug Combination       |dropdown |Disabled                  |
      |Severe Interaction                     |dropdown |Disabled                  |
      |Moderate Interaction                   |dropdown |Disabled                  |
      |Drug Allergy Display                   |dropdown |Disabled                  |
      |Undetermined Severity                  |dropdown |Disabled                  |
      |Prevent Redundant Ordering             |radio    |false                     |
    Then I click the "Save_EditFacility Group Utility Settings" button
#    When I disable all the interaction checking options
#    And I enable the medication duplicate display interaction checking option
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    And I select "CPOEInteraction" from the "Patient List" menu
    And "TEST3 CPOEPAT3" is on the patient list
    And I select patient "TEST3 CPOEPAT3" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Discharge Med Rec" button in the "Orders" pane
    Then the "Discharge Medication Reconciliation" pane should load
    And I click the "Stop Remaining Meds" button in the "Discharge Medication Reconciliation" pane if it exists
    When I click the "here" link if it exists in the "Discharge Medication Reconciliation" pane
    And I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "interferon gamma" in the "Discharge Search For Order" field in the "Search for order" pane
    And I select "Actimmune 2 million unit/0.5 mL Sub-Q (interferon gamma-1b)  SubQ" from the "Searched Combined Med Orders" list in the search results
    And the "Edit Medication Order" pane should load
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I reconcile and Submit the Orders
    And I click the "Discharge Med Rec" button in the "Orders" pane
    Then the "Discharge Medication Reconciliation" pane should load
    And I wait "2" second
    When I click the "here" link if it exists in the "Discharge Medication Reconciliation" pane
    And I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "Actimmune 2 million unit/0.5 mL Sub-Q (interferon gamma-1b)  SubQ" in the "Discharge Search For Order" field in the "Search for order" pane
    And I select "the first item" from the "Searched Combined Med Orders" list in the search results
    Then the "Clinical Decision Support Warnings" pane should load
    And the following text should appear in the "Clinical Decision Support Warnings" pane
      |Duplicate                                                                                                                                                                                                                                                                                                  |
      |The use of Actimmune 100 mcg (2 million unit)/0.5 mL subcutaneous solution and Actimmune 100 mcg (2 million unit)/0.5 mL subcutaneous solution may represent a duplication of drug therapy or pharmacologic effect based on their mutual association with the duplicate therapy class of Interferon Gamma. |
#      |Use of interferon gamma-1b 2 million unit/0.5 mL Sub-Q and interferon gamma-1b 2 million unit/0.5 mL Sub-Q may represent a duplication in therapy based on their association to the therapeutic drug class Interferon Gamma.|
    And I click the "DontOrder" button in the "Clinical Decision Support Warnings" pane
    When I click the "MedRec Cancel" button
    And I click the "Yes" button in the "Question" pane
  #Then the "Discharge Medication Reconciliation" pane should close

  Scenario: Duplicate Interaction display between New and Existing Med CHMOrders
    When "TEST5 CPOEPAT5" is on the patient list
    And I select patient "TEST5 CPOEPAT5" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Continue Home Meds" button
    And I click the "OK" button in the "Warning" pane if it exists
    Then the "Continue Home Medication" pane should load
    And I click the "Add" link in the "Hospital OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "adenosine" in the "Hospital Search For Order" field in the "Continue Home Medication" pane
    And I select "ATP tablet,delayed release (adenosine triphosphate)  25MG Oral" from the "Searched NonFormulary MedOrders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    And I reconcile and Submit the Orders
    And I click the "Continue Home Meds" button
    And I click the "OK" button in the "Warning" pane if it exists
    Then the "Continue Home Medication" pane should load
    And I click the "Add" link in the "Hospital OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "ATP tablet,delayed release (adenosine triphosphate)  25MG Oral" in the "Hospital Search For Order" field in the "Continue Home Medication" pane
    And I select "the first item" from the "Searched NonFormulary MedOrders" list in the search results
    Then the "Clinical Decision Support Warnings" pane should load
    And the text "Duplicates" should appear in the "Clinical Decision Support Warnings" pane
    And the text "ATP 25 mg tablet,delayed release and ATP 25 mg tablet,delayed release are not screened in Duplicate Therapy because they do not meet inclusion criteria for screening." should appear in the "Clinical Decision Support Warnings" pane
    And I click the "DontOrder" button in the "Clinical Decision Support Warnings" pane
    When I click the "MedRec Cancel" button
    And I click the "Yes" button in the "Question" pane
  #Then the "Continue Home Medication" pane should close

  Scenario: Enable Interaction Severity Display
    When I am on the "Admin" tab
    And I select the "Facility Group" subtab
    And I click the "CPOE Utilities" link in the "Facility Group Navigation" pane
    And I click the "Interaction Checking" element if it exists
    And I click the "Edit_CPOEUtilities" button
    And I wait up to "20" seconds for the "Edit Facility Group Utlity Settings Loading Icon" field of type "MISC_ELEMENT" to be invisible
    And the "Edit Facility Group Utilities Settings" pane should load
    And I edit the following settings in the "Edit Facility Group Utilities Settings" pane
      |Name                                   |Type     |Value                     |
      |Medication Duplicate Display           |dropdown |Disabled                  |
      |New Medication Duplicate Display       |dropdown |Disabled                  |
      |Contraindicated Drug Combination       |dropdown |Popup and Require Reason  |
      |Severe Interaction                     |dropdown |Popup and Require Reason  |
      |Moderate Interaction                   |dropdown |Popup and Require Reason  |
      |Drug Allergy Display                   |dropdown |Popup and Require Reason  |
      |Undetermined Severity                  |dropdown |Popup and Require Reason  |
    Then I click the "Save_EditFacility Group Utility Settings" button
#    When I enable interaction severity display
#    And I enable the drug allergy display interaction checking option
#   # Not dealing with Duplicate medication interaction display, better to disable it.
#    And I disable the medication duplicate display interaction checking option

  Scenario Outline: Drug interaction Severity display between two new orders
    Given I am on the "Patient List V2" tab
    When "<Patient>" is on the patient list
    And I select patient "<Patient>" from the patient list
    And I select "Orders" from clinical navigation
    And I search for the "<Order Text1>" order
    And I select CPOE "Medication Orders" tab
    And I select "<Order1>" from the "<Search List1>" list in the search results
    And I fill the mandatory order details in the "Edit Order" pane if it exists
    Given I am on the "Patient List V2" tab
    And I select patient "<Patient>" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Enter Orders" button
    And I enter "<Order2>" in the "Add Order" field in the "Enter Orders" pane
    And I select CPOE "Medication Orders" tab
    And I select "the first item" from the "<Search List2>" list in the search results
    Then the "Order Clinical Decision Support Warnings" pane should load
    And the text "<Interaction Message1>" should appear in the "Order Clinical Decision Support Warnings" pane
    And the text "<Interaction Message2>" should appear in the "Order Clinical Decision Support Warnings" pane
    When I select "Provider Aware - Continue as ordered" as override reason in the "Order Clinical Decision Support Warnings" pane
    And I click the "CDSW OK" button in the "Order Clinical Decision Support Warnings" pane
    And I fill the mandatory order details in the "Order Clinical Decision Support Warnings" pane if it exists
    And I click the "CDSW OK" button in the "Order Clinical Decision Support Warnings" pane
    Then the "Order Clinical Decision Support Warnings" pane should close
    When I Submit the Orders
    Then the "Enter Orders" pane should close

    Examples:
      | Patient        | Order Text1    | Order1                                    | Search List1           | Order Text2   | Order2                                              | Search List2           | Interaction Message1                                    | Interaction Message2                                                                                                                                   |
      | TEST1 CPOEPAT1 | Tikosyn        | Tikosyn capsule (dofetilide)  125MCG Oral | NonFormulary MedOrders | megestrol     | megestrol tablet  20MG Oral                         | NonFormulary MedOrders | Contraindicated Drug Combination                        | Tikosyn 125 mcg capsule and megestroL 20 mg tablet may interact based on the potential interaction between DOFETILIDE and MEGESTROL.                   |
#     |TEST2 CPOEPAT2 |carmustine    |carmustine IV Solution 100MG IV            |NonFormulary MedOrders |Cimetidine    |cimetidine tablet  300MG Oral                                           |NonFormulary MedOrders |Severe Interaction                                      |carmustine 100 mg IV Solution and cimetidine 300 mg tablet may interact based on the potential interaction between CARMUSTINE and CIMETIDINE.                                                         |
      | TEST2 CPOEPAT2 | carmustine     | carmustine IV Solution  100MG             | NonFormulary MedOrders | Cimetidine    | cimetidine tablet  300MG Oral                       | NonFormulary MedOrders | Severe Interaction                                      | carmustine 100 mg intravenous solution and cimetidine 300 mg tablet may interact based on the potential interaction between CARMUSTINE and CIMETIDINE. |
      | TEST3 CPOEPAT3 | Lanoxin tablet | Lanoxin tablet (digoxin)  125MCG Oral     | NonFormulary MedOrders | Tetracycline  | Adoxa capsule (doxycycline monohydrate)  150MG Oral | NonFormulary MedOrders | Moderate Interaction                                    | Lanoxin 125 mcg (0.125 mg) tablet and Adoxa 150 mg capsule may interact based on the potential interaction between DIGOXIN, ORAL and TETRACYCLINES.    |
      | TEST4 CPOEPAT4 | Bayer Aspirin  | Bayer Aspirin tablet (aspirin) 325MG Oral | NonFormulary MedOrders | ginkgo biloba | Ginkgo tablet (ginkgo biloba)  60MG Oral            | NonFormulary MedOrders | Undetermined Severity - Alternative Therapy Interaction | Bayer Aspirin 325 mg tablet and Ginkgo 60 mg tablet may interact based on the potential interaction between ASPIRIN; ALOXIPRIN and GINKGO BILOBA.      |
#	  |TEST5 CPOEPAT5 |cephalexin    |cephalexin capsule 250MG Oral              |NonFormulary MedOrders |penicillin    |penicillin V potassium tablet  250MG Oral |NonFormulary MedOrders |Duplicates                                              |Use of penicillin V potassium 250 mg tablet and cephalexin 250 mg capsule may represent a duplication in therapy based on their association to the therapeutic drug class Beta-Lactams.                          |

  Scenario Outline: Drug interaction Severity display between two new orders from AMR
    When "<Patient>" is on the patient list
    And I select patient "<Patient>" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Adm Med Rec" button in the "Orders" pane
    Then the "Admission Medication Reconciliation" pane should load
    When I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home Medications*" cell header in the "Medication Reconciliation" table if table exists
    And I enter "<Order Text1>" in the "Search for order" field in the "Search for order" pane
    And I select CPOE "Medication Orders" tab in the "Search for order" pane
    And I select "<Order1>" from the "<Search List1>" list in the search results
   #Need to continue if the selected discharge medication is having 'a route of IV'
    And I click the "Yes" button in the "Question" pane if it exists
    And I fill the mandatory order details in the "Search for order" pane if it exists
    And I select the "Continue" radio in the row with "<textVal1>" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table
    And I enter "<Order2>" in the "Search for order" field in the "Search for order" pane
    And I select CPOE "Medication Orders" tab in the "Search for order" pane
    And I select "the first item" from the "<Search List2>" list in the search results
    Then the "Clinical Decision Support Warnings" pane should load
    And the text "<Interaction Message1>" should appear in the "Clinical Decision Support Warnings" pane
    And the text "<Interaction Message2>" should appear in the "Clinical Decision Support Warnings" pane
    When I select "Provider Aware - Continue as ordered" as override reason in the "Clinical Decision Support Warnings" pane
    And I click the "CDSW OK" button in the "Clinical Decision Support Warnings" pane
    And I fill the mandatory order details in the "Clinical Decision Support Warnings" pane if it exists
#    And I fill the mandatory order details in the "Clinical Decision Support Warnings" pane if it exists
    When I reconcile and Submit the Orders
    Then the "Admission Medication Reconciliation" pane should close

    Examples:
      | Patient        | Order Text1   | Order1                                    | Search List1                 | Order Text2   | Order2                                                     | Search List2                 | Interaction Message1                                    | Interaction Message2                                                                                                                                         | textVal1           | textVal2           |
      | TEST6 CPOEPAT6 | Tikosyn       | Tikosyn capsule (dofetilide)  125MCG Oral | Searched Combined Med Orders | megestrol     | Megace 400 mg/10 mL (40 mg/mL) Oral Susp (megestrol)  Oral | Searched Combined Med Orders | Contraindicated Drug Combination                        | Tikosyn 125 mcg capsule and Megace 400 mg/10 mL (40 mg/mL) oral suspension may interact based on the potential interaction between DOFETILIDE and MEGESTROL. | New: Tikosyn       | New: Megace        |
      | TEST7 CPOEPAT7 | carmustine    | carmustine IV Solution 100MG              | Searched Combined Med Orders | Cimetidine    | cimetidine tablet  300MG Oral                              | Searched Combined Med Orders | Severe Interaction                                      | carmustine 100 mg intravenous solution and cimetidine 300 mg tablet may interact based on the potential interaction between CARMUSTINE and CIMETIDINE.       | New: carmustine    | New: cimetidine    |
      | TEST8 CPOEPAT8 | digoxin       | Lanoxin tablet (digoxin)  125MCG Oral     | Searched Combined Med Orders | Tetracycline  | Adoxa capsule (doxycycline monohydrate)  150MG Oral        | Searched Combined Med Orders | Moderate Interaction                                    | Lanoxin 125 mcg (0.125 mg) tablet and Adoxa 150 mg capsule may interact based on the potential interaction between DIGOXIN, ORAL and TETRACYCLINES.          | New: Lanoxin       | New: Adoxa capsule |
      | TEST9 CPOEPAT9 | Bayer Aspirin | Bayer Aspirin tablet (aspirin) 325MG Oral | Searched Combined Med Orders | ginkgo biloba | Ginkgo tablet (ginkgo biloba)  60MG Oral                   | Searched Combined Med Orders | Undetermined Severity - Alternative Therapy Interaction | Bayer Aspirin 325 mg tablet and Ginkgo 60 mg tablet may interact based on the potential interaction between ASPIRIN; ALOXIPRIN and GINKGO BILOBA.            | New: Bayer Aspirin | New: Ginkgo tablet |
#			|TEST10 CPOEPAT10 |cephalexin    |cephalexin capsule 250MG Oral              |Searched Combined Med Orders    |penicillin    |penicillin V potassium tablet  250MG Oral |Searched Combined Med Orders    |Duplicates                                              |Use of penicillin V potassium 250 mg tablet and cephalexin 250 mg capsule may represent a duplication in therapy based on their association to the therapeutic drug class Beta-Lactams. |New: cephalexin    |New: penicillin    |


  Scenario Outline: Drug interaction Severity display between Existing and new orders from AMR
    When "<Patient>" is on the patient list
    And I select patient "<Patient>" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Adm Med Rec" button in the "Orders" pane
    Then the "Admission Medication Reconciliation" pane should load
    When I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "<Order Text1>" in the "Search for order" field in the "Search for order" pane
    And I select CPOE "Medication Orders" tab in the "Search for order" pane
    And I select "<Order1>" from the "<Search List1>" list in the search results
    And I fill the mandatory order details in the "Search for order" pane if it exists
    And I select the "Continue" radio in the row with "<textVal1>" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I reconcile and Submit the Orders
    And I click the "Adm Med Rec" button in the "Orders" pane
    And I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "<Order1>" in the "Search for order" field in the "Search for order" pane
    And I select CPOE "Medication Orders" tab in the "Search for order" pane
    And I select "the first item" from the "<Search List1>" list in the search results
    And I fill the mandatory order details in the "Search for order" pane if it exists
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table
    And I enter "<Order2>" in the "Search for order" field in the "Search for order" pane
    And I select "the first item" from the "<Search List2>" list in the search results
    Then the "Clinical Decision Support Warnings" pane should load
    And the text "<Interaction Message1>" should appear in the "Clinical Decision Support Warnings" pane
    And the text "<Interaction Message2>" should appear in the "Clinical Decision Support Warnings" pane
    When I click the "Dont Order" button in the "Clinical Decision Support Warnings" pane
    Then the "Clinical Decision Support Warnings" pane should close
    When I click the "MedRec Cancel" button
    And I click the "Yes" button in the "Question" pane
    Then the "Admission Medication Reconciliation" pane should close

    Examples:
      | Patient          | Order Text1 | Order1                                    | Search List1                 | Order Text2  | Order2                                              | Search List2                 | Interaction Message1             | Interaction Message2                                                                                                                                   | textVal1        |
      | TEST12 CPOEPAT12 | Tikosyn     | Tikosyn capsule (dofetilide)  125MCG Oral | Searched Combined Med Orders | megestrol    | Orap tablet (pimozide)  2MG Oral                    | Searched Combined Med Orders | Contraindicated Drug Combination | Orap 2 mg tablet and Tikosyn 125 mcg capsule may interact based on the potential interaction between PIMOZIDE and SELECTED ANTIARRHYTHMICS.            | New: Tikosyn    |
      | TEST6 CPOEPAT6   | carmustine  | carmustine IV Solution 100MG IV           | Searched Combined Med Orders | Cimetidine   | cimetidine tablet  300MG Oral                       | Searched Combined Med Orders | Severe Interaction               | carmustine 100 mg intravenous solution and cimetidine 300 mg tablet may interact based on the potential interaction between CARMUSTINE and CIMETIDINE. | New: carmustine |
      | TEST10 CPOEPAT10 | digoxin     | Lanoxin tablet (digoxin)  125MCG Oral     | Searched Combined Med Orders | Tetracycline | Adoxa capsule (doxycycline monohydrate)  150MG Oral | Searched Combined Med Orders | Moderate Interaction             | Lanoxin 125 mcg (0.125 mg) tablet and Adoxa 150 mg capsule may interact based on the potential interaction between DIGOXIN, ORAL and TETRACYCLINES.    | New: Lanoxin    |
       # Example for 'TEST8, CPOEPAT8' is split into a seperate scenario below
#      |TEST8 CPOEPAT8   |Bayer Aspirin |Bayer Aspirin tablet (aspirin) 325MG Oral |Searched Combined Med Orders    |ginkgo biloba |ginkgo biloba capsule  40MG Oral          |Searched Combined Med Orders    |Undetermined Severity - Alternative Therapy Interaction |Bayer Aspirin 325 mg tablet and ginkgo biloba 40 mg capsule may interact based on the potential interaction between ASPIRIN; ALOXIPRIN and GINKGO BILOBA.                               |New: Bayer Aspirin |
#			|TEST9 CPOEPAT9   |cephalexin    |cephalexin capsule  250MG Oral            |Searched Combined Med Orders    |penicillin    |penicillin V potassium tablet  250MG Oral |Searched Combined Med Orders    |Duplicates                                              |Use of penicillin V potassium 250 mg tablet and cephalexin 250 mg capsule may represent a duplication in therapy based on their association to the therapeutic drug class Beta-Lactams. |New: cephalexin    |

  Scenario: Drug interaction Severity display between Existing and New orders from AMR
    When "TEST30 CPOEPAT30" is on the patient list
    And I select patient "TEST30 CPOEPAT30" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Adm Med Rec" button in the "Orders" pane
    Then the "Admission Medication Reconciliation" pane should load
    When I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "Bayer Aspirin" in the "Search for order" field in the "Search for order" pane
    And I select CPOE "Medication Orders" tab in the "Search for order" pane
    And I select "Bayer Aspirin tablet (aspirin) 325MG Oral" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Search for order" pane if it exists
    # Commenting the below step as the order is already submitted in above scenarios
    And I select the "Continue" radio in the row with "New: Bayer Aspirin tablet (aspirin) 325 mg Oral Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I reconcile and Submit the Orders
    And I click the "Adm Med Rec" button in the "Orders" pane
    And I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I enter "Bayer Aspirin tablet (aspirin) 325MG Oral" in the "Search for order" field in the "Search for order" pane
    And I select CPOE "Medication Orders" tab in the "Search for order" pane
    And I select "the first item" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Search for order" pane if it exists
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table
    And I enter "Ginkgo tablet (ginkgo biloba)  60MG Oral" in the "Search for order" field in the "Search for order" pane
    And I select "the first item" from the "Searched Combined Med Orders" list in the search results
    Then the "Clinical Decision Support Warnings" pane should load
    And the text "Undetermined Severity - Alternative Therapy Interaction" should appear in the "Clinical Decision Support Warnings" pane
    And the text "Bayer Aspirin 325 mg tablet and Ginkgo 60 mg tablet may interact based on the potential interaction between ASPIRIN; ALOXIPRIN and GINKGO BILOBA." should appear in the "Clinical Decision Support Warnings" pane
    When I click the "Dont Order" button in the "Clinical Decision Support Warnings" pane
    Then the "Clinical Decision Support Warnings" pane should close
    When I click the "MedRec Cancel" button
    And I click the "Yes" button in the "Question" pane
    Then the "Admission Medication Reconciliation" pane should close
    And I click the logout button

  Scenario Outline: Drug interaction Severity display between two new orders from DMR
    When "<Patient>" is on the patient list
    And I select patient "<Patient>" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Discharge Med Rec" button in the "Orders" pane
#    Then the "Discharge Medication Reconciliation" pane should load
    When I click the "here" link if it exists in the "Discharge Medication Reconciliation" pane
    And I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "<Order Text1>" in the "Discharge Search For Order" field in the "Search for order" pane
    And I select CPOE "Medication Orders" tab in the "Search for order" pane
    And I select "<Order1>" from the "<Search List1>" list in the search results
   #Need to continue if the selected discharge medication is having 'a route of IV'
    And I click the "Yes" button in the "Question" pane if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table
    And I enter "<Order2>" in the "Discharge Search For Order" field in the "Search for order" pane
    And I select CPOE "Medication Orders" tab in the "Search for order" pane
    And I select "the first item" from the "<Search List2>" list in the search results
   #Question dialog appears if medication has 'IV'
    And I click the "Yes" button in the "Question" pane if it exists
#    Then the "Clinical Decision Support Warnings" pane should load
    And the text "<Interaction Message1>" should appear in the "Clinical Decision Support Warnings" pane
    And the text "<Interaction Message2>" should appear in the "Clinical Decision Support Warnings" pane
    When I select "Provider Aware - Continue as ordered" as override reason in the "Clinical Decision Support Warnings" pane
    And I click the "CDSW OK" button in the "Clinical Decision Support Warnings" pane
    And I fill the DMR mandatory order details in the "Clinical Decision Support Warnings" pane if it exists
    Then the "Clinical Decision Support Warnings" pane should close
    When I Stop all the medications in the "Discharge Medication Reconciliation" pane
    And I reconcile and Submit the Orders
    Then the "Discharge Medication Reconciliation" pane should close

    Examples:
      | Patient          | Order Text1   | Order1                                    | Search List1                 | Order Text2   | Order2                                              | Search List2                 | Interaction Message1                                    | Interaction Message2                                                                                                                                   |
      | TEST1 CPOEPAT1   | Tikosyn       | Tikosyn capsule (dofetilide)  125MCG Oral | Searched Combined Med Orders | megestrol     | Orap tablet (pimozide)  2MG Oral                    | Searched Combined Med Orders | Contraindicated Drug Combination                        | Orap 2 mg tablet and Tikosyn 125 mcg capsule may interact based on the potential interaction between PIMOZIDE and SELECTED ANTIARRHYTHMICS.            |
      | TEST30 CPOEPAT30 | carmustine    | carmustine IV Solution 100MG              | Searched Combined Med Orders | Cimetidine    | cimetidine tablet  300MG Oral                       | Searched Combined Med Orders | Severe Interaction                                      | carmustine 100 mg intravenous solution and cimetidine 300 mg tablet may interact based on the potential interaction between CARMUSTINE and CIMETIDINE. |
      | TEST3 CPOEPAT3   | digoxin       | Lanoxin tablet (digoxin)  125MCG Oral     | Searched Combined Med Orders | Tetracycline  | Adoxa capsule (doxycycline monohydrate)  150MG Oral | Searched Combined Med Orders | Moderate Interaction                                    | Lanoxin 125 mcg (0.125 mg) tablet and Adoxa 150 mg capsule may interact based on the potential interaction between DIGOXIN, ORAL and TETRACYCLINES.    |
      | TEST4 CPOEPAT4   | Bayer Aspirin | Bayer Aspirin tablet (aspirin) 325MG Oral | Searched Combined Med Orders | ginkgo biloba | Ginkgo tablet (ginkgo biloba)  60MG Oral            | Searched Combined Med Orders | Undetermined Severity - Alternative Therapy Interaction | Bayer Aspirin 325 mg tablet and Ginkgo 60 mg tablet may interact based on the potential interaction between ASPIRIN; ALOXIPRIN and GINKGO BILOBA.      |
#			|TEST11 CPOEPAT11 |cephalexin    |cephalexin capsule  250MG Oral            |Searched Combined Med Orders    |penicillin    |penicillin V potassium tablet  250MG Oral |Searched Combined Med Orders    |Duplicates                                              |Use of penicillin V potassium 250 mg tablet and cephalexin 250 mg capsule may represent a duplication in therapy based on their association to the therapeutic drug class Beta-Lactams.      |


  Scenario Outline: Drug interaction Severity display between existing and new order from DMR
    When "<Patient>" is on the patient list
    And I select patient "<Patient>" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Discharge Med Rec" button in the "Orders" pane
    Then the "Discharge Medication Reconciliation" pane should load
    When I click the "here" link if it exists in the "Discharge Medication Reconciliation" pane
    And I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "<Order Text1>" in the "Discharge Search For Order" field in the "Search for order" pane
    And I select CPOE "Medication Orders" tab in the "Search for order" pane
    And I select "<Order1>" from the "<Search List1>" list in the search results
   #Need to continue if the selected discharge medication is having 'a route of IV'
    And I click the "Yes" button in the "Question" pane if it exists
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
    And I Stop all the medications in the "Discharge Medication Reconciliation" pane
    And I reconcile and Submit the Orders
    And I click the "Discharge Med Rec" button in the "Orders" pane
    And I click the "here" link if it exists in the "Discharge Medication Reconciliation" pane
    And I click the "Add" link if it exists in the "Discharge Medication Reconciliation" pane
    And I enter "<Order2>" in the "Discharge Search For Order" field in the "Search for order" pane
    And I select CPOE "Medication Orders" tab in the "Search for order" pane
    And I select "the first item" from the "<Search List2>" list in the search results
   #Question dialog appears if medication has 'IV'
    And I click the "Yes" button in the "Question" pane if it exists
    Then the "Clinical Decision Support Warnings" pane should load
    And the text "<Interaction Message1>" should appear in the "Clinical Decision Support Warnings" pane
    And the text "<Interaction Message2>" should appear in the "Clinical Decision Support Warnings" pane
    When I click the "Dont Order" button in the "Clinical Decision Support Warnings" pane
    Then the "Clinical Decision Support Warnings" pane should close
    When I click the "MedRec Cancel" button
    And I click the "Yes" button in the "Question" pane
 #		Then the "Discharge Medication Reconciliation" pane should close

    Examples:
      | Patient          | Order Text1   | Order1                                    | Search List1                 | Order Text2   | Order2                                              | Search List2                 | Interaction Message1                                    | Interaction Message2                                                                                                                                   |
      | TEST6 CPOEPAT6   | Tikosyn       | Tikosyn capsule (dofetilide)  125MCG Oral | Searched Combined Med Orders | megestrol     | Orap tablet (pimozide)  2MG Oral                    | Searched Combined Med Orders | Contraindicated Drug Combination                        | Orap 2 mg tablet and Tikosyn 125 mcg capsule may interact based on the potential interaction between PIMOZIDE and SELECTED ANTIARRHYTHMICS.            |
      | TEST7 CPOEPAT7   | carmustine    | carmustine IV Solution  100MG             | Searched Combined Med Orders | Cimetidine    | cimetidine tablet  300MG Oral                       | Searched Combined Med Orders | Severe Interaction                                      | carmustine 100 mg intravenous solution and cimetidine 300 mg tablet may interact based on the potential interaction between CARMUSTINE and CIMETIDINE. |
      | TEST9 CPOEPAT9   | digoxin       | Lanoxin tablet (digoxin)  125MCG Oral     | Searched Combined Med Orders | Tetracycline  | Adoxa capsule (doxycycline monohydrate)  150MG Oral | Searched Combined Med Orders | Moderate Interaction                                    | Lanoxin 125 mcg (0.125 mg) tablet and Adoxa 150 mg capsule may interact based on the potential interaction between DIGOXIN, ORAL and TETRACYCLINES.    |
      | TEST10 CPOEPAT10 | Bayer Aspirin | Bayer Aspirin tablet (aspirin) 325MG Oral | Searched Combined Med Orders | ginkgo biloba | Ginkgo tablet (ginkgo biloba)  60MG Oral            | Searched Combined Med Orders | Undetermined Severity - Alternative Therapy Interaction | Bayer Aspirin 325 mg tablet and Ginkgo 60 mg tablet may interact based on the potential interaction between ASPIRIN; ALOXIPRIN and GINKGO BILOBA.      |

  Scenario: Drug allergy display for an order from DMR
    When "MOLLY DARR" is on the patient list
    And I select patient "MOLLY DARR" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Discharge Med Rec" button in the "Orders" pane
    Then the "Discharge Medication Reconciliation" pane should load
    When I click the "here" link if it exists in the "Discharge Medication Reconciliation" pane
    And I click the "Add" link in the "Discharge OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "cephalexin" in the "Discharge Search For Order" field in the "Search for order" pane
    And I select CPOE "Medication Orders" tab in the "Search for order" pane
    And I select "cephalexin capsule  250MG Oral" from the "Searched Combined Med Orders" list in the search results
    And I fill the DMR mandatory order details in the "Edit Medication Order" pane if it exists
   #Need to continue if the selected discharge medication is having 'a route of IV'
    And I click the "Yes" button in the "Question" pane if it exists
    Then the "Clinical Decision Support Warnings" pane should load
    And the text "Allergies" should appear in the "Clinical Decision Support Warnings" pane
    And the text "The use of cephalexin capsule  may result in an allergic reaction based on a reported history of allergy to Drug: Penicillin" should appear in the "Clinical Decision Support Warnings" pane
    When I click the "Dont Order" button in the "Clinical Decision Support Warnings" pane
    Then the "Clinical Decision Support Warnings" pane should close
    When I click the "MedRec Cancel" button
    And I click the "Yes" button in the "Question" pane
    Then the "Discharge Medication Reconciliation" pane should close

  Scenario Outline: Drug interaction Severity display between two new orders from CHM
    When "<Patient>" is on the patient list
    And I select patient "<Patient>" from the patient list
      #Adding steps to place AMR order as these scenarios were failing without home meds
    And I select "Orders" from clinical navigation
    And I click the "Adm Med Rec" button in the "Orders" pane
    Then the "Admission Medication Reconciliation" pane should load
    When I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "ASPIRIN EC" in the "Search for order" field in the "Search for order" pane
    And I select "ASPIRIN EC 1 TAB 325MG Oral Daily" from the "Searched Combined Med Orders" list in the search results
    And I select the "Continue" radio in the row with "New: ASPIRIN EC 1 TAB 325MG Oral Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I reconcile and Submit the Orders
    And I wait "2" seconds
    And I select "Orders" from clinical navigation
    And I click the "Continue Home Meds" button in the "Orders" pane
    Then the "Continue Home Medication" pane should load
    When I click the "Add" link in the "Hospital OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "<Order1>" in the "Hospital Search For Order" field in the "Continue Home Medication" pane
    And I select CPOE "Medication Orders" tab in the "Search for order" pane
    And I select "the first item" from the "<Search List1>" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    And I click the "Add" link in the "Hospital OrdersAdd" cell header in the "Medication Reconciliation" table
    And I enter "<Order2>" in the "Hospital Search For Order" field in the "Continue Home Medication" pane
    And I select CPOE "Medication Orders" tab in the "Search for order" pane
    And I select "the first item" from the "<Search List2>" list in the search results
    Then the "Clinical Decision Support Warnings" pane should load
    And the text "<Interaction Message1>" should appear in the "Clinical Decision Support Warnings" pane
    And the text "<Interaction Message2>" should appear in the "Clinical Decision Support Warnings" pane
    When I select "Provider Aware - Continue as ordered" as override reason in the "Clinical Decision Support Warnings" pane
    And I click the "CDSW OK" button in the "Clinical Decision Support Warnings" pane
    And I fill the mandatory order details in the "Clinical Decision Support Warnings" pane if it exists
    Then the "Clinical Decision Support Warnings" pane should close
    And I wait "2" seconds
    When I reconcile and Submit the Orders
    Then the "Continue Home Medication" pane should close

    Examples:
      |Patient              |Order Text1   |Order1                                               |Search List1                    |Order Text2   |Order2                                                                   |Search List2                    |Interaction Message1                                    |Interaction Message2                                                                                                                                                                         |
      |CPOEPAT13, TEST13    |sildenafil    |Revatio tablet (sildenafil)  20MG Oral               |Searched NonFormulary MedOrders |isosorbide    |Imdur tablet,extended release (isosorbide mononitrate)  30MG Oral        |Searched NonFormulary MedOrders |Contraindicated Drug Combination                        |Revatio 20 mg tablet and Imdur 30 mg tablet,extended release may interact based on the potential interaction between CGMP SPECIFIC PDE TYPE-5 INHIBITORS and NITRATES.                       |
   #  |TEST8 CPOEPAT8       |digoxin       |Lanoxin tablet (digoxin)  125MCG Oral     |Searched NonFormulary MedOrders |Tetracycline  |tetracycline capsule  250MG Oral          |Searched NonFormulary MedOrders |Moderate Interaction                                    |Lanoxin 125 mcg tablet and tetracycline 250 mg capsule may interact based on the potential interaction between DIGOXIN, ORAL and TETRACYCLINES.                               |
      |TEST5 CPOEPAT5       |Bayer Aspirin |Bayer Aspirin tablet (aspirin) 325MG Oral            |Searched NonFormulary MedOrders |ginkgo biloba |Ginkgo tablet (ginkgo biloba)  60MG Oral                                 |Searched NonFormulary MedOrders |Undetermined Severity - Alternative Therapy Interaction |Bayer Aspirin 325 mg tablet and Ginkgo 60 mg tablet may interact based on the potential interaction between ASPIRIN; ALOXIPRIN and GINKGO BILOBA.                                            |
   #|TEST1 CPOEPAT1   |cephalexin    |cephalexin capsule 250MG Oral             |Searched NonFormulary MedOrders |penicillin    |penicillin V potassium tablet  250MG Oral |Searched NonFormulary MedOrders |Duplicates                                              |Use of penicillin V potassium 250 mg tablet and cephalexin 250 mg capsule may represent a duplication in therapy based on their association to the therapeutic drug class Beta-Lactams. |

  Scenario: Moderate Drug interaction Severity display between two new orders from CHM
    When "CPOEPAT14, TEST14" is on the patient list
    And I select patient "CPOEPAT14, TEST14" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Adm Med Rec" button in the "Orders" pane
    Then the "Admission Medication Reconciliation" pane should load
    When I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "aspirin Rectal" in the "Search for order" field in the "Search for order" pane
    And I select CPOE "Medication Orders" tab in the "Search for order" pane
    And I select "aspirin Rectal Suppository  300MG" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    And I select the "Continue" radio in the row with "New: aspirin Rectal Suppository 300 mg Rect Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I reconcile and Submit the Orders
    And "CPOEPAT14, TEST14" is on the patient list
    And I select patient "CPOEPAT14, TEST14" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Continue Home Meds" button in the "Orders" pane
#    Then the "Continue Home Medication" pane should load
    When I click the "Add" link in the "Hospital OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "Lanoxin tablet (digoxin)  125MCG Oral" in the "Hospital Search For Order" field in the "Continue Home Medication" pane
    And I select CPOE "Medication Orders" tab in the "Search for order" pane
    And I select "the first item" from the "Searched NonFormulary MedOrders" list in the search results
    And I fill the mandatory order details in the "Search for order" pane if it exists
    And I click the "Add" link in the "Hospital OrdersAdd" cell header in the "Medication Reconciliation" table
    And I enter "Adoxa capsule (doxycycline monohydrate)  150MG Oral" in the "Hospital Search For Order" field in the "Continue Home Medication" pane
    And I select CPOE "Medication Orders" tab in the "Search for order" pane
    And I select "the first item" from the "Searched NonFormulary MedOrders" list in the search results
    Then the "Clinical Decision Support Warnings" pane should load
    When the text "Moderate Interaction" should appear in the "Clinical Decision Support Warnings" pane
    And the text "Lanoxin 125 mcg (0.125 mg) tablet and Adoxa 150 mg capsule may interact based on the potential interaction between DIGOXIN, ORAL and TETRACYCLINES." should appear in the "Clinical Decision Support Warnings" pane
    When I select "Provider Aware - Continue as ordered" as override reason in the "Clinical Decision Support Warnings" pane
    And I click the "CDSW OK" button in the "Clinical Decision Support Warnings" pane
    And I fill the mandatory order details in the "Clinical Decision Support Warnings" pane if it exists
    Then the "Clinical Decision Support Warnings" pane should close
    When I reconcile and Submit the Orders
    Then the "Continue Home Medication" pane should close

  Scenario Outline: Drug interaction Severity display between existing and new orders from CHM
    When "<Patient>" is on the patient list
    And I select patient "<Patient>" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Adm Med Rec" button in the "Orders" pane
    And I click the "Yes" button in the "Question" pane if it exists
    Then the "Admission Medication Reconciliation" pane should load
    When I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    And I click the "Yes" button in the "Question" pane if it exists
    And I enter "ASPIRIN EC" in the "Search for order" field in the "Search for order" pane
    And I select "ASPIRIN EC 1 TAB 325MG Oral Daily" from the "Searched Combined Med Orders" list in the search results
    And I select the "Continue" radio in the row with "New: ASPIRIN EC 1 TAB 325MG Oral Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I reconcile and Submit the Orders
    And I wait "2" seconds
    And I select "Orders" from clinical navigation
    And I click the "Continue Home Meds" button in the "Orders" pane
    Then the "Continue Home Medication" pane should load
    And I click the "Yes" button in the "Question" pane if it exists
    When I click the "Add" link in the "Hospital OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "<Order1>" in the "Hospital Search For Order" field in the "Continue Home Medication" pane
    And I select CPOE "Medication Orders" tab in the "Search for order" pane
    And I select "the first item" from the "<Search List1>" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    And I click the "Add" link in the "Hospital OrdersAdd" cell header in the "Medication Reconciliation" table
    And I enter "<Order2>" in the "Hospital Search For Order" field in the "Continue Home Medication" pane
    And I select CPOE "Medication Orders" tab in the "Search for order" pane
    And I select "the first item" from the "<Search List2>" list in the search results
    Then the "Clinical Decision Support Warnings" pane should load
    And the text "<Interaction Message1>" should appear in the "Clinical Decision Support Warnings" pane
    And the text "<Interaction Message2>" should appear in the "Clinical Decision Support Warnings" pane
    When I select "Provider Aware - Continue as ordered" as override reason in the "Clinical Decision Support Warnings" pane
    And I click the "CDSW OK" button in the "Clinical Decision Support Warnings" pane
    And I fill the mandatory order details in the "Clinical Decision Support Warnings" pane if it exists
    Then the "Clinical Decision Support Warnings" pane should close
    And I wait "2" seconds
    When I reconcile and Submit the Orders
    Then the "Continue Home Medication" pane should close

    Examples:
      | Patient        | Order Text1 | Order1                                    | Search List1                    | Order Text2 | Order2                           | Search List2                    | Interaction Message1             | Interaction Message2                                                                                                                                   |
      | TEST1 CPOEPAT1 | carmustine  | carmustine IV Solution  100MG             | Searched NonFormulary MedOrders | Cimetidine  | cimetidine tablet  300MG Oral    | Searched NonFormulary MedOrders | Severe Interaction               | carmustine 100 mg intravenous solution and cimetidine 300 mg tablet may interact based on the potential interaction between CARMUSTINE and CIMETIDINE. |
      | TEST9 CPOEPAT9 | Tikosyn     | Tikosyn capsule (dofetilide)  125MCG Oral | Searched NonFormulary MedOrders | megestrol   | Orap tablet (pimozide)  2MG Oral | Searched NonFormulary MedOrders | Contraindicated Drug Combination | Orap 2 mg tablet and Tikosyn 125 mcg capsule may interact based on the potential interaction between PIMOZIDE and SELECTED ANTIARRHYTHMICS.            |
#      |TEST10 CPOEPAT10 |digoxin       |Lanoxin tablet (digoxin)  125MCG Oral     |Searched NonFormulary MedOrders |Tetracycline  |tetracycline capsule  250MG Oral          |Searched NonFormulary MedOrders |Moderate Interaction                                    |Lanoxin 125 mcg tablet and tetracycline 250 mg capsule may interact based on the potential interaction between DIGOXIN, ORAL and TETRACYCLINES.      |
#Commenting the above example and splitting it into a seperate scenario as meds need to be continued in AMR for the patient used in this example

  Scenario: Drug Interaction Severity display between Existing and New Orders from CHM
    When "TEST10 CPOEPAT10" is on the patient list
    And I select patient "TEST10 CPOEPAT10" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Adm Med Rec" button in the "Orders" pane
    And I click the "Yes" button in the "Question" pane if it exists
#    Then the "Admission Medication Reconciliation" pane should load
    When I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    And I click the "Yes" button in the "Question" pane if it exists
    And I enter "ASPIRIN EC" in the "Search for order" field in the "Search for order" pane
    And I select "ASPIRIN EC 1 TAB 325MG Oral Daily" from the "Searched Combined Med Orders" list in the search results
    And I select the "Continue" radio in the row with "New: ASPIRIN EC 1 TAB 325MG Oral Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I reconcile and Submit the Orders
    And I wait "2" seconds
    And I select "Orders" from clinical navigation
    And I click the "Continue Home Meds" button in the "Orders" pane
    Then the "Continue Home Medication" pane should load
    And I click the "Yes" button in the "Question" pane if it exists
    When I click the "Add" link in the "Hospital OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "Lanoxin tablet (digoxin)  125MCG Oral" in the "Hospital Search For Order" field in the "Continue Home Medication" pane
    And I select CPOE "Medication Orders" tab in the "Search for order" pane
    And I select "the first item" from the "Searched NonFormulary MedOrders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    And I click the "Add" link in the "Hospital OrdersAdd" cell header in the "Medication Reconciliation" table
    And I enter "Adoxa capsule (doxycycline monohydrate)  150MG Oral" in the "Hospital Search For Order" field in the "Continue Home Medication" pane
    And I select CPOE "Medication Orders" tab in the "Search for order" pane
    And I select "the first item" from the "Searched NonFormulary MedOrders" list in the search results
    Then the "Clinical Decision Support Warnings" pane should load
    And the text "Moderate Interaction" should appear in the "Clinical Decision Support Warnings" pane
    And the text "Lanoxin 125 mcg (0.125 mg) tablet and Adoxa 150 mg capsule may interact based on the potential interaction between DIGOXIN, ORAL and TETRACYCLINES." should appear in the "Clinical Decision Support Warnings" pane
    When I select "Provider Aware - Continue as ordered" as override reason in the "Clinical Decision Support Warnings" pane
    And I click the "CDSW OK" button in the "Clinical Decision Support Warnings" pane
    And I fill the mandatory order details in the "Clinical Decision Support Warnings" pane if it exists
    Then the "Clinical Decision Support Warnings" pane should close
    And I wait "2" seconds
    When I reconcile and Submit the Orders
    Then the "Continue Home Medication" pane should close

  Scenario Outline: Drug interaction Severity display between Existing and new orders from CHM
    When "<Patient>" is on the patient list
    And I select patient "<Patient>" from the patient list
   #Adding steps to place AMR order as these scenarios were failing without home meds
    And I select "Orders" from clinical navigation
    And I click the "Adm Med Rec" button in the "Orders" pane
    Then the "Admission Medication Reconciliation" pane should load
    And I click the "Yes" button in the "Question" pane if it exists
    When I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    And I click the "Yes" button in the "Question" pane if it exists
    And I enter "ASPIRIN EC" in the "Search for order" field in the "Search for order" pane
    And I select "ASPIRIN EC 1 TAB 325MG Oral Daily" from the "Searched Combined Med Orders" list in the search results
    And I select the "Continue" radio in the row with "New: ASPIRIN EC 1 TAB 325MG Oral Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I reconcile and Submit the Orders
    And I wait "2" seconds
    And I select "Orders" from clinical navigation
    And I click the "Continue Home Meds" button in the "Orders" pane
    And I click the "Yes" button in the "Question" pane if it exists
    And I click the "Add" link in the "Hospital OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "<Order1>" in the "Hospital Search For Order" field in the "Continue Home Medication" pane
    And I select CPOE "Medication Orders" tab in the "Search for order" pane
    And I select "the first item" from the "<Search List1>" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    And I click the "Add" link in the "Hospital OrdersAdd" cell header in the "Medication Reconciliation" table
    And I enter "<Order2>" in the "Hospital Search For Order" field in the "Continue Home Medication" pane
    And I select CPOE "Medication Orders" tab in the "Search for order" pane
    And I select "the first item" from the "<Search List2>" list in the search results
    Then the "Clinical Decision Support Warnings" pane should load
    And the text "<Interaction Message1>" should appear in the "Clinical Decision Support Warnings" pane
    And the text "<Interaction Message2>" should appear in the "Clinical Decision Support Warnings" pane
    When I click the "Dont Order" button in the "Clinical Decision Support Warnings" pane
    Then the "Clinical Decision Support Warnings" pane should close
    And I wait "2" seconds
    And I click the "MedRec Cancel" button
    And I click the "Yes" button in the "Question" pane
    Then the "Continue Home Medication" pane should close

    Examples:
      |Patient          |Order Text1   |Order1                                                          |Search List1                    |Order Text2   |Order2                                            |Search List2                    |Interaction Message1                                    |Interaction Message2                                                                                                                                                                    |
      |TEST12 CPOEPAT12 |carmustine    |carmustine IV Solution 100MG IV                                 |Searched NonFormulary MedOrders |Cimetidine    |cimetidine tablet  300MG Oral                     |Searched NonFormulary MedOrders |Severe Interaction                                      |carmustine 100 mg intravenous solution and cimetidine 300 mg tablet may interact based on the potential interaction between CARMUSTINE and CIMETIDINE.                                  |
#      |TEST6 CPOEPAT6   |Bayer Aspirin |12 Hour Nasal Relief Spray 0.05 % Aerosol (oxymetazoline)  Nasl |Searched NonFormulary MedOrders |ginkgo biloba |Ginkgo tablet (ginkgo biloba)  60MG Oral          |Searched NonFormulary MedOrders |Undetermined Severity - Alternative Therapy Interaction |aspirin 325 mg tablet and Ginkgo 60 mg tablet may interact based on the potential interaction between ASPIRIN; ALOXIPRIN and GINKGO BILOBA.                                       |
#			|TEST5 CPOEPAT5   |cephalexin    |cephalexin capsule 250MG Oral             |Searched NonFormulary MedOrders |penicillin    |penicillin V potassium tablet  250MG Oral |Searched NonFormulary MedOrders |Duplicates                                              |Use of penicillin V potassium 250 mg tablet and cephalexin 250 mg capsule may represent a duplication in therapy based on their association to the therapeutic drug class Beta-Lactams. |
  

  Scenario: Drug interaction Severity display between Existing and new orders from CHM
    When "TEST6 CPOEPAT6" is on the patient list
    And I select patient "TEST6 CPOEPAT6" from the patient list
   #Adding steps to place AMR order as these scenarios were failing without home meds
    And I select "Orders" from clinical navigation
    And I click the "Adm Med Rec" button in the "Orders" pane
    Then the "Admission Medication Reconciliation" pane should load
    And I click the "Yes" button in the "Question" pane if it exists
    When I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I click the "Add" link in the "Home MedicationsAdd" cell header in the "Medication Reconciliation" table if table exists
    And I click the "Yes" button in the "Question" pane if it exists
    And I enter "ASPIRIN EC" in the "Search for order" field in the "Search for order" pane
    And I select "ASPIRIN EC 1 TAB 325MG Oral Daily" from the "Searched Combined Med Orders" list in the search results
    And I select the "Continue" radio in the row with "New: ASPIRIN EC 1 TAB 325MG Oral Daily" as the value under "Home Medications*" in the "Medication Reconciliation" table
    And I reconcile and Submit the Orders
    And I wait "2" seconds
    And I select "Orders" from clinical navigation
    And I click the "Continue Home Meds" button in the "Orders" pane
    And I click the "Yes" button in the "Question" pane if it exists
    And I click the "Add" link in the "Hospital OrdersAdd" cell header in the "Medication Reconciliation" table if table exists
    And I enter "Nasal & Sinus Decongestant tablet (pseudoephedrine HCl)  30MG Oral" in the "Hospital Search For Order" field in the "Continue Home Medication" pane
    And I select CPOE "Medication Orders" tab in the "Search for order" pane
    And I select "the first item" from the "Searched NonFormulary MedOrders" list in the search results
    And I fill the mandatory order details in the "Search for order" pane if it exists
    And I click the "Add" link in the "Hospital OrdersAdd" cell header in the "Medication Reconciliation" table
    And I enter "Ginkgo tablet (ginkgo biloba)  60MG Oral" in the "Hospital Search For Order" field in the "Continue Home Medication" pane
    And I select CPOE "Medication Orders" tab in the "Search for order" pane
    And I select "the first item" from the "Searched NonFormulary MedOrders" list in the search results
    Then the "Clinical Decision Support Warnings" pane should load
    And the text "Undetermined Severity - Alternative Therapy Interaction" should appear in the "Clinical Decision Support Warnings" pane
    And the text "aspirin 325 mg tablet and Ginkgo 60 mg tablet may interact based on the potential interaction between ASPIRIN; ALOXIPRIN and GINKGO BILOBA." should appear in the "Clinical Decision Support Warnings" pane
    When I click the "Dont Order" button in the "Clinical Decision Support Warnings" pane
    Then the "Clinical Decision Support Warnings" pane should close
    And I wait "2" seconds
    And I click the "MedRec Cancel" button
    And I click the "Yes" button in the "Question" pane
    Then the "Continue Home Medication" pane should close

  Scenario Outline: Drug interaction Severity display between existing and new order
    When "<Patient>" is on the patient list
    And I select patient "<Patient>" from the patient list
    And I select "Orders" from clinical navigation
    And I search for the "<Order Text1>" order
    And I select CPOE "Medication Orders" tab
    And I select "<Order1>" from the "<Search List1>" list in the search results
    And I fill the mandatory order details in the "Edit Order" pane if it exists
    And I Submit the Orders
    And I search for the "<Order2>" order
    And I select CPOE "Medication Orders" tab
    And I select "the first item" from the "<Search List2>" list in the search results
    Then the "Order Clinical Decision Support Warnings" pane should load
    When I wait "3" seconds
    And the text "<Interaction Message1>" should appear in the "Order Clinical Decision Support Warnings" pane
    And the text "<Interaction Message2>" should appear in the "Order Clinical Decision Support Warnings" pane
    And I wait "2" seconds
    When I click the "Dont Order" button in the "Order Clinical Decision Support Warnings" pane
    Then the "Order Clinical Decision Support Warnings" pane should close
    When I click the "AddOrder Cancel" button
    And I click the "Yes" button in the "Question" pane if it exists
    Then the "Enter Orders" pane should close

    Examples:
      |Patient         |Order Text1 |Order1                                      |Search List1           |Order Text2   |Order2                                                                |Search List2           |Interaction Message1             |Interaction Message2                                                                                                                                                          |
      |TEST11 CPOEPAT11|Tikosyn     |Tikosyn capsule (dofetilide)  125MCG Oral   |NonFormulary MedOrders |megestrol     |Megace 400 mg/10 mL (40 mg/mL) Oral Susp (megestrol)  Oral            |NonFormulary MedOrders |Contraindicated Drug Combination |Tikosyn 125 mcg capsule and Megace 400 mg/10 mL (40 mg/mL) oral suspension may interact based on the potential interaction between DOFETILIDE and MEGESTROL.                  |
      |MEDREC RECON2   |carmustine  |carmustine IV Solution  100MG               |NonFormulary MedOrders |Cimetidine    |Acid Reducer (cimetidine) tablet (cimetidine)  200MG Oral             |NonFormulary MedOrders |Severe Interaction               |carmustine 100 mg intravenous solution and Acid Reducer (cimetidine) 200 mg tablet may interact based on the potential interaction between CARMUSTINE and CIMETIDINE.         |

  Scenario Outline: Moderate and Undetermined Severity Drug interaction Severity display between existing and new order
    When "<Patient>" is on the patient list
    And I select patient "<Patient>" from the patient list
    And I select "Orders" from clinical navigation
    And I search for the "<Order Text1>" order
    And I select CPOE "Medication Orders" tab
    And I select "<Order1>" from the "<Search List1>" list in the search results
    And I fill the mandatory order details in the "Edit Order" pane if it exists
    And I Submit the Orders
    And I search for the "<Order2>" order
    And I select CPOE "Medication Orders" tab
    And I select "the first item" from the "<Search List2>" list in the search results
    Then the "Order Clinical Decision Support Warnings" pane should load
    When I wait "3" seconds
    And the text "<Interaction Message1>" should appear in the "Order Clinical Decision Support Warnings" pane
    And the text "<Interaction Message2>" should appear in the "Order Clinical Decision Support Warnings" pane
    When I click the "Dont Order" button in the "Order Clinical Decision Support Warnings" pane
    Then the "Order Clinical Decision Support Warnings" pane should close
    When I click the "AddOrder Cancel" button
    And I click the "Yes" button in the "Question" pane if it exists
    Then the "Enter Orders" pane should close

    Examples:
      |Patient         |Order Text1   |Order1                                    |Search List1            |Order Text2       |Order2                                                         |Search List2           |Interaction Message1                                    |Interaction Message2                                                                                                                                                               |
      |MEDREC RECON3   |Lasix tablet  |Lasix tablet (furosemide)  20MG Oral      |NonFormulary MedOrders  |aliskiren tablet  |aliskiren tablet  150MG Oral                                   |NonFormulary MedOrders |Moderate Interaction                                    |Lasix 20 mg tablet and aliskiren 150 mg tablet may interact based on the potential interaction between FUROSEMIDE and ALISKIREN.                                                   |
      |TEST7 CPOEPAT7  |Lasix tablet  |Lasix tablet (furosemide)  20MG Oral      |NonFormulary MedOrders  |ginseng           |Korean ginseng root extract capsule  100MG Oral                |NonFormulary MedOrders |Undetermined Severity - Alternative Therapy Interaction |Lasix 20 mg tablet and Korean ginseng root extract 100 mg capsule may interact based on the potential interaction between LOOP DIURETICS and GINSENG.                              |
#			|TEST5 CPOEPAT5  |cephalexin    |cephalexin capsule 250MG Oral             |NonFormulary MedOrders |penicillin    |penicillin V potassium tablet  250MG Oral |NonFormulary MedOrders |Duplicates                                              |Use of penicillin V potassium 250 mg tablet and cephalexin 250 mg capsule may represent a duplication in therapy based on their association to the therapeutic drug class Beta-Lactams. |

  Scenario: Disable all the Interaction checking settings
    When I am on the "Admin" tab
    And I select the "Facility Group" subtab
    And I click the "CPOE Utilities" link in the "Facility Group Navigation" pane
    And I click the "Interaction Checking" element if it exists
    And I click the "Edit_CPOEUtilities" button
    And I wait up to "20" seconds for the "Edit Facility Group Utlity Settings Loading Icon" field of type "MISC_ELEMENT" to be invisible
    And the "Edit Facility Group Utilities Settings" pane should load
    And I edit the following settings in the "Edit Facility Group Utilities Settings" pane
      |Name                                   |Type     |Value     |
      |Non-Medication Duplicate Display       |dropdown |Disabled  |
      |New Non-Medication Duplicate Display   |dropdown |Disabled  |
      |Medication Duplicate Display           |dropdown |Disabled  |
      |New Medication Duplicate Display       |dropdown |Disabled  |
      |Drug Allergy Display                   |dropdown |Disabled  |
      |Contraindicated Drug Combination       |dropdown |Disabled  |
      |Severe Interaction                     |dropdown |Disabled  |
      |Moderate Interaction                   |dropdown |Disabled  |
      |Undetermined Severity                  |dropdown |Disabled  |
      |Prevent Redundant Ordering             |radio    |false     |
    Then I click the "Save_EditFacility Group Utility Settings" button