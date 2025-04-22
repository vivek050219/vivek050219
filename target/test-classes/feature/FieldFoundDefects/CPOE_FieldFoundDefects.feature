Feature: CPOE Field Found Defects
  This test suite validates the defects which are found in CI.

  @CPOE
  Scenario: Pre-requisite disable interaction options
    Given I am logged into the portal with user "pkadmin" using the default password
    And I disable all the interaction checking options

  @CPOE
  Scenario: 8.4.1:DEV-76927-NW/CPOE Orders should submit without any Warning popup
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "PSList" from the "Patient List" menu
    When "HEATH, NEIL" is on the patient list
    And I select patient "HEATH, NEIL" from the patient list
    And I load the "Progress Note" template note for the selected patient
    And I select the note "Enter Orders" section
    Then the "Note Writer Enter Orders" pane should load within "5" seconds
    When I enter "Tylenol" in the "Add Order" field in the "NoteWriter EnterOrders" pane
    And I select "Tylenol 8 Hour tablet,extended release (acetaminophen)  650MG Oral Daily" from the "Note Writer Formulary Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    And I click the "Sign/Submit Orders" button
    And I click the "Yes" button in the "Question" pane if it exists
    And I wait "3" seconds
    Then the "Warning Message" pane should not appear with the text "Please launch CPOE again to continue"
    And I click the "button cancel orders" button
    And I click the "Yes" button in the "Question" pane if it exists
    And I click the "NoteWriter CancelNote" button
    And I click the "Yes" button in the "Question" pane if it exists

  @CPOE
  Scenario: 8.4.1:DEV-76839-NW/CPOE Orders should submit as(Save as Draft) without any Warning popup
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select "PSList" from the "Patient List" menu
    When "DARR, MOLLY" is on the patient list
    And I select patient "DARR, MOLLY" from the patient list
    And I load the "Progress Note" template note for the selected patient
    And I select the note "Enter Orders" section
    Then the "NoteWriter EnterOrders" pane should load within "5" seconds
    When I enter "Tylenol" in the "Add Order" field in the "Note Writer Enter Orders" pane
    And I select "Tylenol 8 Hour tablet,extended release (acetaminophen)  650MG Oral Daily" from the "Note Writer Formulary Med Orders" list in the search results
    And I click the "Orders Save As Draft" button
    And I click the "Yes" button in the "Question" pane if it exists
