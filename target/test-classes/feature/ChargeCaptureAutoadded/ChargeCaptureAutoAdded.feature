@ChargeCaptureAA
Feature: Auto added CPT validation

  Scenario: Turn off all codeedits on user server
    Given I am logged into the portal with user "pkadmin" using the default password
    #And I turn "off" all codeedits on "server"
    And I am on the "PatientListV2" tab
    And I execute the "Disable All Code Edits" query

  Scenario Outline: Validate auto added CPT  with master CPT user level1 with copy MD modifier yes

    Given I am logged into the portal with user "ccuser1" and password "123"
    And I am on the "PatientListV2" tab
    And "Molly Darr" is on the patient list
    And patient "Molly Darr" has no charges
    And I select patient "Molly Darr" from the patient list
    When I click the "Charges+" button
    And I wait "3" seconds
    And I set the following charge headers
      |Name          |Value     |
      |Bill Area     |Cardiology|
      |Svc Site      |<SvcSite> |
    And I enter the ICD-10 code "B65.0"
    And I enter the CPT code "<CPT>"
    And I click the "Submit" button
    And I click the "Save As Is" button in the "Confirm" pane if it exists
    Then the "Charges" table should load
    Then the "Charges" table should have at least "1" row containing the text "<Auto added>"
    Examples:
      |SvcSite   |CPT  |Auto added       |
      |Outpatient|93289|540793289 (A) add|
      |Inpatient |93289|540793289 (A) add|
      |ER        |93289|540793289 (A) add|
      |Outpatient|92312|540793290 (A) add|
      |Inpatient |92312|540793290 (A) add|
      |ER        |92312|540793290 (A) add|
      |Outpatient|92311|540792388 (A) add|
      |Inpatient |92311|540792388 (A) add|
      |ER        |92311|540792388 (A) add|

  Scenario Outline: Validate auto added CPT  with master CPT user level1 with modifier

    Given I am logged into the portal with user "ccuser1" and password "123"
    And I am on the "PatientListV2" tab
    And "Molly Darr" is on the patient list
    And patient "Molly Darr" has no charges
    And I select patient "Molly Darr" from the patient list
    When I click the "Charges+" button
    And I wait "3" seconds
    And I set the following charge headers
      |Name         |Value     |
      |Bill Area    |Cardiology|
      |Svc Site     |<SvcSite> |
    And I enter the ICD-10 code "B65.0"
    And I enter the CPT code "19316"
    And I click the "Submit" button
    And I click the "Save As Is" button in the "Confirm" pane if it exists
    Then the "Charges" table should have at least "1" row containing the text "540719311 (A) add"

    Examples:
      |SvcSite   |
      |Outpatient|
      |Inpatient |
      |ER        |

  Scenario Outline: Validate auto added CPT  with master CPT user level1 with copy MD modifier no

    Given I am logged into the portal with user "ccuser1" and password "123"
    And I am on the "PatientListV2" tab
    And "Molly Darr" is on the patient list
    And patient "Molly Darr" has no charges
    And I select patient "Molly Darr" from the patient list
    When I click the "Charges+" button
    And I wait "3" seconds
    And I set the following charge headers
      |Name         |Value     |
      |Bill Area    |Cardiology|
      |Svc Site     |<SvcSite> |
    And I enter the ICD-10 code "B65.0"
    And I enter the CPT code "95962"
    And I click the "Submit" button
    And I click the "Save As Is" button in the "Confirm" pane if it exists
    Then the "Charges" table should have at least "1" row containing the text "540793290 (A) add"

    Examples:
      |SvcSite   |
      |Outpatient|
      |Inpatient |
      |ER        |

  Scenario Outline: Validate auto added CPT  with master CPT user level1-svc site(outpatient)

    Given I am logged into the portal with user "ccuser1" and password "123"
    And I am on the "PatientListV2" tab
    And "Molly Darr" is on the patient list
    And patient "Molly Darr" has no charges
    And I select patient "Molly Darr" from the patient list
    When I click the "Charges+" button
    And I wait "3" seconds
    And I set the following charge headers
      |Name         |Value      |
      |Bill Area    |Hospitalist|
      |Svc Site     | Outpatient|
    And I enter the ICD-10 code "B65.0"
    And I enter the CPT code "<CPT>"
    And I click the "Submit" button
    And I click the "Save As Is" button in the "Confirm" pane if it exists
    Then the "Charges" table should have at least "1" row containing the text "<Auto added>"

    Examples:
      |CPT   |Auto added                            |
      |90680 |90471 (A) immunization admin          |
      |90715 |90461 (A) inadm any route addl vac/tox|

  Scenario Outline: Validate auto added CPT  with master CPT user level1-svc site(All)

    Given I am logged into the portal with user "ccuser1" and password "123"
    And I am on the "Patient ListV2" tab
    And "Molly Darr" is on the patient list
    And patient "Molly Darr" has no charges
    And I select patient "Molly Darr" from the patient list
    When I click the "Charges+" button
    And I wait "3" seconds
    And I set the following charge headers
      |Name         |Value     |
      |Bill Area    |<BillArea>|
      |Svc Site     |<SvcSite> |
    And I enter the ICD-10 code "B65.0"
    And I enter the CPT code "59020"
    And I click the "Submit" button
    And I click the "Save As Is" button in the "Confirm" pane if it exists
