#Level 2 user required for 'Override Yes' tests

@PatientListV2
Feature: Patient List V2 Assignment Tab Permissions Tests

  Scenario: 0004 Search - Restrict All, Override No
    Given I am logged into the portal with user "PLV2PermTest1" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    And I use the API to create a patient list named "VerveDel AssignmentTab Perm Test1" owned by "PLV2PermTest1" with the following parameters
      | Type      | Name            | Value        |
      | Filter    | Medical Service | PLM2Test-TBC |
      | List Type |                 | ASSIGNMENT   |

    And I use the API to create a patient list named "VerveDel AssignmentTab Perm Test1 View" owned by "PLV2PermTestBuddy" with the following parameters
      | Type      | Name            | Value        |
      | Filter    | Medical Service | PLM2Test-TBC |
      | List Type |                 | ASSIGNMENT   |
    And I use the API to update the permissions for the patient list named "VerveDel AssignmentTab Perm Test1 View" owned by "PLV2PermTestBuddy" with the following
      | Action | Name | Value         |
      | Add    | View | PLV2PermTest1 |

    And I use the API to create a patient list named "VerveDel AssignmentTab Perm Test1 Manage" owned by "PLV2PermTestBuddy" with the following parameters
      | Type      | Name            | Value        |
      | Filter    | Medical Service | PLM2Test-TBC |
      | List Type |                 | ASSIGNMENT   |
    And I use the API to update the permissions for the patient list named "VerveDel AssignmentTab Perm Test1 Manage" owned by "PLV2PermTestBuddy" with the following
      | Action | Name   | Value         |
      | Add    | Manage | PLV2PermTest1 |

    And I use the API to create a patient list named "VerveDel AssignmentTab Perm Test1 AddRemove" owned by "PLV2PermTestBuddy" with the following parameters
      | Type      | Name            | Value        |
      | Filter    | Medical Service | PLM2Test-TBC |
      | List Type |                 | ASSIGNMENT   |
    And I use the API to update the permissions for the patient list named "VerveDel AssignmentTab Perm Test1 AddRemove" owned by "PLV2PermTestBuddy" with the following
      | Action | Name       | Value         |
      | Add    | Add/Remove | PLV2PermTest1 |

   #List for which PLV2PermTest1 has no relation, no perms, and no shared dept/fac.  Should NOT appear in search results due to VIEW permission.
    And I use the API to create a patient list named "VerveDel AssignmentTab Perm Test1 NoPerm" owned by "PLV2PermTestBuddy2" with the following parameters
      | Type      | Name            | Value        |
      | Filter    | Medical Service | PLM2Test-TBC |
      | List Type |                 | ASSIGNMENT   |

    And I click the "Refresh Patient List" button
    When I am on the "Assignment" tab
    And I click the "Refresh" button
    And I open the search screen from the assignment list dropdown
    And I enter "VerveDel AssignmentTab Perm Test1" in the "Patient List Search" field
    And I click the "Search Patient List" button
    Then the following rows should match the "Patient List Search Results" clinical table
      | NAME                                        |
      | VerveDel AssignmentTab Perm Test1           |
      | VerveDel AssignmentTab Perm Test1 AddRemove |
      | VerveDel AssignmentTab Perm Test1 Manage    |
      | VerveDel AssignmentTab Perm Test1 View      |

  Scenario: 0005 Search - Restrict Facility, Override No
    Given I am logged into the portal with user "PLV2PermTest2" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    And I use the API to create a patient list named "VerveDel AssignmentTab Perm Test2" owned by "PLV2PermTest2" with the following parameters
      | Type      | Name            | Value        |
      | Filter    | Medical Service | PLM2Test-TBC |
      | List Type |                 | ASSIGNMENT   |
   #Shares facility with PLV2PermTestBuddy
    And I use the API to create a patient list named "VerveDel AssignmentTab Perm Test2 View" owned by "PLV2PermTestBuddy" with the following parameters
      | Type      | Name            | Value        |
      | Filter    | Medical Service | PLM2Test-TBC |
      | List Type |                 | ASSIGNMENT   |
    And I use the API to update the permissions for the patient list named "VerveDel AssignmentTab Perm Test2 View" owned by "PLV2PermTestBuddy" with the following
      | Action | Name | Value         |
      | Add    | View | PLV2PermTest2 |

    And I use the API to create a patient list named "VerveDel AssignmentTab Perm Test2 Manage" owned by "PLV2PermTestBuddy" with the following parameters
      | Type      | Name            | Value        |
      | Filter    | Medical Service | PLM2Test-TBC |
      | List Type |                 | ASSIGNMENT   |
    And I use the API to update the permissions for the patient list named "VerveDel AssignmentTab Perm Test2 Manage" owned by "PLV2PermTestBuddy" with the following
      | Action | Name   | Value         |
      | Add    | Manage | PLV2PermTest2 |

    And I use the API to create a patient list named "VerveDel AssignmentTab Perm Test2 AddRemove" owned by "PLV2PermTestBuddy" with the following parameters
      | Type      | Name            | Value        |
      | Filter    | Medical Service | PLM2Test-TBC |
      | List Type |                 | ASSIGNMENT   |
    And I use the API to update the permissions for the patient list named "VerveDel AssignmentTab Perm Test2 AddRemove" owned by "PLV2PermTestBuddy" with the following
      | Action | Name       | Value         |
      | Add    | Add/Remove | PLV2PermTest2 |
   #Shares department with PLV2PermTestBuddy2
    And I use the API to create a patient list named "VerveDel AssignmentTab Perm Test2 SharedDept" owned by "PLV2PermTestBuddy2" with the following parameters
      | Type      | Name            | Value        |
      | Filter    | Medical Service | PLM2Test-TBC |
      | List Type |                 | ASSIGNMENT   |
    And I use the API to update the permissions for the patient list named "VerveDel AssignmentTab Perm Test2 SharedDept" owned by "PLV2PermTestBuddy2" with the following
      | Action | Name       | Value         |
      | Add    | View       | PLV2PermTest2 |
      | Add    | Manage     | PLV2PermTest2 |
      | Add    | Add/Remove | PLV2PermTest2 |
   #No shared facility or departments with PLV2PermTestBuddy3
    And I use the API to create a patient list named "VerveDel AssignmentTab Perm Test2 NoShared" owned by "PLV2PermTestBuddy3" with the following parameters
      | Type      | Name            | Value        |
      | Filter    | Medical Service | PLM2Test-TBC |
      | List Type |                 | ASSIGNMENT   |
    And I use the API to update the permissions for the patient list named "VerveDel AssignmentTab Perm Test2 NoShared" owned by "PLV2PermTestBuddy3" with the following
      | Action | Name       | Value         |
      | Add    | View       | PLV2PermTest2 |
      | Add    | Manage     | PLV2PermTest2 |
      | Add    | Add/Remove | PLV2PermTest2 |

    And I click the "Refresh Patient List" button
    When I am on the "Assignment" tab
    And I click the "Refresh" button
    And I open the search screen from the assignment list dropdown
    And I enter "VerveDel AssignmentTab Perm Test2" in the "Patient List Search" field
    And I click the "Search Patient List" button
