@Messaging

  Feature: Test the Result Notification portion of messaging

    Scenario: Clear the database of messages
      Given I am logged into the portal with user "chatuser1" using the default password
      And I delete all messages

      
    Scenario:  Create an order and subscribe to the result notification
      Given I am logged into the portal with user "chatuser1" using the default password
      And I am on the "PatientListV2" tab
      And "Evelyn Jones" is on the patient list
      And I select patient "Evelyn Jones" from the patient list
      And I select "Orders" from clinical navigation
      And I wait "5" seconds
      And I click the "Enter Orders" button
      And I wait "5" seconds
      And I select the order "CALCIUM  today" from the 'Favorites' list under 'Add Order'
      And I select "CALCIUM today" from the "New Orders" list in the search results
      Then verify the "Subscribe To Result Notification" checkbox is checked on the "PatientListV2" tab
      And I click the "EnterOrderOK" button
      When I enter "lab" in the "Add Order" field in the "Enter Orders" pane
      And I select "CBC today" in the "CPOE All Orders" table
      And I select "CBC today" from the "New Orders" list in the search results
      Then verify and toggle the "Subscribe To Result Notification" checkbox is unchecked on the "PatientListV2" tab
      And I click the "EnterOrderOK" button
      Then the following rows should appear in the "NewOrders" table
        | New Orders    |
        | CBC today     |
        | CALCIUM today |
      And I Submit the Orders
      Then I execute the query "Check Result Notification Status" "24" times with "10" seconds in between each call for a result set that has > "0" results using the search key "PENDING"
      Then I execute the query "Check Result Notification Status" "50" times with "3" seconds in between each call for a result set that has = "0" results using the search key "PENDING"
      Then I execute the query "Check Result Notification Status" "9" times with "10" seconds in between each call for a result set that has = "0" results using the search key "RESULTED"


    Scenario: Verify all buttons on the conversation screen are disabled
      Given I am logged into the portal with user "chatuser1" using the default password
      And I open the messaging window
      And I wait "1" second
      Then I click the "Messaging Name Tab" element
      And I wait "2" second
      Then I click the "New Result Message" element
      Then I confirm the message timestamp
      Then the "Add Image To Conversation Disabled" "MISC_ELEMENT" should be visible
      Then the "Start Patient Context Disabled" "MISC_ELEMENT" should be visible
      Then The "Message Input Area Path" "MISC_ELEMENT" should be disabled
      And I close the conversation
      And I open the messaging window
      And I wait "2" seconds
      Then the "Result Message" "MISC_ELEMENT" should be visible


    Scenario: Login as another user and make sure they did not receive a result notification since they did not subscribe
      Given I am logged into the portal with user "chatuser2" using the default password
      And I open the messaging window
      Then the "New Result Message" "MISC_ELEMENT" should not be visible


    Scenario: Verify the lab result messages for Evelyn Jones
      Given I am logged into the portal with user "chatuser1" using the default password
      And I can read messages from the user: "New" "Results"
      Then check the data in the result messages against the database for the user "Evelyn" "Jones" for the following tests
        | CBC     |
        | CALCIUM |


    Scenario: Add orders for another user
      Given I am logged into the portal with user "chatuser1" using the default password
      And I am on the "PatientListV2" tab
      And "Ricky Rony" is on the patient list
      And I select patient "Ricky Rony" from the patient list
      And I select "Orders" from clinical navigation
      And I click the "Enter Orders" button
      # There are 2 spaces between the order name and frequency
      And I select the order "CALCIUM  today" from the 'Favorites' list under 'Add Order'
      And I select the order "METABOLIC SCREEN STAT  today" from the 'Favorites' list under 'Add Order'
      Then the following rows should appear in the "NewOrders" table
        | New Orders                  |
        | CALCIUM today               |
        | METABOLIC SCREEN STAT today |
      And I Submit the Orders
      Then I execute the query "Check Result Notification Status" "24" times with "10" seconds in between each call for a result set that has > "0" results using the search key "PENDING"
      Then I execute the query "Check Result Notification Status" "50" times with "6" seconds in between each call for a result set that has = "0" results using the search key "PENDING"
      Then I execute the query "Check Result Notification Status" "9" times with "10" seconds in between each call for a result set that has = "0" results using the search key "RESULTED"


    Scenario: Verify the result messages for the second user
      Given I am logged into the portal with user "chatuser1" using the default password
      And I can read messages from the user: "New" "Results"
      Then check the data in the result messages against the database for the user "Evelyn" "Jones" for the following tests
        | CALCIUM               |
        | METABOLIC SCREEN STAT |


    Scenario: Make sure both patient context links appear in the same conversation
      Given I am logged into the portal with user "chatuser1" using the default password
      And I can read messages from the user: "New" "Results"
      Then I confirm the patient link for the patient "Evelyn" "Jones" appears in my current conversation
      Then I confirm the patient link for the patient "Ricky" "Rony" appears in my current conversation
      And I close the conversation


    Scenario: Check to make sure both sets of result messages appear in the same conversation
      Given I am logged into the portal with user "chatuser1" using the default password
      And I open the messaging window
      And I wait "2" seconds
      Then the "Result Message" xpath on the "" tab should return "1" element


    Scenario: Confirm that messages are marked as NEW RESULTS in the table pk_chatmessage
      Given I am logged into the portal with user "chatuser1" using the default password
      Then I execute the query "Number Of New Result Messages" "6" times with "5" seconds in between each call for a result set that has = "4" results using the search key ""


    # The order groups are hard coded so if new ones are added they need to be added to the examples
    Scenario Outline: Make sure that these order groups do not allow for subscription to notifications
      Given I am logged into the portal with user "pkadmin" using the default password
      And I am on the "Admin" tab
      And I select the "Facility Group" subtab
      And I click the "Order Groups" link in the "Facility Group Navigation" pane
      And I click the "Search" button in the "Order Groups" pane
      And I select "<OrderGroup>" in the "CPOE Order Groups Search Results" table
      Then the "OrderGroupsResultMessageSetting" "MISC_ELEMENT" should not be visible
      Examples:
        | OrderGroup          |
        | Diet Order Group    |
        | Med Rec Order Def   |
        | Medication          |
        | Nursing Order Group |


    Scenario Outline: Verify that the only order groups that have a setting to allow subscribing to an order
    to that order group are Lab Order Group, Other Order Group and Radiology Order Group
      Given I am logged into the portal with user "pkadmin" using the default password
      And I am on the "Admin" tab
      And I select the "Facility Group" subtab
      And I click the "Order Groups" link in the "Facility Group Navigation" pane
      And I click the "Search" button in the "Order Groups" pane
      And I select "<OrderGroup>" in the "CPOE Order Groups Search Results" table
      #Assumes that the the setting is set to Yes
      Then the text "Yes" should appear in the "Allow subscribing to alert when order resulted" field of the "Order Groups Settings Preview" table
      Examples:
        | OrderGroup            |
        | Lab Order Group       |
        | Other Order Group     |
        | Radiology Order Group |


    Scenario: Turn off New Result Notification and make sure you cannot subscribe to an order[DEV-74058]
      Given I am logged into the portal with user "pkadmin" using the default password
      And I am on the "Admin" tab
      And I select the "Institution" subtab
      And I select "Messaging" from the "Edit User Settings" dropdown
      And the "Messaging Settings" pane should load
      Then I uncheck the "New Result Notification" checkbox
      And I click the "Save" button
      And I click "OK" in the confirmation box


    Scenario: Check to make sure you cannot subscribe to result notifications if new result notification is turned off in institution settings[DEV-74058]
      Given I am logged into the portal with user "chatuser1" using the default password
      And I am on the "PatientListV2" tab
      And "Evelyn Jones" is on the patient list
      And I select patient "Evelyn Jones" from the patient list
      And I select "Orders" from clinical navigation
      And I click the "Enter Orders" button
      # There are 2 spaces between the order name and frequency
      When I enter "lab" in the "Add Order" field in the "Enter Orders" pane
      And the "CPOE All Orders" table should load
      And I select "AMMONIA" in the "CPOE All Orders" table
      And I select "AMMONIA" from the "New Orders" list in the search results
      Then the "Subscribe To Result Notification" "CHECKBOX" should not be visible
      And I click the "Edit Order Cancel" button


    Scenario Outline: If new result notifications is disabled institution wide check to make sure order groups do not have the setting to a allow
      for subscribing to result notifications[DEV-74058]
      Given I am logged into the portal with user "pkadmin" using the default password
      And I am on the "Admin" tab
      And I select the "Facility Group" subtab
      And I click the "Order Groups" link in the "Facility Group Navigation" pane
      And I click the "Search" button in the "Order Groups" pane
      And I select "<OrderGroup>" in the "CPOE Order Groups Search Results" table
      #The step below assumes that messaging is enabled institution wide and that order groups are enabled (set to "YES")
      Then the text "Yes" should not appear in the "Allow subscribing to alert when order resulted" field of the "Order Groups Settings Preview" table
      Examples:
        | OrderGroup            |
        | Lab Order Group       |
        | Other Order Group     |
        | Radiology Order Group |


    Scenario: Turn on new result notifications
      Given I am logged into the portal with user "pkadmin" using the default password
      And I am on the "Admin" tab
      And I select the "Institution" subtab
      And I select "Messaging" from the "Edit User Settings" dropdown
      And the "Messaging Settings" pane should load
      Then I check the "New Result Notification" checkbox
      And I click the "Save" button
      And I click "OK" in the confirmation box


    Scenario: DEV-68675:New CPOE Order Group property to enable and disable notification when order resulted
      Given I am logged into the portal with user "chatuser1" using the default password
      And I am on the "Admin" tab
      And I select the "Facility Group" subtab
      And I click the "Order Groups" link in the "Facility Group Navigation" pane
      And I click the "Search" button in the "Order Groups" pane
      And I select "Lab Order Group" in the "CPOE Order Groups Search Results" table
      When I click the "Edit CPOE Order Group" button
      And I select "false" from the "Allow Subscribing To Alert When Order Resulted" radio list
      And I click the "Order Group Save" button
      Then the text "No" should appear in the "Allow subscribing to alert when order resulted" field of the "Order Groups Settings Preview" table
      And I am on the "PatientListV2" tab
      And I select "Result Notification Sample" from the "Patient List" menu
      #Subscribe To Result Notification "CHECKBOX" will visible only for the "Evelyn Jones" patient
      And "Evelyn Jones" is on the patient list
      And I select patient "Evelyn Jones" from the patient list
      And I select "Orders" from clinical navigation
      And I click the "Enter Orders" button
      And I select the order "CALCIUM  today" from the 'Favorites' list under 'Add Order'
      And I select "CALCIUM today" from the "New Orders" list in the search results
      Then the "Subscribe To Result Notification" "CHECKBOX" should not be visible
      And I click the "Edit Order Cancel" button
      And I click the "AddOrderCancel" button
      And I click the "Yes" button in the "Question" pane if it exists
      And I am on the "Admin" tab
      And I select the "Facility Group" subtab
      And I click the "Order Groups" link in the "Facility Group Navigation" pane
      And I click the "Search" button in the "Order Groups" pane
      And I select "Lab Order Group" in the "CPOE Order Groups Search Results" table
      When I click the "Edit CPOE Order Group" button
      And I select "true" from the "Allow Subscribing To Alert When Order Resulted" radio list
      And I click the "Order Group Save" button
      Then the text "Yes" should appear in the "Allow subscribing to alert when order resulted" field of the "Order Groups Settings Preview" table
      And I am on the "PatientListV2" tab
      And "Evelyn Jones" is on the patient list
      And I select patient "Evelyn Jones" from the patient list
      And I select "Orders" from clinical navigation
      And I click the "Enter Orders" button
      And I select the order "CALCIUM  today" from the 'Favorites' list under 'Add Order'
      And I select "CALCIUM today" from the "New Orders" list in the search results
      Then the "Subscribe To Result Notification" "CHECKBOX" should be visible
      And I click the "Edit Order Cancel" button
      And I click the "AddOrderCancel" button
      And I click the "Yes" button in the "Question" pane if it exists




