@Schedule
  Feature: Hartford Co-Surgery Tab
  Scenarios for testing Hartford Co-Surgery under Scheduled tab.

    Scenario Outline: Adding charges to patients as per pre-requisite
      Given I am logged into the portal with user "<UserName>" and password "123"
      And I am on the "Patient List V2" tab
      And I use the API to create a patient list named "SCHEDULEPLV2" owned by "<UserName>" with the following parameters
        | Type   | Name              | Value      |
        | Filter | Medical Service   | Card Group |
      And I click the "Refresh Patient List" button
      And I select "SCHEDULEPLV2" from the "Patient List" menu
      And "<Patient>" is on the patient list
      And I select patient "<Patient>" from the patient list
      And I select "Visits" from clinical navigation
      Then the "Visits" table should load
      And I wait "3" seconds
      When I select "<BillingProv>" from the "Provider" column in the "Visits" table
      And I click the "Add Charge to this Visit" button in the "Visit Detail" pane
      And I wait "3" seconds
      And I set the following charge headers
        |Name         |Value         |
        |Bill Area    |scheduledeptA |
        |Billing Prov |<BillingProv> |
        |Svc Site     |Outpatient    |
      And I enter the ICD-10 code "<ICD Code>"
      And I enter the CPT code "<CPT Code>"
      And I click the "Submit" button
      And I click the "Save As Is" button in the "Confirm" pane if it exists

      
    Examples:
      |UserName     |Patient         |BillingProv     |ICD Code  |CPT Code  |
      |drjoneshf    |TEST SCHEDULE-8 |JONESHF, DOCTOR |B65.0     |31040     |
      |drjoneshf    |TEST SCHEDULE-9 |JONESHF, DOCTOR |B65.0     |31040     |
      |drsmithhf    |TEST SCHEDULE-8 |SMITHHF, DOCTOR |B65.0     |31040     |
      |drsmithhf    |TEST SCHEDULE-10|SMITHHF, DOCTOR |B36.0     |86000     |

    Scenario Outline: Scheduled tab charges validation for Hartford Co-Surgery when selected provider is Jones and Smith,Edit User (Yes/No)
      Given I am logged into the portal with user "scadmin" and password "123"
      When I am on the "Admin" tab
      And I open "Patient List" settings page for the user "<Selected User>"
      And I edit the following user settings and I click save
        |Page             |Name                         |Type     |Value                      |
        |Patient List     |Scheduling Access            |dropdown |<Scheduling Access Value>  |
        |Charge Capture   |Charge Desktop View Access   |dropdown |<Charge Access Value>      |
        |User Permissions |Can Edit Other Users Charges |radio    |<CheckBox Value>           |
      Given I am logged into the portal with user "<Selected User>" and password "123"
      And I am on the "Schedule" tab
      And I wait "5" seconds
      When I click the "Clear Criteria" button in the "Search Criteria" pane
      And I click the "Delete Entry" image in the "Provider Search" pane if it exists
      And I select "Today" from the "Date Filter" menu
      And I enter "Diab Service" in the "Services" field
      And I click the "Service Search" button in the "Search Criteria" pane
      And I select "Billing or Scheduled" from the "Provider Type" dropdown
      And I enter "<BillingProv>" in the "Providers" field
      And I click the "Provider Search" button in the "Search Criteria" pane
      Then the following visits should appear in the scheduled tab
        |SCHEDULE-8, TEST  |
        |SCHEDULE-9, TEST  |
        |SCHEDULE-10, TEST |
      Then the charge should be editable for the "<visitName1>" visit in the scheduled tab
      Then the charge should be editable for the "<visitName2>" visit in the scheduled tab

    Examples:
      |Selected User  |Scheduling Access Value   |Charge Access Value   |CheckBox Value  |BillingProv         |visitName1       |visitName2        |
      |drjoneshf      |User                      |No Other Charges      |Yes             |JONESHF, DOCTOR     |SCHEDULE-8, TEST |SCHEDULE-9, TEST  |
      |drjoneshf      |User                      |No Other Charges      |No              |JONESHF, DOCTOR     |SCHEDULE-8, TEST |SCHEDULE-9, TEST  |
      |drjoneshf      |Department                |No Other Charges      |No              |JONESHF, DOCTOR     |SCHEDULE-8, TEST |SCHEDULE-9, TEST  |
      |drsmithhf      |User                      |No Other Charges      |Yes             |SMITHHF, DOCTOR     |SCHEDULE-8, TEST |SCHEDULE-10, TEST |
      |drsmithhf      |User                      |No Other Charges      |No              |SMITHHF, DOCTOR     |SCHEDULE-8, TEST |SCHEDULE-10, TEST |
      |drsmithhf      |Department                |No Other Charges      |No              |SMITHHF, DOCTOR     |SCHEDULE-8, TEST |SCHEDULE-10, TEST |

    Scenario Outline: Scheduled tab charges validation when selected provider is Jones and Smith,Scheduling access,Charge desktop Access and Edit User setting changed
      Given I am logged into the portal with user "scadmin" and password "123"
      When I am on the "Admin" tab
      And I open "Patient List" settings page for the user "<Selected User>"
      And I edit the following user settings and I click save
        |Page             |Name                           |Type     |Value                        |
        |Patient List     |Scheduling Access              |dropdown |<Scheduling Access Value>    |
        |Charge Capture   |Charge Desktop View Access     |dropdown |<Charge Access Value>        |
        |User Permissions |Can Edit Other Users Charges   |radio    |<Edit User Value>            |
      Given I am logged into the portal with user "<Selected User>" and password "123"
      And I am on the "Schedule" tab
      And I wait "3" seconds
      When I click the "Clear Criteria" button in the "Search Criteria" pane
      And I click the "Delete Entry" image in the "Provider Search" pane if it exists
      And I select "Today" from the "Date Filter" menu
	  And I enter "JONESHF, DOCTOR" in the "Providers" field
      And I click the "Provider Search" button in the "Search Criteria" pane
      And I select "Billing or Scheduled" from the "Provider Type" dropdown
	  Then the charge should be editable for the "SCHEDULE-8, TEST" visit in the scheduled tab
      And  the charge should be editable for the "SCHEDULE-9, TEST" visit in the scheduled tab
	  And  the charge should be viewable with "Not Coded Outpatient" for the "SCHEDULE-10, TEST" visit in the scheduled tab
      And I enter "Diab Service" in the "Services" field
      And I click the "Service Search" button in the "Search Criteria" pane
	  When I enter "SMITHHF, DOCTOR" in the "Providers" field
      And I click the "Provider Search" button in the "Search Criteria" pane
	  Then the charge should be editable for the "SCHEDULE-8, TEST" visit in the scheduled tab
      And the charge should be editable for the "SCHEDULE-10, TEST" visit in the scheduled tab
	  And the charge should be viewable with "Not Coded Outpatient" for the "SCHEDULE-9, TEST" visit in the scheduled tab
      And I enter "JONESHF, DOCTOR" in the "Providers" field
      And I click the "Provider Search" button in the "Search Criteria" pane
      Then the following visits should appear in the scheduled tab
        |SCHEDULE-8, TEST  |
        |SCHEDULE-9, TEST  |
        |SCHEDULE-10, TEST |
        |SCHEDULE-10, TEST |
    Examples:
      |Selected User   |Scheduling Access Value |Charge Access Value                |Edit User Value  |
      |drjoneshf       |Department              |Within the User's Department       |Yes              |
      |drjoneshf       |All                     |All Charges                        |Yes              |

    Scenario Outline: Scheduled tab charges validation when selected provider is smith and Jones,Scheduling access,Charge desktop Access and Edit User setting changed
      Given I am logged into the portal with user "scadmin" and password "123"
      When I am on the "Admin" tab
      And I open "Patient List" settings page for the user "<Selected User>"
      And I edit the following user settings and I click save
        |Page             |Name                                       |Type     |Value                        |
        |Patient List     |Scheduling Access                          |dropdown |<Scheduling Access Value>    |
        |Charge Capture   |Charge Desktop View Access                 |dropdown |<Charge Access Value>        |
        |User Permissions |Can Edit Other Users Charges               |radio    |<Edit User Value>            |
      Given I am logged into the portal with user "<Selected User>" and password "123"
      And I am on the "Schedule" tab
      When I click the "Clear Criteria" button in the "Search Criteria" pane
      And I click the "Delete Entry" image in the "Provider Search" pane if it exists
      And I select "Today" from the "Date Filter" menu
      And I enter "Diab Service" in the "Services" field
      And I click the "Service Search" button in the "Search Criteria" pane
      And I select "Billing or Scheduled" from the "Provider Type" dropdown
	  And I enter "SMITHHF, DOCTOR" in the "Providers" field
      And I click the "Provider Search" button in the "Search Criteria" pane
	  Then the charge should be editable for the "SCHEDULE-8, TEST" visit in the scheduled tab
      And the charge should be editable for the "SCHEDULE-10, TEST" visit in the scheduled tab
      And the charge should be viewable with "Not Coded Outpatient" for the "SCHEDULE-9, TEST" visit in the scheduled tab
      When I enter "JONESHF, DOCTOR" in the "Providers" field
      And I click the "Provider Search" button in the "Search Criteria" pane
	  Then the charge should be editable for the "SCHEDULE-8, TEST" visit in the scheduled tab
      And the charge should be editable for the "SCHEDULE-9, TEST" visit in the scheduled tab
      And the charge should be viewable with "Not Coded Outpatient" for the "SCHEDULE-10, TEST" visit in the scheduled tab
      And I enter "SMITHHF, DOCTOR" in the "Providers" field
      And I click the "Provider Search" button in the "Search Criteria" pane
      Then the following visits should appear in the scheduled tab
        |SCHEDULE-8, TEST  |
        |SCHEDULE-9, TEST  |
        |SCHEDULE-10, TEST |

    Examples:
      |Selected User   |Scheduling Access Value |Charge Access Value                |Edit User Value  |
      |drsmithhf       |Department              |Within the User's Department       |Yes              |
      |drsmithhf       |All                     |All Charges                        |Yes              |

    Scenario: Scheduled tab charges validation when selected provider is jones, with scheduling access "All" and Charges Desktop "Within the User's Department"
      Given I am logged into the portal with user "scadmin" and password "123"
      When I am on the "Admin" tab
      And I open "Patient List" settings page for the user "drjoneshf"
      And I edit the following user settings and I click save
        |Page             |Name                                       |Type     |Value                        |
        |Patient List     |Scheduling Access                          |dropdown |All                          |
        |Charge Capture   |Charge Desktop View Access                 |dropdown |Within the User's Department |
        |User Permissions |Can Edit Other Users Charges               |radio    |No                           |
      Given I am logged into the portal with user "drjoneshf" and password "123"
      And I am on the "Schedule" tab
      And I wait "3" seconds
      When I click the "Clear Criteria" button in the "Search Criteria" pane
      And I click the "Delete Entry" image in the "Provider Search" pane if it exists
      And I select "Today" from the "Date Filter" menu
      And I enter "Diab Service" in the "Services" field
      And I click the "Service Search" button in the "Search Criteria" pane
	  When I enter "JONESHF, DOCTOR" in the "Providers" field
      And I click the "Provider Search" button in the "Search Criteria" pane
      And I select "Billing or Scheduled" from the "Provider Type" dropdown
      Then the charge should be editable for the "SCHEDULE-8, TEST" visit in the scheduled tab
      And the charge should be editable for the "SCHEDULE-9, TEST" visit in the scheduled tab
	  And the charge should be viewable with "Not Coded Outpatient" for the "SCHEDULE-10, TEST" visit in the scheduled tab
      When I enter "SMITHHF, DOCTOR" in the "Providers" field
      And I click the "Provider Search" button in the "Search Criteria" pane
      Then the charge should be viewable for the "SCHEDULE-8, TEST" visit in the scheduled tab
	  And the charge should be viewable for the "SCHEDULE-10, TEST" visit in the scheduled tab
      Then the charge should be viewable with "Not Coded Outpatient" for the "SCHEDULE-9, TEST" visit in the scheduled tab
      When I enter "JONESHF, DOCTOR" in the "Providers" field
      And I click the "Provider Search" button in the "Search Criteria" pane
      Then the following visits should appear in the scheduled tab
        |SCHEDULE-8, TEST  |
        |SCHEDULE-9, TEST  |
        |SCHEDULE-10, TEST |


    Scenario: Scheduled tab charges validation when selected provider is smith, with scheduling access "All" and Charges Desktop "Within the User's Department"
      Given I am logged into the portal with user "scadmin" and password "123"
      When I am on the "Admin" tab
      And I open "Patient List" settings page for the user "drsmithhf"
      And I edit the following user settings and I click save
        |Page             |Name                                       |Type     |Value                        |
        |Patient List     |Scheduling Access                          |dropdown |All                          |
        |Charge Capture   |Charge Desktop View Access                 |dropdown |Within the User's Department |
        |User Permissions |Can Edit Other Users Charges               |radio    |No                           |
      Given I am logged into the portal with user "drsmithhf" and password "123"
      And I am on the "Schedule" tab
      And I wait "3" seconds
      When I click the "Clear Criteria" button in the "Search Criteria" pane
      And I click the "Delete Entry" image in the "Provider Search" pane if it exists
      And I select "Today" from the "Date Filter" menu
      And I enter "Diab Service" in the "Services" field
      And I click the "Service Search" button in the "Search Criteria" pane
      And I select "Billing or Scheduled" from the "Provider Type" dropdown
	  And I enter "SMITHHF, DOCTOR" in the "Providers" field
      And I click the "Provider Search" button in the "Search Criteria" pane
	  Then the charge should be editable for the "SCHEDULE-8, TEST" visit in the scheduled tab
      And the charge should be editable for the "SCHEDULE-10, TEST" visit in the scheduled tab
	  And the charge should be viewable with "Not Coded Outpatient" for the "SCHEDULE-9, TEST" visit in the scheduled tab
      When I enter "JONESHF, DOCTOR" in the "Providers" field
      And I click the "Provider Search" button in the "Search Criteria" pane
	  Then the charge should be viewable for the "SCHEDULE-8, TEST" visit in the scheduled tab
	  And the charge should be viewable for the "SCHEDULE-9, TEST" visit in the scheduled tab
	  And the charge should be viewable with "Not Coded Outpatient" for the "SCHEDULE-10, TEST" visit in the scheduled tab
      And I enter "SMITHHF, DOCTOR" in the "Providers" field
      And I click the "Provider Search" button in the "Search Criteria" pane
      Then the following visits should appear in the scheduled tab
        |SCHEDULE-8, TEST  |
        |SCHEDULE-9, TEST  |
        |SCHEDULE-10, TEST |