#    And I select patient "VERVEDARR, MOLLY" from the patient list
    And I select "Clinical Notes" from clinical navigation
    When I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    And I select "*DRAFT* Progress Note" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    Then the "Progress Note" pane should load
    And the text "Draft" should appear in the "Progress Note" pane
    When I click the "Edit Note" button
    And the "Note Writer" pane should load
    And I select the note "Enter Orders" section
    Then the "Warning Message" pane should not appear with the text "There is already an active CPOE Tab open for this patient. "
    And I click the "button cancel orders" button
    And I click the "Yes" button in the "Question" pane if it exists

  @CPOEMicro
  Scenario: 8.4.1:DEV-69663-Remove default facility group from CPOEBase class
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Admin" tab
    And I select the "Facility Group" subtab
    And I select "DefaultFacilityGroup" from the "Facility Group" dropdown
    And the "CPOE Preferences" pane should load
    And I click the "Order Definitions" link in the "Facility Group Navigation" pane
    And I wait "2" seconds
    And I click the "Add Order Definition" button
    And I wait "3" seconds
    And I select "Medication" from the "CPOE Order Type" dropdown
    And I enter "Novolin 70/30" in the "CPOE Abbreviation" field
    And I enter "Novolin 70/30" in the "CPOE Name" field
    And I click the "Add Order String" button in the "Add CPOE Order Definition" pane
    And I click the "Yes" button in the "Question" pane
    And the "Order String Maintenance" pane should load
    And I click the "Add Order String" link in the "Order String Maintenance" pane
    And I wait "5" seconds
    And The element "Route" of type "PKlist" should present in the "CPOE Add Order String" pane
    And I click the "Cancel" button in the "CPOE Add Order String" pane
    And I click the "Cancel" button in the "Order String Maintenance" pane
    And I click the "Cancel" button in the "Add CPOE Order Definition" pane

  @CPOEMicro
  Scenario:8.4.1: DEV-76101 Pre-requisite for creating order set
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Admin" tab
    And I select the "Facility Group" subtab
    And I click the "Order Sets" link in the "Facility Group Navigation" pane
    And I click the "Add Order Set" button
    And I enter "GENERAL ADMISSION PSYCH" in the "Edit Order Set Name" field
    And I enter "GAP" in the "Edit Order Set Abbreviation" field
    And I enter "ADMISSION PSYCH - Description" in the "Edit Order Set Description" field
    And I check the "Edit Order Set Active" checkbox
    And I click the "Content" element
    And I wait "1" seconds
    And I open the "[Section - no label]" component for editing in the Content Tab
    And I enter "Anxiety" in the "Section Label" field
    And I click the "Detail Ok" button in the "Detail Dialog" pane
       #    First order selection
    And I drag the "Order Component" to section field in Edit order set pane
    And I wait "3" seconds
    And I enter "lorazepam 2 mg/mL Oral Concentrate" in the "Order Search" field
    And I wait "3" seconds
    And I select "lorazepam 2 mg/mL Oral Concentrate" in the "NonFormulary MedOrders search" table
    Then the "CPOE Order Prototype" pane should load
    And I select "Q6H" from the "FrequencyList" multiselect in the "CPOEOrderPrototypeContents" pane
    And I select "Otic" from the "Route" multiselect in the "CPOEOrderPrototypeContents" pane
    And I check the "PRN" checkbox in the "CPOEOrderPrototypeContents" pane
    And I enter "anxiety" in the "PRNReason" field in the "CPOEOrderPrototypeContents" pane
    And I click the "OK CPOE Order Prototype" button
    Then the text "lorazepam 2 mg/mL Oral Concentrate  Otic Q6H PRN  anxiety" should appear in the "EditOrderSet" pane
      #    Second order selection
    And I drag the "Order Component" to section field in Edit order set pane
    And I enter "lorazepam 2 mg/mL Oral Concentrate" in the "Order Search" field
    And I wait "3" seconds
    And I select "lorazepam 2 mg/mL Oral Concentrate" in the "NonFormulary MedOrders search" table
    Then the "CPOE Order Prototype" pane should load
    And I select "Q6H" from the "FrequencyList" multiselect in the "CPOEOrder Prototype Contents" pane
    And I select "Perf" from the "Route" multiselect in the "CPOEOrder Prototype Contents" pane
    And I check the "PRN" checkbox in the "CPOEOrder Prototype Contents" pane
    And I enter "anxiety" in the "PRN Reason" field in the "CPOEOrder Prototype Contents" pane
    And I click the "OK CPOE Order Prototype" button
    Then the text "lorazepam 2 mg/mL Oral Concentrate  Perf Q6H PRN  anxiety" should appear in the "Edit Order Set" pane
    And I click the "Save Edit Order Set" button
    And I click the "Close Edit Order Set" button

  @CPOEMicro
  Scenario:8.4.1: DEV-76101 Routes and PRN are deleted when editing orders in common workflow
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Admin" tab
    And I select the "Facility Group" subtab
    And I click the "Order Sets" link in the "Facility Group Navigation" pane
    And I enter "GENERAL ADMISSION PSYCH" in the "OrderSet Name" field
    And I click the "Search CPOE Order Set Maintenance" button
    Then the "CPOE Order Set" table should load
    And I select "GENERAL ADMISSION PSYCH" in the "CPOE Order Set" table
    And I click the "Edit CPOE Order Set Maintenance" button
    And I click "OK" in the confirmation box if it exists
    And I wait "2" seconds
    And I click the "Content" element
    And I wait "1" seconds
       #Select first order
    And I open the "lorazepam 2 mg/mL Oral Concentrate  Otic Q6H PRN  anxiety" section item for editing in Edit Order Set
    Then the "CPOEOrderPrototype" pane should load
    And I click the "OK" button in the "Warning" pane if it exists
    And I click the "Order Behaviour" tab
    And I click the "OK CPOE Order Prototype" button
        #Select second order
    And I open the "lorazepam 2 mg/mL Oral Concentrate  Perf Q6H PRN  anxiety" section item for editing in Edit Order Set
    Then the "CPOEOrderPrototype" pane should load
    And I click the "OK" button in the "Warning" pane if it exists
    And I click the "Order Behaviour" tab
    And I click the "OK CPOE Order Prototype" button
    And I click the "Save Edit Order Set" button
    And I click the "Close Edit Order Set" button
      #Re-open order set
    And I enter "GENERAL ADMISSION PSYCH" in the "Order Set Name" field
    And I click the "Search CPOE Order Set Maintenance" button
    Then the "CPOE Order Set" table should have at least "1" row containing the text "GENERAL ADMISSION PSYCH"
    And I click the "Edit CPOE Order Set Maintenance" button
    And I wait "2" seconds
    And I click the "Content" element
    And I wait "1" seconds
    Then the text "lorazepam 2 mg/mL Oral Concentrate  Otic Q6H PRN  anxiety" should appear in the "Edit Order Set" pane
    Then the text "lorazepam 2 mg/mL Oral Concentrate  Perf Q6H PRN  anxiety" should appear in the "Edit Order Set" pane
    And I click the "Save Edit Order Set" button
    And I click the "Close Edit Order Set" button

  @CPOEMicro
  Scenario:8.4.1: DEV-76101 Post-requisite for deleting order set
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Admin" tab
    And I select the "Facility Group" subtab
    And I click the "Order Sets" link in the "Facility Group Navigation" pane
    And I enter "GENERAL ADMISSION PSYCH" in the "OrderSet Name" field
    And I click the "Search CPOE Order Set Maintenance" button
    Then the "CPOE Order Set" table should have at least "1" row containing the text "GENERAL ADMISSION PSYCH"
    And I select "GENERAL ADMISSION PSYCH" in the "CPOE Order Set" table
    And I click the "Delete CPOE Order Set Maintenance" button
    And I click the "Confirm Delete" button

  @CPOE
  Scenario:8.4.1: DEV-76353-CPOE deselecting a med in an order set generates a System Error
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Patient List V2" tab
    And I use the API to create a patient list named "PSList" owned by "pkadminv2" with the following parameters
      | Type   | Name            | Value      |
      | Filter | Medical Service | Card Group |
    And I click the "Refresh Patient List" button
    And I select "PSList" from the "Patient List" menu
    When "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Enter Orders" button
    And the "Enter Orders" pane should load within "10" seconds
    And I wait "5" seconds
    And I enter "DEV76353 order set" in the "Add Order" field in the "Enter Orders" pane
    And I wait "3" seconds
    And I select "DEV76353 order set" from the "All Orders" list in the search results
    And I wait "3" seconds
    And I check all checkboxes in "OrderSetContent" pane
    And I uncheck the "Aspirintablet" checkbox in the "OrderSetContent" pane
    Then the text "A System Error Has Occured" should not appear in the "OrderSetContent" pane
    And I click the "CancelOrderSet" button in the "EditOrderErx" pane
    And I click the "Yes" button if it exists
    When I click the "Add Order Cancel" button in the "Order Submission" pane
    And I click the "Yes" button if it exists