#    Then the following rows should appear in the "Charges" table
#      |Proc|
#      |59020 (A) fetal contract stress test|
    Then the "Charges" table should have at least "1" row containing the text "<Auto added>"

    Examples:
      |SvcSite    |BillArea   |Auto added                            |
      |Outpatient |Cardiology |59020 (A) fetal contract stress test  |
      |Inpatient  |Hospitalist|59020 (A) fetal contract stress test  |
      |ER         |Neurology  |59020 (A) fetal contract stress test  |

  Scenario Outline: Validate auto added CPT  with master CPT user level1 with auto-added modifier

    Given I am logged into the portal with user "ccuser1" and password "123"
    And I am on the "PatientListV2" tab
    And "Molly Darr" is on the patient list
    And patient "Molly Darr" has no charges
    And I select patient "Molly Darr" from the patient list
    When I click the "Charges+" button
    And I wait "3" seconds
    And I set the following charge headers
      |Name         |Value       |
      |Bill Area    |Cardiology  |
      |Svc Site     |<SvcSite>   |
    And I enter the ICD-10 code "B65.0"
    And I enter the CPT code "92978"
    And I click the "Submit" button
    And I click the "Save As Is" button in the "Confirm" pane if it exists
    Then the following rows should appear in the "Charges" table
      |Proc                                |
      |92978 intravasc us heart add-on     |
    Examples:
      |SvcSite   |
      |Outpatient|
      |Inpatient |
      |ER        |

  Scenario Outline: Validate auto added CPT  with master CPT user level2 with copy MD modifier yes

    Given I am logged into the portal with user "ccuser2" and password "123"
    And I am on the "PatientListV2" tab
    And "Mona Angeline" is on the patient list
    And patient "Mona Angeline" has no charges
    And I select patient "Mona Angeline" from the patient list
    When I click the "Charges+" button
    And I wait "3" seconds
    And I set the following charge headers
      |Name          |Value     |
      |Bill Area     |Cardiology|
      |Svc Site      |<SvcSite> |
    And I enter the ICD-10 code "B65.0"
    And I enter the CPT code "<CPT>"
    And I click the "Submit" button
    And I click the "Save As Is" button in the "Confirm" pane if it exists
    Then the "Charges" table should load
    Then the "Charges" table should have at least "1" row containing the text "<Auto added>"
    Examples:
      |SvcSite   |CPT  |Auto added       |
      |Outpatient|93289|540793289 (A) add|
      |Inpatient |93289|540793289 (A) add|
      |ER        |93289|540793289 (A) add|
      |Outpatient|92312|540793290 (A) add|
      |Inpatient |92312|540793290 (A) add|
      |ER        |92312|540793290 (A) add|
      |Outpatient|92311|540792388 (A) add|
      |Inpatient |92311|540792388 (A) add|
      |ER        |92311|540792388 (A) add|

  Scenario Outline: Validate auto added CPT  with master CPT user level2 with modifier

    Given I am logged into the portal with user "ccuser2" and password "123"
    And I am on the "PatientListV2" tab
    And "Mona Angeline" is on the patient list
    And patient "Mona Angeline" has no charges
    And I select patient "Mona Angeline" from the patient list
    When I click the "Charges+" button
    And I wait "3" seconds
    And I set the following charge headers
      |Name         |Value     |
      |Bill Area    |Cardiology|
      |Svc Site     |<SvcSite> |
    And I enter the ICD-10 code "B65.0"
    And I enter the CPT code "19316"
    And I click the "Submit" button
    And I click the "Save As Is" button in the "Confirm" pane if it exists
    Then the "Charges" table should have at least "1" row containing the text "540719311 (A) add"

    Examples:
      |SvcSite   |
      |Outpatient|
      |Inpatient |
      |ER        |

  Scenario Outline: Validate auto added CPT  with master CPT user level2 with copy MD modifier no

    Given I am logged into the portal with user "ccuser2" and password "123"
    And I am on the "PatientListV2" tab
    And "Mona Angeline" is on the patient list
    And patient "Mona Angeline" has no charges
    And I select patient "Mona Angeline" from the patient list
    When I click the "Charges+" button
    And I wait "3" seconds
    And I set the following charge headers
      |Name         |Value     |
      |Bill Area    |Cardiology|
      |Svc Site     |<SvcSite> |
    And I enter the ICD-10 code "B65.0"
    And I enter the CPT code "95933"
    And I click the "Submit" button
    And I click the "Save As Is" button in the "Confirm" pane if it exists
    Then the "Charges" table should have at least "1" row containing the text "540793289 (A) add"

    Examples:
      |SvcSite   |
      |Outpatient|
      |Inpatient |
      |ER        |

  Scenario Outline: Validate auto added CPT  with master CPT user level2-svc site(outpatient)

    Given I am logged into the portal with user "ccuser2" and password "123"
    And I am on the "PatientListV2" tab
    And "Mona Angeline" is on the patient list
    And patient "Mona Angeline" has no charges
    And I select patient "Mona Angeline" from the patient list
    When I click the "Charges+" button
    And I wait "3" seconds
    And I set the following charge headers
      |Name         |Value      |
      |Bill Area    |Hospitalist|
      |Svc Site     | Outpatient|
    And I enter the ICD-10 code "B65.0"
    And I enter the CPT code "<CPT>"
    And I click the "Submit" button
    And I click the "Save As Is" button in the "Confirm" pane if it exists
    Then the "Charges" table should have at least "1" row containing the text "<Auto added>"

    Examples:
      |CPT   |Auto added|
      |90680 |90471     |
      |90715 |90461     |

  Scenario Outline: Validate auto added CPT  with master CPT user level2-svc site(All)

    Given I am logged into the portal with user "ccuser2" and password "123"
    And I am on the "Patient ListV2" tab
    And "Mona Angeline" is on the patient list
    And patient "Mona Angeline" has no charges
    And I select patient "Mona Angeline" from the patient list
    When I click the "Charges+" button
    And I wait "3" seconds
    And I set the following charge headers
      |Name         |Value     |
      |Bill Area    |<BillArea>|
      |Svc Site     |<SvcSite> |
    And I enter the ICD-10 code "B65.0"
    And I enter the CPT code "59020"
    And I click the "Submit" button
    And I click the "Save As Is" button in the "Confirm" pane if it exists
    Then the "Charges" table should have at least "1" row containing the text "<Auto added>"
