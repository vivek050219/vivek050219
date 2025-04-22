@Messaging
Feature: Tests the group messaging feature

  Scenario: Clearing the chat messages
    Given I am logged into the portal with user "chatuser1" using the default password
    And I delete all messages
    And I open the messaging window
    Then I click the "Messaging Name Tab" element


  Scenario: This could be added to background setup but for now this is a redundant scenario to make sure messaging is
    turned on for the user since it must be disabled for a scenario below
    Given I am logged into the portal with user "chatuser1" using the default password
    And I am on the "Admin" tab
    And I open "Messaging" settings page for the user "chatuser4"
    Then I select "true" from the "Enable PK Messaging" radio list
    And I click the "Save" button
    And I click "OK" in the confirmation box


  Scenario: Safety step to ensure group messaging is enabled
    Given I am logged into the portal with user "pkadmin" using the default password
    And I am on the "Admin" tab
    And I select the "Institution" subtab
    And I select "Messaging" from the "Edit Institution Settings" dropdown
    Then I select "true" from the "Enable Group Messaging" radio list
    And I click the "Save" button
    And I click "OK" in the confirmation box


  Scenario: Make a group with no title and 3 members
    Given I am logged into the portal with user "chatuser1" using the default password
    And I open the messaging window
    And I click the "New Group" element

    And I enter "chatuser" in the "Make Group User Search Bar" field
    And I wait "1" second
    Then I select the offline user using the info "Group User" and "Chat Dchatuser2"
    And I wait "2" second
    Then I select the offline user using the info "Group User" and "Chat Hchatuser3"

    And I hover over and click the "Create Button" element of type "MISC_ELEMENTS" on the "" tab
    Then make sure the "Achatuser1, Dchatuser2 and Hchatuser3" group with "3" people is shown on the "In Conversation" card
    And I wait "2" second
    Then I click the "Close Conversation" element


  Scenario: Make a group with no title and more than 3 members
    Given I am logged into the portal with user "chatuser1" using the default password
    And I open the messaging window
    And I click the "New Group" element
    And I enter "chatuser" in the "Make Group User Search Bar" field
    Then I select the offline user using the info "Group User" and "Chat Dchatuser2"
    And I wait "2" second
    Then I select the offline user using the info "Group User" and "Chat Hchatuser3"
    And I wait "2" second
    And I press the "BACKSPACE" key "8" times in the "Make Group User Search Bar" rich text field
    And I enter "zchatuser5" in the "Make Group User Search Bar" field
    Then I select the offline user using the info "Group User" and "Chat Zchatuser5"

    And I hover over and click the "Create Button" element of type "MISC_ELEMENTS" on the "" tab
    Then make sure the "Achatuser1, Dchatuser2 and Hchatuser3..." group with "4" people is shown on the "In Conversation" card
    And I click the "Close Conversation" element


  Scenario Outline:  Create a group conversation with a title and check
    Given I am logged into the portal with user "chatuser1" using the default password
    And I open the messaging window
    And I click the "New Group" element
    And I enter "chat" in the "Make Group User Search Bar" field
    Then I select the offline user using the info "Group User" and "Chat Dchatuser2"
    Then I select the offline user using the info "Group User" and "Chat Hchatuser3"

    And I enter "<GroupName>" in the "Group Name" rich text field
    And I press the "Enter" key "1" time in the "Group Name" rich text field
    And I hover over the "Create Button" element of type "MISC_ELEMENTS" on the "" tab
    And I click the "Create Button" element

    Then the text "A Group Name" should appear in the "Message Area" pane
    And I enter "Hello everyone" in the "Message Input Area" field
    And I click the "ENTER" key in the "Message Input Area" rich text field
    Then I confirm the message timestamp
    And the text "C. Achatuser1" should not appear in the "Message Area" pane
    And I click the "Close Conversation" element

    Examples:
      | GroupName      |
      | A Group Name   |
      | B Group Name   |


  Scenario: Check to make sure the group conversation has the right members
    Given I am logged into the portal with user "chatuser3" using the default password
    And I open the messaging window
    And I can read messages from the group "A Group Name" with "3" people
    And I click the "Group Details" element
    And I wait "5" second
    And I enter "Test" in the "Message Input Area" field
    And I press the "ENTER" key "1" time in the "Message Input Area" rich text field
    And I wait "5" second
    Then the "Group Details Title" "MISC_ELEMENT" should be visible
    And I click the "Group Details Title" element
    And I look for the user using the info "Members List" and "Achatuser1, Chat"
    And I look for the user using the info "Members List" and "Dchatuser2, Chat"
    And I look for the user using the info "Members List" and "Hchatuser3, Chat"
    And I close the group details
    And I close the conversation


  Scenario Outline:  Each group member sends a message in the group conversation
    Given I am logged into the portal with user "<User>" using the default password
    And I open the messaging window
    And I can read messages from the group "A Group Name" with "3" people
    And I click the "Group Details" element
    And I wait "5" second
    And I enter "<Message>" in the "Message Input Area" field
    And I click the "ENTER" key in the "Message Input Area" rich text field
    Then the text "<ChatName>" should not appear in the "Message Area" pane

    Examples:
      | User      | Message      | ChatName      |
      | chatuser2 | Hi people    | C. Dchatuser2 |
      | chatuser3 | Bye everyone | C. Hchatuser3 |


  Scenario Outline:   Verify the name above the message is the correct sender
    Given I am logged into the portal with user "<User>" using the default password
    And I open the messaging window
    And I can read messages from the group "A Group Name" with "3" people
    And I click the "Group Details" element
    And I wait "5" second
    Then I look for a "Group" message from the user "<Name>" that says "<Message>"
    And I wait "5" second
