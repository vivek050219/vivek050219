package features.step_definitions;

import com.sun.jna.platform.win32.WinDef;
import common.SeleniumFunctions;
import constants.GlobalConstants;
import cucumber.api.DataTable;
import cucumber.api.Scenario;
import cucumber.api.java.Before;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import features.Hooks;
import junit.framework.AssertionFailedError;
import org.apache.commons.lang3.StringUtils;
import org.json.simple.JSONObject;
import org.junit.Assert;
import org.openqa.selenium.*;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.Select;
import org.openqa.selenium.support.ui.WebDriverWait;
import pageObject.PatientListPage;
import support.*;
import support.db.DBExecutor;
import support.jna_extensions.User32;
import support.jna_extensions.WindowHelper;
import utils.UtilFunctions;
import utils.UtilProperty;

import java.awt.*;
import java.awt.event.KeyEvent;
import java.io.IOException;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.util.*;
import java.util.List;

import static features.Hooks.driver;
import static support.Page.*;

import com.sun.jna.platform.win32.WinDef.HWND;

/**
 * Created by PatientKeeper on 6/24/2016.
 */

/******************************************************************************
 Class Name: GlobalStepdefs
 Contains global step definitions used with every feature file
 ******************************************************************************/

public class GlobalStepdefs {

    public String className = getClass().getSimpleName();
    public static String curTabName = "";
    public static String subSection = "";
    public static String textFromField = "";
    private static Date d1 = null;
    private static Date d2 = null;

    private Scenario scenario;

    @Before
    public void before(Scenario scenario) throws IOException {
        this.scenario = scenario;
    }


    @Given("^I am on the \"(.*?)\" tab$")
    public void selectTab(String tabName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        tabName = tabName.replace(" ", "");
        curTabName = tabName;
        //Clear subSection any time a tab change occurs
        subSection = "";
        PatientListPage.setTab(curTabName);

        if (NavBar.selectNavigationTab(Hooks.getDriver(), tabName, ""))
            Assert.assertTrue("Tab element: " + tabName + " not found on 1st try.", true);
        else
            Assert.assertTrue("Tab element: " + tabName + " not found on 2nd try.",
                    NavBar.selectNavigationTab(Hooks.getDriver(), tabName, ""));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @Given("^I select the \"(.*?)\" subtab$")
    public void selectSubTab(String subTab) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        subSection = subTab.replace("_", "").replace(" ", "").toUpperCase() + "_SUBSECTION";
        subTab = subTab.replace(" ", "");
        boolean getValue = NavBar.selectNavigationTab(Hooks.getDriver(), curTabName, subTab);
        Assert.assertTrue("Sub tab element: " + subTab + " not found", getValue);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^the \"(.*?)\" pane should (load|not load|close)(?: within \"(.*?)\" seconds?)?$")
    public void checkPaneLoad(String paneName, String action, String waitTime) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        WebElement paneElement = null;

        //if time is null and the action equals either 'load' or 'not load'
        if ((waitTime == null) && (!action.equals("close"))) {
            paneElement = Page.findPane(Hooks.getDriver(), curTabName, paneName);
        } else if (action.equals("close")) {
            waitForFieldAttributeValue(waitTime, paneName, "pane", paneName, "be invisible",
                    null, null);
            paneElement = Page.findPane(Hooks.getDriver(), curTabName, paneName, GlobalConstants.ONE);
        } else {
            paneElement = Page.findPane(Hooks.getDriver(), curTabName, paneName, Integer.parseInt(waitTime));
        }

        if ((paneElement != null) && (!paneElement.isDisplayed())) {
            UtilFunctions.log("Assigning paneElement value to null as it is not displayed");
            paneElement = null;
        }

