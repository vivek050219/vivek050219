@NoteWriterCosig
Feature:NoteWriterCo-signature

  Scenario:Enable NoteWriter Co-signature
    Given I am logged into the portal with user "nwadmin" using the default password
    And I am on the "Admin" tab
    And I select the "Institution" subtab
    And I select "NoteWriter" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    And I wait "2" seconds
    And I select "true" from the "Enable Quick Text Version 2" radio list in the "Note Writer Settings" pane
    And I select "true" from the "CoSignature" radio list in the "Note Writer Settings" pane
    And I select "Password" from the "Validation" dropdown
    And I select "true" from the "AllowAuthorToEditNoteInSignedStatus" radio list in the "Note Writer Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box if it exists

  Scenario: Verify Co-sig Family Social History in History and Physical template
    Given I am logged into the portal with user "CSlvl3u1" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    When "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I load the "History and Physical" template note for the selected patient
    And I select the note "Family/Social History" section
    Then the "FamilySocialHistory" pane should load
    When I check the "TobaccoUse" checkbox in the dashboard mode
    And I select "Current" from the "TobaccoUseStatus" dropdown
    And I enter "10" in the "PacksPerDay" field
    And I enter "1" in the "NoofYears" field
    And I enter "Chain Smoker" in the "TobaccoUseComments" field
    Then the value in the "PacksPerDay" field should be "10"
    And the value in the "NoofYears" field should be "1"
    And the value in the "TobaccoUseComments" field should be "Chain Smoker"
    When I check the "AlcoholUse" checkbox in the dashboard mode
    And I select "Few times a month" from the "Frequency" dropdown
    And I enter "Occasionally" in the "AlcoholUseComment" field
    Then the value in the "AlcoholUseComment" field should be "Occasionally"
    And I check the "DrugUse" checkbox in the dashboard mode
    And I enter "Never" in the "DrugUseComment" field
    When I select "Married" from the "Marital Status" dropdown
    Then the "Marital Status" dropdown should be "Married"
    When I enter "Lives at home independently" in the "Living Situation" field
    Then the value in the "Living Situation" field should be "Lives at home independently"
    When I enter "Daughter and son live nearby and check in on patient regularly. Patient's wife died 2 years ago" in the "Additional Social History Info" field
#    Then the value in the "Additional Social History Info" field should be "Daughter and son live nearby and check in on patient regularly. Patient's wife died 2 years ago"
    When I select "Full Code" from the "Code Status" dropdown
    Then the "Code Status" dropdown should be "Full Code"
    When I enter "healthcare proxy on file" in the "Health Care Proxy" field
    Then the value in the "Health Care Proxy" field should be "healthcare proxy on file"
    And I enter "Family History of Asthma" in the "FS Diagnosis Search" field in the "FamilySocialHistory" pane
    And I wait "2" seconds
#    And I click the "Add as Free Text" link in the "FamilySocialHistoryDiagnoses" pane
    And I click on the link "FamilyHistoryAddAsFreeText" in the "New Note" pane
    Then the text "Family History of Asthma" should appear in the "FamilySocialHistory" pane
    When I enter "Brother" in the "DiagnosesFSHQTV2" rich text field
    Then the text "Brother" should appear in the "FamilySocialHistory" pane
#    And I click the "ClearDiagnoses" element in the "FamilySocialHistoryDiagnoses" pane
    When I enter "Family history of coronary artery disease" in the "FS Diagnosis Search" field in the "FamilySocialHistory" pane
    And I wait "2" seconds
#    And I click the "Add as Free Text" link in the "FamilySocialHistoryDiagnoses" pane
    And I click on the link "FamilyHistoryAddAsFreeText" in the "New Note" pane
    Then the text "Family history of coronary artery disease" should appear in the "FamilySocialHistory" pane
    When I enter "mom" in the "DiagnosesFSHQTV2" rich text field
#    And I click the "enter" key in the "DiagnosesFSHQTV2" rich text field
    Then the text "Mother" should appear in the "FamilySocialHistory" pane
    And I click the "FamilyDiagnosesABCQTV2" element in the "FamilySocialHistory" pane
    When I click on the text "ppfh" in the "ClickToInsertV2" pane
    And I click the "CloseQT" button in the "ClickToInsertV2" pane
    Then the text "Patient's father's family has" should appear in the "FamilySocialHistory" pane
    When I enter "h/o pancreatic cancer" in the "DiagnosesFSHQTV2" rich text field
    Then the text "h/o pancreatic cancer" should appear in the "FamilySocialHistory" pane
    And I select the note "A/P" section
    And I enter "R52" in the "AP Diagnosis Search" field
    And I select "Moderate" from the "LevelOfDecision" dropdown
    And I click the "NoteWriterSign/Submit" button in the "Note Writer Main" pane
    And I click the "SearchImage" element in the "CoSignSubmitNote" pane
    And I verify the "CoSignLookUpSearchList" list has "2" rows with following text
      |CSLVL1U1 LEVEL1|
      |CSLVL2U1 LEVEL2|
    And I enter "CSLVL1U1" in the "lookupField" field in the "CoSignSubmitNote" pane
    Then I select "CSLVL1U1" option from the "CoSign LookUp Search List" list
    And I enter "123" in the "PasswordField" field in the "CoSignSubmitNote" pane
    And I click the "SubmitCoSigNoteConfirm" button in the "CoSignSubmitNote" pane
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
   # And I select "the first item" in the "Clinical Notes" table
    When I select "History and Physical" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And the text "Signed: Awaiting Co-signature" should appear in the "Progress Note" pane
    And The button "Edit" should be enabled in the "Progress Note" pane

  Scenario: Verify Co-sig Family Social History section in History and Physical template in Co-signature user
    Given I am logged into the portal with user "CSlvl1u1" using the default password
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Co-Sign" element
    And I click the "Refresh" button
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    When I select "DARR, MOLLY" from the "Patient" column in the "Messages" table
    Then the "eSig Note Content" pane should load
    And The following fields should be enabled in the "eSig Note Content" pane
      |Name     |Type   |
      |Attest   |button |
      |Skip     |button |
      |Decline  |button |
      |Sign     |button |
    And I click the "Attest" button
    And I wait "3" seconds
    And I select the note "History" section in the "CoSigNote" pane
    When I enter "User able to entered data in History tab." in the "CoSignatureAdditionsSubjective" rich text field
    And I select the note "Family/Social History" section in the "CoSigNote" pane
    When I enter "User able to entered data in Family/SocialHistory tab." in the "CoSignatureAdditionsFSHistory" rich text field
    And I select the note "ROS" section in the "CoSigNote" pane
    When I enter "User able to entered data in Ros tab." in the "CoSignatureAdditionsROS" rich text field
    And I select the note "Exam" section in the "CoSigNote" pane
    When I enter "User able to entered data in Exam tab." in the "CoSignatureAdditionsExam" rich text field
    And I select the note "Diagnostics" section in the "CoSigNote" pane
    When I enter "User able to entered data in Diagnostics tab." in the "CoSignatureAdditionsData" rich text field
    And I select the note "A/P" section in the "CoSigNote" pane
    When I enter "User able to entered data in A/P tab." in the "CoSignatureAdditionsAP" rich text field
    And I select the note "Billing" section in the "CoSigNote" pane
    When I enter "User able to entered data in Billing tab." in the "CoSignatureAdditionsBilling" rich text field
    #commenting below lines as this section is now obselete