#    Then the following rows should appear in the "Charges" table
#      |Proc                                 |
#      |59020 (A) fetal contract stress test |

    Examples:
      |SvcSite    |BillArea   |Auto added                            |
      |Outpatient |Cardiology |59020 (A) fetal contract stress test  |
      |Inpatient  |Hospitalist|59020 (A) fetal contract stress test  |
      |ER         |Neurology  |59020 (A) fetal contract stress test  |


  Scenario Outline: Validate auto added CPT  with master CPT user2(2nd) with Auto-added modifier

    Given I am logged into the portal with user "ccuser2" and password "123"
    And I am on the "PatientListV2" tab
    And "Mona Angeline" is on the patient list
    And patient "Mona Angeline" has no charges
    And I select patient "Mona Angeline" from the patient list
    When I click the "Charges+" button
    And I wait "3" seconds
    And I set the following charge headers
      |Name         |Value     |
      |Bill Area    |Cardiology|
      |Svc Site     |<SvcSite> |
    And I enter the ICD-10 code "B65.0"
    And I enter the CPT code "92978"
    And I click the "Submit" button
    And I click the "Save As Is" button in the "Confirm" pane if it exists
    Then the following rows should appear in the "Charges" table
      |Proc                                |
      |92978 intravasc us heart add-on     |


    Examples:
      |SvcSite   |
      |Outpatient|
      |Inpatient |
      |ER        |

  Scenario: Enable Auto-Added Display settings

    Given I am logged into the portal with user "pkadmin" using the default password
    And I am on the "Admin" tab
    And I select the "User" subtab
    And I open "Charge Capture" settings page for the user "ccuser3"
    And I edit the following user settings and I click save
      |Page           |Name                 |Type  |Value |
      |Charge Capture |ShowAutoAddedCharges |radio |true  |