#    Then rows containing the following should appear in the "Patient List Search Results" table
    Then the following rows should match the "Patient List Search Results" table
      | NAME                                         |
      | VerveDel AssignmentTab Perm Test2            |
      | VerveDel AssignmentTab Perm Test2 AddRemove  |
      | VerveDel AssignmentTab Perm Test2 Manage     |
      | VerveDel AssignmentTab Perm Test2 SharedDept |
      | VerveDel AssignmentTab Perm Test2 View       |

  Scenario: 0006 Search - Restrict Department, Override No
    Given I am logged into the portal with user "PLV2PermTest3" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    And I use the API to create a patient list named "VerveDel AssignmentTab Perm Test3" owned by "PLV2PermTest3" with the following parameters
      | Type      | Name            | Value        |
      | Filter    | Medical Service | PLM2Test-TBC |
      | List Type |                 | ASSIGNMENT   |
   #Shares a department with PLV2PermTestBuddy2
    And I use the API to create a patient list named "VerveDel AssignmentTab Perm Test3 View" owned by "PLV2PermTestBuddy2" with the following parameters
      | Type      | Name            | Value        |
      | Filter    | Medical Service | PLM2Test-TBC |
      | List Type |                 | ASSIGNMENT   |
    And I use the API to update the permissions for the patient list named "VerveDel AssignmentTab Perm Test3 View" owned by "PLV2PermTestBuddy2" with the following
      | Action | Name | Value         |
      | Add    | View | PLV2PermTest3 |

    And I use the API to create a patient list named "VerveDel AssignmentTab Perm Test3 Manage" owned by "PLV2PermTestBuddy2" with the following parameters
      | Type      | Name            | Value        |
      | Filter    | Medical Service | PLM2Test-TBC |
      | List Type |                 | ASSIGNMENT   |
    And I use the API to update the permissions for the patient list named "VerveDel AssignmentTab Perm Test3 Manage" owned by "PLV2PermTestBuddy2" with the following
      | Action | Name   | Value         |
      | Add    | Manage | PLV2PermTest3 |

    And I use the API to create a patient list named "VerveDel AssignmentTab Perm Test3 AddRemove" owned by "PLV2PermTestBuddy2" with the following parameters
      | Type      | Name            | Value        |
      | Filter    | Medical Service | PLM2Test-TBC |
      | List Type |                 | ASSIGNMENT   |
    And I use the API to update the permissions for the patient list named "VerveDel AssignmentTab Perm Test3 AddRemove" owned by "PLV2PermTestBuddy2" with the following
      | Action | Name       | Value         |
      | Add    | Add/Remove | PLV2PermTest3 |
   #Shares a facility with PLV2PermTestBuddy
    And I use the API to create a patient list named "VerveDel AssignmentTab Perm Test3 SharedFac" owned by "PLV2PermTestBuddy" with the following parameters
      | Type      | Name            | Value        |
      | Filter    | Medical Service | PLM2Test-TBC |
      | List Type |                 | ASSIGNMENT   |
    And I use the API to update the permissions for the patient list named "VerveDel AssignmentTab Perm Test3 SharedFac" owned by "PLV2PermTestBuddy" with the following
      | Action | Name       | Value         |
      | Add    | View       | PLV2PermTest3 |
      | Add    | Manage     | PLV2PermTest3 |
      | Add    | Add/Remove | PLV2PermTest3 |
   #Nothing shared with PLV2PermTestBuddy3
    And I use the API to create a patient list named "VerveDel AssignmentTab Perm Test3 NoShared" owned by "PLV2PermTestBuddy3" with the following parameters
      | Type      | Name            | Value        |
      | Filter    | Medical Service | PLM2Test-TBC |
      | List Type |                 | ASSIGNMENT   |
    And I use the API to update the permissions for the patient list named "VerveDel AssignmentTab Perm Test3 NoShared" owned by "PLV2PermTestBuddy3" with the following
      | Action | Name       | Value         |
      | Add    | View       | PLV2PermTest3 |
      | Add    | Manage     | PLV2PermTest3 |
      | Add    | Add/Remove | PLV2PermTest3 |
     #Shares department with 'exclude from checks' set to 'Yes'
    And I use the API to create a patient list named "VerveDel AssignmentTab Perm Test3 DeptExclude" owned by "PLV2PermTestBuddy4" with the following parameters
      | Type      | Name            | Value        |
      | Filter    | Medical Service | PLM2Test-TBC |
      | List Type |                 | ASSIGNMENT   |
    And I use the API to update the permissions for the patient list named "VerveDel AssignmentTab Perm Test3 DeptExclude" owned by "PLV2PermTestBuddy4" with the following
      | Action | Name       | Value         |
      | Add    | View       | PLV2PermTest3 |

    And I click the "Refresh Patient List" button
    When I am on the "Assignment" tab
    And I click the "Refresh" button
    And I open the search screen from the assignment list dropdown
    And I enter "VerveDel AssignmentTab Perm Test3" in the "Patient List Search" field
    And I click the "Search Patient List" button
    Then the following rows should match the "Patient List Search Results" table
      | NAME                                        |
      | VerveDel AssignmentTab Perm Test3           |
      | VerveDel AssignmentTab Perm Test3 AddRemove |
      | VerveDel AssignmentTab Perm Test3 Manage    |
      | VerveDel AssignmentTab Perm Test3 View      |

  Scenario: 0007 Search - Restrict Only My Lists
    Given I am logged into the portal with user "PLV2PermTest4" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    And I use the API to create a patient list named "VerveDel AssignmentTab Perm Test4" owned by "PLV2PermTest4" with the following parameters
      | Type      | Name            | Value        |
      | Filter    | Medical Service | PLM2Test-TBC |
      | List Type |                 | ASSIGNMENT   |

   #Shares a department with PLV2PermTestBuddy2
    And I use the API to create a patient list named "VerveDel AssignmentTab Perm Test4 View" owned by "PLV2PermTestBuddy2" with the following parameters
      | Type      | Name            | Value        |
      | Filter    | Medical Service | PLM2Test-TBC |
      | List Type |                 | ASSIGNMENT   |
    And I use the API to update the permissions for the patient list named "VerveDel AssignmentTab Perm Test3 View" owned by "PLV2PermTestBuddy2" with the following
      | Action | Name | Value         |
      | Add    | View | PLV2PermTest4 |

    And I use the API to create a patient list named "VerveDel AssignmentTab Perm Test4 Manage" owned by "PLV2PermTestBuddy2" with the following parameters
      | Type      | Name            | Value        |
      | Filter    | Medical Service | PLM2Test-TBC |
      | List Type |                 | ASSIGNMENT   |
    And I use the API to update the permissions for the patient list named "VerveDel AssignmentTab Perm Test3 Manage" owned by "PLV2PermTestBuddy2" with the following
      | Action | Name   | Value         |
      | Add    | Manage | PLV2PermTest4 |

    And I use the API to create a patient list named "VerveDel AssignmentTab Perm Test4 AddRemove" owned by "PLV2PermTestBuddy2" with the following parameters
      | Type      | Name            | Value        |
      | Filter    | Medical Service | PLM2Test-TBC |
      | List Type |                 | ASSIGNMENT   |
    And I use the API to update the permissions for the patient list named "VerveDel AssignmentTab Perm Test4 AddRemove" owned by "PLV2PermTestBuddy2" with the following
      | Action | Name       | Value         |
      | Add    | Add/Remove | PLV2PermTest4 |

   #Shares a facility with PLV2PermTestBuddy
    And I use the API to create a patient list named "VerveDel AssignmentTab Perm Test4 SharedFac" owned by "PLV2PermTestBuddy" with the following parameters
      | Type      | Name            | Value        |
      | Filter    | Medical Service | PLM2Test-TBC |
      | List Type |                 | ASSIGNMENT   |
    And I use the API to update the permissions for the patient list named "VerveDel AssignmentTab Perm Test4 SharedFac" owned by "PLV2PermTestBuddy" with the following
      | Action | Name       | Value         |
      | Add    | View       | PLV2PermTest4 |
      | Add    | Manage     | PLV2PermTest4 |
      | Add    | Add/Remove | PLV2PermTest4 |
    And I click the "Refresh Patient List" button
    When I am on the "Assignment" tab
    And I click the "Refresh" button
    And I open the search screen from the assignment list dropdown
    And I enter "VerveDel AssignmentTab Perm Test4" in the "Patient List Search" field
    And I click the "Search Patient List" button
    Then the following rows should match the "Patient List Search Results" table
      | NAME                              |
      | VerveDel AssignmentTab Perm Test4           |

  Scenario: 0008 Search - No Restrictions (All), Override Yes
    Given I am logged into the portal with user "PLV2PermTest5" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    And I use the API to create a patient list named "VerveDel AssignmentTab Perm Test5" owned by "PLV2PermTest5" with the following parameters
      | Type      | Name            | Value        |
      | Filter    | Medical Service | PLM2Test-TBC |
      | List Type |                 | ASSIGNMENT   |

    And I use the API to create a patient list named "VerveDel AssignmentTab Perm Test5 View" owned by "PLV2PermTestBuddy" with the following parameters
      | Type      | Name            | Value        |
      | Filter    | Medical Service | PLM2Test-TBC |
      | List Type |                 | ASSIGNMENT   |
    And I use the API to update the permissions for the patient list named "VerveDel AssignmentTab Perm Test5 View" owned by "PLV2PermTestBuddy" with the following
      | Action | Name | Value         |
      | Add    | View | PLV2PermTest5 |

    And I use the API to create a patient list named "VerveDel AssignmentTab Perm Test5 Manage" owned by "PLV2PermTestBuddy" with the following parameters
      | Type      | Name            | Value        |
      | Filter    | Medical Service | PLM2Test-TBC |
      | List Type |                 | ASSIGNMENT   |
    And I use the API to update the permissions for the patient list named "VerveDel AssignmentTab Perm Test5 Manage" owned by "PLV2PermTestBuddy" with the following
      | Action | Name   | Value         |
      | Add    | Manage | PLV2PermTest5 |

    And I use the API to create a patient list named "VerveDel AssignmentTab Perm Test5 AddRemove" owned by "PLV2PermTestBuddy" with the following parameters
      | Type      | Name            | Value        |
      | Filter    | Medical Service | PLM2Test-TBC |
      | List Type |                 | ASSIGNMENT   |
    And I use the API to update the permissions for the patient list named "VerveDel AssignmentTab Perm Test5 AddRemove" owned by "PLV2PermTestBuddy" with the following
      | Action | Name       | Value         |
      | Add    | Add/Remove | PLV2PermTest5 |

   #List for which PLV2PermTest5 has no relation, no perms, and no shared dept/fac.  Should NOT appear in search results due to VIEW permission.
    And I use the API to create a patient list named "VerveDel AssignmentTab Perm Test5 NoPerm" owned by "PLV2PermTestBuddy2" with the following parameters
      | Type      | Name            | Value        |
      | Filter    | Medical Service | PLM2Test-TBC |
      | List Type |                 | ASSIGNMENT   |

    And I click the "Refresh Patient List" button
    When I am on the "Assignment" tab
    And I click the "Refresh" button
    And I open the search screen from the assignment list dropdown
    And I enter "VerveDel AssignmentTab Perm Test5" in the "Patient List Search" field
    And I click the "Search Patient List" button
    Then the following rows should match the "Patient List Search Results" clinical table
      | NAME                                        |
      | VerveDel AssignmentTab Perm Test5           |
      | VerveDel AssignmentTab Perm Test5 AddRemove |
      | VerveDel AssignmentTab Perm Test5 Manage    |
      | VerveDel AssignmentTab Perm Test5 View      |

  Scenario: 0009 Search - Restrict Department, Override Yes
    Given I am logged into the portal with user "PLV2PermTest6" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    And I use the API to create a patient list named "VerveDel AssignmentTab Perm Test6" owned by "PLV2PermTest6" with the following parameters
      | Type      | Name            | Value        |
      | Filter    | Medical Service | PLM2Test-TBC |
      | List Type |                 | ASSIGNMENT   |
   #Shares a department with PLV2PermTestBuddy2
    And I use the API to create a patient list named "VerveDel AssignmentTab Perm Test6 View" owned by "PLV2PermTestBuddy2" with the following parameters
      | Type      | Name            | Value        |
      | Filter    | Medical Service | PLM2Test-TBC |
      | List Type |                 | ASSIGNMENT   |
    And I use the API to update the permissions for the patient list named "VerveDel AssignmentTab Perm Test6 View" owned by "PLV2PermTestBuddy2" with the following
      | Action | Name | Value         |
      | Add    | View | PLV2PermTest6 |

    And I use the API to create a patient list named "VerveDel AssignmentTab Perm Test6 Manage" owned by "PLV2PermTestBuddy2" with the following parameters
      | Type      | Name            | Value        |
      | Filter    | Medical Service | PLM2Test-TBC |
      | List Type |                 | ASSIGNMENT   |
    And I use the API to update the permissions for the patient list named "VerveDel AssignmentTab Perm Test6 Manage" owned by "PLV2PermTestBuddy2" with the following
      | Action | Name   | Value         |
      | Add    | Manage | PLV2PermTest6 |

    And I use the API to create a patient list named "VerveDel AssignmentTab Perm Test6 AddRemove" owned by "PLV2PermTestBuddy2" with the following parameters
      | Type      | Name            | Value        |
      | Filter    | Medical Service | PLM2Test-TBC |
      | List Type |                 | ASSIGNMENT   |
    And I use the API to update the permissions for the patient list named "VerveDel AssignmentTab Perm Test6 AddRemove" owned by "PLV2PermTestBuddy2" with the following
      | Action | Name       | Value         |
      | Add    | Add/Remove | PLV2PermTest6 |
   #Shares a facility with PLV2PermTestBuddy
    And I use the API to create a patient list named "VerveDel AssignmentTab Perm Test6 SharedFac" owned by "PLV2PermTestBuddy" with the following parameters
      | Type      | Name            | Value        |
      | Filter    | Medical Service | PLM2Test-TBC |
      | List Type |                 | ASSIGNMENT   |
    And I use the API to update the permissions for the patient list named "VerveDel AssignmentTab Perm Test6 SharedFac" owned by "PLV2PermTestBuddy" with the following
      | Action | Name       | Value         |
      | Add    | View       | PLV2PermTest6 |
      | Add    | Manage     | PLV2PermTest6 |
      | Add    | Add/Remove | PLV2PermTest6 |
   #Nothing shared with PLV2PermTestBuddy3
    And I use the API to create a patient list named "VerveDel AssignmentTab Perm Test6 NoShared" owned by "PLV2PermTestBuddy3" with the following parameters
      | Type      | Name            | Value        |
      | Filter    | Medical Service | PLM2Test-TBC |
      | List Type |                 | ASSIGNMENT   |
    And I use the API to update the permissions for the patient list named "VerveDel AssignmentTab Perm Test6 NoShared" owned by "PLV2PermTestBuddy3" with the following
      | Action | Name       | Value         |
      | Add    | View       | PLV2PermTest6 |
      | Add    | Manage     | PLV2PermTest6 |
      | Add    | Add/Remove | PLV2PermTest6 |
   #Shares department with 'exclude from checks' set to 'Yes'
    And I use the API to create a patient list named "VerveDel AssignmentTab Perm Test6 DeptExclude" owned by "PLV2PermTestBuddy4" with the following parameters
      | Type      | Name            | Value        |
      | Filter    | Medical Service | PLM2Test-TBC |
      | List Type |                 | ASSIGNMENT   |
    And I use the API to update the permissions for the patient list named "VerveDel AssignmentTab Perm Test6 DeptExclude" owned by "PLV2PermTestBuddy4" with the following
      | Action | Name       | Value         |
      | Add    | View       | PLV2PermTest6 |

    And I click the "Refresh Patient List" button
    When I am on the "Assignment" tab
    And I click the "Refresh" button
    And I open the search screen from the assignment list dropdown
    And I enter "VerveDel AssignmentTab Perm Test6" in the "Patient List Search" field
    And I click the "Search Patient List" button
    Then the following rows should match the "Patient List Search Results" table
      | NAME                                        |
      | VerveDel AssignmentTab Perm Test6           |
      | VerveDel AssignmentTab Perm Test6 AddRemove |
      | VerveDel AssignmentTab Perm Test6 Manage    |
      | VerveDel AssignmentTab Perm Test6 View      |

  Scenario: 0010 Search - Restrict Facility, Override Yes
    Given I am logged into the portal with user "PLV2PermTest7" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    And I use the API to create a patient list named "VerveDel AssignmentTab Perm Test7" owned by "PLV2PermTest7" with the following parameters
      | Type      | Name            | Value        |
      | Filter    | Medical Service | PLM2Test-TBC |
      | List Type |                 | ASSIGNMENT   |
   #Shares facility with PLV2PermTestBuddy
    And I use the API to create a patient list named "VerveDel AssignmentTab Perm Test7 View" owned by "PLV2PermTestBuddy" with the following parameters
      | Type      | Name            | Value        |
      | Filter    | Medical Service | PLM2Test-TBC |
      | List Type |                 | ASSIGNMENT   |
    And I use the API to update the permissions for the patient list named "VerveDel AssignmentTab Perm Test7 View" owned by "PLV2PermTestBuddy" with the following
      | Action | Name | Value         |
      | Add    | View | PLV2PermTest7 |

    And I use the API to create a patient list named "VerveDel AssignmentTab Perm Test7 Manage" owned by "PLV2PermTestBuddy" with the following parameters
      | Type      | Name            | Value        |
      | Filter    | Medical Service | PLM2Test-TBC |
      | List Type |                 | ASSIGNMENT   |
    And I use the API to update the permissions for the patient list named "VerveDel AssignmentTab Perm Test7 Manage" owned by "PLV2PermTestBuddy" with the following
      | Action | Name   | Value         |
      | Add    | Manage | PLV2PermTest7 |

    And I use the API to create a patient list named "VerveDel AssignmentTab Perm Test7 AddRemove" owned by "PLV2PermTestBuddy" with the following parameters
      | Type      | Name            | Value        |
      | Filter    | Medical Service | PLM2Test-TBC |
      | List Type |                 | ASSIGNMENT   |
    And I use the API to update the permissions for the patient list named "VerveDel AssignmentTab Perm Test7 AddRemove" owned by "PLV2PermTestBuddy" with the following
      | Action | Name       | Value         |
      | Add    | Add/Remove | PLV2PermTest7 |
   #Shares department with PLV2PermTestBuddy2
    And I use the API to create a patient list named "VerveDel AssignmentTab Perm Test7 SharedDept" owned by "PLV2PermTestBuddy2" with the following parameters
      | Type      | Name            | Value        |
      | Filter    | Medical Service | PLM2Test-TBC |
      | List Type |                 | ASSIGNMENT   |
    And I use the API to update the permissions for the patient list named "VerveDel AssignmentTab Perm Test7 SharedDept" owned by "PLV2PermTestBuddy2" with the following
      | Action | Name       | Value         |
      | Add    | View       | PLV2PermTest7 |
      | Add    | Manage     | PLV2PermTest7 |
      | Add    | Add/Remove | PLV2PermTest7 |
   #No shared facility or departments with PLV2PermTestBuddy3
    And I use the API to create a patient list named "VerveDel AssignmentTab Perm Test7 NoShared" owned by "PLV2PermTestBuddy3" with the following parameters
      | Type      | Name            | Value        |
      | Filter    | Medical Service | PLM2Test-TBC |
      | List Type |                 | ASSIGNMENT   |
    And I use the API to update the permissions for the patient list named "VerveDel AssignmentTab Perm Test7 NoShared" owned by "PLV2PermTestBuddy3" with the following
      | Action | Name       | Value         |
      | Add    | View       | PLV2PermTest7 |
      | Add    | Manage     | PLV2PermTest7 |
      | Add    | Add/Remove | PLV2PermTest7 |
   #Shares facility with 'exclude from checks' set to 'Yes'
    And I use the API to create a patient list named "VerveDel AssignmentTab Perm Test7 FacExclude" owned by "PLV2PermTestBuddy4" with the following parameters
      | Type      | Name            | Value        |
      | Filter    | Medical Service | PLM2Test-TBC |
      | List Type |                 | ASSIGNMENT   |
    And I use the API to update the permissions for the patient list named "VerveDel AssignmentTab Perm Test7 FacExclude" owned by "PLV2PermTestBuddy4" with the following
      | Action | Name       | Value         |
      | Add    | View       | PLV2PermTest7 |

    And I click the "Refresh Patient List" button
    When I am on the "Assignment" tab
    And I click the "Refresh" button
    And I open the search screen from the assignment list dropdown
    And I enter "VerveDel AssignmentTab Perm Test7" in the "Patient List Search" field
    And I click the "Search Patient List" button
    Then the following rows should match the "Patient List Search Results" table
      | NAME                                         |
      | VerveDel AssignmentTab Perm Test7            |
      | VerveDel AssignmentTab Perm Test7 AddRemove  |
      | VerveDel AssignmentTab Perm Test7 Manage     |
      | VerveDel AssignmentTab Perm Test7 SharedDept |
      | VerveDel AssignmentTab Perm Test7 View       |


