Feature: BrowserSessionTest
  #Test for PR

  @BrowserSessionTest
  Scenario Outline: Patient Selection Test
    Given I am logged into the portal with user "<username>" and password "<password>"
    And I am on the "Patient List V2" tab
    And I select "Default Patient List" from the "Patient List" menu
    Given "Molly Darr" is on the patient list
    When I select patient "Molly Darr" from the patient list
    And I select "Orders" from clinical navigation
#		And I select "All" from the "Order Type" menu
    And I click the "Enter Orders" button
    And I click the "OK" button in the "Warning" pane if it exists
    When I click the "Add Order Cancel" button

    Examples:
      | username | password |
      | perf1    | PKco1997 |
      | perf2    | PKco1997 |
      | perf1    | PKco1997 |
      | perf2    | PKco1997 |
      | perf1    | PKco1997 |
      | perf2    | PKco1997 |
      | perf1    | PKco1997 |
      | perf2    | PKco1997 |
      | perf1    | PKco1997 |
      | perf2    | PKco1997 |

  @BrowserSessionTabTest
  Scenario Outline: Patient Selection Test With Tab
    Given I am logged into the portal with user "<username>" and password "<password>"
    And I start a network test in a new tab
    And I switch the focus to tab "1"
    And I am on the "Patient List V2" tab
    And I select "Default Patient List" from the "Patient List" menu
    Given "Molly Darr" is on the patient list
    When I select patient "Molly Darr" from the patient list
    And I select "Orders" from clinical navigation
    And I click the "Enter Orders" button
    And I click the "OK" button in the "Warning" pane if it exists
    When I click the "Add Order Cancel" button
    And I switch the focus to tab "2"
    And I stop the network test

    Examples:
      | username | password |
      | perf1    | PKco1997 |
      | perf2    | PKco1997 |
      | perf1    | PKco1997 |
      | perf2    | PKco1997 |
      | perf1    | PKco1997 |
      | perf2    | PKco1997 |
      | perf1    | PKco1997 |
      | perf2    | PKco1997 |
      | perf1    | PKco1997 |
      | perf2    | PKco1997 |

  @BrowserSessionTabPOC
  Scenario: tabs
    Given I am logged into the portal with user "pkadmin" and password "123"
    And I start a network test in a new tab
    And I switch the focus to tab "1"
    And I am on the "Patient List V2" tab
    And I select "Card Group" from the "Patient List" menu
    And I switch the focus to tab "2"
    And I stop the network test
    And I wait "10" seconds
