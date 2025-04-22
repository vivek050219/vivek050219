@PortalSmoke @Inbox
Feature: Inbox

  @BuildVerificationTest
  Scenario: 1. Prereq - Loading of the Inbox tab with the Messages subtab
    Given I am logged into the portal with user "addchargeuser3" using the default password
    And I am on the "Inbox" tab
    Then the following subtabs should load
      | eSig and PK Mail |
      | Outbox           |
      | Send PK Mail     |

#  DEV-86276 -- Send Mail button on Inbox tab > Send PK Mail subtab is off-screen and can't be clicked at resolution 1366x768 in IE
  @Demo
  Scenario: 2. Prereq - Send mail to yourself[DEV-86276]
    Given I am logged into the portal with user "addchargeuser3" using the default password
    Then I am on the "Inbox" tab
    And I select the "Send PK Mail" subtab
    And I wait for the "UserName" field of type "TEXT_FIELD" in the "User Search Criteria" pane to be visible
    When I enter "addchargeuser3" in the "UserName" field
    And I click the "Search" button
    Then the "User Search Results" table should load
    And rows containing the following should appear in the "User Search Results" table
      | Username       |
      | addchargeuser3 |
    When I select "addchargeuser3" from the "Username" column in the "User Search Results" table
    And I click the "Add Selected Users" button
    Then the "Recipients" table should load
    And rows containing the following should appear in the "Recipients" table
      | Username       |
      | addchargeuser3 |
    And I enter "test message 1" in the "Subject" field
    And I enter "test message 1" in the "Body" field
    And I click the "Send" button
    Then the "Information" pane should load
    And I click the "OK" button in the "Information" pane