#    And I click "OK" in the confirmation box

  Scenario Outline: Validate auto added CPT  with master CPT user level3 and auto-added display= Yes with copy MD modifiers =Yes

    Given I am logged into the portal with user "ccuser3" and password "123"
    And I am on the "PatientListV2" tab
    And "Neil Heath" is on the patient list
    And patient "Neil Heath" has no charges
    And I select patient "Neil Heath" from the patient list
    When I click the "Charges+" button
    And I wait "3" seconds
    And I set the following charge headers
      |Name          |Value     |
      |Bill Area     |Cardiology|
      |Svc Site      |<SvcSite> |
    And I enter the ICD-10 code "B65.0"
    And I enter the CPT code "<CPT>"
    And I click the "Submit" button
    And I click the "Save As Is" button in the "Confirm" pane if it exists
#    Then the "Charges" table should load
    Then the "Charges" table should have at least "1" row containing the text "<Auto added>"
    Examples:
      |SvcSite   |CPT  |Auto added       |
      |Outpatient|93289|540793289 (A) add|
      |Inpatient |93289|540793289 (A) add|
      |ER        |93289|540793289 (A) add|
      |Outpatient|92312|540793290 (A) add|
      |Inpatient |92312|540793290 (A) add|
      |ER        |92312|540793290 (A) add|
      |Outpatient|92311|540792388 (A) add|
      |Inpatient |92311|540792388 (A) add|
      |ER        |92311|540792388 (A) add|

  Scenario Outline: Validate auto added CPT  with master CPT user level3 and auto-added display= Yes with modifier

    Given I am logged into the portal with user "ccuser3" and password "123"
    And I am on the "PatientListV2" tab
    And "Neil Heath" is on the patient list
    And patient "Neil Heath" has no charges
    And I select patient "Neil Heath" from the patient list
    When I click the "Charges+" button
    And I wait "3" seconds
    And I set the following charge headers
      |Name         |Value     |
      |Bill Area    |Cardiology|
      |Svc Site     |<SvcSite> |
    And I enter the ICD-10 code "B65.0"
    And I enter the CPT code "19316"
    And I click the "Submit" button
    And I click the "Save As Is" button in the "Confirm" pane if it exists
    Then the "Charges" table should have at least "1" row containing the text "540719311 (A) add"

    Examples:
      |SvcSite   |
      |Outpatient|
      |Inpatient |
      |ER        |

  Scenario Outline: Validate auto added CPT  with master CPT user level3 and auto-added display= Yes with copy MD modifier= No

    Given I am logged into the portal with user "ccuser3" and password "123"
    And I am on the "PatientListV2" tab
    And "Neil Heath" is on the patient list
    And patient "Neil Heath" has no charges
    And I select patient "Neil Heath" from the patient list
    When I click the "Charges+" button
    And I wait "3" seconds
    And I set the following charge headers
      |Name         |Value     |
      |Bill Area    |Cardiology|
      |Svc Site     |<SvcSite> |
    And I enter the ICD-10 code "B65.0"
    And I enter the CPT code "95933"
    And I click the "Submit" button
    And I click the "Save As Is" button in the "Confirm" pane if it exists
    Then the "Charges" table should have at least "1" row containing the text "540793289 (A) add"

    Examples:
      |SvcSite   |
      |Outpatient|
      |Inpatient |
      |ER        |

  Scenario Outline: Validate auto added CPT  with master CPT user level3-svc site(outpatient) and Auto-Added Display= Yes

    Given I am logged into the portal with user "ccuser3" and password "123"
    And I am on the "PatientListV2" tab
    And "Neil Heath" is on the patient list
    And patient "Neil Heath" has no charges
    And I select patient "Neil Heath" from the patient list
    When I click the "Charges+" button
    And I wait "3" seconds
    And I set the following charge headers
      |Name         |Value      |
      |Bill Area    |Hospitalist|
      |Svc Site     |Outpatient |
    And I enter the ICD-10 code "B65.0"
    And I enter the CPT code "<CPT>"
    And I click the "Submit" button
    And I click the "Save As Is" button in the "Confirm" pane if it exists
    Then the "Charges" table should have at least "1" row containing the text "<Auto added>"

    Examples:
      |CPT   |Auto added|
      |90680 |90471     |
      |90715 |90461     |

  Scenario Outline: Validate auto added CPT  with master CPT user level3-svc site(All)and auto-added display= Yes

    Given I am logged into the portal with user "ccuser3" and password "123"
    And I am on the "Patient ListV2" tab
    And "Neil Heath" is on the patient list
    And patient "Neil Heath" has no charges
    And I select patient "Neil Heath" from the patient list
    When I click the "Charges+" button
    And I wait "3" seconds
    And I set the following charge headers
      |Name         |Value     |
      |Bill Area    |<BillArea>|
      |Svc Site     |<SvcSite> |
    And I enter the ICD-10 code "B65.0"
    And I enter the CPT code "59020"
    And I click the "Submit" button
    And I click the "Save As Is" button in the "Confirm" pane if it exists
