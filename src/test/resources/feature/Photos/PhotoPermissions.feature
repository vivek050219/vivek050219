@PhotoFeature
Feature: Photo Permissions feature

  Scenario: Setup Create photos via each test user
    Given I am logged into the portal with user "Verve1Dept3FacB" using the default password
    And I am on the "Patient List V2" tab
    When I select "Photo Test" from the "Patient List" menu
    And I select patient "Molly Darr" from the patient list
    And I select "Photo Add" from clinical navigation
    And I enter "Verve1Dept3FacB" in the "Photo Description" field
    And I select "TestImage1.jpg" "image" file for "Choose File" option in the "Add Photo" pane
    And I wait "3" seconds
    And I click the "Upload" button
    When I click the "Warning OK" button in the "Information" pane
    Given I am logged into the portal with user "Verve1Dept6NoFac" using the default password
    And I am on the "Patient List V2" tab
    When I select "Photo Test" from the "Patient List" menu
    And I select patient "Molly Darr" from the patient list
    And I select "Photo Add" from clinical navigation
    And I enter "Verve1Dept6NoFac" in the "Photo Description" field
    And I select "TestImage1.jpg" "image" file for "Choose File" option in the "Add Photo" pane
    And I wait "3" seconds
    And I click the "Upload" button
    When I click the "Warning OK" button in the "Information" pane
    Given I am logged into the portal with user "Verve1Dept2FacA" using the default password
    And I am on the "Patient List V2" tab
    When I select "Photo Test" from the "Patient List" menu
    And I select patient "Molly Darr" from the patient list
    And I select "Photo Add" from clinical navigation
    And I enter "Verve1Dept2FacA" in the "Photo Description" field
    And I select "TestImage1.jpg" "image" file for "Choose File" option in the "Add Photo" pane
    And I wait "3" seconds
    And I click the "Upload" button
    When I click the "Warning OK" button in the "Information" pane
    Given I am logged into the portal with user "Verve2Dept1FacA" using the default password
    And I am on the "Patient List V2" tab
    When I select "Photo Test" from the "Patient List" menu
    And I select patient "Molly Darr" from the patient list
    And I select "Photo Add" from clinical navigation
    And I enter "Verve2Dept1FacA" in the "Photo Description" field
    And I select "TestImage1.jpg" "image" file for "Choose File" option in the "Add Photo" pane
    And I wait "3" seconds
    And I click the "Upload" button
    When I click the "Warning OK" button in the "Information" pane
    Given I am logged into the portal with user "Verve1Dept1FacA" using the default password
    And I am on the "Patient List V2" tab
    When I select "Photo Test" from the "Patient List" menu
    And I select patient "Molly Darr" from the patient list
    And I select "Photo Add" from clinical navigation
    And I enter "Verve1Dept1FacA" in the "Photo Description" field
    And I select "TestImage1.jpg" "image" file for "Choose File" option in the "Add Photo" pane
    And I wait "3" seconds
    And I click the "Upload" button
    When I click the "Warning OK" button in the "Information" pane
    Then I click the "Refresh PT Info" button

  Scenario: Photo View: None, Photo Edit: My Photos Only
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Admin" tab
    And I select the "User" subtab
    And I search for the user "Verve1Dept1FacA"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Patient Photos" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I select "None" from the "Patient Photo View Permission" dropdown in the "Photo Viewer Settings" pane
    And I select "My Photos Only" from the "Patient Photo Edit Delete Permission" dropdown in the "Photo Viewer Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I wait for the "Page Loading" field of type "misc_element" to be invisible
    Given I am logged into the portal with user "Verve1Dept1FacA" using the default password
    And I am on the "Patient List V2" tab
    Then the following clinical navigation options should not be available
      | Photos |

  Scenario: Photo View: User, Photo Edit: My Photos Only
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Admin" tab
    And I select the "User" subtab
    And I search for the user "Verve1Dept1FacA"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Patient Photos" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I select "User" from the "Patient Photo View Permission" dropdown in the "Photo Viewer Settings" pane
    And I select "My Photos Only" from the "Patient Photo Edit Delete Permission" dropdown in the "Photo Viewer Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I wait for the "Page Loading" field of type "misc_element" to be invisible
    Given I am logged into the portal with user "Verve1Dept1FacA" using the default password
    And I am on the "Patient List V2" tab
    And I select "Photos" from clinical navigation
    And I select patient "Molly Darr" from the patient list
    Then the text "Verve1Dept1FacA" should appear in the "Photos" pane
    Then the text "Verve1Dept6NoFac" should not appear in the "Photos" pane
    Then the text "Verve1Dept2FacA" should not appear in the "Photos" pane
    Then the text "Verve1Dept3FacB" should not appear in the "Photos" pane
    And the "Delete Photo" button should be shown in the following rows in the "Photo List" table
      | Displayed | Title           |
      | True      | Verve1Dept1FacA |

  Scenario: Photo View: Department, Photo Edit: My Photos Only
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Admin" tab
    And I select the "User" subtab
    And I search for the user "Verve1Dept1FacA"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Patient Photos" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I select "Department" from the "Patient Photo View Permission" dropdown in the "Photo Viewer Settings" pane
    And I select "My Photos Only" from the "Patient Photo Edit Delete Permission" dropdown in the "Photo Viewer Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I wait for the "Page Loading" field of type "misc_element" to be invisible
    Given I am logged into the portal with user "Verve1Dept1FacA" using the default password
    And I am on the "Patient List V2" tab
    And I select "Photos" from clinical navigation
    And I select patient "Molly Darr" from the patient list
    Then the text "Verve1Dept1FacA" should appear in the "Photos" pane
    Then the text "Verve1Dept6NoFac" should appear in the "Photos" pane
    Then the text "Verve2Dept1FacA" should appear in the "Photos" pane
    Then the text "Verve1Dept2FacA" should not appear in the "Photos" pane
    Then the text "Verve1Dept3FacB" should not appear in the "Photos" pane
    And the "Delete Photo" button should be shown in the following rows in the "Photo List" table
      | Displayed | Title           |
      | true      | Verve1Dept1FacA |
    And the "Delete Photo Disabled" button should be shown in the following rows in the "Photo List" table
      | Displayed | Title            |
      | true      | Verve1Dept6NoFac |
      | true      | Verve2Dept1FacA  |

  Scenario: Photo View: Facility, Photo Edit: My Photos Only
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Admin" tab
    And I select the "User" subtab
    And I search for the user "Verve1Dept1FacA"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Patient Photos" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I select "Facility" from the "Patient Photo View Permission" dropdown in the "Photo Viewer Settings" pane
    And I select "My Photos Only" from the "Patient Photo Edit Delete Permission" dropdown in the "Photo Viewer Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I wait for the "Page Loading" field of type "misc_element" to be invisible
    Given I am logged into the portal with user "Verve1Dept1FacA" using the default password
    And I am on the "Patient List V2" tab
    And I select "Photos" from clinical navigation
    And I select patient "Molly Darr" from the patient list
    Then the text "Verve1Dept1FacA" should appear in the "Photos" pane
    Then the text "Verve1Dept6NoFac" should not appear in the "Photos" pane
    Then the text "Verve2Dept1FacA" should appear in the "Photos" pane
    Then the text "Verve1Dept2FacA" should appear in the "Photos" pane
    Then the text "Verve1Dept3FacB" should not appear in the "Photos" pane
    And the "Delete Photo" button should be shown in the following rows in the "Photo List" table
      | Displayed | Title           |
      | true      | Verve1Dept1FacA |
    And the "Delete Photo Disabled" button should be shown in the following rows in the "Photo List" table
      | Displayed | Title           |
      | true      | Verve1Dept2FacA |
      | true      | Verve2Dept1FacA |

  Scenario: Photo View: All, Photo Edit: My Photos Only
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Admin" tab
    And I select the "User" subtab
    And I search for the user "Verve1Dept1FacA"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Patient Photos" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I select "All" from the "Patient Photo View Permission" dropdown in the "Photo Viewer Settings" pane
    And I select "My Photos Only" from the "Patient Photo Edit Delete Permission" dropdown in the "Photo Viewer Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I wait for the "Page Loading" field of type "misc_element" to be invisible
    Given I am logged into the portal with user "Verve1Dept1FacA" using the default password
    And I am on the "Patient List V2" tab
    And I select "Photos" from clinical navigation
    And I select patient "Molly Darr" from the patient list
    Then the text "Verve1Dept1FacA" should appear in the "Photos" pane
    Then the text "Verve1Dept6NoFac" should appear in the "Photos" pane
    Then the text "Verve2Dept1FacA" should appear in the "Photos" pane
    Then the text "Verve1Dept2FacA" should appear in the "Photos" pane
    Then the text "Verve1Dept3FacB" should appear in the "Photos" pane
    And the "Delete Photo" button should be shown in the following rows in the "Photo List" table
      | Displayed | Title           |
      | true      | Verve1Dept1FacA |
    And the "Delete Photo Disabled" button should be shown in the following rows in the "Photo List" table
      | Displayed | Title            |
      | true      | Verve1Dept6NoFac |
      | true      | Verve2Dept1FacA  |
      | true      | Verve1Dept2FacA  |
      | true      | Verve1Dept3FacB  |

  Scenario: Photo View: None, Photo Edit: All
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Admin" tab
    And I select the "User" subtab
    And I search for the user "Verve1Dept1FacA"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Patient Photos" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I select "None" from the "Patient Photo View Permission" dropdown in the "Photo Viewer Settings" pane
    And I select "All" from the "Patient Photo Edit Delete Permission" dropdown in the "Photo Viewer Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I wait for the "Page Loading" field of type "misc_element" to be invisible
    Given I am logged into the portal with user "Verve1Dept1FacA" using the default password
    Then the following clinical navigation options should not be available
      | Photos |

  Scenario: Photo View: User, Photo Edit: All
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Admin" tab
    And I select the "User" subtab
    And I search for the user "Verve1Dept1FacA"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Patient Photos" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I select "User" from the "Patient Photo View Permission" dropdown in the "Photo Viewer Settings" pane
    And I select "All" from the "Patient Photo Edit Delete Permission" dropdown in the "Photo Viewer Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I wait for the "Page Loading" field of type "misc_element" to be invisible
    Given I am logged into the portal with user "Verve1Dept1FacA" using the default password
    And I am on the "Patient List V2" tab
    And I select "Photos" from clinical navigation
    And I select patient "Molly Darr" from the patient list
    Then the text "Verve1Dept1FacA" should appear in the "Photos" pane
    Then the text "Verve1Dept6NoFac" should not appear in the "Photos" pane
    Then the text "Verve1Dept2FacA" should not appear in the "Photos" pane
    Then the text "Verve1Dept3FacB" should not appear in the "Photos" pane
    And the "Delete Photo" button should be shown in the following rows in the "Photo List" table
      | Displayed | Title           |
      | true      | Verve1Dept1FacA |

  Scenario: Photo View: Department, Photo Edit: All
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Admin" tab
    And I select the "User" subtab
    And I search for the user "Verve1Dept1FacA"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Patient Photos" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I select "Department" from the "Patient Photo View Permission" dropdown in the "Photo Viewer Settings" pane
    And I select "All" from the "Patient Photo Edit Delete Permission" dropdown in the "Photo Viewer Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I wait for the "Page Loading" field of type "misc_element" to be invisible
    Given I am logged into the portal with user "Verve1Dept1FacA" using the default password
    And I am on the "Patient List V2" tab
    And I select "Photos" from clinical navigation
    And I select patient "Molly Darr" from the patient list
    Then the text "Verve1Dept1FacA" should appear in the "Photos" pane
    Then the text "Verve1Dept6NoFac" should appear in the "Photos" pane
    Then the text "Verve2Dept1FacA" should appear in the "Photos" pane
    Then the text "Verve1Dept2FacA" should not appear in the "Photos" pane
    Then the text "Verve1Dept3FacB" should not appear in the "Photos" pane
    And the "Delete Photo" button should be shown in the following rows in the "Photo List" table
      | Displayed | Title            |
      | true      | Verve1Dept1FacA  |
      | true      | Verve1Dept6NoFac |
      | true      | Verve2Dept1FacA  |

  Scenario: Photo View: Facility, Photo Edit: All
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Admin" tab
    And I select the "User" subtab
    And I search for the user "Verve1Dept1FacA"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Patient Photos" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I select "Facility" from the "Patient Photo View Permission" dropdown in the "Photo Viewer Settings" pane
    And I select "All" from the "Patient Photo Edit Delete Permission" dropdown in the "Photo Viewer Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I wait for the "Page Loading" field of type "misc_element" to be invisible
    Given I am logged into the portal with user "Verve1Dept1FacA" using the default password
    And I am on the "Patient List V2" tab
    And I select "Photos" from clinical navigation
    And I select patient "Molly Darr" from the patient list
    Then the text "Verve1Dept1FacA" should appear in the "Photos" pane
    Then the text "Verve1Dept6NoFac" should not appear in the "Photos" pane
    Then the text "Verve2Dept1FacA" should appear in the "Photos" pane
    Then the text "Verve1Dept2FacA" should appear in the "Photos" pane
    Then the text "Verve1Dept3FacB" should not appear in the "Photos" pane
    And the "Delete Photo" button should be shown in the following rows in the "Photo List" table
      | Displayed | Title           |
      | true      | Verve1Dept1FacA |
      | true      | Verve1Dept2FacA |
      | true      | Verve2Dept1FacA |

  Scenario: Photo View: All, Photo Edit: All
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Admin" tab
    And I select the "User" subtab
    And I search for the user "Verve1Dept1FacA"
    And I click the "Edit" button in the "Quick Details" pane
    And I select "Patient Photos" from the "Edit User Settings" dropdown in the "User Preferences" pane
    And I select "All" from the "Patient Photo View Permission" dropdown in the "Photo Viewer Settings" pane
    And I select "All" from the "Patient Photo Edit Delete Permission" dropdown in the "Photo Viewer Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I wait for the "Page Loading" field of type "misc_element" to be invisible
    Given I am logged into the portal with user "Verve1Dept1FacA" using the default password
    And I am on the "Patient List V2" tab
    And I select "Photos" from clinical navigation
    And I select patient "Molly Darr" from the patient list
    Then the text "Verve1Dept1FacA" should appear in the "Photos" pane
    Then the text "Verve1Dept6NoFac" should appear in the "Photos" pane
    Then the text "Verve2Dept1FacA" should appear in the "Photos" pane
    Then the text "Verve1Dept2FacA" should appear in the "Photos" pane
    Then the text "Verve1Dept3FacB" should appear in the "Photos" pane
    And the "Delete Photo" button should be shown in the following rows in the "Photo List" table
      | Displayed | Title            |
      | true      | Verve1Dept1FacA  |
      | true      | Verve1Dept6NoFac |
      | true      | Verve2Dept1FacA  |
      | true      | Verve1Dept2FacA  |
      | true      | Verve1Dept3FacB  |