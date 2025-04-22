@Chrome75
Feature: Chrome 75 Tests

  @Chrome75NW
  Scenario Outline: Open NoteWriter, no pop-out
  Given I am logged into the portal with user "pkadmin" using the default password
  And I am on the "Patient List V2" tab
  And I select "Card Group" from the "Patient List" menu
  And "<Patient>" is on the patient list
  And I select patient "<Patient>" from the patient list
  When I select "Clinical Notes" from clinical navigation
  And I load the "Progress Note" template note for the selected patient
  And I click the "Note Writer Cancel Note" button
  And I click the "Yes" button in the "Question" pane

    Examples:
      | Patient    |
      | Molly Darr |
      | Molly Darr |
      | Molly Darr |
      | Molly Darr |
      | Molly Darr |
      | Molly Darr |
      | Molly Darr |
      | Molly Darr |
      | Molly Darr |
      | Molly Darr |

  @Chrome75NW
  Scenario Outline: Open NoteWriter, with pop-out
    Given I am logged into the portal with user "pkadmin" using the default password
    And I am on the "Patient List V2" tab
    And I select "Card Group" from the "Patient List" menu
    And "<Patient>" is on the patient list
    And I select patient "<Patient>" from the patient list
    When I select "Clinical Notes" from clinical navigation
    And I load the "Progress Note" template note for the selected patient
    And I pop out note writer
    And I wait "3" seconds
    And I pop in note writer
    And I click the "Note Writer Cancel Note" button
    And I click the "Yes" button in the "Question" pane

    Examples:
      | Patient    |
      | Molly Darr |
      | Molly Darr |
      | Molly Darr |
      | Molly Darr |
      | Molly Darr |
      | Molly Darr |
      | Molly Darr |
      | Molly Darr |
      | Molly Darr |
      | Molly Darr |

  @Chrome75CC
  Scenario Outline: Open Charge Capture
    Given I am logged into the portal with user "pkadmin" using the default password
    And I am on the "Patient List V2" tab
    And I select "Card Group" from the "Patient List" menu
    And "<Patient>" is on the patient list
    When I select patient "<Patient>" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I wait "5" seconds
    And I click the "Close" image

    Examples:
      | Patient    |
      | Neil Heath |
      | Neil Heath |
      | Neil Heath |
      | Neil Heath |
      | Neil Heath |
      | Neil Heath |
      | Neil Heath |
      | Neil Heath |
      | Neil Heath |
      | Neil Heath |

  @Chrome75CC
  Scenario Outline: Verify Bill Area selection from short list
    Given I am logged into the portal with user "pkadmin" using the default password
    And I launch the charge transaction headers for "addchargeuser3" user
    And I select "Bill Area" in the "Charge Transaction Headers" table
    And I click the "Edit" button in the "Charge Transaction Content" pane
    And I wait "2" seconds
    And I click the "Cancel" button in the "Charge Header Edit Content" pane
    And I click the "Close" button in the "Charge Transaction Content" pane

    #Unused examples to force loop through Scenario Outline 10 times
    Examples:
      | Patient    |
      | Neil Heath |
      | Neil Heath |
      | Neil Heath |
      | Neil Heath |
      | Neil Heath |
      | Neil Heath |
      | Neil Heath |
      | Neil Heath |
      | Neil Heath |
      | Neil Heath |

  @Chrome75OrderEntry
  Scenario Outline: Open Order Entry screen
    Given I am logged into the portal with user "pkadmin" using the default password
    When I am on the "Patient List V2" tab
    And I select "Card Group" from the "Patient List" menu
    And "<Patient>" is on the patient list
    And I select patient "<Patient>" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Enter Orders" button
    And I enter "acetaminophen" in the "Add Order" field in the "Enter Orders" pane
    And I select "acetaminophen 100 mg/mL Oral Drops" from the "NonFormulary MedOrders" list in the search results
    And I click the "Enter Order Cancel" button
    And I click the "Add Order Cancel" button
    And I click the "Yes" button in the "Question" pane if it exists

    Examples:
      | Patient    |
      | Molly Darr |
      | Molly Darr |
      | Molly Darr |
      | Molly Darr |
      | Molly Darr |
      | Molly Darr |
      | Molly Darr |
      | Molly Darr |
      | Molly Darr |
      | Molly Darr |

  @Chrome75HomeMeds
  Scenario Outline: Open Continue Home Meds screen
    Given I am logged into the portal with user "pkadmin" using the default password
    When I am on the "Patient List V2" tab
    When "<Patient>" is on the patient list
    And I select patient "<Patient>" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Continue Home Meds" button
    And I click the "OK" button in the "Warning" pane if it exists
    And I click the "MedRec Cancel" button
    And I click the "Yes" button in the "Question" pane

    Examples:
      | Patient    |
      | Molly Darr |
      | Molly Darr |
      | Molly Darr |
      | Molly Darr |
      | Molly Darr |
      | Molly Darr |
      | Molly Darr |
      | Molly Darr |
      | Molly Darr |
      | Molly Darr |

  @Chrome75OSB
  Scenario Outline: Open Order Set Builder
    Given I am logged into the portal with user "pkadmin" using the default password
    Given I am on the "Admin" tab
    When I select the "Facility Group" subtab
    And I select "DefaultFacilityGroup" from the "Facility Group" dropdown
    And the "CPOE Preferences" pane should load
    And I click the "Order Sets" link in the "Facility Group Navigation" pane
    And I click the "Add Order Set" button
    And I wait "3" seconds
    And I click the "Close Edit Order Set" button
    And I click the "Confirm Close Yes" button

    #Unused examples to force loop through Scenario Outline 10 times
    Examples:
      | Patient    |
      | Molly Darr |
      | Molly Darr |
      | Molly Darr |
      | Molly Darr |
      | Molly Darr |
      | Molly Darr |
      | Molly Darr |
      | Molly Darr |
      | Molly Darr |
      | Molly Darr |

  @Chrome75OSB
  Scenario Outline: Open Order Set Sections
    Given I am logged into the portal with user "pkadmin" using the default password
    Given I am on the "Admin" tab
    When I select the "Facility Group" subtab
    And I select "DefaultFacilityGroup" from the "Facility Group" dropdown
    And the "CPOE Preferences" pane should load
    And I click the "Order Set Sections" link in the "Facility Group Navigation" pane
    And I click the "Add Order Set Section" button
    And I wait "3" seconds
    And I click the "Close Edit Order Set Sections" button
    And I click the "Confirm Close Yes" button

    #Unused examples to force loop through Scenario Outline 10 times
    Examples:
      | Patient    |
      | Molly Darr |
      | Molly Darr |
      | Molly Darr |
      | Molly Darr |
      | Molly Darr |
      | Molly Darr |
      | Molly Darr |
      | Molly Darr |
      | Molly Darr |
      | Molly Darr |

  @Chrome75Merge
  Scenario Outline: Open Patient Merge
    Given I am logged into the portal with user "patientmerge1" using the default password
    And I am on the "Patient Search" tab
    And I click the "Clear Criteria" button
    And I check the "Include Cancelled Visits" checkbox
    And I check the "Include Past Visits" checkbox
    Then I enter "MergeTest" in the "Last" field in the "Patient Search Criteria" pane
    Then I enter "Patient" in the "First" field in the "Patient Search Criteria" pane
    And I click the "Search for Visits" button
    And I sort the "Visit Search Results" table chronologically by the "Admit/Appt" column in "Descending" order
    Then I select the "Merge" link in the row with "MERGETEST, PATIENT O*" as the value under "Name (\d)" in the "Visit Search Results" table
    And I click the "Merge Patients" button
    And I click the "Cancel" button in the "Merge Patient" pane

    #Unused examples to force loop through Scenario Outline 10 times
    Examples:
      | Patient   |
      | MergeTest |
      | MergeTest |
      | MergeTest |
      | MergeTest |
      | MergeTest |
      | MergeTest |
      | MergeTest |
      | MergeTest |
      | MergeTest |
      | MergeTest |