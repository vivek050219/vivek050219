@PatientListV2
Feature: Patient List V2 Assignment Tab

#    Scenario: Setup
    Background:
        Given I am logged into the portal with user "PLV2LVL3" using the default password
        And I am on the "Patient List V2" tab
        And the patient list is maximized
        And I use the API to create a patient list named "VerveDel AssignmentTab Test" owned by "PLV2LVL3" with the following parameters
            |Type            |Name            |Value                |
            |Filter          |Medical Service |PLM2Test-TBC         |
            |List Type       |                |ASSIGNMENT           |
            |Assignment List |                |VerveDel Assignment1 |
            |Assignment List |                |VerveDel Assignment2 |
            |Assignment List |                |VerveDel Assignment3 |
        And I click the "Refresh Patient List" button

#Add New Patients
    Scenario: 1. Add patient (unassigned)
        When I select "VerveDel AssignmentTab Test" from the "Patient List" menu
        Given "Molly Darr" is on the patient list
        And I am on the "Assignment" tab
#        And I wait up to "10" seconds for the "Assignment List" field of type "PKDROPDOWN" to be visible
        And I wait up to "4" seconds for the "Assignment List" field of type "PKDROPDOWN" to be visible
        When I select "VerveDel AssignmentTab Test" from the "Assignment List" pkdropdown
        Then I wait "4" seconds
        And I select "Unassigned" from the "Lists To Display" pkdropdown
        When I wait "2" seconds
        Then patient "Molly Darr" should be on the "Unassigned" sublist

    Scenario: 2. Add patient to Sublist (unassigned)
        When I select "VerveDel Assignment1" from the "Patient List" menu
        Given "Roy Blazer" is on the patient list
        And I am on the "Assignment" tab
#        And I wait up to "10" seconds for the "Assignment List" field of type "PKDROPDOWN" to be visible
        And I wait up to "4" seconds for the "Assignment List" field of type "PKDROPDOWN" to be visible
        When I select "VerveDel AssignmentTab Test" from the "Assignment List" pkdropdown
        Then I wait "4" seconds
        And I select "VerveDel Assignment1" from the "Lists To Display" pkdropdown
        When I wait "2" seconds
        Then patient "Roy Blazer" should be on the "VerveDel Assignment1" sublist

    Scenario: 3. Remove patient
        When I select "VerveDel AssignmentTab Test" from the "Patient List" menu
        Given "Molly Darr" is on the patient list
        When I select patient "Molly Darr" from the patient list
        And I select "Remove Patient" from the "Actions" menu
        And I click the "Yes" button in the "Question" pane
        When I select "VerveDel Assignment1" from the "Patient List" menu
        Given "Roy Blazer" is on the patient list
        When I select patient "Roy Blazer" from the patient list
        And I select "Remove Patient" from the "Actions" menu
        And I click the "Yes" button in the "Question" pane
        And I am on the "Assignment" tab