#    # A bunch of scenarios are failing because the drug strings listed in search aren't the exact same as the strings we
##    have listed in the scenarios.
#  #Supposedly, this was fixed on 3/15/19, but the drug strings are still slightly different.
#  #It's the same drug, just worded differently.  -- HIC 3/18/19.
## https://jira/browse/DEV-79236
  @CPOE
  Scenario:8.4.1: DEV-76353-AMR deselecting a med in an order set generates a System Error[DEV-79236]
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Patient List V2" tab
#    #An earlier scenario picks this same patient list, "PSList", w/o creating it with the API, so it must exist already. -- HIC 3/18/19
#    And I use the API to create a patient list named "PSList" owned by "pkadminv2" with the following parameters
#      | Type   | Name            | Value      |
#      | Filter | Medical Service | Card Group |
#    And I click the "Refresh Patient List" button
    And I select "PSList" from the "Patient List" menu
    When "HEATH, NEIL" is on the patient list
    And I select patient "HEATH, NEIL" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Adm Med Rec" button in the "Orders" pane
    When I click the "here" link if it exists in the "Admission Medication Reconciliation" pane
    And I enter "norfloxacin tablet" in the "Search for order" field in the "Search for order" pane
#    And I select "Noroxin tablet (norfloxacin)  400MG Oral" from the "Searched Combined Med Orders" list in the search results
    Then I select "norfloxacin tablet  400MG Oral" from the "Searched Combined Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    And I click the "HospitalOrdersAdd" button
    And I enter "DEV76353 order set" in the "HospitalSearchForOrder" field
    And I wait "3" seconds
    And I select "DEV76353 order set" from the "SearchedAllOrders" list in the search results
    And I wait "3" seconds
    And I check all checkboxes in "AMR-OrderSetContent" pane
    And I uncheck the "Aspirintablet" checkbox in the "AMR-OrderSetContent" pane
    Then the text "A System Error Has Occured" should not appear in the "AMR-OrderSetContent" pane
    And I click the "CancelOrderSet" button in the "AMR-OrderSetContent" pane
    And I click the "Yes" button if it exists
    When I click the "AMR-Cancel" button
    And I click the "Yes" button if it exists

  @CPOE
  Scenario:8.4.1: DEV-76353-DMR deselecting a med in an order set generates a System Error
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Patient List V2" tab
    And I use the API to create a patient list named "PSList" owned by "pkadminv2" with the following parameters
      | Type   | Name            | Value      |
      | Filter | Medical Service | Card Group |
    And I click the "Refresh Patient List" button
    And I select "PSList" from the "Patient List" menu
    When "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "DischargeMedRec" button
    And I click the "DischargeOrdersAdd" button
    And I enter "DEV76353 order set" in the "DMR-SearchForOrder" field
    And I wait "3" seconds
    And I select "DEV76353 order set" from the "DMR-AllOrders" list in the search results
    And I wait "3" seconds
    And I check all checkboxes in "DMR-OrderSetContent" pane
    And I uncheck the "Aspirintablet" checkbox in the "DMR-OrderSetContent" pane
    Then the text "A System Error Has Occured" should not appear in the "DMR-OrderSetContent" pane
    And I click the "CancelOrderSet" button in the "DMR-OrderSetContent" pane
    And I click the "Yes" button if it exists
    When I click the "DMR-Cancel" button
    And I click the "Yes" button if it exists