#    And the text "Read" should not appear in the "Message Area" pane
    And Text exact "Read" should not appear in the "MessageStatus" section in the "Message Area" pane
#    And the text "Unread" should not appear in the "Message Area" pane
    And Text exact "Unread" should not appear in the "MessageStatus" section in the "Message Area" pane
    And make sure the "A Group Name" group with "3" people is shown on the "In Conversation" card

    Examples:
      | User      | Name          | Message        |
      | chatuser2 | C. Achatuser1 | Hello everyone |
      | chatuser2 | C. Hchatuser3 | Bye everyone   |
      | chatuser3 | C. Achatuser1 | Hello everyone |
      | chatuser3 | C. Dchatuser2 | Hi people      |


  Scenario: Search for a group that you are not a part of
    Given I am logged into the portal with user "chatuser4" using the default password
    And I open the messaging window
    And I enter "A Group Name" in the "User Search Bar" field
    Then the text "A Group Name" should not appear in the "Message Area" pane


  Scenario Outline: The sender enters a group message that contains HTML tags that should be removed along with the contents
  of the message and checks makes sure the HTML was sanitized for the sender
    Given I am logged into the portal with user "chatuser1" using the default password
    And I open the messaging window
    And I can send messages to the group "A Group Name" with "3" people
    And I click the "Group Details" element
    And I wait "5" second
    And I enter "<InvalidHTMLMsg>" in the "Message Input Area" field
    And I press the "ENTER" key "1" time in the "Message Input Area" rich text field
    Then I check there is not a message that contains the "tag" "<InvalidHTMLMsg>" between the users "system" and "chatuser1"

    Examples:
      | InvalidHTMLMsg                                                                                                                                                                          |
      | <html>html should not work</html>                                                                                                                                                       |
      | <body>body should not work</body>                                                                                                                                                       |
      | <meta name="meta" content="Web tutorials">                                                                                                                                              |
      | <head>head should not work</head>                                                                                                                                                       |
      | <link rel="stylesheet" type="text/css" href="ATheme.css">                                                                                                                               |
      | <title>title should not work</title>                                                                                                                                                    |
      | <script>document.getElementById("demo").innerHTML = "Hello World!";</script>                                                                                                            |
      | <frameset>frameset should not work</frameset>                                                                                                                                           |
      | <frameset cols="33%,*,25%"><frame src="frame_x.htm"><frame src="frame_y.htm"><frame src="frame_z.htm"></frameset>                                                                       |
      | <form action="/some_action.php" method="get">Form name: <input type="text" name="fname"><br>Last name: <input type="text" name="lname"><br></form>                                      |
      | <input type="submit" value="input">                                                                                                                                                     |
      | <select>select should not work</select>                                                                                                                                                 |
      | <option>option should not work</option>                                                                                                                                                 |
      | <map name="shapesMap"><area shape="rect" coords="0,0,82,126" href="big_circle.htm" alt="Fire Ball"><area shape="circle" coords="90,58,3" href="smaller_circle.htm" alt="Mercury"></map> |
      | <style> h1 {color:green;} p {color:red;} style{} </style>                                                                                                                               |
      | <iframe src="https://www.patientkeeper.com"></iframe>                                                                                                                                   |


  Scenario Outline: The user enters HTML tags that should be filtered
    Given I am logged into the portal with user "chatuser1" using the default password
    And I open the messaging window
    And I can send messages to the group "A Group Name" with "3" people
    And I click the "Group Details" element
    And I wait "5" second
    Then I enter "<Message>" in the "Message Input Area" field
    And I press the "ENTER" key "1" times in the "Message Input Area" rich text field
    Then I check there is a message that contains the "tag" "<FilteredMessage>" between the users "system" and "chatuser1"
    And I click the "Close Conversation" element

    Examples:
      | Message                                          | FilteredMessage                                        |
      | <button>Click me!</button>                       | Click me!                                              |
      | <textarea>This is 8<9.</textarea>                | This is 8&lt;9.                                        |
      | <img src="image/url">                            | <SPAN>[IMG] image/url</SPAN>                           |
      | <a href="http://www.google.com/">google site</a> | <SPAN>[LINK] http://www.google.com/ google site</SPAN> |


  Scenario: Testing the new line character
    Given I am logged into the portal with user "chatuser1" using the default password
    And I open the messaging window
    And I can read messages to the group "A Group Name" with "3" people
    And I click the "Group Details" element
    And I click the "Message Input Area Path" element
    And I type the string "Top%\n%Bottom" where the caret is currently focused
    And I press the "ENTER" key "1" time in the "Message Input Area" rich text field
    Then I check there is a message that contains a "NEWLINE" "Top" "Bottom" between the users "system" and "chatuser1"

  @donotrun
  Scenario: Testing the tab character
    ## donotrun tag will be removed once DEV-74760 is fixed
    Given I am logged into the portal with user "chatuser1" using the default password
    And I open the messaging window
    And I can read messages to the group "A Group Name" with "3" people
    And I click the "Group Details" element
    And I click the "Message Input Area Path" element
    And I type the string "Top%\t%Bottom" where the caret is currently focused
    And I press the "ENTER" key "1" time in the "Message Input Area" rich text field
    Then I check there is a message that contains a "Start" "Stop" "TAB" between the users "system" and "chatuser1"


  Scenario Outline:   Send messages to another user containing all characters
    Given I am logged into the portal with user "chatuser1" using the default password
    And I open the messaging window
    And I can read messages from the group "A Group Name" with "3" people
    And I click the "Group Details" element
    And I wait "5" second
    And I enter "<GroupMessage>" in the "Message Input Area" field
    And I click the "ENTER" key in the "Message Input Area" rich text field
    Then I look for a "Individual" message that says "<GroupMessage>"

    Examples:
      | GroupMessage |
      | testa        |
      | testb        |
      | testc        |
      | testd        |
      | teste        |
      | testf        |
      | testg        |
      | testh        |
      | testi        |
      | testj        |
      | testk        |
      | testl        |
      | testm        |
      | testn        |
      | testo        |
      | testp        |
      | testq        |
      | testr        |
      | tests        |
      | testt        |
      | testu        |
      | testv        |
      | testw        |
      | testx        |
      | testy        |
      | testz        |
      | testA        |
      | testB        |
      | testC        |
      | testD        |
      | testE        |
      | testF        |
      | testG        |
      | testH        |
      | testI        |
      | testJ        |
      | testK        |
      | testL        |
      | testM        |
      | testN        |
      | testO        |
      | testP        |
      | testQ        |
      | testR        |
      | testS        |
      | testT        |
      | testU        |
      | testV        |
      | testW        |
      | testX        |
      | testY        |
      | testZ        |
      | test1        |
      | test2        |
      | test3        |
      | test4        |
      | test5        |
      | test6        |
      | test7        |
      | test8        |
      | test9        |
      | test0        |
      | test~        |
      | test`        |
      | test!        |
      | test@        |
      | test#        |
      | test$        |
      | test%        |
      | test^        |
      | test&        |
      | test*        |
      | test(        |
      | test)        |
      | test-        |
      | test_        |
      | test+        |
      | test=        |
      | test[        |
      | test]        |
      | test{        |
      | test}        |
      | test;        |
      | test:        |
      | test'        |
      | test"        |
      | test<        |
      | test>        |
      | test,        |
      | test.        |
      | test/        |
      | test?        |
      | test\        |
      | test\|       |
      #The below case tests the space character
      | test test    |


  Scenario Outline: Make sure all characters are properly displayed on the chat window
    Given I am logged into the portal with user "chatuser2" using the default password
    And I open the messaging window
    And I can read messages from the group "A Group Name" with "3" people
    And I click the "Group Details" element
    Then I scroll up on the "Message Area" "PANES" element until the "<GroupMessage>" appears on the "" tab

    Examples:
      | GroupMessage |
      | testa        |
      | testb        |
      | testc        |
      | testd        |
      | teste        |
      | testf        |
      | testg        |
      | testh        |
      | testi        |
      | testj        |
      | testk        |
      | testl        |
      | testm        |
      | testn        |
      | testo        |
      | testp        |
      | testq        |
      | testr        |
      | tests        |
      | testt        |
      | testu        |
      | testv        |
      | testw        |
      | testx        |
      | testy        |
      | testz        |
      | testA        |
      | testB        |
      | testC        |
      | testD        |
      | testE        |
      | testF        |
      | testG        |
      | testH        |
      | testI        |
      | testJ        |
      | testK        |
      | testL        |
      | testM        |
      | testN        |
      | testO        |
      | testP        |
      | testQ        |
      | testR        |
      | testS        |
      | testT        |
      | testU        |
      | testV        |
      | testW        |
      | testX        |
      | testY        |
      | testZ        |
      | test1        |
      | test2        |
      | test3        |
      | test4        |
      | test5        |
      | test6        |
      | test7        |
      | test8        |
      | test9        |
      | test0        |
      | test~        |
      | test`        |
      | test!        |
      | test@        |
      | test#        |
      | test$        |
      | test%        |
      | test^        |
      | test&        |
      | test*        |
      | test(        |
      | test)        |
      | test-        |
      | test_        |
      | test+        |
      | test=        |
      | test[        |
      | test]        |
      | test{        |
      | test}        |
      | test;        |
      | test:        |
      | test'        |
      | test"        |
      | test<        |
      | test>        |
      | test,        |
      | test.        |
      | test/        |
      | test?        |
      | test\        |
      | test\|       |
      #The below case tests the space character
      | test test    |

  Scenario Outline: Check to make sure all users can change the group name
    Given I am logged into the portal with user "<User>" using the default password
    And I open the messaging window
    And I can read messages from the group "B Group Name" with "3" people
    And I click the "Group Details" element
    And I wait "5" second
    And I press the "BACKSPACE" key "30" times in the "Group Name" rich text field
     # This group name has exactly 30 characters
    And I hover over and click the "Group Name" element of type "TEXT_FIELDS" on the "" tab
    And I type the string "Make a group name with 30 char" where the caret is currently focused
    And I close the group details
    And I wait up to "5" seconds for the "Group Details" field of type "misc_element" to be visible
    Then the text "Make a group name with 30 char" should appear in the "Message Area" pane
    Then the text "User <FullName> has changed Group Name to Make a group name with 30 char" should appear in the "Message Area" pane
    And I click the "Group Details" element
    And I press the "BACKSPACE" key "30" times in the "Group Name" rich text field
    And I hover over and click the "Group Name" element of type "TEXT_FIELDS" on the "" tab
    And I type the string "This group name contains more than 30 characters" where the caret is currently focused
    And I close the group details
    And I wait up to "5" seconds for the "Group Details" field of type "misc_element" to be visible
    Then the text "This group name contains more " should appear in the "Message Area" pane
    And I click the "Group Details" element
    And I press the "BACKSPACE" key "30" times in the "Group Name" rich text field
    And I type the string "B Group Name" where the caret is currently focused
    And I close the group details
    And I close the conversation

    Examples:
      | User      | FullName      |
      | chatuser3 | C. Hchatuser3 |
      | chatuser2 | C. Dchatuser2 |
      | chatuser1 | C. Achatuser1 |


  Scenario:   Test special characters in the group name
    Given I am logged into the portal with user "chatuser1" using the default password
    And I open the messaging window
    And I can read messages from the group "B Group Name" with "3" people
    And I click the "Group Details" element
    And I wait "5" second
    And I press the "BACKSPACE" key "30" times in the "Group Name" rich text field
    And I enter "`~!@#$%^&*()_-=+'" in the "Group Name" rich text field
    And I click the "Close Group Details" element
    Then make sure the "`~!@#$%^&*()_-=+'" group with "3" people is shown on the "In Conversation" card
    And I click the "Group Details" element
    And I press the "BACKSPACE" key "30" times in the "Group Name" rich text field
    And I enter "{}[]\|;:",.<>/?" in the "Group Name" rich text field
    And I click the "Close Group Details" element
    Then make sure the "{}[]\|;:",.<>/?" group with "3" people is shown on the "In Conversation" card
    And I click the "Group Details" element
    And I press the "BACKSPACE" key "30" times in the "Group Name" rich text field
    And I enter "B Group Name" in the "Group Name" rich text field
    And I click the "Close Group Details" element
    And I click the "Close Conversation" element


  Scenario:   Send a patient context link to a group conversation
    Given I am logged into the portal with user "chatuser1" using the default password
    And I open the messaging window
    And I can read messages from the group "A Group Name" with "3" people
    And I am on the "Patient List V2" tab
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I wait up to "5" seconds for the "Start Patient Context" field of type "MISC_ELEMENT" to be visible
    And I click the "Start Patient Context" element
    And I wait "1" second
    Then I confirm the patient link for the patient "Molly" "Darr" appears in my current conversation
    And I enter "See this patient" in the "Message Input Area" field
    And I press the "ENTER" key "1" times in the "Message Input Area" rich text field


  Scenario Outline:   Add the patient in the link to to patient list each user has a different PAT level 1-3
    Given I am logged into the portal with user "<User>" using the default password
    And I open the messaging window
    And I can read messages from the group "A Group Name" with "3" people
    And I am on the "Patient List V2" tab
    And I select "Messaging" from the "Patient List" menu
    And I enter "Ill add them to my patient list" in the "Message Input Area" field
    And I press the "ENTER" key "1" times in the "Message Input Area" rich text field
    And I click the patient link for the patient "Molly" "Darr" in my current conversation
    And I wait up to "5" seconds for the "Patient Detail Visits" field of type "MISC_ELEMENT" to be visible
    And I click the "Patient Detail Visits" element
    Then I select "the first item" in the "ProvidersToVisit" table
    And I click the "Add To Patient List" button
    And I click the "Patient Detail Add" button
    And I wait "1" second
    And I enter "All set" in the "Message Input Area" field
    And I press the "ENTER" key "1" times in the "Message Input Area" rich text field
    And I select patient "Molly Darr" from the patient list

    And I select "Remove Patient" from the "Actions" menu
    And I click the "Yes" button

    Examples:
      | User      |
      | chatuser3 |
      | chatuser2 |


  Scenario: Close the patient in the link to to patient list
    Given I am logged into the portal with user "chatuser3" using the default password
    And I open the messaging window
    And I can read messages from the group "A Group Name" with "3" people
    And I click the "Close Patient Context" element
    And I enter "All done" in the "Message Input Area" field
    And I press the "ENTER" key "1" times in the "Message Input Area" rich text field

  Scenario Outline: Try to add and delete a user from an already created group chat
    Given I am logged into the portal with user "<User>" using the default password
    And I open the messaging window
    And I can read messages from the group "A Group Name" with "3" people
    And I click the "Group Details" element
    And I enter "chatuser4" in the "Make Group User Search Bar" field
    Then I select the offline user using the info "Group User" and "Chat Tchatuser4"
    And I wait "3" seconds
    And I click the "Add To Group" element
    And I wait "3" seconds
    And I close the group details
    Then the text "User <FullName> added Tchatuser4, Chat into Group" should appear in the "Message Area" pane
    And I click the "Group Details" element
    And I wait "3" seconds
    Then I select the user using the info "Remove From Group" and "Tchatuser4, Chat"
    And I click the "Yes Delete User" element
    And I close the group details
    Then the text "User <FullName> Removed C. Tchatuser4 from Group" should appear in the "Message Area" pane

    Examples:
      | User      | FullName      |
      | chatuser3 | C. Hchatuser3 |
      | chatuser2 | C. Dchatuser2 |
      | chatuser1 | C. Achatuser1 |


  Scenario: Check to make sure the removed user can see the removal messages
    Given I am logged into the portal with user "chatuser4" using the default password
    And I open the messaging window
    And I can read messages from the group "A Group Name" with "3" people
    Then the text "User C. Hchatuser3 Removed C. Tchatuser4 from Group" should appear in the "Message Area" pane
    Then the text "User C. Dchatuser2 Removed C. Tchatuser4 from Group" should appear in the "Message Area" pane
    Then the text "User C. Achatuser1 Removed C. Tchatuser4 from Group" should appear in the "Message Area" pane


  # Legacy messages displayed for removed members
  Scenario Outline: Now that chatuser4 has been added and removed from the group they should be able to see unpurged messages
    Given I am logged into the portal with user "chatuser4" using the default password
    And I open the messaging window
    And I can read messages to the group "A Group Name" with "3" people
    Then I scroll up on the "Message Area" "PANES" element until the "<Message>" appears on the "" tab

    Examples:
      | Message        |
      | Hello everyone |
      | Hi people      |
      | Bye everyone   |


  Scenario: Send a message in the group chat that will be purged and add chatuser4 back to the group
    Given I am logged into the portal with user "chatuser2" using the default password
    And I open the messaging window
    And I can read messages from the group "A Group Name" with "3" people
    And I click the "Group Details" element
    And I wait "5" second
    And I enter "chatuser4" in the "Make Group User Search Bar" field
    And I select the offline user using the info "Group User" and "Chat Tchatuser4"
    Then I click the "Add To Group" element
    And I click the "Close Group Details" element
    And I enter "This message should be purged" in the "Message Input Area" field
    And I press the "ENTER" key "1" time in the "Message Input Area" rich text field
    Then I look for a "Individual" message that says "This message should be purged"


  Scenario Outline: Check to make sure the message appears before leaving/being removed from the group
    Given I am logged into the portal with user "<User>" using the default password
    And I open the messaging window
    And I can read messages from the group "A Group Name" with "4" people
    Then I look for a "<MessageType>" message from the user "<Sender>" that says "This message should be purged"

    Examples:
      | User      | MessageType | Sender        |
      | chatuser4 | Group       | C. Dchatuser2 |
      | chatuser1 | Group       | C. Dchatuser2 |
      | chatuser3 | Group       | C. Dchatuser2 |


  Scenario: A user leaves the chat conversation
    Given I am logged into the portal with user "chatuser3" using the default password
    And I open the messaging window
    And I can read messages from the group "A Group Name" with "3" people
    And I click the "Group Details" element
    And I click the "Leave Group Conversation" element
    And I click "OK" in the confirmation box


  Scenario: Set the message past the set purge date and remove an user from the group
    Given I am logged into the portal with user "chatuser1" using the default password
    And I open the messaging window
    And I can read messages from the group "A Group Name" with "3" people
    And I click the "Group Details" element
    And I wait "5" second
    And I select the user using the info "Remove From Group" and "Tchatuser4, Chat"
    And I click the "Yes Delete User" element
    And I subtract "61" days from the timestamp with the text "This message should be purged"
    Then I execute the query "Check Messages" "10" times with "15" seconds in between each call for a result set that has = "0" results using the search key "This message should be purged"


  Scenario: Make sure purged messages are not shown for users who were removed from the chat
    Given I am logged into the portal with user "chatuser4" using the default password
    And I open the messaging window
    And I can read messages from the group "A Group Name" with "2" people
    Then I look for a "Group" message that should not appear from the user "chatuser2" that says "This message should be purged"


  Scenario: Make sure purged messages are not shown for users who leave a chat
    Given I am logged into the portal with user "chatuser3" using the default password
    And I open the messaging window
    And I can read messages from the group "A Group Name" with "2" people
    Then I look for a "Group" message that should not appear from the user "chatuser2" that says "This message should be purged"


  Scenario Outline: Check to make sure the message is purged for group members
    Given I am logged into the portal with user "<User>" using the default password
    And I open the messaging window

    And I can read messages from the group "A Group Name" with "2" people
    Then I look for a "<MessageType>" message that should not appear from the user "<Sender>" that says "This message should be purged"

    Examples:
      | User      | MessageType | Sender        |
      | chatuser2 | Individual  | C. Dchatuser2 |
      | chatuser1 | Group       | C. Dchatuser2 |


  # Group Details, Prevent view group detail and message send (removed member)
  Scenario: Send a message in a conversation that you were removed from
    Given I am logged into the portal with user "chatuser4" using the default password
    And I open the messaging window
    And I can read messages from the group "A Group Name" with "2" people
    And I enter "Please let me in" in the "Message Input Area" field
    And I click the "ENTER" key in the "Message Input Area" rich text field
    Then the text "You are not currently a member of this group" should appear in the "PkModalBody" pane
    And I click the "Close Button" element
    And I click the "Group Details" element
    Then the text "You are not currently a member of this group" should appear in the "PkModalBody" pane
    And I click the "Close Button" element

  # Group Details, Prevent view group detail and message send (removed member)
  Scenario: Send a message in a conversation that you left yourself
    Given I am logged into the portal with user "chatuser3" using the default password
    And I open the messaging window
    And I can read messages from the group "A Group Name" with "2" people
    And I enter "Please let me in" in the "Message Input Area" field
    And I click the "ENTER" key in the "Message Input Area" rich text field
    Then the text "You are not currently a member of this group" should appear in the "PkModalBody" pane
    And I click the "Close Button" element
    And I click the "Group Details" element
    Then the text "You are not currently a member of this group" should appear in the "PkModalBody" pane
    And I click the "Close Button" element


  Scenario: Make sure that un-purged legacy messages still appear after leaving a conversation
    Given I am logged into the portal with user "chatuser3" using the default password
    And I open the messaging window
    And I can read messages from the group "A Group Name" with "2" people
    Then I scroll up on the "Message Area" "PANES" element until the "Hello everyone" appears on the "" tab
    Then I scroll up on the "Message Area" "PANES" element until the "Hi people" appears on the "" tab
    Then I scroll up on the "Message Area" "PANES" element until the "Bye everyone" appears on the "" tab


  Scenario:   Check that messages sent after being removed from a group conversation are not seen
    Given I am logged into the portal with user "chatuser1" using the default password
    And I open the messaging window
    And I can read messages from the group "A Group Name" with "2" people
    And I enter "users 3 and 4 not in group should not see this" in the "Message Input Area" field
    And I click the "ENTER" key in the "Message Input Area" rich text field

    # This user was previously removed from the group in the scenario: Set the message past the set purge date and remove an user from the group
    Given I am logged into the portal with user "chatuser4" using the default password
    And I open the messaging window
    And I can read messages from the group "A Group Name" with "2" people
    Then I look for a "Group" message that should not appear from the user "C. Achatuser1" that says "users 3 and 4 not in group should not see this"


  Scenario: If a user leaves a group any new messages are not seen (using the message from the scenario above)
    # This user left the group on their own
    Given I am logged into the portal with user "chatuser3" using the default password
    And I open the messaging window
    And I can read messages from the group "A Group Name" with "2" people
    Then I look for a "Group" message that should not appear from the user "C. Achatuser1" that says "users 3 and 4 not in group should not see this"


  Scenario: A group member adds user back into the group to make sure the receive the messages sent while they were not
  in the group
    Given I am logged into the portal with user "chatuser1" using the default password
    And I open the messaging window
    And I can read messages from the group "A Group Name" with "2" people
    And I click the "Group Details" element
    And I enter "chat" in the "Make Group User Search Bar" field
    And I select the offline user using the info "Group User" and "Chat Hchatuser3"
    And I select the offline user using the info "Group User" and "Chat Tchatuser4"
    Then I click the "Add To Group" element


  Scenario: A group member that was removed confirms they got the message sent while they were removed
    Given I am logged into the portal with user "chatuser4" using the default password
    And I open the messaging window
    And I can read messages from the group "A Group Name" with "4" people
    Then I look for a "Group" message from the user "C. Achatuser1" that says "users 3 and 4 not in group should not see this"


  Scenario: A group member who left the group makes sure they got the message sent while not in the group
    Given I am logged into the portal with user "chatuser3" using the default password
    And I open the messaging window
    And I can read messages from the group "A Group Name" with "4" people
    Then I look for a "Group" message from the user "C. Achatuser1" that says "users 3 and 4 not in group should not see this"


  Scenario: If group messaging is disabled the user can't see groups or send group messages
    Given I am logged into the portal with user "pkadmin" using the default password
    And I am on the "Admin" tab
    And I select the "Institution" subtab
    And I select "Messaging" from the "Edit Institution Settings" dropdown
    Then I select "false" from the "Enable Group Messaging" radio list
    And I click the "Save" button
    And I click "OK" in the confirmation box
    Given I am logged into the portal with user "chatuser1" using the default password
    And I open the messaging window
    Then the "New Group" "MISC_ELEMENT" should not be visible
    Then make sure the "A Group Name" group with "4" people is not shown on the "Recent Conversations" card
    And I enter "A Group Name" in the "User Search Bar" field
    Then make sure the "A Group Name" group with "4" people is not shown on the "Recent Conversations" card


  Scenario: Re-Enable group messaging, this step is separate so if the scenario above fails the ones below can still pass
    Given I am logged into the portal with user "pkadmin" using the default password
    And I am on the "Admin" tab
    And I select the "Institution" subtab
    And I select "Messaging" from the "Edit Institution Settings" dropdown
    Then I select "true" from the "Enable Group Messaging" radio list
    And I click the "Save" button
    And I click "OK" in the confirmation box


  Scenario: Turn off messaging for a user then check to make sure they were removed from the group chat
    Given I am logged into the portal with user "chatuser1" using the default password
    And I am on the "Admin" tab
    And I open "Messaging" settings page for the user "chatuser4"
    And I select "false" from the "Enable PK Messaging" radio list
    And I click the "Save" button
    And I click "OK" in the confirmation box
    And I can read messages from the group "A Group Name" with "3" people
    And I wait "1" second
    Then I look for a "System" message that says ": C. Tchatuser4 was removed from this conversation because Messaging was disabled for this user."
    And I click the "Close Conversation" element


  Scenario: Turn on messaging for the removed user
    Given I am logged into the portal with user "chatuser1" using the default password
    And I am on the "Admin" tab
    And I open "Messaging" settings page for the user "chatuser4"
    Then I select "true" from the "Enable PK Messaging" radio list
    And I click the "Save" button
    And I click "OK" in the confirmation box


  Scenario: Verify the On Call tab is not accessible from the group creation
    Given I am logged into the portal with user "chatuser1" using the default password
    And I open the messaging window
    And I click the "Messaging Name Tab" element
    And I click the "New Group" element
    Then the "Group Details Title" "MISC_ELEMENT" should be visible
    And I click the "Messaging On Call Tab" element
    Then the "On Call Search Bar" "text_field" should not be visible
    And I click the "Close Button" element


  Scenario: Send an individual message and make sure that group messages and individual messages appear together
    Given I am logged into the portal with user "chatuser1" using the default password
    And I can send messages to the user: "Chat" "Dchatuser2"
    And I wait "2" seconds
    And I enter "Hi there" in the "Message Input Area" field
    And I click the "ENTER" key in the "Message Input Area" rich text field
    And I click the "Close Conversation" element
    And I open the messaging window
    Then The current conversations for the user should appear in the following order
      | Chat Dchatuser2 |
      | A Group Name    |