#        And I wait up to "10" seconds for the "Assignment List" field of type "PKDROPDOWN" to be visible
        And I wait up to "4" seconds for the "Assignment List" field of type "PKDROPDOWN" to be visible
        When I select "VerveDel AssignmentTab Test" from the "Assignment List" pkdropdown
        Then I wait "4" seconds
        And I select "VerveDel Assignment1" from the "Lists To Display" pkdropdown
        And I wait "2" seconds
        Then patient "Molly Darr" should not be on the "Unassigned" sublist
        Then patient "Roy Blazer" should not be on the "VerveDel Assignment1" sublist
      And I click the "List To Display" element

        #Admin Settings
    Scenario: 4. Admin - User Patient List setting - Allow Patient Assignment
        Given I am logged into the portal with user "pkadmin" using the default password
        And I am on the "Admin" tab
        And I select the "User" subtab
        And I search for the user "plv2permtest"
        And I select the user "plv2permtest"
        And I click the "Edit" button in the "Quick Details" pane
        And I select "Patient List" from the "Edit User Settings" dropdown
        And I select "true" from the "Allow Patient Assignment" radio list
        And I click the "Save" button
        And I click "OK" in the confirmation box
        Given I am logged into the portal with user "plv2permtest" using the default password
        And I am on the "Patient List" tab
        Then the following tab should load
            |Assignment |

    Scenario: 5. Admin - User Patient List setting - Disallow Patient Assignment
        Given I am logged into the portal with user "pkadmin" using the default password
        And I am on the "Admin" tab
        And I select the "User" subtab
        And I search for the user "plv2permtest"
        And I select the user "plv2permtest"
        And I click the "Edit" button in the "Quick Details" pane
        And I select "Patient List" from the "Edit User Settings" dropdown
        And I select "false" from the "Allow Patient Assignment" radio list
        And I click the "Save" button
        And I click "OK" in the confirmation box
        Given I am logged into the portal with user "plv2permtest" using the default password
        And I am on the "Patient List" tab
        Then the following tab should not load
            |Assignment |

        #Patient List Favorites and Search
    Scenario: 6. 0001 Non-Favorited Lists Do Not Display in Assignment List Drop down
        And I use the API to create a patient list named "VerveDel AssignmentTab NonFav Test" owned by "PLV2LVL3" with the following parameters
            | Type            | Name            | Value                            |
            | Filter          | Medical Service | PLM2Test-TBC                     |
            | List Type       |                 | ASSIGNMENT                       |
            | Assignment List |                 | VerveDel Assignment NonFav Test1 |
        And I use the API to unfavorite patient list "VerveDel AssignmentTab NonFav Test" for user "PLV2LVL3" owned by "PLV2LVL3"
        And I click the "Refresh Patient List" button
        When I am on the "Assignment" tab
        And I click the "Refresh" button
        Then the "Assignment List" pkdropdown should not have the following items
            | VerveDel AssignmentTab NonFav Test |

    Scenario: 7. 0003 Search for list - Have View/Manage Permission
        And I use the API to create a patient list named "VerveDel AssignmentTab Perm Test" owned by "PLV2ADMIN" with the following parameters
            | Type            | Name            | Value                          |
            | Filter          | Medical Service | PLM2Test-TBC                   |
            | List Type       |                 | ASSIGNMENT                     |
            | Assignment List |                 | VerveDel Assignment Perm Test1 |
            | Assignment List |                 | VerveDel Assignment Perm Test2 |
            | Assignment List |                 | VerveDel Assignment Perm Test3 |
        And I use the API to update the permissions for the patient list named "VerveDel AssignmentTab Perm Test" owned by "PLV2ADMIN" with the following
            | Action | Name   | Value    |
            | Add    | View   | PLV2LVL3 |
            | Add    | Manage | PLV2LVL3 |
      And I click the "Refresh Patient List" button
      When I am on the "Assignment" tab
      And I click the "Refresh" button
      And I open the search screen from the assignment list dropdown
      And I enter "VerveDel AssignmentTab Perm Test" in the "Patient List Search" field
      And I click the "Search Patient List" button
      And I select "VerveDel AssignmentTab Perm Test" in the "Patient List Search Results" table
      And I click the "Select Patient List" button
      And I select "Unassigned" from the "Lists To Display" pkdropdown
      And I select "VerveDel Assignment Perm Test1" from the "Lists To Display" pkdropdown
      And I click the "List To Display" element
      And I wait "3" seconds
      And I reassign the following patients
        | Patient Name | Source List | Target List                    |
        | TBCTEST, 02  | Unassigned  | VerveDel Assignment Perm Test1 |
      Then patient "TBCTEST, 02" should be on the "VerveDel Assignment Perm Test1" sublist


#Reassign patients to sublists
  @PatientSafety
  Scenario: 8. Reassign Patients to Sublist
    Given I use the API to create a patient list named "VerveDel AssignmentTab Reassign1 Test" owned by "PLV2LVL3" with the following parameters
      | Type            | Name            | Value                          |
      | Filter          | Medical Service | PLM2Test-TBC                   |
      | List Type       |                 | ASSIGNMENT                     |
      | Assignment List |                 | VerveDel Reassign1 Assignment1 |
      | Assignment List |                 | VerveDel Reassign1 Assignment2 |
      | Assignment List |                 | VerveDel Reassign1 Assignment3 |
    And I wait "5" seconds
    And I click the "Refresh Patient List" button
    Then I am on the "Assignment" tab
    And I wait "5" seconds
    And I wait up to "4" seconds for the "Assignment List" field of type "PKDROPDOWN" to be visible
