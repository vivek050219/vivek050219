@InboxOrders
Feature: Inbox Orders

  Background: 
    Given I am logged into the portal with user "dturner" using the default password
    And I wait "25" seconds
    And I am on the "Inbox" tab
    And I wait "25" seconds
    When I select the "eSig and PK Mail" subtab
    And I wait "35" seconds

  Scenario: 1. Verify Save & Sign functionality
    And I click the "All" element
    And I wait "35" seconds
    Then the "Messages" table should load
    And I click the "Search" element
    And I wait "10" seconds
    When I enter "Order" in the "SearchBox" field
    And I wait "20" seconds
    And I click on the text "Unsigned" in the "eSig Note Content" pane
    And I wait "5" seconds
    Then the "Scanned Note Minimize" pane should load
    And The following fields should be enabled in the "Scanned Note Minimize" pane
      | Name      | Type   |
      | Skip      | button |
      | Decline   | button |
      | Sign      | button |
      | EDIT/SIGN | button |
    And I wait "3" seconds
    And I click the "EDIT/SIGN" button
    And I wait "5" seconds
    And The following fields should be enabled in the "Scanned Note Minimize" pane
      | Name      | Type   |
      | Save      | button |
      | Save&Sign | button |
      | Cancel    | button |
    And I click the "Save&Sign" button
    And I wait "5" seconds
    Then the "Scanned Note Minimize" pane should load
    And I wait "5" seconds
    When I verify the count of the "Messages" table and click the "Sign" button
    And I wait "5" seconds
    Then the "Messages" table should load

  Scenario: 2. Verify Close button feature when viewing Orders from Orders screen and expand its view in full view
    And I click the "All" element
    And I wait "35" seconds
    Then the "Messages" table should load
    And I wait "15" seconds
    When I enter "Order" in the "SearchBox" field
    And I wait "5" seconds
    And I click on the text "Unsigned" in the "eSig Note Content" pane
    And I wait "5" seconds
    Then the "Scanned Note Minimize" pane should load
    And The following fields should be enabled in the "Scanned Note Minimize" pane
      | Name      | Type   |
      | Skip      | button |
      | Decline   | button |
      | Sign      | button |
      | EDIT/SIGN | button |
    And I click the "Minimize" button
    Then the "Order Note Content" pane should load
    And I click the "Minimize" button
    And I wait "5" seconds
    And I click the "Close" element
    And I wait "5" seconds
    Then the "Messages" table should load

  Scenario: 3. Verify Description column sorting by descending and perform search for some existing data
    And I click the "All" element
    And I wait "35" seconds
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Description" column in "Descending" order
    And I wait "30" seconds
    Then the following rows should appear in the "Messages" table
      | Description |
      | Order       |
    And I click the "Search" element
    And I wait "10" seconds
    When I enter "Order" in the "SearchBox" field
    And I wait "5" seconds
    Then the following rows should appear in the "Messages" table
      | Description |
      | Order       |
    And I click the "Search" element
    And I wait "15" seconds
    When I enter "History and Physical" in the "SearchBox" field
    And I wait "25" seconds
    And I sort the "Messages" table chronologically by the "Description" column in "Ascending" order
    And I wait "30" seconds
    When I enter "Farrebee, Claudia" in the "SearchBox" field
    And I wait "10" seconds
    Then the following rows should appear in the "Messages" table
      | Patient           |
      | Farrebee, Claudia |

  Scenario: 4. Verify Skip functionality when two orders checkbox are checked
    And I click the "Orders" element
    And I wait "35" seconds
    Then the "Messages" table should load
    And I click on the element "First Note Checkbox" in the "eSig Note Content" pane
    And I click on the element "Second Note Checkbox" in the "eSig Note Content" pane
    And I wait "4" seconds
    And the following field should display in the "eSig Note Content" pane
      | Name      | Type   |
      | EDIT/SIGN | button |
    And I click the "EDIT/SIGN" button
    And I wait "5" seconds
    And I click the "Skip" button
    And I wait "5" seconds
    And I click the "Skip" button
    And I wait "10" seconds
    Then the following elements should be checked in the "eSig Note Content" pane
      | FirstNoteCheckbox  |
      | SecondNoteCheckbox |

  Scenario: 5. Verify Close button feature when viewing Orders from Orders screen
    And I click the "Orders" element
    And I wait "35" seconds
    Then the "Messages" table should load
    And I click on the text "Unsigned" in the "eSig Note Content" pane
    And I wait "5" seconds
    Then the "Scanned Note Minimize" pane should load
    And The following fields should be enabled in the "Scanned Note Minimize" pane
      | Name      | Type   |
      | Skip      | button |
      | Decline   | button |
      | Sign      | button |
      | EDIT/SIGN | button |
    And I click the "Minimize" button
    Then the "Order Note Content" pane should load
    And I click the "Minimize" button
    And I wait "5" seconds
    And I click the "Close" element
    And I wait "5" seconds
    Then the "Messages" table should load

  Scenario: 6. Verify Decline functionality
    And I click the "Orders" element
    And I wait "35" seconds
    Then the "Messages" table should load
    And I click on the text "Unsigned" in the "eSig Note Content" pane
    And The following fields should be enabled in the "eSig Note Content" pane
      | Name      | Type   |
      | Decline   | button |
      | EDIT/SIGN | button |
      | Skip      | button |
      | Sign      | button |
    And I click the "Decline" button
    And I wait "4" seconds
    And I click the "CancelAtDecline" button
    And The following fields should be enabled in the "eSig Note Content" pane
      | Name      | Type   |
      | Decline   | button |
      | EDIT/SIGN | button |
      | Skip      | button |
      | Sign      | button |
    And I click the "Decline" button
    And I wait "4" seconds
    And I select "Reasons" from the "Reason" dropdown
    And I enter "declining order" in the "Additional Comments" field
    And I click the "ConfirmOK" button
    And I click the "Close" icon
    And I click the "Orders" element
    And I wait "25" seconds
    Then the "Messages" table should load
    And I click on the element "FirstNote Checkbox" in the "eSig Note Content" pane
    And I click on the element "SecondNote Checkbox" in the "eSig Note Content" pane
    And The following fields should be enabled in the "eSig Note Content" pane
      | Name      | Type   |
      | Refresh   | button |
      | Decline   | button |
      | EDIT/SIGN | button |
      | Sign      | button |
    And I click the "Decline" button
    And I wait "4" seconds
    And I click the "CancelAtDecline" button
    And The following fields should be enabled in the "eSig Note Content" pane
      | Name      | Type   |
      | Refresh   | button |
      | Decline   | button |
      | EDIT/SIGN | button |
      | Sign      | button |
    And I click the "Decline" button
    And I select "Tester1" from the "Reason" dropdown
    And I enter "declining order" in the "Additional Comments" field
    And I click the "ConfirmOK" button
    And The following fields should be not display in the "eSig Note Content" pane
      | Name      | Type   |
      | Decline   | button |
      | EDIT/SIGN | button |
      | Sign      | button |
    Then the following elements should be unchecked in the "eSig Note Content" pane
      | FirstNote Checkbox  |
      | SecondNote Checkbox |

  Scenario: 7. Verify Close button functionality
    And I click the "Orders" element
    And I wait "35" seconds
    Then the "Messages" table should load
    And I click on the text "Unsigned" in the "eSig Note Content" pane
    And I wait "10" seconds
    Then the "Scanned Note Minimize" pane should load
    And the following fields should display in the "Scanned Note Minimize" pane
      | Name      | Type   |
      | EDIT/SIGN | button |
      | Decline   | button |
      | Sign      | button |
      | Skip      | button |
    And I click the "Close" element
    And I wait "5" seconds
    Then the "Scanned Note Minimize" pane should close

  Scenario: 8. Verify Save & Sign functionality for one order
    And I click the "Orders" element
    And I wait "35" seconds
    Then the "Messages" table should load
    And I click on the text "Unsigned" in the "eSig Note Content" pane
    And I wait "5" seconds
    Then the "Scanned Note Minimize" pane should load
    And The following fields should be enabled in the "Scanned Note Minimize" pane
      | Name      | Type   |
      | Skip      | button |
      | Decline   | button |
      | Sign      | button |
      | EDIT/SIGN | button |
    And I click the "EDIT/SIGN" button
    And I wait "5" seconds
    And The following fields should be enabled in the "Scanned Note Minimize" pane
      | Name      | Type   |
      | Save      | button |
      | Save&Sign | button |
      | Cancel    | button |
    And I click the "Save&Sign" button
    And I wait "5" seconds
    Then the "Scanned Note Minimize" pane should load
    And I click the "Close" element
    And I wait "5" seconds
    Then the "Scanned Note Minimize" pane should not load

  Scenario: 9. Verify save functionality
    And I click the "Orders" element
    And I wait "35" seconds
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    And I wait "15" seconds
    And I click on the text "Unsigned" in the "eSig Note Content" pane
    And I wait "5" seconds
    And The following fields should be enabled in the "eSig Note Content" pane
      | Name      | Type   |
      | Decline   | button |
      | EDIT/SIGN | button |
      | Sign      | button |
      | Skip      | button |
    And I click the "EDIT/SIGN" button
    And The following fields should be display in the "OrderNoteContent" pane
      | Name      | Type   |
      | Cancel    | button |
      | Save&Sign | button |
      | Save      | button |
    And the following text should appear in the "OrderNoteContent" pane
      | Patient: |
      | MRN:     |
    And I click the "Save" button
    And I wait "10" seconds
    And I click the "Close" icon
    And I wait "5" seconds
    Then the "Messages" table should load

  Scenario: 10. Verify Skip functionality when one order is open
    And I click the "Orders" element
    And I wait "35" seconds
    Then the "Messages" table should load
    And I click on the text "Unsigned" in the "eSig Note Content" pane
    And I wait "5" seconds
    Then the "Scanned Note Minimize" pane should load
    And I wait "5" seconds
    And the following fields should display in the "Scanned Note Minimize" pane
      | Name      | Type   |
      | EDIT/SIGN | button |
      | Decline   | button |
      | Sign      | button |
      | Skip      | button |
    And I wait "10" seconds
    And I click the "Skip" button
    And I wait "10" seconds
    And I click the "Close" element
    Then the "Scanned Note Minimize" pane should close

  Scenario: 11. Verify Refresh functionality
    And I click the "Orders" element
    And I wait "25" seconds
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    And I click on the element "FirstNote Checkbox" in the "eSig Note Content" pane
    And I click on the element "SecondNote Checkbox" in the "eSig Note Content" pane
    And I wait "4" seconds
    And The following fields should be enabled in the "eSig Note Content" pane
      | Name      | Type   |
      | Refresh   | button |
      | Decline   | button |
      | EDIT/SIGN | button |
      | Sign      | button |
    And I click the "Refresh" button
    And The following fields should be not display in the "eSig Note Content" pane
      | Name      | Type   |
      | Refresh   | button |
      | Decline   | button |
      | EDIT/SIGN | button |
      | Sign      | button |
    Then the following elements should be unchecked in the "eSig Note Content" pane
      | FirstNote Checkbox  |
      | SecondNote Checkbox |

  Scenario: 12. Verify only top buttons available for further action when checkboxes selected
    And I click the "Orders" element
    And I wait "50" seconds
    Then the "Messages" table should load
    And I click on the element "FirstNote Checkbox" in the "eSig Note Content" pane
    And I click on the element "SecondNote Checkbox" in the "eSig Note Content" pane
    And I wait "4" seconds
    And the following fields should be enabled in the "eSig Note Content" pane
      | Name      | Type   |
      | EDIT/SIGN | button |
      | Decline   | button |
      | Sign      | button |
    And I click on the text "Unsigned" in the "eSig Note Content" pane
    And I wait "5" seconds
    Then the "Scanned Note Minimize" pane should not load

  Scenario: 13. Verify Save & Sign functionality when one orders selected for Edit
    And I click the "Orders" element
    And I wait "25" seconds
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    And I click on the element "FirstNote Checkbox" in the "eSig Note Content" pane
    And I wait "4" seconds
    And The following fields should be enabled in the "eSig Note Content" pane
      | Name      | Type   |
      | Refresh   | button |
      | Decline   | button |
      | EDIT/SIGN | button |
      | Sign      | button |
    And I click the "EDIT/SIGN" button
    And The following fields should be enabled in the "eSig Note Content" pane
      | Name      | Type   |
      | Refresh   | button |
      | Decline   | button |
      | EDIT/SIGN | button |
      | Sign      | button |
    And I verify the count of the "Messages" table and click the "Save&Sign" button
    And The following fields should be not display in the "eSig Note Content" pane
      | Name      | Type   |
      | Refresh   | button |
      | Decline   | button |
      | EDIT/SIGN | button |
      | Sign      | button |

  Scenario: 14. Verify Back to Inbox functionality when user selects one order checkbox
    And I click the "Orders" element
    And I wait "35" seconds
    Then the "Messages" table should load
    And I click on the element "First Note Checkbox" in the "eSig Note Content" pane
    And I wait "4" seconds
    And the following field should display in the "eSig Note Content" pane
      | Name      | Type   |
      | EDIT/SIGN | button |
      | Decline   | button |
    And I click the "EDIT/SIGN" button
    And I wait "5" seconds
    And I click the "BackToInbox" button
    And I wait "3" seconds
    And I click the "ConfirmOK" button
    And the following field should not display in the "eSig Note Content" pane
      | Name      | Type   |
      | EDIT/SIGN | button |
      | Decline   | button |

  Scenario: 15. Verify Save & Sign functionality when two orders selected for Edit
    And I click the "Orders" element
    And I wait "35" seconds
    Then the "Messages" table should load
    And I click on the element "FirstNote Checkbox" in the "eSig Note Content" pane
    And I click on the element "SecondNote Checkbox" in the "eSig Note Content" pane
    And I click the "EDIT/SIGN" button
    And I wait "5" seconds
    Then the "Scanned Note Minimize" pane should load
    And The following fields should be enabled in the "Scanned Note Minimize" pane
      | Name        | Type   |
      | BackToInbox | button |
      | Skip        | button |
      | Save        | button |
      | Save&Sign   | button |
    And I click the "Save&Sign" button
    And I wait "5" seconds
    Then the "Scanned Note Minimize" pane should load
    And I click the "Save&Sign" button
    And I wait "5" seconds
    Then the "Messages" table should load
    And I wait "5" seconds
    And I click the logout button