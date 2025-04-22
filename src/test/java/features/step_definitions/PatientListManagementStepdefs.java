package features.step_definitions;

import cucumber.api.DataTable;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import features.Hooks;
import frames.PatientSearch_Frames;
import org.apache.commons.lang3.StringUtils;
import org.json.simple.JSONObject;
import org.junit.Assert;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import pageObject.PatientListPage;
import support.Page;
import utils.UtilFunctions;
import constants.GlobalConstants;
import common.SeleniumFunctions;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static features.Hooks.driver;
import static features.step_definitions.GlobalStepdefs.curTabName;

/**
 * Created by PatientKeeper on 6/30/2016.
 */

/******************************************************************************
 Class Name: PatientListManagementStepdefs
 Contains step definitions related to patient list management
 ******************************************************************************/

public class PatientListManagementStepdefs {

    public String className = getClass().getSimpleName();

    @Given("^\"(.*?)\" is( not)? on the patient list()$")
    public void addRemovePatientOnPatientList(String patientName, String not, String includePastVisits) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        GlobalStepdefs globalStepsObj = new GlobalStepdefs();
        if (not == null) {//Then the patient should be on or added to the patient list
            if (PatientListPage.findPatientByName(Hooks.getDriver(), UtilFunctions.reformName(patientName).toUpperCase()) == null) {
                //check if patient is already on list
                UtilFunctions.log("Patient: " + patientName + " is not present on list. Adding patient.");

                //When I select "Add Patient" from the "Actions" menu
                globalStepsObj.selectFromMenu("Add Patient", "Actions", null, null);

                //And I click the "Clear Criteria" button
                SeleniumFunctions.explicitWait(Hooks.getDriver(), 10,
                        PatientSearch_Frames.patientSearchFramesMap.get("FRAME_SEARCH_CRITERIA") + ";name");
                globalStepsObj.clickButton("Clear Criteria", null, null);

                //And I enter "#{days}" in the "Admit in last N days" field
                globalStepsObj.enterInTheField(PatientListPage.getNoOfDays(), "Admit in last N days", null);

                //And I "uncheck" the following |Include Cancelled Visits|   |Include Past Visits     |
                List<String> checkBoxNames = Arrays.asList("Include Cancelled Visits", "Include Past Visits");
                if (includePastVisits.equals("past")) {
                    globalStepsObj.checkMultipleCheckBoxes("check", null, checkBoxNames);
                } else {
                    globalStepsObj.checkMultipleCheckBoxes("uncheck", null, checkBoxNames);
                }

                //And I search for patient "#{patientName}"
                searchForPatient(patientName, "");

                //And I select patient "#{patientName}" from the "Name (\\d)"  column in the "Add Patient Search" table
                globalStepsObj.selectPatientFromTheColumnInTable(patientName, "Name", "Add Patient Search");
                Thread.sleep(500);

                //And I select "ADMITTING" from the "Relationship" dropdown if the current tab is PatientList
                if (GlobalStepdefs.curTabName.equals("PatientList")) {
                    globalStepsObj.selectFromDropdown("ADMITTING", "Relationship", null,
                            null);
                }

                //And I click the "Add" button in the "Add patient(s) to your patient list" pane
                globalStepsObj.clickButton("Add", "Add patient(s) to your patient list", null);
                globalStepsObj.waitForFieldAttributeValue("10", "Add Patient Result", "PANE",
                        "Add Patient Result", "be invisible", null, null);
                Thread.sleep(500);

                //And I click the "Close" button in the "Add patient(s) to your patient list" pane
                globalStepsObj.clickButton("Close", "Add patient(s) to your patient list", null);
                Thread.sleep(1000);

                //And I refresh the patient list
                PatientListDisplayStepdefs patientListDisplayObj = new PatientListDisplayStepdefs();
                patientListDisplayObj.refreshPatientList();
            } else {
                UtilFunctions.log("Patient: " + patientName + " is already present on the list.");
            }
        } else {//The patient should not be on the patient list or should be removed from the patient list
            if (PatientListPage.findPatientByName(Hooks.getDriver(), UtilFunctions.reformName(patientName).toUpperCase()) != null) {
                //check if patient is already not on the list
                UtilFunctions.log("Patient: " + patientName + " is present on list. Deleting the patient.");

                //Select the given patient
                Assert.assertTrue(patientName + " could not be selected and was not removed from patient list.",
                        PatientListPage.selectPatientByName(Hooks.getDriver(), patientName));
                //Click the Actions menu and select Remove Patient
                globalStepsObj.selectFromMenu("Remove Patient", "Actions", null, null);
                Assert.assertTrue("Yes button not clicked to remove " + patientName + " from patient list.",
                        Page.clickButton(Hooks.getDriver(), GlobalStepdefs.curTabName, "Yes"));
                //Assert the patient is no longer on the patient list
                Assert.assertNull(patientName + " still found on patient list, not successfully removed.",
                        PatientListPage.findPatientByName(Hooks.getDriver(), UtilFunctions.reformName(patientName).toUpperCase()));

                //Why is this removing all of the patients from the specified patient list?
                /*globalStepsObj.selectFromMenu("Remove Multiple Patients", "Actions", null, null);
                globalStepsObj.clickButton("Select All", null, null);
                globalStepsObj.clickButton("Remove", "Remove Patient(s) from PSList", null);
                globalStepsObj.clickButton("Close", "Remove Patient(s) from PSList", "exists");

                //Switch to PLV2 frame
                String frameName;
                if (GlobalStepdefs.curTabName.equals("PatientListV2"))
                    frameName = "FRAME_LISTV2";
                else
                    frameName = "FRAME_LIST";
                String paneFrames = UtilFunctions.getFrameValue(UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName),
                        frameName);
                UtilFunctions.log("PaneFrames: " + paneFrames);
                SeleniumFunctions.selectFrame(driver, paneFrames, "id");
                SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.TEN,
                        "//span[@class='common-text' and text()='No patients meet the current patient list criteria.']"
                                + ";xpath");*/
            } else {
                UtilFunctions.log("Patient: " + patientName + " is not present on the list.");
            }
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @Given("^\"(.*?)\", admitted in the (last|past)? \"(.*?)\" days, is on the patient list$")
    public void selectPatientOnPatientListInLastNDays(String patientName, String includePastVisits, String days) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        PatientListPage.setNoOfDays(days);
        addRemovePatientOnPatientList(patientName, null, includePastVisits);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I search for patient \"(.*?)\"(?:, admitted in the last \"(.*?)\" days)?$")
    public void searchForPatient(String patientName, String days) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String firstName = "";
        String lastName = "";
//        String days = "";
        GlobalStepdefs globalStepsObj = new GlobalStepdefs();

