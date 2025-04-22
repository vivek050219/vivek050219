package features.step_definitions;

import com.sun.jna.platform.win32.WinDef;
import com.sun.jna.platform.win32.WinDef.HWND;
import common.SeleniumFunctions;
import constants.GlobalConstants;
import cucumber.api.DataTable;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import features.Hooks;
import org.apache.commons.lang3.StringUtils;
import org.json.simple.JSONObject;
import org.junit.Assert;
import org.openqa.selenium.*;
import org.openqa.selenium.interactions.Actions;
import pageObject.PatientListPage;
import support.Page;
import support.jna_extensions.User32;
import support.jna_extensions.WindowHelper;
import utils.UtilFunctions;
import utils.UtilProperty;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import static features.Hooks.driver;

/**
 * Created by PatientKeeper on 7/6/2016.
 */

/******************************************************************************
 Class Name: PatientListChargesStepdefs
 Contains step definitions related to patient list charge page
 ******************************************************************************/

public class PatientListCPOEStepdefs {

    public String className = getClass().getSimpleName();

    //TODO: Refactor, both branches of this if-else do the exact same thing
    @When("^I select \"(.*)\" from the \"(.*)\" list in the search results( if it exists)?$")
    public void selectFromListInSearchResults(String order, String list, String exists) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        if (StringUtils.isEmpty(exists)) {
            if (order.equals("the first item"))
                Assert.assertTrue("Row not selected.", Page.selectFromTableByRowIndex(Hooks.getDriver(),
                        GlobalStepdefs.curTabName, list.replace(" ", ""), 0));
            else {
                Assert.assertTrue("Row not selected.", Page.selectFromTableByValue(Hooks.getDriver(),
                        GlobalStepdefs.curTabName, list.replace(" ", ""), "", order));
            }

            if (list.contains("NonFormulary")) {
                GlobalStepdefs globalStepdefs = new GlobalStepdefs();
                globalStepdefs.clickButton("Continue", null, "if it exists");
            }
        } else {
            if (order.equals("the first item"))
                Page.selectFromTableByRowIndex(Hooks.getDriver(), GlobalStepdefs.curTabName,
                        list.replace(" ", ""), 0);
            else {
                Page.selectFromTableByValue(Hooks.getDriver(), GlobalStepdefs.curTabName,
                        list.replace(" ", ""), "", order);
            }

            if (list.contains("NonFormulary")) {
                GlobalStepdefs globalStepdefs = new GlobalStepdefs();
                globalStepdefs.clickButton("Continue", null, "if it exists");
            }
        }


        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^the following options should appear in the \"(.*?)\" list in the search results$")
    public void checkSearchListOptions(String list, DataTable dataTable) throws Throwable {
        list = list.replace(" ", "");
        SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.TEN, "autocomplete_dialog" + ";id");
        PatientListPage.selectCPOETab(Hooks.getDriver(), list, "");
        List<String> dataList = dataTable.asList(String.class);
        boolean res = false;
        for (String value : dataList) {
            List<WebElement> rows = Page.findTableRowsByValue(Hooks.getDriver(), list, "", value);
            for (WebElement row : rows) {
                if (row != null) {
                    res = true;
                }
                if (res)
                    break;
            }
        }
        Assert.assertTrue(res);
    }


    @When("^I fill the( DMR)? mandatory order details in the \"(.*?)\" pane( if it exists)?( for change order)?$")
    public void handleOrderDetailPopUp(String isDischargeMedRec, String paneName, String exists, String changeOrder) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        //If the string "if it exists" is passed in and the pane might not exist/display
        if (exists != null &&
                !(Page.checkElementExists(Hooks.getDriver(), GlobalStepdefs.curTabName, paneName, "PANES"))) {
            UtilFunctions.log(paneName + " does not exist / is not displayed.  Mandatory order details do not " +
                    "need to be entered.  Returning...");
            System.out.println(paneName + " does not exist / is not displayed.  Mandatory order details do not " +
                    "need to be entered.  Returning...");
            return;
        }

        //Otherwise the pane exists and mandatory order details must be entered.
        paneName = paneName.replace(" ", "");

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj,
                "PANES." + paneName, "frame"));
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");

        //Wait for the Order Detail Screen to display
        SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.TEN,
                "//div[contains(@class, 'md-layout') and contains(@class,'lists-area-small')]" + ";xpath");

        //Find the Order Detail Screen's div containing the selects, inputs, textboxes, etc.
        WebElement orderDetailObj = SeleniumFunctions.findElement(Hooks.getDriver(),
                SeleniumFunctions.setByValues("//div[contains(@class, 'md-layout') and contains(@class,'lists-area-small')]"
                        + ";xpath"));
        Assert.assertNotNull("Order Detail Screen is NULL.  Mandatory order details can't be entered.", orderDetailObj);

        //Find the 'Dose' list box select
        String dosePKlistXpath = UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(GlobalStepdefs.curTabName,
                "PKLISTS", "Dose", "path", "", "");
        Assert.assertNotNull("'Dose' PK List Xpath is NULL.", dosePKlistXpath);
        UtilFunctions.log("'Dose' PK List Xpath: " + dosePKlistXpath);
        //Get the dose that is selected by default in the 'Dose' list box select
        String selectedText = Page.getSelectedOptionFromPKlist(Hooks.getDriver(), dosePKlistXpath);
        Assert.assertNotNull("selectedText from 'Dose' PK List is NULL and not found.", selectedText);
        selectedText = selectedText.toUpperCase();
        UtilFunctions.log("selectedText: " + selectedText);
        System.out.println("selectedText: " + selectedText);

        //If the dose selected by default is a typical dosage, not an IV Push or otherwise needing special instructions,
        //set the Frequency to Daily
        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        if (selectedText.contains("MG") || selectedText.contains("MCG") || selectedText.equals("")) {
            //Page.setPKList(Hooks.getDriver(), curTabName, value, selectName.replace(" ", ""), paneName)
            //globalStepdefs.selectItemFromMultiSelect("Daily", "Frequency", paneName);
            Thread.sleep(500);
            Assert.assertTrue("'Daily' not selected from 'Frequency' PK List in Order Details Screen.",
                    Page.setPKList(Hooks.getDriver(), GlobalStepdefs.curTabName, "Daily",
                            "Frequency", paneName));
            Thread.sleep(500);
        } else {//Otherwise, set the Special Instructions and the Frequency
            globalStepdefs.selectItemFromMultiSelect("Special Instruction", "Dose", paneName);
            Thread.sleep(500);
            globalStepdefs.enterInTheField("test order", "Special Instructions", paneName);
            Thread.sleep(500);
            //globalStepdefs.selectItemFromMultiSelect("Daily", "Frequency", paneName);
            Thread.sleep(500);
            Assert.assertTrue("'Daily' not selected from 'Frequency' PK List in Order Details Screen.",
                    Page.setPKList(Hooks.getDriver(), GlobalStepdefs.curTabName, "Daily",
                            "Frequency", paneName));
            Thread.sleep(500);
        }
        UtilFunctions.log("'Daily' sucessfully selected from 'Frequency' PK List in Order Details Screen.");
        System.out.println("'Daily' successfully selected from 'Frequency' PK List in Order Details Screen.");

        WebElement totalNumberOf = SeleniumFunctions.findElement(driver, By.xpath("//div[contains(text(),'Total # of') and contains(@class,'requiredField')]"));
        if (totalNumberOf != null && totalNumberOf.isDisplayed()) {
            PatientSafetyStepdefs patientSafetyStepdefs = new PatientSafetyStepdefs();
            patientSafetyStepdefs.clickRadioOrCheckbox("TotalNumberOfDays", "radio", paneName);
            if (changeOrder != null) {
                globalStepdefs.enterInTheField("4", "TotalNumberOfDays", paneName);
            } else {
                globalStepdefs.enterInTheField("2", "TotalNumberOfDays", paneName);
            }
        }

        //If is DMR, enter quantity and # of refills
        if (isDischargeMedRec != null) {
            WebElement quantity = SeleniumFunctions.findElement(driver, By.xpath("//label[text()='Quantity']"));
            if (quantity != null && quantity.isDisplayed()) {
                globalStepdefs.enterInTheField("2", "Dispense", paneName);
            }
            WebElement refills = SeleniumFunctions.findElement(driver, By.xpath("//div[contains(normalize-space(text()),'Refills')]"));
            if (refills != null && refills.isDisplayed()) {
                globalStepdefs.selectItemFromMultiSelect("0", "Refills", paneName);
            }
        }

        globalStepdefs.clickButton("Done", paneName, "if it exists");
        globalStepdefs.clickButton("CDSWOK", null, "if it exists");


        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @And("^I select CPOE \"(.*?)\" tab(?: in the \"(.*?)\" pane)?$")
    public void selectCPOETab(String tabName, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        PatientListPage.selectCPOETab(Hooks.getDriver(), tabName, paneName);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @And("^there should not be any unfinished orders$")
    public void checkUnfinishedOrders() throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        Thread.sleep(1000);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        String paneFrameMain = UtilFunctions.getFrameValue(frameMap, "OLD_UI_TOPFRAME");
        UtilFunctions.log("PaneFrameMain: " + paneFrameMain);
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrameMain, "id");
        String paneFrameTable = UtilFunctions.getFrameValue(frameMap, "FRAME_POPUP_CONTENTS");
        GlobalStepdefs globalStepdefs = new GlobalStepdefs();

        WebElement link = Page.findLinkText(Hooks.getDriver(), "unfinished orders", "", "");
        if (link != null && link.isDisplayed()) {
            link.click();
            Thread.sleep(1000);
            SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrameTable, "id");


            SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.TEN, "UnfinishedOrderTable" + ";id");

            List<WebElement> deleteButtons = SeleniumFunctions.findElements(Hooks.getDriver(), By.id("DeleteButton"));
            for (WebElement delete : deleteButtons) {
                delete.click();
                Thread.sleep(1000);
            }
            globalStepdefs.clickButton("Close", "UnfinishedOrders", null);
            Assert.assertNull(Page.findLinkText(Hooks.getDriver(), "unfinished orders", "", ""));
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @And("^I (re)?select \"(.*?)\" as override reason in the \"(.*?)\" pane( if it exists)?$")
    public void selectOverrideReason(String reselect, String value, String paneName, String exists) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        paneName = paneName.replace(" ", "");
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
        String paneFrames = UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame");
        paneFrames = UtilFunctions.getFrameValue(frameMap, paneFrames);
        UtilFunctions.log("PaneFrames: " + paneFrames);
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");


        boolean handle_drug_dup_message = false;

        String override = UtilFunctions.getElementFromJSONFile(fileObj, "DROPDOWNS." + "Override", "path");
        SeleniumFunctions.explicitWait(driver, GlobalConstants.FIFTEEN, override + ";xpath");
        WebElement override_exists = SeleniumFunctions.findElement(Hooks.getDriver(), By.xpath(override));
        int i = 0;
        if (override_exists != null) {
            handle_drug_dup_message = true;
        }
        int count = 0;
        int maxTries = 3;
        if (handle_drug_dup_message) {

            List<WebElement> multi_drug_dup_messages = SeleniumFunctions.findElements(Hooks.getDriver(), By.xpath(override));
            if (paneName.equals("CDSWarnings")) {
                if (reselect == null) {
                    i = 2;
                }
            } else {
                if (reselect == null) {
                    i = 0;
                }
            }
            for (WebElement d : multi_drug_dup_messages) {
                try {
                    Thread.sleep(2000);
                    i += 1;
                    d.click();
                    SeleniumFunctions.findElement(Hooks.getDriver(), By.xpath("//td[descendant-or-self::*/text()='" +
                            value +
                            "' and ancestor::div[@class='dijitPopup dijitMenuPopup' and contains(@style,'visibility: visible')]]")).click();
                } catch (Exception e) {
                    if (++count == maxTries || exists == null) throw e;
                }
            }
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I select \"(.*)\" from the (home|hospital) medication favorites list in the \"(.*?)\" pane$")
    public void selectFavoriteFromSearchOrdersList(String orderName, String listType, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        paneName = paneName.replace(" ", "");
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
        String paneFrames = UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame");
        paneFrames = UtilFunctions.getFrameValue(frameMap, paneFrames);
        UtilFunctions.log("PaneFrames: " + paneFrames);
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");

        SeleniumFunctions.explicitWait(Hooks.getDriver(), 5, "//div[contains(@id, SearchDialogFavorites)]"
                + ";xpath");

        WebElement favCollapsed = SeleniumFunctions.findElement(Hooks.getDriver(),
                By.xpath("//div[contains(@class, 'hpickerBranch') and contains(@class, 'hpickerTopBranch') and contains(@class, 'hpickerCollapsed')]"));

        if (favCollapsed != null) {
            favCollapsed.click();
        }
        Thread.sleep(1000);

        if (listType.equals("home")) {
            SeleniumFunctions.findElement(Hooks.getDriver(), By.xpath("//span[@class='hpickerItemDescription' and contains(text(),'" + orderName + "') and ancestor::div[@id='HomeMedSearchDialogFavorites']]")).click();
        } else {
            SeleniumFunctions.findElement(Hooks.getDriver(), By.xpath("//span[@class='hpickerItemDescription' and contains(text(),'" + orderName + "') and ancestor::div[@id='SearchDialogFavorites']]")).click();
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @Then("^I search for the \"(.*?)\" order$")
    public void searchForOrder(String order) throws Throwable {
        GlobalStepdefs globalStepdefs = new GlobalStepdefs();

        //Thread.sleep(2000);
        globalStepdefs.clickButton("Enter Orders", null, null);
        globalStepdefs.clickButton("OK", "Warning", "if it exists");
        globalStepdefs.enterInTheField(order, "Add Order", "Enter Orders");
    }


    @Then("^I place the \"(.*?)\" order$")
    public void placeAnOrder(String order) throws Throwable {
        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        PatientListCPOEStepdefs patientListCPOEStepdefs = new PatientListCPOEStepdefs();

        //Thread.sleep(2000);
        patientListCPOEStepdefs.searchForOrder(order);
        patientListCPOEStepdefs.selectFromListInSearchResults(order, "NonFormulary MedOrders", null);
        //Only pass in "exists" or "if it exists" to handleOrderDetailPopUp() if the Order Detail screen might not exist.
        //Since, this step is to place an order, the Order Detail screen has to exist. Never pass in  "exists" or "if it exists" here.
        patientListCPOEStepdefs.handleOrderDetailPopUp(null, "Edit Order", null, null);
        globalStepdefs.reconcileSubmitOrders(null);//pass in null b/c not reconciling meds, but placing an order
    }

    @Then("^the \"(green checkmark|interaction warning icon)\" changed to \"(interaction warning icon|green checkmark)\" on the left side in the \"(.*?)\" pane$")
    public void checkForInteractionWarningIcon(String item1, String item2, String paneName) throws Throwable {

        Assert.assertTrue(!item1.equals(item2));
        paneName = paneName.replace(" ", "");
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
        String paneFrames = UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame");
        paneFrames = UtilFunctions.getFrameValue(frameMap, paneFrames);
        UtilFunctions.log("PaneFrames: " + paneFrames);
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");

        if (item1.equals("green checkmark") && item2.equals("interaction warning icon")) {
            Assert.assertTrue(Page.checkIfElementExists(Hooks.getDriver(),
                    "//div[@id='OrderListSection']//div[@class='error']", ";xpath"));
        } else {
            Assert.assertFalse(Page.checkIfElementExists(Hooks.getDriver(),
                    "//div[@id='OrderListSection']//div[@class='error']", ";xpath"));
        }
    }


    @When("^I enter \"(.*)\" reason for the exam in the \"(.*)\" pane$")
    public void enterReasonForExam(String reason, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        Page.clickLinkText(driver, GlobalStepdefs.curTabName, "Select Problem",
                paneName.replace(" ", ""), null, null);
        Thread.sleep(300);

        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        globalStepdefs.enterInTheField(reason, "SearchForProblem", null);
        Thread.sleep(200);

        Page.clickButton(driver, GlobalStepdefs.curTabName, "EditOrderOK", paneName);
        globalStepdefs.clickButton("OK", "paneName", "exists");

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");

    }


    @And("^I (Stop|Continue) all the medications(?: in the \"(.*?)\" table)? in the \"(.*?)\" pane$")
    public void stopContinueMeds(String option, String tableName, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String currentTab = GlobalStepdefs.curTabName;
        UtilFunctions.log("Current tab: " + currentTab);

        GlobalStepdefs globalStepdefs = new GlobalStepdefs();

        if (option.equals("Stop") && paneName.contains("Discharge")) {
            globalStepdefs.clickButton("Stop Remaining Meds", "Discharge Medication Reconciliation",
                    "Yes");
            globalStepdefs.clickButton("Yes", "Question", "Yes");
        } else {
            paneName = paneName.replace(" ", "");
            HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(currentTab);
            JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(currentTab);
            String paneFrames = UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame");
            paneFrames = UtilFunctions.getFrameValue(frameMap, paneFrames);
            UtilFunctions.log("PaneFrames: " + paneFrames);
            SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");

            option = option.toUpperCase();

            if (tableName == null) {
                WebElement tableElement = Page.findTable(Hooks.getDriver(), currentTab, "MedicationReconciliation");
                List<WebElement> radiosList = SeleniumFunctions.findElementsByWebElement(tableElement,
                        SeleniumFunctions.setByValues("//input[@type='radio' and @value='" + option + "']"));
                for (WebElement radio : radiosList) {
                    Thread.sleep(1000);
                    if (radio.isDisplayed()) {
                        radio.click();
                        globalStepdefs.clickButton("Yes", "Question", "if it exists");
                    }
                }//end for click each radio
            }//TODO: This else isn't working.  Throws Stale Element Ref when gets to 2nd iteration of FOR loop.  Need new way to find each row.
            else {
                tableName = tableName.replace(" ", "");
                WebElement tableElement = Page.findTable(Hooks.getDriver(), currentTab, tableName);
                Assert.assertNotNull(tableName + " table is NULL and not found", tableElement);
                UtilFunctions.log(tableName + " table FOUND.");

                String[] tableDetailArr = UtilFunctions.getTableValues(currentTab, tableName);
                String tableBody = tableDetailArr[3];

                WebElement tableBodyObj = SeleniumFunctions.findElementByWebElement(tableElement,
                        SeleniumFunctions.setByValues(tableBody + ";xpath"));
                List<WebElement> tableRows = SeleniumFunctions.findElementsByWebElement(tableBodyObj,
                        SeleniumFunctions.setByValues(".//tr[@id='UnreconciledOrderRow']" + ";xpath"));
                Assert.assertNotNull(tableName + " table has no rows.", tableRows);

                if (tableRows.size() > 0) {
//                    for (WebElement row : tableRows) {
                    for (int i = 0; i < tableRows.size(); ++i) {
//                        WebElement row = tableRows.get(i);
                        WebElement row = Page.getTableRowIndex(Hooks.getDriver(), currentTab, tableName, i);
                        WebElement cell = SeleniumFunctions.findElementByWebElement(row, By.xpath(".//td[@id='UnreconciledOrderDescriptionCell']"));
                        SeleniumFunctions.mouseOver(Hooks.getDriver(), row);
                        String cellText;
                        try {
                            cellText = cell.getText();
                        } catch (StaleElementReferenceException e) {
                            row = Page.getTableRowIndex(Hooks.getDriver(), currentTab, tableName, i);
                            cell = SeleniumFunctions.findElementByWebElement(row, By.xpath(".//td[@id='UnreconciledOrderDescriptionCell']"));
                            cellText = cell.getText();
                        }

                        String medName = cellText.split("\n")[0].trim();
                        medName = medName.replaceAll("DAILY", "").trim();
                        String[] medNameArr = medName.split(" ");
                        medName = medNameArr[0].trim();

                        String numericDose = medNameArr[1].trim();
                        String measureOfDose = medNameArr[2].trim().toUpperCase();
                        if (!measureOfDose.equalsIgnoreCase("MG") ||
                                !measureOfDose.equalsIgnoreCase("ML") ||
                                !measureOfDose.equalsIgnoreCase("CC")) {
                            measureOfDose = medNameArr[3].trim().toUpperCase();
                        }
                        String medDose = numericDose + measureOfDose;

                        WebElement radio = SeleniumFunctions.findElementByWebElement(row,
                                SeleniumFunctions.setByValues(".//input[@type='radio' and @value='" + option + "']"));
                        Assert.assertTrue(option + " radio button for med: " + medName + " is not displayed.",
                                radio.isDisplayed());

                        radio.click();
                        Page.setTextBox(Hooks.getDriver(), currentTab, medName + " " + medDose, "SearchFor", "Searchfor");
                        Assert.assertTrue("", selectMedByNameAndDose(medName, medDose));

                        if (Page.checkElementExists(Hooks.getDriver(), currentTab, "Question", "PANES")) {
                            Page.clickButton(Hooks.getDriver(), currentTab, "Yes", "Question");
                        }
                    }
                } else {
                    UtilFunctions.log(tableName + " table has 0 rows.  " +
                            "There are no AMR or Home meds that need to be reconciled.");
                }
            }//end if else (tableName == null)

        }//end if else (option.equals("Stop") && paneName.contains("Discharge"))

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    //And I select the medication from search results by med name "" and dose ""
    //@And("^I select the medication from search results by med name \"(.*?)\" and dose \"(.*?)\"$")
    private boolean selectMedByNameAndDose(String medName, String dose) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String currentTab = GlobalStepdefs.curTabName;
        UtilFunctions.log("currentTab: " + currentTab);

        String[] tableDetailArr = UtilFunctions.getTableValues(currentTab, "SearchedCombinedMedOrders");
        String tablePath = tableDetailArr[2];
        String tableBodyPath = tableDetailArr[3];
        String paneFrames = tableDetailArr[4];

        UtilFunctions.log("tablePath: " + tablePath);
        UtilFunctions.log("tableBodyPath: " + tableBodyPath);
        UtilFunctions.log("PaneFrames: " + paneFrames);

        SeleniumFunctions.selectFrame(driver, paneFrames, "id");
        WebElement tableObj = Page.findTable(Hooks.getDriver(), tablePath);

        if (tableObj != null && tableObj.isDisplayed()) {
            WebElement tableBody = SeleniumFunctions.findElementByWebElement(tableObj, By.xpath(tableBodyPath));
            if (tableBody != null) {
                List<WebElement> tableRows = SeleniumFunctions.findElementsByWebElement(tableBody,
                        By.xpath("//tr[contains(@id, 'ORDERPROTOTYPE') or contains(@id, 'ORDERDEF')]"));
                if (tableRows != null && tableRows.size() > 0) {
                    for (WebElement row : tableRows) {
                        String rowText = row.getText().trim();
                        if (rowText.contains(medName) && rowText.contains(dose)) {
                            if (SeleniumFunctions.mouseOver(Hooks.getDriver(), row)) {
                                row.click();
                                Thread.sleep(500);
                                return true;
                            }
                        }
                    }
                }
            }
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
        return false;
    }


    @When("^I discontinue the order with the \"(.*?)\" text in the \"(.*?)\" table$")
    public void discontinueMedOrder(String value, String tableName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        value = value.trim();
        boolean success = false;
        List<WebElement> rows = Page.findTableRowsByValue(Hooks.getDriver(), tableName, "", value, 5);
        for (WebElement row : rows) {
            List<WebElement> cols = SeleniumFunctions.findElementsByWebElement(row, By.xpath(".//td/*"));
            for (WebElement element : cols) {
                if (element != null) {
                    String orderText = element.getText();
                    orderText = orderText.trim();
                    if (orderText.equalsIgnoreCase(value) || orderText.startsWith(value)) {
                        Actions action = new Actions(Hooks.getDriver());
                        action.moveToElement(element).perform();
                        success = true;
                        break;
                    }
                } else {
                    UtilFunctions.log("order not found in the table");
                    success = false;
                    break;
                }
            }
        }
        Assert.assertTrue("Mouse over the order " + value + " failed", success);
        Page.clickMiscElement(driver, GlobalStepdefs.curTabName, "Discontinue", null, null, null);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    /* For radio button, only value should be used*/
    @When("^I mouse over the \"(.*?)\" (text|element|image) and click the \"(.*?)\" (element|link|button|radio)" +
            " of the row with text \"(.*?)\"(?: under the \"(.*?)\" column)? in the \"(.*?)\" table$")
    public void moveOverAndClickElement(String moverObj, String moverObjType, String clickObj, String clickObjType,
                                        String rowValue, String colName, String tableName) throws Throwable {

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        tableName = tableName.replace(" ", "");
        String paneFrame = UtilFunctions.getFrameValue(frameMap,
                UtilFunctions.getElementFromJSONFile(fileObj, "TABLES." + tableName, "frame"));
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
        WebElement row;
        if (colName == null)
            row = Page.findTableRowByText(Hooks.getDriver(), tableName, rowValue);
        else
            row = Page.findTableRowByCellText(Hooks.getDriver(), GlobalStepdefs.curTabName, tableName, colName, rowValue);
        String[] moverEleDetails;
        String moverLocator = "", moverLocatorValue = "";
        switch (moverObjType) {
            case "text":
                moverLocator = "xpath";
                moverLocatorValue = "//*[text() = '" + moverObj + "']" + ";xpath";
                break;
            case "image":
                moverEleDetails = UtilFunctions.getElementStringAndType(fileObj,
                        "IMAGES." + moverObj.replace(" ", ""));
                moverLocator = moverEleDetails[1];
                moverLocatorValue = moverEleDetails[0];
                break;
            default:
                moverEleDetails = UtilFunctions.getElementStringAndType(fileObj,
                        "MISC_ELEMENTS." + moverObj.replace(" ", ""));
                moverLocator = moverEleDetails[1];
                moverLocatorValue = moverEleDetails[0];
                break;
        }
        WebElement moverElement = SeleniumFunctions.findElementByWebElement(row,
                SeleniumFunctions.setByValues(moverLocatorValue + ";" + moverLocator));
        Assert.assertNotNull(moverObj + " " + moverObjType + " is not found", moverElement);

        Assert.assertTrue("Mouse over on " + moverObj + " element is not successful",
                SeleniumFunctions.mouseOver(Hooks.getDriver(), moverElement));

        String[] clickEleDetails;
        String clickLocator = "", clickLocatorValue = "";
        switch (clickObjType) {
            case "link":
                clickLocator = "xpath";
                clickLocatorValue = "//*[starts-with(normalize-space(./text()), '" + clickObj + "')]";
                break;
            case "button":
                clickEleDetails = UtilFunctions.getElementStringAndType(fileObj,
                        "BUTTONS." + clickObj.replace(" ", ""));
                clickLocator = clickEleDetails[1];
                clickLocatorValue = clickEleDetails[0];
                break;
            case "radio":
                clickLocator = "xpath";
                clickLocatorValue = "//input[@type='radio' and @value='" + clickObj + "']";
                break;
            case "image":
                clickEleDetails = UtilFunctions.getElementStringAndType(fileObj,
                        "IMAGES." + clickObj.replace(" ", ""));
                clickLocator = clickEleDetails[1];
                clickLocatorValue = clickEleDetails[0];
                break;
            default:
                clickEleDetails = UtilFunctions.getElementStringAndType(fileObj,
                        "MISC_ELEMENTS." + clickObj.replace(" ", ""));
                clickLocator = clickEleDetails[1];
                clickLocatorValue = clickEleDetails[0];
                break;
        }
        WebElement clickEle = SeleniumFunctions.findElementByWebElement(row,
                SeleniumFunctions.setByValues(clickLocatorValue + ";" + clickLocator));
        Assert.assertNotNull(clickObj + " " + clickObjType + " is not found", clickEle);
        WebDriver currentDriver = Hooks.getDriver();
        try {
//            clickEle.click();
            JavascriptExecutor jsExecutor = (JavascriptExecutor) currentDriver;
            jsExecutor.executeScript("arguments[0].click()", clickEle);
        } catch (Exception e) {
            UtilFunctions.log(clickObj + " " + clickObjType + " is not clicked due to exception: " + e.getMessage());
            Assert.assertFalse(clickObj + " " + clickObjType + " is not clicked due to exception: " + e.getMessage(), true);
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    //Then I sign and submit the order

    @Then("^I sign and submit the order with default password$")
    public void signSubmitOrder() throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String defaultPassword = UtilProperty.userPwd;
        String paneFrameName = UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(GlobalStepdefs.curTabName, "PANES", "SignOrders", "frame", "", "");
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrameName, "id");

        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        if (Page.checkElementOnPagePresent(Hooks.getDriver(), GlobalStepdefs.curTabName, "SignOrders", "PANES")) {
            if (SeleniumFunctions.findElement(driver, By.id("promptInput")) != null) {
                globalStepdefs.enterInTheField(defaultPassword, "Password", "SignOrders");
            }
            globalStepdefs.clickButton("Search", "SignOrders", null);
            globalStepdefs.selectFromTheTable("the first item", "Look Up");
            globalStepdefs.clickButton("Look Up OK", "SignOrders", null);

        } else {
            //Not on the sign orders pane
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I apply the security key from VIP Access$")
    public void applyVIPCode() {
        Process vipAccess;
        try {
            vipAccess = new ProcessBuilder("C:\\Program Files (x86)\\Symantec\\VIP Access Client\\VIPUIManager.exe").start();
        } catch (IOException ex) {
            throw new RuntimeException(ex);
        }
        HWND vipWindow = com.sun.jna.platform.win32.User32.INSTANCE.FindWindow(null, " VIP Access");
        HWND vipCodeBox = WindowHelper.FindWindowByIndex(vipWindow, "Static", 6);

        //get current code
        WinDef.LRESULT strlen = com.sun.jna.platform.win32.User32.INSTANCE.SendMessage(vipCodeBox, User32.WM_GETTEXTLENGTH, null, null);
        char[] codeArr = new char[strlen.intValue()];
        User32.instance.SendMessage(vipCodeBox, User32.WM_GETTEXT, strlen.intValue() + 1, codeArr);
        String vipSecurityCode = new String(codeArr);

        try {
            Assert.assertNotEquals("Failed to copy 2FA security code from VIP Access", vipSecurityCode, "");
            Assert.assertTrue("Failed to enter security code in Controlled Substance 2FA field",
                    Page.setTextBox(Hooks.getDriver(), "PatientList", vipSecurityCode, "ControlledSubstance2FA"));
        } finally {
            //close VIP access regardless of outcome
            vipAccess.destroy();
        }
    }

}
