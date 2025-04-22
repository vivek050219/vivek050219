@Messaging

Feature: Testing the On-Call module of messaging

  Scenario: Clearing the chat messages
    Given I am logged into the portal with user "chatuser1" using the default password
    And I delete all messages


  Scenario: Test different search terms (first + last name) and verify the the correct users appear
    Given I am logged into the portal with user "chatuser1" using the default password
    And I open the messaging window
    Then I wait "10" seconds
    And I enter "dan" in the "User Search Bar" field
    Then I look for the offline user using the info "User Search-On Call" and "Daniel Dobbs" who specializes in "Neurological Surgery"

    And I enter "Daniel" in the "User Search Bar" field
    Then I look for the offline user using the info "User Search-On Call" and "Daniel Dobbs" who specializes in "Neurological Surgery"

    And I enter "Dob" in the "User Search Bar" field
    Then I look for the offline user using the info "User Search-On Call" and "Daniel Dobbs" who specializes in "Neurological Surgery"

    And I enter "dobbs" in the "User Search Bar" field
    Then I look for the offline user using the info "User Search-On Call" and "Daniel Dobbs" who specializes in "Neurological Surgery"

    And I enter "Neuro" in the "User Search Bar" field
    Then I look for the offline user using the info "User Search-On Call" and "Daniel Dobbs" who specializes in "Neurological Surgery"
    Then I look for the offline user using the info "User Search-On Call" and "Cathy Donohue" who specializes in "Neurology, Nuclear Medicine, Ophthalmology, Orthopaedic Surgery"


  Scenario: Check to make sure the users information is displayed when they click the info icon for a user who is NOT on call
    Given I am logged into the portal with user "chatuser1" using the default password
    And I open the messaging window
    And I wait "5" seconds
    And I click the "Messaging On Call Tab" element
    Then view information of the non-pk messaging user "Administrator On Call" "Kadmin, Perry" who is offering "Administrator" at the "PKOnCall" facility
    And I click the "Close User Info Pop Up" element


  Scenario: Make sure that results are filtered on specialty after typing at least 3 letters
    Given I am logged into the portal with user "chatuser1" using the default password
    And I open the messaging window
    And I click the "Messaging On Call Tab" element
    And I wait "5" seconds
    #There should be no results appearing since there is no specialty with numbers
    And I enter "123" in the "On Call Search Bar" rich text field
    And I wait "5" seconds
    Then the "On Call Search Results" "MISC_ELEMENT" should not be visible
    And I press the "BACKSPACE" key "3" times in the "On Call Search Bar" rich text field
    And I enter "hos" in the "On Call Search Bar" rich text field
    Then look for the pk messaging user "Hospitalist" "Donohue, Cathy" who is offering "Physician" at the "PKOnCall" facility


  Scenario: Make sure that results are filtered on service offered after typing at least 3 letters
    Given I am logged into the portal with user "chatuser1" using the default password
    And I open the messaging window
    And I click the "Messaging On Call Tab" element
    And I wait "5" seconds
    And I enter "Call" in the "On Call Search Bar" rich text field
    And I wait "5" seconds
    Then look for the non-pk messaging user "Administrator On Call" "Kadmin, Perry" who is offering "Administrator" at the "PKOnCall" facility
    And I press the "BACKSPACE" key "21" times in the "On Call Search Bar" rich text field


  Scenario: Check to make sure the users information is displayed when they click the info icon for a user who is on call
    Given I am logged into the portal with user "chatuser1" using the default password
    And I open the messaging window
    And I click the "Messaging On Call Tab" element
    And I wait "2" seconds
    Then view information of the pk messaging user "Hospitalist" "Donohue, Cathy" who is offering "Physician" at the "PKOnCall" facility
    And I click the "Close User Info Pop Up" element


  Scenario: Open the on call tab and try to start a chat with a user who is not a chat user
    Given I am logged into the portal with user "chatuser1" using the default password
    And I open the messaging window
    And I click the "Messaging On Call Tab" element
    Then start chat with the non-pk messaging user "Administrator On Call" "Kadmin, Perry" who is offering "Administrator" at the "PKOnCall" facility
    # This xpath is hardcoded to "Perry Kadmin"
    And the "pkadmin Not Messaging User Error" "MISC_ELEMENT" should be visible
    And I wait "5" seconds
    And I click the "Close User Info Pop Up" element
    And I click the "Messaging Name Tab" element


  Scenario: Open the on call tab and try to start a chat with a user who is a chat user
    Given I am logged into the portal with user "chatuser1" using the default password
    And I open the messaging window
    And I click the "Messaging On Call Tab" element
    And I wait "2" seconds
    Then start chat with the pk messaging user "Hospitalist" "Donohue, Cathy" who is offering "Physician" at the "PKOnCall" facility
    And I enter "hi" in the "Message Input Area" field
    And I press the "ENTER" key "1" time in the "Message Input Area" rich text field
    Then I look for a "Individual" message that says "hi"
    And I confirm the message timestamp
    And I wait "2" seconds
    And I click the "Close Conversation" element
    And I click the logout button

  Scenario Outline: Test all the characters in a conversation started through the on-call tab
    Given I am logged into the portal with user "chatuser1" using the default password
    And I open the messaging window
    And I click the "Messaging On Call Tab" element
    And I wait "2" seconds
    Then start chat with the pk messaging user "Hospitalist" "Donohue, Cathy" who is offering "Physician" at the "PKOnCall" facility
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
#      The below case tests the space character
      | test test   |

  Scenario Outline: The receiver of the messages checks to make sure the special characters appear
    Given I am logged into the portal with user "cdonohue" using the default password
    And I can read messages from the user: "Chat" "Achatuser1"
    And I wait "3" seconds
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


  Scenario: Make sure the user is listed as on call under the message preview in recent conversation card
    Given I am logged into the portal with user "chatuser1" using the default password
    And I open the messaging window
    And I click the "Messaging Name Tab" element
    Then I look for the offline user using the info "Recent Conversations-On Call" and "Cathy Donohue" who specializes in "Neurology, Nuclear Medicine, Ophthalmology, Orthopaedic Surgery"

  #TODO: Change the facility used in this test. Right now all users are in the same facility so this might not be the strongest test
  Scenario: Apply a facility filter and make sure only users related with the facility appear. Verify that the correct users are shown
    Given I am logged into the portal with user "chatuser1" using the default password
    And I open the messaging window
    And I click the "Messaging On Call Tab" element
    And the "On Call Facility" pkdropdown should have exactly the following items and I select the "PKOnCall" option
      | GHDOHospital |
      | PKHospital   |
      | PKOnCall     |
      | All          |
      | SPOK         |

    Then look for the non-pk messaging user "Administrator On Call" "Kadmin, Perry" who is offering "Administrator" at the "PKOnCall" facility
    Then look for the pk messaging user "Hospitalist" "Donohue, Cathy" who is offering "Physician" at the "PKOnCall" facility
    Then look for the pk messaging user "Neurosurgery" "Dobbs, Daniel" who is offering "Physician" at the "PKOnCall" facility


  Scenario: Verify the information pop up for a user who is currently on call
    Given I am logged into the portal with user "chatuser1" using the default password
    And I open the messaging window
    And I click the "Messaging On Call Tab" element
    Then view information of the pk messaging user "Hospitalist" "Donohue, Cathy" who is offering "Physician" at the "PKOnCall" facility
    And verify the following information on the provider details popup for a messaging user "Donohue Cathy" with schedule type "Physician"
      | Name       | Donohue Cathy                                                   |
      | Specialty  | Neurology, Nuclear Medicine, Ophthalmology, Orthopaedic Surgery |
      | Facilities | GHDOHospital, PKOnCall, SPOK                                    |
    Then I click the "Close User Info Pop Up" element


  Scenario: Verify the information pop up for a user who is not currently on call
    Given I am logged into the portal with user "chatuser1" using the default password
    And I open the messaging window
    And I click the "Messaging On Call Tab" element
    Then view information of the non-pk messaging user "Administrator On Call" "Kadmin, Perry" who is offering "Administrator" at the "PKOnCall" facility
    And verify the following information on the provider details popup for a non messaging user "Kadmin Perry" with schedule type "Administrator"
      | Name       | Kadmin Perry |
      | Specialty  |              |
      | Facilities | GHDOHospital |
      | User Roles |              |
    Then I click the "Close User Info Pop Up" element

  Scenario: Verify the information pop up for a user who is not a local pk user
    Given I am logged into the portal with user "chatuser1" using the default password
    And I open the messaging window
    And I click the "Messaging On Call Tab" element
    Then view information of the non-pk messaging user "Cardiology" "Adams,Amy" who is offering "Physician" at the "PKOnCall" facility
    And verify the following information on the provider details popup for a non messaging user "Adams Amy" with schedule type "Physician"
      | Name       | Adams Amy |
      | Specialty  |           |
      | Facilities |           |
      | User Roles |           |
    Then I click the "Close User Info Pop Up" element

  Scenario: If a user is not is not associated with a facility then the "ON CALL" tab should not appear in the messaging window
    Given I am logged into the portal with user "chatuser4" using the default password
    And I open the messaging window
    Then the "Messaging On Call Tab" "MISC_ELEMENT" should not be visible
    
  Scenario: Check the audit log for on call message requests
    Given I am logged into the portal with user "chatuser1" using the default password
    And I open the messaging window
    And I click the "Messaging On Call Tab" element
    And start chat with the non-pk messaging user "Administrator On Call" "Kadmin, Perry" who is offering "Administrator" at the "PKOnCall" facility
    Then verify the on call chat request log using the info: "Administrator On Call - PKOnCall", "Administrator", "PKOnCall", "chatuser1", "Perry Kadmin", "true" and "false"
    And I click the "Close User Info Pop Up" element