        String tabName = globalStepsObj.curTabName;

        if (!patientName.contains(",")) {
            String[] patientNameArr = patientName.split(" ");
            firstName = patientNameArr[0];
            lastName = patientNameArr[patientNameArr.length - 1];
        } else {
            String[] patientNameArr = patientName.split(",");
            String[] firstMiddleNameStr = patientNameArr[1].trim().split(" ");
            firstName = firstMiddleNameStr[0];
            lastName = patientNameArr[0];
        }
        if (firstName.endsWith("*"))
            firstName = firstName.replace("*", "");

        Assert.assertTrue("Text Box Object Not found", Page.setTextBox(Hooks.getDriver(), tabName, firstName, "SearchFirstName"));
        Assert.assertTrue("Text Box Object Not found", Page.setTextBox(Hooks.getDriver(), tabName, lastName, "SearchLastName"));

        if (!StringUtils.isEmpty(days)) {
            Assert.assertTrue("Text Box Object Not found", Page.setTextBox(Hooks.getDriver(), tabName, days, "AdmitinlastNdays"));
        }

        globalStepsObj.clickButton("VisitSearch", null, null);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

//Overloaded and Refactored, see below -- HIC 11/19/18
    /*@When("^I drag the order link to section field in Edit order set pane$")
    public void dragAndDrop() throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        WebElement source = SeleniumFunctions.findElement(Hooks.getDriver(),
                SeleniumFunctions.setByValues("//span[@class='toolboxItem ui-draggable' and text()='Order' and ancestor::div[@id='toolboxContainer']]"));
        WebElement target = SeleniumFunctions.findElement(Hooks.getDriver(),
                SeleniumFunctions.setByValues("//div[@class='sectionLayoutContentContainer']"));
        Page.dragAndDrop(Hooks.getDriver(), source, target);
        Thread.sleep(3000);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }
*/

