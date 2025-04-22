@PatientListV2
Feature: Patient List V2 Delete Patient Lists
  Test patient list deletion

  Background:
    Given I am logged into the portal with user "PLV2DELETE" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized

  Scenario: Delete Patient List of type List
    When I use the API to create a patient list named "VerveDel Delete Test" owned by "PLV2DELETE" with the following parameters
      |Type     |Name            |Value         |
      |Filter   |Medical Service |PLM2Test-TBC  |
    And I click the "Refresh Patient List" button
    And I select "VerveDel Delete Test" from the "Patient List" menu
    And I select "Edit" from the "Actions" menu
    And I click the "Create Patient Delete Patient List" button
    Then the text "Deleting the selected list is a permanent action and cannot be undone. Are you sure?" should appear in the "Delete Patient List" pane
    And I click the "Delete" button in the "Delete Patient List" pane
    Then the "Patient List" menu should not have the following options
      |VerveDel Delete Test |

  Scenario: Cancel Delete of Patient List
    When I select "Cancel Delete Test" from the "Patient List" menu
    And I select "Edit" from the "Actions" menu
    And I click the "Create Patient Delete Patient List" button
    And I click the "Cancel Delete Patient List" button in the "Delete Patient List" pane
    And I click the "Create Patient List Cancel" button
    Then the "Patient List" menu should have the following options
      | Cancel Delete Test |

  Scenario: Delete Patient Assignment List
    When I use the API to create a patient list named "VerveDel Delete Assignment Test" owned by "PLV2DELETE" with the following parameters
      | Type      | Name            | Value        |
      | Filter    | Medical Service | PLM2Test-TBC |
      | List Type |                 | ASSIGNMENT   |
    And I click the "Refresh Patient List" button
    And I select "VerveDel Delete Assignment Test" from the "Patient List" menu
    And I select "Edit" from the "Actions" menu
    And I click the "Create Patient Delete Patient List" button
    And I click the "Delete" button in the "Delete Patient List" pane
    Then the "Patient List" menu should not have the following options
      | VerveDel Delete Assignment Test |

  Scenario: Cancel Delete of Patient Assignment List
    And I select "Cancel Delete Assignment Test" from the "Patient List" menu
    And I select "Edit" from the "Actions" menu
    And I click the "Create Patient Delete Patient List" button
    And I click the "Cancel Delete Patient List" button in the "Delete Patient List" pane
    And I click the "Create Patient List Cancel" button
    Then the "Patient List" menu should have the following options
      | Cancel Delete Assignment Test |

  Scenario: Delete Patient View List
    When I use the API to create a patient list named "VerveDel Source List for Delete Test" owned by "PLV2DELETE" with the following parameters
      | Type   | Name            | Value        |
      | Filter | Medical Service | PLM2Test-TBC |
    When I use the API to create a patient list named "VerveDel Delete View Test" owned by "PLV2DELETE" with the following parameters
      | Type        | Name            | Value                                |
      | Filter      | Medical Service | PLM2Test-TBC                         |
      | List Type   |                 | VIEW                                 |
      | Source List |                 | VerveDel Source List for Delete Test |
    And I click the "Refresh Patient List" button
    And I select "VerveDel Source List for Delete Test" from the "Patient List" menu
    And I select "Edit" from the "Actions" menu
    And I click the "Create Patient Delete Patient List" button
    And I click the "Remove and Delete" button in the "Delete Patient List" pane
    And I click the "DeletePatientListConfirm" button in the "Delete Patient List" pane
    Then the "Patient List" menu should not have the following options
      | VerveDel Source List for Delete Test |

  Scenario: Delete Source List from View List
    When I use the API to create a patient list named "VerveDel Source List for Delete Test2" owned by "PLV2DELETE" with the following parameters
      | Type   | Name            | Value        |
      | Filter | Medical Service | PLM2Test-TBC |
    When I use the API to create a patient list named "VerveDel Delete View Test2" owned by "PLV2DELETE" with the following parameters
      | Type        | Name            | Value                                 |
      | Filter      | Medical Service | PLM2Test-TBC                          |
      | List Type   |                 | VIEW                                  |
      | Source List |                 | VerveDel Source List for Delete Test2 |
    And I click the "Refresh Patient List" button
    And I select "VerveDel Source List for Delete Test2" from the "Patient List" menu
    And I select "Edit" from the "Actions" menu
    And I click the "Create Patient Delete Patient List" button