#    See note line 207
#  #[DEV-79303] - Hold medication order button missing in 842. May be the same as or related to DEV-74731 -- HIC 3/18/19
  #  Medications and medication orders are not showing up in 842 due to HL7s being rejected. -- HIC 3/20/19
#    https://jira/browse/DEV-79159
  @CPOE
  Scenario: 8.4.0: DEV-74731 - Portal CPOE - buttons missing from order details (hold, dc, modify etc) - regression[DEV-79236][DEV-79303][DEV-79159]
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Patient List V2" tab
#    #An earlier scenario picks this same patient list, "PSList", w/o creating it with the API, so it must exist already. -- HIC 3/18/19
#    And I use the API to create a patient list named "PSList" owned by "pkadminv2" with the following parameters
#      | Type   | Name            | Value      |
#      | Filter | Medical Service | Card Group |
#    And I click the "Refresh Patient List" button
    And I select "PSList" from the "Patient List" menu
    When "DARR, MOLLY" is on the patient list
    And I select patient "DARR, MOLLY" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Enter Orders" button
    And I wait "3" seconds
#    And I select "simvastatin tablet  20mg Oral qPM" from the "Existing orders*" column in the "Existing Orders" table
    When I select "acetaminophen tablet 325mg Oral Q6H PRN pain" from the "Existing orders" column in the "Existing Orders" table
    Then I wait "5" seconds
    And the "EditOrderInEnterOrder" pane should load
    Then the following fields should display in the "EditOrder" pane
      | Name        | Type   |
      | Discontinue | button |
      | Hold        | button |
      | Modify      | button |
    And I click the "EditOrderCancel" button in the "EditOrder" pane
    And I click the "AddOrderCancel" button

    @CPOE
    Scenario: 8.2.1.6.12: DEV-76508 - Verify view submission records link
      Given I am logged into the portal with user "pkadminv2" using the default password
      And I am on the "Patient List V2" tab
      And I use the API to create a patient list named "PSList" owned by "pkadminv2" with the following parameters
        | Type   | Name            | Value      |
        | Filter | Medical Service | Card Group |
      And I click the "Refresh Patient List" button
      And I select "PSList" from the "Patient List" menu
      And I select patient "Roy Blazer" from the patient list
      And I select "Orders" from clinical navigation
      And I click the "Enter Orders" button
      And I click the "OK" button in the "Warning" pane if it exists
      And I enter "Aspirin" in the "Add Order" field in the "Enter Orders" pane
      And I select CPOE "Formulary Med Orders" tab
      And I select "ASPIRIN EC 1 TAB  325MG Oral Daily" in the "Formulary Med Orders" table
      And I Submit the Orders
      Then the "Orders" table should load
      And rows containing the following should appear in the "Orders" table
        |Existing orders for |Start          |
        |ASPIRIN             |%Current Date% |
      When I select "ASPIRIN EC 1 TAB 325MG Oral Daily" from the "Existing orders for*" column in the "Orders" table
      Then the "Order Detail" pane should load within "3" seconds
      When I click the "View Submission Records" link in the "Order Detail" pane
      Then the "Order Submission Records" pane should load within "3" seconds
      And the "Order Submission Records" table should load
      And I click the "order Submission Close" button

  @CPOE
  Scenario: 8.4.0:DEV-74679-CPOE "Order Entry" should "Save as draft" without any Warning popup Message
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Patient List V2" tab
    And I select "PSList" from the "Patient List" menu
    When "MOLLY DARR" is on the patient list
    And I select patient "MOLLY DARR" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Enter Orders" button
    When I enter "Tylenol" in the "Add Order" field in the "Enter Orders" pane
    And I select "Tylenol 8 Hour tablet,extended release (acetaminophen)  650MG Oral Daily" from the "Formulary Med Orders" list in the search results
    And I fill the mandatory order details in the "Edit Medication Order" pane if it exists
    And I click the "Orders Save As Draft" button
    And I click the "Enter Orders" button
    Then the "Warning Message" pane should not appear with the text "There is already an active CPOE Tab open for this patient. "
    And I click the "Cancel" button in the "Order Submission" pane
    And I click the "Yes" button in the "Question" pane if it exists

  @CPOE
  Scenario: 8.4.0:DEV-74679-CPOE "Order Set" should "Save as draft" without any Warning popup Message
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Patient List V2" tab
    And I select "PSList" from the "Patient List" menu
    When "MOLLY DARR" is on the patient list
    And I select patient "MOLLY DARR" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Enter Orders" button
    When I enter "DEV-74679-CPOE" in the "Add Order" field in the "Enter Orders" pane
