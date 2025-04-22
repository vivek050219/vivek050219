@Performance @OneWindow_Performance
Feature: Performance CPOE test

  @Performance @CPOEPerformance @OneWindow_Performance @OneWindow_CPOEPerformance
  Scenario Outline: CPOE Add Order Set
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Automation Perf Test" from the "Patient List" menu
    #Given "<Patient>", admitted in the past "201" days, is on the patient list
    And I select patient "<Patient>" from the patient list
    And I click the "Logo" element
    And I select "Orders" from clinical navigation
  # And I select "the first item" in the "Orders" table
    And I click the "Enter Orders" button
    And I click the "OK" button if it exists
    And I click the "No" button in the "Question" pane if it exists
    When I enter "AM Labs" in the "Add Order" field in the "Enter Orders" pane
    And I select "the first item" in the "CPOE All Orders" table
    And I check all checkboxes in "Order Set Content" pane
    And I click the "Done with Order Set" button
    And I click the "Sign/Submit" button in the "Order Submission" pane
    Then I sign and submit the order with default password
    And I select "the first item" in the "Orders" table

    Examples:
      | Patient             |
      | PATIENT22, CLINICAL  |
      | PATIENT4, CLINICAL  |
      | PATIENT2, CLINICAL  |
      | PATIENT6, CLINICAL  |
      | PATIENT17, CLINICAL |
      | PATIENT8, CLINICAL  |
      | PATIENT10, CLINICAL |
      | PATIENT15, CLINICAL |
      | PATIENT21, CLINICAL |
      | PATIENT18, CLINICAL |

  @Performance @CPOEPerformance @OneWindow_Performance @OneWindow_CPOEPerformance
  Scenario Outline: CPOE Add Second Order Set
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Automation Perf Test" from the "Patient List" menu
    #Given "<Patient>", admitted in the past "201" days, is on the patient list
    And I select patient "<Patient>" from the patient list
    And I click the "Logo" element
    And I select "Orders" from clinical navigation
    And I select "the first item" in the "Orders" table
    And I click the "Enter Orders" button
    And I click the "OK" button if it exists
    And I click the "No" button in the "Question" pane if it exists
    When I enter "Hospitalist General Adm" in the "Add Order" field in the "Enter Orders" pane
    And I select "Hospitalist General Adm" from the "CPOE All Orders" list in the search results
    And I click the "Done with Order Set" button
    And I click the "Sign/Submit" button in the "Order Submission" pane
    Then I sign and submit the order with default password
    And I select "the first item" in the "Orders" table

    Examples:
      | Patient             |
      | PATIENT22, CLINICAL |
      | PATIENT4, CLINICAL  |
      | PATIENT2, CLINICAL  |
      | PATIENT6, CLINICAL  |
      | PATIENT17, CLINICAL |
      | PATIENT8, CLINICAL  |
      | PATIENT10, CLINICAL |
      | PATIENT15, CLINICAL |
      | PATIENT21, CLINICAL |
      | PATIENT18, CLINICAL |

  @Performance @CPOEPerformance @OneWindow_Performance @OneWindow_CPOEPerformance
  Scenario Outline: CPOE Add Third Order Set
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Automation Perf Test" from the "Patient List" menu
    #Given "<Patient>", admitted in the past "201" days, is on the patient list
    And I select patient "<Patient>" from the patient list
    And I click the "Logo" element
    And I select "Orders" from clinical navigation
    And I select "the first item" in the "Orders" table
    And I click the "Enter Orders" button
    And I click the "OK" button if it exists
    And I click the "No" button in the "Question" pane if it exists
    When I enter "Diag Angiogram/PCI Post Cath" in the "Add Order" field in the "Enter Orders" pane
    And I select "Diag Angiogram/PCI Post Cath" from the "CPOE All Orders" list in the search results
    And I click the "Done with Order Set" button
    And I click the "Sign/Submit" button in the "Order Submission" pane
    Then I sign and submit the order with default password
    And I select "the first item" in the "Orders" table

    Examples:
      | Patient             |
      | PATIENT22, CLINICAL |
      | PATIENT4, CLINICAL  |
      | PATIENT2, CLINICAL  |
      | PATIENT6, CLINICAL  |
      | PATIENT17, CLINICAL |
      | PATIENT8, CLINICAL  |
      | PATIENT10, CLINICAL |
      | PATIENT15, CLINICAL |
      | PATIENT21, CLINICAL |
      | PATIENT18, CLINICAL |

  @Performance @CPOEPerformance @OneWindow_Performance @OneWindow_CPOEPerformance
  Scenario Outline: CPOE Add Order Entry
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Automation Perf Test" from the "Patient List" menu
    #Given "<Patient>", admitted in the past "201" days, is on the patient list
    And I select patient "<Patient>" from the patient list
    And I click the "Logo" element
    And I select "Orders" from clinical navigation
    # And I select "the first item" in the "Orders" table
    And I click the "Enter Orders" button
    And I click the "OK" button if it exists
    And I click the "No" button in the "Question" pane if it exists
    When I enter "Bumex" in the "Add Order" field in the "Enter Orders" pane
    And I select "Bumex 1 MG Tab tab (bumetanide) oral" from the "Combined Med Orders" list in the search results
    And I select "0.5 MG" from the "Dose" multiselect
    And I select "Daily" from the "Frequency" multiselect
    And I click the "Enter Order OK" button in the "EnterOrders" pane
    And I select "Bumetanide Tab (Bumex Tab) 0.5 MG oral Daily" in the "New Orders" table
    And I select "1 MG" from the "Dose" multiselect
    And I click the "Enter Order OK" button in the "EnterOrders" pane
    And I select "Bumetanide Tab (Bumex Tab) 1 MG oral Daily" in the "New Orders" table
    And I select "Weekly" from the "Frequency" multiselect
    And I click the "Enter Order OK" button in the "EnterOrders" pane
    And I click the "Sign/Submit" button in the "Order Submission" pane
    Then I sign and submit the order with default password
    And I select "the first item" in the "Orders" table


    Examples:
      | Patient             |
      | PATIENT1, CLINICAL  |
      | PATIENT4, CLINICAL  |
      | PATIENT5, CLINICAL  |
      | PATIENT6, CLINICAL  |
      | PATIENT17, CLINICAL |
      | PATIENT8, CLINICAL  |
      | PATIENT10, CLINICAL |
      | PATIENT15, CLINICAL |
      | PATIENT21, CLINICAL |
      | PATIENT18, CLINICAL |


  @Performance @CPOEPerformance @OneWindow_Performance @OneWindow_CPOEPerformance
  Scenario Outline: CPOE Four Order Defs with pop-up detail
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Automation Perf Test" from the "Patient List" menu
    #Given "<Patient>", admitted in the past "201" days, is on the patient list
    And I select patient "<Patient>" from the patient list
    And I click the "Logo" element
    And I select "Orders" from clinical navigation
    And I select "the first item" in the "Orders" table
    And I click the "Enter Orders" button
    And I click the "OK" button if it exists
    And I click the "No" button in the "Question" pane if it exists
    When I enter "EKG 12 LEAD" in the "Add Order" field in the "Enter Orders" pane
    And I select CPOE "All" tab
    And I select "the first item" from the "CPOE All Orders" list in the search results
    And I select "Once" from the "Frequency" multiselect
    And I click the "Enter Order OK" button in the "EnterOrders" pane
    Then I enter "Change Attending MD" in the "Add Order" field in the "Enter Orders" pane
    And I select "Change Attending MD" from the "CPOE All Orders" list in the search results
    And I enter "er" in the "Provider Lookup Text" field
    And I click the "Provider Lookup Search" button
    Then I select "the first item" in the "Look Up" table
    And I click the "Enter Order OK" button in the "EnterOrders" pane
    Then I enter "Diabetic Diet" in the "Add Order" field in the "Enter Orders" pane
    And I select "the first item" from the "CPOE All Orders" list in the search results
    And I select "Breakfast" from the "Start Meal" multiselect
    And I click the "Enter Order OK" button in the "EnterOrders" pane
    Then I enter "Bedside Swallow Evaluation" in the "Add Order" field in the "Enter Orders" pane
    And I select "Bedside Swallow Evaluation" from the "CPOE All Orders" list in the search results
    And I select "Once" from the "Frequency" multiselect
    And I click the "Enter Order OK" button in the "EnterOrders" pane
    And I click the "Sign/Submit" button in the "Order Submission" pane
    Then I sign and submit the order with default password
    And I select "the first item" in the "Orders" table


    Examples:
      | Patient             |
      | PATIENT1, CLINICAL  |
      | PATIENT4, CLINICAL  |
      | PATIENT5, CLINICAL  |
      | PATIENT6, CLINICAL  |
      | PATIENT17, CLINICAL |
      | PATIENT8, CLINICAL  |
      | PATIENT10, CLINICAL |
      | PATIENT15, CLINICAL |
      | PATIENT21, CLINICAL |
      | PATIENT18, CLINICAL |


  @Performance @CPOEPerformance @OneWindow_Performance @OneWindow_CPOEPerformance
  Scenario Outline: CPOE Add Order Entry without pop-up detail
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Automation Perf Test" from the "Patient List" menu
    #Given "<Patient>", admitted in the past "201" days, is on the patient list
    And I select patient "<Patient>" from the patient list
    And I click the "Logo" element
    And I select "Orders" from clinical navigation
    And I select "the first item" in the "Orders" table
    And I click the "Enter Orders" button
    And I click the "OK" button if it exists
    And I click the "No" button in the "Question" pane if it exists
    When I enter "<Order Def>" in the "Add Order" field in the "Enter Orders" pane
    And I select CPOE "All" tab
    And I select "the first item" from the "CPOE All Orders" list in the search results
    When I enter "<Order Def 2>" in the "Add Order" field in the "Enter Orders" pane
    And I select CPOE "All" tab
    And I select "the first item" from the "CPOE All Orders" list in the search results
    #And I click the "Enter Order OK" button in the "EnterOrders" pane
    And I click the "Sign/Submit" button in the "Order Submission" pane
    Then I sign and submit the order with default password
    And I select "the first item" in the "Orders" table


    Examples:
      | Patient             | Order Def                    | Order Def 2        |
      | PATIENT1, CLINICAL  | BASIC METABOLIC PANEL        | dext 50 ml solp    |
      | PATIENT4, CLINICAL  | CBC NO DIFFERENTIAL-HEMOGRAM | vitamin b12 100    |
      | PATIENT5, CLINICAL  | Morphine                     | vitamin A          |
      | PATIENT6, CLINICAL  | Tylenol Tab 325 ONCE         | PREALBUMIN         |
      | PATIENT17, CLINICAL | Aldactone Tab 12.5           | Regular Diet       |
      | PATIENT8, CLINICAL  | Basic Metab & HH (Bedside)   | vitamin D          |
      | PATIENT10, CLINICAL | CORD BLOOD PH                | AB ACTIN           |
      | PATIENT15, CLINICAL | wellbutrin 100 tab once      | UR IRON            |
      | PATIENT21, CLINICAL | HEPARIN UNFRACTIONATED       | aquasol E 50       |
      | PATIENT18, CLINICAL | CREATININE  with             | bed position       |



  @Performance @CPOEPerformance @OneWindow_Performance @OneWindow_CPOEPerformance
  Scenario Outline: Add Microbiology Order String Added in 8.4.0
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Automation Perf Test" from the "Patient List" menu
    ##Given "<Patient>", admitted in the past "201" days, is on the patient list
    And I select patient "<Patient>" from the patient list
    And I click the "Logo" element
    And I select "Orders" from clinical navigation
    And I select "the first item" in the "Orders" table
    And I click the "Enter Orders" button
    And I click the "OK" button if it exists
    And I click the "No" button in the "Question" pane if it exists
    And I enter "Test Micro Lab" in the "Add Order" field in the "Enter Orders" pane
    And I select "Test Micro Lab" from the "CPOE All Orders" list in the search results
    And I select "Test Micro Lab today" in the "New Orders" table
    And I select "Back" from the "Source Field" dropdown
    And I select "Lower" from the "Source Description" dropdown
    And I click the "Enter Order OK" button
    And I click the "Sign/Submit" button in the "Order Submission" pane
    Then I sign and submit the order with default password
    And I select "the first item" in the "Orders" table


    Examples:
      | Patient             |
      | PATIENT1, CLINICAL  |
      | PATIENT4, CLINICAL  |
      | PATIENT5, CLINICAL  |
      | PATIENT6, CLINICAL  |
      | PATIENT7, CLINICAL  |
      | PATIENT8, CLINICAL  |
      | PATIENT10, CLINICAL |
      | PATIENT14, CLINICAL |
      | PATIENT16, CLINICAL |
      | PATIENT18, CLINICAL |

  @Performance @CPOEPerformance @OneWindow_Performance @OneWindow_CPOEPerformance
  Scenario: Turn on all interactions
    Given I am logged into the portal with the default user
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
      |Medication Duplicate Display           |dropdown |Popup and Require Reason  |
      |New Medication Duplicate Display       |dropdown |Popup and Require Reason  |
      |Drug Allergy Display                   |dropdown |Popup and Require Reason  |
      |Contraindicated Drug Combination       |dropdown |Popup and Require Reason  |
      |Severe Interaction                     |dropdown |Popup and Require Reason  |
      |Moderate Interaction                   |dropdown |Popup and Require Reason  |
      |Undetermined Severity                  |dropdown |Popup and Require Reason  |
      |Prevent Redundant Ordering             |radio    |true                      |
    Then I click the "Save_EditFacility Group Utility Settings" button