#    Then the following rows should appear in the "Charges" table
#      |Proc                                 |
#      |59020 fetal contract stress test - 26|
    Then the "Charges" table should have at least "1" row containing the text "<Auto added>"
    Examples:
      |SvcSite    |BillArea   |Auto added                            |
      |Outpatient |Cardiology |59020 (A) fetal contract stress test  |
      |Inpatient  |Hospitalist|59020 (A) fetal contract stress test  |
      |ER         |Neurology  |59020 (A) fetal contract stress test  |

  Scenario Outline: Validate auto added CPT  with master CPT user level3 and auto-added display= Yes with auto-added modifier

    Given I am logged into the portal with user "ccuser3" and password "123"
    And I am on the "PatientListV2" tab
    And "Neil Heath" is on the patient list
    And patient "Neil Heath" has no charges
    And I select patient "Neil Heath" from the patient list
    When I click the "Charges+" button
    And I wait "3" seconds
    And I set the following charge headers
      |Name         |Value     |
      |Bill Area    |Cardiology|
      |Svc Site     |<SvcSite> |
    And I enter the ICD-10 code "B65.0"
    And I enter the CPT code "92978"
    And I click the "Submit" button
    And I click the "Save As Is" button in the "Confirm" pane if it exists
    Then the following rows should appear in the "Charges" table
      |Proc                                |
      |92978 intravasc us heart add-on     |

    Examples:
      |SvcSite   |
      |Outpatient|
      |Inpatient |
      |ER        |

    # for level 3 user all the auto coded charges are not displayed as Show Auto Added Codes is No. But when logged in as level1 user and checked the same transaction the auto added codes are displayed as expected for the above scenarios.


  Scenario: Disable Auto-Added Display settings

    Given I am logged into the portal with user "pkadmin" using the default password
    And I am on the "Admin" tab
    And I select the "User" subtab
    And I open "Charge Capture" settings page for the user "ccuser3"
    And I edit the following user settings and I click save
      |Page           |Name                 |Type  |Value |
      |Charge Capture |ShowAutoAddedCharges |radio |false |

