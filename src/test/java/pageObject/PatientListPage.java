package pageObject;

import common.SeleniumFunctions;
import constants.GlobalConstants;
import cucumber.api.DataTable;
import features.Hooks;
import features.step_definitions.GlobalStepdefs;
import features.step_definitions.PatientListChargesStepdefs;
import frames.PatientList_Frames;
import org.apache.commons.lang3.StringUtils;
import org.json.simple.JSONObject;
import org.junit.Assert;
import org.openqa.selenium.*;
import org.openqa.selenium.interactions.Actions;
import support.Page;
import utils.UtilFunctions;
import utils.UtilProperty;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static features.Hooks.driver;
import static support.Page.checkIfLinkExists;
import static support.Page.clickLinkText;

/**
 * Created by PatientKeeper on 6/23/2016.
 */

/******************************************************************************
 Class Name: PatientListPage
 Contains functions related to operations on PatientList page
 ******************************************************************************/

public class PatientListPage {

    public String className = getClass().getSimpleName();
    private static PatientListPage patientListPage = new PatientListPage();

    static String tabName = "PatientList";
    static String daysNo = "";


    /**************************************************************************
     * name: setTab(String tab)
     * functionality: Set the current tab value
     * param: String tab - Current tab name
     * return: void
     *************************************************************************/
    public static void setTab(String tab) {
        tabName = tab;
    }


    /**************************************************************************
     * name: setNoOfDays(String days)
     * functionality: Set the no of days to be entered in add patient form
     * param: String days - No of days to be entered
     * return: void
     *************************************************************************/
    public static void setNoOfDays(String days) {
        UtilFunctions.log("Class: " + patientListPage.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);
        daysNo = days;
        UtilFunctions.log("No of days set to: " + daysNo);
    }


    /**************************************************************************
     * name: getNoOfDays
     * functionality: Get the no of days to be entered in add patient form
     * return: returns the no of days to be entered
     *************************************************************************/
    public static String getNoOfDays() {
        UtilFunctions.log("Class: " + patientListPage.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);
        if (daysNo.equals("")) {
            UtilFunctions.log("Returning 5 no of days.");
            return "5";
        } else {
            UtilFunctions.log("Returning " + daysNo + " no of days.");
            return daysNo;
        }
    }