#        When I select "VerveDel AssignmentTab Reassign1 Test" from the "Assignment List" pkdropdown
    When I search for "VerveDel AssignmentTab Reassign1 Test" from the Assignment List pkdropdown
    And I wait "2" seconds
    And I click the "Lists To Display" dropdown
    And I click the "Check All" element in the "Lists To Display" pane
    And I wait "3" seconds
    And I click the "List To Display" element
    Then I reassign the following patients
      | Patient Name | Source List | Target List                    |
      | TBCTEST, 01  | Unassigned  | VerveDel Reassign1 Assignment1 |
      | TBCTEST, 04  | Unassigned  | VerveDel Reassign1 Assignment1 |
      | TBCTEST, 06  | Unassigned  | VerveDel Reassign1 Assignment1 |
    Then I wait "4" seconds
    And I am on the "Patient List V2" tab
    When I select "VerveDel Reassign1 Assignment1" from the "Patient List" menu
    And I click the "Refresh Patient List" button
    Then the following patients should be on "Patient Visit" PatientList
      | TBCTEST, 01 |
      | TBCTEST, 04 |
      | TBCTEST, 06 |


  @PatientSafety
  Scenario: 9. Reassign Patients to Multiple Sublists
    Given I use the API to create a patient list named "VerveDel AssignmentTab Reassign2 Test" owned by "PLV2LVL3" with the following parameters
      | Type            | Name            | Value                          |
      | Filter          | Medical Service | PLM2Test-TBC                   |
      | List Type       |                 | ASSIGNMENT                     |
      | Assignment List |                 | VerveDel Reassign2 Assignment1 |
      | Assignment List |                 | VerveDel Reassign2 Assignment2 |
      | Assignment List |                 | VerveDel Reassign2 Assignment3 |
    And I wait "5" seconds
    And I click the "Refresh Patient List" button
    And I am on the "Assignment" tab
    And I wait "5" seconds
    And I wait up to "5" seconds for the "Assignment List" field of type "PKDROPDOWN" to be visible
#        When I select "VerveDel AssignmentTab Reassign2 Test" from the "Assignment List" pkdropdown
    When I search for "VerveDel AssignmentTab Reassign2 Test" from the Assignment List pkdropdown
    And I wait "2" seconds
    And I click the "Lists To Display" dropdown
    And I click the "Check All" element in the "Lists To Display" pane
    And I wait "3" seconds
    And I click the "List To Display" element
    And I reassign the following patients
      | Patient Name | Source List | Target List                    |
      | TBCTEST, 04  | Unassigned  | VerveDel Reassign2 Assignment1 |
      | TBCTEST, 11  | Unassigned  | VerveDel Reassign2 Assignment1 |
      | TBCTEST, 02  | Unassigned  | VerveDel Reassign2 Assignment2 |
      | TBCTEST, 06  | Unassigned  | VerveDel Reassign2 Assignment2 |
#            | TBCTEST, 09  | Unassigned  | VerveDel Reassign2 Assignment3 |
#        This is just too many lists for IE to dragAndDrop() to effectively.  Is only a problem in automation with IE.
    Then I wait "4" seconds
    And I am on the "Patient List V2" tab
    When I select "VerveDel Reassign2 Assignment1" from the "Patient List" menu
    And I click the "Refresh Patient List" button
    Then the following patients should be on "Patient Visit" PatientList
      | TBCTEST, 11 |
      | TBCTEST, 04 |
    When I select "VerveDel Reassign2 Assignment2" from the "Patient List" menu
    Then the following patients should be on "Patient Visit" PatientList
      | TBCTEST, 02 |
      | TBCTEST, 06 |
#        When I select "VerveDel Reassign2 Assignment3" from the "Patient List" menu
#        Then the following patients should be on "Patient Visit" PatientList
#            | TBCTEST, 09 |


  Scenario: 10. Reassign All Patients to Sublist
    And I use the API to create a patient list named "VerveDel AssignmentTab Reassign3 Test" owned by "PLV2LVL3" with the following parameters
      | Type            | Name            | Value                          |
      | Filter          | Medical Service | PLM2Test-TBC                   |
      | List Type       |                 | ASSIGNMENT                     |
      | Assignment List |                 | VerveDel Reassign3 Assignment1 |
      | Assignment List |                 | VerveDel Reassign3 Assignment2 |
      | Assignment List |                 | VerveDel Reassign3 Assignment3 |
    And I click the "Refresh Patient List" button
    And I am on the "Assignment" tab
    And I click the "Refresh" button