#    Then the text "This list is associated with the following Patient List Views. Deleting this list will remove it from the associated Views." should appear in the "Delete Patient List" pane
    And I click the "Remove and Delete" button in the "Delete Patient List" pane
    And I click the "Delete PatientList Confirm" button in the "Delete Patient List" pane
    Then the "Patient List" menu should not have the following options
      | VerveDel Source List for Delete Test2 |
    And I select "VerveDel Delete View Test2" from the "Patient List" menu
    And I select "Show Properties" from the "Actions" menu
    Then the text "VerveDel Source List for Delete Test2" should not appear in the "Patient List Criteria" pane
    And I click the "Close Patient List Criteria" button

  Scenario: Cancel Delete of Patient View List
    When I use the API to create a patient list named "VerveDel Source List for View Cancel Delete Test" owned by "PLV2DELETE" with the following parameters
      | Type   | Name            | Value        |
      | Filter | Medical Service | PLM2Test-TBC |
    When I use the API to create a patient list named "VerveDel Cancel Delete View Test" owned by "PLV2DELETE" with the following parameters
      | Type        | Name            | Value                                            |
      | Filter      | Medical Service | PLM2Test-TBC                                     |
      | List Type   |                 | VIEW                                             |
      | Source List |                 | VerveDel Source List for View Cancel Delete Test |
    And I click the "Refresh Patient List" button
    And I select "VerveDel Cancel Delete View Test" from the "Patient List" menu
    And I select "Edit" from the "Actions" menu
    And I click the "Create Patient Delete Patient List" button
    And I click the "Cancel Delete Patient List" button in the "Delete Patient List" pane
    And I click the "Create Patient List Cancel" button
    Then the "Patient List" menu should have the following options
      | VerveDel Cancel Delete View Test |

  Scenario: Cancel Delete of Patient Source List
    When I use the API to create a patient list named "VerveDel Source List for Delete Test3" owned by "PLV2DELETE" with the following parameters
      | Type   | Name            | Value        |
      | Filter | Medical Service | PLM2Test-TBC |
    When I use the API to create a patient list named "VerveDel Delete View Test3" owned by "PLV2DELETE" with the following parameters
      | Type        | Name            | Value                                 |
      | Filter      | Medical Service | PLM2Test-TBC                          |
      | List Type   |                 | VIEW                                  |
      | Source List |                 | VerveDel Source List for Delete Test3 |
    And I click the "Refresh Patient List" button
    And I select "VerveDel Source List for Delete Test3" from the "Patient List" menu
    And I select "Edit" from the "Actions" menu
    And I click the "Create Patient Delete Patient List" button
    Then the text "This list is associated with the following Patient List Views. Deleting this list will remove it from the associated Views." should appear in the "Delete Patient List" pane
    And I click the "Delete Patient List Cancel" button in the "Delete Patient List" pane
    And I wait "2" seconds
    And I click the "Create Patient List Cancel" button
    Then the "Patient List" menu should have the following options
      | VerveDel Source List for Delete Test3 |

  Scenario: Attempt to Delete Patient List, No Permission
    When I use the API to create a patient list named "VerveDel Delete No Permission" owned by "PLV2DELETE" with the following parameters
      |Type       |Name            |Value        |
      |Filter     |Medical Service |PLM2Test-TBC |
      |Permission |View            |All Users    |
    And I am logged into the portal with user "PLV2the2nd" using the default password
    And I select "Find a Patient List" from the "Actions" menu
    And I enter "VerveDel Delete No Permission" in the "Patient List Search" field
    And I click the "Search Patient List" button
    And I favorite the list by clicking the "Patient List Favorite" button in the row with "VerveDel Delete No Permission" as the value under "Name" in the "Patient List Search Results" table
    And I click the "Edit Favorite Save" button
    And I click the "Close Search For Patient List" button
    And I select "VerveDel Delete No Permission" from the "Patient List" menu
    And I select "Edit" from the "Actions" menu
    And I wait "3" seconds
    Then The following field should not display in the "EditPatientLists" pane
      |Name                               |Type   |
      |Create Patient Delete Patient List |button |

  Scenario: Delete List Created By Other User
    When I use the API to create a patient list named "VerveDel Created By Other" owned by "PLV2DELETE" with the following parameters
      | Type       | Name            | Value        |
      | Filter     | Medical Service | PLM2Test-TBC |
      | Permission | View            | All Users    |
      | Permission | Manage          | All Users    |
    And I am logged into the portal with user "PLV2DELETELVL3PERM" using the default password
    And I select "Find a Patient List" from the "Actions" menu
    And I enter "VerveDel Created By Other" in the "Patient List Search" field
    And I click the "Search Patient List" button
    And I favorite the list by clicking the "Patient List Favorite" button in the row with "VerveDel Created By Other" as the value under "Name" in the "Patient List Search Results" table
