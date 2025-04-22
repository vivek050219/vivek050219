@Messaging
Feature: Scheduled Messages

  Scenario:Icon displays
    Given I am logged into the portal with user "chatuser2" using the default password
    And I can send messages to the user: "Chat" "Achatuser1"
    And I enter "Hello" in the "Message Input Area" field
    And I wait "2" seconds
    Then the "Scheduling Clock Icon" "MISC_ELEMENT" should be visible

  Scenario:Schedule Messages
    Given I am logged into the portal with user "chatuser2" using the default password
    And I can send messages to the user: "Chat" "Achatuser1"
    And I enter "Hello" in the "Message Input Area" field
    And I wait "2" seconds
    And I press the "BACKSPACE" key "5" times in the "Message Input Area" rich text field
    Then the "Scheduling Clock Icon" "MISC_ELEMENT" should not be visible