    /**************************************************************************
     * name: refreshPatientList(WebDriver driver, String... frameNameArr)
     * functionality: Function refreshes the patient list on patient list tab
     * param: WebDriver driver - WebDriver object
     * param: String... frameNameArr - Optional variable for frame to be
     * switched to
     * return: boolean
     *************************************************************************/
    public static boolean refreshPatientList(WebDriver driver, String... frameNameArr) throws InterruptedException {
        UtilFunctions.log("Class: " + patientListPage.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);

        String frameName;
        if (frameNameArr.length > 0)
            frameName = frameNameArr[0];
        else
            frameName = "FRAME_LIST";

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        String paneFrames = UtilFunctions.getFrameValue(frameMap, frameName);
        UtilFunctions.log("PaneFrames" + paneFrames);
        SeleniumFunctions.selectFrame(driver, paneFrames, "id");
        String xPath = UtilFunctions.getElementFromJSONFile(fileObj, "CLINICAL_REFRESH", "");
        UtilFunctions.log("xPath" + xPath);

        SeleniumFunctions.explicitWait(driver, GlobalConstants.TWENTY, xPath + ";xpath");
        WebElement refreshObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(xPath + ";xpath"));
        if (refreshObj == null) {
            UtilFunctions.log("Refresh Patient object not present. Returning false.");
            return false;
        } else {
            refreshObj.click();
            Thread.sleep(2500);
            UtilFunctions.log("Refresh button clicked and waited for 2.5sec. Returning true.");
            return true;
        }
    }


    /**************************************************************************
     * name: findPatientByName(WebDriver driver, String patientName)
     * functionality: Get the object of patient name on patient list
     * param: WebDriver driver - WebDriver object
     * param: String patientName - Name of patient
     * return: returns the element object
     *************************************************************************/
    public static WebElement findPatientByName(WebDriver driver, String reformedPatientName) {
        UtilFunctions.log("Class: " + patientListPage.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);
        UtilFunctions.log("ReformedPatientName: " + reformedPatientName);

        String tab = GlobalStepdefs.curTabName;
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        //Condition to check if the tab is PatientListV2
        if (tab.equals("PatientListV2")) {
            String paneFrames = UtilFunctions.getFrameValue(frameMap, "FRAME_LISTV2");
            UtilFunctions.log("PaneFrames: " + paneFrames);
            SeleniumFunctions.selectFrame(driver, paneFrames, "id");
            String xPath = "//span[@class='PAT_FULLNAME' and normalize-space(text())='" + reformedPatientName + "']";
            UtilFunctions.log("xPath: " + xPath);
            SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, xPath + ";xpath");
            return SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(xPath + ";xpath"));
        } else {
            String paneFrames = UtilFunctions.getFrameValue(frameMap, "FRAME_LIST");
            UtilFunctions.log("PaneFrames: " + paneFrames);
            SeleniumFunctions.selectFrame(driver, paneFrames, "id");
            String xPath = "//td[starts-with(@id, 'PatientNameCell') and normalize-space(text())='" + reformedPatientName + "']";
            UtilFunctions.log("xPath: " + xPath);
            SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, xPath + ";xpath");
            return SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(xPath + ";xpath"));
        }
    }


    /**************************************************************************
     * name: selectPatientByName(WebDriver driver, String patientName)
     * functionality: Click on the patient after retrieving its object
     * param: WebDriver driver - WebDriver object
     * param: String patientName - Name of patient
     * return: boolean
     *************************************************************************/
    public static boolean selectPatientByName(WebDriver driver, String patientName) throws Throwable {
        UtilFunctions.log("Class: " + patientListPage.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);
        UtilFunctions.log("patientName: " + patientName);

        String tab = GlobalStepdefs.curTabName;
        String patientsParentXPath;
        patientName = UtilFunctions.reformName(patientName).toUpperCase();
        UtilFunctions.log("reformedPatientName: " + patientName);
        //COndition to check if the tab is PatientListV2
        if (tab.equals("PatientListV2"))
            patientsParentXPath = "//tr[contains(@class, 'selected') and descendant-or-self::span[@class='PAT_FULLNAME' and normalize-space(text())='" + patientName + "']]";
        else
            patientsParentXPath = "//tr[@class='standardTable_selectedRow' and descendant::td[starts-with(@id, 'PatientNameCell') and normalize-space(text())='" + patientName + "']]";
        UtilFunctions.log("patientsParentXPath: " + patientsParentXPath);
        int patientSelectCnt = 0;
        WebElement patientNameObj = findPatientByName(driver, patientName);
        if (patientNameObj == null) {
            UtilFunctions.log("patient: " + patientName + " not present. Returning false.");
            return false;
        } else {
            System.out.println(patientNameObj.getText());
            patientNameObj.click();
            patientNameObj.click();
            UtilFunctions.log("patient: " + patientNameObj.getText() + " present and clicked twice. Will check for parent now.");
            while (SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(patientsParentXPath + ";xpath")) == null) {
                patientSelectCnt++;
                UtilFunctions.log("Patient select check count: " + patientSelectCnt);
                patientNameObj = findPatientByName(driver, patientName);
                ((JavascriptExecutor) driver).executeScript("arguments[0].scrollIntoView(true);", patientNameObj);
                Thread.sleep(500);

                System.out.println(patientNameObj.getText());
                UtilFunctions.log("PatientName: " + patientNameObj.getText());
                patientNameObj.click();
                if (patientSelectCnt > GlobalConstants.TEN) {
                    UtilFunctions.log("patient: " + patientNameObj.getText() + " not present. Returning false.");
                    return false;
                }
            }
            UtilFunctions.log("patient: " + patientNameObj.getText() + " present. Returning true.");
            return true;
        }
    }

    /**************************************************************************
     * Select a patient from the patient list via row index
     *
     * @param driver WebDriver object
     * @param index Index of row to select
     * @return boolean
     *************************************************************************/
    public static boolean selectPatientByIndex(WebDriver driver, int index) {
        UtilFunctions.log("Class: " + patientListPage.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);
        UtilFunctions.log("PatientIndex: " + index);

        if (index < 1) {
            UtilFunctions.log("Patient index invalid: " + index);
            return false;
        }

        String tab = GlobalStepdefs.curTabName;
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        List<WebElement> patientRows = null;
        //Condition to check if the tab is PatientListV2
        if (tab.equals("PatientListV2")) {
            String paneFrames = UtilFunctions.getFrameValue(frameMap, "FRAME_LISTV2");
            UtilFunctions.log("PaneFrames: " + paneFrames);
            SeleniumFunctions.selectFrame(driver, paneFrames, "id");
            patientRows = SeleniumFunctions.findElements(Hooks.getDriver(), By.xpath("//table[@class='visits-table']/tbody//span[@class='PAT_FULLNAME']"));
        } else {
            //TODO: Test 'select patient by index' in PLv1
            String paneFrames = UtilFunctions.getFrameValue(frameMap, "FRAME_LIST");
            UtilFunctions.log("PaneFrames: " + paneFrames);
            SeleniumFunctions.selectFrame(driver, paneFrames, "id");
            patientRows = SeleniumFunctions.findElements(Hooks.getDriver(), By.xpath("//table[@id='dynamicDetailTable']/tbody//td[starts-with(@id, 'PatientNameCell')]"));
        }
        if (index <= patientRows.size()) {
            //Array index starts at 0.  Subtract 1 to compensate.
            patientRows.get(index - 1).click();
            UtilFunctions.log("Patient at index '" + index + "' selected");
            return true;
        } else {
            UtilFunctions.log("Index '" + index + "' not within range of selected patient list, which has '" + patientRows.size() + "' elements.");
            return false;
        }
    }

    /**************************************************************************
     * name: selectClinicalNav(WebDriver driver, String selectName, String... paneNameArr)
     * functionality: Function used to select navigation item (ex - charges)
     * from patient list tab
     * param: WebDriver driver - WebDriver object
     * param: String selectName - Name of clinical item to select
     * (ex - charges)
     * param: String... paneNameArr - Optional parameter to store pane name
     * return: boolean
     *************************************************************************/
    public static boolean selectClinicalNav(WebDriver driver, String selectName, String... paneNameArr) {
        UtilFunctions.log("Class: " + patientListPage.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);
        UtilFunctions.log("Clinical Select name: " + selectName);

        String paneFrames;
        String paneName = "";
        if (paneNameArr.length > 0)
            paneName = paneNameArr[0];
        UtilFunctions.log("paneName: " + paneName);
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        if (paneName.equals("")) {
            paneFrames = UtilFunctions.getFrameValue(frameMap, "FRAME_CLINNAV");
            SeleniumFunctions.selectFrame(driver, paneFrames, "id");
        } else {
            paneName = paneName.replace(" ", "");
            paneFrames = (String) frameMap.get(UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
            SeleniumFunctions.selectFrame(driver, paneFrames, "id");
        }
        UtilFunctions.log("paneFrames: " + paneFrames);
        return clickLinkText(driver, selectName);
    }

    /**************************************************************************
     * name: checkIfExists(WebDriver driver, String objName)
     * functionality: checks if the image has been uploaded successfully
     * param: WebDriver driver - WebDriver object
     * param: String objName - Name of image to be searched
     * return: boolean value
     *************************************************************************/
    public static boolean checkIfExists(WebDriver driver, String objName) {
        UtilFunctions.log("Class: " + patientListPage.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);

        WebElement element = SeleniumFunctions.findElement(driver, new By.ByXPath(objName));
        if (element != null)
            return true;
        return false;
    }

    /**************************************************************************
     * name: getClinicalNav(WebDriver driver, String paneName)
     * functionality: Get Clinical navigation item text from patient list tab
     * param: WebDriver driver - WebDriver object
     * param: String paneName - Store pane name
     * return: clinical navigation item text
     *************************************************************************/
    public static String getClinicalNav(WebDriver driver, String paneName) {
        UtilFunctions.log("Class: " + patientListPage.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);

        String paneFrames;
        UtilFunctions.log("paneName: " + paneName);
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        if (paneName.equals("")) {
            paneFrames = UtilFunctions.getFrameValue(frameMap, "FRAME_CLINNAV");
            SeleniumFunctions.selectFrame(driver, paneFrames, "id");
        } else {
            paneName = paneName.replace(" ", "");
            paneFrames = (String) frameMap.get(UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
            SeleniumFunctions.selectFrame(driver, paneFrames, "id");
        }
        UtilFunctions.log("paneFrames: " + paneFrames);
        try {
            return SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//li[@class='active' or @class='active first']" + ";xpath")).getText();
        } catch (Exception e) {
            UtilFunctions.log("Not able to find clinical object. Returning null.");
            return null;
        }
    }


    /**************************************************************************
     * name: setChargeHeaders(WebDriver driver, DataTable dataTable,
     * String... paneNameArr)
     * functionality: Function used to set charge header values in add charge
     * form
     * param: WebDriver driver - WebDriver object
     * param: DataTable dataTable - Stores the charge headers and their values
     * param: String... paneNameArr - Optional parameter to store pane name
     * return: "" if headers set successfully
     *************************************************************************/
    public static String setChargeHeaders(WebDriver driver, DataTable dataTable, String... paneNameArr) throws InterruptedException {
        UtilFunctions.log("Class: " + patientListPage.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);

        String paneName;
        boolean setHeader;
        String retValue = "";
        if (paneNameArr.length > 0) {
            paneName = paneNameArr[0];
            paneName = paneName.replace(" ", "");
        } else {
            paneName = "ChargeEntry";
        }
        UtilFunctions.log("paneName: " + paneName);
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        List<Map<String, String>> dataList = dataTable.asMaps(String.class, String.class);
        String paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
        UtilFunctions.log("paneFrames: " + paneFrames);
        SeleniumFunctions.selectFrame(driver, paneFrames, "id");
        for (Map data : dataList) {
            String fieldName = (String) data.get("Name");
            String fieldValue = UtilFunctions.convertThruRegEx((String) data.get("Value"));
            String headerXPath = "//div[@class='header_info' and descendant::span[text()='" + fieldName + "']]";

            UtilFunctions.log("fieldName: " + fieldName);
            UtilFunctions.log("fieldValue: " + fieldValue);
            UtilFunctions.log("headerXPath: " + headerXPath);

            SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, headerXPath + ";xpath");
            WebElement headerObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(headerXPath + ";xpath"));
            if (headerObj == null) {
                retValue = retValue + "Header for: " + fieldName + " not found.";
                UtilFunctions.log("Header object not present. retValue: " + retValue);
            } else {
                WebElement preHeaderObj = SeleniumFunctions.findElementByWebElement(headerObj, SeleniumFunctions.setByValues(".//span[@class='inlineBlockClass'];xpath"));
                if (preHeaderObj == null) {
                    setHeader = true;
                } else {
                    if (preHeaderObj.getText().equals(fieldValue))
                        setHeader = false;
                    else {
                        WebElement clearValueObj = SeleniumFunctions.findElementByWebElement(headerObj, SeleniumFunctions.setByValues(".//span[starts-with(@class, 'clearSelection')]"));
                        try {
//                            clearValueObj.click();
                            SeleniumFunctions.click(clearValueObj);
                            UtilFunctions.log(fieldName + " - .//span[starts-with(@class, 'clearSelection')]  - Clear Selection Object Clicked.");
                            setHeader = true;
                        } catch (Exception e) {
                            UtilFunctions.log(fieldName + " - .//span[starts-with(@class, 'clearSelection')]  - Clear Selection Object Not Clicked. Exception: " + e.getMessage());
                            setHeader = false;
                            retValue = retValue + "Clear Selection object for " + fieldName + " not retrieved. Test Failing.";
                            UtilFunctions.log(retValue);
                        }
                    }
                }
                if (setHeader) {
                    WebElement textBoxObj = SeleniumFunctions.findElementByWebElement(headerObj, SeleniumFunctions.setByValues(".//input[@type='search' or @type='text'];xpath"));
                    if (textBoxObj == null) {
                        retValue = retValue + "Text Box Object for: " + fieldName + " not found.";
                        UtilFunctions.log("Text box object not found. retValue: " + retValue);
                    } else {
                        textBoxObj.clear();
                        if (!fieldValue.equals("")) {
                            textBoxObj.sendKeys(fieldValue);
                            String menuItemXPath = "//*[normalize-space(./text())='" + fieldValue + "' and ancestor::ul[@role='listbox']]";
                            SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, menuItemXPath + ";xpath");
                            WebElement menuItemObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(menuItemXPath + ";xpath"));
                            if (menuItemObj == null) {
                                UtilFunctions.log("menuItemObj is null. Entered TAB.");
                                textBoxObj.sendKeys(Keys.TAB);
                            } else {
                                menuItemObj.click();
                                UtilFunctions.log("menuItemObj is not null. Clicked menuItemObj.");
                            }
                        } else {
                            //Do nothing
                        }
                    }
                }
            }
        }
        UtilFunctions.log("Returning retValue: " + retValue);
        return retValue;
    }


    /**************************************************************************
     * name: enterCPTCodes(WebDriver driver, String cptCode,
     * String... paneNameArr)
     * functionality: Function used to enter CPT codes
     * param: WebDriver driver - WebDriver object
     * param: String cptCode - CPT code
     * param: String... paneNameArr - Optional parameter to store pane name
     * return: "" if codes entered successfully
     *************************************************************************/
    //TODO: Refactor
    public static String enterCPTCodes(WebDriver driver, String cptCode, String... paneNameArr) throws Throwable {
        UtilFunctions.log("Class: " + patientListPage.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);
        UtilFunctions.log("cptCode: " + cptCode);

        String paneName;
        String retValue = "";
        if (paneNameArr.length > 0) {
            paneName = paneNameArr[0];
            paneName = paneName.replace(" ", "");
        } else {
            paneName = "ChargeEntry";
        }
        UtilFunctions.log("paneName: " + paneName);
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        String paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
        UtilFunctions.log("paneFrames: " + paneFrames);
        SeleniumFunctions.selectFrame(driver, paneFrames, "id");

        String sectionPath = UtilFunctions.getElementFromJSONFile(fileObj, "PANE_SECTIONS.ChargeList", "path");
        String[] codeArr = cptCode.split(";");

        for (int codeLen = 0; codeLen < codeArr.length; codeLen++) {
            String code = codeArr[codeLen];
            String cpt = "";
            String mod = "";
            String qty = "";
            if (code.contains("-")) {
                String[] splitCode = code.split("-");
                cpt = splitCode[0].replace(" ", "");
                mod = splitCode[1].replace(" ", "");

                UtilFunctions.log("code: " + code + " contains '-'");
                UtilFunctions.log("cpt: " + cpt);
                UtilFunctions.log("mod: " + mod);
            } else if (code.contains(":")) {
                String[] splitCode = code.split(":");
                cpt = splitCode[0].replace(" ", "");
                qty = splitCode[1].replace(" ", "");

                UtilFunctions.log("code: " + code + " contains ':'");
                UtilFunctions.log("cpt: " + cpt);
                UtilFunctions.log("qty: " + qty);
            } else {
                cpt = code.replace(" ", "");
                UtilFunctions.log("cpt: " + cpt);
            }

            /**************************************************************************
             * Following setps are performed by the below code:
             * "And I enter \"#{cpt}\" in the \"Charge Search\" field in the
             \"#{pane}\" pane"
             *************************************************************************/
            GlobalStepdefs globalStepsObj = new GlobalStepdefs();
            globalStepsObj.enterInTheField(cpt, "Charge Search", paneName);
            /*************************************************************************/

            if (codeLen > 0 && code.equals(codeArr[codeLen - 1]))
                Thread.sleep(2500);

            if (Page.textExists(driver, cpt, sectionPath, false)) {
                UtilFunctions.log("Text exists.");
                if (!qty.equals("")) {
                    UtilFunctions.log("qty not null. Calling setQtyOnCpt");

                    /**************************************************************************
                     * Following setps are performed by the below code:
                     * "And I set the quantity on the CPT code \"#{cpt}\" to \"#{qty}\""
                     *************************************************************************/
                    PatientListChargesStepdefs patientListChargesStepsObj = new PatientListChargesStepdefs();
                    patientListChargesStepsObj.setQtyOnCpt(cpt, qty);
                    /*************************************************************************/
                }
                if (!mod.equals("")) {
                    UtilFunctions.log("mod not null. Calling addModifierToCPT");

                    /**************************************************************************
                     * Following setps are performed by the below code:
                     * "And I add the modifier \"#{mod}\" to the CPT code \"#{cpt}\""
                     *************************************************************************/
                    PatientListChargesStepdefs patientListChargesStepsObj = new PatientListChargesStepdefs();
                    patientListChargesStepsObj.addModifierToCPT(mod, cpt);
                    /*************************************************************************/
                }
            } else {
                retValue = retValue + "Page does not exist.";
                UtilFunctions.log("Text cpt: " + cpt + " does not exist. Returning retValue: " + retValue);
            }
        }
        return retValue;
    }


    /**************************************************************************
     * name: checkPatientCharges(WebDriver driver, String patientName,
     * String tableName)
     * functionality: Function check and delete patient charges if existing
     * param: WebDriver driver - WebDriver object
     * param: String patientName - Name of patient
     * param: String tableName - Table name
     * return: boolean
     *************************************************************************/
    public static boolean checkPatientCharges(WebDriver driver, String patientName, String tableName) throws InterruptedException {
        UtilFunctions.log("Class: " + patientListPage.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);
        UtilFunctions.log("patientName: " + patientName);
        UtilFunctions.log("tableName: " + tableName);

        if (Page.checkTableExists(driver, tabName, tableName)) {
            int noOfRows = Page.countTableRows(driver, tabName, tableName, null, null);
            UtilFunctions.log("No of rows in table: " + tableName + " is: " + noOfRows);
            GlobalStepdefs globalStepsObj = new GlobalStepdefs();
            for (int rowCnt = 0; rowCnt < noOfRows; rowCnt++) {
                try {
                    globalStepsObj.selectFromTheTable("the first item", tableName);
                    UtilFunctions.log("Clicking Delete button");
                    globalStepsObj.clickButton("Delete", "Charge Detail", null);
                    int maxRetry = 0;
                    while ((!Page.checkElementOnPagePresent(driver, tabName, "Yes", "BUTTONS", "Question")) && (maxRetry < 3)) {
                        maxRetry += 1;
                        UtilFunctions.log("Yes button not present on screen. Clicking Delete button again");
                        globalStepsObj.clickButton("Delete", "Charge Detail", null);
                    }
                    UtilFunctions.log("Clicking Yes button");
                    globalStepsObj.clickButton("Yes", "Question", null);
                    selectPatientByName(Hooks.getDriver(), patientName);
                    selectClinicalNav(Hooks.getDriver(), "Charges");
                    if (!Page.checkTableExists(driver, tabName, tableName))
                        break;
                } catch (Throwable throwable) {
                    throwable.printStackTrace();
                    UtilFunctions.log("Returning false. Exception Throwable: " + throwable.getMessage());
                    return false;
                }
            }
            UtilFunctions.log("Returning true.");
            return true;
        } else {
            System.out.println("No table present");
            UtilFunctions.log("No table present. Returning true.");
            return true;
        }
    }


    /**************************************************************************
     * name: enterICDCodes(WebDriver driver, String paneName, String code)
     * functionality: Function used to enter ICD codes
     * param: WebDriver driver - WebDriver object
     * param: String paneName - Name of pane
     * param: String code - ICD code
     * return: "" if codes entered successfully
     *************************************************************************/
    public static String enterICDCodes(WebDriver driver, String paneName, String code) throws Throwable {
        UtilFunctions.log("Class: " + patientListPage.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);
        UtilFunctions.log("paneName: " + paneName);
        UtilFunctions.log("code: " + code);

        paneName = paneName.replace(" ", "");
        String retValue = "";
        String[] codeArr = code.split(";");
        GlobalStepdefs globalStepsObj = new GlobalStepdefs();
        for (String codeValue : codeArr) {
            codeValue = codeValue.replace(" ", "");
            UtilFunctions.log("codeValue: " + codeValue);
            globalStepsObj.enterInTheField(codeValue, "Diagnosis Search", paneName);
            if (Page.textExists(driver, tabName, codeValue, paneName, "DiagnosisList"))
                retValue += "";
            else
                retValue += "Text does not exists";
        }
        UtilFunctions.log("Returning retValue: " + retValue);
        return retValue;
    }


    /**************************************************************************
     * name: setQtyOnCpt(WebDriver driver, String paneSectionName, String cpt,
     * String qty)
     * functionality: Function used to set qty on cpt
     * param: WebDriver driver - WebDriver object
     * param: String paneSectionName - Name of pane section
     * param: String cpt - CPT code
     * param: String qty - Qty value
     * return: boolean
     *************************************************************************/
    public static boolean setQtyOnCpt(WebDriver driver, String paneSectionName, String cpt, String qty) {
        UtilFunctions.log("Class: " + patientListPage.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);
        UtilFunctions.log("paneSectionName: " + paneSectionName);
        UtilFunctions.log("cpt: " + cpt);
        UtilFunctions.log("qty: " + qty);

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        String sectionPath = UtilFunctions.getElementFromJSONFile(fileObj, "PANE_SECTIONS." + paneSectionName, "path");
        UtilFunctions.log("sectionPath: " + sectionPath);
        SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, sectionPath + ";xpath");
        WebElement sectionObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(sectionPath + ";xpath"));
        if (sectionObj == null) {
            UtilFunctions.log("sectionObj is null. Returning false.");
            return false;
        } else {
            String xPath = "//input[contains(@class, 'chargeQuantity') and ancestor::div[@class='chargeItemsMain' and descendant::*[contains(text(), '" + cpt + "') or contains(@size, '" + cpt + "')]]]";
            UtilFunctions.log("xPath: " + xPath);
            WebElement inputObj = SeleniumFunctions.findElementByWebElement(sectionObj, SeleniumFunctions.setByValues(xPath + ";xpath"));
            if (inputObj == null) {
                UtilFunctions.log("inputObj is null. Returning false.");
                return false;
            } else {
                inputObj.sendKeys(Keys.BACK_SPACE);
                inputObj.click();
                inputObj.clear();
                inputObj.sendKeys(qty);
                UtilFunctions.log("Sent keys: " + qty + ". Returning true.");
                return true;
            }
        }
    }


    /**************************************************************************
     * name: addModifierOnCpt(WebDriver driver, String paneSectionName,
     * String mod, String cpt)
     * functionality: Function used to add modifiers to cpt
     * param: WebDriver driver - WebDriver object
     * param: String paneSectionName - Name of pane section
     * param: String mod - Mod value
     * param: String cpt - CPT code
     * return: boolean
     *************************************************************************/
    public static boolean addModifierOnCpt(WebDriver driver, String paneSectionName, String mod, String cpt) {
        UtilFunctions.log("Class: " + patientListPage.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);
        UtilFunctions.log("paneSectionName: " + paneSectionName);
        UtilFunctions.log("cpt: " + cpt);
        UtilFunctions.log("mod: " + mod);

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        String sectionPath = UtilFunctions.getElementFromJSONFile(fileObj, "PANE_SECTIONS." + paneSectionName, "path");
        SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, sectionPath + ";xpath");
        WebElement sectionObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(sectionPath + ";xpath"));
        if (sectionObj == null) {
            UtilFunctions.log("sectionObj is null. Returning false.");
            return false;
        } else {
            String xPath = "//a[contains(@class, 'addModifierLink') and ancestor::div[@class='chargeSecondRow' and preceding-sibling::div[@class='chargeItemsMain' and descendant::div[contains(@class, 'chargeCode') and contains(text(), '" + cpt + "')]]]]";
            UtilFunctions.log("xPath: " + xPath);
            WebElement modListLinkObj = SeleniumFunctions.findElementByWebElement(sectionObj, SeleniumFunctions.setByValues(xPath + ";xpath"));
            if (modListLinkObj == null) {
                UtilFunctions.log("modListLinkObj is null. Returning false.");
                return false;
            } else {
                try {
                    Thread.sleep(1000);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                modListLinkObj.click();
                try {
                    Thread.sleep(1000);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                String modSectionPath = UtilFunctions.getElementFromJSONFile(fileObj, "PANE_SECTIONS." + "ModifierList", "path");
                SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, modSectionPath + ";xpath");
                WebElement modSectionObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(modSectionPath + ";xpath"));

                //New addition to check whether pop-up of modifier window exists or not!///////////////////////
                int modSectionCnt = 0;
                try {
                    while (modSectionObj == null || !modSectionObj.isDisplayed()) {
                        modSectionCnt++;
                        modListLinkObj.click();
                        SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, modSectionPath + ";xpath");
                        modSectionObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(modSectionPath + ";xpath"));
                        if (modSectionCnt > GlobalConstants.FIVE)
                            break;
                    }
                } catch (StaleElementReferenceException se) {
                    modListLinkObj.click();
                    modSectionObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(modSectionPath + ";xpath"));
                }
                //////////////////////////////////////////////////////////////////////////////////////////////

                if (modSectionObj == null) {
                    UtilFunctions.log("modSectionObj is null. Returning false.");
                    return false;
                } else {
                    String modPath = "//a[@class='code' and text()='" + mod + "']";
                    UtilFunctions.log("modPath: " + modPath);
                    WebElement modLinkObj = SeleniumFunctions.findElementByWebElement(modSectionObj, SeleniumFunctions.setByValues(modPath + ";xpath"));
                    if (modLinkObj == null) {
                        UtilFunctions.log("modLinkObj is null. Returning false.");
                        return false;
                    } else {
                        modLinkObj.click();
                        Actions action = new Actions(driver);
                        action.sendKeys(Keys.ESCAPE).build().perform();
                        UtilFunctions.log("Returning true.");
                        return true;
                    }
                }
            }
        }
    }


    /**************************************************************************
     * name: removeCodesFromDiagnosisList(WebDriver driver, String code,
     * String paneName)
     * functionality: Function used to delete codes from diagnostic list
     * param: WebDriver driver - WebDriver object
     * param: String code - Code to be removed
     * param: String paneName - Pane name
     * return: boolean
     *************************************************************************/
    public static boolean removeCodesFromDiagnosisList(WebDriver driver, String code, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + patientListPage.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);
        UtilFunctions.log("CodeName: " + code);
        UtilFunctions.log("PaneName: " + paneName);

        if (paneName == null)
            paneName = "ChargeEntry";

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        String paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName.replace(" ", ""), "frame"));
        UtilFunctions.log("PaneFrames: " + paneFrames);
        SeleniumFunctions.selectFrame(driver, paneFrames, "id");

        WebElement headerPageObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//div[@class='header_info']" + ";xpath"));
        while (!headerPageObj.isDisplayed())
            headerPageObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//div[@class='header_info']" + ";xpath"));

        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        globalStepdefs.clickMiscElement("Diagnoses", null, paneName, null);

        String sectionPath = UtilFunctions.getElementFromJSONFile(fileObj, "PANE_SECTIONS." + "DiagnosisList", "path");
        if (code == null) {
            while (!Page.textExists(driver, tabName, "No Diagnoses", paneName, "DiagnosisList")) {
                WebElement diagnosisList = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(sectionPath + ";xpath"));
                if (diagnosisList == null) {
                    UtilFunctions.log("Diagnosis list element not present. Returning false.");
                    return false;
                } else {
                    WebElement trash = SeleniumFunctions.findElementByWebElement(diagnosisList, SeleniumFunctions.setByValues(".//div[starts-with(@class, 'delDx')]" + ";xpath"));
                    if (trash == null) {
                        UtilFunctions.log("Trash element not present. Returning false.");
                        return false;
                    } else
                        trash.click();
                }
            }
        } else {
            String[] codeArr = code.split(";");
            for (String codeValue : codeArr) {
                WebElement diagnosisList = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(sectionPath + ";xpath"));
                if (diagnosisList == null) {
                    UtilFunctions.log("Diagnosis list element not present. Returning false.");
                    return false;
                } else {
                    WebElement diagnosisItemMain = SeleniumFunctions.findElementByWebElement(diagnosisList, SeleniumFunctions.setByValues(".//div[starts-with(@class, 'dxItem') and descendant::span[starts-with(@class,'dx') and text()='" + codeValue + "']]" + ";xpath"));
                    if (diagnosisItemMain == null) {
                        UtilFunctions.log("Diagnosis code element not present. Returning false.");
                        return false;
                    } else {
                        WebElement trash = SeleniumFunctions.findElementByWebElement(diagnosisItemMain, SeleniumFunctions.setByValues(".//div[starts-with(@class, 'delDx')]" + ";xpath"));
                        if (trash == null) {
                            UtilFunctions.log("Trash element not present. Returning false.");
                            return false;
                        } else
                            trash.click();
                    }
                }
            }
        }

        return true;
    }


    /**************************************************************************
     * Function used to delete codes from CPT list
     *
     * @param driver WebDriver object
     * @param code code to be removed
     * @param paneName pane name
     * @return boolean
     *************************************************************************/
    public static boolean removeCodesFromChargeList(WebDriver driver, String code, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + patientListPage.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);
        UtilFunctions.log("CodeName: " + code);
        UtilFunctions.log("PaneName: " + paneName);

        if (paneName == null)
            paneName = "ChargeEntry";

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        String paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName.replace(" ", ""), "frame"));
        UtilFunctions.log("PaneFrames: " + paneFrames);
        SeleniumFunctions.selectFrame(driver, paneFrames, "id");

        WebElement headerPageObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//div[@class='header_info']" + ";xpath"));
        while (!headerPageObj.isDisplayed())
            headerPageObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//div[@class='header_info']" + ";xpath"));

        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        globalStepdefs.clickMiscElement("Diagnoses", null, paneName, null);

        String sectionPath = UtilFunctions.getElementFromJSONFile(fileObj, "PANE_SECTIONS." + "ChargeList", "path");
        if (code == null) {
            while (!Page.textExists(driver, tabName, "No Charges", paneName, "ChargeList")) {
                WebElement chargeList = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(sectionPath + ";xpath"));
                if (chargeList == null) {
                    UtilFunctions.log("Charges list element not present. Returning false.");
                    return false;
                } else {
                    WebElement trash = SeleniumFunctions.findElementByWebElement(chargeList, SeleniumFunctions.setByValues(".//div[starts-with(@class, 'delCharge')]" + ";xpath"));
                    if (trash == null) {
                        UtilFunctions.log("Trash element not present. Returning false.");
                        return false;
                    } else
                        trash.click();
                }
            }
        } else {
            String[] codeArr = code.split(";");
            for (String codeValue : codeArr) {
                WebElement chargeList = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(sectionPath + ";xpath"));
                if (chargeList == null) {
                    UtilFunctions.log("Charges list element not present. Returning false.");
                    return false;
                } else {
                    WebElement chargesItemMain = SeleniumFunctions.findElementByWebElement(chargeList, SeleniumFunctions.setByValues(".//div[starts-with(@class, 'chargeItem') and descendant::div[boolean(text())='" + codeValue + "']]" + ";xpath"));
                    if (chargesItemMain == null) {
                        UtilFunctions.log("Charges code element not present. Returning false.");
                        return false;
                    } else {
                        WebElement trash = SeleniumFunctions.findElementByWebElement(chargesItemMain, SeleniumFunctions.setByValues(".//div[starts-with(@class, 'delCharge')]" + ";xpath"));
                        if (trash == null) {
                            UtilFunctions.log("Trash element not present. Returning false.");
                            return false;
                        } else
                            trash.click();
                    }
                }
            }
        }
        return true;
    }


    /**************************************************************************
     * name: selectCodeInListInSearchSection(WebDriver driver, String value,
     * String valueType, String list, String listType, String section,
     * String paneName)
     * functionality: Search and select code in search section list
     * param: WebDriver driver - WebDriver object
     * param: String value - Value to be selected
     * param: String valueType - Type of code
     * param: String list - List containing the code
     * param: String listType - List type
     * param: String section - Section name
     * param: String paneName - Pane name
     * return: boolean
     *************************************************************************/
    public static boolean selectCodeInListInSearchSection(WebDriver driver, String value, String valueType, String list, String listType, String section, String paneName) {
        UtilFunctions.log("Class: " + patientListPage.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);

        if (paneName == null)
            paneName = "ChargeEntry";
        value = UtilFunctions.convertThruRegEx(value);

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        String paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName.replace(" ", ""), "frame"));
        String sectionPath = UtilFunctions.getElementFromJSONFile(fileObj, "PANE_SECTIONS." + section.replace(" ", ""), "path");
        UtilFunctions.log("PaneFrames: " + paneFrames);
        SeleniumFunctions.selectFrame(driver, paneFrames, "id");

        String listSectionXPath;
        expandListInSearchSection(driver, list, listType, section, paneName);
        SeleniumFunctions.explicitWait(driver, GlobalConstants.FIVE, sectionPath + ";xpath");
        WebElement sectionElement = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(sectionPath + ";xpath"));
        if (sectionElement == null) {
            UtilFunctions.log("Section: " + section + " object is null. Returning false.");
            return false;
        } else {
            if (listType == null)
                listSectionXPath = ".//div[@class='collapsible_group' and descendant::span[text()='" + list + "']]";
            else
                listSectionXPath = ".//div[@class='collapsible_group' and descendant::span[text()='" + list + "'] and ancestor::div[@class='custom_groups_container ui-sortable']]";
            WebElement listElement = SeleniumFunctions.findElementByWebElement(sectionElement, SeleniumFunctions.setByValues(listSectionXPath + ";xpath"));
            if (listElement == null) {
                UtilFunctions.log("Section: " + section + " object is null. Returning false.");
                return false;
            } else {
                WebElement codeElt;
                if (valueType == null) {
                    codeElt = SeleniumFunctions.findElementByWebElement(listElement, SeleniumFunctions.setByValues(".//span[@class='code_text' and text()= '" + value + "']" + ";xpath"));
                    int codeEltCnt = 0;
                    while (codeElt == null) {
                        codeEltCnt++;
                        codeElt = SeleniumFunctions.findElementByWebElement(listElement, SeleniumFunctions.setByValues(".//span[@class='code_text' and text()= '" + value + "']" + ";xpath"));
                        if (codeEltCnt > GlobalConstants.FIVE)
                            break;
                    }
                } else {
                    codeElt = SeleniumFunctions.findElementByWebElement(listElement, SeleniumFunctions.setByValues(".//span[contains(normalize-space(), '" + value + "')]" + ";xpath"));
                    int codeEltCnt = 0;
                    while (codeElt == null) {
                        codeEltCnt++;
                        codeElt = SeleniumFunctions.findElementByWebElement(listElement, SeleniumFunctions.setByValues(".//span[contains(normalize-space(), '" + value + "')]" + ";xpath"));
                        if (codeEltCnt > GlobalConstants.FIVE)
                            break;
                    }
                }
                if (codeElt == null) {
                    UtilFunctions.log("Code: " + value + " object is null. Returning false.");
                    return false;
                } else {
                    codeElt.click();
                    UtilFunctions.log("Code: " + value + " object present and clicked. Returning true.");
                    return true;
                }
            }
        }

    }


    /**************************************************************************
     * name: expandListInSearchSection(WebDriver driver, String list,
     * String listType, String section, String paneName)
     * functionality: Expands the list container if not already expanded
     * param: WebDriver driver - WebDriver object
     * param: String list - List containing the code
     * param: String listType - List type
     * param: String section - Section name
     * param: String paneName - Pane name
     * return: void
     *************************************************************************/
    public static void expandListInSearchSection(WebDriver driver, String list, String listType, String section, String paneName) {
        UtilFunctions.log("Class: " + patientListPage.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);

        if (paneName == null)
            paneName = "ChargeEntry";

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        String paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName.replace(" ", ""), "frame"));
        String sectionPath = UtilFunctions.getElementFromJSONFile(fileObj, "PANE_SECTIONS." + section.replace(" ", ""), "path");
        UtilFunctions.log("PaneFrames: " + paneFrames);
        UtilFunctions.log("SectionPath: " + sectionPath);
        SeleniumFunctions.selectFrame(driver, paneFrames, "id");

        SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, "//div[@id='dx_charge_accordion_container']" + ";xpath");
        WebElement pageLoadObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//div[@id='dx_charge_accordion_container']" + ";xpath"));
        while (!pageLoadObj.isDisplayed())
            pageLoadObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//div[@id='dx_charge_accordion_container']" + ";xpath"));

        SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, "//h3[descendant::span[text()='" + section + "']]" + ";xpath");
        WebElement sectionHeader = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//h3[descendant::span[text()='" + section + "']]" + ";xpath"));
        if (sectionHeader == null)
            UtilFunctions.log("sectionHeader object is null.");
        else {
            WebElement collapseIcon = SeleniumFunctions.findElementByWebElement(sectionHeader, SeleniumFunctions.setByValues(".//span[@class='ui-icon ui-icon-triangle-1-e']" + ";xpath"));
            if (collapseIcon == null)
                UtilFunctions.log("collapseIcon object is null. List already expanded.");
            else {
                collapseIcon.click();
                try {
                    Thread.sleep(1000);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                collapseIcon = SeleniumFunctions.findElementByWebElement(sectionHeader, SeleniumFunctions.setByValues(".//span[@class='ui-icon ui-icon-triangle-1-e']" + ";xpath"));
                int whileCounter1 = 0;
                while (collapseIcon != null) {
                    whileCounter1++;
                    collapseIcon.click();
                    try {
                        Thread.sleep(2000);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                    collapseIcon = SeleniumFunctions.findElementByWebElement(sectionHeader, SeleniumFunctions.setByValues(".//span[@class='ui-icon ui-icon-triangle-1-e']" + ";xpath"));
                    if (whileCounter1 > GlobalConstants.FIVE)
                        break;
                }
                UtilFunctions.log("Clicked the collapseIcon object to expand list.");
            }
        }

        SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, sectionPath + ";xpath");
        WebElement sectionTree = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(sectionPath + ";xpath"));
        if (sectionTree == null)
            UtilFunctions.log("sectionTree object is null.");
        else {
            String listXPath;
            if (listType == null)
                listXPath = ".//div[@class='collapsible_group' and descendant::span[text()='" + list + "']]";
            else
                listXPath = ".//div[@class='collapsible_group' and descendant::span[text()='" + list + "'] and ancestor::div[@class='custom_groups_container ui-sortable']]";
            WebElement listObj = SeleniumFunctions.findElementByWebElement(sectionTree, SeleniumFunctions.setByValues(listXPath + ";xpath"));
            if (listObj == null)
                UtilFunctions.log("listObj object is null. List already expanded.");
            else {
                WebElement collapseIcon = SeleniumFunctions.findElementByWebElement(listObj, SeleniumFunctions.setByValues(".//span[@class='list_header_collapse_icon ui-icon ui-icon-triangle-1-e']" + ";xpath"));
                if (collapseIcon == null)
                    UtilFunctions.log("collapseIcon object is null. List already expanded.");
                else {
                    collapseIcon.click();
                    try {
                        Thread.sleep(1000);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                    collapseIcon = SeleniumFunctions.findElementByWebElement(listObj, SeleniumFunctions.setByValues(".//span[@class='list_header_collapse_icon ui-icon ui-icon-triangle-1-e']" + ";xpath"));
                    int whileCounter2 = 0;
                    while (collapseIcon != null) {
                        whileCounter2++;
                        collapseIcon.click();
                        try {
                            Thread.sleep(2000);
                        } catch (InterruptedException e) {
                            e.printStackTrace();
                        }
                        collapseIcon = SeleniumFunctions.findElementByWebElement(listObj, SeleniumFunctions.setByValues(".//span[@class='list_header_collapse_icon ui-icon ui-icon-triangle-1-e']" + ";xpath"));
                        if (whileCounter2 > GlobalConstants.FIVE)
                            break;
                    }
                    UtilFunctions.log("Clicked the collapseIcon object to expand list.");
                }
            }
        }
    }


    /**************************************************************************
     * name: expandInSearchSection(WebDriver driver, String operation,
     * String sectionName, String paneName)
     * functionality: Expands/Collapse the section based on the operation
     * param: WebDriver driver - WebDriver object
     * param: String operation - Operation name (Expand/Collapse)
     * param: String sectionName - Section name
     * param: String paneName - Pane name
     * return: void
     *************************************************************************/
    public static void expandInSearchSection(WebDriver driver, String operation, String sectionName, String paneName) {
        UtilFunctions.log("Class: " + patientListPage.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);

        if (paneName == null)
            paneName = "ChargeEntry";

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        String paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName.replace(" ", ""), "frame"));
        UtilFunctions.log("PaneFrames: " + paneFrames);
        SeleniumFunctions.selectFrame(driver, paneFrames, "id");

        SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, "//div[@id='dx_charge_accordion_container']" + ";xpath");
        WebElement pageLoadObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//div[@id='dx_charge_accordion_container']" + ";xpath"));
        while (!pageLoadObj.isDisplayed())
            pageLoadObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//div[@id='dx_charge_accordion_container']" + ";xpath"));

        SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, "//h3[descendant::span[text()='" + sectionName + "']]" + ";xpath");
        WebElement sectionHeader = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//h3[descendant::span[text()='" + sectionName + "']]" + ";xpath"));
        if (sectionHeader == null)
            UtilFunctions.log("sectionHeader object is null.");
        else {
            WebElement collapseIcon = SeleniumFunctions.findElementByWebElement(sectionHeader, SeleniumFunctions.setByValues(".//span[starts-with(@class, 'ui-icon ui-icon-triangle-1-')]" + ";xpath"));
            if (collapseIcon == null)
                UtilFunctions.log("CollapseIcon object is null.");
            else {
                if (operation.equals("expand") && collapseIcon.getAttribute("class").contains("-e")) {
                    collapseIcon.click();
                    UtilFunctions.log("Clicked the collapseIcon object to expand list.");
                } else if (operation.equals("collapse") && collapseIcon.getAttribute("class").contains("-s")) {
                    collapseIcon.click();
                    UtilFunctions.log("Clicked the collapseIcon object to collapse list.");
                }
            }
        }
    }


    /**
     * selectNoteWriterTemplate(String templateName, String paneName)
     * functionality: Select a note template from the "Write A Note" accordion/toggle and click to open the template
     *
     * @param templateName -- type of note to be selected, e.g. "Progress Note"
     * @param paneName     -- name of pane that the "Write A Note" toggle/accordion is in (optional, pass in null)
     * @return true if the right note type was selected and the template pane opened, otherwise false
     */
    public static boolean selectNoteWriterTemplate(String templateName, String paneName, String autoPopout) {
        UtilFunctions.log("Class: " + patientListPage.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + ": Start");

        String tabName = GlobalStepdefs.curTabName;
        WebDriver driver = Hooks.getDriver();
        UtilFunctions.log("Current tab name: " + tabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);

        String paneFrames = null;
        //If no paneName is passed in, assumes you're on the Patient List tab and the frame is: "FRAME_NOTEWRITER_MAIN"
        //If you're unsure which tab or frame you need, pass in a paneName
        if (paneName == null) {
            paneFrames = UtilFunctions.getFrameValue(frameMap, "FRAME_NOTEWRITER_MAIN");
        } else {//pass in a Pane Name for other tabs like Patient Search tab
            paneName = paneName.replace(" ", "");
            JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
            paneFrames = UtilFunctions.getFrameValue(frameMap,
                    UtilFunctions.getElementFromJSONFile(fileObj, "PANES." +
                            paneName, "frame"));
        }
        UtilFunctions.log("PaneFrames: " + paneFrames);
        System.out.println("PaneFrames: " + paneFrames);
        //Wait for the pane to display
        SeleniumFunctions.explicitWait(driver, GlobalConstants.TWO, paneFrames + ";id");
        SeleniumFunctions.selectFrame(driver, paneFrames, "id");

        //Verify the "Write A Note" toggle is open before selecting a NW template
        if (Page.toggleIsOpen("WriteANote", tabName, "is", paneName)) {
            UtilFunctions.sleep(500);
            WebElement noteEle = SeleniumFunctions.findElement(driver,
                    SeleniumFunctions.setByValues("//li[@class='mdl-list__item pk-nw-mdl-list-item' and " +
                            "child::span[text()='" + templateName + "']]" + ";xpath"));
            if (noteEle != null) {
                noteEle.click();
                UtilFunctions.sleep(1000);
                if (autoPopout == null) {
                    try {
                        //check that the template opened
                        //StaleElementReference occurs if note auto-pops out on creation.  checkIfElementExists is never true
                        if (!(Page.checkIfElementExists(driver, "//div[@id='WIZARDFRAMES']", ";xpath"))) {
                            SeleniumFunctions.click(noteEle);
                            UtilFunctions.sleep(1000);
                            if (!(Page.checkIfElementExists(driver, "//div[@id='WIZARDFRAMES']", ";xpath"))) {
                                Actions actions = new Actions(driver);
                                actions.moveToElement(noteEle).click().build().perform();
                                UtilFunctions.sleep(1000);
                            }
                        }
                        return Page.checkIfElementExists(driver, "//div[@id='WIZARDFRAMES']", ";xpath");

                    } catch (ElementNotInteractableException e) {
                        UtilFunctions.log(templateName + " not selected due to exception: " + e.getMessage() +
                                ".  Trying again.");
                        SeleniumFunctions.click(noteEle);
                        UtilFunctions.sleep(1000);
                        if (!(Page.checkIfElementExists(driver, "//div[@id='WIZARDFRAMES']", ";xpath"))) {
                            Actions actions = new Actions(driver);
                            actions.moveToElement(noteEle).click().build().perform();
                            UtilFunctions.sleep(1000);
                        }
                        return Page.checkIfElementExists(driver, "//div[@id='WIZARDFRAMES']", ";xpath");
                    }
                } else {
                    SeleniumFunctions.switchToNWPopoutWindow(Hooks.getDriver());
                    return true;
                }

            } else {
                UtilFunctions.log(templateName + " NW template is NULL and not found.  Returning false...");
                System.out.println(templateName + " NW template is NULL and not found.  Returning false...");
                UtilFunctions.log("Class: " + patientListPage.className + "; Method: " + new Object() {
                }.getClass().getEnclosingMethod().getName() + ": Complete");
                return false;
            }//end if(noteEle != null)
        }//end if "Write A Note" toggle is open

        UtilFunctions.log("The 'WriteANote' toggle/accordion would not open. A NW template can't be selected.  Returning false... ");
        System.out.println("The 'WriteANote' toggle/accordion would not open. A NW template can't be selected.  Returning false... ");
        UtilFunctions.log("Class: " + patientListPage.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + ": Complete");
        return false;
    }


    /**
     * findNoteWriterTemplate(String templateName, String paneName)
     * functionality: Finds a note template/note type in the "Write A Note" toggle/accordion's list, but doesn't click on/open it
     *
     * @param templateName -- type of note to be found, e.g. "Progress Note"
     * @param paneName     -- name of pane that the "Write A Note" toggle/accordion is in (optional, pass in null)
     * @return WebElement -- note template element, if found, otherwise null
     */
    public static WebElement findNoteWriterTemplate(String templateName, String paneName) {
        UtilFunctions.log("Class: " + patientListPage.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        String tabName = GlobalStepdefs.curTabName;
        UtilFunctions.log("Current tab name: " + tabName);
        WebDriver driver = Hooks.getDriver();
        UtilFunctions.log("Current tab name: " + tabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);

        String paneFrames = null;
        //If no paneName is passed in, assumes you're on the Patient List tab and the frame is: "FRAME_NOTEWRITER_MAIN"
        //If you're unsure which tab or frame you need, pass in a paneName
        if (paneName == null) {
            paneFrames = UtilFunctions.getFrameValue(frameMap, "FRAME_NOTEWRITER_MAIN");
        } else {//pass in a Pane Name for other tabs like Patient Search tab
            paneName = paneName.replace(" ", "");
            JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
            paneFrames = UtilFunctions.getFrameValue(frameMap,
                    UtilFunctions.getElementFromJSONFile(fileObj, "PANES." +
                            paneName, "frame"));
        }
        UtilFunctions.log("PaneFrames: " + paneFrames);
        System.out.println("PaneFrames: " + paneFrames);
        //Wait for the pane to display
        SeleniumFunctions.explicitWait(driver, GlobalConstants.TWO, paneFrames + ";id");
        SeleniumFunctions.selectFrame(driver, paneFrames, "id");

        //First, verify the "Write A Note" toggle is open
        if (Page.toggleIsOpen("WriteANote", tabName, "is", paneName)) {
            WebElement noteEle = null;
            //try to find note template twice; break if found 1st time.
            for (int i = 0; i < GlobalConstants.TWO; ++i) {
                noteEle = SeleniumFunctions.findElement(driver,
                        SeleniumFunctions.setByValues("//li[@class='mdl-list__item pk-nw-mdl-list-item' and " +
                                "child::span[text()='" + templateName + "']]" + ";xpath"));
                if (noteEle != null)
                    break;
            }
            return noteEle;
        }

        UtilFunctions.log("The 'WriteANote' toggle/accordion would not open. A NW template can't be found.  Returning null... ");
        System.out.println("The 'WriteANote' toggle/accordion would not open. A NW template can't be found.  Returning null... ");
        UtilFunctions.log("Class: " + patientListPage.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + ": Complete");
        return null;
    }


    /**
     * name: getPatientID(WebDriver driver, String name)
     * functionality: Get the patient ID from patient name
     *
     * @param driver      -- WebDriver driver - WebDriver object
     * @param patientName
     * @return patient ID in String format or null if not found
     * @throws Throwable
     */
    public static String getPatientID(WebDriver driver, String patientName) throws Throwable {
        UtilFunctions.log("Class: " + patientListPage.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);

        if (patientName != null && !patientName.equals("")) {
            selectPatientByName(driver, patientName);
        }
        //Get the current Clinical Nav selection that you're on so you can switch back to it after getting the patient ID
        // from the Patient Detail screen
        String clinNavSelection = getClinicalNav(driver, "");
        if (clinNavSelection == null) {
            UtilFunctions.log("The current Clinical Nav selection couldn't be found. Returning null...");
            System.out.println("The current Clinical Nav selection couldn't be found. Returning null...");
            return null;
        }
        clinNavSelection = clinNavSelection.trim();
        UtilFunctions.log("ClinNavSelection starting point: " + clinNavSelection);
        System.out.println("ClinNavSelection starting point: " + clinNavSelection);

        //Switch to "Patient Detail" in the Clinical Nav, if not already on it.
        if (!(clinNavSelection.equalsIgnoreCase("Patient Detail"))) {
            selectClinicalNav(driver, "Patient Detail");
        }
        //Ensure you're on the "FRAME_PATDETAIL"
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        String paneFrames = UtilFunctions.getFrameValue(frameMap, "FRAME_PATDETAIL");
        SeleniumFunctions.selectFrame(driver, paneFrames, "id");

        WebElement patIdElement = SeleniumFunctions.findElement(Hooks.getDriver(),
                By.xpath("//td[(preceding-sibling::td[@class='fieldLabel' and child::*[contains(text(), 'PK Patient Key')]]) " +
                        "and (following-sibling::td[@class='fieldLabel' and child::*[contains(text(), 'PK Visit Key')]])]"));

        String patID = null;
        if (patIdElement != null) {
            patID = patIdElement.getText().trim();
        }

        //Switch back to the Clinical Nav you were on before switching to "Patient Detail", if you didn't start on "Patient Detail"
        if (!(clinNavSelection.equalsIgnoreCase("Patient Detail"))) {
            Thread.sleep(1000);
            selectClinicalNav(driver, clinNavSelection);
            Thread.sleep(1000);
        }

        return patID;
    }


    /**************************************************************************
     * name: checkClinicalNav(WebDriver driver,String selectName)
     * functionality: To check if the Clinical Navigations exists
     * param: WebDriver driver - WebDriver object
     * param: String selectName - - Name of clinical item to select
     * return: clinical navigation item text
     *************************************************************************/
    public static boolean checkClinicalNav(WebDriver driver, String selectName) {
        UtilFunctions.log("Class: " + patientListPage.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);
        UtilFunctions.log("Clinical Select name: " + selectName);

        String curFrame = PatientList_Frames.patientListFramesMap.get("FRAME_CLINNAV");
        SeleniumFunctions.selectFrame(driver, curFrame, "id");

        UtilFunctions.log("paneFrames: " + curFrame);

        return checkIfLinkExists(driver, selectName);
    }

    /**************************************************************************
     * name: checkIfPatientExists(WebDriver driver, String text, String tag,
     * String section)
     * functionality: Function to check if the patient is on the patient list
     * param: WebDriver driver - WebDriver object
     * param: String text - Name of patient
     * param: String section - Section of xpath value
     * return: returns True if the link text exists else false
     *************************************************************************/
    public static boolean checkIfPatientExists(WebDriver driver, String patientName) {
        UtilFunctions.log("Patient Name: " + patientName + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        return findPatientByName(driver, patientName) != null;
    }

    /**************************************************************************
     * name: checkCountOfFormularyAndNonFormularyListItems(String min1, String numItems1, String min2, String numItems2
     * functionality: validate count of formulary and non formulary list items with the value passed
     * param: WebDriver driver - WebDriver object
     * param: String name - min1(atleast in formulary)
     * param: numItems1(no.items atleast in formulary list)
     * param: min2(atleast in non-formulary),numItems2(no.items atleast in non-formulary list)
     * return: void
     *************************************************************************/
    public static void checkCountOfFormularyAndNonFormularyListItems(String min1, String numItems1, String min2, String numItems2) throws Throwable {
        UtilFunctions.log("Class: " + patientListPage.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);

        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
        String paneFrames = "FRAME_EDITORDER";
        paneFrames = UtilFunctions.getFrameValue(frameMap, paneFrames);
        UtilFunctions.log("PaneFrames: " + paneFrames);
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");
        List<WebElement> formulary = SeleniumFunctions.findElements(Hooks.getDriver(), SeleniumFunctions.setByValues(".//div[@id='SearchResults-LHSMed']//tr[@category='Medication']"));
        List<WebElement> nonformulary = SeleniumFunctions.findElements(Hooks.getDriver(), SeleniumFunctions.setByValues(".//div[@id='SearchResults-RHSMed']//tr[@category='Medication']"));
        if (min1 == null) {
            nonformulary.size();
            UtilFunctions.log("No. of nonformulary list items: " + nonformulary.size());

            nonformulary.equals(numItems2);
        } else {
            int size = formulary.size();
            int val = Integer.parseInt(numItems1);
            Assert.assertTrue("No. of Items expected' " + val + "'" + "But Formulary list contains' " + size + "'", size >= val);
        }
        if (min2 == null) {
            formulary.size();
            UtilFunctions.log("No. of formulary list items: " + formulary.size());
            formulary.equals(numItems1);
        } else {
            nonformulary.size();
            nonformulary.equals(numItems2);
        }

    }

    /**************************************************************************
     * name: selectCPOETab(WebDriver driver, String tabName, String paneName)
     * functionality: To select the CPOE tabs
     * param: WebDriver driver - WebDriver object
     * param: String tabName - name of the tab
     * paneName: String tabName - name of the Pane
     * return: void
     *************************************************************************/
    public static void selectCPOETab(WebDriver driver, String tabName, String paneName) {
        UtilFunctions.log("Class: " + patientListPage.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);
        tabName = tabName.replace(" ", "");
        String paneFrames;
        int count = 0;
        int maxTries = 2;
        boolean first = true;

        try {
            JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName("PatientList");
            HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
            String[] elementType = UtilFunctions.getElementStringAndType(fileObj, "CPOE_ORDER_TABS." + tabName);
            String path = elementType[0];
            String method = elementType[1];
            if (StringUtils.isEmpty(paneName)) {
                paneFrames = "FRAME_EDITORDER";
                paneFrames = UtilFunctions.getFrameValue(frameMap, paneFrames);
                UtilFunctions.log("PaneFrames: " + paneFrames);
                SeleniumFunctions.selectFrame(driver, paneFrames, "id");
//                        SeleniumFunctions.selectFrame(Hooks.getDriver(), "FRAME_EDITORDER", "id");
            } else {
                paneName = paneName.replace(" ", "");
                paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName.replace(" ", ""), "frame"));
                SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");
            }

//                    SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, path+ ";" + method);
            String tab = UtilFunctions.getElementFromJSONFile(fileObj, "CPOE_ORDER_TABS." + tabName, "path");
            String tabText = "//div[@role='tab' and child::" + tab + "]";

            WebElement tabElt = SeleniumFunctions.findElement(Hooks.getDriver(), By.xpath(tabText));

            if (tabElt != null) {
                tabElt.click();
            }
        } catch (Exception e) {
            if (first)
                first = false;
            if (++count == maxTries) throw e;
        }
    }

    /**************************************************************************
     * Verify text appears in billArea
     *
     * @param driver WebDriver object
     * @param text text to verify
     * @return boolean
     *************************************************************************/
    public static boolean textAppears(WebDriver driver, String text, String... listName) throws InterruptedException {
        UtilFunctions.log("Class: " + patientListPage.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);

        UtilFunctions.log("text: " + text);

        String paneFrameName = "FRAME_POPUP_CONTENTS";
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        paneFrameName = UtilFunctions.getFrameValue(frameMap, paneFrameName);
        UtilFunctions.log("PaneFrames: " + paneFrameName);
        SeleniumFunctions.selectFrame(driver, paneFrameName, "id");

        SeleniumFunctions.explicitWait(driver, GlobalConstants.ONE, "//*[normalize-space(./text())='" + text + "' and ancestor::ul[@role='listbox']]" + ";xpath");
        WebElement textObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//*[normalize-space(./text())='" + text + "' and ancestor::ul[@role='listbox']]"));

        if (textObj == null) {
            return false;
        }
        return true;

    }

    /**************************************************************************
     * Click button in header section
     *
     * @param driver WebDriver object
     * @param buttonName button to click
     * @param headName   header name
     * @param paneName   pane name
     * @return boolean
     *************************************************************************/
    public static boolean clickButtonInHeaderSection(WebDriver driver, String buttonName, String headName, String paneName) throws InterruptedException {
        UtilFunctions.log("Class: " + patientListPage.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);

        UtilFunctions.log("buttonName: " + buttonName);
        UtilFunctions.log("headName: " + headName);

        if (paneName == null) {
            paneName = "ChargeEntry";
        }
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        String paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName.replace(" ", ""), "frame"));
        UtilFunctions.log("PaneFrames: " + paneFrames);
        SeleniumFunctions.selectFrame(driver, paneFrames, "id");

        WebElement feaderObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(".//div[@class='header_info' and descendant::span[text()='" + headName + "']]" + ";xpath"));
        if (feaderObj == null) {
            UtilFunctions.log("Header object is null.");
            return false;
        } else {
            WebElement collapseIcon = SeleniumFunctions.findElementByWebElement(feaderObj, SeleniumFunctions.setByValues(".//button[starts-with(@class, '" + buttonName + "')]" + ";xpath"));
            collapseIcon.click();
        }
        return true;
    }


    /**************************************************************************
     * check searchList loaded or not
     *
     * @param driver WebDriver object
     * @return boolean
     *************************************************************************/
    public static boolean searchListLoad(WebDriver driver) throws InterruptedException {
        UtilFunctions.log("Class: " + patientListPage.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);


        String paneFrameName = "FRAME_POPUP_CONTENTS";
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        paneFrameName = UtilFunctions.getFrameValue(frameMap, paneFrameName);
        UtilFunctions.log("PaneFrames: " + paneFrameName);
        SeleniumFunctions.selectFrame(driver, paneFrameName, "id");

        SeleniumFunctions.explicitWait(driver, GlobalConstants.ONE, "//ul[@role='listbox']" + ";xpath");
        WebElement searchList = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//ul[@role='listbox']"));
        if (searchList == null) {
            return false;
        }
        return searchList.isDisplayed();
    }

    /**************************************************************************
     * name: checkIfPatientExists(WebDriver driver, String text, String tag,
     * String section)
     * functionality: Function to check if the patient is on the patient list
     * param: WebDriver driver - WebDriver object
     * param: String text - Name of patient
     * param: String section - Section of xpath value
     * return: returns True if the link text exists else false
     *************************************************************************/
    public static int getNumPatients(String tableType) {
        UtilFunctions.log("Patient Name: " + tableType + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        String tabName = GlobalStepdefs.curTabName;
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        String paneFrames;
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        if (StringUtils.isEmpty(tableType)) {
            SeleniumFunctions.selectFrame(Hooks.getDriver(), UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(tabName, "", "", "", "PATIENTLIST_VISITS_FRAME", ""), "id");

        } else {
            paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "TABLES." + tableType, "frame"));
            SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");
        }
        return SeleniumFunctions.findElements(Hooks.getDriver(), By.xpath("//span[@class='PAT_FULLNAME']")).size();
    }

    /**************************************************************************
     * perform TimeBasedCriteriaSettings
     *
     * @String CriteriaValue - "Add Patients" or "Remove Patients"
     * @String typeTBC - TimeBasedCriteria Type i.e. ER,ER2...
     * @String criteriaType - "Add"
     * @return void
     *************************************************************************/

    public static void patientListTimeBasedCriteriaSetting(String criteriaValue, String typeTBC, String criteriaType) throws Throwable {
        UtilFunctions.log("Class: " + patientListPage.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        criteriaValue = criteriaValue.replace(" ", "");
        String typeSub = typeTBC;

        if (criteriaValue.contains(":")) {
            String[] codeArr = criteriaValue.split(":");
            int codeLen = 0;
            String code = codeArr[codeLen];
            String noOfDays = codeArr[0].replace(" ", "");
            String Field = codeArr[1].replace(" ", "");
            String textField = String.format(Field);
            //Used in testing error scenarios where the user left the field blank
            if (noOfDays.contains("NULL")) {
                typeSub = typeSub + "_TBC";
                JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
                HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
                String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "TEXT_FIELDS_TEMP." + textField, "frame"));
                SeleniumFunctions.selectFrame(driver, paneFrame, "id");
                String daysField = UtilFunctions.getElementFromJSONFile(fileObj, "TEXT_FIELDS_TEMP." + textField, "path");
                daysField = daysField.replace("TBC", typeSub);
                WebElement txtObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(daysField));
                txtObj.click();
                txtObj.clear();
                txtObj.sendKeys("");

            } else {
                int Days = Integer.parseInt(noOfDays);

                if (noOfDays != null && !noOfDays.isEmpty()) {
                    typeSub = typeSub + "_TBC";
                    JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
                    HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
                    String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "TEXT_FIELDS_TEMP." + textField, "frame"));
                    SeleniumFunctions.selectFrame(driver, paneFrame, "id");
                    String daysField = UtilFunctions.getElementFromJSONFile(fileObj, "TEXT_FIELDS_TEMP." + textField, "path");
                    daysField = daysField.replace("TBC", typeSub);
                    WebElement txtObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(daysField));
                    txtObj.click();
                    txtObj.clear();
                    txtObj.sendKeys(noOfDays);
                } else {
                    JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
                    HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
                    String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "RADIO_BUTTONS_TEMP." + textField, "frame"));
                    SeleniumFunctions.selectFrame(driver, paneFrame, "id");
                    String daysField = UtilFunctions.getElementFromJSONFile(fileObj, "RADIO_BUTTONS_TEMP." + textField, "name");
                    SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(daysField)).click();
                }

            }

        } else {
            typeSub = typeSub + "_TBC";
            JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
            HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
            String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "RADIO_BUTTONS_TEMP." + criteriaValue, "frame"));
            SeleniumFunctions.selectFrame(driver, paneFrame, "id");
            String daysField = UtilFunctions.getElementFromJSONFile(fileObj, "RADIO_BUTTONS_TEMP." + criteriaValue, "name");
            daysField = daysField.replace("TBC", typeSub);
            SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(daysField)).click();
        }
    }

    /**************************************************************************
     * name: selectPatientByIndex(WebDriver driver, String patientName, Integer index)
     * functionality: Click on the patient with after retrieving its object
     * param: WebDriver driver - WebDriver object
     * param: String patientName - Name of patient
     * param: Integer patientName - Index of patient name
     * return: boolean
     *************************************************************************/
    public static boolean selectPatientByNameAndIndex(WebDriver driver, String patientName, Integer index) throws Throwable {
        UtilFunctions.log("Class: " + patientListPage.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);
        UtilFunctions.log("patientName: " + patientName);

        String tab = GlobalStepdefs.curTabName;
        String patientsParentXPath;
        patientName = UtilFunctions.reformName(patientName).toUpperCase();
        UtilFunctions.log("reformedPatientName: " + patientName);
        //COndition to check if the tab is PatientListV2
        if (tab.equals("PatientListV2"))
            patientsParentXPath = "//tr[contains(@class, 'selectable') and descendant-or-self::span[@class='PAT_FULLNAME' and normalize-space(text())='" + patientName + "']][" + index + "]";
        else
            patientsParentXPath = "//tr[@class='standardTable_selectedRow' and descendant::td[starts-with(@id, 'PatientNameCell') and normalize-space(text())='" + patientName + "']][" + index + "]";
        UtilFunctions.log("patientsParentXPath: " + patientsParentXPath);
        WebElement patientNameObj1 = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(patientsParentXPath + ";xpath"));
        int patientSelectCnt = 0;
        WebElement patientNameObj = findPatientByName(driver, patientName);
        if (patientNameObj == null) {
            UtilFunctions.log("patient: " + patientName + " not present. Returning false.");
            return false;
        } else {
            System.out.println(patientNameObj.getText());
            patientNameObj.click();
            patientNameObj.click();
            UtilFunctions.log("patient: " + patientNameObj.getText() + " present and clicked twice. Will check for parent now.");
            while (SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(patientsParentXPath + ";xpath")) == null) {
                patientSelectCnt++;
                UtilFunctions.log("Patient select check count: " + patientSelectCnt);
                patientNameObj = findPatientByName(driver, patientName);
                ((JavascriptExecutor) driver).executeScript("arguments[0].scrollIntoView(true);", patientNameObj);
                Thread.sleep(500);

                System.out.println(patientNameObj.getText());
                UtilFunctions.log("PatientName: " + patientNameObj.getText());
                patientNameObj.click();
                if (patientSelectCnt > GlobalConstants.TEN) {
                    UtilFunctions.log("patient: " + patientNameObj.getText() + " not present. Returning false.");
                    return false;
                }
            }
            UtilFunctions.log("patient: " + patientNameObj.getText() + " present. Returning true.");
            return true;
        }
    }


}