#    And I click the "Favorite" button in the row with "VerveDel Created By Other" as the value under "Name" in the "Patient List Search Results" table
    And I click the "Edit Favorite Save" button
    And I click the "Close Search For Patient List" button
    And I select "VerveDel Created By Other" from the "Patient List" menu
    And I select "Edit" from the "Actions" menu
    And I wait "3" seconds
    And I click the "Create Patient Delete Patient List" button
    And I click the "Delete" button in the "Delete Patient List" pane
    Then the "Patient List" menu should not have the following options
      | VerveDel Created By Other |

  Scenario: Unable to Delete List When 'Override Patient List View and Manage Permissions' Set to False
    Given I am logged into the portal with user "PLV2DELETELVL2NOPERM" using the default password
    And I am on the "Patient List V2" tab
    And I select "Verve No Override Del Test" from the "Patient List" menu
    And I select "Edit" from the "Actions" menu
    And I wait "3" seconds
    Then The following field should be not display in the "EditPatientLists" pane
      |Name                               |Type   |
      |Create Patient Delete Patient List |button |

  Scenario: Able to Delete List When 'Override Patient List View and Manage Permissions' Set to False
    When I use the API to create a patient list named "VerveDel Override Del Test" owned by "PLV2DELETE" with the following parameters
      |Type       |Name            |Value        |
      |Filter     |Medical Service |PLM2Test-TBC |
      |Permission |View            |All Users    |
    Given I am logged into the portal with user "PLV2DELETELVL2PERM" using the default password
    And I am on the "Patient List V2" tab
    And I select "Find a Patient List" from the "Actions" menu
    And I enter "VerveDel Override Del Test" in the "Patient List Search" field
    And I click the "Search Patient List" button
    And I favorite the list by clicking the "Patient List Favorite" button in the row with "VerveDel Override Del Test" as the value under "Name (\d)" in the "Patient List Search Results" table
    And I click the "Edit Favorite Save" button
    And I click the "Close Search For Patient List" button
    And I select "VerveDel Override Del Test" from the "Patient List" menu
    And I select "Edit" from the "Actions" menu
    And I click the "Create Patient Delete Patient List" button
    And I click the "Delete" button in the "Delete Patient List" pane
    Then the "Patient List" menu should not have the following options
      | VerveDel Override Del Test |

  Scenario: Verify Deleted List Doesn't Appear In Batch Charge Entry
    When I use the API to create a patient list named "VerveDel Delete BatchCharge" owned by "PLV2DELETE" with the following parameters
      | Type   | Name            | Value        |
      | Filter | Medical Service | PLM2Test-TBC |
    And I click the "Refresh Patient List" button
    When I select "VerveDel Delete BatchCharge" from the "Patient List" menu
    And I select "Edit" from the "Actions" menu
    And I click the "Create Patient Delete Patient List" button
    And I click the "Delete" button in the "Delete Patient List" pane
    When I am on the "Charges" tab
    And I select the "Batch Charge Entry" subtab
    Then the "Batch Charge Entry" menu should not have the following options
      | VerveDel Delete BatchCharge |

 #dummy scenario to illustrate modify permissions step
  @donotrun
  Scenario: Test modify permissions
    When I use the API to create a patient list named "VerveDel Test Modify" owned by "PLV2DELETE" with the following parameters
      |Type       |Name            |Value        |
      |Filter     |Medical Service |PLM2Test-TBC |
      |Permission |View            |All Users    |
    And I use the API to update the permissions for the patient list named "VerveDel Test Modify" owned by "PLV2DELETE" with the following
      |Action     |Name            |Value            |
      |Add        |Add/Remove      |FAC:GHDOHospital |
      |Remove     |View            |All Users        |

  Scenario: Remove Sublist from Assignment List
    When I use the API to create a patient list named "VerveDel Delete Assignment Test" owned by "PLV2DELETE" with the following parameters
      | Type            | Name            | Value                |
      | Filter          | Medical Service | PLM2Test-TBC         |
      | List Type       |                 | ASSIGNMENT           |
      | Assignment List |                 | VerveDel Assignment1 |
      | Assignment List |                 | VerveDel Assignment2 |
      | Assignment List |                 | VerveDel Assignment3 |
    And I click the "Refresh Patient List" button
    Then the "Patient List" menu should have the following options
      | Unassigned - VerveDel Delete Assignment Test |
      | VerveDel Delete Assignment Test              |
      | VerveDel Assignment1                         |
      | VerveDel Assignment2                         |
      | VerveDel Assignment3                         |
    When I select "VerveDel Delete Assignment Test" from the "Patient List" menu
    And I select patient "TBCTEST, 01" from the patient list
    And I select "Reassign Patient" from the "Actions" menu
    And I wait up to "10" seconds for the "To Sub List" field of type "RADIO" to be visible
    And I select "VerveDel Assignment1" from the "To Sub List" radio list in the "Reassign Patient" pane
    And I click the "Reassign" button in the "Reassign Patient" pane
    And I select "Reassign Patient" from the "Actions" menu
    And I wait up to "10" seconds for the "To Sub List" field of type "RADIO" to be visible
    And The "Current List" element should appear with the text "VerveDel Assignment1" in the "Reassign Patient" pane
    And I click the "Reassign Patient Cancel" button in the "Reassign Patient" pane
    When I select "VerveDel Delete Assignment Test" from the "Patient List" menu
    And I select "Edit" from the "Actions" menu
    And the "Edit Patient Lists" pane should load
    And I click the "Remove" element
    And I click the "YesDelete" button
    And I click the "Create Patient List Save" button
    And I click the "Refresh Patient List" button
    Then the "Patient List" menu should not have the following options
      | VerveDel Assignment1            |
    Then the "Patient List" menu should have the following options
      | Unassigned - VerveDel Delete Assignment Test |
      | VerveDel Delete Assignment Test              |
      | VerveDel Assignment2                         |
      | VerveDel Assignment3                         |


  Scenario: Delete All Source Lists
    When I use the API to create a patient list named "VerveDel Source List 1 for View Test4" owned by "PLV2DELETE" with the following parameters
      | Type   | Name            | Value        |
      | Filter | Medical Service | PLM2Test-TBC |
    And I use the API to create a patient list named "VerveDel Source List 2 for View Test4" owned by "PLV2DELETE" with the following parameters
      | Type   | Name            | Value        |
      | Filter | Medical Service | PLM2Test-TBC |
    And I use the API to create a patient list named "VerveDel Source List 3 for View Test4" owned by "PLV2DELETE" with the following parameters
      | Type   | Name            | Value        |
      | Filter | Medical Service | PLM2Test-TBC |
    And I use the API to create a patient list named "VerveDel Delete View Test4" owned by "PLV2DELETE" with the following parameters
      | Type        | Name            | Value                                 |
      | Filter      | Medical Service | PLM2Test-TBC                          |
      | List Type   |                 | VIEW                                  |
      | Source List |                 | VerveDel Source List 1 for View Test4 |
      | Source List |                 | VerveDel Source List 2 for View Test4 |
      | Source List |                 | VerveDel Source List 3 for View Test4 |
    And I click the "Refresh Patient List" button
    And I select "VerveDel Source List 1 for View Test4" from the "Patient List" menu
    And I select "Edit" from the "Actions" menu
    And I click the "Create Patient Delete Patient List" button
    And I click the "Remove and Delete" button in the "Delete Patient List" pane
    And I click the "DeletePatientListConfirm" button in the "Delete Patient List" pane
    And I click the "Refresh Patient List" button
    And I select "VerveDel Source List 2 for View Test4" from the "Patient List" menu
    And I select "Edit" from the "Actions" menu
    And I click the "Create Patient Delete Patient List" button
    And I click the "Remove and Delete" button in the "Delete Patient List" pane
    And I click the "DeletePatientListConfirm" button in the "Delete Patient List" pane