#    And I click the "Medications" element
    And I select CPOE "All" tab
    And I select "DEV-74679-CPOE" from the "CPOE All Orders" list in the search results
    And I click the "DMRSaveAsDraft" button
    And I click the "Enter Orders" button
    Then the "Warning Message" pane should not appear with the text "There is already an active CPOE Tab open for this patient. "
    And I click the "Cancel" button in the "Order Submission" pane
    And I click the "Yes" button in the "Question" pane if it exists

  @CPOEInteractionChecking
  Scenario: Enable Interaction Severity Display
    Given I am logged into the portal with user "Cadmin" using the default password
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
      |Contraindicated Drug Combination       |dropdown |Popup and Require Reason  |
      |Severe Interaction                     |dropdown |Popup and Require Reason  |
      |Moderate Interaction                   |dropdown |Popup and Require Reason  |
      |Drug Allergy Display                   |dropdown |Popup and Require Reason  |
      |Undetermined Severity                  |dropdown |Popup and Require Reason  |
    Then I click the "Save_EditFacility Group Utility Settings" button

  @CPOEInteractionChecking
  Scenario: 8.4.0:DEV-75871-CPOE "CDSW" able to resolve all interactions,when click on "Next issue"
    Given I am logged into the portal with user "cadmin" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    And I select "Card Group" from the "Patient List" menu
    And "VERVEHEATH, NEIL" is on the patient list
    And I select patient "VERVEHEATH, NEIL" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Enter Orders" button
    When I enter "DEV-75871" in the "Add Order" field in the "Enter Orders" pane
    And I select "DEV-75871" from the "CPOE All Orders" list in the search results
    And I wait "3" seconds
    And I check all checkboxes in "Order Set Content" pane
    And I click the "Done with Order Set" button
    And I wait "3" seconds
    Then the "Clinical Decision Support Warnings" pane should load
    And I select "Home Medication" as override reason in the "Clinical Decision Support Warnings" pane
    And I click the "NextIssue" button
    And I select "Home Medication" as override reason in the "Clinical Decision Support Warnings" pane
    And I click the "NextIssue" button