#    And I select the note "Co-Signature" section in the "CoSigNote" pane
#    When I enter "User able to entered data in Co-Signature tab." in the "CoSignatureGeneralComments" rich text field
    And I select the note "A/P" section in the "CoSigNote" pane
    And I verify the note count of the "Messages" table and click the "Submit" button with "123" password
    And I click the logout button

  Scenario: Verify Status Co-sig Family Social History section in History and Physical template in resident user
    And I am logged into the portal with user "CSlvl3u1" and password "123"
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    And I click the "Refresh Patient List" button
    And I select patient "Molly Darr" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    Then rows starting with the following should appear in the "Clinical Notes" table
      |Date/Time             |Note Type                    |Author                             |
      |%Current Date MMDDYY% |History and Physical         |LEVEL3, CSLVL3U1 LEVEL1, CSLVL1U1  |
    When I select "History and Physical" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And the text "User able to entered data in Billing tab." should appear in the "Progress Note" pane
    And the text "Final" should appear in the "Progress Note" pane
    And the following field should not display in the "Progress Note" pane
      |Name     |Type   |
      |Edit     |button |


  Scenario: Verify co-sig ROS section in History and Physical template
    Given I am logged into the portal with user "CSlvl3u3" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    When "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I load the "History and Physical" template note for the selected patient
    And I select the note "ROS" section
    And I click the "ROS RESP Normal" button in the "ROSHistory" pane
    And I wait "1" seconds
    Then the text "Negative for dyspnea or wheeze. No cough." should appear in the "ROSHistory" pane
    When I click the "ROS CV Abnormal" button in the "Note Writer Main" pane
    Then the text "" should appear in the "ROSHistory" pane
    When I click the "ROSCVABCQTV2" button in the "ROSHistory" pane
    When I click on the text "palpitation" in the "ClickToInsertV2" pane
    Then the following text should appear in the "ROSHistory" pane
      |palpitation|
    And I click the "CloseQT" button in the "ClickToInsertV2" pane
    And I wait "2" seconds
    And I click the "ROS GI Normal" button in the "ROSHistory" pane
    And I wait "2" seconds
    Then the text "Negative for abdominal pain or nausea. No emesis. No diarrhea." should appear in the "ROSHistory" pane
    When I click the "ROS Skin Abnormal" button in the "ROSHistory" pane
    Then the text "" should appear in the "ROSHistory" pane
    When I click the "ROSSkinABCQTV2" button in the "ClickToInsertV2" pane
    When I click on the text "jaundice present" in the "ClickToInsertV2" pane
    Then the following text should appear in the "ROSHistory" pane
      |jaundice present|
    When I click on the text "itching present" in the "ClickToInsertV2" pane
    Then the following text should appear in the "ROS Skin AbnormalQTV2" pane
      |itching present|
    And I click the "CloseQT" button in the "ClickToInsertV2" pane
    And I select the note "A/P" section
    And I enter "R52" in the "AP Diagnosis Search" field
    And I select "Moderate" from the "LevelOfDecision" dropdown
    And I click the "NoteWriterSign/Submit" button in the "Note Writer Main" pane
    And I enter "CSLVL1U2" in the "lookupField" field in the "CoSignSubmitNote" pane
    Then I select "CSLVL1U2" option from the "CoSign LookUp Search List" list
    And I enter "123" in the "PasswordField" field in the "CoSignSubmitNote" pane
    And I click the "SubmitCoSigNoteConfirm" button in the "CoSignSubmitNote" pane
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "History and Physical" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And the text "Signed: Awaiting Co-signature" should appear in the "Progress Note" pane
    And The button "Edit" should be enabled in the "Progress Note" pane

  Scenario: Verify co-sig ROS section in History and Physical template in Co-signature user
    Given I am logged into the portal with user "CSlvl1u2" using the default password
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Co-Sign" element
    And I click the "Refresh" button
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    When I select "DARR, MOLLY" from the "Patient" column in the "Messages" table
    Then the "eSig Note Content" pane should load
    And The following fields should be enabled in the "eSig Note Content" pane
      |Name     |Type   |
      |Sign     |button |
      |Attest   |button |
      |Skip     |button |
      |Decline  |button |
    And I click the "Decline" button
    And I select "Edits are rquired" from the "Reason" dropdown
    And I enter ""Edits are required" '##^*Test" in the "AdditionalComments" field
    And I click the "OK" button in the "eSigNoteContent" pane
    And I wait "3" seconds
    And I click the logout button

  Scenario: Verify  Status co-sig ROS section in History and Physical template with resident user
    And I am logged into the portal with user "CSlvl3u3" and password "123"
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    And I click the "Refresh Patient List" button
    And I select patient "Molly Darr" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "History and Physical" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And the text "Signed: Awaiting Co-signature" should appear in the "Progress Note" pane
    And the text "Declining Provider: LEVEL1, CSLVL1U2" should appear in the "Progress Note" pane
    And the text "Additional Comments: "Edits are required" '##^*Test" should appear in the "Progress Note" pane
    And The button "Edit" should be enabled in the "Progress Note" pane
    And I click the "Edit" button
    And I wait "2" seconds
    And The button "Save as Draft" should be disabled in the "Note Writer Main" pane
    And I select the note "A/P" section
    And I enter "Chest pain radiating to arm" in the "AP Diagnosis Search" field in the "CoSignSubmitNote" pane
    And I select "Chest pain radiating to arm" option from the "AP Problem Picker" list
    And I enter "Burn" in the "PlanQTV2" rich text field
    And I sign/submit the Co-sig note as cosignature "CSLVL1U1"
    And I select "Clinical Notes" from clinical navigation
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "History and Physical" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And the text "Signed: Awaiting Co-signature" should appear in the "Progress Note" pane

  Scenario: Verify  Status co-sig ROS section in History and Physical template with provider in Co-signature user
    Given I am logged into the portal with user "CSlvl1u1" using the default password
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Co-Sign" element
    And I click the "Refresh" button
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    When I select "DARR, MOLLY" from the "Patient" column in the "Messages" table
    Then the "eSig Note Content" pane should load
    And The following fields should be enabled in the "eSig Note Content" pane
      |Name     |Type   |
      |Attest   |button |
      |Skip     |button |
      |Decline  |button |
      |Sign     |button |
    And I verify the note count of the "Messages" table and click the "Sign" button with "123" password
    And I click the logout button
    And I am logged into the portal with user "CSlvl3u3" and password "123"
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    And I click the "Refresh Patient List" button
    And I select patient "Molly Darr" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "History and Physical" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And the text "Final" should appear in the "Progress Note" pane

  Scenario:Verify co-sig Subjective Section in Progress note template
    Given I am logged into the portal with user "CSlvl3u3" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    When "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I load the "Progress Note" template note for the selected patient
    And I enter "This is a test quick text" in the "PatientNarrativeQTV2" field
    And I click the "Save as Draft" button in the "Note Writer Main" pane
    Then I click the "Yes" button in the "Note Writer Main" pane
    And I load the "Progress Note" template note for the selected patient
    And I click the "PatientNarrative" insert previous link in the "Note Writer Main" pane
    And I wait "3" seconds
    And I click the "InsertSelected" button
    And I press the "backspace" key "5" times in the "PatientNarrativeQTV2" rich text field
    Then the text "This is a test quick" should appear in the "PatientNarrativeQTV2" pane
    And I enter "Manually entered text" in the "PatientNarrativeQTV2" rich text field
    And I enter "PN" in the "PatientNarrativeQTV2" rich text field
    And I click the "space" key in the "PatientNarrativeQTV2" rich text field
    And the text "This is a QTv2 entry for Progress Note. This is " should appear in the "Note Writer Main" pane
    When I click the "Free Text" textbox in the rich text field
    And I enter "the third time patient has visited this hospital" in the "Free Text" free text field in the "Note Writer Main" pane
    And I click the "List" list in the rich text field
    And I select "1" option from the "ListSelect" list
    When I check the "SeverityQTV2" checkbox in the dashboard mode
    When I check the "ContextQTV2" checkbox in the dashboard mode
    When I check the "ModifyingFactorsQTV2" checkbox in the dashboard mode
    When I check the "QualityQTV2" checkbox in the dashboard mode
    And I wait "1" seconds
    And I click the "ROS EYES Normal" button in the "ROSHistory" pane
    And I click the "ROSGINormal" button in the "ROSHistory" pane