#    And I click the "Delete" button in the "Delete Patient List" pane
    And I click the "Refresh Patient List" button
    And I select "VerveDel Source List 3 for View Test4" from the "Patient List" menu
    And I select "Edit" from the "Actions" menu
    And I click the "Create Patient Delete Patient List" button
    And I click the "Remove and Delete" button in the "Delete Patient List" pane
    And I click the "DeletePatientListConfirm" button in the "Delete Patient List" pane
    And I click the "Refresh Patient List" button
    Then the "Patient List" menu should not have the following options
      | VerveDel Source List 1 for View Test4 |
      | VerveDel Source List 2 for View Test4 |
      | VerveDel Source List 3 for View Test4 |
    When I select "VerveDel Delete View Test4" from the "Patient List" menu
    Then the text "No patients meet the current patient list criteria." should appear in the "Patient List" pane

  Scenario: Validate Delete Action Recorded in Audit Report
    When I use the API to create a patient list named "VerveDel Delete Audit Test" owned by "PLV2DELETE" with the following parameters
      |Type     |Name            |Value         |
      |Filter   |Medical Service |PLM2Test-TBC  |
    And I click the "Refresh Patient List" button
    And I select "VerveDel Delete Audit Test" from the "Patient List" menu
    And I select "Edit" from the "Actions" menu
    And I click the "Create Patient Delete Patient List" button
    And I click the "Delete" button in the "Delete Patient List" pane
    Given I am logged into the portal with user "PLV2ADMIN" using the default password
    And I am on the "Admin" tab
    And I select the "System Management" subtab
    And I click the "Audit Report" link in the "System Management Navigation" pane
    When I enter "%Current Date MMDDYY%" in the "Start Date" field in the "Audit Report" pane
    And I enter "%Current Date MMDDYY%" in the "End Date" field in the "Audit Report" pane
    And I enter "PLV2DELETE" in the "Select Users" field in the "Audit Report" pane
    And I click the "Lookup User" element in the "Audit Report" pane
    And I select "PLV2DELETE" from the "Last Name" column in the "Lookup User" table
    And I click the "Show Audit Records" button in the "Audit Report" pane
    Then the "Audit Report" table should load
    Then rows containing the following should appear in the "Audit Report" table
      | Date/Time             | User              | Description                                           |
      | %Current Date MMDDYY% | PLV2DELETE, VERVE | ListName : VerveDel Delete Audit Test ListType : LIST |

  Scenario: Validate Deleted List is Not Available in Add Patient to Another List Screen
    When I use the API to create a patient list named "VerveDel Delete Cannot Add Patient Test" owned by "PLV2DELETE" with the following parameters
      |Type       |Name            |Value        |
      |Filter     |Medical Service |PLM2Test-TBC |
    When I use the API to create a patient list named "VerveDel Delete Cannot Add Patient Test2" owned by "PLV2DELETE" with the following parameters
      |Type       |Name            |Value        |
      |Filter     |Medical Service |PLM2Test-TBC |
    And I click the "Refresh Patient List" button
    And I select "VerveDel Delete Cannot Add Patient Test" from the "Patient List" menu
    And I select "Edit" from the "Actions" menu
    And I click the "Create Patient Delete Patient List" button
    And I click the "Delete" button in the "Delete Patient List" pane
    And I click the "Refresh Patient List" button
    And I select "VerveDel Delete Cannot Add Patient Test2" from the "Patient List" menu
    And I select patient "TBCTEST, 08" from the patient list
    And I select "Add Patient(s) To Another List" from the "Actions" menu
    And I wait "2" seconds
    Then the "Select a Patient List" pkdropdown should not have the following items
      | VerveDel Delete Cannot Add Patient Test |

  @donotrun
  Scenario: Validate Deleted List is Not Available in Assignment Tab List
    When I use the API to create a patient list named "VerveDel Delete Assignment Tab Test" owned by "PLV2DELETE" with the following parameters
      | Type   | Name            | Value        |
      | Filter | Medical Service | PLM2Test-TBC |
    And I click the "Refresh Patient List" button
    When I select "VerveDel Delete Assignment Tab Test" from the "Patient List" menu
    And I select "Edit" from the "Actions" menu
    And I click the "Create Patient Delete Patient List" button
    And I click the "Delete" button in the "Delete Patient List" pane
    When I am on the "Assignment" tab
    Then the "Assignment List" pkdropdown should not have the following items
      | VerveDel Delete Assignment Tab Test |