    //Overloaded dragAndDrop()
    @When("^I drag the \"(.*?)\" to section field in Edit order set pane$")
    public void dragAndDrop(String componentName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        WebElement target = SeleniumFunctions.findElement(Hooks.getDriver(),
                SeleniumFunctions.setByValues("//div[@class='sectionLayoutContentContainer']"));
        Page.dragAndDrop(Hooks.getDriver(), componentName, target, curTabName);
        Thread.sleep(3000);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @When("^there should be( at least)? \"(\\d+)\" item(?:s)? on the formulary list and( at least)? \"(\\d+)\" items on the non formulary list$")
    public void checkFormularyAndNonFormulary(String min1, String numItems1, String min2, String numItems2) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        PatientListPage.checkCountOfFormularyAndNonFormularyListItems(min1, numItems1, min2, numItems2);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");

    }

    @And("^the following patients should( not)? be on \"(.*?)\" PatientList$")
    public void checkPatientOnPatientList(String no, String paneName, DataTable dataTable) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String tabName = GlobalStepdefs.curTabName;
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        paneName = paneName.replace(" ", "");
        String paneFrames = (String) frameMap.get(UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");

        String patientPath;
        WebElement elt;
        boolean success = false;
        List<String> dataList = dataTable.asList(String.class);

        for (String patient : dataList) {
            patientPath = "//span[@class='PAT_FULLNAME' and text() = '" + patient.toUpperCase() + "']";
            elt = SeleniumFunctions.findElement(Hooks.getDriver(), By.xpath(patientPath));
            if (no != null && (" not").equals(no)) {
                if (elt == null) {
                    //Success should NEVER be FALSE when element is null. Element is null, and we are checking for element not to be present, this clearly explains that success SHOULD BE TRUE.
                    //success = false;
                    success = true;
                } else {
                    success = false;
                    break;
                }
            } else {
                if (elt != null) {
                    success = true;
                } else {
                    success = false;
                    break;
                }
            }
        }
        Assert.assertTrue(success);
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^the patient list should be empty$")
    public void checkIfPatientListEmpty() throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        boolean populated = true;
        if (PatientListPage.getNumPatients("") != 0) {
            wait(5);
        }
        if (PatientListPage.getNumPatients("") == 0) {
            populated = false;
        } else {
            populated = true;
        }
        Assert.assertFalse(populated);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @And("^I do the following TimeBasedCriteria settings$")
    public void timeBasedCriteriaSettings(DataTable tbcRows) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String paneName = "TimeCriteria";
        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        List<Map<String, String>> dataList = tbcRows.asMaps(String.class, String.class);
        for (Map data : dataList) {
            String typeTBC = ((String) data.get("Type")).replace(" ", "");
            String AddPatients = ((String) data.get("Add Patients")).replace(" ", "");

            String RemovePatients = ((String) data.get("Remove Patients")).replace(" ", "");

            boolean flag;

            JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
            HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
            UtilFunctions.log("SectionName: " + typeTBC);
            String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
            SeleniumFunctions.selectFrame(driver, paneFrame, "id");

            //check checkbox for TBC settings
            if (AddPatients.equals("N/A")) {
                //uncheck check box
                Page.setCheckBox(driver, GlobalStepdefs.curTabName, typeTBC, "uncheck", null);
            } else {

                WebElement checkb = Page.findCheckBoxObj(driver, typeTBC, "value");
                flag = Page.getCheckBoxStatus(driver, GlobalStepdefs.curTabName, typeTBC, "checked", "TimeCriteria");
                if (flag == true) {
                    checkb.click();
                }
                Page.setCheckBox(driver, GlobalStepdefs.curTabName, typeTBC, "check", "TimeCriteria");

                //set the Add and Remove Patients settings
                String addPatientVal = AddPatients;
                PatientListPage.patientListTimeBasedCriteriaSetting(addPatientVal, typeTBC, "Add");
                String removePatientVal = RemovePatients;
                PatientListPage.patientListTimeBasedCriteriaSetting(removePatientVal, typeTBC, "Add");
                //click Save button after TBC settings is done
                globalStepdefs.clickButton("SaveButtonTBC", "TimeCriteria", null);
            }

            UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
            }.getClass().getEnclosingMethod().getName() + " : Complete");

        }

    }

    @And("^I add the following Assignment Sub List$")
    public void addSubList(DataTable subAssignmentList) throws Throwable {


        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String tabName = GlobalStepdefs.curTabName;
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);

        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        String buttonName = "AddAssignmentList";
        String textfieldName = "SublistName";
        String buttonFrames = (String) frameMap.get(UtilFunctions.getElementFromJSONFile(fileObj, "BUTTONS." + buttonName, "frame"));
        SeleniumFunctions.selectFrame(Hooks.getDriver(), buttonFrames, "id");
        String addSubListButtonPath = UtilFunctions.getElementFromJSONFile(fileObj, "BUTTONS." + buttonName, "path");
        List<String> dataList = subAssignmentList.asList(String.class);
        int tempCount = 0;
        for (String item : dataList) {
            String addSubListTextPath = UtilFunctions.getElementFromJSONFile(fileObj, "TEXT_FIELDS." + textfieldName, "path");
            SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(addSubListButtonPath + ";xpath")).click();

            addSubListTextPath = addSubListTextPath.replace("name_", "name_" + (tempCount));
            WebElement txtObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(addSubListTextPath + ";xpath"));
            txtObj.click();
            txtObj.clear();
            txtObj.sendKeys(item);
            addSubListTextPath = null;
            tempCount++;
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I drag and drop following locations one by one at the top in \"(.*?)\" pane$")
    public void dragAndDropLocations(String paneName, DataTable dataTable) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);

        String paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName.replace(" ", ""), "frame"));
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");

        String target = UtilFunctions.getElementFromJSONFile(fileObj, "MISC_ELEMENTS." + "locationsListFirstElement", "path");
        WebElement targetElement = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues(target + ";xpath"));

        List<String> locationlist = dataTable.asList(String.class);
        for (String location : locationlist) {
            String listSource = UtilFunctions.getElementFromJSONFile(fileObj, "MISC_ELEMENTS." + "locationsWithText", "path");
            listSource = listSource.replace("textVal", location);
            WebElement sourceElement = SeleniumFunctions.findElement(Hooks.getDriver(), By.xpath(listSource));
            Page.dragAndDrop(Hooks.getDriver(), sourceElement, targetElement);
            Thread.sleep(250);
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Given("^I drag and drop the settings for the \"(.*?)\" Section as follows$")
    public void dragAndDropSettings(String sectionName, DataTable dataTable) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        WebElement colSpan = SeleniumFunctions.findElement(Hooks.getDriver(), By.xpath("//*[@id='createPatientListDisplayBuilderview8']//table/tbody/tr/td[@colspan='2']"));
        WebElement delRow = SeleniumFunctions.findElement(Hooks.getDriver(), By.xpath("//*[@id='createPatientListDisplayBuilderview8' and descendant-or-self::a[text()='Delete Row']]"));
        WebElement firstRow = SeleniumFunctions.findElement(Hooks.getDriver(), By.xpath("//*[@id='createPatientListDisplayBuilderview8']//table/tbody/tr/td[@class='layout-cell-area ui-droppable']"));
        WebElement insertRow = SeleniumFunctions.findElement(Hooks.getDriver(), By.xpath("//*[@id='createPatientListDisplayBuilderview8' and descendant-or-self::a[text()='Merge Right']]"));


        if (sectionName.equals("Display")) {
            String displayOptions = UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + "SelectedOptionsOnDisplay", "path");
            List<WebElement> displayOptionList = SeleniumFunctions.findElements(Hooks.getDriver(), SeleniumFunctions.setByValues(displayOptions + ";xpath"));

            for (WebElement listItem : displayOptionList) {
                String paneFrames = (String) frameMap.get(UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + "SelectedOptionsOnDisplay", "frame"));
                SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");
                listItem.click();
            }

            if (colSpan != null) {
                colSpan.click();
                delRow.click();
                firstRow.click();
                insertRow.click();

            }
        }

        List<List<String>> dataList = dataTable.raw();
        int rowIndex = 1;
        for (List<String> row : dataList) {
            String paneFrames = (String) frameMap.get(UtilFunctions.getElementFromJSONFile(fileObj, "DRAG_AND_DROP." + sectionName, "frame"));
            SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");
            int columnCount = row.size();
            int colIndex = 1;
            for (int i = 0; i < colIndex; i++) {
                int rowToBeDroppedAt = rowIndex;
                int colToBeDroppedAt = i + 1;
                String elementToDrag = row.get(Integer.valueOf(i));
                String[] allElementsToDrag = elementToDrag.split(",");
                for (String element : allElementsToDrag) {
                    String source = UtilFunctions.getElementFromJSONFile(fileObj, "DRAG_AND_DROP." + sectionName, "source").replace("sourceName", element.trim());
                    WebElement sourceElement = SeleniumFunctions.findElement(Hooks.getDriver(), By.xpath(source.trim()));
                    WebElement targetElement = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues(UtilFunctions.getElementFromJSONFile(fileObj, "DRAG_AND_DROP." + sectionName, "target") + "tr[" + String.valueOf(rowToBeDroppedAt) + "]/td[" + String.valueOf(colToBeDroppedAt) + "]"));
                    try {
                        Page.dragAndDrop(Hooks.getDriver(), sourceElement, targetElement);
                        Thread.sleep(3000);
                    } catch (Exception e) {
                        UtilFunctions.log("Source or Target not found");
                    }
                }
                colIndex = colIndex + 1;
                if (colIndex > columnCount) {
                    break;
                }

            }
            rowIndex = rowIndex + 1;
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^the visit cell for patient \"(.*?)\" in \"(.*?)\" table should contain the following( Discharged status)?$")
    public void checkVisitCellData(String patientName, String tableName, String status, DataTable dataTable) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        PatientListClinicalsStepdefs patientListClinicalStepsObj = new PatientListClinicalsStepdefs();
        PatientListV2Stepdefs patientListV2Stepobj = new PatientListV2Stepdefs();

        tableName = tableName.replace(" ", "");

        String[] tableDetailArr = UtilFunctions.getTableValues(GlobalStepdefs.curTabName, tableName);
        String tablePath = tableDetailArr[0];
        UtilFunctions.log("tablePath: " + tablePath);
        String visitId = null;

        if (tableName.equals("PatientList")) {
            patientListClinicalStepsObj.selectPatientFromPatientList(patientName);
            if (patientName != null) {
                patientListV2Stepobj.setPatientListDisplayOptions();
            }
            String curNav = PatientListPage.getClinicalNav(Hooks.getDriver(), "").trim();
            PatientListPage.selectClinicalNav(Hooks.getDriver(), "Patient Detail", "");
            if (status != null) {
                visitId = Page.getTableFieldValue(Hooks.getDriver(), GlobalStepdefs.curTabName,
                        "Patient Detail", "Last InFacility Visit", "PK Visit Key");
            } else {
                visitId = Page.getTableFieldValue(Hooks.getDriver(), GlobalStepdefs.curTabName,
                        "Patient Detail", "InFacility Visit", "PK Visit Key");
                if (visitId == null)
                    visitId = Page.getTableFieldValue(Hooks.getDriver(), GlobalStepdefs.curTabName,
                            "Patient Detail", "Last InFacility Visit", "PK Visit Key");
            }
            PatientListPage.selectClinicalNav(Hooks.getDriver(), curNav, "");
        } else {
            patientName = UtilFunctions.reformName(patientName);

            JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
            HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
            String paneFrames = (String) frameMap.get(UtilFunctions.getElementFromJSONFile(fileObj, "TABLES." +
                    tableName, "frame"));
            SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");

            WebElement tableObject = Page.findTable(Hooks.getDriver(), tablePath);
            WebElement body = SeleniumFunctions.findElementByWebElement(tableObject, By.tagName("tbody"));
            String path = ".//" + "tr[descendant::span[@class='PAT_FULLNAME' and text()='" + patientName + "']]";

            WebElement rows = SeleniumFunctions.findElementByWebElement(body, By.xpath(path));

            visitId = rows.getAttribute("visitid").trim();
        }

        List<List<String>> table = dataTable.raw();

        if (Page.compareTableBodies(tableName, table, visitId)) {
            Assert.assertTrue("Table values does not match", true);
            UtilFunctions.log("Table values match on 1st try: Table Name: " + tableName + ", \t Visit ID: "
                    + visitId);
        } else {
            Assert.assertTrue("Table values does not match", Page.compareTableBodies(tableName, table, visitId));
            UtilFunctions.log("Table values match on 2nd try: Table Name: " + tableName + ", \t Visit ID: "
                    + visitId);
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Given("^there are no patients on the patient list$")
    public void checkForNoPatients() throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String tableType = "PatientList";
        int count = PatientListPage.getNumPatients(tableType);
        if (count != 0) {
            Page.selectFromPKActionsMenu(driver, "Actions", "Remove Multiple Patients", GlobalStepdefs.curTabName);
            Page.clickButton(driver, GlobalStepdefs.curTabName, "Select All", "Remove Patients from your Short List");
            GlobalStepdefs globalStepdefs = new GlobalStepdefs();
            globalStepdefs.waitGivenTime("1");
            Page.clickButton(driver, GlobalStepdefs.curTabName, "Remove");

            UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
            }.getClass().getEnclosingMethod().getName() + " : Complete");
        }

    }

    @And("^\"(.*?)\" is( not)? on the patient lists$")
    public void selectPatientfromPatientList(String patientName, String no) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        GlobalStepdefs globalStepsObj = new GlobalStepdefs();
        if (no == null) {
            if (PatientListPage.findPatientByName(Hooks.getDriver(), UtilFunctions.reformName(patientName).toUpperCase()) == null) {
                UtilFunctions.log("Patient: " + patientName + " is not present on list. Adding patient.");
                /**************************************************************************
                 * Following setps are performed by the below code:
                 * When I select "Add Patient" from the "Actions" menu
                 * And I click the "Clear Criteria" button
                 * And I enter "#{days}" in the "Admit in last N days" field
                 * And I "uncheck" the following
                 |Include Cancelled Visits|
                 |Include Past Visits     |
                 * And I search for patient "#{patientName}"
                 * And I select patient "#{patientName}" from the "Name (\\d)"
                 column in the "Add Patient Search" table
                 *************************************************************************/
                globalStepsObj.selectFromMenu("Add Patient", "Actions", null, null);
                SeleniumFunctions.explicitWait(Hooks.getDriver(), 10, PatientSearch_Frames.patientSearchFramesMap.get("FRAME_SEARCH_CRITERIA") + ";name");
                globalStepsObj.clickButton("Clear Criteria", null, null);
                globalStepsObj.enterInTheField(PatientListPage.getNoOfDays(), "Admit in last N days", null);
                List<String> checkBoxNames = Arrays.asList("Include Cancelled Visits", "Include Past Visits");
                globalStepsObj.checkMultipleCheckBoxes("check", null, checkBoxNames);
                searchForPatient(patientName, "");
                globalStepsObj.selectPatientFromTheColumnInTable(patientName, "Name", "Add Patient Search");
                if (GlobalStepdefs.curTabName.equals("PatientList")) {
                    globalStepsObj.selectFromDropdown("ADMITTING", "Relationship", null, null);
                }
//                globalStepsObj.selectFromDropdown("ADMITTING", "Relationship", null, null);
                globalStepsObj.clickButton("Add", "Add patient(s) to your patient list", null);
                globalStepsObj.clickButton("Close", "Add patient(s) to your patient list", null);
                PatientListDisplayStepdefs patientListDisplayObj = new PatientListDisplayStepdefs();
                patientListDisplayObj.refreshPatientList();
                /*************************************************************************/
            } else {
                UtilFunctions.log("Patient: " + patientName + " is already present on the list.");
            }
            UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
            }.getClass().getEnclosingMethod().getName() + " : Complete");

        }
    }

    //match num patients on pat list to counter on tab
    @Then("^the number of patients should be displayed$")
    public void checkPatientCount() throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        int patListCount = PatientListPage.getNumPatients("PatientList");
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
//        String paneFrames = (String) frameMap.get(UtilFunctions.getElementFromJSONFile(fileObj, "TABLES." + "PatientList", "frame"));
        String paneFrames = UtilFunctions.getFrameValue(frameMap, "FRAME_MAIN_NAV");
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");
        WebElement tab = SeleniumFunctions.findElement(driver, By.xpath("//li[@id='PT']"));
        String tabText = tab.getText();
        tabText.matches("^\\((\\d+)\\)$");
        tabText = tabText.replaceAll("[a-zA-Z\\s\\(()\\)]", "");

        Assert.assertTrue(tabText.equals(String.valueOf(patListCount)));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }
}