#  DEV-86276 -- Send Mail button on Inbox tab > Send PK Mail subtab is off-screen and can't be clicked at resolution 1366x768 in IE
 
  Scenario: 3. Prereq - Send mail to self and other recipient[DEV-86276]
    Given I am logged into the portal with user "addchargeuser3" using the default password
    And I am on the "Inbox" tab
    And I select the "Send PK Mail" subtab
    And I wait for the "UserName" field of type "TEXT_FIELD" in the "User Search Criteria" pane to be visible
      When I enter "autoinbox1" in the "UserName" field
    And I click the "Search" button 
    When I select "autoinbox1" from the "Username" column in the "User Search Results" table
    And I click the "Add Selected Users" button  
    When I enter "addchargeuser" in the "UserName" field
    And I click the "Search" button
    When I select "addchargeuser3" from the "Username" column in the "User Search Results" table
    And I click the "Add Selected Users" button  
    Then the "Recipients" table should load
    And rows containing the following should appear in the "Recipients" table
      | Username       |
      | addchargeuser3 |
      | autoinbox1     |
    And I enter "test message for self and other" in the "Subject" field
    And I enter "test message for self and other" in the "Body" field
    And I click the "Send" button
    Then the "Information" pane should load
    And I click the "OK" button in the "Information" pane

  @Demo
  Scenario: 4. Validate you see the message sent to yourself
    Given I am logged into the portal with user "addchargeuser3" using the default password
    Then I am on the "Inbox" tab
    And I select the "eSig and PK Mail" subtab
    When I click the "Mail" element
    Then the "Mail Content" pane should load
    And I click the "Refresh" button
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    Then rows containing the following should appear in the "Messages" table
      | Date                  | Description            | Subject        |
      | %Current Date MMDDYY% | From: USER3, ADDCHARGE | test message 1  |
    And I click on the text "USER3, ADDCHARGE" in the "eSig Note Content" pane
    Then the "eSig And PK Mail Content" pane should load
    And the following text should appear in the "eSig And PK Mail Content" pane
      | To:                   |
      | USER3, ADDCHARGE      |
      | From:                 |
      | %Current Date MMDDYY% |
      | Subject:              |
      | test message 1        |

  Scenario: 5. Verify mail received from other recipient
    Given I am logged into the portal with user "autoinbox1" using the default password
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Mail" element
    And the "Mail Content" pane should load
    And I click the "Refresh" button
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    Then rows containing the following should appear in the "Messages" table
      | Date                  | Description            | Subject                         |
      | %Current Date MMDDYY% | From: USER3, ADDCHARGE | test message for self and other |

  Scenario: 6. Verify buttons available on dialog box when click on any mail
    Given I am logged into the portal with user "addchargeuser3" using the default password
    Then I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Mail" element
    And the "Mail Content" pane should load
    And I click the "Refresh" button
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    When I select "the first item" in the "Messages" table
    Then the "eSig And PK Mail Content" pane should load
    And The following fields should be enabled in the "eSig And PK Mail Content" pane
      | Name       | Type   |
      | Print      | button |
      | Reply      | button |
      | Skip       | button |
      | ReplyToAll | button |
      | Forward    | button |
      | Delete     | button |
      
      
      
      Scenario: 7. Verify Skip functionality when reached last record
    Given I am logged into the portal with user "addchargeuser3" using the default password
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Mail" element
    And the "Mail Content" pane should load
    Then the "Messages" table should load
    And The following fields should be enabled in the "eSig And PK Mail Content" pane
      | Name       | Type   |
      | Print      | button |
      | Reply      | button |
      | Skip       | button |
      | ReplyToAll | button |
      | Forward    | button |
      | Delete     | button |
    And I click the "Skip" button in the "eSig And PK Mail Content" pane
    And The following fields should be enabled in the "eSig And PK Mail Content" pane
      | Name       | Type   |
      | Print      | button |
      | Reply      | button |
      | Skip       | button |
      | ReplyToAll | button |
      | Forward    | button |
      | Delete     | button |
    And I click the "Skip" button in the "eSig And PK Mail Content" pane
    And the following text should appear in the "eSig And PK Mail Content" pane
      | You have reached the end of your inbox. |
    And I click the "ConfirmOK" button
    Then the "Messages" table should load
      

  Scenario: 8. Verify OK button appears when message sent successfully
    Given I am logged into the portal with user "addchargeuser3" using the default password
    Then I am on the "Inbox" tab
    And I select the "Send PK Mail" subtab
    And I wait for the "UserName" field of type "TEXT_FIELD" in the "User Search Criteria" pane to be visible
    When I enter "addchargeuser3" in the "UserName" field
    And I click the "Search" button
    Then the "User Search Results" table should load
    And rows containing the following should appear in the "User Search Results" table
      | Username       |
      | addchargeuser3 |
    When I select "addchargeuser3" from the "Username" column in the "User Search Results" table
    And I click the "Add Selected Users" button
    Then the "Recipients" table should load
    And rows containing the following should appear in the "Recipients" table
      | Username       |
      | addchargeuser3 |
    And I enter "test message 2" in the "Subject" field
    And I enter "test message 2" in the "Body" field
    And I click the "Send" button
    Then the "Information" pane should load
    And the following text should appear in the "Information" pane
      | Message Sent. |
    And The following fields should be enabled in the "Information" pane
      | Name | Type   |
      | OK   | button |
    And I click the "OK" button in the "Information" pane
    Then the "Recipients" table should load
    And rows containing the following should appear in the "Recipients" table
      | Username       |
      | addchargeuser3 |

  Scenario: 9. Verify Print Preview functionality
    Given I am logged into the portal with user "addchargeuser3" using the default password
    Then I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Mail" element
    And the "Mail Content" pane should load
    And I click the "Refresh" button
    Then the "Messages" table should load
    When I select "the first item" in the "Messages" table
    Then the "eSig And PK Mail Content" pane should load
    And The following fields should be enabled in the "eSig And PK Mail Content" pane
      | Name  | Type   |
      | Print | button |
    And I click the "Print" button
    And I wait "2" seconds
    And I close windows popup
    And I click the "Close" icon

  Scenario: 10. Verify reply to self functionality
    Given I am logged into the portal with user "addchargeuser3" using the default password
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Mail" element
    And I click the "Refresh" button
    And the "Mail Content" pane should load
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    Then rows containing the following should appear in the "Messages" table
      | Date                  | Description            | Subject        |
      | %Current Date MMDDYY% | From: USER3, ADDCHARGE | test message 1 |
    And I click on the text "test message 1" in the "eSig Note Content" pane
    Then the "eSig And PK Mail Content" pane should load
    And The following field should be enabled in the "eSig And PK Mail Content" pane
      | Name  | Type   |
      | Reply | button |
    And I click the "Reply" button
    And I enter "Re test message for self" in the "Subject" field in the "InboxSendPKMailPopUp" pane
    And I click the "Send" button in the "InboxSendPKMailPopUp" pane
    Then the "Information" pane should load
    And the following text should appear in the "Information" pane
      | Message Sent. |
    And The following fields should be enabled in the "Information" pane
      | Name | Type   |
      | OK   | button |
    And I click the "OK" button in the "Information" pane
    Then the "eSig And PK Mail Content" pane should load
    When I click the "Close" element
    And I click the "Refresh" button
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    Then rows containing the following should appear in the "Messages" table
      | Date                  | Description            | Subject                  |
      | %Current Date MMDDYY% | From: USER3, ADDCHARGE | Re test message for self |

  Scenario: 11. Verify ReplyToAll functionality
    Given I am logged into the portal with user "addchargeuser3" using the default password
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Mail" element
    And the "Mail Content" pane should load
    Then the "Messages" table should load
    Then rows containing the following should appear in the "Messages" table
      | Date                  | Description            | Subject                         |
      | %Current Date MMDDYY% | From: USER3, ADDCHARGE | test message for self and other |
    And I click on the text "test message for self and other" in the "eSig Note Content" pane
    Then the "eSig And PK Mail Content" pane should load
    And I click the "ReplyToAll" button
    Then the "RecipientsReply" table should load
    And rows containing the following should appear in the "RecipientsReply" table
      | Username       |
      | addchargeuser3 |
      | autoinbox1     |
    When I enter "Re Reply All" in the "Subject" field in the "InboxSendPKMailPopUp" pane
    And I click the "Send" button in the "InboxSendPKMailPopUp" pane
    And I click the "OK" button in the "Information" pane
    When I select the "eSig and PK Mail" subtab
    And I click the "Mail" element
    And the "Mail Content" pane should load
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    Then rows containing the following should appear in the "Messages" table
      | Date                  | Description            | Subject      |
      | %Current Date MMDDYY% | From: USER3, ADDCHARGE | Re Reply All |

  Scenario: 12. Verify repliedToAll mail received by other user
    Given I am logged into the portal with user "autoinbox1" using the default password
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Mail" element
    And the "Mail Content" pane should load
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    Then rows containing the following should appear in the "Messages" table
      | Date                  | Description            | Subject      |
      | %Current Date MMDDYY% | From: USER3, ADDCHARGE | Re Reply All |