#    And I click the "ROS NEURO Normal" button in the "ROSHistory" pane
    And I mouse over and click the "ROS NEURO Normal" button in the "ROSHistory" pane
    Then the following text should appear in the "ROSHistory" pane
      |Negative for blurry vision. No diplopia.                        |
      |Negative for abdominal pain or nausea. No emesis. No diarrhea.  |
      |Negative for headache. No vertigo. Denies paresthesias.         |
    When I click the "ROS CV Abnormal" button in the "ROSHistory" pane
    And I click the "ROSCVABCQTV2" button in the "ROSHistory" pane
    And I wait "2" seconds
    And I click on the text "palpitation" in the "ClickToInsertV2" pane
    Then the following text should appear in the "Note Writer Main" pane
      |palpitation|
    And I enter "PND and orthopnea" in the "ROSCardiovascularAbnormalQTV2" rich text field
    And I select the note "A/P" section
    And I enter "R52" in the "PN Diagnosis Search" field
    And I select "Moderate" from the "LevelOfDecision" dropdown
    And I click the "NoteWriterSign/Submit" button in the "Note Writer Main" pane

    And I enter "CSLVL1U2" in the "lookupField" field in the "CoSignSubmitNote" pane
    Then I select "CSLVL1U2" option from the "CoSign LookUp Search List" list
    And I enter "123" in the "PasswordField" field in the "CoSignSubmitNote" pane
    And I click the "SubmitCoSigNoteConfirm" button in the "CoSignSubmitNote" pane

    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    And I select "*DRAFT* Progress Note" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And I delete the draft note in the "Progress Note" pane
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "Progress Note" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And the text "Signed: Awaiting Co-signature" should appear in the "Progress Note" pane
    And the text "LEVEL1, CSLVL1U2" should appear in the "Progress Note" pane

  Scenario:Verify co-sig Subjective Section in Progress note template in Co-signature user
     Given I am logged into the portal with user "CSlvl1u2" using the default password
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Co-Sign" element
    And I click the "Refresh" button
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    When I select "DARR, MOLLY" from the "Patient" column in the "Messages" table
    Then the "eSig Note Content" pane should load
    And The following fields should be enabled in the "eSig Note Content" pane
      |Name     |Type   |
      |Attest   |button |
      |Skip     |button |
      |Decline  |button |
      |Sign     |button |
      |Reassign |button|
    And I click the "Reassign" button
    And I enter "CSlvl1u4" in the "ProviderLOOKUP" field
    And I click the "SearchImage" image
    And the text "No results found." should appear in the "ReassignNote" pane
    And I click the "ProviderLOOKUP" element
    And I click the "OK" button in the "eSigNoteContent" pane
    And the text "Please specify a valid value to continue." should appear in the "eSigNoteContent" pane
    And I enter "CSlvl3u1" in the "ProviderLOOKUP" field
    And I click the "SearchImage" image
    #TODO: blocked by DEV-82971
    And I click the "OK" button in the "eSigNoteContent" pane
    And I click the logout button

  Scenario:Verify Status co-sig Subjective Section in Progress note template in Co-signature user
    And I am logged into the portal with user "CSlvl3u1" and password "123"
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Co-Sign" element
    And I click the "Refresh" button
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    When I select "DARR, MOLLY" from the "Patient" column in the "Messages" table
    Then the "eSig Note Content" pane should load
    And The following fields should be enabled in the "eSig Note Content" pane
      |Name     |Type   |
      |Attest   |button |
      |Skip     |button |
      |Decline  |button |
      |Sign     |button |
      |Reassign |button|
    And I click the "Attest" button
    And I wait "3" seconds
    And I select the note "Subjective" section in the "CoSigNote" pane
    When I enter "User able to entered data in Subjective tab." in the "CoSignatureAdditionsSubjective" rich text field
    And I select the note "Exam" section in the "CoSigNote" pane
    When I enter "User able to entered data in Exam tab." in the "CoSignatureAdditionsExam" rich text field
    And I select the note "Data" section in the "CoSigNote" pane
    When I enter "User able to entered data in Data tab." in the "CoSignatureAdditionsData" rich text field
    And I select the note "A/P" section in the "CoSigNote" pane
    When I enter "User able to entered data in A/P tab." in the "CoSignatureAdditionsAP" rich text field
    And I select the note "Billing" section in the "CoSigNote" pane
    When I enter "User able to entered data in Billing tab." in the "CoSignatureAdditionsBilling" rich text field
    #commenting below line as this section is now obselete
#    And I select the note "Co-Signature" section in the "CoSigNote" pane
#    When I enter "User able to entered data in Co-Signature tab." in the "CoSignatureGeneralComments" rich text field
    And I select the note "A/P" section in the "CoSigNote" pane
    And I verify the note count of the "Messages" table and click the "Submit" button with "123" password
    And I am logged into the portal with user "CSlvl3u3" and password "123"
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    And I click the "Refresh Patient List" button
    And I select patient "Molly Darr" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "Progress Note" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And the text "Final" should appear in the "Progress Note" pane
    And the text "Attestation message should be display end of the Note detail." should appear in the "Progress Note" pane


  Scenario:Verify Exam Section in Progress note template
    Given I am logged into the portal with user "CSlvl3u2" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    When "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I load the "Progress Note" template note for the selected patient
    Then I select the note "Exam" section
    And I click the "Exam CONST Normal" element in the "Note Writer Main" pane
    And I click the "SaveasDraft" button in the "Note Writer Main" pane
    Then I click the "Yes" button in the "Note Writer Main" pane
    And I load the "Progress Note" template note for the selected patient
    And I select the note "Exam" section
    And I wait "2" seconds
#    And the "VitalsQTV2" table should have at least "1" row
    Then The "RecentVitals" element should contain with the text "HR" in the "Note Writer Main" pane
    #commented fow now as pr manual team
   # And the "I/OQTV2" table should have at least "1" row
   #|Net: 1,482 Intake: 3,240 Output: 1,758|
    Then The "RecentIO" element should contain with the text "Net" in the "Note Writer Main" pane
    And I click the "ExamTarget" insert previous link in the "Note Writer Main" pane
    And I click the "InsertSelected" button
    Then the following text should appear in the "Note Writer Main" pane
      |Alert, in NAD. |
    And I click the "Exam Eyes Normal" element in the "Note Writer Main" pane
    And I click the "Exam Resp Normal" element in the "Note Writer Main" pane
    And the following text should appear in the "Note Writer Main" pane
      |PERL. Sclerae nonicteric. Conjunctivae pink. |
      |Lungs clear to auscultation, no distress.    |