#    And I select "Home Medication" as override reason in the "Clinical Decision Support Warnings" pane
#    And I click the "NextIssue" button
    Then the "Clinical Decision Support Warnings" pane should close
    And the following text should appear in the "New Orders" pane
      |New Orders                                                                                        |
      |Hydrocortisone Plus 1 % Topical Cream (hydrocortisone-aloe vera)  25mg Top Daily                  |
      |Zoloft tablet (sertraline)  25MG Oral Daily                                                       |
      |Zoloft tablet (sertraline)  25MG Oral Daily                                                       |
      |Tylenol 8 Hour tablet,extended release (acetaminophen)  650MG Oral Daily                          |
      |ASPIRIN EC  1 TAB  325MG Oral Daily                                                               |
    And I click the "Cancel" button in the "Order Submission" pane
    And I click the "Yes" button in the "Question" pane if it exists

  @CPOEInteractionChecking
  Scenario: Disable Interaction Severity Display
    Given I am logged into the portal with user "Cadmin" using the default password
    When I am on the "Admin" tab
    And I select the "Facility Group" subtab
    And I click the "CPOE Utilities" link in the "Facility Group Navigation" pane
    And I click the "Interaction Checking" element if it exists
    And I click the "Edit_CPOEUtilities" button
    And I wait up to "20" seconds for the "Edit Facility Group Utlity Settings Loading Icon" field of type "MISC_ELEMENT" to be invisible
    And the "Edit Facility Group Utilities Settings" pane should load
    And I edit the following settings in the "Edit Facility Group Utilities Settings" pane
      |Name                                   |Type     |Value    |
      |Medication Duplicate Display           |dropdown |Disabled |
      |New Medication Duplicate Display       |dropdown |Disabled |
      |Contraindicated Drug Combination       |dropdown |Disabled |
      |Severe Interaction                     |dropdown |Disabled |
      |Moderate Interaction                   |dropdown |Disabled |
      |Drug Allergy Display                   |dropdown |Disabled |
      |Undetermined Severity                  |dropdown |Disabled |
    Then I click the "Save_EditFacility Group Utility Settings" button

  @CPOE
  Scenario: 8.4.1.3:DEV-78570-Add synonyms to order set
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Admin" tab
    And I select the "Facility Group" subtab
    And I click the "Order Sets" link in the "Facility Group Navigation" pane
    And I enter "DEV-3320" in the "Order Set Name" field
    And I click the "Search CPOE Order Set Maintenance" button
    Then the "CPOE Order Set" table should have at least "1" row containing the text "DEV-3320"
    And I select "DEV-3320" in the "CPOE Order Set" table
    And I click the "Edit CPOE Order Set Maintenance" button
    And I click "OK" in the confirmation box if it exists
    And I wait "2" seconds
    And I click the "Synonyms Delete" button if it exists
    And I click the "Synonyms+" button
    And I click the "New Synonyms" button
    And I type the string "synonyms that are greater than 256 characters long" where the caret is currently focused
    And I click the "Save Edit Order Set" button
    And I click the "Close Edit Order Set" button
    When I click the "CPOE Utilities" link in the "Facility Group Navigation" pane
    Then the "CPOE Utility" pane should load
    And I wait up to "5" seconds for the "OHA/SearchIndex" field of type "MISC_ELEMENT" to be visible
    And I click the "OHA/SearchIndex" element
    And I wait "3" seconds
    And I click the "RefreshIcon" element
    And I wait "3" seconds
    And I click the "Run Search Indexer" button
#    #Susanna Burns put in comments of dev-issue DEV-78570 that don't have to run a full Indexer, that incremental should
#    #be fine.  Commenting this uncheck out b/c I think the full Index is taking too long to run (up to 2 minutes) before
#    #checking for the synonyms, even with the login step proceeding. -- HIC 3/14/19
#    And I uncheck the "Run Incremental Update" checkbox
    And I check the "Run Incremental Update" checkbox
    And I click the "Run the Indexer" button
#    #Wait for the incremental Indexer to go from Queued > Running > to timestamp of when it's finished
    Then I wait "4" seconds
    And I click the "RefreshIcon" element
    Then I wait "4" seconds
    And I click the "InformationOK" button if it exists
    Given I am logged into the portal with user "pkadminv2" using the default password
    When I am on the "Patient List V2" tab
    And I select "Card Group" from the "Patient List" menu
    When "Roy Blazer" is on the patient list
    And I select patient "Roy Blazer" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Enter Orders" button
    And I enter "synonyms" in the "Add Order" field in the "Enter Orders" pane
    And I select CPOE "All" tab
    Then the "Search Orders" table should have at least "1" row containing the text "DEV-3320"
    And I click the "CloseX" button
    And I click the "Cancel" button in the "Order Submission" pane
    And I click the "Yes" button in the "Question" pane if it exists