@FW
  Scenario: 13. Verify Forward mail functionality
    Given I am logged into the portal with user "addchargeuser3" using the default password
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Mail" element
    And the "Mail Content" pane should load
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    Then rows containing the following should appear in the "Messages" table
      | Date                  | Description            | Subject                         |
      | %Current Date MMDDYY% | From: USER3, ADDCHARGE | test message for self and other |
    And I click on the text "test message for self and other" in the "eSig Note Content" pane
    And I click the "Forward" button
    And I wait for the "UserName" field of type "TEXT_FIELD" in the "User Search Criteria" pane to be visible
    And I wait "3" seconds
    When I enter "autoinbox0" in the "UserName" field in the "UserSearchAtReply" pane
    And I click the "Search" button in the "UserSearchAtReply" pane 
    When I select "autoinbox0" from the "Username" column in the "UserSearchResultsReply" table
    And I click the "Add Selected Users" button in the "UserSearchAtReply" pane
    When I enter "addchargeuser" in the "UserName" field in the "UserSearchAtReply" pane
    And I click the "Search" button in the "UserSearchAtReply" pane
    When I select "addchargeuser3" from the "Username" column in the "UserSearchResultsReply" table
    And I click the "Add Selected Users" button in the "UserSearchAtReply" pane
    And I enter "FW Forward Test Message" in the "Subject" field in the "InboxSendPKMailPopUp" pane
    And I click the "Send" button in the "InboxSendPKMailPopUp" pane
    Then the "Information" pane should load
    And I click the "OK" button in the "Information" pane
    When I select the "eSig and PK Mail" subtab
    And I click the "Mail" element
    And the "Mail Content" pane should load
    And I click the "Refresh" button
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    Then rows containing the following should appear in the "Messages" table
      | Date                  | Description            | Subject                 |
      | %Current Date MMDDYY% | From: USER3, ADDCHARGE | FW Forward Test Message |