#    And I click "OK" in the confirmation box

  Scenario Outline: Validate auto added CPT  with master CPT user level3 auto-added display= NO with copy MD modifier= Yes

    Given I am logged into the portal with user "ccuser3" and password "123"
    And I am on the "PatientListV2" tab
    And "Neil Heath" is on the patient list
    And patient "Neil Heath" has no charges
    And I select patient "Neil Heath" from the patient list
    When I click the "Charges+" button
    And I wait "3" seconds
    And I set the following charge headers
      |Name          |Value     |
      |Bill Area     |Cardiology|
      |Svc Site      |<SvcSite> |
    And I enter the ICD-10 code "B65.0"
    And I enter the CPT code "<CPT>"
    And I click the "Submit" button
    And I click the "Save As Is" button in the "Confirm" pane if it exists
    Then the "Charges" table should load
    Given I am logged into the portal with user "ccuser1" and password "123"
    And I am on the "PatientListV2" tab
    And "Neil Heath" is on the patient list
    And I select patient "Neil Heath" from the patient list
    When I select "the first item" in the "Charges" table
    Then the "Charges" table should have at least "1" row containing the text "<Auto added>"
    Examples:
      |SvcSite   |CPT  |Auto added       |
      |Outpatient|93289|540793289 (A) add|
      |Inpatient |93289|540793289 (A) add|
      |ER        |93289|540793289 (A) add|
      |Outpatient|92312|540793290 (A) add|
      |Inpatient |92312|540793290 (A) add|
      |ER        |92312|540793290 (A) add|
      |Outpatient|92311|540792388 (A) add|
      |Inpatient |92311|540792388 (A) add|
      |ER        |92311|540792388 (A) add|

  Scenario Outline: Validate auto added CPT  with master CPT user level3 and auto-added display= NO with modifier

    Given I am logged into the portal with user "ccuser3" and password "123"
    And I am on the "PatientListV2" tab
    And "Neil Heath" is on the patient list
    And patient "Neil Heath" has no charges
    And I select patient "Neil Heath" from the patient list
    When I click the "Charges+" button
    And I wait "3" seconds
    And I set the following charge headers
      |Name         |Value     |
      |Bill Area    |Cardiology|
      |Svc Site     |<SvcSite> |
    And I enter the ICD-10 code "B65.0"
    And I enter the CPT code "19316"
    And I click the "Submit" button
    And I click the "Save As Is" button in the "Confirm" pane if it exists
    Given I am logged into the portal with user "ccuser1" and password "123"
    And I am on the "PatientListV2" tab
    And "Neil Heath" is on the patient list
    And I select patient "Neil Heath" from the patient list
    When I select "the first item" in the "Charges" table
    Then the "Charges" table should have at least "1" row containing the text "540719311 (A) add"

    Examples:
      |SvcSite   |
      |Outpatient|
      |Inpatient |
      |ER        |

  Scenario Outline: Validate auto added CPT  with master CPT user level3 and auto-added display= NO with copy MD modifier =NO

    Given I am logged into the portal with user "ccuser3" and password "123"
    And I am on the "PatientListV2" tab
    And "Neil Heath" is on the patient list
    And patient "Neil Heath" has no charges
    And I select patient "Neil Heath" from the patient list
    When I click the "Charges+" button
    And I wait "3" seconds
    And I set the following charge headers
      |Name         |Value     |
      |Bill Area    |Cardiology|
      |Svc Site     |<SvcSite> |
    And I enter the ICD-10 code "B65.0"
    And I enter the CPT code "95933"
    And I click the "Submit" button
    And I click the "Save As Is" button in the "Confirm" pane if it exists
    Given I am logged into the portal with user "ccuser1" and password "123"
    And I am on the "PatientListV2" tab
    And "Neil Heath" is on the patient list
    And I select patient "Neil Heath" from the patient list
    When I select "the first item" in the "Charges" table
    Then the "Charges" table should have at least "1" row containing the text "540793289 (A) add"

    Examples:
      |SvcSite   |
      |Outpatient|
      |Inpatient |
      |ER        |

  Scenario Outline: Validate auto added CPT  with master CPT user level3-svc site(outpatient) and auto-added display= NO

    Given I am logged into the portal with user "ccuser3" and password "123"
    And I am on the "PatientListV2" tab
    And "Neil Heath" is on the patient list
    And patient "Neil Heath" has no charges
    And I select patient "Neil Heath" from the patient list
    When I click the "Charges+" button
    And I wait "3" seconds
    And I set the following charge headers
      |Name         |Value      |
      |Bill Area    |Hospitalist|
      |Svc Site     |Outpatient |
    And I enter the ICD-10 code "B65.0"
    And I enter the CPT code "<CPT>"
    And I click the "Submit" button
    And I click the "Save As Is" button in the "Confirm" pane if it exists
    Given I am logged into the portal with user "ccuser1" and password "123"
    And I am on the "PatientListV2" tab
    And "Neil Heath" is on the patient list
    And I select patient "Neil Heath" from the patient list
    When I select "the first item" in the "Charges" table
    Then the "Charges" table should have at least "1" row containing the text "<Auto added>"

    Examples:
      |CPT   |Auto added|
      |90680 |90471     |
      |90715 |90461     |

  Scenario Outline: Validate auto added CPT  with master CPT user level3-svc site(All)and auto-added display= NO

    Given I am logged into the portal with user "ccuser3" and password "123"
    And I am on the "Patient ListV2" tab
    And "Neil Heath" is on the patient list
    And patient "Neil Heath" has no charges
    And I select patient "Neil Heath" from the patient list
    When I click the "Charges+" button
    And I wait "3" seconds
    And I set the following charge headers
      |Name         |Value     |
      |Bill Area    |<BillArea>|
      |Svc Site     |<SvcSite> |
    And I enter the ICD-10 code "B65.0"
    And I enter the CPT code "59020"
    And I click the "Submit" button
    And I click the "Save As Is" button in the "Confirm" pane if it exists
    When I select "the first item" in the "Charges" table
    Then the following rows should appear in the "Charges" table
      |Proc                                 |
      |59020 fetal contract stress test     |

    Examples:
      |SvcSite   |BillArea   |
      |Outpatient|Cardiology |
      |Inpatient |Hospitalist|
      |ER        |Neurology  |


  Scenario Outline: Validate auto added CPT  with master CPT user level3 and auto-added display= NO with auto-added modifier

    Given I am logged into the portal with user "ccuser3" and password "123"
    And I am on the "PatientListV2" tab
    And "Neil Heath" is on the patient list
    And patient "Neil Heath" has no charges
    And I select patient "Neil Heath" from the patient list
    When I click the "Charges+" button
    And I wait "3" seconds
    And I set the following charge headers
      |Name         |Value     |
      |Bill Area    |Cardiology|
      |Svc Site     |<SvcSite> |
    And I enter the ICD-10 code "B65.0"
    And I enter the CPT code "92978"
    And I click the "Submit" button
    And I click the "Save As Is" button in the "Confirm" pane if it exists
    When I select "the first item" in the "Charges" table
    Then the following rows should appear in the "Charges" table
      |Proc                                |
      |92978 intravasc us heart add-on     |

    Examples:
      |SvcSite   |
      |Outpatient|
      |Inpatient |
      |ER        |
