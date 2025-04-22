package features.step_definitions;

import common.SeleniumFunctions;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import org.json.simple.JSONObject;
import org.junit.Assert;

import org.openqa.selenium.*;
import org.openqa.selenium.interactions.Actions;
import pageObject.PatientListPage;
import support.Page;
import utils.UtilFunctions;

import java.text.SimpleDateFormat;
import java.util.*;

import features.Hooks;

import static features.Hooks.driver;
import static features.step_definitions.GlobalStepdefs.curTabName;

/******************************************************************************
 Class Name: PatientSearchStepdefs
 Contains step definitions related to patient search page
 ******************************************************************************/

public class PatientSearchStepdefs {

    public String className = getClass().getSimpleName();

    @Then("^only patients with last name \"(.*?)\" should appear in the \"(.*?)\" table$")
    public void lastNameExistsInTable(String lastName, String tableName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        lastName = lastName.toUpperCase();
        List<WebElement> tableRows = Page.getTableRows(Hooks.getDriver(), curTabName, tableName);
        if (tableRows == null) {
            UtilFunctions.log("Table: " + tableName + " Object not found.");
            Assert.assertTrue("Table: " + tableName + " not found.", false);
        } else {
            UtilFunctions.log("Table: " + tableName + " Object found.");
            for (WebElement row : tableRows) {
                List<WebElement> tdArr = SeleniumFunctions.findElementsByWebElement(row, SeleniumFunctions.setByValues("td;tagName"));
                String[] nameColumnData = tdArr.get(0).getText().split(",");
                String lastNameFromTable = nameColumnData[0].replaceAll("\"", "");
                Assert.assertTrue("Patients other than last name " + lastName + " also displayed", lastNameFromTable.equals(lastName));
            }
            UtilFunctions.log("Only rows with last name " + lastName + " are displayed in the table " + tableName);
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I select table row with cell values \"(.*?)\" from \"(.*?)\" table( with reference to visit creation date)?$")
    public void selectTableRowByValues(String cellValue, String tableName, String refDate) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        String[] cellValues = cellValue.split(";");

        List<WebElement> tableRows = Page.getTableRows(Hooks.getDriver(), curTabName, tableName);
        if (tableRows == null) {
            UtilFunctions.log("Table: " + tableName + " Object not found.");
            Assert.assertTrue("Rows of Table: " + tableName + " not found.", false);
        } else {
            boolean flag = false;
            int rowIndex = -1;
            for (WebElement row : tableRows) {
                rowIndex += 1;
                flag = true;
                String rowText = row.getText().toLowerCase();
                for (String cell : cellValues) {
                    if (refDate != null) {
                        cell = UtilFunctions.convertDateThruRegExWithRefDate(cell, PatientListV2Stepdefs.visitCreationDate);
                    } else
                        cell = UtilFunctions.convertThruRegEx(cell);
                    if (!rowText.contains(cell.toLowerCase())) {
                        flag = false;
                        break;
                    }
                }
                if (flag) {
                    Assert.assertTrue("Row is not selected with the given values", SeleniumFunctions.clickTableItemIfNotClickedProperly(tableRows.get(rowIndex), true));
                    break;
                }
            }
            Assert.assertTrue("Row is not found with the given values", flag);
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @And("^I select \"(.*?)\" provider(?: and \"(.*?)\" as med service)? for the \"(.*?)\" patients$")
    public void selectProviderForThePatients(String providerName, String services, String patientName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        String fname = patientName.split(" ")[0];
        String lname = patientName.split(" ")[1];


        if (!PatientListPage.checkIfPatientExists(Hooks.getDriver(), patientName)) {
            globalStepdefs.selectTab("Patient Search");
            globalStepdefs.clickButton("Clear Criteria", null, null);
            globalStepdefs.checkCheckBox(null, "Include Cancelled Visits", null, null);
            globalStepdefs.checkCheckBox(null, "Include Past Visits", null, null);
            Page.setTextBox(driver, curTabName, "5", "Admit in last N days");
            Page.setTextBox(driver, curTabName, lname, "Last");
            Page.setTextBox(driver, curTabName, fname, "First");
            globalStepdefs.clickButton("Search for Visits", null, null);
            globalStepdefs.waitGivenTime("5");
            globalStepdefs.selectPatientFromTheColumnInTable(patientName, "Name (\\d)", "Visit Search Results");
            globalStepdefs.clickButton("Edit", null, null);

            if (services == null) {
                globalStepdefs.waitGivenTime("10");
                Page.setTextBox(driver, curTabName, providerName, "AttendingMDTextField");
                Page.clickButton(driver, curTabName, "AttendingMDImg");
                Page.clickButton(driver, curTabName, "AttendingMDField");
            } else {
                globalStepdefs.waitGivenTime("10");
                Page.setTextBox(driver, curTabName, providerName, "Scheduled Provider");
                Page.clickButton(driver, curTabName, "ScheduledMDImg");
                Page.clickButton(driver, curTabName, "ScheduledMDTextField");
                globalStepdefs.selectFromDropdown(services, "ReassignMedService", null, null);

            }
            Page.clickButton(driver, curTabName, "Save");
            globalStepdefs.waitGivenTime("2");
            Page.setTextBox(driver, curTabName, lname, "Last");
            Page.setTextBox(driver, curTabName, fname, "First");
            globalStepdefs.clickButton("Search for Visits", null, null);
            globalStepdefs.selectPatientFromTheColumnInTable(patientName, "Name (\\d)", "Visit Search Results");
            globalStepdefs.clickButton("AddtoPatientList", null, null);
            globalStepdefs.waitGivenTime("2");
//            globalStepdefs.selectFromDropdown("SCHEDULED", "Relationship", null, "if it exists");
            globalStepdefs.clickButton("AddV2", null, "if it exists");
            globalStepdefs.clickButton("Add", null, "if it exists");
        }

    }

//  ************************************************************************************************

    @And("^I select \"(.*?)\" provider(?: and \"(.*?)\" as med service)? for the \"(.*?)\" patient$")
    public void selectProviderFromThePatient(String providerName, String services, String patientName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        String fname = patientName.split(" ")[0];
        String lname = patientName.split(" ")[1];

        //Deleting the patient from the patient list if exists
        PatientListManagementStepdefs patientListManagementStepdefs = new PatientListManagementStepdefs();
        patientListManagementStepdefs.addRemovePatientOnPatientList(patientName, "not", "");


        if (!PatientListPage.checkIfPatientExists(Hooks.getDriver(), patientName)) {
            globalStepdefs.selectTab("Patient Search");
            globalStepdefs.clickButton("Clear Criteria", null, null);
            globalStepdefs.checkCheckBox("uncheck", "Include Cancelled Visits", null, null);
            globalStepdefs.checkCheckBox("uncheck", "Include Past Visits", null, null);
            Page.setTextBox(driver, curTabName, "5", "Admit in last N days");
            Page.setTextBox(driver, curTabName, lname, "Last");
            Page.setTextBox(driver, curTabName, fname, "First");
            globalStepdefs.clickButton("Search for Visits", null, null);
            globalStepdefs.selectPatientFromTheColumnInTable(patientName, "Name (\\d)", "Visit Search Results");
            globalStepdefs.clickButton("Edit", null, null);

            if (services == null) {
                Page.setTextBox(driver, curTabName, providerName, "Scheduled Provider");
                globalStepdefs.clickButton("ScheduledMDImg", null, null);
                globalStepdefs.clickButton("ContactNameField", null, null);
            } else {
                Page.setTextBox(driver, curTabName, providerName, "Scheduled Provider");
                Page.clickButton(driver, curTabName, "ScheduledMDImg");
                Page.clickButton(driver, curTabName, "ContactNameField");
                globalStepdefs.selectFromDropdown(services, "ReassignMedService", null, null);

            }
            Page.clickButton(driver, curTabName, "Save");
            globalStepdefs.selectPatientFromTheColumnInTable(patientName, "Name (\\d)", "Visit Search Results");
            globalStepdefs.clickButton("AddtoPatientList", null, null);
//            globalStepdefs.selectFromDropdown("SCHEDULED", "Relationship", null, "if it exists");
            globalStepdefs.clickButton("AddV2", null, "if it exists");
            globalStepdefs.clickButton("Add", null, "if it exists");
        }
    }


    //Then if the "Error Dialog" pane appears try to merge the visits again
    @Then("^if the \"(.*)\" pane appears try to merge the visits again$")
    public void mergeVisitsAgain(String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        WebElement paneObj = Page.findPane(Hooks.getDriver(), curTabName, paneName);
        if (paneObj != null) {
            UtilFunctions.log("Pane " + paneName + " found. Trying to merge patients again.");
            //Click the "ErrorOK" btn in the Error Dialog pane
            if (Page.clickButton(Hooks.getDriver(), curTabName, "ErrorOK", paneName)) {
                UtilFunctions.log("Button: ErrorOK clicked.");
                //Click the cancel button
                if (Page.clickButton(Hooks.getDriver(), curTabName, "CancelMerge", "")) {
                    UtilFunctions.log("Button: CancelMerge clicked.");
                    //I select the "Merge" link in the row with "MERGETEST, PATIENT ONE*" as the value under
                    // "Name (\d)" in the "Visit Search Results" table if it exists
                    Thread.sleep(2000);
                    WebElement row = Page.findTableRowByCellText(Hooks.getDriver(), curTabName,
                            "Visit Search Results", "Name (\\d)",
                            "MERGETEST, PATIENT ONE*");
                    SeleniumFunctions.findElementByWebElement(row, By.xpath(".//" + "*[normalize-space(./text())='Merge']")).click();
                    //I click the "MergeVisits" button
                    if (Page.clickButton(Hooks.getDriver(), curTabName, "MergeVisits", "")) {
                        //I select patient "MERGETEST, PATIENT ONE*" from the "Name (\d)" column in the "Merge Visits" table if it exists
                        Thread.sleep(500);
                        String patientName = UtilFunctions.reformName("MERGETEST, PATIENT ONE*");
                        Page.selectFromTableByValue(Hooks.getDriver(), curTabName, "Merge Visits",
                                "Name (\\d)", patientName.replace("\\.", ""));
                        //I click the "Resolve" button
                        if (Page.clickButton(Hooks.getDriver(), curTabName, "Resolve", "")) {
                            Assert.assertTrue("Button: Resolve not found and not clicked.", true);
                        } else {
                            Assert.assertTrue("Button: Resolve not found and not clicked.",
                                    Page.clickButton(Hooks.getDriver(), curTabName, "Resolve", ""));
                        }
                    }
                }
            }//end 1st inner IF
        } else {
            //If the Error Dialog pane doesn't appear, do nothing.
            UtilFunctions.log("Pane " + paneName + " not found.  Moving on to the next automation step.");
        }//end outer if-else

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }//end mergeVisitsAgain


    //And I click the "Create Visit" button if it exists and select "ER" from the dropdown that displays
    @Then("^I click the \"(.*)\" button( if it exists)? and select \"(.*)\" from the dropdown that displays$")
    public void clickButtonSelectFromDropdown(String buttonName, String ifItExists, String value) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String tabName = GlobalStepdefs.curTabName;
        buttonName = buttonName.replace(" ", "");
        WebDriver driver = Hooks.getDriver();

        if (ifItExists != null && !(Page.checkElementExists(driver, tabName, buttonName, "BUTTONS"))) {
            UtilFunctions.log(buttonName + " button does not exist so can't be clicked.  Returning...");
            System.out.println(buttonName + " button does not exist so can't be clicked.  Returning...");
            return;
        }

        //if the button exists, click it
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        String[] elementType = UtilFunctions.getElementStringAndType(fileObj, "BUTTONS." + buttonName);
        String buttonPath = elementType[0];
        String buttonMethod = elementType[1];

        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        String paneFrames = UtilFunctions.getFrameValue(frameMap,
                UtilFunctions.getElementFromJSONFile(fileObj, "BUTTONS." + buttonName, "frame"));
        SeleniumFunctions.selectFrame(driver, paneFrames, "id");

        WebElement btnObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(buttonPath + ";"
                + buttonMethod));
        Assert.assertNotNull(buttonName + " button is NULL and not found.", btnObj);

        String menuXpath = null;
        WebElement menu = null, menuOption = null;
        if (buttonName.equalsIgnoreCase("CreateVisit")) {
            menuXpath = "//ul[@id='AddVisitButtonMenu']";
        } else {//if buttonName  = "Actions"
            menuXpath = "//ul[@id='ActionDropdownMenu']";
        }

        //Ensure the dropdown menu displays after btn click
        try {
            btnObj.click();
            menu = SeleniumFunctions.findElement(driver, By.xpath(menuXpath));
            Assert.assertNotNull(buttonName + " dropdown menu is NULL and not found.", menu);

            if (!(menu.isDisplayed())) {
                SeleniumFunctions.click(btnObj);
            }
        } catch (ElementNotInteractableException e) {
            SeleniumFunctions.click(btnObj);
            menu = SeleniumFunctions.findElement(driver, By.xpath(menuXpath));
            Assert.assertNotNull(buttonName + " dropdown menu is NULL and not found.", menu);

            if (!(menu.isDisplayed())) {
                Actions actions = new Actions(driver);
                actions.moveToElement(btnObj).click().build().perform();
            }
        }

        //Find the dropdown or menu item/option
        menuOption = SeleniumFunctions.findElementByWebElement(menu,
                By.xpath(".//li[@pkmenuitemvalue='" + value + "']"));
        Assert.assertNotNull("'" + value + "' from " + buttonName + " dropdown is NULL and not found.", menuOption);

        //Click the menuOption and if the btn = "CreateVisit", verify the "AddPatientContent" pane pops up/displays
        if (buttonName.equalsIgnoreCase("CreateVisit")) {
            Actions actions = new Actions(driver);
            try {
                menuOption.click();
                Thread.sleep(1000);
                if (!Page.checkElementExists(driver, tabName, "AddPatientContent", "PANES")) {
                    SeleniumFunctions.click(menuOption);
                    Thread.sleep(1000);
                    if (!Page.checkElementExists(driver, tabName, "AddPatientContent", "PANES")) {
                        actions.moveToElement(menuOption).click().build().perform();
                        Thread.sleep(1000);
                    }
                }
            } catch (ElementNotInteractableException e) {
                SeleniumFunctions.click(menuOption);
                Thread.sleep(1000);
                if (!Page.checkElementExists(driver, tabName, "AddPatientContent", "PANES")) {
                    try {
                        SeleniumFunctions.click(menuOption);
                        Thread.sleep(1000);
                        Assert.assertTrue("The 'AddPatientContent' pane to Create Visit never displayed.",
                                Page.checkElementExists(driver, tabName, "AddPatientContent", "PANES"));
                    } catch (StaleElementReferenceException ser) {
                        menuOption = SeleniumFunctions.findElement(driver,
                                By.xpath(menuXpath + "//li[@pkmenuitemvalue='" + value + "']"));
                        if (menuOption == null) {
                            menuOption = SeleniumFunctions.findElementByWebElement(menu,
                                    By.xpath(".//li[@pkmenuitemvalue='" + value + "']"));
                        }
                        if (menuOption != null) {
                            actions.moveToElement(menuOption).click().build().perform();
                            Thread.sleep(1000);
                        }
                        Assert.assertTrue("The 'AddPatientContent' pane to Create Visit never displayed.",
                                Page.checkElementExists(driver, tabName, "AddPatientContent", "PANES"));
                    }
                }
            }
        } else {//if buttonName  = "Actions"
            try {
                menuOption.click();
                Thread.sleep(500);
            } catch (ElementNotInteractableException e) {
                Actions actions = new Actions(driver);
                try {
                    actions.moveToElement(menuOption).click().build().perform();
                    Thread.sleep(500);
                } catch (StaleElementReferenceException ser) {
                    menuOption = SeleniumFunctions.findElement(driver,
                            By.xpath(menuXpath + "//li[@pkmenuitemvalue='" + value + "']"));
                    actions.moveToElement(menuOption).click().build().perform();
                    Thread.sleep(500);
                }
            }
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }//end clickButtonSelectFromDropdown

    //And I add an "ER" visit from the Patient Search tab
    @Then("^I add a(?:n)? \"(.*)\" visit from the Patient Search tab(?: for patient \"(.*)\")?$")
    public void addVisitFromPatientSearch(String visitType, String patientName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        //When I click the "Create Visit" button if it exists and select [visitType] from the dropdown that displays
        clickButtonSelectFromDropdown("CreateVisit", "if it exists", visitType);
        //And I click the "ER" link if it exists in the "Search Results" pane
        GlobalStepdefs globalSteps = new GlobalStepdefs();
        globalSteps.clickLinkInPane(visitType, "if it exists", null, "SearchResults");

        //Fill in the Patient Visit info:
        //If no patientName is passed in, Fill in 'E' as the middle name.  'E' is used to signify a manually registered patient by Automation
        if (patientName == null)
            Page.setTextBox(Hooks.getDriver(), GlobalStepdefs.curTabName, "E", "MiddleName");
        //MRN
        Page.setTextBox(Hooks.getDriver(), GlobalStepdefs.curTabName, "123456789", "MRNtextbox");
        //Facility
        Page.selectDropDownInPane(Hooks.getDriver(), GlobalStepdefs.curTabName, "PKHospital", "AddFacility");
        //Admit Date and Time
        Page.setTextBox(Hooks.getDriver(), GlobalStepdefs.curTabName, "%Current Date MMDDYY%", "AdmitDateTime-Date");
        Page.setTextBox(Hooks.getDriver(), GlobalStepdefs.curTabName, "%Current Time HHMM%", "AdmitDateTime-Time");
        //Discharge Date and Time
        Page.setTextBox(Hooks.getDriver(), GlobalStepdefs.curTabName, "%1 day from now MMDDYY%", "DischargeDateTime-Date");
        Page.setTextBox(Hooks.getDriver(), GlobalStepdefs.curTabName, "%Current Time HHMM%", "DischargeDateTime-Time");

        //And I click the "Add and Save" button
        Assert.assertTrue("'Add and Save' button to save and add patient visit NOT clicked.  Visit not saved.",
                Page.clickButton(Hooks.getDriver(), GlobalStepdefs.curTabName, "AddandSave"));
        //And I click the "Yes" button if it exists
        globalSteps.clickButton("Yes", null, "if it exists");

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


}//end class
