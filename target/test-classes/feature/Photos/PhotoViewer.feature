@PhotoFeature
Feature: Photos feature

  Background:
    Given I am logged into the portal with user "pkadminv2" using the default password
    And I am on the "Patient List V2" tab
    And the patient list is maximized
    When I select "Photo Test" from the "Patient List" menu

  Scenario: Add photo to patient
    And I select patient "Molly Darr" from the patient list
    And I select "Photo Add" from clinical navigation
    And I enter "TestImage1" in the "Photo Description" field
    And I select "TestImage1.jpg" "image" file for "Choose File" option in the "Add Photo" pane
    And I click the "Upload" button
    When I click the "Warning OK" button in the "Information" pane
    Then I click the "Refresh PT Info" button

  Scenario: View photo
    And I select patient "Molly Darr" from the patient list
    And I select "Photos" from clinical navigation
    And I select "TestImage1" in the "Photo List" table
    And I click the "Close Photo Viewer" button

  Scenario: Verify navigation buttons are absent if a patient has only one photo
    And "Betsy Oates" is on the patient list
    And I select patient "Betsy Oates" from the patient list
    And I select "Photo Add" from clinical navigation
    And I enter "TestImage1" in the "Photo Description" field
    And I select "TestImage1.jpg" "image" file for "Choose File" option in the "Add Photo" pane
    And I click the "Upload" button
    When I click the "Warning OK" button in the "Information" pane
    Then I click the "Refresh PT Info" button
    And I select "Photos" from clinical navigation
    And I select "TestImage1" in the "Photo List" table
    Then the "Navigate Back Photo Viewer" "Button" should not be visible
    Then the "Navigate Next Photo Viewer" "Button" should not be visible
    And I click the "Close Photo Viewer" button

  Scenario: Verify navigation buttons work
    And I select patient "Molly Darr" from the patient list
    And I select "Photo Add" from clinical navigation
    And I enter "TestImage2" in the "Photo Description" field
    And I select "TestImage2.jpg" "image" file for "Choose File" option in the "Add Photo" pane
    And I click the "Upload" button
    When I click the "Warning OK" button in the "Information" pane
    Then I click the "Refresh PT Info" button
    And I select "Photos" from clinical navigation
    And I select "TestImage1" in the "Photo List" table
    And I store the photoID of the image "TestImage1"
    And I click the "NavigateNextPhotoViewer" button
    And I store the photoID of the image "TestImage2"
    And I click the "NavigateBackPhotoViewer" button
    And I check the photoID of the image "TestImage1"
    And I click the "NavigateNextPhotoViewer" button
    And I check the photoID of the image "TestImage2"
    And I click the "Close Photo Viewer" button

  Scenario: Check the message when there is no photo
    And I select patient "Heath, Neil" from the patient list
    And I select "Photos" from clinical navigation
    Then the text "There are no photos for the current patient" should appear in the "NoPhotoMessage" pane

  Scenario: Verify Photo List table sorts correctly by Title column
    And I select patient "Molly Darr" from the patient list
    And I select "Photo Add" from clinical navigation
    And I enter "AZ Image" in the "Photo Description" field
    And I select "TestImage1.jpg" "image" file for "Choose File" option in the "Add Photo" pane
    And I click the "Upload" button
    When I click the "Warning OK" button in the "Information" pane
    And I enter "GA Image" in the "Photo Description" field
    And I click the "Upload" button
    When I click the "Warning OK" button in the "Information" pane
    And I enter "ZB Image" in the "Photo Description" field
    And I click the "Upload" button
    When I click the "Warning OK" button in the "Information" pane
    And I enter "1 Image" in the "Photo Description" field
    And I click the "Upload" button
    When I click the "Warning OK" button in the "Information" pane
    And I enter "2 Image" in the "Photo Description" field
    And I click the "Upload" button
    When I click the "Warning OK" button in the "Information" pane
    And I enter "3 Image" in the "Photo Description" field
    And I click the "Upload" button
    When I click the "Warning OK" button in the "Information" pane
    Then I click the "Refresh PT Info" button
    And I select "Photos" from clinical navigation
    And I sort the "Photo List" table alphabetically by the "Title" column in "Ascending" order
    Then the "Photo List" table should be alphabetically sorted by "Title" in "Ascending" order
    And I sort the "Photo List" table alphabetically by the "Title" column in "Descending" order
    Then the "Photo List" table should be alphabetically sorted by "Title" in "Descending" order

  Scenario: Verify Photo List table sorts correctly by Date/Time column
    And I select patient "Molly Darr" from the patient list
    And I select "Photos" from clinical navigation
    And I sort the "Photo List" table chronologically by the "Date/Time" column in "Ascending" order
    Then the "Photo List" table should be chronologically sorted by "Date/Time" in "Ascending" order
    And I sort the "Photo List" table chronologically by the "Date/Time" column in "Descending" order
    Then the "Photo List" table should be chronologically sorted by "Date/Time" in "Descending" order

  Scenario: Verify Photo List table sorts correctly by Created By column
    And I am logged into the portal with user "PhotoSort1" using the default password
    And I am on the "Patient List V2" tab
    When I select "Photo Test" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Photo Add" from clinical navigation
    And I enter "TestSort1" in the "Photo Description" field
    And I select "TestImage1.jpg" "image" file for "Choose File" option in the "Add Photo" pane
    And I click the "Upload" button
    When I click the "Warning OK" button in the "Information" pane
    And I am logged into the portal with user "PhotoSort2" using the default password
    And I am on the "Patient List V2" tab
    When I select "Photo Test" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Photo Add" from clinical navigation
    And I enter "TestSort2" in the "Photo Description" field
    And I select "TestImage1.jpg" "image" file for "Choose File" option in the "Add Photo" pane
    And I click the "Upload" button
    When I click the "Warning OK" button in the "Information" pane
    And I am logged into the portal with user "PhotoSort3" using the default password
    And I am on the "Patient List V2" tab
    When I select "Photo Test" from the "Patient List" menu
    And "Molly Darr" is on the patient list
    And I select patient "Molly Darr" from the patient list
    And I select "Photo Add" from clinical navigation
    And I enter "TestSort3" in the "Photo Description" field
    And I select "TestImage1.jpg" "image" file for "Choose File" option in the "Add Photo" pane
    And I click the "Upload" button
    When I click the "Warning OK" button in the "Information" pane
    Then I click the "Refresh PT Info" button
    And I select patient "Molly Darr" from the patient list
    And I select "Photos" from clinical navigation
    And I sort the "Photo List" table alphabetically by the "Created By" column in "Ascending" order
    Then the "Photo List" table should be alphabetically sorted by "Created By" in "Ascending" order
    And I sort the "Photo List" table alphabetically by the "Created By" column in "Descending" order
    Then the "Photo List" table should be alphabetically sorted by "Created By" in "Descending" order

  Scenario: Check if the photo list have all the options
    And I select patient "Molly Darr" from the patient list
    And I select "Photos" from clinical navigation
    And I select "TestImage1" in the "Photo List" table
    Then the "Rotate Right" "Button" should be visible
    Then the "Rotate Left" "Button" should be visible
    Then the "Original Size" "Button" should be visible
    Then the "Fit To Screen" "Button" should be visible
    Then the "Purge" "Button" should be visible
    Then the "Zoom In" "Button" should be visible
    Then the "Zoom Out" "Button" should be visible

  Scenario: Delete a photo
    And I select patient "Molly Darr" from the patient list
    And I select "Photo Add" from clinical navigation
    And I enter "Delete Me" in the "Photo Description" field
    And I select "TestImage1.jpg" "image" file for "Choose File" option in the "Add Photo" pane
    And I click the "Upload" button
    When I click the "Warning OK" button in the "Information" pane
    Then I click the "Refresh PT Info" button
    And I select "Photos" from clinical navigation
    And I click the "Delete Photo" button in the row with "Delete Me" as the value under "Title" in the "Photo List" table
    And I click the "Confirm Yes" button in the "Delete Dialog" pane
    Then I click the "Refresh PT Info" button
    Then the text "Delete Me" should not appear in the "Photos" pane

  Scenario: Cancel delete a photo
    And I select patient "Molly Darr" from the patient list
    And I select "Photo Add" from clinical navigation
    And I enter "Cancel Delete" in the "Photo Description" field
    And I select "TestImage1.jpg" "image" file for "Choose File" option in the "Add Photo" pane
    And I click the "Upload" button
    When I click the "Warning OK" button in the "Information" pane
    Then I click the "Refresh PT Info" button
    And I select "Photos" from clinical navigation
    And I click the "Delete Photo" button in the row with "Cancel Delete" as the value under "Title" in the "Photo List" table
    And I click the "Confirm No" button in the "Delete Dialog" pane
    Then I click the "Refresh PT Info" button
    Then the text "Cancel Delete" should appear in the "Photos" pane

  Scenario: Rotate photo clockwise
    And I select patient "Molly Darr" from the patient list
    And I select "Photos" from clinical navigation
    And I select "TestImage1" in the "Photo List" table
    And I click the "Rotate Right" button
    And I check the rotation for the "Current Image"
    And I click the "Close Photo Viewer" button

  Scenario: Rotate photo counter clockwise
    And I select patient "Molly Darr" from the patient list
    And I select "Photos" from clinical navigation
    And I select "TestImage1" in the "Photo List" table
    And I click the "Rotate Left" button
    And I check the rotation for the "Current Image"
    And I click the "Close Photo Viewer" button

  Scenario: Change photo size
    And I select patient "Molly Darr" from the patient list
    And I select "Photos" from clinical navigation
    And I select "TestImage1" in the "Photo List" table
    And I click the "Original Size" button
    Then the "Current Image" image is oiginal size
    And I click the "Fit To Screen" button
    Then the "Current Image" image fits the screen
    And I click the "Close Photo Viewer" button

  Scenario: Zoom photo
    And I select patient "Molly Darr" from the patient list
    And I select "Photos" from clinical navigation
    And I select "TestImage1" in the "Photo List" table
    And I zoom in the photo
    And I zoom out the photo
    And I click the "Close Photo Viewer" button

  Scenario: Purge Photo
    And I select patient "Molly Darr" from the patient list
    And I select "Photos" from clinical navigation
    And I select "TestImage1" in the "Photo List" table
    And I purge the photo
    And I wait "2" seconds
    And I unpurge the photo
    And I click the "Close Photo Viewer" button

  Scenario: Check photo Viewer functions from Edit Visits
    And I select patient "Molly Darr" from the patient list
    And I select "Visits" from clinical navigation
    And I select "the first item" in the "Visits" table
    And I click the "Edit Visit" button
    And I click the "Photos" button
    And I select "TestImage1" in the "Photo List POPUP" table
    And I click the "Rotate Right_POP" button
    And I check the rotation for the "CurrentImage_POP_UP"
    And I click the "Close Photo Popup" button
    And I click the "Cancel" button in the "Edit Visit" pane

  Scenario: Check no photo message from Edit Visits
    And I select patient "Neil Heath" from the patient list
    And I select "Visits" from clinical navigation
    And I select "the first item" in the "Visits" table
    And I click the "EditVisit" button
    And I click the "Photos" button
    Then the text "There are no photos for the current patient" should appear in the "NoPhotoMessage_POP_UP" pane
    And I click the "Close Photo Popup" button
    And I click the "Cancel" button in the "Edit Visit" pane

  Scenario: Check if the photo list can sort by Title from Edit Visits
    And I select patient "Molly Darr" from the patient list
    And I select "Visits" from clinical navigation
    And I select "the first item" in the "Visits" table
    And I click the "EditVisit" button
    And I click the "Photos" button
    And I sort the "Photo List POPUP" table alphabetically by the "Title" column in "Ascending" order
    Then the "Photo List POPUP" table should be alphabetically sorted by "Title" in "Ascending" order
    And I sort the "Photo List POPUP" table alphabetically by the "Title" column in "Descending" order
    Then the "Photo List POPUP" table should be alphabetically sorted by "Title" in "Descending" order
    And I click the "Close Photo Popup" button
    And I click the "Cancel" button in the "Edit Visit" pane

  Scenario: Check photo Viewer functions from Charge Entry
    And I select patient "Molly Darr" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I click the "Photos_AddCharge" button
    And I select "TestImage1" in the "Photo List POPUP" table
    And I click the "Rotate Right_POP" button
    And I check the rotation for the "CurrentImage_POP_UP"
    And I click the "Close Photo Popup" button
    And I click the "Cancel Add Charge" button in the "Charge Entry" pane

  Scenario: Check no photo message from Charge Entry
    And I select patient "Neil Heath" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I click the "Photos_AddCharge" button
    Then the text "There are no photos for the current patient" should appear in the "NoPhotoMessage_POP_UP" pane
    And I click the "Close Photo Popup" button
    And I click the "Cancel Add Charge" button in the "Charge Entry" pane

  Scenario: Check if the photo list can sort by Title from Charge Entry
    And I select patient "Molly Darr" from the patient list
    And I select "Add Charge" from the "Patient Header Actions" menu
    And I click the "Photos_AddCharge" button
    And I sort the "Photo List POPUP" table alphabetically by the "Title" column in "Ascending" order
    Then the "Photo List POPUP" table should be alphabetically sorted by "Title" in "Ascending" order
    And I sort the "Photo List POPUP" table alphabetically by the "Title" column in "Descending" order
    Then the "Photo List POPUP" table should be alphabetically sorted by "Title" in "Descending" order
    And I click the "Close Photo Popup" button
    And I click the "Cancel Add Charge" button in the "Charge Entry" pane

  Scenario: Check no photo message from Edit Patient
    Given "Test, NoPhoto*", admitted in the last " " days, is on the patient list
    And I select patient "Test, NoPhoto*" from the patient list
    And I select "Patient Detail" from clinical navigation
    And I click the "EditPatient" button
    And I click the "Photos" button
    Then the text "There are no photos for the current patient" should appear in the "NoPhotoMessage_POP_UP" pane
    And I click the "Close Photo Popup" button
    And I click the "Edit Patient Cancel" button

  Scenario: Check photo Viewer functions from Edit Patient
    Given "Test, Photo*", admitted in the last " " days, is on the patient list
    And I select patient "Test, Photo*" from the patient list
    And I select "Photo Add" from clinical navigation
    And I enter "TestImage1" in the "Photo Description" field
    And I select "TestImage1.jpg" "image" file for "Choose File" option in the "Add Photo" pane
    And I click the "Upload" button
    When I click the "Warning OK" button in the "Information" pane
    Then I click the "Refresh PT Info" button
    And I select "Patient Detail" from clinical navigation
    And I click the "Edit Patient" button
    And I click the "Photos" button
    And I select "TestImage1" in the "Photo List POPUP" table
    And I click the "Rotate Right_POP" button
    And I check the rotation for the "CurrentImage_POP_UP"
    And I click the "Close Photo Popup" button
    And I click the "Edit Patient Cancel" button

  Scenario: Check if the photo list can sort by Title from Edit Patient
    And "Test, Photo*", admitted in the last " " days, is on the patient list
    And I select patient "Test, Photo*" from the patient list
    And I select "Photo Add" from clinical navigation
    And I enter "AZ Image" in the "Photo Description" field
    And I select "TestImage1.jpg" "image" file for "Choose File" option in the "Add Photo" pane
    And I click the "Upload" button
    When I click the "Warning OK" button in the "Information" pane
    And I enter "GA Image" in the "Photo Description" field
    And I click the "Upload" button
    When I click the "Warning OK" button in the "Information" pane
    And I enter "ZB Image" in the "Photo Description" field
    And I click the "Upload" button
    When I click the "Warning OK" button in the "Information" pane
    And I enter "1 Image" in the "Photo Description" field
    And I click the "Upload" button
    When I click the "Warning OK" button in the "Information" pane
    And I enter "2 Image" in the "Photo Description" field
    And I click the "Upload" button
    When I click the "Warning OK" button in the "Information" pane
    And I enter "3 Image" in the "Photo Description" field
    And I click the "Upload" button
    When I click the "Warning OK" button in the "Information" pane
    Then I click the "Refresh PT Info" button
    And I select "Patient Detail" from clinical navigation
    And I click the "Edit Patient" button
    And I click the "Photos" button
    And I sort the "Photo List POPUP" table alphabetically by the "Title" column in "Ascending" order
    Then the "Photo List POPUP" table should be alphabetically sorted by "Title" in "Ascending" order
    And I sort the "Photo List POPUP" table alphabetically by the "Title" column in "Descending" order
    Then the "Photo List POPUP" table should be alphabetically sorted by "Title" in "Descending" order
    And I click the "Close Photo Popup" button
    And I click the "Edit Patient Cancel" button