#    When I click the "ProblemTrash" element in the "Note Writer Main" pane
#    clicking Exam CONST Normal button to remove the exam element
    And I click the "Exam CONST Normal" element in the "Note Writer Main" pane
    And the text "CONSTITUTIONAL:" should not appear in the "Exam Target Table" section in the "Note Writer Main" pane
    And I enter "This is manually entered text" in the "ExamRespNormalQTV2" field
    And I click the "Exam Neuro Normal" element in the "Note Writer Main" pane
    Then the following text should appear in the "Note Writer Main" pane
      |Negative for headache. No vertigo. Denies paresthesias. |
    And I enter "This is manually entered text" in the "ExamNeuroNormalQTV2" rich text field
    When I click the "Exam CV Abnormal" element in the "Note Writer Main" pane
    And I click the "ExamCVABCQTV2" element in the "Note Writer Main" pane
    And I click on the text "palipitation" in the "ClickToInsertV2" pane
    Then the following text should appear in the "Note Writer Main" pane
      |palipitation   |
    And I enter "PND and orthopnea" in the "ExamCVQTV2" rich text field in the "Note Writer Main" pane
    And I select the note "A/P" section
    And I enter "R52" in the "PN Diagnosis Search" field
    And I select "Moderate" from the "LevelOfDecision" dropdown
    And I click the "NoteWriterSign/Submit" button in the "Note Writer Main" pane
    And I click the "SearchImage" element in the "CoSignSubmitNote" pane
    And I verify the "CoSignLookUpSearchList" list has "2" rows with following text
      |CSLVL1U1 LEVEL1|
      |CSLVL1U3 LEVEL1|
    And I enter "CSLVL1U3" in the "lookupField" field in the "CoSignSubmitNote" pane
    Then I select "CSLVL1U3" option from the "CoSign LookUp Search List" list
    And I enter "123" in the "PasswordField" field in the "CoSignSubmitNote" pane
    And I click the "SubmitCoSigNoteConfirm" button in the "CoSignSubmitNote" pane
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    And I select "*DRAFT* Progress Note" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And I delete the draft note in the "Progress Note" pane
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "Progress Note" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And the text "Signed: Awaiting Co-signature" should appear in the "Progress Note" pane


  Scenario:Verify Exam Section in Progress note template in Co-signature user
    And I am logged into the portal with user "CSlvl1u3" and password "123"
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Co-Sign" element
    And I click the "Refresh" button
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    When I select "DARR, MOLLY" from the "Patient" column in the "Messages" table
    Then the "eSig Note Content" pane should load
    And The following fields should be enabled in the "eSig Note Content" pane
      |Name     |Type   |
      |Attest   |button |
      |Skip     |button |
      |Decline  |button |
      |Sign     |button |
      |Reassign |button|
    And I verify the note count of the "Messages" table and click the "Sign" button with "123" password

  Scenario: Verify Status Exam Section in Progress note template with resident user
    And I am logged into the portal with user "CSlvl3u2" and password "123"
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    And I click the "Refresh Patient List" button
    And I select patient "Molly Darr" from the patient list
    And I select "Clinical Notes" from clinical navigation
    When I select "Progress Note" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And the text "Final" should appear in the "Progress Note" pane
    And the following field should not display in the "Progress Note" pane
      |Name     |Type   |
      |Edit     |button |
    And the text "Attestation message should be display end of the Note detail." should appear in the "Progress Note" pane

  Scenario: Verify Discharge Medications in Discharge Summary template [DEV-57044]
    Given I am logged into the portal with user "CSlvl3u3" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    When "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I load the "Discharge Summary" template note for the selected patient
    And I find out all active windows
    And I switch the focus to the "popoutWindow" window
    And I select the note "Discharge Medications" section
    Then the "Discharge Medications" pane should load
    And the "CurrentAllergy" pane should load
    #with new Responsive design for NW, checkboxes will not be displayed
#    And the checkbox should be checked in the rows with "hives" cell text in the "AllergyDischargeSummary" table
#    And I uncheck the "BeeSting" checkbox in the dashboard mode
#    Then the following should be unchecked
#      |BeeSting |
    And I click the "Annotation" element
    And I wait "2" seconds
    When I enter "This is annotation text for allergy field" in the "AllergyDischargeSummary" field
    And I wait "2" seconds
    Then the text "This is annotation text for allergy field" should appear in the "Discharge Medications" pane
    And I sign/submit the Co-sig note as cosignature "CSLVL2U1"
    And I wait "2" seconds
    And I switch the focus to the "LoginWindow" window
    And I am on the "Patient List V2" tab
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "Discharge Summary" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And the text "Signed: Awaiting Co-signature" should appear in the "Progress Note" pane
    And the text "LEVEL2, CSLVL2U1" should appear in the "Progress Note" pane
    And The button "Edit" should be enabled in the "Progress Note" pane
    Given I am logged into the portal with user "CSlvl2u1" using the default password
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Co-Sign" element
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    When I select "DARR, MOLLY" from the "Patient" column in the "Messages" table
    Then the "eSig Note Content" pane should load
    And The following fields should be enabled in the "eSig Note Content" pane
      |Name     |Type   |
      |Sign     |button |
      |Attest   |button |
      |Skip     |button |
      |Decline  |button |
    And I verify the note count of the "Messages" table and click the "Sign" button with "123" password
    And I click the logout button
    And I am logged into the portal with user "CSlvl3u3" and password "123"
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    And I click the "Refresh Patient List" button
    And I select patient "DARR, MOLLY" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "Discharge Summary" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And the text "Final" should appear in the "Progress Note" pane
    And the following field should not display in the "Progress Note" pane
      |Name     |Type   |
      |Edit     |button |
    And the text "Attestation message should be display end of the Note detail." should appear in the "Progress Note" pane

  Scenario: Verify Follow Up section in Discharge Summary template
    Given I am logged into the portal with user "CSlvl3u4" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    When "LOLA BONNET" is on the patient list
    And I select patient "LOLA BONNET" from the patient list
    And I load the "Discharge Summary" template note for the selected patient
    And I find out all active windows
    And I switch the focus to the "popoutWindow" window
    And I select the note "Follow Up" section
    Then I select "Fair" from the "Discharge Condition" dropdown
    And I enter "Patient will continue recovery at home." in the "DischargeConditionQTV2" rich text field
    And the text "Patient will continue recovery at home." should appear in the "Note Writer Main" pane
    And I click the "DischargeConditionABC" element
    When I click on the text "imprv" in the "ClickToInsertV2" pane
    And I click the "CloseQuickText" button
    And the text "Patient condition has improved" should appear in the "Note Writer Main" pane
#    And the "Pending Labs Tests" table should have at least "1" rows containing the text "Pending"
    Then The "PendingLabTests" element should contain with the text "Pending" in the "Note Writer Main" pane
    And I enter "Patient should try to exercise daily." in the "RecommendationsDischargeInstructionsQTV2" rich text field
    And the text "Patient should try to exercise daily." should appear in the "Note Writer Main" pane
    And I click the "RecommendationsDischargeInstructionsABC" element
    And I click on the text "lfat" in the "ClickToInsertV2" pane
    And I click the "CloseQuickText" button
    Then the following text should appear in the "Note Writer Main" pane
      |Recommend patient to have low fat diet |
    And I enter "adams" in the "Physicians Lookup" field in the "Note Writer Main" pane
    Then I select "AMY" option from the "Physican LookUp Search List" list