        switch (action) {
            case "load":
                if (paneElement == null && waitTime == null) {
                    paneElement = Page.findPane(Hooks.getDriver(), curTabName, paneName);
                } else if (paneElement == null && waitTime != null) {
                    paneElement = Page.findPane(Hooks.getDriver(), curTabName, paneName, Integer.parseInt(waitTime));
                }
                Assert.assertNotNull("Object for pane: " + paneName + " Not Found", paneElement);
                break;
            case "not load":
            case "close":
                Assert.assertNull("Object for pane: " + paneName + " Found", paneElement);
                break;
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @When("^I select \"(.*?)\" from the \"(.*?)\" dropdown(?: in the \"(.*?)\" pane)?( if it exists)?$")
    public void selectFromDropdown(String value, String dropDownName, String paneName, String exists) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        if (exists == null) {
            Page.selectDropDownInPane(Hooks.getDriver(), curTabName, value, dropDownName, paneName);
        } else {//Catch errors when operating on a dropdown that may not exist
            try {
                Page.selectDropDownInPane(Hooks.getDriver(), curTabName, value, dropDownName, paneName);
            } catch (Exception e) {
                UtilFunctions.log("Dropdown '" + dropDownName + "' does not exist. Exception: " + e.getMessage());
                e.printStackTrace();
            }
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @When("^I wait \"(.*?)\" seconds?$")
    public void waitGivenTime(String waitTime) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        Thread.sleep(Integer.parseInt(waitTime) * 1000);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @And("^I click the \"([^\"]*)\" button(?: in the \"(.*?)\" pane)?( if it exists)?$")
    public void clickButton(String buttonName, String paneName, String exists) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        if (exists == null) {
            if (Page.clickButton(Hooks.getDriver(), curTabName, buttonName, paneName)) {
                Assert.assertTrue("Button: " + buttonName + " does not exist.", true);
            } else {
                Assert.assertTrue("Button: " + buttonName + " does not exist.", Page.clickButton(Hooks.getDriver(),
                        curTabName, buttonName, paneName));
            }
        } else {
            try {
                Page.clickButton(Hooks.getDriver(), curTabName, buttonName, paneName);
            } catch (Exception e) {
                e.printStackTrace();
                UtilFunctions.log("Button: " + buttonName + " does not exist. Exception: " + e.getMessage());
            }
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @Then("^I select \"(.*?)\" \"(.*?)\" file for \"(.*?)\" option(?: in the \"(.*?)\" pane)?( if it exists)?$")
    public void selectFile(String fileName, String fileType, String buttonName, String paneName, String exists) {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        paneName = paneName.replace(" ", "");
        buttonName = buttonName.replace(" ", "");
        String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));

        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
        WebElement ele = Page.getElementObject(Hooks.getDriver(), curTabName, buttonName, "BUTTONS", paneName);
        Assert.assertNotNull("Element not found.", ele);

        String filePath = null;
        switch (fileType) {
            case "image":
                filePath = System.getProperty("user.dir") + "\\src\\test\\java\\testData\\Images\\" + fileName;
                break;
            default:
                Assert.assertNotNull("Invalid file type: " + fileType, filePath);
                break;
        }
        ele.sendKeys(filePath);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I click \"(.*?)\" in the confirmation box( if it exists)?$")
    public void selectAlert(String alertName, String exists) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        if (exists == null) {
            Assert.assertTrue("Alert: " + alertName + " not visible", Page.handleAlert(Hooks.getDriver(), alertName));
        } else {
            try {
                Page.handleAlert(Hooks.getDriver(), alertName);
            } catch (Exception e) {
                e.printStackTrace();
                UtilFunctions.log("Alert: " + alertName + " not visible Exception: " + e.getMessage());
            }
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    //    @Then("^(?:the|The)? following field(?:s)? should(?: be)? (enabled|disabled|display)(?: in the \"(.*?)\" pane)?$")
//    public void checkDataTableValuesInPane(String state, String paneName, DataTable dataTable) throws Throwable {
//        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
//        }.getClass().getEnclosingMethod().getName() + " : Start");
//
//        Assert.assertEquals("", Page.checkDataTableInPane(Hooks.getDriver(), curTabName, state, paneName, dataTable));
//
//        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
//        }.getClass().getEnclosingMethod().getName() + " : Complete");
//    }
    @Then("^(?:the|The)? following field(?:s)? should(?: be)? (enabled|disabled|display|not display)" +
            "(?: in the \"(.*?)\" pane)?$")
    public void checkDataTableValuesInPane(String state, String paneName, DataTable dataTable) throws Throwable {

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        if (state.equals("not display")) {
            Assert.assertNotNull("Field is not present.", Page.checkDataTableInPane(Hooks.getDriver(),
                    curTabName, state, paneName, dataTable));
        } else {
            Assert.assertEquals("", Page.checkDataTableInPane(Hooks.getDriver(),
                    curTabName, state, paneName, dataTable));
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @When("^I select \"(.*?)\" from the \"(.*?)\" radio list in the \"(.*?)\" pane( if it exists)?$")
    public void selectRadioListButton(String value, String radioName, String paneName, String exists) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        Thread.sleep(500);
        if (exists == null) {
            Assert.assertTrue("Radio Button: " + radioName + " is not found",
                    Page.setRadioValue(Hooks.getDriver(), curTabName, value, radioName, paneName));
        } else {
            try {
                Page.setRadioValue(Hooks.getDriver(), curTabName, value, radioName, paneName);
            } catch (Exception e) {
                UtilFunctions.log("Radio button is not set due to exception: " + e);
            }
        }
        Thread.sleep(500);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I select \"(.*?)\" from the \"(.*?)\" radio list$")
    public void selectRadioListButton(String value, String radioName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        Thread.sleep(500);
        Assert.assertTrue("Radio Button: " + radioName + " not found",
                Page.setRadioValue(Hooks.getDriver(), curTabName, value, radioName));
        Thread.sleep(500);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^the following subtabs should load$")
    public void checkSubTabLoad(DataTable dataTable) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        List<String> dataList = dataTable.asList(String.class);
        for (String subTabName : dataList) {
            UtilFunctions.log("SubTab name to be checked: " + subTabName);
            Assert.assertTrue("SubTab: " + subTabName + " does not exist.", NavBar.navigationSubTabExists(Hooks.getDriver(), curTabName, subTabName.replace(" ", "")));
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    //TODO: Refactor b/c IE just doesn't seem to be able to click options in Pkmenus anymore when run in Automation.  Works fine in Chrome and manually in IE.
    @When("^I select \"(.*?)\" from the \"(.*?)\" menu(?: in the \"(.*)\" pane)?( if it exists)?$")
    public void selectFromMenu(String option, String menu, String pane, String exists) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        UtilFunctions.log("Option: " + option);
        UtilFunctions.log("Menu: " + menu);

        menu = menu.replace(" ", "");
        boolean output;
        switch (menu) {
            case "Actions":
            case "PatientHeaderActions":
                if (exists == null) {
                    JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
                    String expectedItem = UtilFunctions.getElementFromJSONFile(fileObj, "PKMENUS." + menu,
                            "ExpectedItem_" + option.replace(" ", ""));
                    if (expectedItem != null) {
                        String[] expectedItemArr = expectedItem.split(";");
                        String elementName = expectedItemArr[0];
                        String elementType = expectedItemArr[1];
                        output = Page.selectFromPKActionsMenu(Hooks.getDriver(), menu, option, curTabName, elementName, elementType);
                        Assert.assertTrue("Item: " + option + " not selected", output);
                    } else {
                        Assert.assertTrue("Item: " + option + " not selected",
                                Page.selectFromPKActionsMenu(Hooks.getDriver(), menu, option, curTabName));
                    }
                } else {
                    try {
                        Page.selectFromPKActionsMenu(Hooks.getDriver(), menu, option, curTabName);
                    } catch (NullPointerException e) {
                        UtilFunctions.log(menu + " PK Menu does not exist.");
                    }
                }
                break;
            case "PatientList":
                if (exists == null) {
                    if (Page.selectFromPatientListMenu(Hooks.getDriver(), menu, option, curTabName, pane)) {
                        Assert.assertTrue("Item: " + option + " not selected", true);
                    } else {
                        Assert.assertTrue("Item: " + option + " not selected",
                                Page.selectFromPatientListMenu(Hooks.getDriver(), menu, option, curTabName, pane));
                    }
                } else {
                    try {
                        Page.selectFromPKActionsMenu(Hooks.getDriver(), menu, option, curTabName);
                    } catch (NullPointerException e) {
                        UtilFunctions.log(menu + " Patient List Menu does not exist.");
                    }
                }

                break;
            default:
                if (exists == null) {
                    Assert.assertTrue("Item: " + option + " not selected",
                            Page.selectFromPKMenu(Hooks.getDriver(), menu, option, curTabName));
                } else {
                    try {
                        Page.selectFromPKActionsMenu(Hooks.getDriver(), menu, option, curTabName);
                    } catch (NullPointerException e) {
                        UtilFunctions.log(menu + " PK Menu does not exist.");
                    }
                }
                break;
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^the \"(.*?)\" menu should( not)? have the following options$")
    public void verifyOptionsInMenu(String menu, String not, DataTable dataTable) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        //PLv2 selection menu is a bit complicated so it has a dedicated method.
        if (menu.equals("Patient List")) {
            if (not == null)
                Assert.assertTrue("Value(s) not found in menu: " + menu, Page.verifyOptionsInPLv2Menu(Hooks.getDriver(), menu, false, dataTable, curTabName));
            else
                Assert.assertTrue("Value(s) found in menu: " + menu, Page.verifyOptionsInPLv2Menu(Hooks.getDriver(), menu, true, dataTable, curTabName));
        } else {
            if (not == null)
                Assert.assertTrue("Value(s) not found in menu: " + menu, Page.verifyOptionsInMenu(Hooks.getDriver(), menu, false, dataTable, curTabName));
            else
                Assert.assertTrue("Value(s) found in menu: " + menu, Page.verifyOptionsInMenu(Hooks.getDriver(), menu, true, dataTable, curTabName));
            //other menus not yet implemented
            //Assert.assertTrue("verifyOptionsInMenu method not implemented for '" + menu + "' menu", false);
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    //Enter Value in Text Box
    @When("^I enter \"(.*?)\" in the \"(.*?)\" field(?: in the \"(.*?)\" pane)?$")
    public void enterInTheField(String value, String fieldName, String paneName) {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        fieldName = fieldName.replace(" ", "");
        value = UtilFunctions.convertThruRegEx(value);

        if (paneName == null)
            Assert.assertTrue("Failed to set field '" + fieldName + "' to '" + value + "'",
                    Page.setTextBox(Hooks.getDriver(), curTabName, value, fieldName));
        else
            Assert.assertTrue("Failed to set field '" + fieldName + "' to '" + value + "'",
                    Page.setTextBox(Hooks.getDriver(), curTabName, value, fieldName, paneName));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @When("^I append text \"(.*?)\" to the \"(.*?)\" field(?: in the \"(.*)\" pane)?$")
    public void enterTextAtCursor(String value, String fieldName, String paneName) {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        Assert.assertTrue("Failed to set field '" + fieldName + "' to '" + value + "'",
                Page.appendTextToField(Hooks.getDriver(), curTabName, value, fieldName, paneName));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @Then("^the content (should|should not) contain the text \"(.*?)\" in the \"(.*?)\" pane$")
    public void checkTextInDiv(String shouldShouldNot, String text, String paneName)
            throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        boolean exact = false;
        switch (shouldShouldNot) {
            case "should":
                if (Page.textExists(Hooks.getDriver(), text, "", exact, paneName, curTabName))
                    Assert.assertTrue("Content contains text: " + text, true);
                else
                    Assert.assertTrue("Content contains text: " + text,
                            Page.textExists(Hooks.getDriver(), text, "", exact, paneName, curTabName));
                break;
            case "should not":
                if (!Page.textExists(Hooks.getDriver(), text, "", exact, paneName, curTabName))
                    Assert.assertFalse("Content does not contain text: " + text, false);
                else
                    Assert.assertFalse("Content does not contain text: " + text,
                            Page.textExists(Hooks.getDriver(), text, "", exact, paneName, curTabName));
                break;
        }

        /*if(txtDoesExist){
            if(Page.textExists(Hooks.getDriver(), text, "", exact))
                Assert.assertTrue("Content contains text: " + text, true);
            else
                Assert.assertTrue("Content contains text: " + text,
                        Page.textExists(Hooks.getDriver(), text, "", exact));
        }else {
            Assert.assertFalse("Content does contain text: " + text, txtDoesExist);
        }*/

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @When("^the value in the \"(.*?)\" field(?: in the \"(.*)\" pane)? should be (?:blank|\"(.*?)\")$")
    public void getFromTheField(String fieldName, String paneName, String value) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        fieldName = fieldName.replace(" ", "");
        WebElement txtBoxObj = Page.getTextBox(Hooks.getDriver(), curTabName, fieldName, paneName);

        if (txtBoxObj == null) {
            UtilFunctions.log("TextBox: " + fieldName + " Object not found.");
            Assert.assertTrue("TextBox: " + fieldName + " Object not found.", false);
        }

        if (value == null || value.equals("")) {
            if (txtBoxObj.getAttribute("value") == null || txtBoxObj.getAttribute("value").equals(""))
                Assert.assertTrue("Matched.", true);
            else
                Assert.assertTrue("Text Box: " + fieldName + " not null", false);
        } else {
            value = UtilFunctions.convertThruRegEx(value);
            String textContent = txtBoxObj.getText();
            if (textContent.equals("") || textContent == null) {
                textContent = txtBoxObj.getAttribute("value");
                if (textContent.equals("") || textContent == null) {
                    textContent = txtBoxObj.getAttribute("textContent");
                }
            }

            UtilFunctions.log("Exp text :" + value.toUpperCase());
            UtilFunctions.log("Act text :" + textContent.toUpperCase());
            Assert.assertEquals("Not matched value: " + value,
                    textContent.toUpperCase(), value.toUpperCase());
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    //Un/check multiple check boxes
    @When("^I \"(.*?)\" the following(?: checkbox in the \"(.*?)\" pane)?$")
    public void checkMultipleCheckBoxes(String checkType, String paneName, List<String> dataList) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        for (String checkBoxName : dataList) {
            UtilFunctions.log("CheckBoxName: " + checkBoxName);
            Assert.assertTrue("CheckBox: " + checkBoxName + " didn't set properly.",
                    Page.setCheckBox(Hooks.getDriver(), curTabName, checkBoxName, checkType, paneName));
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @When("^I (un)?check the \"(.*?)\" checkbox(?: in the \"(.*?)\" pane)?( if it exists)?$")
    public void checkCheckBox(String checkType, String checkbox, String paneName, String exists) {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        UtilFunctions.log("CheckBoxName: " + checkbox);
        if (checkType == null) {
            checkType = "check";
        } else {
            checkType = "uncheck";
        }
        if (exists == null) {
            Assert.assertTrue("CheckBox: " + checkbox + " didn't set properly.",
                    Page.setCheckBox(Hooks.getDriver(), curTabName, checkbox, checkType, paneName));
        } else {
            try {
                Page.setCheckBox(Hooks.getDriver(), curTabName, checkbox, checkType, paneName);
            } catch (Exception e) {
                e.printStackTrace();
                UtilFunctions.log("CheckBox: " + checkbox + " didn't set properly. " + e.getMessage());
            }
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    //Check multiple check boxes status
    @Then("^the following should be (checked|unchecked)(?: in the \"(.*?)\" pane)?( in dashboard mode)?$")
    public void checkCheckBoxesStatus(String checkType, String paneName, String dashboard, List<String> dataList) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        for (String checkBoxName : dataList) {
            UtilFunctions.log("CheckBoxName: " + checkBoxName);
            if (dashboard == null) {
                Assert.assertTrue("CheckBox: " + checkBoxName + " didn't set properly.", Page.getCheckBoxStatus(Hooks.getDriver(), curTabName, checkBoxName, checkType, paneName));
            } else {
                Assert.assertTrue("CheckBox: " + checkBoxName + " didn't set properly.", Page.getCheckBoxStatusDashboardMode(Hooks.getDriver(), curTabName, checkBoxName, checkType, paneName));
            }
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I select patient \"(.*?)\" from the \"(.*?)\" column in the \"(.*?)\" table$")
    public void selectPatientFromTheColumnInTable(String patientName, String column, String tableName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        UtilFunctions.log("PatientName: " + patientName);

        Thread.sleep(500);
        if (patientName.equals("the first item")) {
            Assert.assertTrue("First Row not selected.", Page.selectFromTableByRowIndex(Hooks.getDriver(),
                    curTabName, tableName, 0));
        } else {
            patientName = UtilFunctions.reformName(patientName);
            Assert.assertTrue("Patient: " + patientName + " not displayed.",
                    Page.selectFromTableByValue(Hooks.getDriver(), curTabName,
                            tableName, column, patientName.replace("\\.", "")));
        }
        Thread.sleep(500);
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I select \"(.*?)\" in the \"(.*?)\" table$")
    public void selectFromTheTable(String value, String tableName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        UtilFunctions.log("Item to select from table: " + value);

        if (value.equals("the first item"))
            Assert.assertTrue("First Row not selected.",
                    Page.selectFromTableByRowIndex(Hooks.getDriver(), curTabName, tableName, 0));
        else if (tableName.replace(" ", "").equals("NewOrders"))
            Assert.assertTrue("Order element not found",
                    Page.selectOrderFromNewOrdersTable(Hooks.getDriver(), curTabName, value));
        else {
            Assert.assertTrue("Element not found",
                    Page.selectFromTableByValue(Hooks.getDriver(), curTabName, tableName, "",
                            value.replace("\\.", "")));
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @When("^I select \"(.*?)\" from the \"(.*?)\" column in the \"(.*?)\" table( if it exists)?$")
    public void selectValueFromTheColumnInTable(String value, String column, String tableName, String exists)
            throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        UtilFunctions.log("Value: " + value);

        //if exists != null, then the item or the table might not exist
        if (StringUtils.isNotEmpty(exists)) {
            try {
                if (value.equals("the first item"))
                    if (column.equals("the first")) {
                        Assert.assertTrue("Element in first row and first column is not selected",
                                Page.selectFromTableByRowAndColumnIndex(Hooks.getDriver(), curTabName, tableName,
                                        0, 0));
                    } else {
                        Assert.assertTrue("First Row not selected.",
                                Page.selectFromTableByRowIndex(Hooks.getDriver(), curTabName, tableName, 0));
                    }
                else {
                    Page.selectFromTableByValue(Hooks.getDriver(), curTabName, tableName, column, value);
                }
            } catch (Exception e) {
                UtilFunctions.log("Element not present.");
            }
        } else {//Otherwise, the item or the table must exist
            if (value.equals("the first item"))
                if (column.equals("the first")) {
                    Assert.assertTrue("Element in first row and first column is not selected",
                            Page.selectFromTableByRowAndColumnIndex(Hooks.getDriver(), curTabName, tableName,
                                    0, 0));
                } else {
                    Assert.assertTrue("First Row not selected.",
                            Page.selectFromTableByRowIndex(Hooks.getDriver(), curTabName, tableName, 0));
                }
            else {
                Assert.assertTrue("'" + value + "' not selected from table: " + tableName,
                        Page.selectFromTableByValue(Hooks.getDriver(), curTabName, tableName, column, value));
            }
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @Then("^the (?:text|html) (?:collected from field|\"(.*?)\") should( not)? appear(?: in the \"(.*?)\" section)?(?: in the \"(.*?)\" pane)?$")
    public void textAppearInPane(String text, String not, String sectionName, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        if (text == null)
            text = textFromField;
        else
            text = UtilFunctions.convertThruRegEx(text);

        if (not == null) {
            if (textExists(Hooks.getDriver(), curTabName, text, paneName, sectionName))
                Assert.assertTrue("Text: " + text + " is not displayed.", true);
            else {
                Assert.assertTrue("Text: " + text + " is not displayed.", textExists(Hooks.getDriver(),
                        curTabName, text, paneName, sectionName));
            }
        } else {
            Assert.assertFalse("Text: " + text + " is displayed.", textExists(Hooks.getDriver(),
                    curTabName, text, paneName, sectionName));
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @Then("^the following text should appear in the \"(.*?)\" pane$")
    public void checkForMultipleTextEntries(String paneName, DataTable dataTable) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        List<String> textList = dataTable.asList(String.class);
        for (String text : textList) {
            text = UtilFunctions.convertThruRegEx(text);
            textAppearInPane(text, null, null, paneName.replace(" ", ""));
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^the patient \"(.*?)\" should appear in the \"(.*?)\" pane$")
    public void patientAppearInPane(String text, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        text = UtilFunctions.reformName(text).toUpperCase();
        textAppearInPane(text, null, null, paneName);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @And("^I mouse over and click the \"(.*?)\" (icon|button|element|image|linktext)(?: in the \"(.*?)\" pane)?$")
    public void mouseOverAndClick(String objName, String objType, String paneName) {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        // objName = objName.replace(" ", "");

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        String findObjectType;
        if (objType.equals("button"))
            findObjectType = "BUTTONS";
        else if (objType == "image")
            findObjectType = "IMAGES";
        else
            findObjectType = "MISC_ELEMENTS";

        String objPath, objMethod;
        if (!objType.equals("linktext")) {
            String[] elementType = UtilFunctions.getElementStringAndType(fileObj, findObjectType + "." + objName.replace(" ", ""));
            objPath = elementType[0];
            objMethod = elementType[1];
        } else {
            objPath = "//*[starts-with(normalize-space(./text()), '" + objName + "')]";
            objMethod = "xpath";
        }
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        String paneFrames;

        if (paneName != null) {
            paneName = paneName.replace(" ", "");
            paneFrames = UtilFunctions.getFrameValue(frameMap,
                    UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
        } else {
            paneFrames = UtilFunctions.getFrameValue(frameMap,
                    UtilFunctions.getElementFromJSONFile(fileObj, findObjectType + "." + objName.replace(" ", ""), "frame"));
        }
        UtilFunctions.log("PaneFrames: " + paneFrames);
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");

        SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.TEN, objPath + ";" + objMethod);
        WebElement obj = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues(objPath + ";"
                + objMethod));
        Assert.assertNotNull(objName + " " + objType + " is not found", obj);
        UtilFunctions.log(objName + " " + objType + " is found");

        WebDriver currentDriver = Hooks.getDriver();
        try {
            JavascriptExecutor jsExecutor = (JavascriptExecutor) currentDriver;
            jsExecutor.executeScript("arguments[0].scrollIntoView(true)", obj);
            Actions act = new Actions(currentDriver);
            act.moveToElement(obj).perform();
            Thread.sleep(1000);
            act.click(obj).perform();
            UtilFunctions.log("Mouse over and click on " + objName + " " + objType + " is successful");
        } catch (WebDriverException webDriverEx) {
            JavascriptExecutor jsExecutor = (JavascriptExecutor) currentDriver;
            jsExecutor.executeScript("arguments[0].click();", obj);
            UtilFunctions.log("Mouse over and JavaScript click on " + objName + " " +
                    objType + " is successful");
            System.out.println("Mouse over and JavaScript click on " + objName + " " +
                    objType + " is successful");
        } catch (Exception e) {
            UtilFunctions.log("Failed to Mouse over and click on " + objName +
                    " " + objType + " due to exception: " + e.getMessage());
            Assert.fail("Failed to Mouse over and click on " + objName +
                    " " + objType + " due to exception: " + e.getMessage());
        }


        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^I click the \"(.*?)\" (?:image|tab|element|icon)(?: in the \"(.*?)\" section)?(?: in the \"(.*?)\" pane)?( if it exists)?$")
    public void clickMiscElement(String elementName, String sectionName, String paneName, String exists)
            throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        if (exists == null) {
            if (Page.clickMiscElement(Hooks.getDriver(), curTabName, elementName, sectionName, paneName, exists))//Parameter "exists" is never used by .clickMiscElement(), but it's needed elsewhere. -- HIC 11/1/18
                Assert.assertTrue("Element: " + elementName + " not present", true);
            else {
                Assert.assertTrue("Element: " + elementName + " not present",
                        Page.clickMiscElement(Hooks.getDriver(),
                                curTabName, elementName, sectionName, paneName, exists));
            }
        } else {
            try {
                Page.clickMiscElement(Hooks.getDriver(), curTabName, elementName, sectionName, paneName, exists);
            } catch (Exception e) {
                e.printStackTrace();

                UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
                }.getClass().getEnclosingMethod().getName() + " : Complete");
            }
        }
    }

    @When("^I click the \"(.*?)\" link( if it exists)? in the(?: \"(.*?)\" section in the)? \"(.*?)\" pane$")
    public void clickLinkInPane(String linkName, String exists, String sectionName, String paneName) throws Throwable {

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        paneName = paneName.replace(" ", "");
        if (exists == null) {
            if (Page.clickLinkText(Hooks.getDriver(), curTabName, linkName, paneName, sectionName, null)) {
                Assert.assertTrue("Link: " + linkName + " not found on 1st try.  Trying again.", true);
                UtilFunctions.log("Link: '" + linkName + "' found on 1st try.");
                System.out.println("Link: '" + linkName + "' found on 1st try.");
            } else {
                Assert.assertTrue("Link: " + linkName + " not found on 2nd try.",
                        Page.clickLinkText(Hooks.getDriver(), curTabName, linkName, paneName, sectionName, null));
                UtilFunctions.log("Link: '" + linkName + "' found on 2nd try.");
                System.out.println("Link: '" + linkName + "' found on 2nd try.");
            }
        } else
            Page.clickLinkText(Hooks.getDriver(), curTabName, linkName, paneName, sectionName, null);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @Then("^the following links should display in the \"(.*?)\" pane$")
    public void verifyLinksExist(String paneName, DataTable dataTable) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        Assert.assertTrue("Link(s) not found in pane: " + paneName, Page.verifyLinks(Hooks.getDriver(), curTabName, paneName, dataTable));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @When("^I sort the \"(.*?)\" table( numerically| alphabetically| chronologically)? by the \"(.*?)\" column in \"(.*?)\" order$")
    public void sortTable(String tableName, String sortType, String header, String order) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        Assert.assertTrue("Table: " + tableName + " not sorted " + sortType + " in " + order + " order or table not found.",
                Page.sortTable(Hooks.getDriver(), curTabName, tableName, sortType, header, order));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @Then("^(rows starting with the following|rows containing the following|the following rows) should" +
            " (not appear in|appear in|match) the \"(.*)\"( clinical)? table$")
    public void checkDataInTable(String type, String exactMatch, String tableName, String clinical, DataTable dataTable)
            throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        if (exactMatch.equals("not appear in"))
            Assert.assertFalse("Table contains the given data when it should not.", Page.checkDataInTable(Hooks.getDriver(),
                    curTabName, type, exactMatch, tableName, clinical, dataTable));
        else
            Assert.assertTrue("Table Data does not match with given data.", Page.checkDataInTable(Hooks.getDriver(),
                    curTabName, type, exactMatch, tableName, clinical, dataTable));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @When("^the \"(.*?)\" table should have( at least)? \"(\\d+)\" rows?(?:( not)? containing the text \"(.*?)\")?$")
    public void checkNoOfRowsInTable(String tableName, String min, String noOfRows, String no, String text)
            throws Throwable {

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        int givenRowCount = Integer.parseInt(noOfRows);
        //The check to see if the correct text is present or not in the table is in method countTableRows().
        int rowCount = Page.countTableRows(Hooks.getDriver(), curTabName, tableName, text, no);

        //If/Else to force the Assert to fire twice for timing issues -- HIC 11/2/18
        if (min == null) {
            //Since min is null, we should check whether the obtained row size is equivalent to the given row size
            if (rowCount == givenRowCount) {
                Assert.assertTrue("Actual Row count not equal to expected row count.\nActual Row Count: " +
                        rowCount + "\n Expected Row Count: " + givenRowCount, true);
            } else {
                Assert.assertTrue("Actual Row count not equal to expected row count.\nActual Row Count: " +
                        rowCount + "\n Expected Row Count: " + givenRowCount, rowCount == givenRowCount);
            }
        } else {
            if (rowCount >= givenRowCount)
                Assert.assertTrue(true);
            else
                Assert.assertTrue("No of rows in table less than expected or no rows present. No of rows displayed: "
                        + rowCount, false);
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^the \"(.*?)\" table should be (numerically|alphabetically|chronologically)? sorted by \"(.*?)\" in \"(Ascending|Descending)?\" order$")
    public void tableSortCheck(String tableName, String sortType, String columnName, String sortOrder) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        Assert.assertTrue("Table sort order check failed.", Page.validateTableSort(Hooks.getDriver(), tableName, columnName, sortType, sortOrder));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I fill in the following fields$")
    public void fillInMultipleFieldValues(DataTable dataTable) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        List<Map<String, String>> dataList = dataTable.asMaps(String.class, String.class);
        for (Map data : dataList) {
            String fieldName = ((String) data.get("Name"));
            String fieldType = (String) data.get("Type");
            String fieldValue = ((String) data.get("Value"));
            switch (fieldType) {
                case "text":
                    enterInTheField(fieldValue, fieldName, null);
                    break;
                case "dropdown":
                    selectFromDropdown(fieldValue, fieldName, null, null);
                    break;
                case "radio":
                    selectRadioListButton(fieldValue, fieldName);
                    break;
                default:
                    UtilFunctions.log("Invalid Field Type: " + fieldType);
                    break;
            }
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @Then("^the text \"(.*)\" should( not)? appear in the \"(.*)\" field(?: in the \"(.*)\" section)? of the \"(.*)\" table$")
    public void textAppearInFieldUnderTable(String value, String shouldAppear, String fieldName, String sectionName, String tableName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        if (sectionName != null) {
            Assert.assertNotEquals("Content not yet loaded. Table name: " + tableName, -1, Page.findTableSection(Hooks.getDriver(), curTabName, tableName, sectionName));
        }
//        if (!Page.getTableFieldValue(Hooks.getDriver(), curTabName, tableName, sectionName, fieldName).contains(value))
//            Assert.assertTrue("Value: " + value + " is not present in table.", false);
        if (shouldAppear == null)
            Assert.assertTrue(String.format("The %s table did not contain the value %s", tableName, value), Page.getTableFieldValue(Hooks.getDriver(), curTabName, tableName, sectionName, fieldName).contains(value));
        else
            Assert.assertNull(String.format("The %s table contains the value %s", tableName, value), Page.getTableFieldValue(Hooks.getDriver(), curTabName, tableName, sectionName, fieldName));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    //TODO: Refactor and re-write these queries
    @Then("^the contents of the \"(.*?)\"( clinical)? table should (contain|match) the results of the \"(.*?)\" query(?: filtered by \"(.*?)\" of \"(.*?)\")?$")
    public void checkTableContentAgainstDB(String tableName, String clinical, String exactMatch, String queryName,
                                           String filterCol, String filterVal) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String[] queryNameArr = queryName.split("\\+");
        List<DBExecutor> queryObjArr = new ArrayList<>();
        String mainQuery = "";

        String patID = PatientListPage.getPatientID(Hooks.getDriver(), "");
        Thread.sleep(500);

        for (String query : queryNameArr) {
            DBExecutor dbExecutorObj;
            switch (exactMatch) {
                case "match":
                    dbExecutorObj = Page.prepareQuery(query, false);
                    break;
                case "contain":
                    dbExecutorObj = Page.prepareQuery(query);
                    break;
                default:
                    dbExecutorObj = Page.prepareQuery(query);
                    break;
            }

            if (clinical != null && !clinical.equals("")) {
                String patIDColumn = dbExecutorObj.getHelperValue("patientidcolumn");
                if (patIDColumn == null || patIDColumn.equals(""))
                    dbExecutorObj.addWhere("pat_id=" + patID);
                else
                    dbExecutorObj.addWhere(patIDColumn + "=" + patID);

                String userIDColumn = dbExecutorObj.getHelperValue("useridcolumn");
                if (userIDColumn != null && !userIDColumn.equals("")) {
                    DBExecutor dbExecutorNew = new DBExecutor("u_user", "user_id", true, null, null, null);
                    dbExecutorNew.addWhere("user_nm='" + UtilProperty.userName + "'");
                    List<HashMap> newRs = dbExecutorNew.executeQuery();
                    int userID;
                    try {
                        userID = Integer.parseInt((String) newRs.get(0).get("USER_ID"));
                    } catch (Exception e) {
                        userID = ((BigDecimal) newRs.get(0).get("USER_ID")).intValue();
                    }
                    dbExecutorObj.addWhere(userIDColumn + "=" + userID);
                }
            }
            if (filterCol != null && !filterCol.equals("")) {
                if (filterCol.equals("timeframe"))
                    dbExecutorObj.addWhereTimeFrame(filterVal);
                else
                    dbExecutorObj.addWhere(filterCol + "=" + filterVal);
            }
            queryObjArr.add(dbExecutorObj);
        }

        queryObjArr.get(0).setQuery();
        mainQuery = mainQuery + queryObjArr.get(0).query;
        for (int queryIndex = 1; queryIndex < queryObjArr.size(); queryIndex++) {
            queryObjArr.get(queryIndex).addUnion(mainQuery);
            queryObjArr.get(queryIndex).setQuery();
            mainQuery = queryObjArr.get(queryIndex).query;
        }

        DBExecutor dbExecutorMainQueryObj = new DBExecutor();
        List<HashMap> mainQryResults = dbExecutorMainQueryObj.executeQuery(mainQuery);
        Assert.assertNotNull("The 'Main Query' results for query: " + queryName + " came back NULL.",
                mainQryResults);

        List<Map<String, String>> mapList = new ArrayList<>();

        String cukeTable = "";//what is this?

        Set<String> curTableName = null;
        for (HashMap map : mainQryResults) {
            curTableName = map.keySet();
            break;
        }
        Assert.assertNotNull("The Set for the curTableName is NULL.", curTableName);

        String[] curTableNameArr = curTableName.toArray(new String[curTableName.size()]);
        for (int i = curTableNameArr.length - 1; i >= 0; i--) {
            String col = curTableNameArr[i];
            if (col.equals("\"Date/Time\""))
                col = col.replace("\"", "");
            col = col.replace("_", " ");
            col = col.trim();
            cukeTable = cukeTable + "|" + col;
            if (Page.findTableColumn(Hooks.getDriver(), curTabName, tableName, col) == null) {
                cukeTable = cukeTable + "*";
            }
        }
        cukeTable = cukeTable + '|';

        for (HashMap map : mainQryResults) {
            cukeTable += "\r\n";
            Map<String, String> tempMap = new HashMap<>();
            for (int i = curTableNameArr.length - 1; i >= 0; i--) {
                String searchStr = curTableNameArr[i];
                if (map.get(searchStr) == null) {
                    cukeTable += "|";
                } else {
                    cukeTable += "|" + map.get(searchStr);
                    tempMap.put(curTableNameArr[i].replace("_", " ").trim(), (String) map.get(searchStr));
                }
            }
            cukeTable += "|";
            mapList.add(tempMap);
        }

        //why is this a switch?  Both 'branches' do the same thing and it doesn't need breaks.
        /*switch (exactMatch) {
            case "match":
                //Assert.assertTrue("Table Data does not match with given data.",
                        //Page.checkDataInTableUsingList(Hooks.getDriver(), curTabName, "the following rows",
                                //exactMatch, tableName, clinical, mapList));
                //break;
            case "contain":
                Assert.assertTrue("Table Data does not match with given data.",
                        Page.checkDataInTableUsingList(Hooks.getDriver(), curTabName, "the following rows",
                                exactMatch, tableName, clinical, mapList));
                break;
            default:
                break;
        }*/

        Assert.assertTrue("Table Data does not match with given data.",
                Page.checkDataInTableUsingList(Hooks.getDriver(), curTabName, "the following rows",
                        exactMatch, tableName, clinical, mapList));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @When("^I select \"(.*)\" from the \"(.*)\" multiselect(?: in the \"(.*)\" pane)?$")
    public void selectItemFromMultiSelect(String value, String selectName, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        Assert.assertTrue("Select Value: " + value + " is not selected.",
                Page.setPKList(Hooks.getDriver(), curTabName, value,
                        selectName.replace(" ", ""), paneName));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I( reconcile and)? Submit the Orders$")
    public void reconcileSubmitOrders(String reconcile) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        if (reconcile == null) {
            //"And I click the "Sign/Submit" button in the "Order Submission" pane"
            clickButton("Sign/Submit", "Order Submission", null);
        } else {
            //"And I click the "Reconcile and Submit" button"
            clickButton("Reconcile and Submit", null, null);
            //"And I click the "Submit Partial Med Rec" button if it exists"
            clickButton("SubmitPartialMedRec", null, "if it exists");
        }
        String paneFrame = UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(curTabName, "PANES",
                "SignOrders", "frame", "", "");
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");

        if (Page.checkElementOnPagePresent(Hooks.getDriver(), curTabName, "SignOrders", "PANES")) {
            /***************************************************************
             *  And I enter "#{password}" in the "Password" field
             *  And I wait "1" seconds
             *  And I click the "OK" button in the "Sign Orders" pane
             **************************************************************/
            enterInTheField(UtilProperty.userPwd, "Password", null);
            waitGivenTime("2");
            clickButton("OK", "Sign Orders", null);
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @When("^I click the \"(.*?)\" (?:link|\"(.*?)\") in the \"(.*?)\" cell header in the \"(.*?)\" table( if table exists)?$")
    public void clickLinkInTableColumnHeader(String elementName, String elementType, String headerTxt, String tableName, String ifItExists) {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        tableName = tableName.replace(" ", "");
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        String paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "TABLES." + tableName, "frame"));
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");


        //If the table with the element to be clicked might not exist
        if (ifItExists != null && !(Page.checkTableExists(Hooks.getDriver(), curTabName, tableName))) {
            UtilFunctions.log(tableName + " table is NULL and not found.  Therefore, " + elementName + " "
                    + elementType + " does not need to be clicked.  Returning...");
            System.out.println(tableName + " table is NULL and not found.  Therefore, " + elementName + " "
                    + elementType + " does not need to be clicked.  Returning...");
            return;
        }

        //if the table exists, click the passed in element in its cell header

        WebElement tableObj = Page.findTable(Hooks.getDriver(), UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(
                curTabName, "TABLES", tableName, "path", "", ""));
        Assert.assertNotNull(tableName + " table is NULL and not found.", tableObj);

        WebElement cellHeaderObj = Page.findTableHeaderCell(tableObj, tableName,
                UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(curTabName, "TABLES", tableName,
                        "head", "", ""),
                headerTxt);
        Assert.assertNotNull(tableName + " table's head is NULL and not found.", cellHeaderObj);

        WebElement element;
        if (elementType == null) {
            if (headerTxt.equals("Hospital OrdersAdd")) {
                element = SeleniumFunctions.findElementByWebElement(cellHeaderObj,
                        By.xpath("//span[@clickmessage='addreconciledorder' and text()='Add']"));
            } else {
                element = SeleniumFunctions.findElementByWebElement(cellHeaderObj,
                        SeleniumFunctions.setByValues("//*[normalize-space(./text())='" + elementName + "']" + ";xpath"));
            }
        } else {
            String elementXpath = UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(curTabName,
                    elementType, elementName.replace(" ", ""), "path",
                    "", "");
            element = SeleniumFunctions.findElementByWebElement(cellHeaderObj, By.xpath(elementXpath));
        }
        Assert.assertNotNull(elementName + " " + elementType + " in table " + tableName +
                " is NULL and not found.", element);

        try {
            element.click();
        } catch (ElementNotInteractableException e) {
            UtilFunctions.log(elementName + " " + elementType + " not clicked due to exception: " +
                    e.getMessage() + ".  Trying again w/ JS click.");
            e.printStackTrace();
            SeleniumFunctions.click(element);
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @When("^I choose \"(.*?)\" option by clicking \"(.*?)\" (?:icon|image)(?: against \"(.*?)\" text)? in the row with \"(.*?)\" as the value under \"(.*?)\" in the \"(.*?)\" table$")
    public void selectMenuItemByClickingIconInTableRow(String option, String objName, String cellText, String srcValue, String srcHeader, String tableName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        objName = objName.replace(" ", "");
        int retryCnt = 0;

        while (retryCnt < GlobalConstants.TWO) {
            retryCnt++;
            try {
                String objNameXPath = UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(curTabName, "MISC_ELEMENTS", objName, "path", "", "");
                WebElement row = Page.findTableRowByCellText(Hooks.getDriver(), curTabName, tableName, srcHeader, srcValue);
                if (cellText == null) {
                    SeleniumFunctions.findElementByWebElement(row, SeleniumFunctions.setByValues(objNameXPath + ";xpath")).click();
                    Thread.sleep(2000);
//                    SeleniumFunctions.findElementByWebElement(row, SeleniumFunctions.setByValues("td[@class='dijitReset dijitMenuItemLabel' and contains(text(), '" + option + "')]" + ";xpath")).click();
                    SeleniumFunctions.findElementByWebElement(row, By.xpath("//td[@class='dijitReset dijitMenuItemLabel' and text() = '" + option + "']")).click();
                } else {
                    WebElement elt = null;
                    List<WebElement> cols = SeleniumFunctions.findElementsByWebElement(row, SeleniumFunctions.setByValues("td;xpath"));
                    System.out.println("cols: " + cols.size());
                    for (WebElement col : cols) {
                        String text = col.getText().trim();
                        System.out.println("Text: " + text);
                        int eltCnt = 0;
//                        if (text.equals(cellText) || text.startsWith(cellText) || text.contains(cellText)) {
                        if (text.equals(cellText) || text.startsWith(cellText)) {
                            System.out.println("Text: " + text + " matches with text: " + cellText);
                            System.out.println("objNameXPath: " + objNameXPath);
//                            WebElement obj1 = SeleniumFunctions.findElementByWebElement(col, SeleniumFunctions.setByValues(objNameXPath + ";xpath"));
                            WebElement obj1 = SeleniumFunctions.findElementByWebElement(col, By.xpath("." + objNameXPath));
                            while (obj1 == null) {
                                eltCnt++;
                                obj1 = SeleniumFunctions.findElementByWebElement(col, SeleniumFunctions.setByValues(objNameXPath + ";xpath"));
                                Thread.sleep(2000);
                                System.out.println("Waiting for Obj1.....");
                                if (eltCnt > GlobalConstants.TWO)
                                    break;

                            }
                            obj1.click();
                            System.out.println("Obj1 clicked.");
                            eltCnt = 0;
//                            elt = SeleniumFunctions.findElementByWebElement(row, SeleniumFunctions.setByValues(".//td[@class='dijitReset dijitMenuItemLabel' and contains(text(), '" + option + "')]" + ";xpath"));
                            elt = SeleniumFunctions.findElementByWebElement(row, By.xpath("//td[@class='dijitReset dijitMenuItemLabel' and contains(text(), '" + option + "')]"));
                            while (elt == null) {
                                eltCnt++;
                                elt = SeleniumFunctions.findElementByWebElement(row, SeleniumFunctions.setByValues(".//td[@class='dijitReset dijitMenuItemLabel' and contains(text(), '" + option + "')]" + ";xpath"));
                                Thread.sleep(2000);
                                System.out.println("Waiting for Object elt.....");
                                if (eltCnt > GlobalConstants.TWO)
                                    break;
                            }
                            break;
                        }
                    }
                    elt.click();
                    Thread.sleep(2000);
                    Assert.assertNotNull("Element not present.", elt);
                    break;
                }
            } catch (Exception e) {
                if (retryCnt > GlobalConstants.TWO)
                    Assert.assertTrue("Element Object is not displayed.", false);
            }
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^patient \"(.*?)\" should( not)? be on the patient list$")
    public void checkPatientOnPatientList(String patientName, String no) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String name = UtilFunctions.reformName(patientName).toUpperCase();
        if ((" not").equals(no)) {
            Assert.assertFalse(PatientListPage.checkIfPatientExists(Hooks.getDriver(), name));
        } else {
            Assert.assertTrue(PatientListPage.checkIfPatientExists(Hooks.getDriver(), name));
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^the \"(.*)\" table should load with the following columns$")
    public void checkColumnsInTable(String tableName, DataTable dataTable) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        List<String> dataList = dataTable.asList(String.class);
        for (String columnName : dataList) {
            System.out.println("Passed values -> " + columnName);
            String colRef = Page.findTableColumn(Hooks.getDriver(), curTabName, tableName, columnName);
            System.out.println(colRef);
            if (colRef == null) {
                Assert.assertTrue("Column " + columnName + "  is not present ", false);
                break;
            }
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I move the mouse over the \"(.*?)\" text in the row with \"(.*?)\" as the value under \"(.*?)\" in the \"(.*?)\" table$")
    public void mouseOverText(String value, String srcValue, String srcHeader, String tableName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        value = value.trim();
        WebElement row = Page.findTableRowByCellText(Hooks.getDriver(), curTabName, tableName, srcHeader, srcValue);
        List<WebElement> columns = SeleniumFunctions.findElementsByWebElement(row, By.xpath(".//td/*"));

        for (WebElement elt : columns) {
            if (elt != null) {
                String text = elt.getText();
                text = text.trim();
                if (text.equals(value) || text.startsWith(value)) {
                    Assert.assertTrue("Mouse over " + value + " failed", SeleniumFunctions.mouseOver(Hooks.getDriver(), elt));
                    break;
                }
            }
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I click the \"(.*?)\" (?:button|element)? in the row with \"(.*?)\" as the value under \"(.*?)\" in the \"(.*?)\" table$")
    public void clickButtonInTableRow(String destHeader, String srcValue, String srcHeader, String tableName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        destHeader = destHeader.replace(" ", "");
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        String destPath;
        if (UtilFunctions.getElementFromJSONFile(fileObj, "MISC_ELEMENTS." + destHeader, "path") != null) {
            destPath = UtilFunctions.getElementFromJSONFile(fileObj, "MISC_ELEMENTS." + destHeader, "path");
        } else {
            destPath = UtilFunctions.getElementFromJSONFile(fileObj, "BUTTONS." + destHeader, "path");
        }
        SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.TWENTY, "destPath" + ";xpath");
        List<WebElement> rows = Page.findTableRowsByValue(Hooks.getDriver(), tableName, srcHeader, srcValue);
//        String t = row.getAttribute("innerHTML");
//        System.out.println(t);
//
//        String t1 = row.getText();
//        System.out.println(t1);
        for (WebElement row : rows) {
            SeleniumFunctions.findElementByWebElement(row, By.xpath(destPath)).click();
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @And("^I wait (?:up to \"(.*?)\" seconds )?for loading to complete$")
    public void waitForLoad(String time) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        int waitTime;
        if (time == null) {
            waitTime = GlobalConstants.FIFTEEN;
        } else
            waitTime = Integer.parseInt(time);
        try {
            SeleniumFunctions.explicitWait(Hooks.getDriver(), waitTime, "//img[@id='loadingImg']" + ";xpath");
        } catch (Exception e) {
            e.printStackTrace();
            UtilFunctions.log("Page not loded" + e.getMessage());
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^the \"(.*?)\" window should open$")
    public void checkWindow(WebDriver driver, String windowName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        WebDriver window = driver.switchTo().window(windowName);
        Assert.assertNotNull("Window: " + windowName + " is not loaded", window);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^I close the \"(.*?)\" window and switch to the \"(.*?)\" window$")
    public void closeWindow(String windowName, String switchTo) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        WebDriver driver = Hooks.getDriver();
        driver.close();
        switchFocus(switchTo);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^the following options should( not)? be available in the \"(.*?)\" dropdown(?: in the \"(.*?)\" pane)?$")
    public void checkDropDownOptions(String no, String dropDownName, String paneName, DataTable dataTable) {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String paneFrames;
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        dropDownName = dropDownName.replace(" ", "");
        if (paneName == null) {
            paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "DROPDOWNS." + dropDownName, "frame"));
        } else {
            paneName = paneName.replace(" ", "");
            paneFrames = (String) frameMap.get(UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
        }
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");

        String[] elementType = UtilFunctions.getElementStringAndType(fileObj, "DROPDOWNS." + dropDownName);
        String searchString = elementType[0];
        String searchMethod = elementType[1];
        boolean res;
        String dropDownVal;
        WebElement dropDownObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(searchString + ";" + searchMethod));
        if (dropDownObj != null) {
            Select select = new Select(dropDownObj);
            List<WebElement> dropDownOptions = select.getOptions();
            List<String> tableValues = dataTable.asList(String.class);
            for (String value : tableValues) {
                res = false;
                for (WebElement dropDownOption : dropDownOptions) {
                    dropDownVal = dropDownOption.getText();
                    if (res = dropDownVal.equals(value)) {
                        res = true;
                        break;
                    }
                }
                if (no == null)
                    Assert.assertTrue("Value: " + value + " is not found in dropdown: " + dropDownName, res);
                else
                    Assert.assertFalse("Value: " + value + " is found in dropdown: " + dropDownName, res);
            }
        } else {
            Assert.assertTrue("Dropdown: " + dropDownName + " is not found", false);
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");

    }


    @Then("^the \"(.*?)\" table should( not)? load$")
    public void checkTableLoad(String tableName, String no) throws Throwable {
        if (no == null) {
            Assert.assertTrue("Table: " + tableName + " is not loaded", Page.checkTableExists(Hooks.getDriver(), curTabName, tableName));
        } else {
            if (!Page.checkTableExists(Hooks.getDriver(), curTabName, tableName))
                Assert.assertFalse("Table: " + tableName + " is loaded", false);
            else
                Assert.assertFalse("Table: " + tableName + " is loaded",
                        Page.checkTableExists(Hooks.getDriver(), curTabName, tableName));
        }
    }


    @Then("^the text \"(.*?)\" should( not)? appear in the \"(.*?)\" search list$")
    public void textAppearInList(String text, String no, String listName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        if (no == null) {
            Assert.assertTrue("Text not appears:", PatientListPage.textAppears(Hooks.getDriver(), text));
        } else {
            Assert.assertFalse("Text appears:", PatientListPage.textAppears(Hooks.getDriver(), text));
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");


    }


    @And("^I create the department \"(.*?)\"$")
    public void createDepartment(String departmentName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        clickButton("NewDepartment", null, null);
        enterInTheField(departmentName, "Department Name", null);
        enterInTheField(departmentName, "Department Label", null);
        clickButton("Save", null, null);
        selectAlert("OK", null);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @Then("^the \"(.*?)\" search list should( not)? load$")
    public void searchList(String listName, String action) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        if (action != null) {
            Assert.assertFalse("Search List loaded", PatientListPage.searchListLoad(Hooks.getDriver()));
        } else
            Assert.assertTrue("Search List did not load", PatientListPage.searchListLoad(Hooks.getDriver()));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Given("^the provider with firstname \"(.*?)\" and lastname \"(.*?)\" is in the provider list$")
    public void checkIfProviderIsInList(String fname, String lname) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        String providerName = lname + ", " + fname;
        String paneName = "Provider Main Search";
        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        globalStepdefs.enterInTheField(providerName, "Provider Name ID Alias", "Provider Main Search");
        globalStepdefs.selectFromDropdown("PROVIDER", "Role", paneName, null);
        globalStepdefs.clickButton("Search", paneName, null);
        Page.findTableRowByCellText(driver, curTabName, "Provider Search Results", "Last Name", "$SPECIAL");
        //Only create provider if provider doesn't already exist
        String providerXpath = "//tr[@fullname='" + lname + ", " + fname + "']";
        SeleniumFunctions.explicitWait(driver, 2, providerXpath + ";xpath");
        if (SeleniumFunctions.findElement(driver, By.xpath(providerXpath)) == null) {
            globalStepdefs.clickButton("Add", "ProviderMain", null);
            globalStepdefs.waitGivenTime("2");
            globalStepdefs.enterInTheField(lname, "ProviderLastName", "Add Provider");
            globalStepdefs.enterInTheField(fname, "ProviderFirstName", "Add Provider");
            globalStepdefs.selectRadioListButton("Male", "Gender", "Add Provider", null);
            globalStepdefs.clickButton("Saveprovider", "AddProvider", null);
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I select the \"(.*?)\" section$")
    public void selectSection(String SectionName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        Thread.sleep(3000);
        SectionName = SectionName.replace(" ", "");

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        UtilFunctions.log("SectionName: " + SectionName);
        String section = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "SECTION." + SectionName, "frame"));
        SeleniumFunctions.selectFrame(Hooks.getDriver(), section, "id");

        String[] elementType = UtilFunctions.getElementStringAndType(fileObj, "SECTION." + SectionName);
        String SectionPath = elementType[0];
        String SectionMethod = elementType[1];
        SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues(SectionPath + ";" + SectionMethod)).click();

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I click the \"(.*?)\" button for the \"(.*?)\" entry$")
    public void clickButtonInList(String buttonName, String text) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        buttonName = buttonName.replace(" ", "");
        String paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "BUTTONS." + buttonName, "frame"));
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");
        String buttonVal;
        String buttonValue;
        String buttonMethod;

        if (StringUtils.isEmpty(UtilFunctions.getElementFromJSONFile(fileObj, "BUTTONS." + buttonName, "id"))) {
            buttonMethod = "xpath";
            buttonVal = UtilFunctions.getElementFromJSONFile(fileObj, "BUTTONS." + buttonName, "path");
        } else {
            buttonMethod = "id";
            buttonVal = UtilFunctions.getElementFromJSONFile(fileObj, "BUTTONS." + buttonName, "id");
        }
        buttonValue = buttonVal.replace("textVal", text);

        System.out.println(buttonValue);

        SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues(buttonValue + ";" + buttonMethod)).click();

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    //Refactored
    @When("^I select \"(.*?)\" from the \"(.*?)\" pkdropdown(?: in the \"(.*?)\" pane)?$")
    public void selectFromPKDropDown(String value, String dropDownName, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        dropDownName = dropDownName.replace(" ", "");

        String tabName = curTabName;
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        String paneFrames;
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        if (paneName == null) {
            paneFrames = (String) frameMap.get(UtilFunctions.getElementFromJSONFile(fileObj, "PKDROPDOWNS." +
                    dropDownName, "frame"));
        } else {
            paneName = paneName.replace(" ", "");
            paneFrames = (String) frameMap.get(UtilFunctions.getElementFromJSONFile(fileObj, "PANES." +
                    paneName, "frame"));
        }
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");

        String dropdownPath = UtilFunctions.getElementFromJSONFile(fileObj, "PKDROPDOWNS." + dropDownName,
                "path");
        if (dropdownPath == null) {
            UtilFunctions.log(dropDownName + " dropdown has no path set in its JSON element.  Asserting fail.");
            Assert.fail(dropDownName + " dropdown has no path set in its JSON element. The JSON object's path needs to be defined.");
        }
        WebElement dropDownElt = SeleniumFunctions.findElement(Hooks.getDriver(), By.xpath(dropdownPath));
        Assert.assertNotNull(dropDownName + " PK dropdown is NULL and not found.", dropDownElt);

        try {
            dropDownElt.click();
        } catch (ElementNotInteractableException e) {
            UtilFunctions.log(e.getMessage());
            e.printStackTrace();
            SeleniumFunctions.click(dropDownElt);
        }
        Thread.sleep(500);

        //This is the path for the <select> or <UL> that actually drops down and displays when you click the dropdown.
        //But, you have to click the dropdown first.
        String dropDownMenuPath = UtilFunctions.getElementFromJSONFile(fileObj, "PKDROPDOWNS." + dropDownName,
                "listPath");
        WebElement menuItem = null;
        if (dropDownMenuPath != null) {
            WebElement dropDownMenu = SeleniumFunctions.findElement(Hooks.getDriver(), By.xpath(dropDownMenuPath));
            Assert.assertNotNull(dropDownName + " PK dropdown Menu did not drop down / is NULL and not found.", dropDownMenu);
            Assert.assertTrue(dropDownName + " PK dropdown Menu did not drop down / is not displayed.", dropDownMenu.isDisplayed());

            menuItem = SeleniumFunctions.findElementByWebElement(dropDownMenu, By.xpath(".//*[text()='" + value + "']"));
        } else {
            menuItem = SeleniumFunctions.findElementByWebElement(dropDownElt,
                    SeleniumFunctions.setByValues(".//ul[@class='dropdownListBoxChoices']/li[text()='" + value + "']" + ";xpath"));
            if (menuItem == null)
                menuItem = SeleniumFunctions.findElementByWebElement(dropDownElt,
                        SeleniumFunctions.setByValues(".//select[@class='dropdownList']/option[text()='" + value + "']" + ";xpath"));
        }

        Assert.assertNotNull(dropDownName + " PK dropdown Menu Item: " + value + " is NULL and not found.", menuItem);
        try {
            menuItem.click();
        } catch (ElementNotInteractableException e) {
            UtilFunctions.log(e.getMessage());
            e.printStackTrace();
            SeleniumFunctions.click(menuItem);
        }
        Thread.sleep(500);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @Then("^the following tabs? should( not)? load$")
    public void checkNavigationTabLoad(String no, DataTable dataTable) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        List<String> dataList = dataTable.asList(String.class);

        for (String row : dataList) {
            if (no != null && (" not").equals(no)) {
                Assert.assertFalse("Tab does not exist ", NavBar.navigationTabExists(Hooks.getDriver(), row));
            } else {
                Assert.assertTrue("Tab exists ", NavBar.navigationTabExists(Hooks.getDriver(), row));
            }
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^the \"(.*?)\" dropdown(?: in the \"(.*?)\" pane)? should be blank$")
    public void verifyDropdownBlank(String dropDownName, String paneName) {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        Assert.assertTrue("Dropdown '" + dropDownName + "' is not blank.", Page.checkDropdownValue(Hooks.getDriver(), curTabName, "", dropDownName, paneName));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^the \"(.*?)\" dropdown(?: in the \"(.*?)\" pane)? should be \"(.*?)\"$")
    public void verifyDropdownValue(String dropDownName, String paneName, String value) {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        Assert.assertTrue("Value check for dropdown '" + dropDownName + "' failed.",
                Page.checkDropdownValue(Hooks.getDriver(), curTabName, value, dropDownName, paneName));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^the \"(.*?)\" pkdropdown(?: in the \"(.*?)\" pane)? should( not)? have the following items$")
    public void verifyOptionsInPKDropdown(String dropDownName, String paneName, String no, DataTable dataTable) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        UtilFunctions.log("Current tab name: " + curTabName);
        UtilFunctions.log("PKDropdown: " + dropDownName);

        dropDownName = dropDownName.replace(" ", "");
        String paneFrames;
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        String dropDownPath;
        String dropDown = UtilFunctions.getElementFromJSONFile(fileObj, "PKDROPDOWNS." + dropDownName, "path");
        String dropDownList = UtilFunctions.getElementFromJSONFile(fileObj, "PKDROPDOWNS." + dropDownName, "listPath");

        List<WebElement> itemsInDropdown = null;
        boolean success = false;

        if (StringUtils.isEmpty(paneName)) {
            paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PKDROPDOWNS." + dropDownName, "frame"));
            SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");
        } else {
            paneName = paneName.replace(" ", "");
            paneFrames = (String) frameMap.get(UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
            SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");
        }

        if (dropDown == null) {
            dropDownPath = UtilFunctions.getElementFromJSONFile(fileObj, "PKDROPDOWNS." + dropDownName, "path") + "//following-sibling::*[1]";
            WebElement dropDownElt = SeleniumFunctions.findElement(Hooks.getDriver(), By.xpath(dropDownPath));
            SeleniumFunctions.findElementByWebElement(dropDownElt, By.xpath(".//input[@class='dropdownShowHideOptions']")).click();
            itemsInDropdown = SeleniumFunctions.findElements(Hooks.getDriver(), By.xpath(dropDownPath + "//ul[@class='dropdownListBoxChoices']/li"));
        } else {
            SeleniumFunctions.findElement(Hooks.getDriver(), By.xpath(dropDown)).click();
            dropDownList = dropDownList + "//span";
            itemsInDropdown = SeleniumFunctions.findElements(Hooks.getDriver(), By.xpath(dropDownList));
        }
        List<String> dataList = dataTable.asList(String.class);
        for (String option : dataList) {
            if (itemsInDropdown != null) {
                for (WebElement optionElt : itemsInDropdown) {
                    String listOption = optionElt.getText();
                    if (listOption.equals(option)) {
                        success = true;
                        break;
                    }
                }
            }
        }
        if ((" not").equals(no)) {
            Assert.assertFalse(success);
        } else {
            Assert.assertTrue(success);
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    //select entry from tabledropdown
    @When("^I select \"(.*?)\" from the \"(.*?)\" tabledropdown(?: in the \"(.*?)\" pane)?$")
    public void selectFromTableDropDown(String value, String dropDownName, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        dropDownName = dropDownName.replace(" ", "");
        String paneFrames;
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        if (paneName.equals("")) {
            paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "TABLEDROPDOWNS." + dropDownName, "frame"));
        } else {
            paneName = paneName.replace(" ", "");
            paneFrames = (String) frameMap.get(UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
        }
        SeleniumFunctions.selectFrame(driver, paneFrames, "id");
        String[] elementType = UtilFunctions.getElementStringAndType(fileObj, "TABLEDROPDOWNS." + dropDownName);
        String dropdownPath = elementType[0];
        String dropdownMethod = elementType[1];
        String tableName = UtilFunctions.getElementFromJSONFile(fileObj, "TABLEDROPDOWNS." + dropDownName, "table");
        String clearButton = UtilFunctions.getElementFromJSONFile(fileObj, "TABLEDROPDOWNS." + dropDownName, "buttonToClear");
        try {
            SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(dropdownPath + ";" + dropdownMethod)).click();
            if (value.isEmpty()) {
                Page.clickButton(driver, GlobalStepdefs.curTabName, clearButton);
            } else {
                WebElement tableObj = Page.findTable(driver, GlobalStepdefs.curTabName, tableName);
                if (tableObj != null) {
                    try {
                        SeleniumFunctions.findElementByWebElement(tableObj, By.xpath("//td[contains(span, '" + value + "') or starts-with(normalize-space(./text()), '" + value + "')]")).click();
                    } catch (Exception e) {
                        Assert.assertTrue("Table value " + value + " not selected due to error " + e.getMessage(), false);
                    }
                } else {
                    Assert.assertTrue("Table " + tableName + " not present ", false);
                }
            }
        } catch (Exception e) {
            Assert.assertTrue("Tabledropdown " + dropDownName + " is not clicked due to error " + e.getMessage(), false);
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @Then("^the \"(.*?)\" (image|icon|button|checkbox) should be shown in the following rows in the \"(.*?)\" table$")
    public void shouldBeDisplayedInTable(String itemName, String itemType, String tableName, DataTable dataTable)
            throws Throwable {

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        tableName = tableName.replace(" ", "");
        itemName = itemName.replace(" ", "");
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
        String imagePath;
        if (itemType.equals("button")) {
            imagePath = UtilFunctions.getElementFromJSONFile(fileObj, "BUTTONS." + itemName, "path");
        } else if (itemType.equals("checkbox")) {
            imagePath = UtilFunctions.getElementFromJSONFile(fileObj, "CHECKBOXES." + itemName, "path");
        } else {
            imagePath = UtilFunctions.getElementFromJSONFile(fileObj, "IMAGES." + itemName, "path");
        }

        String colHeader = null;
        List<Map<String, String>> dataList = dataTable.asMaps(String.class, String.class);
        Assert.assertTrue("Incorrect dataTable format, resulting in dataList of size 0.",
                dataList.size() > 0);
        String columnName = (String) dataList.get(0).keySet().toArray()[1];

        for (Map data : dataList) {
            String displayState = (String) data.get("Displayed");
            String rowValue = ((String) data.get(columnName));
            if (!columnName.equals(""))
                colHeader = columnName;

            WebElement tableRow = Page.findTableRowByCellText(Hooks.getDriver(), curTabName, tableName,
                    colHeader, rowValue);
//            WebElement imageObj = SeleniumFunctions.findElementByWebElement(tableRow,
//                    SeleniumFunctions.setByValues("." + imagePath + ";xpath"));

            //OG If/Else
            if (tableRow != null) {
                WebElement imageObj = SeleniumFunctions.findElementByWebElement(tableRow,
                        SeleniumFunctions.setByValues("." + imagePath + ";xpath"));
                if (displayState.trim().equalsIgnoreCase("true")) {
                    Assert.assertTrue("Element " + itemName + " is not present in the table row",
                            imageObj.isDisplayed());
                } else {
                    //imageObj may not be found if it isn't displayed in UI.
                    if (imageObj == null) {
                        Assert.assertNull("Element " + itemName + " is present in the table for value " +
                                rowValue, imageObj);
                    } else {
                        Assert.assertFalse("Element " + itemName + " is present in the table for value " +
                                rowValue, imageObj.isDisplayed());
                    }
                }
            } else {
                Assert.assertTrue("Table row with value " + rowValue + " is not retrieved from table " +
                        tableName, false);
            }


            //My new If/Else that broke Scenario: Batch Charge Entry
            /*if(tableRow != null) {
                if (displayState.trim().equalsIgnoreCase("true") && imageObj.isDisplayed()) {
                    Assert.assertTrue("Element " + itemName + " is not present in the table row", true);
                } else {
                    Assert.assertTrue("Element " + itemName + " is not present in the table row", imageObj.isDisplayed());
                }
            }
            else{
                tableRow = Page.findTableRowByCellText(Hooks.getDriver(), curTabName, tableName,
                        colHeader, rowValue);
                imageObj = SeleniumFunctions.findElementByWebElement(tableRow,
                        SeleniumFunctions.setByValues("." + imagePath + ";xpath"));
                if (displayState.trim().equalsIgnoreCase("true") && imageObj.isDisplayed()) {
                    Assert.assertTrue("Element " + itemName + " is not present in the table row", true);
                }else{
                    Assert.assertTrue("Element " + itemName + " is not present in the table row", imageObj.isDisplayed());
                }
            }*/

        }//end FOR loop

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^the checkbox should be (checked|unchecked) in the rows with \"(.*?)\" cell text in the \"(.*?)\" table$")
    public void validateCheckBoxIntableWithRow(String checkType, String cellText, String tableName) throws Throwable {

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        Assert.assertTrue("Checkbox is not " + checkType + " in the row with text " + cellText,
                Page.validateCheckBoxInTableWithRow(Hooks.getDriver(), checkType, cellText, tableName));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @Then("^the \"(.*?)\" checkbox should be (checked|unchecked)(?: in the \"(.*?)\" pane)?$")
    public void validateCheckbox(String checkboxName, String checkType, String paneName) {

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        if (paneName == null)
            paneName = "";

        if (Page.getCheckBoxStatus(Hooks.getDriver(), curTabName, checkboxName, checkType, paneName))
            Assert.assertTrue(checkboxName + "checkbox is not " + checkType + " when it should be.",
                    true);
        else
            Assert.assertTrue(checkboxName + "checkbox is not " + checkType + " when it should be.",
                    Page.getCheckBoxStatus(Hooks.getDriver(), curTabName, checkboxName, checkType, paneName));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @Then("^the checkbox should be checked in all rows in the \"(.*?)\" table$")
    public void validateCheckBoxInTable(String tableName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        tableName = tableName.replace(" ", "");
        String[] tableDetailArr = UtilFunctions.getTableValues(curTabName, tableName);
        String tablePath = tableDetailArr[0];
        String tableId = tableDetailArr[1];
        String tableHead = tableDetailArr[2];
        String tableBody = tableDetailArr[3];
        String paneFrames = tableDetailArr[4];

        UtilFunctions.log("tablePath: " + tablePath);
        UtilFunctions.log("tableID: " + tableId);
        UtilFunctions.log("tableHead: " + tableHead);
        UtilFunctions.log("tableBody: " + tableBody);
        UtilFunctions.log("PaneFrames: " + paneFrames);

        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");
        SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.TWENTY, tablePath + ";xpath");
        WebElement tableElement = findTable(Hooks.getDriver(), tablePath);
        WebElement tableBodyObj = SeleniumFunctions.findElementByWebElement(tableElement,
                SeleniumFunctions.setByValues(tableBody + ";xpath"));
        List<WebElement> checkBox = SeleniumFunctions.findElementsByWebElement(tableBodyObj,
                SeleniumFunctions.setByValues("input;tagName"));
        UtilFunctions.log("Checking checkbox for all rows");
        for (WebElement aCheckBox : checkBox) {
            if (!aCheckBox.isSelected()) {//this can get initial state
                aCheckBox.click();
            }
        }
        UtilFunctions.log("Check box checked in all rows");
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @When("^I (un)?check all checkboxes in \"(.*?)\" pane?$")
    public void checkAllCheckBoxesInPane(String checkType, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        String paneFrames = UtilFunctions.getFrameValue(frameMap,
                UtilFunctions.getElementFromJSONFile(fileObj,
                        "PANES." + paneName.replace(" ", ""), "frame"));
        UtilFunctions.log("PaneFrames: " + paneFrames);
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");

        String mainXPath = UtilFunctions.getElementFromJSONFile(fileObj,
                "PANES." + paneName.replace(" ", ""), "path");
        SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.TEN, mainXPath + ";xpath");
        WebElement mainEle = SeleniumFunctions.findElement(Hooks.getDriver(),
                SeleniumFunctions.setByValues(mainXPath + ";xpath"));
        Assert.assertNotNull("Main WebElement not present", mainEle);

        List<WebElement> checkBoxList;
        switch (paneName) {
            case "Edit Dept Pickers By Visit":
                checkBoxList = SeleniumFunctions.findElementsByWebElement(mainEle,
                        SeleniumFunctions.setByValues("//input[@type='checkbox' and @checkboxgroup='pkVisitType'];xpath"));
                break;
            case "Edit My Pickers By Visit":
                checkBoxList = SeleniumFunctions.findElementsByWebElement(mainEle,
                        SeleniumFunctions.setByValues("//input[@type='checkbox' and @checkboxgroup='pkVisitType'];xpath"));
                break;
            default:
                checkBoxList = SeleniumFunctions.findElementsByWebElement(mainEle,
                        SeleniumFunctions.setByValues("//input[@type='checkbox' and @class='orderCheckbox'];xpath"));
                break;
        }
        Assert.assertNotEquals("CheckBox List is empty.", 0, checkBoxList.size());

        for (WebElement checkBoxObj : checkBoxList) {
            if (checkBoxObj.isSelected() && checkType != null) {
                while (checkBoxObj.isSelected()) {
                    UtilFunctions.log("Trying to un-check checkbox");
                    System.out.println(checkBoxObj.isDisplayed());
                    System.out.println(checkBoxObj.isEnabled());
                    checkBoxObj.sendKeys(Keys.ARROW_DOWN);
                    checkBoxObj.sendKeys(Keys.ARROW_UP);
                    checkBoxObj.sendKeys(Keys.ARROW_DOWN);
                    checkBoxObj.sendKeys(Keys.ARROW_UP);
                    checkBoxObj.click();
                    Thread.sleep(500);
                }
            } else if (!checkBoxObj.isSelected() && checkType == null) {
                while (!checkBoxObj.isSelected()) {
                    UtilFunctions.log("Trying to check checkbox");
                    System.out.println(checkBoxObj.isDisplayed());
                    System.out.println(checkBoxObj.isEnabled());
                    checkBoxObj.sendKeys(Keys.ARROW_DOWN);
                    checkBoxObj.sendKeys(Keys.ARROW_UP);
                    checkBoxObj.sendKeys(Keys.ARROW_DOWN);
                    checkBoxObj.sendKeys(Keys.ARROW_UP);
                    checkBoxObj.click();
                    Thread.sleep(500);
                }
            }
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^the \"(.*?)\" menu should have the following options disabled?$")
    public void verifyMenuOptionsDisabled(String menuName, DataTable optionList) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        menuName = menuName.replace(" ", "");

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        String menuFrame = (String) frameMap.get(UtilFunctions.getElementFromJSONFile(fileObj, "PKMENUS." + menuName, "frame"));
        String menuPath = UtilFunctions.getElementFromJSONFile(fileObj, "PKMENUS." + menuName, "path");
        String menuID = UtilFunctions.getElementFromJSONFile(fileObj, "PKMENUS." + menuName, "id");

        UtilFunctions.log("MenuPath: " + menuPath);
        UtilFunctions.log("MenuID: " + menuID);

        SeleniumFunctions.selectFrame(driver, menuFrame, "id");
        SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, menuPath + ";xpath");
        SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(menuPath + ";xpath")).click();

        for (String value : optionList.asList(String.class)) {
            //below xpath is of the options disabled in menu
            WebElement menuList = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//ul[@id='" + menuID + "']//li[@pkmenuitemvalue='" + value + "' and @class='disabled']"));
            Assert.assertNotNull("'" + value + "' is enabled or '" + menuName + "' is not found ", menuList);

        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I save the form entry(?: in the \"(.*?)\" pane)?$")
    public void saveFormentry(String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String buttonName = "Yes";
        if (paneName == null) {
            Page.clickButton(Hooks.getDriver(), curTabName, buttonName);
        } else {
            Page.clickButton(Hooks.getDriver(), curTabName, buttonName, paneName);
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    //Un/check multiple Location check boxes
    @When("^I (un)?check the following location checkboxes(?: in the \"(.*?)\" pane)?$")
    public void checkMultipleLocationCheckBoxes(String checkType, String paneName, DataTable dataTable) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String checkBoxName = "Sort On Location";
        checkBoxName = checkBoxName.replace(" ", "");
        String paneFrames;

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        UtilFunctions.log("PaneName: " + paneName);
        checkBoxName = checkBoxName.replace(" ", "");
        UtilFunctions.log("Dropdown Name: " + checkBoxName);
        if (paneName.equals("")) {
            paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "DROPDOWNS." + checkBoxName, "frame"));
            SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");
        } else {
            paneName = paneName.replace(" ", "");
            paneFrames = (String) frameMap.get(UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
            SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");
        }

        if (checkType == null) {
            checkType = "check";
        } else {
            checkType = "uncheck";
        }

        List<String> texts = dataTable.asList(String.class);
        for (String textVal : texts) {
            UtilFunctions.log("CheckBoxName: " + checkBoxName);
            Page.setDynatreeCheckbox(Hooks.getDriver(), checkBoxName, checkType, textVal);
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    //Medication Reconciliation table is complex and doesn't fit in well with our "findTableHeaderByValue, then find cell in column" strategy
    //This custom step can be used to verify if an image is contained within a medication row.
    @Then("^the \"(.*?)\" image should( not)? be displayed for the \"(.*?)\" row in the Medication Reconciliation table$")
    public void MedRecImageDisplayedCheck(String imageName, String no, String medText) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
        String imagePath = UtilFunctions.getElementFromJSONFile(fileObj, "IMAGES." + imageName, "path");
        //Prepare imagePath string for insertion into imageRowXPath expression
        imagePath = imagePath.replace("//", "");

        //Find image in table by silly xpath
        WebElement myTable = Page.findTable(Hooks.getDriver(), GlobalStepdefs.curTabName, "Medication Reconciliation");
        String imageRowXPath = "//tr[descendant::span[normalize-space(text()) = '" + medText + "'] and descendant::" + imagePath + "]";
        WebElement ele = SeleniumFunctions.findElementByWebElement(myTable, By.xpath(imageRowXPath));

        if (no != null) {
            Assert.assertNull("Image found.", ele);
        } else {
            Assert.assertNotNull("Image not found.", ele);
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^the \"(.*)\" pane should( not)? appear with the text \"(.*)\"$")
    public void checkPaneLoadWithText(String pane, String no, String text) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        WebElement paneObj = Page.findPane(Hooks.getDriver(), curTabName, pane);

        if (no == null) {
            Assert.assertNotNull(pane + " pane is not loaded", paneObj);
            Assert.assertTrue("Text " + text + " is not visible in the " + pane + " pane", paneObj.getText().contains(text));
        } else {
            if (paneObj != null) {
                UtilFunctions.log("Pane " + pane + " found with text:\n" + text);
                Assert.assertFalse("Pane " + pane + " appeared with the text" + text, paneObj.getText().contains(text));
            } else {
                UtilFunctions.log("Pane " + pane + " not found with text:\n" + text);
                UtilFunctions.log("Pane " + pane + " is not appeared with the text " + text);
            }
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^the \"(.*?)\" \"(.*?)\" should( not)? be visible$")
    public void checkIfElementVisible(String itemName, String itemType, String no) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        itemName = itemName.replace(" ", "");
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);

        //Element definition blocks are plural.  Try to get the element by appending either "S" or "ES" to the itemType.
        String itemToSearch = itemType.toUpperCase() + "S." + itemName;
        String[] stringAndType = UtilFunctions.getElementStringAndType(fileObj, itemToSearch);
        if (stringAndType[0] == null) {
            itemToSearch = itemType.toUpperCase() + "ES." + itemName;
            stringAndType = UtilFunctions.getElementStringAndType(fileObj, itemToSearch);
        }
        String elementString = stringAndType[0];  //xpath, id, etc.
        String elementType = stringAndType[1];

        String paneFrame = UtilFunctions.getElementFromJSONFile(fileObj, itemToSearch, "frame");
        String paneFrames = UtilFunctions.getFrameValue(frameMap, paneFrame);
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");

        WebElement elt;
        if (itemName.equals("PatientList")) {
            //TODO: This code path appears to be unused.  Please test before using.
            elt = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(elementString + ";" + elementType));
            WebElement menuObj = SeleniumFunctions.findElement(Hooks.getDriver(), By.xpath(elementString));
            if (!menuObj.isDisplayed()) {
                String elementID = UtilFunctions.getElementFromJSONFile(fileObj, itemToSearch, "path2");
                elt = SeleniumFunctions.findElement(Hooks.getDriver(), By.xpath(elementID));
            }
        } else {
            elt = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(elementString + ";" + elementType));
        }

        if (StringUtils.isEmpty(no)) {
            Assert.assertNotNull(elt);
            Assert.assertTrue(elt.isDisplayed());
        } else {
            if (elt == null) {
                Assert.assertNull(elt);
            } else {
                Assert.assertFalse(elt.isDisplayed());
            }
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @Then("^the value in the \"(.*?)\" textfield should be blank$")
    public void clearValueInTextField(String fieldName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        try {
            fieldName = fieldName.replace(" ", "");
            Page.getTextBox(Hooks.getDriver(), curTabName, fieldName, null).clear();
        } catch (Exception e) {
            Assert.assertTrue("Textfield " + fieldName + " is not cleared", false);
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^the option \"(.*?)\" should( not)? be available in the \"(.*?)\" dropdown list(?: in the \"(.*?)\" pane)?$")
    public void verifyDropDownList(String value, String no, String dropDownName, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        String paneFrame;
        String searchString = "";
        String searchPath = "";
        dropDownName = dropDownName.replace(" ", "");
        UtilFunctions.log("Dropdown Name: " + dropDownName);
        UtilFunctions.log("PaneName: " + paneName);
        if (paneName == null) {
            paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "DROPDOWNS." + dropDownName, "frame"));
            SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
        } else {
            paneName = paneName.replace(" ", "");
            paneFrame = (String) frameMap.get(UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
            SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
        }
        try {
            if (!UtilFunctions.getElementFromJSONFile(fileObj, "DROPDOWNS." + dropDownName, "path").equals("")) {
                searchString = UtilFunctions.getElementFromJSONFile(fileObj, "DROPDOWNS." + dropDownName, "path");
                searchPath = "xpath";
            }
        } catch (Exception e) {
            searchString = UtilFunctions.getElementFromJSONFile(fileObj, "DROPDOWNS." + dropDownName, "name");
            if (searchString == null) {
                searchString = UtilFunctions.getElementFromJSONFile(fileObj, "DROPDOWNS." + dropDownName, "id");
                searchPath = "id";
                UtilFunctions.log("Search path Exception: " + e.getMessage());
            } else
                searchPath = "name";
        }
        Boolean flag = false;
        SeleniumFunctions.explicitWait(driver, GlobalConstants.FIVE, searchString + ";" + searchPath);
        WebElement dropDownItem = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(searchString + ";" + searchPath));
        Select select = new Select(dropDownItem);
        List<WebElement> options = select.getOptions();
        for (WebElement we : options) {
            if (we.getText().equals(value)) {
                UtilFunctions.log("Option:" + value + "present in" + dropDownName);
                flag = true;
                break;
            }
        }
        if ((" not").equals(no)) {
            Assert.assertFalse(flag);
        } else {
            Assert.assertTrue(flag);
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^I click on the (text|link|element) \"(.*)\" in the \"(.*?)\" pane?$")
    public void clickInThePane(String type, String value, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        paneName = paneName.replace(" ", "");
        String paneFrame = UtilFunctions.getFrameValue(frameMap,
                UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");

        if (type.equals("text")) {
            GlobalStepdefs globalStepdefs = new GlobalStepdefs();
            globalStepdefs.clickLinkInPane(value, null, null, paneName);
        } else if (type.equals("link") || type.equals("element")) {
            SeleniumFunctions.selectFrame(driver, paneFrame, "id");
            //WebElement txtObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(".//*[contains(normalize-space(./text()), '" + value + "')]" + ";xpath"));
            String xpath = UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(curTabName,
                    "MISC_ELEMENTS", value, "path", "", "");
            WebElement txtObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(xpath + ";xpath"));
            txtObj.click();
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^the \"(.*?)\" pane title should be \"(.*?)\"$")
    public void checkPaneTitle(String paneName, String value) throws Throwable {

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");


        paneName = paneName.replace(" ", "");
        String title = Page.findPane(driver, GlobalStepdefs.curTabName, paneName).getText().trim();
        Assert.assertTrue("Expected pane title:" + value + " " + "Got:" + title, title.equals(value));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");

    }

    @Then("^(?:Nothing|\"(.*?)\") should be selected in the \"(.*?)\" dropdown(?: in the \"(.*?)\" pane)?$")
    public void checkDropDownSelectedOption(String value, String dropDownName, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String paneFrame;
        String dropDownID = null;
        String method;
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        dropDownName = dropDownName.replace(" ", "");

        if (value == null)
            value = "";
        else
            value = UtilFunctions.convertThruRegEx(value);

        if (paneName == null) {
            paneFrame = UtilFunctions.getFrameValue(frameMap,
                    UtilFunctions.getElementFromJSONFile(fileObj, "DROPDOWNS." + dropDownName, "frame"));
            SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
        } else {
            paneName = paneName.replace(" ", "");
            paneFrame = (String) frameMap.get(UtilFunctions.getElementFromJSONFile(fileObj,
                    "PANES." + paneName, "frame"));
            SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
        }

        if (UtilFunctions.getElementFromJSONFile(fileObj, "DROPDOWNS." + dropDownName, "name") != null) {
            dropDownID = UtilFunctions.getElementFromJSONFile(fileObj, "DROPDOWNS." + dropDownName, "name");
            method = ";name";
        } else if (UtilFunctions.getElementFromJSONFile(fileObj, "DROPDOWNS." + dropDownName, "id") != null) {
            dropDownID = UtilFunctions.getElementFromJSONFile(fileObj,
                    "DROPDOWNS." + dropDownName, "id");
            method = ";id";
        } else {
            dropDownID = UtilFunctions.getElementFromJSONFile(fileObj,
                    "DROPDOWNS." + dropDownName, "barexpath");
            method = ";xpath";
        }

        WebElement dropDownElement = Page.getDropDown(dropDownID, method);
        try {
            Select select = new Select(dropDownElement);
            WebElement selectedOption = select.getFirstSelectedOption();
            Assert.assertTrue("Value " + value + " is not selected in the dropdown" +
                    dropDownName, selectedOption.getText().equals(value));
        } catch (AssertionFailedError e) {
            UtilFunctions.log("Selected DropDown Option: " + e.getMessage());
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^all values under the \"(.*?)\" column in the \"(.*?)\" table should (?:be blank|(be|start with|contain) \"(.*?)\")$")
    public void checkValuesUnderTableColumn(String columnName, String tableName, String condition, String value) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        if (condition == null)
            condition = "";
        else
            value = UtilFunctions.convertThruRegEx(value);
        int columnIndex = Integer.parseInt(Page.findTableColumn(Hooks.getDriver(), GlobalStepdefs.curTabName, tableName, columnName));
        if (columnIndex < 0 && columnIndex != 0) {
            UtilFunctions.log("Column " + columnName + " is not found in table: " + tableName);
            Assert.assertTrue("Column " + columnName + " is not found in table: " + tableName, false);
        } else {
            List<WebElement> tableRows = Page.getTableRows(Hooks.getDriver(), GlobalStepdefs.curTabName, tableName);
            if (tableRows == null) {
                UtilFunctions.log("Rows of table: " + tableName + " not found.");
                Assert.assertTrue("Rows of table: " + tableName + " not found.", false);
            } else {
                UtilFunctions.log("Rows of table: " + tableName + " found.");
                for (WebElement row : tableRows) {
                    List<WebElement> tdArr = SeleniumFunctions.findElementsByWebElement(row, SeleniumFunctions.setByValues("td;tagName"));
                    String nameColumnData = tdArr.get(columnIndex).getText().trim();
                    switch (condition) {
                        case "be":
                            Assert.assertTrue("Expected value " + value + " is not displayed in table ", nameColumnData.equals(value));
                            break;
                        case "start with":
                            Assert.assertTrue("Expected value " + value + " is not displayed in table ", nameColumnData.startsWith(value));
                            break;
                        case "contain":
                            Assert.assertTrue("Expected value " + value + " is not displayed in table ", nameColumnData.contains(value));
                            break;
                        case "":
                            Assert.assertTrue("Expected value " + value + " is not displayed in table ", nameColumnData.isEmpty());
                            break;
                        default:
                            UtilFunctions.log("Invalid Condition: " + condition);
                            break;
                    }
                }
                UtilFunctions.log("All values under the " + columnName + " column in the " + tableName + " table are " + value);
            }
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");

    }

    @When("^I (un)?check the following checkboxes(?: in the \"(.*?)\" pane)?$")
    public void checkMultipleCheckBoxes(String checkType, String paneName, DataTable dataTable) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        UtilFunctions.log("PaneName: " + paneName);

        if (checkType == null) {
            checkType = "check";
        } else {
            checkType = "uncheck";
        }
        List<String> texts = dataTable.asList(String.class);
        for (String checkBoxName : texts) {
            checkBoxName = checkBoxName.replace(" ", "");
            UtilFunctions.log("CheckBoxName: " + checkBoxName);
            Page.setCheckBox(Hooks.getDriver(), curTabName, checkBoxName, checkType, paneName);
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    //So far, this is only used for Med Rec, eRx, etc. -- not really a global step.
    //See note below about table cell id.
    @Then("^I select the \"(.*?)\" radio in the row with \"(.*?)\" as the value under \"(.*?)\" in the \"(.*?)\" table$")
    public void selectRadioInTableRow(String radioName, String srcValue, String srcHeader, String tableName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        //radioName = radioName.replace(" ", "");
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        String paneFrames = (String) frameMap.get(UtilFunctions.getElementFromJSONFile(fileObj,
                "PANES." + "SelectedOptionsOnDisplay", "frame"));
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");

        WebElement row = Page.findTableRowByCellText(Hooks.getDriver(), curTabName, tableName, srcHeader, srcValue);
        String radioValue = UtilFunctions.getElementFromJSONFile(fileObj, "RADIOS." +
                radioName.replace(" ", ""), "attrib_value");
        String radioMethod = UtilFunctions.getElementFromJSONFile(fileObj, "RADIOS." +
                radioName.replace(" ", ""), "select_by");

        boolean radioState = false;

        //get the table cell that contains the radio button by the row
        if (row != null) {
            //From findUsages, it looks like this step is only used for Med Rec, so I think adding this ID is ok.
            //But, if it starts to get used for more global uses, this will have to change or broken out into a separate step.
            WebElement cell = SeleniumFunctions.findElementByWebElement(row, By.xpath(".//td[@id='UnreconciledOrderStatusCell']"));
            if (cell != null) {
                try {
                    cell.click();
                } catch (ElementNotInteractableException e) {
                    SeleniumFunctions.click(cell);
                }
                String radioXPath = null;
                if (radioMethod.equals("value")) {
                    radioXPath = ".//input[@type='radio' and @value='" + radioValue + "']";
                } else if (radioMethod.equals("label")) {
                    radioXPath = ".//input[@type='radio' and @value='" + radioValue + "']";
                } else {
                    Assert.assertTrue("radioMethod not defined in JSON element definition.", false);
                }

                WebElement radioButton = SeleniumFunctions.findElementByWebElement(row, By.xpath(radioXPath));
                if (radioButton != null) {
                    if (radioButton.isDisplayed()) {
                        radioButton.click();
                        try {
                            radioState = Boolean.parseBoolean(radioButton.getAttribute("checked"));
                            if (!radioState) {
                                radioButton.click();
                                radioState = Boolean.parseBoolean(radioButton.getAttribute("checked"));
                            }
                        } catch (StaleElementReferenceException e) {
                            //Assume radio was clicked if element is now stale.  Some radios aren't available after they are successfully clicked.
                            radioState = true;
                        }
                    }
                }
            }
        }

        Assert.assertTrue("Failed to select radio element.", radioState);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @Then("^I select the \"(.*?)\" link in the row with \"(.*?)\" as the value under \"(.*?)\" in the \"(.*?)\" table$")
    public void selectLinkInTableRow(String linkName, String srcValue, String srcHeader, String tableName)
            throws Throwable {

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        Thread.sleep(2000);

        WebElement row = Page.findTableRowByCellText(Hooks.getDriver(), curTabName, tableName, srcHeader, srcValue);
        SeleniumFunctions.findElementByWebElement(row,
                By.xpath(".//" + "*[normalize-space(./text())='" + linkName + "']")).click();

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @Then("^I select the \"(.*?)\" radio in the row with the text \"(.*?)\" from the \"(.*?)\" table$")
    public void selectRadioInTableRowWithoutHeader(String radioName, String rowName, String tableName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        radioName = radioName.replace(" ", "");
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
        WebElement row = Page.findTableRowByText(Hooks.getDriver(), tableName, rowName);
        if (row != null) {
            String radioValue = UtilFunctions.getElementFromJSONFile(fileObj, "RADIOS." + radioName, "attrib_value");
            String radioMethod = UtilFunctions.getElementFromJSONFile(fileObj, "RADIOS." + radioName, "select_by");

            boolean radioState = false;
            WebElement radioButton = null;
            String radioXPath = null;
            if (radioMethod.equals("value")) {
                radioXPath = ".//input[@type='radio' and @value='" + radioValue + "']";
            } else if (radioMethod.equals("label")) {
                radioXPath = ".//input[@type='radio' and @value='" + radioValue + "']";
            } else {
                Assert.assertTrue("radioMethod not defined in element definition.", false);
            }
            radioButton = SeleniumFunctions.findElementByWebElement(row, By.xpath(radioXPath));
            if (radioButton != null) {
                ((JavascriptExecutor) Hooks.getDriver()).executeScript("arguments[0].scrollIntoView(true);", radioButton);
                radioButton.click();
                try {
                    radioState = Boolean.parseBoolean(radioButton.getAttribute("checked"));
                    if (!radioState) {
                        radioButton.click();
                        radioState = Boolean.parseBoolean(radioButton.getAttribute("checked"));
                    }
                } catch (StaleElementReferenceException e) {
                    //Assume radio was clicked if element is now stale.  Some radios aren't available after they are successfully clicked.
                    radioState = true;
                }

                Assert.assertTrue("Failed to select radio element.", radioState);
            } else {
                Assert.assertFalse("Radio button " + radioName + " is not found in the row with text " + rowName, true);
            }

        } else {
            Assert.assertFalse("Row with text " + rowName + " is not found", true);
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^I select the \"(.*?)\" link in the row with the text \"(.*?)\" in the \"(.*?)\" table( if it exists)?$")
    public void selectLinkInTableRowWithoutHeader(String linkName, String value, String tableName, String exists) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        WebElement row = Page.findTableRowByText(Hooks.getDriver(), tableName, value);
        try {
            SeleniumFunctions.findElementByWebElement(row, By.xpath(".//*[normalize-space(./text())='" + linkName + "']")).click();
        } catch (Exception e) {
            if (exists == null)
                Assert.assertNotNull(linkName + " link is not selected in the table " + tableName + " due to exception: " + e.getMessage(), null);
            else
                UtilFunctions.log(linkName + " link is not selected in the table " + tableName + " due to exception: " + e.getMessage());
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^Text( exact)? \"(.*?)\" should( not)? appear(?: in the \"(.*?)\" section)? in the \"(.*?)\" pane$")
    public void exactTextAppearInPane(String exact, String text, String no, String sectionName, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        boolean value = false;
        if (exact == null) {
            value = false;
        } else {
            value = true;
        }
        if (sectionName == null) {
            System.out.println("Do Nothing");
        } else {
            sectionName = sectionName.replace(" ", "");
        }
        text = UtilFunctions.convertThruRegEx(text);
        boolean retValue;
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        String paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName.replace(" ", ""), "frame"));
        UtilFunctions.log("PaneFrames: " + paneFrames);
        SeleniumFunctions.selectFrame(driver, paneFrames, "id");
        if (sectionName == null) {
            retValue = textExists(driver, text, "", value);
            UtilFunctions.log("Checking for text: '" + text + "'. Returning " + retValue);
        } else {
            if (sectionName.equals("")) {
                retValue = textExists(driver, text, "", value);
                UtilFunctions.log("Checking for text: '" + text + "'. Returning " + retValue);
            } else {
                String sectionPath = UtilFunctions.getElementFromJSONFile(fileObj, "PANE_SECTIONS." + sectionName, "path");
                retValue = textExists(driver, text, sectionPath, value);
                UtilFunctions.log("Checking for text: '" + text + "'. Returning " + retValue);
            }
        }
        if ((no == null) || (no == ""))
            Assert.assertTrue("Text " + text + " is not present", retValue);
        else
            Assert.assertFalse("Text " + text + " is not present", retValue);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I click the \"(.*?)\" key in the \"(.*)\" field(?: in the \"(.*?)\" pane)?$")
    public void enterKeyBordInput(String keyName, String textboxName, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        String paneFrame;
        textboxName = textboxName.replace(" ", "");
        if (paneName == null) {
            paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "TEXT_FIELDS." + textboxName, "frame"));
            SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
        } else {
            paneName = paneName.replace(" ", "");
            paneFrame = (String) frameMap.get(UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
            SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
        }
        String[] elementType = UtilFunctions.getElementStringAndType(fileObj, "TEXT_FIELDS." + textboxName);
        String textPath = elementType[0];
        String UpparCase = keyName.toUpperCase();
        //SeleniumFunctions.selectFrame(driver, paneFrame, "id");
        WebElement txtObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(textPath + ";id"));
        Assert.assertNotNull("Text field Object is null.", txtObj);

        if (UpparCase.equals("ENTER")) {
            txtObj.sendKeys(Keys.ENTER);
        }
        if (UpparCase.equals("SPACE")) {
            txtObj.sendKeys(Keys.SPACE);
        }
        if (UpparCase.equals("BACKSPACE")) {
            txtObj.sendKeys(Keys.BACK_SPACE);
        }
        if (UpparCase.equals("ESC")) {
            txtObj.sendKeys(Keys.ESCAPE);
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    //Then I press the ".*" shortcut key in the "(.*" pane
    @When("I press the \"(.*?)\" shortcut key in the \"(.*?)\" pane$")
    public void enterShortcutKey(String shortcutName, String paneName) {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);

        String paneFrame = (String) frameMap.get(UtilFunctions.getElementFromJSONFile(fileObj,
                "PANES." + paneName.replace(" ", ""), "frame"));
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");

        String[] elementType = UtilFunctions.getElementStringAndType(fileObj, "PANES." + paneName);
        String textPath = elementType[0];
        WebElement paneObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(textPath + ";id"));
        Assert.assertNotNull("Pane Object, " + paneName + " , is null.", paneObj);

        switch (shortcutName.toUpperCase()) {
            //Press shortcut, hot key ALT + S to save/download file from IE browser prompt
            case "SAVE":
                paneObj.sendKeys(Keys.ALT + "s");
                break;
            case "CTRL ALL":
                paneObj.sendKeys(Keys.CONTROL + "a");
                break;
            default:
                break;
        }//end switch

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }//end enterShortcutKey


    @When("^I delete the \"(.*?)\" child picker in the \"(.*)\" pane$")
    public void deletcChildPicker(String pickerName, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        String paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName.replace(" ", ""), "frame"));
        UtilFunctions.log("PaneFrames: " + paneFrames);
        SeleniumFunctions.selectFrame(driver, paneFrames, "id");
        WebElement searchObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//tr[@Code='QuickText' and descendant::textarea[@id= 'DisplayText' and text()='" + pickerName + "']]" + ";xpath"));
        SeleniumFunctions.findElementByWebElement(searchObj, SeleniumFunctions.setByValues("//img[@buttonID='deletechild']" + ";xpath")).click();

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I delete the \"(.*?)\" picker in the \"(.*)\" pane$")
    public void deletePicker(String pickerName, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        String paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName.replace(" ", ""), "frame"));
        UtilFunctions.log("PaneFrames: " + paneFrames);
        SeleniumFunctions.selectFrame(driver, paneFrames, "id");
//        WebElement searchObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//tr[ancestor::div[@id='ChildPickers'] and descendant::input[@value='" + pickerName + "']]" + ";xpath"));
//        SeleniumFunctions.findElementByWebElement(searchObj, SeleniumFunctions.setByValues("//img[@buttonID='deletechild']" + ";xpath")).click();
//        Using SeleniumFunctions.click() to delete the child picker as a workaround for IE driver click issue
        WebElement delObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//img[@buttonid='deletechild' and parent::td[following-sibling::td[child::input[@value='" + pickerName + "']]]]"));
        SeleniumFunctions.click(delObj);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @And("^I (check|uncheck) the \"(.*?)\" checkbox in the row with \"(.*?)\" as the value(?: under \"(.*?)\" column)? in the \"(.*?)\" table$")
    public void checkCheckBoxInTable(String checkType, String checkboxName, String rowValue, String srcHeader, String tableName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        checkboxName = checkboxName.replace(" ", "");
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        String[] elementType = UtilFunctions.getElementStringAndType(fileObj, "CHECKBOXES." + checkboxName);
        String textPath = elementType[0];
        if (srcHeader != null) {
            List<WebElement> rows = Page.findTableRowsByValue(Hooks.getDriver(), tableName, srcHeader, rowValue);
            for (WebElement row : rows) {
                WebElement tableBodyObj = SeleniumFunctions.findElementByWebElement(row, SeleniumFunctions.setByValues("//input[@name='" + textPath + "' or @id='" + textPath + "']" + ";xpath"));
                tableBodyObj.click();
            }

        } else {
            tableName = tableName.replace(" ", "");
            String[] tableDetailArr = UtilFunctions.getTableValues(curTabName, tableName);
            String tablePath = tableDetailArr[0];
            String tableId = tableDetailArr[1];
            String tableHead = tableDetailArr[2];
            String tableBody = tableDetailArr[3];
            String paneFrames = tableDetailArr[4];
            UtilFunctions.log("tablePath: " + tablePath);
            UtilFunctions.log("tableID: " + tableId);
            UtilFunctions.log("tableHead: " + tableHead);
            UtilFunctions.log("tableBody: " + tableBody);
            UtilFunctions.log("PaneFrames: " + paneFrames);
            SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");

            WebElement tableElement = findTable(Hooks.getDriver(), tablePath);
            WebElement tableBodyObj = SeleniumFunctions.findElementByWebElement(tableElement, SeleniumFunctions.setByValues(tableBody + ";xpath"));
            // List<WebElement> checkBox = SeleniumFunctions.findElementsByWebElement(tableBodyObj, SeleniumFunctions.setByValues("input;tagName"));
            List<WebElement> tableRowObj = SeleniumFunctions.findElementsByWebElement(tableBodyObj, SeleniumFunctions.setByValues("tr;tagName"));
            for (WebElement rowObj : tableRowObj) {
                List<WebElement> checkBox = SeleniumFunctions.findElementsByWebElement(rowObj, SeleniumFunctions.setByValues("input;tagName"));
                for (WebElement checkObj : checkBox) {
                    String value = checkObj.getAttribute("value");
                    if (value.equals(rowValue)) {
                        WebElement reqCheckObj = SeleniumFunctions.findElementByWebElement(checkObj, SeleniumFunctions.setByValues("//input[@name='" + textPath + "' or @id='" + textPath + "']" + ";xpath"));
                        if (checkType.equals("uncheck") || checkType.equals("check")) {
                            reqCheckObj.click();
                        }
                    }
                }

            }
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^the \"(.*?)\" checkbox should be (checked|unchecked) in the row with \"(.*?)\" as cell text under \"(.*?)\" column in the \"(.*?)\" table$")
    public void validateCheckboxStatusInTable(String checkboxName, String checkType, String rowValue, String srcHeader, String tableName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        checkboxName = checkboxName.replace(" ", "");
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        String[] elementType = UtilFunctions.getElementStringAndType(fileObj, "CHECKBOXES." + checkboxName);
        String textPath = elementType[0];

        List<WebElement> rowsObj = Page.findTableRowsByValue(Hooks.getDriver(), tableName, srcHeader, rowValue);
        for (WebElement row : rowsObj) {
            WebElement tableBodyObj = SeleniumFunctions.findElementByWebElement(row, SeleniumFunctions.setByValues("//input[@name='" + textPath + "' or @id='" + textPath + "']" + ";xpath"));
            if (tableBodyObj.isSelected()) {
                Assert.assertTrue("checkedBox is Uchecked ", checkType.equals("checked"));
            } else {
                Assert.assertTrue("checkedBox is checked ", checkType.equals("unchecked"));
            }
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I click the checkbox in the row with \"(.*?)\" as the value under \"(.*?)\" in the \"(.*?)\" table$")
    public void doCheckInTableWithText(String rowValue, String srcHeader, String tableName) throws Throwable {

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        List<WebElement> rowsObj = Page.findTableRowsByValue(Hooks.getDriver(), tableName, srcHeader, rowValue);
        for (WebElement row : rowsObj) {
            WebElement checkBoxObj = SeleniumFunctions.findElementByWebElement(row,
                    SeleniumFunctions.setByValues("//input[@type='checkbox' or @type='Checkbox']" + ";xpath"));
            Assert.assertNotNull(checkBoxObj);
            if (checkBoxObj.isSelected()) {
                UtilFunctions.log("CheckBox Is Checked Already");
            } else {
                checkBoxObj.click();
                UtilFunctions.log("CheckBox Check Is Done");
            }
        }


        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    //To check the page or element load time
    //Include this before the action/page load step
    @And("^I start the page load timer$")
    public void startTimer() throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        DateFormat dateFormat = new SimpleDateFormat("mm:ss");
        Date date = new Date();
        System.out.println(dateFormat.format(date.getTime())); //08:43

        String startTime = dateFormat.format(date.getTime());
        d1 = dateFormat.parse(startTime);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    //Include this after the action/page load step
    @And("^I stop the page load timer$")
    public void stopTimer() throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        Date date = new Date();

        SimpleDateFormat myFormat = new SimpleDateFormat("mm:ss");
        String stopTime = new SimpleDateFormat("mm:ss").format(date);
        d2 = myFormat.parse(stopTime);

        long diff = d2.getTime() - d1.getTime();
        float diffSeconds = diff / 1000.0f % 60;
        long diffMinutes = diff / (60 * 1000) % 60;
        System.out.println(diffMinutes + " minutes.");
        System.out.println(diffSeconds + " seconds.");

        String temp = diffMinutes + "m:" + diffSeconds + "s";
        temp = "Time taken for the page to load or the action to be performed: " + temp;

        scenario.write(temp);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^there should be at least \"(.*?)\" patients on the patient list$")
    public void velidatePatientsCount(String noOfRows) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        int givenRowCount = Integer.parseInt(noOfRows);
        String patientsParentXPath = "";
        String tab = GlobalStepdefs.curTabName;
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tab);
        if (tab.equals("PatientListV2")) {
            String paneFrames = UtilFunctions.getFrameValue(frameMap, "FRAME_LISTV2");
            UtilFunctions.log("PaneFrames: " + paneFrames);
            SeleniumFunctions.selectFrame(driver, paneFrames, "id");
            patientsParentXPath = "//span[@class='PAT_FULLNAME']";
        } else {
            String paneFrames = UtilFunctions.getFrameValue(frameMap, "FRAME_LIST");
            UtilFunctions.log("PaneFrames: " + paneFrames);
            SeleniumFunctions.selectFrame(driver, paneFrames, "id");
            patientsParentXPath = "//td[starts-with(@id, 'PatientNameCell')]";
        }
        List<WebElement> displayOptionList = SeleniumFunctions.findElements(Hooks.getDriver(), By.xpath(patientsParentXPath));

        int displayCount = displayOptionList.size();

        if (displayCount >= givenRowCount) {
            Assert.assertTrue(true);
        } else
            Assert.assertTrue("No of rows in table less than expected" + displayOptionList, false);


        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");

    }


    @When("^I click the \"(.*?)\" button, then the title in the current popup should( not)? match the previous value$")
    public void currentPopUpTitle(String buttonName, String not) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        String paneFrameMain = UtilFunctions.getFrameValue(frameMap, "FRAME_POPUP");
        UtilFunctions.log("PaneFrameMain: " + paneFrameMain);
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrameMain, "id");

        //Get the title of the popup window before clicking 'Send To Outbox and Next' button
        WebElement prevTitleBar = SeleniumFunctions.findElement(Hooks.getDriver(),
                By.xpath("//div[@id='titleBar' and @class='window-title']"));
        Assert.assertNotNull("Previous title bar is NULL and not found.", prevTitleBar);
        String previousTitle = prevTitleBar.getText();

        //click 'Send To Outbox And Next' (Dashboard mode btn) or "Save And Next" button (Classic mode button)
        buttonName = buttonName.replace(" ", "");
        Assert.assertTrue(buttonName + " button not clicked.",
                Page.clickButton(Hooks.getDriver(), GlobalStepdefs.curTabName, buttonName));
        Thread.sleep(3000);

        WebElement curTitleBar = null;
        String currentTitle = null;
        if (not == null) {//if the titles should match
            //Reselect the frame
            SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrameMain, "id");
            //Wait for the new popup window
            SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.FIFTEEN,
                    "//div[@id='titleBar' and @class='window-title'];xpath");
            //Get the new/current window title
            curTitleBar = SeleniumFunctions.findElement(Hooks.getDriver(),
                    By.xpath("//div[@id='titleBar' and @class='window-title']"));
            Assert.assertNotNull("Current title bar is NULL and not found.", curTitleBar);
            currentTitle = curTitleBar.getText();

            //Asert equals
            Assert.assertTrue("Previous title: " + previousTitle + "\nand Current popup title:" +
                    currentTitle + "  are NOT the same.", previousTitle.equalsIgnoreCase(currentTitle));
            UtilFunctions.log("Previous title: " + previousTitle + "\nand Current popup title:" +
                    currentTitle + "  are EQUAL.");
            System.out.println("Previous title: " + previousTitle + "\nand Current popup title:" +
                    currentTitle + "  are EQUAL.");

        } else {//if the titles should NOT match
            //Reselect the frame
            SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrameMain, "id");
            //Wait for the new popup window
            SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.FIFTEEN,
                    "//div[@id='titleBar' and @class='window-title'];xpath");
            //Get the new/current window title
            curTitleBar = SeleniumFunctions.findElement(Hooks.getDriver(),
                    By.xpath("//div[@id='titleBar' and @class='window-title']"));
            Assert.assertNotNull("Current title bar is NULL and not found.", curTitleBar);
            currentTitle = curTitleBar.getText();

            //Assert not Equal
            Assert.assertFalse("Previous title: " + previousTitle + "\nand Current popup title:" +
                    currentTitle + "  ARE the same (when they should not be).", previousTitle.equalsIgnoreCase(currentTitle));
            UtilFunctions.log("Previous title: " + previousTitle + "\nand Current popup title:" +
                    currentTitle + "  are correctly NOT EQUAL.");
            System.out.println("Previous title: " + previousTitle + "\nand Current popup title:" +
                    currentTitle + "  are correctly NOT EQUAL.");
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    //*********************************************************************************************
    //click header in table (for sorting)
    @When("^I click the \"(.*?)\" header in the \"(.*?)\" table")
    public boolean clickHeaderInTheTable(String srcHeader, String tableName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        tableName = tableName.replace(" ", "");
        WebElement tableObj = findTable(driver, tableName);
        if (tableObj == null) {
            UtilFunctions.log("Table: " + tableName + " is not present. Returning false.");
            return false;
        } else {
            WebElement tableHeaderObj = findTableHeaderCell(tableObj, "tableName", "", "srcHeader");
            tableHeaderObj.click();

        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
        return true;

    }


    @And("^I click the Add link in the first row in the Worklist table$")
    public void clickAddLinkInTable() throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

//           obj = obj.replace(" ", "");
//        tableName = tableName.replace(" ","");
        WebElement tableObj = Page.findTable(Hooks.getDriver(), GlobalStepdefs.curTabName, "Worklist");
//        SeleniumFunctions.findElementByWebElement(tableObj, SeleniumFunctions.setByValues("//[@class='underline pointer' and text()= '11581']")).click();
        SeleniumFunctions.findElementByWebElement(tableObj, SeleniumFunctions.setByValues("//*[@clickmessage='edittransaction' and contains(text() ,'Add')]")).click();


        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
//
    }


    @And("^I get the text in the \"(.*?)\" pane( if it exists)?$")
    public String getPaneText(String paneName, String exists) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        paneName = paneName.replace(" ", "");
        UtilFunctions.log("Pane to be used: " + paneName);
        String paneText = null;
        WebElement paneElement = null;
        paneElement = Page.findPane(Hooks.getDriver(), curTabName, paneName);
        if (exists == null && paneElement == null) {
            Assert.assertTrue("Pane object " + paneName + " not found returning null", false);
            return null;
        } else if (exists != null && paneElement == null) {
            UtilFunctions.log("Pane " + paneName + " not found returning null");
            return null;
        } else {
            paneText = paneElement.getText();
            UtilFunctions.log("Pane " + paneName + " found getting the text");
            return paneText;
        }
    }

    @Then("^I wait(?: up to \"(.*?)\" seconds?)? for the \"(.*?)\" field of type \"(.*?)\"(?: in the \"(.*?)\" pane)? to (be clickable|be visible|be invisible|have attribute \"(.*?)\" contains value \"(.*?)\")$")
    public void waitForFieldAttributeValue(String time, String fieldName, String fieldType, String paneName, String condition, String attribute, String value) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        int timeOut;
        String paneFrames;
        fieldType = fieldType.toUpperCase();
        fieldName = fieldName.replace(" ", "");
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        if (paneName == null)
            paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, fieldType + "S." + fieldName, "frame"));
        else
            paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName.replace(" ", ""), "frame"));
        UtilFunctions.log("PaneFrames: " + paneFrames);
        if (time == null)
            timeOut = GlobalConstants.TEN;
        else
            timeOut = Integer.parseInt(time);
        String[] elementType = UtilFunctions.getElementStringAndType(fileObj, fieldType + "S." + fieldName);
        String searchString = elementType[0];
        String searchCriteria = elementType[1];
        By locator = SeleniumFunctions.setByValues(searchString + ";" + searchCriteria);
        SeleniumFunctions.selectFrame(driver, paneFrames, "id");
        WebDriverWait wait = new WebDriverWait(driver, timeOut);
        try {
            switch (condition) {
                case "be clickable":
                    wait.until(ExpectedConditions.elementToBeClickable(locator));
                    break;
                case "be visible":
                    wait.until(ExpectedConditions.visibilityOfElementLocated(locator));
                    break;
                case "be invisible":
                    wait.until(ExpectedConditions.invisibilityOfElementLocated(locator));
                    break;
                default:
                    if (attribute != null && value != null)
                        wait.until(ExpectedConditions.attributeContains(locator, attribute, value));
                    else
                        UtilFunctions.log("Attribute and Value is mandatry");
                    break;
            }
        } catch (Exception e) {
            UtilFunctions.log("Element not found after timeout of " + timeOut + " seconds. Exception: " + e.getMessage());
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @And("^I check the rotation for the \"(.*?)\"$")
    public void checkRotation(String imageName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        Assert.assertTrue("The image is not rotated", Page.checkImageRotation(Hooks.getDriver(), imageName, curTabName));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");

    }

    @And("^I check the \"(.*?)\" for changes in the size$")
    public void checkSize(String imageName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        Assert.assertTrue("The image is not rotated", Page.checkSizeofTheImage(Hooks.getDriver(), imageName, curTabName));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @And("^I (purge|unpurge) the photo$")
    public void purgeOption(String purgeType) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        Assert.assertTrue("Cannot " + purgeType + " the photo", Page.purgePhoto(Hooks.getDriver(), purgeType, curTabName));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^the \"(.*?)\" image (fits the screen|is oiginal size)$")
    public void verifyPhotoSize(String imageName, String resizeOption) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        Assert.assertTrue("Resize test failed: " + resizeOption, Page.resizePhoto(Hooks.getDriver(), imageName, resizeOption, curTabName));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @And("^I switch the focus to the \"(.*?)\" window$")
    public void switchFocus(String swithcTo) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        SeleniumFunctions.switchToWindow(Hooks.getDriver(), swithcTo);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @And("^I switch the focus to tab \"(.*?)\"$")
    public void switchFocusToTab(String switchTo) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        SeleniumFunctions.switchToWindowTab(Hooks.getDriver(), switchTo);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @And("^I find out all active windows$")
    public void findWindows() throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        SeleniumFunctions.switchToNWPopoutWindow(Hooks.getDriver());

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @And("^The \"(.*?)\" \"(.*?)\" should be (disabled|enabled)$")
    public void checkEnable(String elementName, String elementType, String checkFor) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        Assert.assertTrue(Page.checkIfEnabled(Hooks.getDriver(), curTabName, elementName, elementType, checkFor));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @And("I \"(.*?)\" \"(.*?)\" should be labelled as \"(.*?)\"")
    public void checkLabel(String elementName, String elementType, String label) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        Page.checkLabelOfTheElement(Hooks.getDriver(), curTabName, elementName, elementType, label);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @Then("the \"(.*?)\" pane title should (match|contain) the first item in the \"(.*?)\" column in the \"(.*?)\" table$")
    public void checkPaneTitleAgainstTableEntry(String paneName, String condition, String columnName, String tableName)
            throws Throwable {

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        String tableCellValue;
        String colIndex = Page.findTableColumn(Hooks.getDriver(), curTabName, tableName, columnName);
        if (colIndex != null) {
            tableCellValue = Page.getTableCellValue(Hooks.getDriver(), curTabName, tableName, 0,
                    Integer.parseInt(colIndex));
            paneName = paneName.replace(" ", "");
            String title = Page.findPane(driver, GlobalStepdefs.curTabName, paneName).getText().trim();
            if (condition == "match") {
                Assert.assertTrue("Pane title: " + tableCellValue + " is not same as selected value " +
                        tableCellValue + " from table", title.equals(tableCellValue));
            } else if (tableCellValue.contains("*DRAFT*")) {
                Assert.assertTrue("Pane title: " + tableCellValue + " is not same as selected value " +
                        tableCellValue + " from table", tableCellValue.contains(title));
            } else {//This condition doesn't work for DRAFT notes, but does for everything else. Added Else-If
                // above  -- HIC 10/25/18
                Assert.assertTrue("Pane title: " + tableCellValue + " is not same as selected value " +
                        tableCellValue + " from table", title.contains(tableCellValue));

            }
        } else {
            Assert.assertTrue("Table column " + columnName + " is not found in the table", false);
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("the text matching the first item in the \"(.*?)\" column in the \"(.*?)\" table should appear in the \"(.*?)\" pane$")
    public void checkPaneTextAgainstTableEntry(String columnName, String tableName, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        String tableCellValue;
        String colIndex = Page.findTableColumn(Hooks.getDriver(), curTabName, tableName, columnName);
        if (colIndex != null) {
            tableCellValue = Page.getTableCellValue(Hooks.getDriver(), curTabName, tableName, 0, Integer.parseInt(colIndex));
            paneName = paneName.replace(" ", "");
            Assert.assertTrue("Selected value " + tableCellValue + "vfrom table is not appered in the pane " + paneName, Page.textExists(Hooks.getDriver(), GlobalStepdefs.curTabName, tableCellValue, paneName));
        } else {
            Assert.assertTrue("Table column" + columnName + " is not found in the table", false);
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^the text in the \"(.*)\" field of the \"(.*)\" table should match the first item in the \"(.*)\" column in the \"(.*)\" table$")
    public void checkTextInTableWithAnotherTable(String fieldName, String destTableName, String columnName, String srcTableName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        String colIndex = Page.findTableColumn(Hooks.getDriver(), curTabName, srcTableName, columnName);
        if (colIndex != null) {
            String srcTableValue = Page.getTableCellValue(Hooks.getDriver(), curTabName, srcTableName, 0, Integer.parseInt(colIndex)).toUpperCase();
            String destTableValue = Page.getTableFieldValue(Hooks.getDriver(), curTabName, destTableName, null, fieldName).toUpperCase();
            Assert.assertTrue("Text in the field " + fieldName + " of the table " + destTableName + " is not matching with " + srcTableName + "table value", srcTableValue.equals(destTableValue));
        } else {
            Assert.assertTrue("Table column" + columnName + " is not found in the source table", false);
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("I edit the following settings (?:in the \"(.*)\" pane)?$")
    public void editSettings(String paneName, DataTable dataTable) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        List<Map<String, String>> dataList = dataTable.asMaps(String.class, String.class);
        for (Map data : dataList) {
            String name = ((String) data.get("Name"));
            String type = (String) data.get("Type");
            String value = ((String) data.get("Value"));

            UtilFunctions.log("Name: " + name);
            UtilFunctions.log("Type: " + type);
            UtilFunctions.log("Value: " + value);
            UtilFunctions.log("Pane Name: " + paneName);
            try {
                switch (type) {
                    case "dropdown":
                        Page.selectDropDownInPane(Hooks.getDriver(), curTabName, value, name, paneName);
                        break;
                    case "radio":
                        Page.setRadioValue(Hooks.getDriver(), curTabName, value, name, paneName);
                        break;
                    case "text":
                        Page.setTextBox(Hooks.getDriver(), curTabName, value, name, paneName);
                        break;
                    default:
                        break;
                }
            } catch (Exception e) {
                UtilFunctions.log("Field " + name + " " + type + " is not set with value " + value + " due to error: " + e.getMessage());
                Assert.assertTrue("Field " + name + " " + type + " is not set with value " + value + " due to error: " + e.getMessage(), false);
            }
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I get content from \"(.*?)\" html file and set in the \"(.*?)\" field(?: in the \"(.*?)\" pane)?$")
    public void setFieldWithFileData(String fileName, String fieldName, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        fieldName = fieldName.replace(" ", "");
        String paneFrames;
        if (paneName == null) {
            paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "TEXT_FIELDS." + fieldName, "frame"));
        } else {
            paneName = paneName.replace(" ", "");
            paneFrames = (String) frameMap.get(UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
        }
        //String filePath = System.getProperty("user.dir") + "\\src\\test\\java\\testData\\Htmls\\" + fileName + ".html";
        String filePath = "file:///" + System.getProperty("user.dir") + "/src/test/java/testData/Htmls/" + fileName + ".html";
        UtilFunctions.log("HTML data filepath: " + filePath);
        try {
            Set<String> portalWindows = driver.getWindowHandles();
            String appHandle = driver.getWindowHandle();
            ((JavascriptExecutor) driver).executeScript("window.open();");
            Set<String> appHandles = driver.getWindowHandles();
            appHandles.removeAll(portalWindows);
            String dataHandle = ((String) appHandles.toArray()[0]);
            driver.switchTo().window(dataHandle);
            UtilFunctions.log("Switched to window handle of html data file: " + filePath);
            driver.get(filePath);
            driver.manage().window().maximize();
            Robot dataPage = new Robot();
            dataPage.delay(1000);
            dataPage.keyPress(KeyEvent.VK_CONTROL);
            dataPage.keyPress(KeyEvent.VK_A);
            dataPage.delay(1000);
            dataPage.keyPress(KeyEvent.VK_C);
            dataPage.keyRelease(KeyEvent.VK_CONTROL);
            dataPage.keyRelease(KeyEvent.VK_A);
            dataPage.keyRelease(KeyEvent.VK_C);
            UtilFunctions.log("Copied text from html data file");
            driver.close();
            UtilFunctions.log("HTML data file closed");
            Thread.sleep(1000);
            driver.switchTo().window(appHandle);
            UtilFunctions.log("Switched back to portal window");
            SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");
            String[] elementAttributes = UtilFunctions.getElementStringAndType(fileObj, "TEXT_FIELDS." + fieldName);
            String searchString = elementAttributes[0];
            String searchCriteria = elementAttributes[1];
            WebElement elementObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(searchString + ";" + searchCriteria));
            Assert.assertTrue("Text box " + fieldName + " is not found", elementObj != null);
            elementObj.click();
            elementObj.clear();
            elementObj.sendKeys(Keys.chord(Keys.CONTROL, "v"));
            Thread.sleep(1000);
            Assert.assertTrue("Data from html file is not set to the text box " + fieldName, !elementObj.getText().isEmpty());
        } catch (Exception e) {
            Assert.assertTrue("Data from html file is not set to the text box due to exeception: " + e.getMessage(), false);
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I get text from \"(.*?)\" field(?: in the \"(.*?)\" pane)? to use later$")
    public void getFieldTextAndUseLater(String fieldName, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        fieldName = fieldName.replace(" ", "");
        String paneFrames;
        if (paneName == null) {
            paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "TEXT_FIELDS." + fieldName, "frame"));
        } else {
            paneName = paneName.replace(" ", "");
            paneFrames = (String) frameMap.get(UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
        }
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");
        String[] elementAttributes = UtilFunctions.getElementStringAndType(fileObj, "TEXT_FIELDS." + fieldName);
        String searchString = elementAttributes[0];
        String searchCriteria = elementAttributes[1];
        WebElement elementObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(searchString + ";" + searchCriteria));
        if (elementObj != null) {
            textFromField = elementObj.getText();
            Assert.assertTrue("Text is not retreived from Text box " + fieldName, !textFromField.isEmpty());
        } else
            Assert.assertTrue("Text box " + fieldName + " is not found", false);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^There should( not)? be \"(.*?)\" line spaces(?: in the \"(.*?)\" section)? in the \"(.*?)\" pane$")
    public void checkTempTextInPane(String no, int lineSpaces, String sectionName, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        paneName = paneName.replace(" ", "");
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        String paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
        UtilFunctions.log("PaneFrames: " + paneFrames);
        SeleniumFunctions.selectFrame(driver, paneFrames, "id");
        WebElement textObj;
        if (sectionName == null) {
            String panePath = UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "path");
            SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, panePath + ";" + "xpath");
            textObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(panePath + ";" + "xpath"));
        } else {
            String sectionPath = UtilFunctions.getElementFromJSONFile(fileObj, "PANE_SECTIONS." + sectionName, "path");
            SeleniumFunctions.explicitWait(driver, GlobalConstants.TWENTY, sectionPath + ";xpath");
            textObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(sectionPath + ";xpath"));
        }
        if (textObj != null) {
            String textObjText = textObj.getAttribute("innerHTML");
            String lineSpaceTags = "";
            for (int lineSpace = 0; lineSpace <= lineSpaces; lineSpace++) {
                lineSpaceTags = lineSpaceTags + "<br>";
            }
            if (no == null) {
                Assert.assertTrue("Pane: " + paneName + " doesn't contain " + lineSpaces + " line spaces", textObjText.contains(lineSpaceTags));
            } else {
                Assert.assertFalse("Pane: " + paneName + " contain " + lineSpaces + " line spaces", textObjText.contains(lineSpaceTags));
            }
        } else
            Assert.assertTrue("Pane: " + paneName + " is not found", false);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @Then("^the (vertical|horizontal) scrollbar should( not)? present for the \"(.*?)\" field of type \"(.*?)\"(?: in the \"(.*?)\" pane)?$")
    public void checkScrollBar(String scrollType, String exists, String elementName, String elementType, String paneName)
            throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        UtilFunctions.log("Element Name: " + elementName);
        UtilFunctions.log("Element Type: " + elementType);
        UtilFunctions.log("Scroll Type: " + scrollType);

        boolean scrollExists = Page.checkScrollExists(Hooks.driver, curTabName, elementName, elementType, scrollType,
                paneName);
        if (exists == null) {
            Assert.assertTrue(scrollType + " scrollbar is not present for the " + elementType + ": " +
                    elementName, scrollExists);
        } else {
            Assert.assertFalse(scrollType + " scrollbar is present for the " + elementType + ": "
                    + elementName, scrollExists);
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^The \"(.*?)\" (button|element|text field|link) should( not)? (appear|contain) with the text \"(.*?)\" in the \"(.*?)\" pane$")
    public void checkElementText(String elementName, String elementType, String condition, String matchingType, String text, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        String paneFrames;
        paneName = paneName.replace(" ", "");
        paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
        UtilFunctions.log("PaneFrames: " + paneFrames);
        SeleniumFunctions.selectFrame(driver, paneFrames, "id");
        String[] elementDetails;
        String fieldPath;
        String fieldMethod;
        WebElement eleObj = null;
        boolean textState;
        switch (elementType) {
            case "button":
                elementName = elementName.replace(" ", "");
                elementDetails = UtilFunctions.getElementStringAndType(fileObj, "BUTTONS." + elementName);
                fieldPath = elementDetails[0];
                fieldMethod = elementDetails[1];
                SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, fieldPath + ";" + fieldMethod);
                eleObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(fieldPath + ";" + fieldMethod));
                break;
            case "text field":
                elementName = elementName.replace(" ", "");
                elementDetails = UtilFunctions.getElementStringAndType(fileObj, "TEXT_FIELDS." + elementName);
                fieldPath = elementDetails[0];
                fieldMethod = elementDetails[1];
                eleObj = findTextBox(Hooks.driver, fieldPath, fieldMethod);
                break;
            case "element":
                elementName = elementName.replace(" ", "");
                elementDetails = UtilFunctions.getElementStringAndType(fileObj, "MISC_ELEMENTS." + elementName);
                fieldPath = elementDetails[0];
                fieldMethod = elementDetails[1];
                SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, fieldPath + ";" + fieldMethod);
                eleObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(fieldPath + ";" + fieldMethod));
                break;
            case "link":
                eleObj = findLinkText(Hooks.driver, elementName, "", "");
                break;
            default:
                break;
        }
        if (eleObj == null)
            Assert.assertFalse(elementName + " " + elementType + " is not found", true);
        else {
            if (matchingType.equals("appear")) {
                if (eleObj.getText().trim().equals("") || eleObj.getText() == null)
                    textState = (eleObj.getAttribute("value") != null && eleObj.getAttribute("value").trim().equals(text));
                else if (eleObj.getText().trim().equals(text))
                    textState = true;
                else
                    textState = false;
                if (condition == null)
                    Assert.assertTrue(elementName + " " + elementType + " is not appeared with text " + text, textState);
                else
                    Assert.assertTrue(elementName + " " + elementType + " is appeared with text " + text, !textState);
            } else {
                if (eleObj.getText().trim().equals("") || eleObj.getText() == null)
                    textState = (eleObj.getAttribute("value") != null && eleObj.getAttribute("value").trim().contains(text));
                else if (eleObj.getText().trim().contains(text))
                    textState = true;
                else
                    textState = false;
                if (condition == null)
                    Assert.assertTrue(elementName + " " + elementType + " does not contains text " + text, textState);
                else
                    Assert.assertTrue(elementName + " " + elementType + " contains text " + text, !textState);
            }
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @And("^I execute the \"(.*)\" query$")
    public void executeQuery(String query_name) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        query_name = query_name.replace(" ", "");
        DBExecutor dbExecutorObj = Page.prepareQuery(query_name);
        dbExecutorObj.executeQuery();

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @Given("The \"(.*)\" (menu|drop down)(?: in the \"(.*)\" pane)? should not have duplicate options$")
    public void checkforduplicateoptions(String elementName, String elementType, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        elementName = elementName.replace(" ", "");
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        String paneFrames;
        if (paneName != null) {
            paneName = paneName.replace(" ", "");
            paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
        } else {
            if (elementType.equals("menu"))
                paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PKMENUS." + elementName, "frame"));
            else
                paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "DROPDOWNS." + elementName, "frame"));
        }
        UtilFunctions.log("PaneFrames: " + paneFrames);
        SeleniumFunctions.selectFrame(driver, paneFrames, "id");
        String[] elementDetails;
        WebElement eleobj;
        List<WebElement> optionlist = null;
        switch (elementType) {
            case "menu":
                elementDetails = UtilFunctions.getElementStringAndType(fileObj, "PKMENUS." + elementName);
                String menuID = UtilFunctions.getElementFromJSONFile(fileObj, "PKMENUS." + elementName, "id");
                SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, elementDetails[0] + ";" + elementDetails[1]);
                eleobj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(elementDetails[0] + ";" + elementDetails[1]));
                Assert.assertNotNull(elementName + " " + elementType + " is not found", eleobj);
                optionlist = SeleniumFunctions.findElements(driver, SeleniumFunctions.setByValues("//div[ancestor::ul[@id='" + menuID + "']]"));
                break;
            case "drop down":
                elementDetails = UtilFunctions.getElementStringAndType(fileObj, "DROPDOWNS." + elementName);
                SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, elementDetails[0] + ";" + elementDetails[1]);
                eleobj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(elementDetails[0] + ";" + elementDetails[1]));
                Assert.assertNotNull(elementName + " " + elementType + " is not found", eleobj);
                Select select = new Select(eleobj);
                optionlist = select.getOptions();
                break;
            default:
                break;
        }
        if (optionlist.size() == 0)
            Assert.assertTrue("Options not found for " + elementName + " " + elementType, false);
        else {
            List<String> options = new ArrayList<>();
            Set<String> optionsSet = new HashSet<>();
            for (WebElement optionElement : optionlist) {
                if (elementType.equals("drop down"))
                    options.add(optionElement.getText().trim());
                else if (elementType.equals("menu"))
                    options.add(optionElement.getAttribute("textContent").trim());
            }
            optionsSet.addAll(options);
            Assert.assertEquals(elementName + " " + elementType + " has duplicates", optionsSet.size(), options.size());
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @And("I take a screenshot$")
    public void embedScreenshot() {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        Hooks.takeScreenShot();

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I enter \"(.*)\" in the \"(.*)\" field(?: in the \"(.*)\" pane)? then search list should (load|not load)(?: with the text \"(.*)\")?")
    public void enterAndVerifyText(String enteredText, String fieldName, String paneName, String condition, String searchText) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        String paneFrames;

        String[] elementType = UtilFunctions.getElementStringAndType(fileObj, "TEXT_FIELDS." + fieldName.replace(" ", ""));
        String textPath = elementType[0];
        String textMethod = elementType[1];
        if (paneName == null)
            paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "TEXT_FIELDS." + fieldName.replace(" ", ""), "frame"));
        else
            paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName.replace(" ", ""), "frame"));

        UtilFunctions.log("PaneFrames: " + paneFrames);
        SeleniumFunctions.selectFrame(driver, paneFrames, "id");
        WebElement txtObj = findTextBox(driver, textPath, textMethod);

        if (txtObj == null) {
            UtilFunctions.log("Text box '" + fieldName + "' object is null. Returning false.");
            Assert.assertNull("Text field : " + fieldName + "not found", txtObj);
        } else {
            enteredText = UtilFunctions.convertThruRegEx(enteredText);
            txtObj.clear();
            Actions actions = new Actions(driver);
            actions.click(txtObj)
                    .pause(Duration.ofSeconds(2))
                    .sendKeys(txtObj, enteredText)
                    .build()
                    .perform();
        }
        Thread.sleep(1000);
        WebElement listObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//ul[@class='ui-autocomplete ui-menu ui-widget ui-widget-content ui-corner-all' and contains(@style,'width')]" + ";xpath"));

        if (condition.equals("load")) {
            Assert.assertNotNull("search list is not loaded", listObj);
            if (searchText != null) {
                WebElement targetElement = SeleniumFunctions.findElementByWebElement(listObj, SeleniumFunctions.setByValues("//*[contains(text(),'" + searchText + "')]"));
                Assert.assertNotNull("required text is not present in the search list", targetElement);
            }
        } else {
            if (searchText == null) {
                Assert.assertNull("search list is loaded which was not supposed to be loaded.", listObj);
            } else {
                WebElement targetElement = SeleniumFunctions.findElementByWebElement(listObj, SeleniumFunctions.setByValues("//*[contains(text(),'" + searchText + "')]"));
                Assert.assertNull("list is loaded which was not supposed to be loaded.", targetElement);
            }
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");

    }

    @When("^The element \"(.*)\" of type \"(.*)\" should( not)? present(?: in the \"(.*)\" pane)?")
    public void checkElementExists(String fieldName, String fieldType, String condition, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        fieldType = fieldType.toUpperCase() + "S";
        Boolean eleExists = Page.checkElementExists(Hooks.getDriver(), curTabName, fieldName, fieldType, paneName);
        if (condition == null)
            Assert.assertTrue("Element " + fieldName + " of type " + fieldType + " is not present", eleExists);
        else
            Assert.assertFalse("Element " + fieldName + " of type " + fieldType + " is present", eleExists);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");

    }

    @And("^I load the medorders api url in new tab$")
    public void loadTheMedordersApiUrl() throws Throwable {

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String apiURL;
        apiURL = UtilProperty.apiURL + "api/account/medorders";
        try {
            ((JavascriptExecutor) Hooks.getDriver()).executeScript("window.open('" + apiURL + "');");
            String latestWindowHandle = (String) Hooks.getDriver().getWindowHandles().toArray()[Hooks.getDriver().getWindowHandles().size() - 1];
            Hooks.getDriver().switchTo().window(latestWindowHandle);
        } catch (Exception e) {
            UtilFunctions.log("Could not open new tab due to exception " + e.getMessage());
        }

        Thread.sleep(2000);
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @And("^response loaded from api call should contain the following text$")
    public void verifyMedOrderApiResponse(DataTable response) throws Throwable {

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String pagecontent = driver.findElement(By.tagName("body")).getText();
        UtilFunctions.log("page content: " + pagecontent);
        List<String> dataList = response.asList(String.class);
        for (String text : dataList) {
            Assert.assertTrue("api response:" + text + " is not present", pagecontent.contains(text));
        }
        driver.quit();

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^the (\\d+)(?:st|nd|rd|th)? row of the \"(.*?)\" table should have the text \"(.*?)\" in the \"(.*?)\" column$")
    public void checkTableRowForText(Integer rowNumber, String tableName, String cellValue, String columnName) throws Throwable {

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        tableName = tableName.replace(" ", "");
        cellValue = UtilFunctions.convertThruRegEx(cellValue);
        columnName = UtilFunctions.convertThruRegEx(columnName);
        String columnIndex = Page.findTableColumn(Hooks.getDriver(), GlobalStepdefs.curTabName, tableName, columnName);
        int colIndex = 0;

        if (columnIndex != null) {
            colIndex = Integer.parseInt(columnIndex);
            JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
            String tableRowPath = UtilFunctions.getElementFromJSONFile(fileObj, "TABLES." + tableName,
                    "rowPath");
            String tableBodyPath = UtilFunctions.getElementFromJSONFile(fileObj, "TABLES." + tableName,
                    "body");
            if (tableBodyPath.startsWith("//")) {
                tableBodyPath = tableBodyPath.replace("//", "");
            }
            WebElement tableObj = Page.findTable(Hooks.driver, GlobalStepdefs.curTabName, tableName);
            WebElement tableBodyObj = Page.findTableBody(tableObj, tableBodyPath);

            boolean textFound = false;
            List<WebElement> tableRows = SeleniumFunctions.findElementsByWebElement(tableBodyObj,
                    SeleniumFunctions.setByValues(tableRowPath + ";xpath"));
            WebElement reqTableRow = tableRows.get(rowNumber - 1);
            List<WebElement> tableColumns = SeleniumFunctions.findElementsByWebElement(reqTableRow,
                    SeleniumFunctions.setByValues("td" + ";xpath"));
            String text = tableColumns.get(colIndex).getText();
            if (text.contains(cellValue)) {
                UtilFunctions.log("The first row of the " + tableName + " table does contain " + cellValue +
                        " in the " + columnName + " column.");
                textFound = true;
            }
            Assert.assertTrue("The row " + rowNumber + " of the " + tableName + " table does not contain " + cellValue +
                    " in the " + columnName + " column.", textFound);
        } else {
            Assert.assertNotNull("Column " + columnName + "not found. Column Index is null.", columnIndex);
        }//end outer if-else

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }//end checkTableFirstRowForText


    @Then("^I unzip the \"(.*?)\" file$")
    public void unzipExportedFile(String fileName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String homeUser = System.getProperty("user.home");
        String destinationFolder = "//" + homeUser + "/Downloads";
        String zippedFile = homeUser + "/Downloads/" + fileName + ".zip";

        CompressedFile compressedFile = new CompressedFile();
        compressedFile.unzipFile(zippedFile, destinationFolder);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    //Delete the [file name] [file type] (e.g., .zip file, .txt file, etc.)
    @Then("^I delete the \"(.*?)\" \"(.*?)\" file$")
    public void deleteDownloadedFile(String fileName, String fileType) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String homeUser = System.getProperty("user.home");
        //String destinationFolder = "//" + homeUser + "/Downloads";
        fileName += fileType;
        String filePath = homeUser + "/Downloads/" + fileName;// + fileType;

        CompressedFile compressedFile = new CompressedFile();
        compressedFile.deleteDLdFile(fileName, filePath);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @Then("^I import the \"(.*?)\" file using the \"(.*?)\" Input element$")
    public void importFile(String fileName, String inputName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String homeUser = System.getProperty("user.home");
        //fileName = "VerveNWfilterNoteTypesPickerExport.csv"
        String filePath = homeUser + "\\Downloads\\" + fileName;

        WebElement inputElement = Page.findInputElement(Hooks.driver, GlobalStepdefs.curTabName, inputName);
        if (inputElement != null) {
            if (inputElement.isDisplayed()) {
                if (Page.importFile(inputElement, filePath)) {
                    UtilFunctions.log("File '" + fileName + "' imported successfully.");
                    System.out.println("File '" + fileName + "' imported successfully.");
                    Assert.assertTrue("File '" + fileName + "' failed to import.", true);
                } else {
                    UtilFunctions.log("File '" + fileName + "' failed to import.");
                    System.out.println("File '" + fileName + "' failed to import.");
                    Assert.fail("File '" + fileName + "' failed to import.");
                }
            } else {
                UtilFunctions.log("Input element '" + inputName + "' is not displayed.");
                System.out.println("Input element '" + inputName + "' is not displayed.");
                System.out.println("Input element '" + inputName + "' is not displayed.");
            }
        } else {
            UtilFunctions.log("Input element '" + inputName + "' is NULL.");
            System.out.println("Input element '" + inputName + "' is NULL.");
            Assert.assertNotNull("Input element '" + inputName + "' is NULL.", inputElement);
        }

        Page.importFile(inputElement, filePath);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @Then("^I read the \"(.*?)\" text file and verify that \"(.*?)\" is listed under the \"(.*?)\" column$")
    public void readTextFileVerifyData(String fileName, String cellValue, String columnHeading)
            throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        cellValue = UtilFunctions.convertThruRegEx(cellValue);
        columnHeading = UtilFunctions.convertThruRegEx(columnHeading);
        String homeUser = System.getProperty("user.home");
        ExportedTextFile exportedTextFile = new ExportedTextFile();
        String filepath = homeUser + "/Downloads/" + fileName + ".txt";

        List listOfLines = exportedTextFile.openReadWholeFile(filepath, cellValue, columnHeading);
        Assert.assertNotNull("The file " + fileName + " was not read into a List correctly.  The List is null.",
                listOfLines);

        Map dictionary = exportedTextFile.createDictionary(listOfLines);
        Assert.assertTrue("The cell value " + cellValue + " is not listed in the column " +
                columnHeading + ".", exportedTextFile.compareDataToDictionary(cellValue, columnHeading, dictionary));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @And("I click the \"(.*?)\" export button?( and then the IE browser prompt save file button if it exists)?$")
    public void exportFile(String buttonName, String exists) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        buttonName = buttonName.replace(" ", "");
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        String[] elementType = UtilFunctions.getElementStringAndType(fileObj, "BUTTONS." + buttonName);
        String buttonPath = elementType[0];
        String buttonMethod = elementType[1];
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        String paneFrames = paneFrames = UtilFunctions.getFrameValue(frameMap,
                UtilFunctions.getElementFromJSONFile(fileObj, "BUTTONS." + buttonName, "frame"));
        UtilFunctions.log("PaneFrames: " + paneFrames);
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");
        SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.TEN, buttonPath + ";" + buttonMethod);
        WebElement btnObj = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues(buttonPath + ";"
                + buttonMethod));

        if (btnObj != null) {
            Actions clickButtonAction = new Actions(Hooks.getDriver());
            clickButtonAction.click(btnObj).perform();
            System.out.println("Button object: " + buttonName + " clicked with Actions click.");
            UtilFunctions.log("Button object: " + buttonName + " clicked with Actions click.");
            Assert.assertNotNull("Button object: " + buttonName + " is null.", btnObj);
        } else {
            UtilFunctions.log("Button object: " + buttonName + " is null.  Not clicked.");
            System.out.println("Button object: " + buttonName + " is null.  Not clicked.");
        }

        if (exists != null) {
            //.exe file for the AutoIt script to click save for the IE Save/Open file prompt
            //Process to send the AutoIt script's ConsoleWrite()'s to Intellij's console
            //This .exe file lives on Nuc 6 and is an AutoIt script to click the Windows download file button -- HIC 3/15/19
            ProcessBuilder pb = new ProcessBuilder("//chrisb-nuc6/C$/AutoItScripts/DLFile.exe");
            pb.redirectOutput(ProcessBuilder.Redirect.INHERIT);
            pb.redirectError(ProcessBuilder.Redirect.INHERIT);
            Process p = pb.start();
            //Wait for the process to run all the way through the AutoIt script before destroying it.
            Thread.sleep(6000);
            //Destroy the process so that IE doesn't hang
            p.destroy();
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    /*
     * Test AutoIt script just to see if can get the AutoIt ConsoleWrite()'s to output to the Intellij console
     * This step is just for testing purposes.  This .exe only lives on my local machine and is only for testing
     * whether AutoIt ConsoleWrite()'s will output to the Intellij console.  If you need this .exe,
     * email me and I'll email it or put it in shared location.  But, this step is just for testing AutoIt ConsoleWrite()'s
     * to output to the Intellij's console.  It's not for any scenarios.  -- HIC 3/14/19
     * */
    @And("I run the Got Here AutoIt test script")
    public void runAutoItTestScript() throws Throwable {
        ProcessBuilder pb = new ProcessBuilder("C:\\Users\\hcunningham\\Downloads\\GotHereTest.exe");
        pb.redirectOutput(ProcessBuilder.Redirect.INHERIT);
        pb.redirectError(ProcessBuilder.Redirect.INHERIT);
        Process p = pb.start();
        p.destroy();
    }

    @When("I use Robot to click the IE (Save|Close) button in downloads bar?( if it exists)?$")
    public void ieDownloadFile(String button, String exists) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        Robot robotObj = new Robot();
        if (exists != null) {
            if (UtilProperty.browserType.contains("ie"))
                try {
                    //wait for download to complete and CTRL+N to bring focus to navigation/downloads bar
                    Thread.sleep(3000);
                    robotObj.keyPress(KeyEvent.VK_ALT);
                    robotObj.keyPress(KeyEvent.VK_N);
                    robotObj.keyRelease(KeyEvent.VK_ALT);
                    robotObj.keyRelease(KeyEvent.VK_N);
                    if (button.equals("Save")) {
                        robotObj.keyPress(KeyEvent.VK_TAB);
//                        robotObj.keyPress(KeyEvent.VK_ALT);
//                        robotObj.keyPress(KeyEvent.VK_S);
//                        Thread.sleep(1000);
//                        robotObj.keyRelease(KeyEvent.VK_ALT);
//                        robotObj.keyRelease(KeyEvent.VK_S);
//                        robotObj.keyPress(KeyEvent.VK_TAB);
                        robotObj.keyPress(KeyEvent.VK_ENTER);
                    } else {
                        for (int i = 0; i < 3; i++) {
                            Thread.sleep(1000);
                            robotObj.keyPress(KeyEvent.VK_TAB);
                        }
                        robotObj.keyPress(KeyEvent.VK_ENTER);
                        Thread.sleep(1000);
                        robotObj.keyRelease(KeyEvent.VK_ENTER);
                    }
                    System.out.println("Robot successfully clicked the IE " + button + " file button.");
                    UtilFunctions.log("Robot successfully clicked the IE " + button + " file button.");
                } catch (Exception ex) {
                    ex.printStackTrace();
                    System.out.println("Robot failed to click the IE " + button + " file button due to Exception: " + ex.getMessage());
                    UtilFunctions.log("Robot failed to click the IE " + button + " file button due to Exception: " + ex.getMessage());
                }//end try-catch
            //end inner if
        }//end outer if

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

//    @And("^I open new tab and navigate to \"(.*?)\"$")
//    public void openNewTabToURL(String url) {
//        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
//        }.getClass().getEnclosingMethod().getName() + " : Start");
//
//        ((JavascriptExecutor) Hooks.getDriver()).executeScript("window.open('" + url + "');");
//
//        //Switch to latest tab
//        String latestWindowHandle = (String) Hooks.getDriver().getWindowHandles().toArray()[Hooks.getDriver().getWindowHandles().size() - 1];
//        Hooks.getDriver().switchTo().window(latestWindowHandle);
//
//        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
//        }.getClass().getEnclosingMethod().getName() + " : Complete");
//    }
//
//    @And("^I start a network test$")
//    public void startNetworkTest() {
//        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
//        }.getClass().getEnclosingMethod().getName() + " : Start");
//
//        WebDriver driver = Hooks.getDriver();
//        driver.switchTo().frame("bs-test-driver");
//        WebElement runTest = driver.findElement(By.id("bs-runtest"));
//        runTest.click();
//
//        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
//        }.getClass().getEnclosingMethod().getName() + " : Complete");
//    }

    @And("^I start a network test in a new tab$")
    public void startNetworkTestInNewTab() {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        WebDriver driver = Hooks.getDriver();

        //Open new tab
        ((JavascriptExecutor) driver).executeScript("window.open('https://www.browserscope.org/network/test');");

        try {
            Thread.sleep(2000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        //setDriverWindowHandleMap to allow for switching between tabs via 'I switch the focus to tab "#"' steps
        SeleniumFunctions.setDriverWindowHandleMap(driver);

        //Switch to new tab
        String latestWindowHandle = (String) driver.getWindowHandles().toArray()[Hooks.getDriver().getWindowHandles().size() - 1];
        driver.switchTo().window(latestWindowHandle);

        //Start test
        driver.switchTo().frame("bs-test-driver");
        WebElement runTest = driver.findElement(By.id("bs-runtest"));
        runTest.click();

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @And("^I stop the network test$")
    public void stopNetworkTest() {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        WebDriver driver = Hooks.getDriver();

        //Stop test.  Swallow any errors that occur.
        try {
            driver.switchTo().frame("bs-test-frame");
            driver.switchTo().frame("testdriver");
            WebElement stopTest = driver.findElement(By.id("startstop"));
            stopTest.click();
        } catch (Exception e) {
            UtilFunctions.log("Exception occurred while attempting to stop the BrowserScope Netowrk Test.  Ingoring exception.");
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I (un)?check the \"(.*?)\" checkbox in the dashboard mode$")
    public void checkCheckboxInDashboardMode(String chkType, String checkBoxName) {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        String paneFrame;
        paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "CHECKBOXES." + checkBoxName.replace(" ", ""), "frame"));
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
        String[] elementType = UtilFunctions.getElementStringAndType(fileObj, "CHECKBOXES." + checkBoxName);
        String chBoxValue = elementType[0];
        String chBoxMethod = elementType[1];
        WebElement chkBoxElement = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(chBoxValue + ";" + chBoxMethod));
        Assert.assertNotNull("Checkbox " + checkBoxName + " not found", chkBoxElement);
        if (chkType == null) {
            if (!chkBoxElement.getAttribute("class").contains("is-checked")) {
                chkBoxElement.click();
                UtilFunctions.log("Checkbox " + checkBoxName + " checked");
            }
        } else {
            if (chkBoxElement.getAttribute("class").contains("is-checked")) {
                chkBoxElement.click();
                UtilFunctions.log("Checkbox " + checkBoxName + " unchecked");
            }
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @And("^I select the date \"(.*?)\" from the \"(.*?)\" calendar in the \"(.*?)\" pane$")
    public void selectDateFromCalendar(String date, String calendarElement, String paneName) throws Exception {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName.replace(" ", ""), "frame"));
        UtilFunctions.log("PaneFrames: " + paneFrame);

        String[] elementType = UtilFunctions.getElementStringAndType(fileObj, "MISC_ELEMENTS." + calendarElement.replace(" ", ""));
        String elementPath = elementType[0];
        SeleniumFunctions.selectFrame(driver, paneFrame, "id");
        SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(elementPath)).click();
        Thread.sleep(1000);

        Calendar calendar = Calendar.getInstance();
        date = UtilFunctions.convertThruRegEx(date);
        System.out.println("date after regex conversion is " + date);
        String day, month, year;
        String dateArray[] = date.split("/");
        month = dateArray[0];
        day = dateArray[1];
        year = dateArray[2];

        System.out.println("date after split. mon= " + month + " day= " + day + " year= " + year);
        int currentMonth = calendar.get(Calendar.MONTH);
        String mmm = calendar.getDisplayName(Calendar.MONTH, Calendar.LONG, Locale.getDefault());
        int currentYear = calendar.get(Calendar.YEAR);
        int currentDate = calendar.get(Calendar.DATE);
        System.out.println("Current date instance(dd/mm/yyyy) is " + currentDate + currentMonth + currentYear + "\n");
        WebElement dateElement = null;
        if (mmm.equals(month) && (currentYear == Integer.parseInt(year))) {
            dateElement = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//td[not(contains(@class,'off')) and contains(text(),'" + day + "') and ancestor::div[@class='calendar-table']]" + ";xpath"));
            dateElement.click();
        } else {
            WebElement yearDropDown = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//select[@class='yearselect col']" + ";xpath"));
            WebElement monthDropDown = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//select[@class='monthselect col']" + ";xpath"));
            Select select = new Select(yearDropDown);
            select.selectByValue(year);
            Thread.sleep(500);
            select = new Select(monthDropDown);
            select.selectByValue(month);
            Thread.sleep(500);
            dateElement = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//td[not(contains(@class,'off')) and contains(text(),'" + day + "') and ancestor::div[@class='calendar-table']]" + ";xpath"));
            dateElement.click();
        }

        Thread.sleep(1000);
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @When("^I click the \"(.*?)\" (button|element) in the row with text \"(.*?)\" in the \"(.*?)\" table$")
    public void clickButtonInTableRowWithText(String destElement, String elementType, String srcValue, String tableName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        WebElement tableRow = Page.findTableRowByText(Hooks.getDriver(), tableName, srcValue);
        Assert.assertNotNull("Table row is not identified", tableRow);
        destElement = destElement.replace(" ", "");
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        String[] elementProperties;
        if (elementType.equals("element")) {
            elementProperties = UtilFunctions.getElementStringAndType(fileObj, "MISC_ELEMENTS." + destElement);
        } else {
            elementProperties = UtilFunctions.getElementStringAndType(fileObj, "BUTTONS." + destElement);
        }
        String elementPath = elementProperties[0];
        String elementMethod = elementProperties[1];
        SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.TWENTY, elementPath + ";" + elementMethod);
        WebElement eleToClick = SeleniumFunctions.findElementByWebElement(tableRow, SeleniumFunctions.setByValues(elementPath + ";"
                + elementMethod));
        Assert.assertNotNull("Element in table row is not identified", eleToClick);
        try {
            eleToClick.click();
        } catch (Exception e) {
            Assert.assertTrue("Element " + destElement + " in table row is not clicked due to exception: " + e.getMessage(), false);
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    //And I click the "" dropdown
    @When("^I click the \"(.*?)\" dropdown(?: in the \"(.*?)\" pane)?$")
    public void clickDropdown(String dropdownName, String paneName) {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        //testing
        System.out.println(curTabName);

        if (Page.clickDropdown(dropdownName, curTabName, paneName))
            Assert.assertTrue(dropdownName + " dropdown Not clicked.", true);
        else//try again
            Assert.assertTrue(dropdownName + " dropdown Not clicked.",
                    Page.clickDropdown(dropdownName, curTabName, paneName));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
    }

    @Then("^the \"(.*?)\" (image|icon|button|checkbox) should be shown for following text in note Data section")
    public void shouldBeDisplayedInNoteDataSection(String itemName, String itemType, DataTable dataTable)
            throws Throwable {

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        itemName = itemName.replace(" ", "");
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
        String imagePath, paneFrame;
        if (itemType.equals("button")) {
            imagePath = UtilFunctions.getElementFromJSONFile(fileObj, "BUTTONS." + itemName, "path");
            paneFrame = UtilFunctions.getElementFromJSONFile(fileObj, "BUTTONS." + itemName, "frame");
        } else if (itemType.equals("checkbox")) {
            imagePath = UtilFunctions.getElementFromJSONFile(fileObj, "CHECKBOXES." + itemName, "path");
            paneFrame = UtilFunctions.getElementFromJSONFile(fileObj, "CHECKBOXES." + itemName, "frame");
        } else {
            imagePath = UtilFunctions.getElementFromJSONFile(fileObj, "IMAGES." + itemName, "path");
            paneFrame = UtilFunctions.getElementFromJSONFile(fileObj, "IMAGES." + itemName, "frame");
        }
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        paneFrame = UtilFunctions.getFrameValue(frameMap, paneFrame);
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");

        List<Map<String, String>> dataList = dataTable.asMaps(String.class, String.class);
        Assert.assertTrue("Incorrect dataTable format, resulting in dataList of size 0.",
                dataList.size() > 0);
        String columnName = (String) dataList.get(0).keySet().toArray()[1];

        for (Map data : dataList) {
            String displayState = (String) data.get("Displayed");
            String rowValue = ((String) data.get(columnName));
            String path = "//div[@class='cd-list-row' and descendant::span[contains(text(),'" + rowValue + "')]]";
            UtilFunctions.log("xpath for clinical data element: " + path);

            WebElement dataObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(path + ";xpath"));
            if (dataObj != null) {
                WebElement imageObj = SeleniumFunctions.findElementByWebElement(dataObj,
                        SeleniumFunctions.setByValues("." + imagePath + ";xpath"));
                if (displayState.trim().equalsIgnoreCase("true")) {
                    Assert.assertTrue("Element " + itemName + " is not present for the value" + rowValue,
                            imageObj.isDisplayed());
                } else {
                    //imageObj may not be found if it isn't displayed in UI.
                    if (imageObj == null) {
                        Assert.assertNull("Element " + itemName + " is present in the table for value " +
                                rowValue, imageObj);
                    } else {
                        Assert.assertFalse("Element " + itemName + " is present in the table for value " +
                                rowValue, imageObj.isDisplayed());
                    }
                }
            } else {
                Assert.assertFalse("Clinical data " + rowValue + "not found", true);
            }
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    //TODO: Refactor to remove step and method and use Page.setTextBox instead which already clears and enters txt in txtbox
    @And("^I clear and enter \"(.*?)\" in the \"(.*?)\" field(?: in the \"(.*)\" pane)?$")
    public void clearAndEnterInTheField(String value, String fieldName, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        Assert.assertTrue("Failed to set field '" + fieldName + "' to '" + value + "'",
                Page.clearAndSetTextBox(Hooks.getDriver(), curTabName, value, fieldName, paneName));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    /**
     * @param toggleName - name of toggle, aka a switch
     * @param isOrIsNot  - whether state should be 'is' open/toggled on or not
     * @param paneName   - (optional)
     */
    @When("^the \"(.*?)\" toggle (is|is not) open(?: in the \"(.*?)\" pane)?$")
    public void toggleIsOpen(String toggleName, String isOrIsNot, String paneName) {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        if (isOrIsNot.equals("is")) {//Check if the toggle is Open/toggled On and if not open it/turn it on
            Assert.assertTrue(toggleName + " is not open.",
                    Page.toggleIsOpen(toggleName, curTabName, isOrIsNot, paneName));
        } else {//Check if the toggle is Closed/toggled Off and if not close it/turn it off
            Assert.assertFalse(toggleName + " is not closed.",
                    Page.toggleIsOpen(toggleName, curTabName, isOrIsNot, paneName));
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

}//end Globalsteps