Feature: Schedule Tab Regression
	
	Background:
		Given I am logged into the portal with user "pkadminv2" using the default password
		And I am on the "Admin" tab


	@CPMP
	Scenario Outline: Schedule Tab visit and charge view/edit access
		When I select the "User" subtab
		#And I search for the user "djones"
		Then the user "djones" should appear in the user list
		When I select the user "djones"
		And I click the "Edit" button in the "Quick Details" pane
		And I edit the following user settings and I click save
			|Page              |Type      |Name                           |Value 		    |
            |User Permissions  |radio     |Can Edit Other Users Charges   |<EditOtherUsers> |
            |Patient List	   |dropdown  |Scheduling Access  			  |<Scheduling>		|
            |Charge Capture	   |dropdown  |Set Charge Desktop View Access |<ChargeDesktop>	|
        And I click the "Return to Choose Users" link in the "Personal Preferences" pane
        #When I search for the user "nsmith"
		Then the user "nsmith" should appear in the user list
		When I select the user "nsmith"
		When I click the "Edit" button in the "Quick Details" pane
		When I edit the following user settings and I click save
			|Page              |Type      |Name                           |Value 		    |
            |User Permissions  |radio     |Can Edit Other Users Charges   |<EditOtherUsers> |
            |Patient List	   |dropdown  |Scheduling Access  			  |<Scheduling>		|
            |Charge Capture	   |dropdown  |Set Charge Desktop View Access |<ChargeDesktop>	|
        And I click the "Return to Choose Users" link in the "Personal Preferences" pane
        Given I am logged into the portal with user "djones" and password "123"
		When I am on the "Schedule" tab
		And I click the "Clear Criteria" button in the "Search Criteria" pane
		And I select "Today" from the "Date Filter" menu
		Then "<DJonesVisitList>" visits should display on the Schedule tab
		Then "<DJonesChargeViewList>" Charges should be viewable on the Schedule tab
		Then "<DJonesChargeEditList>" Charges should be editable on the Schedule tab
		Given I am logged into the portal with user "nsmith" and password "123"
		When I am on the "Schedule" tab
		And I click the "Clear Criteria" button in the "Search Criteria" pane
		And I select "Today" from the "Date Filter" menu
		Then "<NSmithVisitList>" visits should display on the Schedule tab
		Then "<NSmithChargeViewList>" Charges should be viewable on the Schedule tab
		Then "<NSmithChargeEditList>" Charges should be editable on the Schedule tab
		
		Examples:
			|EditOtherUsers|Scheduling|ChargeDesktop    |DJonesVisitList     |DJonesChargeViewList	  |DJonesChargeEditList|NSmithVisitList|NSmithChargeViewList|NSmithChargeEditList|
			|Yes           |User      |No Charges 		|2,1,3,4             |2,1A,3B,4C              |1A,3B,4C            |4,5            |4C,5D               |4C,5D               |