#        And I wait up to "10" seconds for the "Assignment List" field of type "PKDROPDOWN" to be visible
    And I wait up to "4" seconds for the "Assignment List" field of type "PKDROPDOWN" to be visible
    When I select "VerveDel AssignmentTab Reassign3 Test" from the "Assignment List" pkdropdown
    Then I wait "4" seconds
    And I click the "Lists To Display" dropdown
    And I check the following sublists
      | Unassigned                     |
            | VerveDel Reassign3 Assignment1 |
            | VerveDel Reassign3 Assignment2 |
        Then I wait "2" seconds
        And I reassign all patients from the "Unassigned" sublist to the "VerveDel Reassign3 Assignment2" sublist
        Then I wait "4" seconds
        And I am on the "Patient List V2" tab
        When I select "VerveDel Reassign3 Assignment2" from the "Patient List" menu
        And I click the "Refresh Patient List" button
        Then the following patients should be on "Patient Visit" PatientList
            | TBCTEST, 01 |
            | TBCTEST, 02 |
            | TBCTEST, 04 |
            | TBCTEST, 06 |
            | TBCTEST, 08 |
            | TBCTEST, 09 |
            | TBCTEST, 11 |


#Search
    Scenario: 11. Search for list by list name
        And I use the API to create a patient list named "VerveDel AssignmentTab Search Test" owned by "PLV2the3rd" with the following parameters
            | Type            | Name            | Value                          |
            | Description     |                 | For assignment tab search test |
            | Filter          | Medical Service | PLM2Test-TBC                   |
            | List Type       |                 | ASSIGNMENT                     |
        And I use the API to update the permissions for the patient list named "VerveDel AssignmentTab Search Test" owned by "PLV2the3rd" with the following
            | Action | Name | Value    |
            | Add    | View | PLV2LVL3 |
        And I click the "Refresh Patient List" button
        When I am on the "Assignment" tab
        And I click the "Refresh" button
        And I open the search screen from the assignment list dropdown
        And I clear and enter "VerveDel AssignmentTab Search Test" in the "Patient List Search" field
        And I click the "Search Patient List" button
        Then the following rows should appear in the "Patient List Search Results" table
          | NAME                               |
            | VerveDel AssignmentTab Search Test |
        And I click the "CancelPatientSearchPopUp" button

    Scenario: 12. Search for list by list description
        And I use the API to create a patient list named "VerveDel AssignmentTab Search Test" owned by "PLV2the3rd" with the following parameters
            | Type            | Name            | Value                          |
            | Description     |                 | For assignment tab search test |
            | Filter          | Medical Service | PLM2Test-TBC                   |
            | List Type       |                 | ASSIGNMENT                     |
        And I use the API to update the permissions for the patient list named "VerveDel AssignmentTab Search Test" owned by "PLV2the3rd" with the following
            | Action | Name | Value    |
            | Add    | View | PLV2LVL3 |
        And I click the "Refresh Patient List" button
        When I am on the "Assignment" tab
        And I click the "Refresh" button
        And I open the search screen from the assignment list dropdown
        And I clear and enter "For assignment tab search test" in the "Patient List Search" field
        And I click the "Search Patient List" button
        Then the following rows should appear in the "Patient List Search Results" table
          | NAME                               |
            | VerveDel AssignmentTab Search Test |
        And I click the "CancelPatientSearchPopUp" button

    Scenario: 13. Search for list by department
        And I use the API to create a patient list named "VerveDel AssignmentTab Search Test" owned by "PLV2the3rd" with the following parameters
            | Type            | Name            | Value                          |
            | Description     |                 | For assignment tab search test |
            | Filter      | Medical Service | PLM2Test-TBC                   |
            | List Type   |                 | ASSIGNMENT                     |
      And I use the API to update the permissions for the patient list named "VerveDel AssignmentTab Search Test" owned by "PLV2the3rd" with the following
        | Action | Name | Value    |
        | Add    | View | PLV2LVL3 |
      And I click the "Refresh Patient List" button
      When I am on the "Assignment" tab
      And I click the "Refresh" button
      And I open the search screen from the assignment list dropdown
      And I select "PLv2The3rdDept" from the "Department" dropdown
      And I click the "Search Patient List" button
      And I wait "5" seconds
      Then the following rows should appear in the "Patient List Search Results" table
        | NAME                               |
        | VerveDel AssignmentTab Search Test |
      And I click the "CancelPatientSearchPopUp" button

    Scenario: 14. Search for list by list alias
        And I use the API to create a patient list named "VerveDel AssignmentTab Search Test" owned by "PLV2the3rd" with the following parameters
            | Type            | Name            | Value                          |
            | Description     |                 | For assignment tab search test |
            | Filter          | Medical Service | PLM2Test-TBC                   |
            | List Type       |                 | ASSIGNMENT                     |
        And I use the API to update the permissions for the patient list named "VerveDel AssignmentTab Search Test" owned by "PLV2the3rd" with the following
            | Action | Name | Value    |
            | Add    | View | PLV2LVL3 |
        And I use the API to favorite patient list "VerveDel AssignmentTab Search Test" with alias "Alias for tab search test" for user "PLV2LVL3" owned by "PLV2the3rd"
        And I click the "Refresh Patient List" button
        When I am on the "Assignment" tab
        And I click the "Refresh" button
        And I open the search screen from the assignment list dropdown
        And I clear and enter "Alias for tab search test" in the "Patient List Search" field