#    And I enter "111-111-1111" in the "Physician Fax" field
    And I click the "NoteWriterSign/Submit" button in the "Note Writer Main" pane
    And I enter "123" in the "PasswordField" field in the "CoSignSubmitNote" pane
    And the following field should not display in the "CoSignSubmitNote" pane
      |Name        |Type   |
      |lookupField |Text Field |
    And I click the "SubmitCoSigNoteConfirm" button in the "CoSignSubmitNote" pane
    And I wait "2" seconds
    And I switch the focus to the "LoginWindow" window
    And I am on the "Patient List V2" tab
    And I select "Clinical Notes" from clinical navigation
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "Discharge Summary" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And the text "Final" should appear in the "Progress Note" pane
    And the following field should not display in the "Progress Note" pane
      |Name     |Type   |
      |Edit     |button |
#    And the text "Attestation message should be display end of the Note detail." should appear in the "Progress Note" pane


  Scenario: Verify Description section in Oprative template
    Given I am logged into the portal with user "CSlvl3u1" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    When "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I load the "OperativeReport" template note for the selected patient
    And I select the note "Description" section
    And I wait "3" seconds
    And I enter "desc" in the "DescriptionOfOperationQTV2" rich text field
    And I click the "Anesthesia Type" list in the rich text field
    And I select "General Anesthesia" option from the "ListSelect" list
    And I click the "Free text1" textbox in the rich text field
    And I enter "Zosyn" in the "Free Text" free text field in the "Note Writer Main" pane
    And I click the "Free text2" textbox in the rich text field
    And I enter "12 to 13 mmHg pressure." in the "Free Text" free text field in the "Note Writer Main" pane
    And I click the "Free text3" textbox in the rich text field
    And I enter "very distended and thick-walled with obsious acute cholecystitis changes about it." in the "Free Text" free text field in the "Note Writer Main" pane
    And I click the "Free text4" textbox in the rich text field
    And I enter "There appeared to be several stones" in the "Free Text" free text field in the "Note Writer Main" pane
#    And I click the "Free text5" textbox in the rich text field
#    And I enter "and since there was some mild oozing in the gallbladder fossa, it was felt best to drain this area postoperatively. Therefore, a #10 Jackson-Pratt was placed into the abdomen in Morison pouch and brought out through the right lateral trocar site. All irrigant was removed and returns were clear." in the "Free Text" free text field in the "PatientNarrativeQTV2" pane
    And I click the "NoteWriterSign/Submit" button in the "Note Writer Main" pane
    And I click the "SearchImage" element in the "CoSignSubmitNote" pane
    And I verify the "CoSignLookUpSearchList" list has "2" rows with following text
      |CSLVL1U1 LEVEL1|
      |CSLVL2U1 LEVEL2|
    And I enter "CSLVL2U1" in the "lookupField" field in the "CoSignSubmitNote" pane
    Then I select "CSLVL2U1" option from the "CoSign LookUp Search List" list
    And I enter "123" in the "PasswordField" field in the "CoSignSubmitNote" pane
    And I click the "SubmitCoSigNoteConfirm" button in the "CoSignSubmitNote" pane
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "Operative Note" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And the text "Signed: Awaiting Co-signature" should appear in the "Progress Note" pane
    And the text "LEVEL2, CSLVL2U1" should appear in the "Progress Note" pane
    Given I am logged into the portal with user "CSlvl2u1" using the default password
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Co-Sign" element
    And I click the "Refresh" button
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    When I select "DARR, MOLLY" from the "Patient" column in the "Messages" table
    Then the "eSig Note Content" pane should load
    And The following fields should be enabled in the "eSig Note Content" pane
      |Name     |Type   |
      |Sign     |button |
      |Attest   |button |
      |Skip     |button |
      |Decline  |button |
    And I verify the note count of the "Messages" table and click the "Sign" button with "123" password
    And I click the logout button
    And I am logged into the portal with user "CSlvl3u1" and password "123"
    And I am on the "Patient List V2" tab
    And I click the "Refresh Patient List" button
    And I select patient "Molly Darr" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "Operative Note" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And the text "Final" should appear in the "Progress Note" pane
    And the following field should not display in the "Progress Note" pane
      |Name     |Type   |
      |Edit     |button |
    And the text "Attestation message should be display end of the Note detail." should appear in the "Progress Note" pane

    #TODO : mail sent for clarification of Data tab DEV-81805
  Scenario: Verify Data section in Oprative template
    Given I am logged into the portal with user "CSlvl3u1" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    When "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I load the "OperativeReport" template note for the selected patient
    And I select the note "Data" section
    And the following links should display in the "PatientNarrativeQTV2" pane
      |Allergies      |
      |Clinical Notes |
      |Medication     |
      |Lab Results    |
      |Orders         |
      |Test Results   |
      |Vitals         |
    When I click the "Allergies" link in the "NoteWriter" pane
    And I wait "2" seconds
    And I click the "NoteWriterPreselectionIcon" element
    And I click the "CopytoNote" button
    Then the text "Sulfonamides" should appear in the "Data" pane
    #Commented below steps due to in automation search text not working looking into this
    When I click the "Clinical Notes" link in the "NoteWriter" pane
    And I select "Consult - Renal" from the "Note Type (\d of \d)" column in the "ClinicalNotesResults" table
    And I enter "1. Monitor BS q4h, renal function daily." in the "NoteSearchTextQTV2" field
    And I click the "SearchTextQTV2" image
    Then I highlight the search text in the "Search Details" pane
    And I click the "AddSelectedText" element in the "Clinical Note Details" pane
    Then the text "1. Monitor BS q4h, renal function daily" should appear in the "Test Selection Nw Qtv2" pane
    When I click the "Copy to Note" button
    When I click the "Clinical Notes" link in the "NoteWriter" pane
    And I wait "2" seconds
    When I select "Nursing Assessment" from the "Note Type (\d of \d)" column in the "ClinicalNotesResults" table
    And I wait "2" seconds
    And I enter "HISTORY" in the "NoteSearchTextQTV2" field
    And I click the "SearchTextQTV2" image
    Then I doubleClick on the searchtext in the "Search Details" pane
    And I click the "AddSelectedText" element in the "Clinical Note Details" pane
    Then the text "HISTORY" should appear in the "Test Selection Nw Qtv2" pane
    When I click the "Copy to Note" button
    Then the following text should appear in the "Data" pane
       |1. Monitor BS q4h, renal function daily  |
       |HISTORY                                  |
    When I click the "Medications" link in the "NoteWriter" pane
    And I wait "2" seconds
    And I click the "NoteWriterPreselectionIcon" element in the "MedicationList" pane
    And I click the "Copy to Note" button
    When I click the "Lab Results" link in the "NoteWriter" pane
    And I click the "NoteWriterPreselectionIcon" element in the "LabList" pane
    And I click the "Copy to Note" button