#@PatientListV2
#Feature: Patient List V2 Delete Patient Lists
#  Test patient list deletion
#
#  Background:
#    Given I am logged into the portal with user "PLV2DELETE" using the default password
#    And I am on the "Patient List V2" tab
##    And the patient list is maximized
#
#  Scenario: Delete Patient List of type List
##    When I use the API to create a patient list named "VerveDel Delete Test" owned by "PLV2DELETE" with the following parameters
##      |Type     |Name            |Value         |
##      |Filter   |Medical Service |PLM2Test-TBC  |
##
##    When I use the API to create a patient list named "VerveDel Delete Assignment Test" owned by "PLV2DELETE" with the following parameters
##      | Type      | Name            | Value        |
##      | Filter    | Medical Service | PLM2Test-TBC |
##      | List Type |                 | ASSIGNMENT   |
##
##    When I use the API to create a patient list named "VerveDel Source List for Delete Test" owned by "PLV2DELETE" with the following parameters
##      | Type   | Name            | Value        |
##      | Filter | Medical Service | PLM2Test-TBC |
##
##    When I use the API to create a patient list named "VerveDel Delete View Test" owned by "PLV2DELETE" with the following parameters
##      | Type        | Name            | Value                                |
##      | Filter      | Medical Service | PLM2Test-TBC                         |
##      | List Type   |                 | VIEW                                 |
##      | Source List |                 | VerveDel Source List for Delete Test |
##
##    When I use the API to create a patient list named "VerveDel Source List for Delete Test2" owned by "PLV2DELETE" with the following parameters
##      | Type   | Name            | Value        |
##      | Filter | Medical Service | PLM2Test-TBC |
##
##    When I use the API to create a patient list named "VerveDel Delete View Test2" owned by "PLV2DELETE" with the following parameters
##      | Type        | Name            | Value                                 |
##      | Filter      | Medical Service | PLM2Test-TBC                          |
##      | List Type   |                 | VIEW                                  |
##      | Source List |                 | VerveDel Source List for Delete Test2 |
##
##    When I use the API to create a patient list named "VerveDel Source List for View Cancel Delete Test" owned by "PLV2DELETE" with the following parameters
##      | Type   | Name            | Value        |
##      | Filter | Medical Service | PLM2Test-TBC |
##
##    When I use the API to create a patient list named "VerveDel Cancel Delete View Test" owned by "PLV2DELETE" with the following parameters
##      | Type        | Name            | Value                                            |
##      | Filter      | Medical Service | PLM2Test-TBC                                     |
##      | List Type   |                 | VIEW                                             |
##      | Source List |                 | VerveDel Source List for View Cancel Delete Test |
##
##    When I use the API to create a patient list named "VerveDel Source List for Delete Test3" owned by "PLV2DELETE" with the following parameters
##      | Type   | Name            | Value        |
##      | Filter | Medical Service | PLM2Test-TBC |
##
##    When I use the API to create a patient list named "VerveDel Delete View Test3" owned by "PLV2DELETE" with the following parameters
##      | Type        | Name            | Value                                 |
##      | Filter      | Medical Service | PLM2Test-TBC                          |
##      | List Type   |                 | VIEW                                  |
##      | Source List |                 | VerveDel Source List for Delete Test3 |
##
##    When I use the API to create a patient list named "VerveDel Delete No Permission" owned by "PLV2DELETE" with the following parameters
##      |Type       |Name            |Value        |
##      |Filter     |Medical Service |PLM2Test-TBC |
##      |Permission |View            |All Users    |
##
##    When I use the API to create a patient list named "VerveDel Created By Other" owned by "PLV2DELETE" with the following parameters
##      | Type       | Name            | Value        |
##      | Filter     | Medical Service | PLM2Test-TBC |
##      | Permission | View            | All Users    |
##      | Permission | Manage          | All Users    |
##
##    When I use the API to create a patient list named "VerveDel Override Del Test" owned by "PLV2DELETE" with the following parameters
##      |Type       |Name            |Value        |
##      |Filter     |Medical Service |PLM2Test-TBC |
##      |Permission |View            |All Users    |
##
##    When I use the API to create a patient list named "VerveDel Delete BatchCharge" owned by "PLV2DELETE" with the following parameters
##      | Type   | Name            | Value        |
##      | Filter | Medical Service | PLM2Test-TBC |
#
#    When I use the API to create a patient list named "VerveDel Test Modify" owned by "PLV2DELETE" with the following parameters
#      |Type       |Name            |Value        |
#      |Filter     |Medical Service |PLM2Test-TBC |
#      |Permission |View            |All Users    |
#
#    And I use the API to update the permissions for the patient list named "VerveDel Test Modify" owned by "PLV2DELETE" with the following
#      |Action     |Name            |Value            |
#      |Add        |Add/Remove      |FAC:GHDOHospital |
#      |Remove     |View            |All Users        |
#
#    When I use the API to create a patient list named "VerveDel Delete Assignment Test" owned by "PLV2DELETE" with the following parameters
#      | Type            | Name            | Value                |
#      | Filter          | Medical Service | PLM2Test-TBC         |
#      | List Type       |                 | ASSIGNMENT           |
#      | Assignment List |                 | VerveDel Assignment1 |
#      | Assignment List |                 | VerveDel Assignment2 |
#      | Assignment List |                 | VerveDel Assignment3 |
#
#    When I use the API to create a patient list named "VerveDel Source List 1 for View Test4" owned by "PLV2DELETE" with the following parameters
#      | Type   | Name            | Value        |
#      | Filter | Medical Service | PLM2Test-TBC |
#    And I use the API to create a patient list named "VerveDel Source List 2 for View Test4" owned by "PLV2DELETE" with the following parameters
#      | Type   | Name            | Value        |
#      | Filter | Medical Service | PLM2Test-TBC |
#    And I use the API to create a patient list named "VerveDel Source List 3 for View Test4" owned by "PLV2DELETE" with the following parameters
#      | Type   | Name            | Value        |
#      | Filter | Medical Service | PLM2Test-TBC |
#    And I use the API to create a patient list named "VerveDel Delete View Test4" owned by "PLV2DELETE" with the following parameters
#      | Type        | Name            | Value                                 |
#      | Filter      | Medical Service | PLM2Test-TBC                          |
#      | List Type   |                 | VIEW                                  |
#      | Source List |                 | VerveDel Source List 1 for View Test4 |
#      | Source List |                 | VerveDel Source List 2 for View Test4 |
#      | Source List |                 | VerveDel Source List 3 for View Test4 |
#
#    When I use the API to create a patient list named "VerveDel Delete Audit Test" owned by "PLV2DELETE" with the following parameters
#      |Type     |Name            |Value         |
#      |Filter   |Medical Service |PLM2Test-TBC  |
#
#    When I use the API to create a patient list named "VerveDel Delete Cannot Add Patient Test" owned by "PLV2DELETE" with the following parameters
#      |Type       |Name            |Value        |
#      |Filter     |Medical Service |PLM2Test-TBC |
#    When I use the API to create a patient list named "VerveDel Delete Cannot Add Patient Test2" owned by "PLV2DELETE" with the following parameters
#      |Type       |Name            |Value        |
#      |Filter     |Medical Service |PLM2Test-TBC |
#
#    When I use the API to create a patient list named "VerveDel Delete Assignment Tab Test" owned by "PLV2DELETE" with the following parameters
#      | Type   | Name            | Value        |
#      | Filter | Medical Service | PLM2Test-TBC |
#
#
##    And I click the "Refresh Patient List" button
##    And I select "VerveDel Delete Test" from the "Patient List" menu
##    And I select "Edit" from the "Actions" menu
##    And I click the "Create Patient Delete Patient List" button
##    Then the text "Deleting the selected list is a permanent action and cannot be undone. Are you sure?" should appear in the "Delete Patient List" pane
##    And I click the "Delete" button in the "Delete Patient List" pane
##    Then the "Patient List" menu should not have the following options
##      |VerveDel Delete Test |
##
##  Scenario:
##    Given API: I am logged into the portal with user "pkadmin" using the default password
##    And API: I close the following tabs
##      |A|B|
##    And API: I open the following tabs
##      |A|B|