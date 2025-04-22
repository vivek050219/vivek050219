@Messaging
Feature: Tests the messaging feature

  Scenario: Clearing the chat messages
    Given I am logged into the portal with user "chatuser1" using the default password
    And I delete all messages
    And I open the messaging window
    Then I click the "Messaging Name Tab" element

  @donotrun
  Scenario: Make sure the search results text does not appear when first opening the messaging window
    ## donotrun tag will be removed once DEV-76197 is fixed
    Given I am logged into the portal with user "chatuser1" using the default password
    And I open the messaging window
    Then the "Messaging No Search Results" "MISC_ELEMENT" should not be visible


  Scenario: Check the timestamp at the start of the chat. This must be run first
    Given I am logged into the portal with user "chatuser1" using the default password
    And I can send messages from the user: "Chat" "Dchatuser2"
    And I wait "2" second
    Then I enter "GetTimestamp" in the "Message Input Area" field
    And I wait "2" second
    And I press the "ENTER" key "1" time in the "Message Input Area" rich text field
    And I wait "2" second
    Then I confirm the message timestamp
    And I click the "Close Conversation" element


  Scenario Outline: The sender enters a message that contains HTML tags that should be removed
  along with the contents of the message
    Given I am logged into the portal with user "chatuser1" using the default password
    Given I can send messages to the user: "Chat" "Dchatuser2"
    And I enter "<InvalidHTMLMsg>" in the "Message Input Area" field
    And I press the "ENTER" key "1" time in the "Message Input Area" rich text field
    Then I check there is not a message that contains the "tag" "<InvalidHTMLMsg>" between the users "chatuser1" and "chatuser2"

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
    And I can send messages to the user: "Chat" "Dchatuser2"
    Then I enter "<Message>" in the "Message Input Area" field
    And I press the "ENTER" key "1" times in the "Message Input Area" rich text field
    Then I check there is a message that contains the "text" "<FilteredMessage>" between the users "chatuser1" and "chatuser2"

    Examples:
      | Message                                          | FilteredMessage                                        |
      | <button>Click me!</button>                       | Click me!                                              |
      | <textarea>This is 8<9.</textarea>                | This is 8&lt;9.                                        |
      | <img src="image/url">                            | <SPAN>[IMG] image/url</SPAN>                           |
      | <a href="http://www.google.com/">google site</a> | <SPAN>[LINK] http://www.google.com/ google site</SPAN> |


  Scenario: Testing the new line character
    Given I am logged into the portal with user "chatuser1" using the default password
    And I can send messages to the user: "Chat" "Dchatuser2"
    And I click the "Message Input Area Path" element
    And I type the string "Top%\n%Bottom" where the caret is currently focused
    And I press the "ENTER" key "1" time in the "Message Input Area" rich text field
    Then I check there is a message that contains a "NEWLINE" "Top" "Bottom" between the users "chatuser1" and "chatuser2"

  @donotrun
  Scenario: Testing the tab character
    ## donotrun tag will be removed once DEV-74760 is fixed
    Given I am logged into the portal with user "chatuser1" using the default password
    And I can send messages to the user: "Chat" "Dchatuser2"
    And I click the "Message Input Area Path" element
    And I type the string "Start%\t%Stop" where the caret is currently focused
    And I press the "ENTER" key "1" time in the "Message Input Area" rich text field
    Then I check there is a message that contains a "Start" "Stop" "TAB" between the users "chatuser1" and "chatuser2"


  Scenario Outline: User sends a message with special characters including
  ` ~ ! @ # $ % ^ & * ( ) - _ + = { } [ ] \ | : ; " ' < > , . ? / and space
    Given I am logged into the portal with user "chatuser1" using the default password
    And I can send messages to the user: "Chat" "Dchatuser2"
    And I enter "<UserMessage>" in the "Message Input Area" field
    And I press the "ENTER" key "1" time in the "Message Input Area" rich text field
    Then I look for a "Individual" message that says "<UserMessage>"

    Examples:
      | UserMessage |
      | testa       |
      | testb       |
      | testc       |
      | testd       |
      | teste       |
      | testf       |
      | testg       |
      | testh       |
      | testi       |
      | testj       |
      | testk       |
      | testl       |
      | testm       |
      | testn       |
      | testo       |
      | testp       |
      | testq       |
      | testr       |
      | tests       |
      | testt       |
      | testu       |
      | testv       |
      | testw       |
      | testx       |
      | testy       |
      | testz       |
      | testA       |
      | testB       |
      | testC       |
      | testD       |
      | testE       |
      | testF       |
      | testG       |
      | testH       |
      | testI       |
      | testJ       |
      | testK       |
      | testL       |
      | testM       |
      | testN       |
      | testO       |
      | testP       |
      | testQ       |
      | testR       |
      | testS       |
      | testT       |
      | testU       |
      | testV       |
      | testW       |
      | testX       |
      | testY       |
      | testZ       |
      | test1       |
      | test2       |
      | test3       |
      | test4       |
      | test5       |
      | test6       |
      | test7       |
      | test8       |
      | test9       |
      | test0       |
      | test~       |
      | test`       |
      | test!       |
      | test@       |
      | test#       |
      | test$       |
      | test%       |
      | test^       |
      | test&       |
      | test*       |
      | test(       |
      | test)       |
      | test-       |
      | test_       |
      | test+       |
      | test=       |
      | test[       |
      | test]       |
      | test{       |
      | test}       |
      | test;       |
      | test:       |
      | test'       |
      | test"       |
      | test<       |
      | test>       |
      | test,       |
      | test.       |
      | test/       |
      | test?       |
      | test\       |
      | test\|      |
      #The below case tests the space character
      | test test   |


  Scenario: Check to make sure the messages are listed as unread until the receiver opens the chat conversation
    Given I am logged into the portal with user "chatuser1" using the default password
    And I can read messages from the user: "Chat" "Dchatuser2"
    Then the "Unread Sent Message" "MISC_ELEMENT" should be visible


  Scenario Outline: The receiver of the messages checks to make sure the special characters appear
    Given I am logged into the portal with user "chatuser2" using the default password
    And I can read messages from the user: "Chat" "Achatuser1"
    Then I scroll up on the "Message Area" "PANES" element until the "<UserMessage>" appears on the "" tab

    Examples:
      | UserMessage |
      | testa       |
      | testb       |
      | testc       |
      | testd       |
      | teste       |
      | testf       |
      | testg       |
      | testh       |
      | testi       |
      | testj       |
      | testk       |
      | testl       |
      | testm       |
      | testn       |
      | testo       |
      | testp       |
      | testq       |
      | testr       |
      | tests       |
      | testt       |
      | testu       |
      | testv       |
      | testw       |
      | testx       |
      | testy       |
      | testz       |
      | testA       |
      | testB       |
      | testC       |
      | testD       |
      | testE       |
      | testF       |
      | testG       |
      | testH       |
      | testI       |
      | testJ       |
      | testK       |
      | testL       |
      | testM       |
      | testN       |
      | testO       |
      | testP       |
      | testQ       |
      | testR       |
      | testS       |
      | testT       |
      | testU       |
      | testV       |
      | testW       |
      | testX       |
      | testY       |
      | testZ       |
      | test1       |
      | test2       |
      | test3       |
      | test4       |
      | test5       |
      | test6       |
      | test7       |
      | test8       |
      | test9       |
      | test0       |
      | test~       |
      | test`       |
      | test!       |
      | test@       |
      | test#       |
      | test$       |
      | test%       |
      | test^       |
      | test&       |
      | test*       |
      | test(       |
      | test)       |
      | test-       |
      | test_       |
      | test+       |
      | test=       |
      | test[       |
      | test]       |
      | test{       |
      | test}       |
      | test;       |
      | test:       |
      | test'       |
      | test"       |
      | test<       |
      | test>       |
      | test,       |
      | test.       |
      | test/       |
      | test?       |
      | test\       |
      | test\|      |
      #The below case tests the space character
      | test test   |


  Scenario: Check to make sure the message is now read
    Given I am logged into the portal with user "chatuser1" using the default password
    And I can read messages from the user: "Chat" "Dchatuser2"
    Then the "Unread Sent Message" "MISC_ELEMENT" should not be visible


  Scenario: The user sets a callback number then clears it by setting a blank number
    Given I am logged into the portal with user "chatuser1" using the default password
    And I open the messaging window
    And I click the "Phone Settings Button" element
    And I enter "12223334444" in the "Set Phone Number Field" field
    And I click the "Save Phone Settings" element
    Then the "Phone Number Saved Feedback" "MISC_ELEMENT" should be visible
    And I enter "" in the "Set Phone Number Field" field
    And I click the "Save Phone Settings" element
    Then the "Phone Number Saved Feedback" "MISC_ELEMENT" should be visible
    Then I click the "Close Phone Settings" element


  Scenario: Add the selected patient into the chat conversation then end the conversation about that patient
    Given I am logged into the portal with user "chatuser1" using the default password
    And I can send messages to the user: "Chat" "Dchatuser2"
    And I am on the "Patient List V2" tab
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I wait up to "5" seconds for the "Start Patient Context" field of type "MISC_ELEMENT" to be visible
    And I click the "Start Patient Context" element
    And I wait "1" second
    Then I confirm the patient link for the patient "Molly" "Darr" appears in my current conversation
    And I enter "See this patient" in the "Message Input Area" field
    And I press the "ENTER" key "1" times in the "Message Input Area" rich text field
    Given I am logged into the portal with user "chatuser2" using the default password
    And I can read messages from the user: "Chat" "Achatuser1"
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
    And I click the "Close Patient Context" element
    Then I wait up to "5" seconds for the "Patient Context Closed" field of type "MISC_ELEMENT" to be visible
    And I enter "All set" in the "Message Input Area" field
    And I press the "ENTER" key "1" times in the "Message Input Area" rich text field
    And I select patient "Molly Darr" from the patient list
    And I select "Remove Patient" from the "Actions" menu
    And I click the "Yes" button


  Scenario: Add photo to chat conversation
    Given I am logged into the portal with user "chatuser1" using the default password
    And I can send messages to the user: "Chat" "Dchatuser2"
    And I click the "Add Image To Conversation" element
    And I type the path to "Images" "TestImage1.jpg" where the caret is currently focused
    And I wait up to "20" seconds for the "Chat Image" field of type "misc_element" to be visible
    Then the "TestImage1.jpg" image is visible


  Scenario: Check to make sure the most recent conversation is shown at the top of the list
    Given I am logged into the portal with user "chatuser2" using the default password
    And I can send messages to the user: "Chat" "Achatuser1"
    And I enter "Hi" in the "Message Input Area" field
    And I press the "ENTER" key "1" time in the "Message Input Area" rich text field

    Given I am logged into the portal with user "chatuser4" using the default password
    And I can send messages to the user: "Chat" "Achatuser1"
    And I enter "A message" in the "Message Input Area" field
    And I press the "ENTER" key "1" time in the "Message Input Area" rich text field

    Given I am logged into the portal with user "chatuser3" using the default password
    And I can send messages to the user: "Chat" "Achatuser1"
    And I enter "Bye" in the "Message Input Area" field
    And I press the "ENTER" key "1" time in the "Message Input Area" rich text field

    Given I am logged into the portal with user "chatuser1" using the default password
    And I open the messaging window
    Then The current conversations for the user should appear in the following order
      | Chat Hchatuser3  |
      | Chat Tchatuser4 |
      | Chat Dchatuser2 |


  # Inorder for chat messages to be purged from chat the Chat found in ServerRoles.TaskQueue must be set to true
  # Also the setting AppPurgeMessagesTaskInterval under Application. Chat is set to 120 seconds to decrease wait time
  Scenario: Check to make sure messages past the purge date are not viewable
    Given I am logged into the portal with user "chatuser1" using the default password
    And I can send messages to the user: "Chat" "Dchatuser2"
    And I enter "Hi" in the "Message Input Area" field
    And I press the "ENTER" key "1" time in the "Message Input Area" rich text field
    And I enter "This message should be purged" in the "Message Input Area" field
    And I press the "ENTER" key "1" time in the "Message Input Area" rich text field
    And I subtract "61" days from the timestamp with the text "This message should be purged"
    Then I execute the query "Check Messages" "10" times with "15" seconds in between each call for a result set that has = "0" results using the search key "This message should be purged"
    And I click the "Close Conversation" element
    And I can read messages from the user: "Chat" "Dchatuser2"
    Then I look for a "Individual" message that should not appear that says "This message should be purged"
    And I click the "Close Conversation" element


  # When multi window is stable it may be useful to check for a green dot when a user is online as well
  Scenario: Make sure there is a gray dot next to offline users
    Given I am logged into the portal with user "chatuser1" using the default password
    And I open the messaging window
    And I enter "dchatuser2" in the "User Search Bar" field
    Then I look for the offline user using the info "User Search Bar Results" and "Chat Dchatuser2" who specializes in "Dermatology, Internal Medicine, Medical Genetics and Genomics, Nuclear Medicine"
    And I press the "BACKSPACE" key "10" times in the "User Search Bar" rich text field
    And I enter "hchatuser3" in the "User Search Bar" field
    Then I look for the offline user using the info "User Search Bar Results" and "Chat Hchatuser3" who specializes in "Family Medicine, Medical Genetics and Genomics, Neurological Surgery, Neurology, Surgery"
    And I press the "BACKSPACE" key "10" times in the "User Search Bar" rich text field
    And I enter "tchatuser4" in the "User Search Bar" field
    Then I look for the offline user using the info "User Search Bar Results" and "Chat Tchatuser4" who specializes in "Dermatology"


  Scenario: If messaging is disabled then the user should not see the messaging tab
    Given I am logged into the portal with user "pkadmin" using the default password
    Then the "Message Tab Minimized" "MISC_ELEMENT" should not be visible