#        And I enter "Alias for tab search test" in the "Patient List Search" field
        And I click the "Search Patient List" button
        Then the following rows should appear in the "Patient List Search Results" table
          | NAME                               |
            | VerveDel AssignmentTab Search Test |
        And I click the "CancelPatientSearchPopUp" button

#Sort Columns on Sublists
    Scenario: 15. Sort List by Name in Ascending order
        And I use the API to create a patient list named "VerveDel AssignmentTab Sort Test" owned by "PLV2LVL3" with the following parameters
            | Type            | Name            | Value                          |
            | Description     |                 | For assignment tab search test |
            | Filter          | Medical Service | Central Clinic                 |
            | List Type       |                 | ASSIGNMENT                     |
            | Assignment List |                 | VerveDel Assignment Sort Test1 |
            | Assignment List |                 | VerveDel Assignment Sort Test2 |
        And I click the "Refresh Patient List" button
        When I am on the "Assignment" tab
        And I click the "Refresh" button
      And I open the search screen from the assignment list dropdown
      And I enter "VerveDel AssignmentTab Sort Test" in the "Patient List Search" field
      And I click the "Search Patient List" button
      And I select "VerveDel AssignmentTab Sort Test" in the "Patient List Search Results" table
      And I click the "Select Patient List" button
      And I click the "Lists To Display" dropdown
      And I check the following sublists
        | Unassigned                     |
        | VerveDel Assignment Sort Test1 |
      And I click the "List To Display" element
      And I sort the "Unassigned" sublist by "Name" in "Ascending" order
      And I wait "5" seconds
      Then the "Unassigned" sublist should be sorted by "Name" in "Ascending" order

    Scenario: 16. Sort List by Name in Descending order
        And I use the API to create a patient list named "VerveDel AssignmentTab Sort Test" owned by "PLV2LVL3" with the following parameters
            | Type            | Name            | Value                          |
            | Description     |                 | For assignment tab search test |
            | Filter          | Medical Service | Central Clinic                 |
            | List Type       |                 | ASSIGNMENT                     |
            | Assignment List |                 | VerveDel Assignment Sort Test1 |
            | Assignment List |                 | VerveDel Assignment Sort Test2 |
        And I click the "Refresh Patient List" button
        When I am on the "Assignment" tab
        And I click the "Refresh" button
      And I open the search screen from the assignment list dropdown
      And I enter "VerveDel AssignmentTab Sort Test" in the "Patient List Search" field
      And I click the "Search Patient List" button
      And I select "VerveDel AssignmentTab Sort Test" in the "Patient List Search Results" table
      And I click the "Select Patient List" button
      And I click the "Lists To Display" dropdown
      And I check the following sublists
        | Unassigned                     |
        | VerveDel Assignment Sort Test1 |
      And I click the "List To Display" element
      And I sort the "Unassigned" sublist by "Name" in "Descending" order
      And I wait "5" seconds
      Then the "Unassigned" sublist should be sorted by "Name" in "Descending" order

    Scenario: 17. Sort List by Location in Ascending order
        And I use the API to create a patient list named "VerveDel AssignmentTab Sort Test" owned by "PLV2LVL3" with the following parameters
            | Type            | Name            | Value                          |
            | Description     |                 | For assignment tab search test |
            | Filter          | Medical Service | Central Clinic                 |
            | List Type       |                 | ASSIGNMENT                     |
            | Assignment List |                 | VerveDel Assignment Sort Test1 |
            | Assignment List |                 | VerveDel Assignment Sort Test2 |
        And I click the "Refresh Patient List" button
        When I am on the "Assignment" tab
        And I click the "Refresh" button
        And I open the search screen from the assignment list dropdown
        And I enter "VerveDel AssignmentTab Sort Test" in the "Patient List Search" field
        And I click the "Search Patient List" button
        And I select "VerveDel AssignmentTab Sort Test" in the "Patient List Search Results" table
        And I click the "Select Patient List" button
        And I click the "Lists To Display" dropdown
        And I check the following sublists
            | Unassigned                     |
            | VerveDel Assignment Sort Test1 |
        And I click the "List To Display" element
        And I sort the "Unassigned" sublist by "Location" in "Ascending" order
        Then the "Unassigned" sublist should be sorted by "Location" in "Ascending" order

    Scenario: 18. Sort List by Location in Descending order
        And I use the API to create a patient list named "VerveDel AssignmentTab Sort Test" owned by "PLV2LVL3" with the following parameters
            | Type            | Name            | Value                          |
            | Description     |                 | For assignment tab search test |
            | Filter          | Medical Service | Central Clinic                 |
            | List Type       |                 | ASSIGNMENT                     |
            | Assignment List |                 | VerveDel Assignment Sort Test1 |
            | Assignment List |                 | VerveDel Assignment Sort Test2 |
        And I click the "Refresh Patient List" button
        When I am on the "Assignment" tab
        And I click the "Refresh" button
        And I open the search screen from the assignment list dropdown
        And I enter "VerveDel AssignmentTab Sort Test" in the "Patient List Search" field
        And I click the "Search Patient List" button
        And I select "VerveDel AssignmentTab Sort Test" in the "Patient List Search Results" table
        And I click the "Select Patient List" button
        And I click the "Lists To Display" dropdown
        And I check the following sublists
            | Unassigned                     |
            | VerveDel Assignment Sort Test1 |
        And I click the "List To Display" element
        And I sort the "Unassigned" sublist by "Location" in "Descending" order
        Then the "Unassigned" sublist should be sorted by "Location" in "Descending" order

    Scenario: 19. Display correct patient count for Assignment List and its sub lists - [DEV-52823]
        And I use the API to create a patient list named "Assignment Tab Test" owned by "PLV2LVL3" with the following parameters
            |Type            |Name            |Value          |
            |Filter          |Medical Service |Central Clinic |
            |List Type       |                |ASSIGNMENT     |
            |Assignment List |                |AssignSublist1 |
            |Assignment List |                |AssignSublist2 |
            |Assignment List |                |AssignSublist3 |
        And I click the "Refresh Patient List" button
        Then I am on the "Assignment" tab
        And I click the "Refresh" button
        And I open the search screen from the assignment list dropdown
        And I wait up to "10" seconds for the "Patient List Search" field of type "TEXT_FIELD" to be visible
        And I enter "Assignment Tab Test" in the "Patient List Search" field
        And I click the "Search Patient List" button
        And I select "Assignment Tab Test" in the "Patient List Search Results" table
        And I click the "Select Patient List" button
        And I click the "Lists To Display" dropdown
        And I check the following sublists
            | Assignment Tab Test |
            | Unassigned          |
        And I click the "List To Display" element
        And the patient count of the "Assignment Tab Test" should be equal to "Unassigned"