#    Then the "ClinicalData" table should have at least "1" rows containing the text "Medications"
#    And the "ClinicalData" table should have at least "1" rows containing the text "Lab Results"
    Then the "MedicationsView" pane should load
    Then the "LabsView" pane should load
    And I click the "NoteWriterSign/Submit" button in the "Note Writer Main" pane
    And I click the "SearchImage" element in the "Submit Note" pane
    And I enter "CSlvl2u1" in the "lookupField" field in the "Submit Note" pane
    And I enter "123" in the "PasswordField" field in the "Submit Note" pane
    And I click the "OK" button in the "Submit Note" pane
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "Operative Note" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And the text "Signed: Awaiting Co-signature" should appear in the "Progress Note" pane
    And the text "LEVEL2, CSLVL2U1" should appear in the "Progress Note" pane
    Given I am logged into the portal with user "CSlvl2u1" using the default password
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Co-Sign" element
    And I click the "Refresh" button
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    When I select "DARR, MOLLY" from the "Patient" column in the "Messages" table
    Then the "eSig Note Content" pane should load
    And The following fields should be enabled in the "eSig Note Content" pane
      |Name     |Type   |
      |Sign     |button |
      |Attest   |button |
      |Skip     |button |
      |Decline  |button |
    And I verify the note count of the "Messages" table and click the "Sign" button with "123" password
    And I click the logout button
    And I am logged into the portal with user "CSlvl3u1" and password "123"
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    And I click the "Refresh Patient List" button
    And I select patient "Molly Darr" from the patient list
    And I select "Clinical Notes" from clinical navigation
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "Operative Note" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And the text "Final" should appear in the "Progress Note" pane
    And the following field should not display in the "Progress Note" pane
      |Name     |Type   |
      |Edit     |button |
    And the text "Attestation message should be display end of the Note detail." should appear in the "Progress Note" pane

  Scenario:Disable Note Signed Status
    Given I am logged into the portal with user "nwadmin" using the default password
    And I am on the "Admin" tab
    And I select the "Institution" subtab
    And I select "NoteWriter" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    And I wait "2" seconds
    And I select "true" from the "CoSignature" radio list in the "Note Writer Settings" pane
    And I select "Password" from the "Validation" dropdown
    And I select "false" from the "AllowAuthorToEditNoteInSignedStatus" radio list in the "Note Writer Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box

  Scenario: Verify Co-sig for Chart Notation AM template
    Given I am logged into the portal with user "CSlvl3u3" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    When "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I load the "Chart Notation AM" template note for the selected patient
    Then I select the note "Notation" section
    When I enter "This is the Title field." in the "TitleField" field
    And I enter "nota1" in the "NotationQTV2" rich text field
    Then the text "The next step is to either diagnose or rule out a chromosomal abnormality. In a patient with a normal number of chromosomes, each pair will have only two chromosomes. Having an extra or missing chromosome usually renders a fetus inviable" should appear in the "NoteWriter" pane
    And I enter "nota2" in the "NotationQTV2" rich text field
    And I click the "List1" list in the rich text field
    And I select "10" option from the "ListSelect" list
    When I click the "Free text1" textbox in the rich text field
    And I enter "Free text with label" in the "Free text1" free text field in the "NotationQTV2" pane
    When I click the "Free text2" textbox in the rich text field
    And I enter "How about Phasma Lead, Kylo, Vader, Sid and Luminara? I've noticed that the bonus attack seems lower than it should be. When I've had Sid in lead, I've got more critical hits overall have been killed a few times with faster teams." in the "Free text1" free text field in the "NotationQTV2" pane
    When I click the "Free text3" textbox in the rich text field
    And I enter "Sids bonus works all the time and for everyone while phasma is just a small chance. I think the damage sid boosts would outshine her in most cases." in the "Free text1" free text field in the "NotationQTV2" pane
    And I click the "List2" list in the rich text field
    And I select "10" option from the "ListSelect" list
    And I sign/submit the Co-sig note as cosignature "CSLVL2U1"
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "Chart Notation" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And the text "Signed: Awaiting Co-signature" should appear in the "Progress Note" pane
    And The button "Edit" should be enabled in the "Progress Note" pane
    And I click the "Edit" button
    And I enter "pn" in the "UpdateNote" rich text field
    When I click the "Free Text" textbox in the rich text field
    And I enter "This is free text" in the "Insert Text" free text field in the "UpdateNote" pane
    And I click the "List" list in the rich text field
    And I select "1" option from the "ListSelect" list
    And The button "Save as Draft" should be disabled in the "Note Writer Main" pane
    And I sign/submit the Co-sig note as cosignature "CSLVL2U1"
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "Chart Notation" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And the text "This is a QTv2 entry for Progress Note." should appear in the "Progress Note" pane

  Scenario: Verify Co-sig for Chart Notation AM template in Co-signature user
    Given I am logged into the portal with user "CSlvl2u1" using the default password
    And I am on the "Inbox" tab
    When I select the "eSig and PK Mail" subtab
    And I click the "Co-Sign" element
    Then the "Messages" table should load
    And I sort the "Messages" table chronologically by the "Date" column in "Descending" order
    When I select "DARR, MOLLY" from the "Patient" column in the "Messages" table
    Then the "eSig Note Content" pane should load
    And The following fields should be enabled in the "eSig Note Content" pane
      |Name     |Type   |
      |Sign     |button |
      |Attest   |button |
      |Skip     |button |
      |Decline  |button |
    And I verify the note count of the "Messages" table and click the "Sign" button with "123" password
    And I click the logout button

  Scenario: Verify Status Co-sig for Chart Notation AM template with resident user
    And I am logged into the portal with user "CSlvl3u3" and password "123"
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    And I click the "Refresh Patient List" button
    And I select patient "Molly Darr" from the patient list
    And I select "Clinical Notes" from clinical navigation
    When I select "Chart Notation" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And the text "Final" should appear in the "Progress Note" pane
    And the following field should not display in the "Progress Note" pane
      |Name     |Type   |
      |Edit     |button |
    And the text "Attestation message should be display end of the Note detail." should appear in the "Progress Note" pane

  Scenario:Verifying in Discharge Summary template "Your note requires co-signature" popup displaying or not
    Given I am logged into the portal with user "CSlvl3u3" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    When "DARR, MOLLY" is on the patient list
    And I select patient "DARR, MOLLY" from the patient list
    And I load the "Discharge Summary" template note for the selected patient
    And I find out all active windows
    And I switch the focus to the "popoutWindow" window
    And I select the note "Discharge Medications" section
    Then the "Discharge Medications" pane should load
    And the "CurrentAllergy" pane should load
    #with new Responsive design for NW, checkboxes will not be displayed