@FW
  Scenario: 14. Verify forwarded mail received by other user
    Given I am logged into the portal with user "autoinbox1" using the default password
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Mail" element
    And the "Mail Content" pane should load
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    Then rows containing the following should appear in the "Messages" table
      | Date                  | Description            | Subject                    |
      | %Current Date MMDDYY% | From: USER3, ADDCHARGE | FW Forward Test Message |

  Scenario: 15. Verify Skip buttons functionality
    Given I am logged into the portal with user "addchargeuser3" using the default password
    Then I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Mail" element
    And the "Mail Content" pane should load
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    And I click on the text "test message 1" in the "eSig Note Content" pane
    Then the "eSig And PK Mail Content" pane should load
    And the following text should appear in the "eSig And PK Mail Content" pane
      | Subject:       |
      | test message 1 |
    And I click the "Skip" button in the "eSig And PK Mail Content" pane
    Then the "eSig And PK Mail Content" pane should load
    #Below is the verification where subject have changed and verify it does not exit
    And the following field should not display in the "eSig And PK Mail Content" pane
      | Name        | Type          |
      | SubjectText | MISC_ELEMENTS |
    When I click the "Close" element
    Then the "Messages" table should load

  Scenario: 16. Verify Refresh button functionality when select two checkboxes and click Refresh
    Given I am logged into the portal with user "addchargeuser3" using the default password
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Mail" element
    And the "Mail Content" pane should load
    And The following fields should be enabled in the "eSig Note Content" pane
      | Name    | Type   |
      | Refresh | button |
    And I click on the element "FirstNote Checkbox" in the "eSig Note Content" pane
    And the following text should appear in the "CollapsedScannedDialog" pane
      | 1 Items Selected |
    And I click on the element "SecondNote Checkbox" in the "eSig Note Content" pane
    And the following text should appear in the "CollapsedScannedDialog" pane
      | 2 Items Selected |
    And The following fields should be enabled in the "eSig Note Content" pane
      | Name   | Type   |
      | Delete | button |
    And I click the "Refresh" button
    And I wait "3" seconds
    And the "Mail Content" pane should load
    Then the following elements should be unchecked in the "eSig Note Content" pane
      | FirstNote Checkbox  |
      | SecondNote Checkbox |

  
  Scenario: 17. CleanUp - Delete All Mails with addchargeuser3 user
    Given I am logged into the portal with user "addchargeuser3" using the default password
    Then I am on the "Inbox" tab
    And I select the "eSig and PK Mail" subtab
    When I click the "Mail" element
    Then the "Mail Content" pane should load
    And I click the "Refresh" button
    And the "Messages" table should load
    And I click on the element "TopLevelCheckbox" in the "eSig Note Content" pane
    And I click the "Delete" button in the "eSig And PK Mail Content" pane
    And I click the "OK" button in the "Confirm" pane if it exists

  Scenario: 18. CleanUp - Delete All Mails with autoinbox1 user
    Given I am logged into the portal with user "autoinbox1" using the default password
    Then I am on the "Inbox" tab
    And I select the "eSig and PK Mail" subtab
    When I click the "Mail" element
    And the "Mail Content" pane should load
    And I click the "Refresh" button
    And the "Messages" table should load
    And I click on the element "TopLevelCheckbox" in the "eSig Note Content" pane
    And I click the "Delete" button in the "eSig And PK Mail Content" pane
    And I click the "OK" button in the "Confirm" pane if it exists