#

  @Performance @CPOEPerformance @OneWindow_Performance @OneWindow_CPOEPerformance
  Scenario Outline: Interaction checking duplicate orders, with some ingredient based interactions
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "Automation Perf Test" from the "Patient List" menu
  ##Given "<Patient>", admitted in the past "201" days, is on the patient list
    And I select patient "<Patient>" from the patient list
    And I select "Orders" from clinical navigation
    And I select "the first item" in the "Orders" table
    And I click the "Enter Orders" button
    And I click the "OK" button if it exists
    #And I click the "No" button in the "Question" pane if it exists
    And I enter "<Order Text1>" in the "Add Order" field in the "Enter Orders" pane
   # And I select "acetaminophen chewable tablet  160MG oral" from the "CPOE All Orders" list in the search results
    And I select CPOE "All" tab
    And I select "<Order1>" from the "CPOE All Orders" list in the search results
    And the text "<Interaction Message1>" should appear in the "Order Clinical Decision Support Warnings" pane
    #And the text "represent a duplication in therapy based on their association" should appear in the "Order Clinical Decision Support Warnings" pane
    When I select "Provider Aware - Continue as ordered" as override reason in the "Order Clinical Decision Support Warnings" pane
    And I click the "CDSW OK" button in the "Order Clinical Decision Support Warnings" pane
    And I fill the mandatory order details in the "Order Clinical Decision Support Warnings" pane if it exists
    Then the "Order Clinical Decision Support Warnings" pane should close
    And I enter "<Order Text2>" in the "Add Order" field in the "Enter Orders" pane
    And I select CPOE "All" tab
    And I select "<Order2>" from the "CPOE All Orders" list in the search results
    And the text "<Interaction Message2>" should appear in the "Order Clinical Decision Support Warnings" pane
    When I select "Provider Aware - Continue as ordered" as override reason in the "Order Clinical Decision Support Warnings" pane
    And I click the "CDSW OK" button in the "Order Clinical Decision Support Warnings" pane
    And I fill the mandatory order details in the "Order Clinical Decision Support Warnings" pane if it exists
    Then the "Order Clinical Decision Support Warnings" pane should close
    And I click the "Sign/Submit" button in the "Order Submission" pane
    Then I sign and submit the order with default password
    And I select "the first item" in the "Orders" table

  Examples:
    | Patient       | Order Text1 | Order1         | Order Text2     | Order2         | Interaction Message1 | Interaction Message2 |
    | PATIENT1, AMR | Tylenol 120 | the first item | fentanyl        | the first item | Duplicates           | allergy              |
    | PATIENT2, AMR | Coumadin 1  | the first item | Coumadin 1      | the first item | Moderate Interaction | Severe Interaction   |
    | PATIENT4, AMR | Zyloprim    | the first item | Zyloprim        | the first item | Duplicates           | Duplicates           |
    | PATIENT5, AMR | Lasix       | the first item | morphine 0.5    | the first item | Duplicates           | allergy              |
    | PATIENT6, AMR | Ibuprofen   | the first item | piperacillin    | the first item | Duplicates           | allergy              |
    | PATIENT7, AMR | Percocet    | the first item | morphine 0.5    | the first item | Duplicates           | allergy              |
    | PATIENT8, AMR | Cozzar      | the first item | penicillins 125 | the first item | Duplicates           | Duplicates           |
    | PATIENT9, AMR | Penicillin  | the first item | Penicillin      | the first item | Duplicates           | Duplicates           |


  @Performance @CPOEPerformance @OneWindow_Performance @OneWindow_CPOEPerformance
  Scenario: Turn off all interactions for the rest of the tests
    Given I am logged into the portal with the default user
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


  @Performance @CPOEPerformance @OneWindow_Performance @OneWindow_CPOEPerformance
  Scenario: Clear Unfinished Order
    Given I am logged into the portal with the default user
    And I am on the "Patient List V2" tab
    Given there should not be any unfinished orders