#    And the checkbox should be checked in the rows with "hives" cell text in the "AllergyDischargeSummary" table
#    And I uncheck the "BeeSting" checkbox in the dashboard mode
#    Then the following should be unchecked
#      |BeeSting |
    And I click the "Annotation" element
    When I enter "This is annotation text for allergy field" in the "AllergyDischargeSummary" rich text field
    And I wait "2" seconds
    Then the text "This is annotation text for allergy field" should appear in the "Discharge Medications" pane
    And I sign/submit the Co-sig note as cosignature "CSLVL2U1"
    And I wait "2" seconds
    And I switch the focus to the "LoginWindow" window
    And I am on the "Patient List V2" tab
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "Discharge Summary" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And the text "Signed: Awaiting Co-signature" should appear in the "Progress Note" pane
    And the text "LEVEL2, CSLVL2U1" should appear in the "Progress Note" pane

  Scenario:Verifying in History and Physical template "Your note requires co-signature" popup displaying or not
    Given I am logged into the portal with user "CSlvl3u3" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    When "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I load the "History and Physical" template note for the selected patient
    And I select the note "ROS" section
    And I click the "ROS RESP Normal" button in the "Note Writer Main" pane
    Then the text "Negative for dyspnea or wheeze. No cough." should appear in the "Note Writer Main" pane
    When I click the "ROS CV Abnormal" button in the "Note Writer Main" pane
    Then the value in the "ROSCardiovascularAbnormalQTV2" field should be blank
    When I click the "ROSCVABCQTV2" button in the "Note Writer Main" pane
    When I click on the text "palpitation" in the "ClickToInsertV2" pane
    Then the following text should appear in the "Note Writer Main" pane
      |palpitation|
    And I click the "ROS GI Normal" button in the "Note Writer Main" pane
    Then the text "Negative for abdominal pain or nausea. No emesis. No diarrhea." should appear in the "Note Writer Main" pane
    When I click the "ROS Skin Abnormal" button in the "Note Writer Main" pane
    Then the value in the "ROSkinQTV2" field should be blank
    When I click the "ROSSkinAbnormalABCQTV2" button in the "Note Writer Main" pane
    When I click on the text "jaundice present" in the "ClickToInsertV2" pane
    Then the following text should appear in the "Note Writer Main" pane
      |jaundice present|
    When I click on the text "itching present" in the "ClickToInsertV2" pane
    Then the following text should appear in the "Note Writer Main" pane
      |itching present|
    And I click the "CloseQuickText" button
    And I select the note "A/P" section
    And I enter "R52" in the "AP Diagnosis Search" field
    And I select "Moderate" from the "LevelOfDecision" dropdown
    And I click the "NoteWriterSign/Submit" button in the "Note Writer Main" pane
    And I enter "CSLVL1U2" in the "lookupField" field in the "CoSignSubmitNote" pane
    Then I select "CSLVL1U2" option from the "CoSign LookUp Search List" list
    And I enter "123" in the "PasswordField" field in the "CoSignSubmitNote" pane
    And I click the "SubmitCoSigNoteConfirm" button in the "CoSignSubmitNote" pane
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "History and Physical" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And the text "Signed: Awaiting Co-signature" should appear in the "Progress Note" pane
    And the text "LEVEL1, CSLVL1U2" should appear in the "Progress Note" pane

  Scenario:Verifying in Progress Note template "Your note requires co-signature" popup displaying or not
    Given I am logged into the portal with user "CSlvl3u3" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    When "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I load the "Progress Note" template note for the selected patient
    Then I select the note "Exam" section
    And I click the "Exam CONST Normal" element in the "Note Writer Main" pane
    And I click the "SaveasDraft" button in the "Note Writer Main" pane
    Then I click the "Yes" button in the "Note Writer Main" pane
    And I load the "Progress Note" template note for the selected patient
    And I select the note "Exam" section
    Then The "RecentVitals" element should contain with the text "HR" in the "Note Writer Main" pane
    Then The "RecentIO" element should contain with the text "Net" in the "Note Writer Main" pane
    And I click the "ExamTarget" insert previous link in the "Note Writer Main" pane
    And I mouse over and click the "InsertSelected" button
    Then the following text should appear in the "Note Writer Main" pane
      |Alert, in NAD. |
    And I click the "Exam Eyes Normal" element in the "Note Writer Main" pane
    And I click the "Exam Resp Normal" element in the "Note Writer Main" pane
    And the following text should appear in the "Note Writer Main" pane
      |PERL. Sclerae nonicteric. Conjunctivae pink. |
      |Lungs clear to auscultation, no distress.    |
#    When I click the "ProblemTrash" element in the "Note Writer Main" pane
    And I click the "Exam CONST Normal" element in the "Note Writer Main" pane
    And the text "CONSTITUTIONAL:" should not appear in the "Exam Target Table" section in the "Note Writer Main" pane
    And I enter "This is manually entered text" in the "ExamRespNormalQTV2" rich text field
    And I click the "Exam Neuro Normal" element in the "Note Writer Main" pane
    Then the following text should appear in the "Note Writer Main" pane
      |Negative for headache. No vertigo. Denies paresthesias. |
    And I enter "This is manually entered text" in the "ExamNeuroNormalQTV2" rich text field
    When I click the "Exam CV Abnormal" element in the "Note Writer Main" pane
    And I enter "PND and orthopnea" in the "ExamCVQTV2" rich text field in the "Note Writer Main" pane
    And I select the note "A/P" section
    And I enter "R52" in the "PN Diagnosis Search" field
    And I select "Moderate" from the "LevelOfDecision" dropdown
    And I click the "NoteWriterSign/Submit" button in the "Note Writer Main" pane
    And I enter "CSLVL1U3" in the "lookupField" field in the "CoSignSubmitNote" pane
    Then I select "CSLVL1U3" option from the "CoSign LookUp Search List" list
    And I enter "123" in the "PasswordField" field in the "CoSignSubmitNote" pane
    And I click the "SubmitCoSigNoteConfirm" button in the "CoSignSubmitNote" pane
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    And I select "*DRAFT* Progress Note" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And I delete the draft note in the "Progress Note" pane
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "Progress Note" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And the text "Signed: Awaiting Co-signature" should appear in the "Progress Note" pane
    And the text "LEVEL1, CSLVL1U3" should appear in the "Progress Note" pane

  Scenario:Verifying in Operative Report template "Your note requires co-signature" popup displaying or not
    Given I am logged into the portal with user "CSlvl3u3" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    When "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I load the "OperativeReport" template note for the selected patient
    And I select the note "Description" section
    And I wait "1" seconds
    And I enter "desc" in the "DescriptionOfOperationQTV2" rich text field
    And I click the "Anesthesia Type" list in the rich text field
    And I select "General Anesthesia" option from the "ListSelect" list
    And I click the "Free text1" textbox in the rich text field
    And I enter "Zosyn" in the "Free Text" free text field in the "Note Writer Main" pane
    And I click the "Free text2" textbox in the rich text field
    And I enter "12 to 13 mmHg pressure." in the "Free Text" free text field in the "Note Writer Main" pane
    And I click the "Free text3" textbox in the rich text field
    And I enter "very distended and thick-walled with obsious acute cholecystitis changes about it." in the "Free Text" free text field in the "Note Writer Main" pane
    And I click the "Free text4" textbox in the rich text field
    And I enter "There appeared to be several stones" in the "Free Text" free text field in the "Note Writer Main" pane
