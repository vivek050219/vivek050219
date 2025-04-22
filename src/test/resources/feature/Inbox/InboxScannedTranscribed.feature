@InboxScannedTranscribed
Feature: Inbox ScannedTranscribed

  Background: 
#  Scenario: Setup
    Given I am logged into the portal with user "dturner" using the default password
    And I wait "25" seconds
    And I am on the "Inbox" tab
    And I wait "25" seconds
    When I select the "eSig and PK Mail" subtab
    And I wait "25" seconds

  Scenario: 1. Verify expand/collapse icon functionality when viewing Scanned/Transcribed from Scanned/Transcribed tab
    And I click the "Scanned" element
    And I wait "25" seconds
    Then the "Messages" table should load
    And the following field should display in the "CollapsedScannedDialog" pane
      | Name    | Type    |
      | Refresh | button  |
      | Search  | element |
    And the following field should not display in the "CollapsedScannedDialog" pane
      | Name      | Type   |
      | Decline   | button |
      | EDIT/SIGN | button |
    When I select "the first item" in the "Messages" table
    And I wait "4" seconds
    And I click the "Collapse" icon if it exists
    Then the "CollapsedScannedDialog" pane should load
    And I wait "4" seconds
    And The following fields should be enabled in the "CollapsedScannedDialog" pane
      | Name      | Type   |
      | Decline   | button |
      | Skip      | button |
      | EDIT/SIGN | button |
      | Sign      | button |
      | Expand    | icon   |
      | Close     | icon   |
    And I click the "Expand" icon
    Then the "ExpandedScannedDialog" pane should load
    And The following fields should be enabled in the "ExpandedScannedDialog" pane
      | Name      | Type   |
      | Decline   | button |
      | Skip      | button |
      | EDIT/SIGN | button |
      | Sign      | button |
      | Collapse  | icon   |
      | Close     | icon   |
    And I wait "4" seconds
    And I click the "Collapse" icon
    And I wait "2" seconds
    Then the "CollapsedScannedDialog" pane should load
    And I click the "Close" icon
    And I wait "2" seconds
    Then the "Messages" table should load

  Scenario: 2. Verify Skip functionality when one Scanned/Transcribed is open
    And I click the "Scanned" element
    And I wait "25" seconds
    Then the "Messages" table should load
    When I select "the first item" in the "Messages" table
    And I wait "5" seconds
    And I click the "Collapse" icon if it exists
    Then the "CollapsedScannedDialog" pane should load
    And I wait "4" seconds
    And The following fields should be enabled in the "CollapsedScannedDialog" pane
      | Name      | Type   |
      | Decline   | button |
      | Skip      | button |
      | EDIT/SIGN | button |
      | Sign      | button |
      | Expand    | icon   |
      | Close     | icon   |
    And I verify the note count appear with the "Scanned" link and click the "Skip" button
    And I wait "5" seconds
    And The following fields should be enabled in the "CollapsedScannedDialog" pane
      | Name      | Type   |
      | Decline   | button |
      | Skip      | button |
      | EDIT/SIGN | button |
      | Sign      | button |
      | Expand    | icon   |
      | Close     | icon   |
    And I click the "Close" icon
    And I wait "2" seconds
    Then the "Messages" table should load
    And the following field should not display in the "CollapsedScannedDialog" pane
      | Name | Type   |
      | Skip | button |

  Scenario: 3. Verify Save&Sign functionality for one Scanned/Transcribed
    And I click the "Scanned" element
    And I wait "25" seconds
    Then the "Messages" table should load
    When I select "the first item" in the "Messages" table
    And I wait "5" seconds
    And The following fields should be enabled in the "CollapsedScannedDialog" pane
      | Name      | Type   |
      | Decline   | button |
      | Skip      | button |
      | EDIT/SIGN | button |
      | Sign      | button |
      | Expand    | icon   |
      | Close     | icon   |
    And I click the "EDIT/SIGN" button
    And The following fields should be enabled in the "CollapsedScannedDialog" pane
      | Name      | Type   |
      | Cancel    | button |
      | Save&Sign | button |
      | Save      | button |
      | Collapse  | icon   |
    And the following field should not display in the "CollapsedScannedDialog" pane
      | Name  | Type |
      | Close | icon |
    And I wait "5" seconds
    And I verify the note count appear with the "Scanned" link and click the "Save&Sign" button
    And I wait "5" seconds
    And I click the "Close" icon
    And I wait "5" seconds
    Then the "Messages" table should load
    And the following field should display in the "CollapsedScannedDialog" pane
      | Name    | Type   |
      | Refresh | button |

  Scenario: 4. Verify Close icon functionality when expanding and collapsing Scanned/Transcribed
    And I click the "Scanned" element
    And I wait "25" seconds
    Then the "Messages" table should load
    When I select "the first item" in the "Messages" table
    And I wait "5" seconds
    And The following fields should be enabled in the "CollapsedScannedDialog" pane
      | Name      | Type   |
      | Decline   | button |
      | Skip      | button |
      | EDIT/SIGN | button |
      | Sign      | button |
      | Expand    | icon   |
      | Close     | icon   |
    And I click the "Expand" icon
    Then the "ExpandedScannedDialog" pane should load
    And The following fields should be enabled in the "ExpandedScannedDialog" pane
      | Name      | Type   |
      | Decline   | button |
      | Skip      | button |
      | EDIT/SIGN | button |
      | Sign      | button |
      | Collapse  | icon   |
      | Close     | icon   |
    Then the "ExpandedScannedDialog" pane should load
    And I click the "Close" icon
    And I wait "5" seconds
    Then the "Messages" table should load
    And the following field should not display in the "CollapsedScannedDialog" pane
      | Name  | Type |
      | Close | icon |
    When I select "the first item" in the "Messages" table
    And I wait "5" seconds
    Then the "ExpandedScannedDialog" pane should load
    And The following fields should be enabled in the "CollapsedScannedDialog" pane
      | Name      | Type   |
      | Decline   | button |
      | Skip      | button |
      | EDIT/SIGN | button |
      | Sign      | button |
      | Expand    | icon   |
      | Close     | icon   |
    And I click the "Collapse" icon
    And I wait "2" seconds
    Then the "CollapsedScannedDialog" pane should load
    And I click the "Close" icon
    And I wait "2" seconds
    Then the "Messages" table should load
    And the following field should not display in the "CollapsedScannedDialog" pane
      | Name  | Type |
      | Close | icon |

  Scenario: 5. Verify Save functionality when one Scanned/Transcribed is open
    And I click the "Scanned" element
    And I wait "25" seconds
    Then the "Messages" table should load
    When I select "the first item" in the "Messages" table
    And I wait "5" seconds
    And The following fields should be enabled in the "CollapsedScannedDialog" pane
      | Name      | Type   |
      | Decline   | button |
      | Skip      | button |
      | EDIT/SIGN | button |
      | Sign      | button |
      | Expand    | icon   |
      | Close     | icon   |
    And I click the "EDIT/SIGN" button
    And The following fields should be enabled in the "CollapsedScannedDialog" pane
      | Name      | Type   |
      | Cancel    | button |
      | Save&Sign | button |
      | Save      | button |
      | Collapse  | icon   |
    And the following field should not display in the "CollapsedScannedDialog" pane
      | Name  | Type |
      | Close | icon |
    And I wait "5" seconds
    And I verify the note count appear with the "Scanned" link and click the "Save" button
    And I wait "5" seconds
    And I click the "Close" icon
    And I wait "5" seconds
    Then the "Messages" table should load
    And the following field should display in the "CollapsedScannedDialog" pane
      | Name    | Type   |
      | Refresh | button |

  Scenario: 6. Verify search functionality
    And I click the "Scanned" element
    And I wait "25" seconds
    Then the "Messages" table should load
    And I click the "Search" element
    And I wait "5" seconds
    When I enter "History and Physical" in the "SearchBox" field
    And I wait "10" seconds
    Then the following rows should appear in the "Messages" table
      | Description          |
      | History and Physical |
      | History and Physical |
    And I click the "Search" element
    When I enter "" in the "SearchBox" field
    Then the following rows should not appear in the "Messages" table
      | Description |
    And I click the "Search" element
    And I wait "1" seconds
    When I enter "History and Physical" in the "SearchBox" field
    And I wait "10" seconds
    Then the following rows should appear in the "Messages" table
      | Description          |
      | History and Physical |
      | History and Physical |
    And I click the "Search" element
    And I wait "2" seconds
    When I enter "Junk char no found" in the "SearchBox" field
    Then the following rows should not appear in the "Messages" table
      | Description |

  Scenario: 7. Decline functionality 1 - Click on one Scanned/Transcribed row and perform Decline
    And I click the "Scanned" element
    And I wait "25" seconds
    Then the "Messages" table should load
    And the following field should not display in the "CollapsedScannedDialog" pane
      | Name    | Type   |
      | Decline | button |
    When I select "the first item" in the "Messages" table
    And I wait "5" seconds
    And The following fields should be enabled in the "CollapsedScannedDialog" pane
      | Name      | Type   |
      | Decline   | button |
      | Skip      | button |
      | EDIT/SIGN | button |
      | Sign      | button |
      | Expand    | icon   |
      | Close     | icon   |
    And I click the "Decline" button
    And I wait "10" seconds
    And I select "Reasons" from the "Reason" dropdown
    And I wait "5" seconds
    And I enter "Decline Reason for Testing" in the "AdditionalComments" field
    And I wait "5" seconds
    And I verify the note count appear with the "Scanned" link and click the "ConfirmOK" button
    And I wait "5" seconds
    And I click the "Close" icon
    And I wait "2" seconds
    Then the "Messages" table should load
    And the following field should not display in the "CollapsedScannedDialog" pane
      | Name    | Type   |
      | Decline | button |

  Scenario: 8. Decline functionality 2 - Select one checkbox on Scanned/Transcribed screen and perform Decline
    And I click the "Scanned" element
    And I wait "25" seconds
    Then the "Messages" table should load
    And the following field should not display in the "CollapsedScannedDialog" pane
      | Name    | Type   |
      | Decline | button |
    And I click on the element "FirstNote Checkbox" in the "eSig Note Content" pane
    And I wait "4" seconds
    And The following fields should be enabled in the "eSig Note Content" pane
      | Name      | Type   |
      | Decline   | button |
      | EDIT/SIGN | button |
    And I click the "Decline" button
    And I select "Reasons" from the "Reason" dropdown
    And I wait "5" seconds
    And I enter "Decline Reason for Testing" in the "AdditionalComments" field
    And I wait "5" seconds
    And I verify the note count appear with the "Scanned" link and click the "ConfirmOK" button
    And I wait "5" seconds
    And the following field should not display in the "CollapsedScannedDialog" pane
      | Name      | Type   |
      | Decline   | button |
      | EDIT/SIGN | button |

  Scenario: 9. Verify Refresh button functionality when select two checkboxes and click Refresh
    And I click the "Scanned" element
    And I wait "25" seconds
    Then the "Messages" table should load
    And The following fields should be enabled in the "eSig Note Content" pane
      | Name    | Type   |
      | Refresh | button |
    And the following field should not display in the "CollapsedScannedDialog" pane
      | Name      | Type   |
      | Decline   | button |
      | EDIT/SIGN | button |
    And I click on the element "FirstNote Checkbox" in the "eSig Note Content" pane
    And the following text should appear in the "CollapsedScannedDialog" pane
      | Signing 1 Items |
    And I click on the element "SecondNote Checkbox" in the "eSig Note Content" pane
    And the following text should appear in the "CollapsedScannedDialog" pane
      | Signing 2 Items |
    And I wait "4" seconds
    And The following fields should be enabled in the "eSig Note Content" pane
      | Name      | Type   |
      | Decline   | button |
      | EDIT/SIGN | button |
    And I click the "Refresh" button
    And I wait "25" seconds
    Then the "Messages" table should load
    Then the following elements should be unchecked in the "eSig Note Content" pane
      | FirstNote Checkbox  |
      | SecondNote Checkbox |

  Scenario: 10. Verify Back to Inbox functionality when user selects one Scanned/Transcribed checkbox
    And I click the "Scanned" element
    And I wait "25" seconds
    Then the "Messages" table should load
    And The following fields should be enabled in the "eSig Note Content" pane
      | Name    | Type   |
      | Refresh | button |
    And the following field should not display in the "CollapsedScannedDialog" pane
      | Name      | Type   |
      | Decline   | button |
      | EDIT/SIGN | button |
    And I click on the element "FirstNote Checkbox" in the "eSig Note Content" pane
    And the following text should appear in the "CollapsedScannedDialog" pane
      | Signing 1 Items |
    And I wait "4" seconds
    And The following fields should be enabled in the "eSig Note Content" pane
      | Name      | Type   |
      | Decline   | button |
      | EDIT/SIGN | button |
    And I click the "EDIT/SIGN" button
    And The following fields should be enabled in the "CollapsedScannedDialog" pane
      | Name        | Type   |
      | BackToInbox | button |
      | Skip        | button |
      | Save&Sign   | button |
      | Save        | button |
      | Collapse    | icon   |
    And the following field should not display in the "CollapsedScannedDialog" pane
      | Name  | Type |
      | Close | icon |
    And I wait "5" seconds
    And the following text should appear in the "CollapsedScannedDialog" pane
      | ITEMS: 1 of 1 |
    And I click the "BackToInbox" button
    And I wait "3" seconds
    And I click the "ConfirmOK" button
    And I wait "5" seconds
    Then the "Messages" table should load
    And the following field should display in the "CollapsedScannedDialog" pane
      | Name    | Type   |
      | Refresh | button |

  Scenario: 11. Verify Skip functionality when Scanned/Transcribed two checkboxes are selected
    And I click the "Scanned" element
    And I wait "25" seconds
    Then the "Messages" table should load
    And The following fields should be enabled in the "eSig Note Content" pane
      | Name    | Type   |
      | Refresh | button |
    And the following field should not display in the "CollapsedScannedDialog" pane
      | Name      | Type   |
      | Decline   | button |
      | EDIT/SIGN | button |
    And I click on the element "FirstNote Checkbox" in the "eSig Note Content" pane
    And the following text should appear in the "CollapsedScannedDialog" pane
      | Signing 1 Items |
    And I click on the element "SecondNote Checkbox" in the "eSig Note Content" pane
    And the following text should appear in the "CollapsedScannedDialog" pane
      | Signing 2 Items |
    And I wait "4" seconds
    And The following fields should be enabled in the "eSig Note Content" pane
      | Name      | Type   |
      | Decline   | button |
      | EDIT/SIGN | button |
    And I click the "EDIT/SIGN" button
    And I wait "5" seconds
    And the following text should appear in the "CollapsedScannedDialog" pane
      | ITEMS: 1 of 2 |
    And I verify the note count appear with the "Scanned" link and click the "Skip" button
    And I wait "5" seconds
    And the following text should appear in the "CollapsedScannedDialog" pane
      | ITEMS: 2 of 2 |
    And I verify the note count appear with the "Scanned" link and click the "Skip" button
    And I wait "5" seconds
    Then the following elements should be unchecked in the "eSig Note Content" pane
      | FirstNoteCheckbox  |
      | SecondNoteCheckbox |

  Scenario: 12. Verify Save&Sign functionality after Skip one Scanned/Transcribed
    And I click the "Scanned" element
    And I wait "25" seconds
    Then the "Messages" table should load
    And The following fields should be enabled in the "eSig Note Content" pane
      | Name    | Type   |
      | Refresh | button |
    And the following field should not display in the "CollapsedScannedDialog" pane
      | Name      | Type   |
      | Decline   | button |
      | EDIT/SIGN | button |
    And I click on the element "FirstNote Checkbox" in the "eSig Note Content" pane
    And the following text should appear in the "CollapsedScannedDialog" pane
      | Signing 1 Items |
    And I click on the element "SecondNote Checkbox" in the "eSig Note Content" pane
    And the following text should appear in the "CollapsedScannedDialog" pane
      | Signing 2 Items |
    And I wait "4" seconds
    And The following fields should be enabled in the "eSig Note Content" pane
      | Name      | Type   |
      | Decline   | button |
      | EDIT/SIGN | button |
    And I click the "EDIT/SIGN" button
    And I wait "5" seconds
    And the following text should appear in the "CollapsedScannedDialog" pane
      | ITEMS: 1 of 2 |
    And I verify the note count appear with the "Scanned" link and click the "Skip" button
    And I wait "5" seconds
    And the following text should appear in the "CollapsedScannedDialog" pane
      | ITEMS: 2 of 2 |
    And I verify the note count appear with the "Scanned" link and click the "Save&Sign" button
    And I wait "5" seconds
    Then the following elements should be unchecked in the "eSig Note Content" pane
      | FirstNoteCheckbox |

  Scenario: 13. Verify when checkbox of Scanned/Transcribed is selected then only top buttons available for further action
    And I click the "Scanned" element
    And I wait "25" seconds
    Then the "Messages" table should load
    And I click on the element "First Note Checkbox" in the "eSig Note Content" pane
    And I wait "4" seconds
    And the following text should appear in the "CollapsedScannedDialog" pane
      | Signing 1 Items |
    And The following fields should be enabled in the "eSig Note Content" pane
      | Name      | Type   |
      | Decline   | button |
      | EDIT/SIGN | button |
    When I select "the first item" in the "Messages" table
    And I wait "5" seconds
    Then the "CollapsedScannedDialog" pane should not load

  Scenario: 14. Verify Auto scroll functionality when one Scanned/Transcribed open
    And I click the "Scanned" element
    And I wait "25" seconds
    Then the "Messages" table should load
    And I click the "Search" element
    And I wait "5" seconds
    When I enter "History and Physical" in the "SearchBox" field
    And I wait "20" seconds
    When I select "the first item" in the "Messages" table
    And I wait "4" seconds
    Then the "CollapsedScannedDialog" pane should load
    And I wait "4" seconds
    And The following fields should be enabled in the "CollapsedScannedDialog" pane
      | Name      | Type   |
      | Decline   | button |
      | Skip      | button |
      | EDIT/SIGN | button |
      | Sign      | button |
      | Expand    | icon   |
      | Close     | icon   |
    And I click the "AutoPlay" image in the "eSigAndPKMailContent" pane
    And I wait "10" seconds
    And I click the "Close" icon
    And I wait "2" seconds
    Then the "Messages" table should load

  Scenario: 15. Verify patient column sorting
    And I click the "Scanned" element
    And I wait "25" seconds
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Patient" column in "Descending" order
    And I wait "10" seconds
    Then the following rows should appear in the "Messages" table
      | Patient |
      | Z       |
    And I sort the "Messages" table chronologically by the "Patient" column in "Ascending" order
    And I wait "10" seconds
    Then the following rows should appear in the "Messages" table
      | Patient |
      | A       |
  