#    And I click the "Free text5" textbox in the rich text field
#    And I enter "and since there was some mild oozing in the gallbladder fossa, it was felt best to drain this area postoperatively. Therefore, a #10 Jackson-Pratt was placed into the abdomen in Morison pouch and brought out through the right lateral trocar site. All irrigant was removed and returns were clear." in the "Free Text" free text field in the "PatientNarrativeQTV2" pane
    And I click the "NoteWriterSign/Submit" button in the "Note Writer Main" pane
    And I enter "CSLVL2U1" in the "lookupField" field in the "CoSignSubmitNote" pane
    Then I select "CSLVL2U1" option from the "CoSign LookUp Search List" list
    And I enter "123" in the "PasswordField" field in the "CoSignSubmitNote" pane
    And I click the "SubmitCoSigNoteConfirm" button in the "CoSignSubmitNote" pane
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "Operative Note" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And the text "Signed: Awaiting Co-signature" should appear in the "Progress Note" pane
    And the text "LEVEL2, CSLVL2U1" should appear in the "Progress Note" pane

  Scenario:Verifying in Chart Notation AM template "Your note requires co-signature" popup displaying or not
    Given I am logged into the portal with user "CSlvl3u3" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    When "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I load the "Chart Notation AM" template note for the selected patient
    And I click the "OK" button in the "Information" pane if it exists
    Then I select the note "Notation" section
    When I enter "This is the TItle field." in the "TitleField" rich text field
    And I enter "nota1" in the "NotationQTV2" rich text field
    Then the text "The next step is to either diagnose or rule out a chromosomal abnormality. In a patient with a normal number of chromosomes, each pair will have only two chromosomes. Having an extra or missing chromosome usually renders a fetus inviable" should appear in the "NoteWriter" pane
    And I enter "nota2" in the "NotationQTV2" rich text field
    And I click the "List1" list in the rich text field
    And I select "10" option from the "ListSelect" list
    When I click the "Free text1" textbox in the rich text field
    And I enter "Free text with label" in the "Free text1" free text field in the "NotationQTV2" pane
    When I click the "Free text2" textbox in the rich text field
    And I enter "How about Phasma Lead, Kylo, Vader, Sid and Luminara? I've noticed that the bonus attack seems lower than it should be. When I've had Sid in lead, I've got more critical hits overall have been killed a few times with faster teams." in the "Free text1" free text field in the "NotationQTV2" pane
    When I click the "Free text3" textbox in the rich text field
    And I enter "Sids bonus works all the time and for everyone while phasma is just a small chance. I think the damage sid boosts would outshine her in most cases." in the "Free text1" free text field in the "NotationQTV2" pane
    And I click the "List2" list in the rich text field
    And I select "10" option from the "ListSelect" list
    And I sign/submit the Co-sig note as cosignature "CSLVL2U1"
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "Chart Notation" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And the text "Signed: Awaiting Co-signature" should appear in the "Progress Note" pane
    And the text "LEVEL2, CSLVL2U1" should appear in the "Progress Note" pane

  Scenario:Pre required for Note in Signed Status=No
    Given I am logged into the portal with user "nwadmin" using the default password
    And I am on the "Admin" tab
    And I select the "Institution" subtab
    And I select "NoteWriter" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    And I wait "2" seconds
    And I select "false" from the "NoteinSignedStatus" radio list in the "Note Writer Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box

  Scenario:Verify Progress Note Author Edit Partial Audit Report When edit a Note in Signed Status=No
    Given I am logged into the portal with user "CSlvl3u3" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    When "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I load the "Progress Note" template note for the selected patient
    Then I select the note "Exam" section
    And I click the "Exam CONST Normal" element in the "Note Writer Main" pane
    And I click the "SaveasDraft" button in the "Note Writer Main" pane
    Then I click the "Yes" button in the "Note Writer Main" pane
    And I load the "Progress Note" template note for the selected patient
    And I select the note "Exam" section
    Then The "RecentVitals" element should contain with the text "HR" in the "Note Writer Main" pane
    Then The "RecentIO" element should contain with the text "Net" in the "Note Writer Main" pane
    And I click the "ExamTarget" insert previous link in the "Note Writer Main" pane
    And I click the "InsertSelected" button
    Then the following text should appear in the "Note Writer Main" pane
      |Alert, in NAD. |
    And I click the "Exam Eyes Normal" element in the "Note Writer Main" pane
    And I click the "Exam Resp Normal" element in the "Note Writer Main" pane
    And the following text should appear in the "Note Writer Main" pane
      |PERL. Sclerae nonicteric. Conjunctivae pink. |
      |Lungs clear to auscultation, no distress.    |
    And I click the "Exam CONST Normal" element in the "Note Writer Main" pane
    And the text "CONSTITUTIONAL:" should not appear in the "Exam Target Table" section in the "Note Writer Main" pane
    And I enter "This is manually entered text" in the "ExamRespNormalQTV2" rich text field
    And I click the "Exam Neuro Normal" element in the "Note Writer Main" pane
    Then the following text should appear in the "Note Writer Main" pane
      |Negative for headache. No vertigo. Denies paresthesias. |
    And I enter "This is manually entered text" in the "ExamNeuroNormalQTV2" rich text field
    When I click the "Exam CV Abnormal" element in the "Note Writer" pane
    And I enter "PND and orthopnea" in the "ExamCVQTV2" rich text field in the "Note Writer Main" pane
    And I select the note "A/P" section
    And I enter "R52" in the "PN Diagnosis Search" field
    And I select "Moderate" from the "LevelOfDecision" dropdown
    And I click the "NoteWriterSign/Submit" button in the "Note Writer Main" pane
    And I enter "CSLVL1U3" in the "lookupField" field in the "CoSignSubmitNote" pane
    Then I select "CSLVL1U3" option from the "CoSign LookUp Search List" list
    And I enter "123" in the "PasswordField" field in the "CoSignSubmitNote" pane
    And I click the "SubmitCoSigNoteConfirm" button in the "CoSignSubmitNote" pane
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    And I select "*DRAFT* Progress Note" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And I delete the draft note in the "Progress Note" pane
    And I sort the "Clinical Notes" table chronologically by the "Date/Time" column in "Descending" order
    When I select "Progress Note" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And the text "Signed: Awaiting Co-signature" should appear in the "Progress Note" pane
    And I click the "Edit" button
    And I select the note "Subjective" section
    When I enter "User able to entered data in Subjective tab." in the "UpdateNoteSubjective" rich text field
    And I select the note "Exam" section
    When I enter "User able to entered data in Exam tab." in the "UpdateNoteExam" rich text field
    And I select the note "A/P" section
    When I enter "User able to entered data in A/P tab." in the "UpdateNoteAP" rich text field
    And I click the "NoteWriterSign/Submit" button in the "Note Writer Main" pane
    And I enter "CSLVL2U1" in the "lookupField" field in the "CoSignSubmitNote" pane
    Then I select "CSLVL2U1" option from the "CoSign LookUp Search List" list
    And I enter "123" in the "PasswordField" field in the "CoSignSubmitNote" pane
    And I click the "SubmitCoSigNoteConfirm" button in the "CoSignSubmitNote" pane
    And I wait "3" seconds
    And I select "Progress Note" from the "Note Type (\d of \d)" column in the "Clinical Notes" table
    And the text "User able to entered data in Subjective tab." should appear in the "Progress Note" pane
    Given I am logged into the portal with user "nwadmin" using the default password
    And I am on the "Admin" tab
    And I select the "System Management" subtab
    And I click the "Audit Report" link in the "System Management Navigation" pane
    When I enter "%Current Date MMDDYY%" in the "Start Date" field in the "Audit Report" pane
    And I enter "%Current Date MMDDYY%" in the "End Date" field in the "Audit Report" pane
    And I enter "CSlvl3u3" in the "Select Users" field in the "Audit Report" pane
    And I click the "Lookup User" element in the "Audit Report" pane
    And I select "CSlvl3u3" from the "Username" column in the "LookUpSearchResults" table
    And I click the "Show Audit Records" button in the "Audit Report" pane
    Then the "Audit Report" table should load
    Then rows containing the following should appear in the "Audit Report" table
      | Date/Time             | User                | Description                                                                                                    |
      | %Current Date MMDDYY% | SIGNATURE, CSLVL3U3 | Web - Author comments added to ( Subjective,Exam,Data,AP,Billing ) - Progress Note Tabs by SIGNATURE, CSLVL3U3 |


  Scenario:Pre required for Note in Signed Status=yes
    Given I am logged into the portal with user "nwadmin" using the default password
    And I am on the "Admin" tab
    And I select the "Institution" subtab
    And I select "NoteWriter" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    And I wait "2" seconds
    And I select "true" from the "NoteinSignedStatus" radio list in the "Note Writer Settings" pane
    And I click the "Save" button
    And I click "OK" in the confirmation box

  Scenario:Disable NoteWriter Co-signature
    Given I am logged into the portal with user "nwadmin" using the default password
    And I am on the "Admin" tab
    And I select the "Institution" subtab
    And I select "NoteWriter" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
    And I wait "2" seconds
    And I select "false" from the "Enable Quick Text Version 2" radio list in the "Note Writer Settings" pane
    And I select "false" from the "CoSignature" radio list in the "Note Writer Settings" pane
    And I select "None" from the "Validation" dropdown
    And I click the "Save" button
    And I click "OK" in the confirmation box









