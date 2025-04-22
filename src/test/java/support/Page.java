package support;

import common.SeleniumFunctions;
import constants.GlobalConstants;
import cucumber.api.DataTable;
import features.Hooks;
import features.step_definitions.GlobalStepdefs;
import org.apache.commons.lang3.StringUtils;
import org.json.simple.JSONObject;
import org.json.simple.parser.ParseException;
import org.junit.Assert;
import org.openqa.selenium.*;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.interactions.Action;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.interactions.MoveTargetOutOfBoundsException;
import org.openqa.selenium.support.ui.Select;
import org.openqa.selenium.support.ui.UnexpectedTagNameException;
import support.db.DBExecutor;
import utils.UtilFunctions;
import utils.UtilProperty;

import javax.rmi.CORBA.Util;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

import static features.step_definitions.GlobalStepdefs.curTabName;

/**
 * Created by PatientKeeper on 6/24/2016.
 */

/******************************************************************************
 Class Name: Page
 Contains common functions related to all pages
 ******************************************************************************/

public class Page {

    public static String STD_MENU_ATTR = "pkmenuitemvalue";
    public String className = getClass().getSimpleName();
    public static HashMap<Integer, DBExecutor> dbExecutorMap = new HashMap<Integer, DBExecutor>();
    private static Page page = new Page();
    private static int count = 0;


    public static WebElement findPane(WebDriver driver, String tabName, String paneName) {
        return findPane(driver, tabName, paneName, GlobalConstants.TEN);
    }


    /**************************************************************************
     * name: findPane(WebDriver driver, String tabName, String paneName)
     * functionality: Function to find and return pane object
     * param: WebDriver driver - WebDriver object
     * param: String tabName - Name of tab
     * param: String paneName - Name of pane
     * return: returns the pane's object
     *************************************************************************/
    public static WebElement findPane(WebDriver driver, String tabName, String paneName, int waitTime) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + ": Start");
        UtilFunctions.log("Current tab name: " + tabName);

        paneName = paneName.replace(" ", "");
        System.out.println("paneName: " + paneName);
        UtilFunctions.log("PaneName: " + paneName);

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        String panePath = UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "path");
        UtilFunctions.log("Pane xpath: " + panePath);
        String paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
        System.out.println("paneFrames: " + paneFrames);
        UtilFunctions.log("PaneFrames: " + paneFrames);

        SeleniumFunctions.selectFrame(driver, paneFrames, "id");
        SeleniumFunctions.explicitWait(driver, waitTime, panePath + ";" + "xpath");

        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + ": Complete");
        return SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(panePath + ";" + "xpath"));
    }


    /**************************************************************************
     * name: selectDropDownInPane(WebDriver driver, String tabName,
     * String value, String dropDownName, String... paneNameArr)
     * functionality: Function to select value in a drop down
     * param: WebDriver driver - WebDriver object
     * param: String tabName - Name of tab
     * param: String value - Name of item to be selected
     * param: String dropDownName - Name of dropDown
     * param: String... paneNameArr - Optional parameter for storing pane name
     * return: void
     *************************************************************************/
    //TODO: Refactor to ake the Assert out of this support method and to return a bool instead of void
    public static void selectDropDownInPane(WebDriver driver, String tabName, String value, String dropDownName,
                                            String... paneNameArr) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);

        String paneFrames;
        String searchString = null;
        String searchMethod = null;
        String paneName = "";

        if (paneNameArr.length > 0 && paneNameArr[0] != null)
            paneName = paneNameArr[0];
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        UtilFunctions.log("PaneName: " + paneName);

        dropDownName = dropDownName.replace(" ", "");
        UtilFunctions.log("Dropdown Name: " + dropDownName);

        if (paneName.equals("")) {
            paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj,
                    "DROPDOWNS." + dropDownName, "frame"));
        } else {
            paneName = paneName.replace(" ", "");
            paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj,
                    "PANES." + paneName, "frame"));
        }
        SeleniumFunctions.selectFrame(driver, paneFrames, "id");
        UtilFunctions.log("PaneFrames: " + paneFrames);

        try {
            String[] elementType = UtilFunctions.getElementStringAndType(fileObj, "DROPDOWNS." + dropDownName);
            searchString = elementType[0];
            searchMethod = elementType[1];

            String dropDownType = UtilFunctions.getElementFromJSONFile(fileObj, "DROPDOWNS." + dropDownName, "type");
            if (dropDownType == null) {
                if (value.equals("the first item"))
                    selectDropDownOptionByIndex(driver, searchString, 0, searchMethod);
                else if (value.equals("the last item"))
                    selectDropDownOptionByIndex(driver, searchString, -1, searchMethod);
                else {
                    Assert.assertTrue("Dropdown " + dropDownName + " not found.",
                            Page.selectDropDownOption(driver, searchString, value, searchMethod));
                }
            } else {
                setDojoDropDown(driver, searchString, value, searchMethod, dropDownType);
            }
        } catch (Exception e) {
            UtilFunctions.log("Item " + value + " not selected from dropDown " + dropDownName +
                    " due to Exception: " + e.getMessage());
            throw (e);
        }
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
    }


    /**************************************************************************
     * name: selectDropDownOptionByIndex(WebDriver driver,
     * String searchString, int index, String searchMethod)
     * functionality: Function to select drop down item based on index
     * param: WebDriver driver - WebDriver object
     * param: String searchString - Name of drop down element
     * param: int index - Index of item to be selected
     * param: String searchMethod - Method such as xpath, id, etc.
     * return: void
     *************************************************************************/
    private static void selectDropDownOptionByIndex(WebDriver driver, String searchString, int index, String searchMethod) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        switch (searchMethod) {
            case "xpath":
                searchString = "//select[" + searchString + "]";
                break;
            case "id":
                searchString = "//select[@name='" + searchString + "'or @id='" + searchString + "']";
                break;
            case "name":
                searchString = "//select[@name='" + searchString + "'or @id='" + searchString + "']";
                break;
        }
        UtilFunctions.log("Search String: " + searchString);
        SeleniumFunctions.explicitWait(driver, GlobalConstants.FIVE, searchString + ";" + searchMethod);
        WebElement dropDownItem = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(searchString + ";" + searchMethod));
        if (dropDownItem != null) {
            UtilFunctions.log("Drop down element not null");
            Select select = new Select(dropDownItem);
            if (index == -1) {
                index = select.getOptions().size() - 1;
            }
            select.selectByIndex(index);
        } else
            UtilFunctions.log("Drop down element is null");
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
    }


    /**
     * name: selectDropDownOption(WebDriver driver, String searchString,
     * * String value, String searchMethod
     * * functionality: Function to select drop down item based on value
     *
     * @param driver       -- WebDriver object
     * @param dropdownName -- Name of drop down element
     * @param value        -- Item to be selected
     * @param searchMethod -- Method such as xpath, id, etc.
     * @return void
     */
    private static boolean selectDropDownOption(WebDriver driver, String dropdownName, String value, String searchMethod) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        SeleniumFunctions.explicitWait(driver, GlobalConstants.FIVE, dropdownName + ";" + searchMethod);
        WebElement dropDown = SeleniumFunctions.findElement(driver,
                SeleniumFunctions.setByValues(dropdownName + ";" + searchMethod));

        if (dropDown != null) {
            UtilFunctions.log("Drop down element not null");
            try {
                Select select = new Select(dropDown);
                select.selectByVisibleText(value);
                return true;
            } catch (Exception e) {
                UtilFunctions.log("Dropdown is not a true dropdown/select; trying to click value by finding " +
                        "element of the value: \n" + value + "\nThrew exception:" + e.getMessage());
                try {
                    dropDown.click();
                } catch (ElementNotInteractableException ex) {
                    UtilFunctions.log(dropdownName + " dropdown not clicked due to: " + ex.getMessage() + ".  Trying again w/ JS click.");
                    ex.printStackTrace();
                    SeleniumFunctions.click(dropDown);
                }

                WebElement dropdownMenuOption = SeleniumFunctions.findElementByWebElement(dropDown,
                        By.xpath("//li[contains(@class,'dropdown-list-item') and descendant-or-self::*[text()='" + value + "']]"));
                if (dropdownMenuOption == null) {
                    dropdownMenuOption = SeleniumFunctions.findElementByWebElement(dropDown,
                            By.xpath("//li[contains(@pkwidgetid,'MenuItem') and descendant-or-self::*[text()='" + value + "']]"));
                }

                if (dropdownMenuOption != null) {
                    try {
                        dropdownMenuOption.click();
                    } catch (ElementNotInteractableException ex) {
                        UtilFunctions.log(value + " not clicked in dropdown due to: " + ex.getMessage() + ".  Trying again w/ JS click.");
                        ex.printStackTrace();
                        SeleniumFunctions.click(dropDown);
                    }
                    return true;
                }
                //new 9x dropdown menus look like this
                else {
                    dropdownMenuOption = SeleniumFunctions.findElementByWebElement(dropDown,
                            By.xpath("//span[@class='md-list-item-text' and (normalize-space(text())='" + value + "')]"));
                    if (dropdownMenuOption != null) {
                        dropdownMenuOption.click();
                        return true;
                    }
                }
            }
        } else {
            UtilFunctions.log("Drop down object is not found");
            throw new NoSuchElementException("Cannot locate dropdown with locator: " + searchMethod + "= " + dropdownName);
        }
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        return false;
    }


    /**************************************************************************
     * name: setDojoDropDown(WebDriver driver, String searchString,
     * String value, String searchMethod, String dropDownType)
     * functionality: Function to select dojo drop down item based on value
     * param: WebDriver driver - WebDriver object
     * param: String searchString - Name of drop down element
     * param: String value - Item to be selected
     * param: String searchMethod - Method such as xpath, id, etc.
     * param: String dropDownType - Type of drop down
     * return: void
     *************************************************************************/
    private static void setDojoDropDown(WebDriver driver, String searchString, String value, String searchMethod,
                                        String dropDownType) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        switch (dropDownType) {
            case "DojoDropdown":
                SeleniumFunctions.explicitWait(driver, GlobalConstants.FIVE, searchString + ";" + searchMethod);
                WebElement dojoXpath = SeleniumFunctions.findElement(driver,
                        SeleniumFunctions.setByValues(searchString + ";" + searchMethod));
                Assert.assertNotNull("dojoXpath is null.", dojoXpath);
                dojoXpath.click();

                SeleniumFunctions.explicitWait(
                        driver,
                        GlobalConstants.FIVE,
                        "//td[@class='dijitReset dijitMenuItemLabel' and descendant-or-self::*/text()='" +
                                value + "']" + ";" + searchMethod
                );
                WebElement dojoXpath2 = SeleniumFunctions.findElement(driver,
                        SeleniumFunctions.setByValues(
                                "//td[@class='dijitReset dijitMenuItemLabel' and descendant-or-self::*/text()='" +
                                        value + "']" + ";" + searchMethod));
                /*The Javascript click below isn't always solving the issue either.  Sometimes the dojoXpath2 is
                 * still coming up as Null even when it is displayed on the page.
                 * So, if it's Null, try to find the element again. -- HIC 11/5/18*/
                if (dojoXpath2 != null) {
                    Assert.assertNotNull("dojoXpath2 is null.", dojoXpath2);
                    dojoXpath2.click();

                } else {
                    dojoXpath = SeleniumFunctions.findElement(driver,
                            SeleniumFunctions.setByValues(searchString + ";" + searchMethod));
                    Assert.assertNotNull("dojoXpath is null.", dojoXpath);
                    dojoXpath.click();

                    dojoXpath2 = SeleniumFunctions.findElement(
                            driver,
                            SeleniumFunctions.setByValues(
                                    "//td[@class='dijitReset dijitMenuItemLabel' and descendant-or-self::*/text()='" +
                                            value +
                                            "']" +
                                            ";" +
                                            searchMethod)
                    );
                    Assert.assertNotNull("dojoXpath2 is null.", dojoXpath2);
                    dojoXpath2.click();
                }

                //clicking once isn't working for few elements. Tried with sleep to avoid race condition also, that didn't work either.
                //So implemented Javascript click
                /*JavascriptExecutor executor = (JavascriptExecutor) driver;
                executor.executeScript("arguments[0].click();", dojoXpath2);*/
                /*I don't think using a JS click is better for HTML timing/sync issues. I think this might be better
                remaining as a Selenium WebDriver dot click like above. -- HIC 11/6/18*/
                break;
            default:
                UtilFunctions.log("Dropdown type not valid.");
                break;
        }

        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
    }

    /**
     * Method to verify selected value of a dropdown
     *
     * @param driver       the driver object
     * @param tabName      name of the currently selected tab
     * @param value        expected selected value of dropdown
     * @param dropdownName name of the dropdown to check
     * @param paneNameArr  name of pane, passed in an option array
     * @return boolean
     */
    public static boolean checkDropdownValue(WebDriver driver, String tabName, String value, String dropdownName, String... paneNameArr) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        String paneFrames;
        String paneName = "";
        if (paneNameArr.length > 0 && paneNameArr[0] != null)
            paneName = paneNameArr[0];
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        UtilFunctions.log("PaneName: " + paneName);
        dropdownName = dropdownName.replace(" ", "");
        UtilFunctions.log("Dropdown Name: " + dropdownName);
        if (paneName.equals("")) {
            paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "DROPDOWNS." + dropdownName, "frame"));
        } else {
            paneName = paneName.replace(" ", "");
            paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
        }
        SeleniumFunctions.selectFrame(driver, paneFrames, "id");
        UtilFunctions.log("PaneFrames: " + paneFrames);
        String[] elementType = UtilFunctions.getElementStringAndType(fileObj, "DROPDOWNS." + dropdownName);
        String searchString = elementType[0];
        String searchMethod = elementType[1];
        SeleniumFunctions.explicitWait(driver, GlobalConstants.FIVE, searchString + ";" + searchMethod);
        WebElement dropDownItem = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(searchString + ";" + searchMethod));
        if (dropDownItem != null) {
            UtilFunctions.log("Drop down element not null");
            try {
                Select select = new Select(dropDownItem);
                if (select != null) {
                    String selectedValue = select.getFirstSelectedOption().getText();
                    if (selectedValue.equals(value))
                        return true;
                    else
                        return false;
                }
            } catch (UnexpectedTagNameException e) {
                //works for dashboard mode
                WebElement selectedEle = SeleniumFunctions.findElementByWebElement(dropDownItem, SeleniumFunctions.setByValues("./*[contains(@class,'dropdown-selected')]"));
                if (selectedEle.getText().equals(value))
                    return true;
                else
                    return false;
            }
        } else {
            UtilFunctions.log("Drop down object is not found");
            throw new NoSuchElementException("Cannot locate dropdown with locator: " + searchMethod + "= " + searchString);
        }
        return false;
    }

    /**************************************************************************
     * name: checkPagePaneLoad(WebDriver driver, String tabName, String value)
     * functionality: Function to check whether pane loads or not
     * param: WebDriver driver - WebDriver object
     * param: String tabName - Name of tab
     * param: String value - Name of pane
     * return: returns pane element object
     *************************************************************************/
    public static WebElement checkPagePaneLoad(WebDriver driver, String tabName, String value) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);
        value = value.replace(" ", "");
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        if (!tabName.equals("")) {
            String[] elementType = UtilFunctions.getElementStringAndType(fileObj, "PANES." + value);
            String panePath = elementType[0];
            String paneMethod = elementType[1];
            String paneFrames = (String) frameMap.get(UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + value, "frame"));
            SeleniumFunctions.selectFrame(driver, paneFrames, "id");
            SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, panePath + ";" + paneMethod);
            WebElement paneListObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(panePath + ";" + paneMethod));
            if (paneListObj != null)
                return paneListObj;
            else
                return null;
        } else
            return null;
    }

    public static boolean checkLabelOfTheElement(WebDriver driver, String tabName, String elementName, String elementType, String checkFor) throws Exception {
        String type = "";
        if (elementType.equals("Button")) {
            type = "BUTTONS.";
        }

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        String[] element = UtilFunctions.getElementStringAndType(fileObj, type + elementName);
        String path = element[0];
        String method = element[1];
        String paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "BUTTONS." + elementName, "frame"));
        SeleniumFunctions.selectFrame(driver, paneFrames, "id");
        SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, path + ";" + method);
        WebElement obj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(path + ";" + method));
        checkFor = checkFor.replace(" ", "");
        String label = "";
        label = obj.getText();
        label = label.replace(" ", "");
        if (checkFor.equals(label))
            return true;
        return false;
    }

    public static boolean checkIfEnabled(WebDriver driver, String tabName, String elementName, String elementType, String checkFor) throws Exception {

        boolean result = false;
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        String paneFrames = "";
        elementType = elementType.toUpperCase() + "S";
        elementName = elementName.replace(" ", "");
        String[] element = UtilFunctions.getElementStringAndType(fileObj, String.format("%s.%s", elementType, elementName));
        String path = element[0];
        String method = element[1];

        paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, String.format("%s.%s", elementType, elementName), "frame"));
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");

        SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.TWO, path);
        WebElement targetElement = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(String.format("%s;%s", path, method)));

        Assert.assertNotNull(String.format("The %s element was not found", elementName), targetElement);

        if ((checkFor.equals("disabled") && !targetElement.isEnabled()) || (checkFor.equals("enabled") && targetElement.isEnabled())) {

            result = true;
        }
        return result;
    }

    public static boolean checkImageRotation(WebDriver driver, String imageName, String tabName) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        imageName = imageName.replace(" ", "");
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        String[] elementType = UtilFunctions.getElementStringAndType(fileObj, "MISC_ELEMENTS." + imageName);
        String buttonPath = elementType[0];
        String buttonMethod = elementType[1];

        WebElement imgObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(buttonPath + ";" + buttonMethod));
        String style = imgObj.getAttribute("style");

        if (style.contains("90deg") || style.contains("-90deg"))
            return true;
        return false;
    }

    public static boolean checkSizeofTheImage(WebDriver driver, String imageName, String tabName) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        imageName = imageName.replace(" ", "");
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        String[] elementType = UtilFunctions.getElementStringAndType(fileObj, "MISC_ELEMENTS." + imageName);
        String buttonPath = elementType[0];
        String buttonMethod = elementType[1];

        WebElement imgObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(buttonPath + ";" + buttonMethod));
        String style = imgObj.getAttribute("style");

        if (style.contains("width") || style.contains("height"))
            return true;
        return false;
    }

    public static boolean resizePhoto(WebDriver driver, String imageName, String resizeType, String tabName) throws Exception {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        imageName = imageName.replace(" ", "");
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        String[] elementType = UtilFunctions.getElementStringAndType(fileObj, "MISC_ELEMENTS." + imageName);
        String buttonPath = elementType[0];
        String buttonMethod = elementType[1];

        WebElement imgObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(buttonPath + ";" + buttonMethod));
        String style = imgObj.getAttribute("style");

        if (resizeType.equals("fits the screen")) {
            if (style.contains("width: 100%; height: 100%;"))
                return true;
            return false;
        } else if (resizeType.equals("is oiginal size")) {
            //Don't know what the "original size" of the image will be, but we do know style should not be "fit to screen"
            if (!style.contains("width: 100%; height: 100%;"))
                return true;
            return false;
        }
        return false;
    }

    public static boolean purgePhoto(WebDriver driver, String purgeType, String tabName) throws Exception {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        String[] elementType = UtilFunctions.getElementStringAndType(fileObj, "BUTTONS." + "Purge");
        String buttonPath = elementType[0];
        String buttonMethod = elementType[1];

        WebElement btnObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(buttonPath + ";" + buttonMethod));
        String title = btnObj.getAttribute("title");

        //getting id of the image
        String[] elementTypeImg = UtilFunctions.getElementStringAndType(fileObj, "MISC_ELEMENTS." + "CurrentImage");
        String imgPath = elementTypeImg[0];
        String imgMethod = elementTypeImg[1];

        WebElement imgObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(imgPath + ";" + imgMethod));
        String imgId = imgObj.getAttribute("id");
        //id for where clause
        int id = Integer.parseInt(imgId.substring(6));

        DBExecutor dbExecutorObj = Page.prepareQuery("PurgedPhoto");
        dbExecutorObj.addWhere("SYNCREPOSITORYID=" + id);
        List<HashMap> rs = dbExecutorObj.executeQuery();

        Map<Integer, Integer> map = rs.get(0);

        int purgeStatusFromDB = ((BigDecimal) rs.get(0).get("PURGESTATUS")).intValue();

        if (purgeType.equals("purge") && purgeStatusFromDB == 0) {
            if (title.contains("Click to save photo so that it will not be purged")) {
                Assert.assertTrue("The button Purge was not found", clickButton(driver, tabName, "Purge", ""));
                return true;
            } else if (title.contains("Photo will not be purged"))
                return true;
            else
                return false;

        }// do not want to purge the photo and photo is not already marked for it

        else if (purgeType.equals("unpurge") && purgeStatusFromDB == 1) {
            if (title.contains("Photo will not be purged")) {
                Assert.assertTrue("The button Purge was not found", clickButton(driver, tabName, "Purge", ""));
                return true;
            } else if (title.contains("Click to save photo so that it will not be purged"))
                return true;
            else
                return false;
        }// do not want to purge the photo and photo is not already marked for it
        else
            return false;
    }

    /**************************************************************************
     * name: clickButton(WebDriver driver, String tabName, String buttonName,
     * String... paneName)
     * functionality: Function to click on a button
     * param: WebDriver driver - WebDriver object
     * param: String tabName - Name of tab
     * param: String buttonName - Name of button to be clicked
     * param: String... paneName - Optional parameter for pane name
     * return: boolean
     *************************************************************************/
    //TODO: refactor clickButton for optimization
    public static boolean clickButton(WebDriver driver, String tabName, String buttonName, String... paneName)
            throws InterruptedException {

        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);
        buttonName = buttonName.replace(" ", "");
        UtilFunctions.log("Button to be clicked: " + buttonName);

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        String paneFrames;

        String[] elementType = UtilFunctions.getElementStringAndType(fileObj, "BUTTONS." + buttonName);
        String buttonPath = elementType[0];
        String buttonMethod = elementType[1];

        if (paneName.length > 0) {
            //Added or in condition to check for null as well as empty string like ("")
            if (paneName[0] == null || paneName[0].equals("")) {
                paneFrames = UtilFunctions.getFrameValue(frameMap,
                        UtilFunctions.getElementFromJSONFile(fileObj, "BUTTONS." +
                                buttonName, "frame"));
            } else {
                paneFrames = UtilFunctions.getFrameValue(frameMap,
                        UtilFunctions.getElementFromJSONFile(fileObj, "PANES." +
                                paneName[0].replace(" ", ""), "frame"));
            }
        } else {
            paneFrames = UtilFunctions.getFrameValue(frameMap,
                    UtilFunctions.getElementFromJSONFile(fileObj, "BUTTONS." + buttonName, "frame"));
        }

        UtilFunctions.log("PaneFrames: " + paneFrames);
        SeleniumFunctions.selectFrame(driver, paneFrames, "id");
        SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, buttonPath + ";" + buttonMethod);

        WebElement btnObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(buttonPath + ";"
                + buttonMethod));

        if (btnObj == null) {
            UtilFunctions.log("Button '" + buttonName + "' object null. Returning false.");
            return false;
        } else {
            if (!btnObj.isDisplayed()) {
                GlobalConstants.setGlobalFrameValue("");
                SeleniumFunctions.selectFrame(driver, paneFrames, "id");
                System.out.println("btnObj.isDisplayed? " + btnObj.isDisplayed());
                List<WebElement> btnObjList = SeleniumFunctions.findElements(driver,
                        SeleniumFunctions.setByValues(buttonPath + ";" + buttonMethod));
                for (WebElement btnObjChild : btnObjList) {
                    if (btnObjChild.isDisplayed()) {
                        //btnObj = btnObjChild;
                        Actions actions = new Actions(driver);
                        actions.moveToElement(btnObj).click().build().perform();
                        break;
                    }
                }
                System.out.println(btnObj.isDisplayed());
            }
            if (btnObj.isDisplayed()) {
                try {
                    btnObj.click();//when the browser is IE, this first btn click is "passing", but the btn is not getting clicked.
                    Thread.sleep(1000);
                    return true;
                } catch (ElementNotInteractableException e) {
                    UtilFunctions.log("Retrying button click w/ JS click for '" + buttonName +
                            "' object. First attempt failed due to exception: " + e.getMessage());
                    e.printStackTrace();
                    SeleniumFunctions.click(btnObj);
                    Thread.sleep(1000);
                    return true;
                } catch (WebDriverException wde) {
                    UtilFunctions.log("Retrying button click for '" + buttonName +
                            "' object. First attempt failed due to exception: " + wde.getMessage());
                    wde.printStackTrace();
                    Actions actions = new Actions(driver);
                    actions.moveToElement(btnObj).click().build().perform();
                    Thread.sleep(1000);
                    UtilFunctions.log("Button '" + buttonName +
                            "' object not null and is clicked. Returning true.");
                    return true;
                }
            }

            UtilFunctions.log("Button '" + buttonName + "' object not visible. Returning false.");
            return false;
        }
    }


    /**************************************************************************
     * name: checkElementExists(WebDriver driver, String curTabName, String elementName, String elementType, String... paneName)
     * functionality: Method to check whether an element exists or not, whether Selenium can find the element or not
     * @param: WebDriver driver - WebDriver object
     * @param: String curTabName - Name of current tab
     * @param: String elementName - Name of element to be checked
     * @param: String elementType - Type of element, i.e. PANE, BUTTON, etc.
     * @param: String... paneName - Optional parameter for pane name
     * @return: boolean, true if Selenium finds the element, otherwise false
     *************************************************************************/
    //TODO: This method and checkElementOnPagePresent() are the same method.  Consolidate.
    public static boolean checkElementExists(WebDriver driver, String curTabName, String elementName, String elementType, String... paneName) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        UtilFunctions.log("Current tab name: " + curTabName);
        elementName = elementName.replace(" ", "");
        UtilFunctions.log("ElementName: " + elementName);

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        String paneFrames;

//        String[] elementArr = UtilFunctions.getElementStringAndType(fileObj, "BUTTONS." + elementName);
        String[] elementArr = UtilFunctions.getElementStringAndType(fileObj, elementType + "." + elementName);

        String elePath = elementArr[0];
        String eleMethod = elementArr[1];

        if (paneName.length > 0 && paneName[0] != null) {
            paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj,
                    "PANES." + paneName[0].replace(" ", ""), "frame"));
        } else
            paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj,
                    elementType + "." + elementName, "frame"));

        UtilFunctions.log("PaneFrames: " + paneFrames);
        SeleniumFunctions.selectFrame(driver, paneFrames, "id");
        WebElement eleObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(elePath + ";" + eleMethod));
        if (eleObj == null) {
            UtilFunctions.log("Element '" + elementName + "' object is null. Returning false");
            return false;
        } else {
            UtilFunctions.log("Element '" + elementName + "' object not null. Returning true");
            return true;
        }
    }


    /**************************************************************************
     * name: checkElementOnPagePresent(WebDriver driver, String tabName,
     * String elementName, String elementType, String identifier,
     * String... paneName)
     * functionality: Function to check whether element exists or not
     * param: WebDriver driver - WebDriver object
     * param: String tabName - Name of current tab
     * param: String elementName - Name of element to be checked
     * param: String elementType - Type of element, i.e. PANE, BUTTON, etc.
     * param: String... paneName - Optional parameter for pane name
     * return: boolean
     *************************************************************************/
    public static boolean checkElementOnPagePresent(WebDriver driver, String tabName, String elementName, String elementType, String... paneName) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);
        UtilFunctions.log("Element Name: " + elementName);
        UtilFunctions.log("Element Type: " + elementType);
        UtilFunctions.log("PaneName: " + paneName);

        String paneFrames;
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        String[] elementTypeArr = UtilFunctions.getElementStringAndType(fileObj, elementType + "." + elementName);
        String elementPath = elementTypeArr[0];
        String elementMethod = elementTypeArr[1];

        UtilFunctions.log("Element Path: " + elementPath);
        UtilFunctions.log("Element Method: " + elementMethod);

        if (paneName.length > 0)
            paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName[0].replace(" ", ""), "frame"));
        else
            paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, elementType + "." + elementName, "frame"));
        UtilFunctions.log("PaneFrames: " + paneFrames);
        SeleniumFunctions.selectFrame(driver, paneFrames, "id");
        SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, elementPath + ";" + elementMethod);
        if (SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(elementPath + ";" + elementMethod)) == null) {
            UtilFunctions.log("Element '" + elementName + "' object not visible. Returning false.");
            return false;
        } else {
            UtilFunctions.log("Element '" + elementName + "' object visible on screen. Returning true.");
            return true;
        }
    }


    /**************************************************************************
     * name: setTextBox(WebDriver driver, String tabName, String value,
     * String fieldName, String... paneName)
     * functionality: Function to enter value in text box
     * param: WebDriver driver - WebDriver object
     * param: String tabName - Name of current tab
     * param: String value - Value to be entered in text box
     * param: String fieldName - Text box field name
     * param: String... paneName - Optional parameter for pane name
     * return: boolean
     *************************************************************************/
    //TODO: Why is this hitting arrow keys before it even clicks the textbox? See line 822.
    public static boolean setTextBox(WebDriver driver, String tabName, String value, String fieldName,
                                     String... paneName) {
        //try {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);
        fieldName = fieldName.replace(" ", "");
        UtilFunctions.log("Text box field name: " + fieldName);

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        String paneFrames = "";
        String[] elementType = UtilFunctions.getElementStringAndType(fileObj, "TEXT_FIELDS." + fieldName);
        String textPath = elementType[0];
        String textMethod = elementType[1];

        UtilFunctions.log("Text box textPath: " + textPath);
        UtilFunctions.log("Text box textMethod: " + textMethod);

        if (paneName.length > 0)
            paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj,
                    "PANES." + paneName[0].replace(" ", ""), "frame"));
        else {
            paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj,
                    "TEXT_FIELDS." + fieldName, "frame"));
        }
        UtilFunctions.log("PaneFrames: " + paneFrames);

        SeleniumFunctions.selectFrame(driver, paneFrames, "id");
        WebElement txtObj = findTextBox(driver, textPath, textMethod);
        if (txtObj == null) {
            UtilFunctions.log("Text box '" + fieldName + "' object is null. Returning false.");
            return false;
        } else {
            value = UtilFunctions.convertThruRegEx(value);
            try {
                txtObj.click();
                UtilFunctions.sleep(500);
                txtObj.clear();
                UtilFunctions.sleep(500);

                if (SeleniumFunctions.checkAlertPresent(driver)) {
                    SeleniumFunctions.handleAlert(driver, "OK");
                    txtObj.sendKeys(Keys.BACK_SPACE);
                    txtObj.sendKeys(Keys.BACK_SPACE);
                    txtObj.sendKeys(Keys.BACK_SPACE);
                }

                if (value.equals("#{days}"))
                    txtObj.sendKeys("5");
                else
                    txtObj.sendKeys(value);
                UtilFunctions.sleep(1000);
                UtilFunctions.log("Text box '" + fieldName + "' object not null. Entered Value: '" + value +
                        "'. Returning true.");
                return true;
            } catch (ElementNotInteractableException e) {
                UtilFunctions.log("Trying again. Exception: " + e.getMessage());
                e.printStackTrace();

                SeleniumFunctions.click(txtObj);
                SeleniumFunctions.clear(driver, txtObj);

                if (SeleniumFunctions.checkAlertPresent(driver)) {
                    SeleniumFunctions.handleAlert(driver, "OK");
                    txtObj.sendKeys(Keys.BACK_SPACE);
                    txtObj.sendKeys(Keys.BACK_SPACE);
                    txtObj.sendKeys(Keys.BACK_SPACE);
                }

                if (value.equals("#{days}"))
                    txtObj.sendKeys("5");
                else
                    txtObj.sendKeys(value);
                UtilFunctions.sleep(1000);
                UtilFunctions.log("Text box '" + fieldName + "' object not null. Entered Value: '" + value +
                        "'. Returning true.");
                return true;
            }
        }
    }


    public static WebElement getTextBox(WebDriver driver, String tabName, String fieldName, String paneName) {
        try {
            UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
            }.getClass().getEnclosingMethod().getName());
            UtilFunctions.log("Current tab name: " + tabName);
            UtilFunctions.log("Text box field name: " + fieldName);

            JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
            HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
            String paneFrames = "";
            String[] elementType = UtilFunctions.getElementStringAndType(fileObj, "TEXT_FIELDS." + fieldName);
            String textPath = elementType[0];
            String textMethod = elementType[1];

            UtilFunctions.log("Text box textPath: " + textPath);
            UtilFunctions.log("Text box textMethod: " + textMethod);

            if (paneName == null)
                paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "TEXT_FIELDS." + fieldName, "frame"));
            else
                paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName.replace(" ", ""), "frame"));
            UtilFunctions.log("PaneFrames: " + paneFrames);

            SeleniumFunctions.selectFrame(driver, paneFrames, "id");
            WebElement txtObj = findTextBox(driver, textPath, textMethod);
            if (txtObj == null) {
                UtilFunctions.log("Text box '" + fieldName + "' object is null. Returning false.");
                count++;
                if (count <= GlobalConstants.ONE) {
                    UtilFunctions.log("Recursive calling of the function.");
                    GlobalConstants.setGlobalFrameValue("");
                    return getTextBox(driver, tabName, fieldName, paneName);
                } else {
                    count = 0;
                    UtilFunctions.log("Returning null");
                    return null;
                }
            } else {
                UtilFunctions.log("Returning object.");
                return txtObj;
            }
        } catch (Exception e) {
            UtilFunctions.log("Returning null. Exception: " + e.getMessage());
            return null;
        }
    }


    /**************************************************************************
     * name: findTextBox(WebDriver driver, String textBoxName,
     *  String textMethod)
     * functionality: Function to find text box object
     * param: WebDriver driver - WebDriver object
     * param: String textBoxName - Text box field name. Or, the actual xpath of the textbox if the textMethod is barexpath.
     * param: String textMethod - Text method type in json, such as xpath, id,
     * name, etc.
     * return: returns text box object
     *************************************************************************/
    public static WebElement findTextBox(WebDriver driver, String textBoxName, String textMethod) {

        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Text box name: " + textBoxName);//Or, the actual xpath of the textbox if the textMethod is barexpath.
        String xpathValue = "";

        if (textMethod.equals("id") || textMethod.equals("name"))
            xpathValue = "//*[(local-name()='input' or local-name()='textarea' or local-name()='div') and (@name='" + textBoxName +
                    "' or @id='" + textBoxName + "' or @testid='" + textBoxName + "' or @externalid='" + textBoxName + "')]";
        else if (textMethod.equals("path") || textMethod.equals("xpath"))
            xpathValue = "//*[(local-name()='input' or local-name()='textarea' or local-name()='div') and " + textBoxName + "]";
        else if (textMethod.equals("barexpath")) {
            //If the textbox has an actual xpath and has member "barexpath" in its JSON object,
            //then the string passed in as "textBoxName" is actually the xpath of the element.
            xpathValue = textBoxName;
        }

        SeleniumFunctions.explicitWait(driver, GlobalConstants.FIFTEEN, xpathValue + ";xpath");
        return SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(xpathValue + ";xpath"));
    }

    /**
     * Append some text to existing text within a text field.  Fakes appending text due to the difficulty in reliably
     * moving cursor to the end of text.  Instead, this step gets the current text, saves it, clears the field,
     * and re-enters the previous text PLUS the new text.
     *
     * @param driver    WebDriver object
     * @param tabName   Name of the current tab.  Used to lookup element definitions
     * @param value     The text value to append to the existing text
     * @param fieldName Target text field for the append action
     * @param paneName  Name of the pane.  Used for frame lookup when not null.
     * @return
     */
    public static boolean appendTextToField(WebDriver driver, String tabName, String value, String fieldName,
                                            String paneName) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        fieldName = fieldName.replace(" ", "");
        UtilFunctions.log("Text box field name: " + fieldName);

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        String paneFrames = "";
        String[] elementType = UtilFunctions.getElementStringAndType(fileObj, "TEXT_FIELDS." + fieldName);
        String textPath = elementType[0];
        String textMethod = elementType[1];

        UtilFunctions.log("Text box textPath: " + textPath);
        UtilFunctions.log("Text box textMethod: " + textMethod);

        if (paneName != null)
            paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj,
                    "PANES." + paneName.replace(" ", ""), "frame"));
        else {
            paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj,
                    "TEXT_FIELDS." + fieldName, "frame"));
        }

        UtilFunctions.log("PaneFrames: " + paneFrames);

        SeleniumFunctions.selectFrame(driver, paneFrames, "id");
        WebElement txtObj = findTextBox(driver, textPath, textMethod);
        if (txtObj == null) {
            UtilFunctions.log("Text box '" + fieldName + "' object is null. Returning false.");
            return false;
        } else {
            txtObj.click();
            String currentText = txtObj.getText();
            txtObj.clear();
            txtObj.sendKeys(currentText + ' ' + value);
            UtilFunctions.log("Appended text to field '" + fieldName + "'.");
        }
        return true;
    }


    /**************************************************************************
     * name: handleAlert(WebDriver driver, String buttonName)
     * functionality: Function used to handle alerts on pages
     * param: WebDriver driver - WebDriver object
     * param: String buttonName - Name of button on alert
     * return: boolean
     *************************************************************************/
    public static boolean handleAlert(WebDriver driver, String buttonName) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Alert button name: " + buttonName);

        return SeleniumFunctions.handleAlert(driver, buttonName);
    }


    /**************************************************************************
     * name: checkDataTableInPane(WebDriver driver, String tabName,
     * String paneName, DataTable dataTable)
     * functionality: Function to check availability of all the radio, text
     * boxes etc. present in the data table
     * param: WebDriver driver - WebDriver object
     * param: String tabName - Name of current tab
     * param: String paneName - Parameter for pane name
     * param: DataTable dataTable - Stores list of items
     * return: returns "" string if successful
     *************************************************************************/
    public static String checkDataTableInPane(WebDriver driver, String tabName, String state, String paneName, DataTable dataTable) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);
        UtilFunctions.log("PaneName: " + paneName);

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        boolean retValue = true;
        String retString = "";
        String[] elementType;
        String fieldPath;
        String fieldMethod;
        paneName = paneName.replace(" ", "");
        List<Map<String, String>> dataList = dataTable.asMaps(String.class, String.class);
        String panePath = UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "path");
        String paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
        UtilFunctions.log("PaneFrames: " + paneFrames);
        SeleniumFunctions.selectFrame(driver, paneFrames, "id");
        for (Map data : dataList) {
            String fieldType = (String) data.get("Type");
            String fieldName = ((String) data.get("Name"));
            if (!fieldType.equals("link")) {
                fieldName = ((String) data.get("Name")).replace(" ", "");
            }
            UtilFunctions.log("fieldType: " + fieldType + "\nfieldName: " + fieldName);
            switch (fieldType) {
                case "element":
                    elementType = UtilFunctions.getElementStringAndType(fileObj, "MISC_ELEMENTS." + fieldName);
                    fieldPath = elementType[0];
                    fieldMethod = elementType[1];
                    UtilFunctions.log("fieldPath: " + fieldPath + "\nfieldMethod: " + fieldMethod);
                    SeleniumFunctions.explicitWait(driver, GlobalConstants.FIFTEEN, fieldPath + ";" + fieldMethod);
                    WebElement eleObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(fieldPath + ";" + fieldMethod));
                    if (eleObj == null)
                        retValue = false;
                    else {
                        if (state != null && state.equals("enabled")) {
                            retValue = eleObj.getAttribute("disabled") == null;
                        } else if (state != null && state.equals("disabled")) {
                            retValue = eleObj.getAttribute("enabled") == null;
                        } else if (state != null && state.equals("not display")) {
                            retValue = eleObj.getAttribute("display") != null;
                        } else {
                            retValue = true;
                        }
                    }
                    break;
                case "text":
                    elementType = UtilFunctions.getElementStringAndType(fileObj, "TEXT_FIELDS." + fieldName);
                    fieldPath = elementType[0];
                    fieldMethod = elementType[1];
                    UtilFunctions.log("fieldPath: " + fieldPath + "\nfieldMethod: " + fieldMethod);
                    retValue = checkTextBoxExists(driver, fieldPath, fieldMethod);
                    break;
                case "radio":
                    elementType = UtilFunctions.getElementStringAndType(fileObj, "RADIOS." + fieldName);
                    fieldPath = elementType[0];
                    fieldMethod = elementType[1];
                    UtilFunctions.log("fieldPath: " + fieldPath + "\nfieldMethod: " + fieldMethod);
                    retValue = checkRadioExists(driver, fieldPath, fieldMethod);
                    break;
                case "button":
                    elementType = UtilFunctions.getElementStringAndType(fileObj, "BUTTONS." + fieldName);
                    fieldPath = elementType[0];
                    fieldMethod = elementType[1];
                    UtilFunctions.log("fieldPath: " + fieldPath + "\nfieldMethod: " + fieldMethod);
                    SeleniumFunctions.explicitWait(driver, GlobalConstants.FIFTEEN, fieldPath + ";" + fieldMethod);
                    WebElement btnObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(fieldPath + ";" + fieldMethod));
                    if (btnObj == null)
                        retValue = false;
                    else {
                        if (state != null && state.equals("enabled")) {
                            retValue = btnObj.getAttribute("disabled") == null;
                        } else if (state != null && state.equals("disabled")) {
                            retValue = btnObj.getAttribute("disabled") != null;
                        } else
                            retValue = true;
                    }
                    break;
                case "dropdown":
                    elementType = UtilFunctions.getElementStringAndType(fileObj, "DROPDOWNS." + fieldName);
                    fieldPath = elementType[0];
                    fieldMethod = elementType[1];
                    UtilFunctions.log("fieldPath: " + fieldPath + "\nfieldMethod: " + fieldMethod);
                    SeleniumFunctions.explicitWait(driver, GlobalConstants.FIFTEEN, fieldPath + ";" + fieldMethod);
                    WebElement dropdownObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(fieldPath + ";" + fieldMethod));
                    if (dropdownObj == null)
                        retValue = false;
                    else {
                        if (state != null && state.equals("enabled")) {
                            retValue = dropdownObj.getAttribute("disabled") == null;
                        } else if (state != null && state.equals("disabled")) {
                            retValue = dropdownObj.getAttribute("disabled") != null;
                        } else
                            retValue = true;
                    }
                    break;
                case "link":
                    if (fieldName.contains("[Edit]"))
                        fieldName = fieldName.replace("[Edit]", "").trim();
                    WebElement linkObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//*[starts-with(normalize-space(./text()), '" + fieldName + "')]"));
//                    WebElement linkObj = SeleniumFunctions.findElement(driver,By.xpath("//*[starts-with(normalize-space(./text()), '" + fieldName + "')]"));
                    if (linkObj == null)
                        retValue = false;
                    else {
                        if (state != null && state.equals("enabled")) {
                            retValue = linkObj.getAttribute("disabled") == null;
                        } else if (state != null && state.equals("disabled")) {
                            retValue = linkObj.getAttribute("disabled") != null;
                        } else if (state != null && state.equals("not display")) {
                            retValue = linkObj.getAttribute("display") != null;
                        } else {
                            retValue = true;
                        }
                    }
                    break;
                case "check":
                    elementType = UtilFunctions.getElementStringAndType(fileObj, "CHECKBOXES." + fieldName);
                    fieldPath = elementType[0];
                    fieldMethod = elementType[1];
                    UtilFunctions.log("fieldPath: " + fieldPath + "\nfieldMethod: " + fieldMethod);
                    SeleniumFunctions.explicitWait(driver, GlobalConstants.FIFTEEN, fieldPath + ";" + fieldMethod);
                    WebElement checkboxObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(fieldPath + ";" + fieldMethod));
                    if (checkboxObj == null)
                        retValue = false;
                    else {
                        if (state != null && state.equals("enabled")) {
                            retValue = checkboxObj.getAttribute("disabled") == null;
                        } else if (state != null && state.equals("disabled")) {
                            retValue = checkboxObj.getAttribute("disabled") != null;
                        } else
                            retValue = true;
                    }
                    break;
                default:
                    break;
            }
            if (retValue) {
                continue;
            }
            retString = retString + "Field: " + fieldName + " of Type: " + fieldType + " is not present.";
            UtilFunctions.log(retString);
            retValue = true;
        }
        return retString;
    }


    /**************************************************************************
     * name: checkRadioExists(WebDriver driver, String fieldPath,
     * String fieldMethod)
     * functionality: Function to check whether radio button exists or not
     * param: WebDriver driver - WebDriver object
     * param: String fieldPath - Name of radio field
     * param: String fieldMethod - Type of radio field name such as xpath, id,
     * name, etc.
     * return: boolean
     *************************************************************************/
    private static boolean checkRadioExists(WebDriver driver, String fieldPath, String fieldMethod) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        String xPathValue = "";

        switch (fieldMethod) {
            case "xpath":
                xPathValue = fieldPath;
                break;
            default:
                xPathValue = "//input[@type='radio' and @name='" + fieldPath + "']";
                break;
        }
        SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, xPathValue + ";" + "xpath");
        WebElement element = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(xPathValue + ";" + "xpath"));
        if (element == null) {
            UtilFunctions.log("Radio: " + fieldPath + " does not exist. Returning false.");
            return false;
        } else {
            UtilFunctions.log("Radio: " + fieldPath + " exist. Returning true.");
            return true;
        }
    }


    /**************************************************************************
     * name: checkTextBoxExists(WebDriver driver, String fieldName,
     * String fieldMethod)
     * functionality: Function to check whether text box exists or not
     * param: WebDriver driver - WebDriver object
     * param: String fieldName - Name of radio field
     * param: String fieldMethod - Type of radio field name such as xpath, id,
     * name, etc.
     * return: boolean
     *************************************************************************/
    public static boolean checkTextBoxExists(WebDriver driver, String fieldName, String fieldMethod) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        String xPathValue;
        switch (fieldMethod) {
            case "name":
                xPathValue = "//*[(local-name()='input' or local-name()='textarea') and (@name='" + fieldName + "' or @id='" + fieldName + "' or @testid='" + fieldName + "')]";
                break;
            case "id":
                xPathValue = "//*[(local-name()='input' or local-name()='textarea') and (@name='" + fieldName + "' or @id='" + fieldName + "' or @testid='" + fieldName + "')]";
                break;
            default:
                xPathValue = fieldName;
                break;
        }
        UtilFunctions.log("Text box: '" + fieldName + "'; xpath: " + xPathValue);
        SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, xPathValue + ";" + "xpath");
        WebElement element = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(xPathValue + ";" + "xpath"));
        if (element == null) {
            UtilFunctions.log("Text box: " + fieldName + " does not exist. Returning false.");
            return false;
        } else {
            UtilFunctions.log("Text box: " + fieldName + " exist. Returning true.");
            return true;
        }
    }


    /**************************************************************************
     * name: setRadioValue(WebDriver driver, String tabName, String value,
     * String radioName, String... paneName)
     * functionality: Function to set values for clicking radio button and
     * invoke the function to click on radio button
     * param: WebDriver driver - WebDriver object
     * param: String tabName - Name of tab
     * param: String value - Radio button display text
     * param: String radioName - Name of radio button in json file
     * param: String... paneName - Optional parameter for pane name
     * return: boolean
     *************************************************************************/
    public static boolean setRadioValue(WebDriver driver, String tabName, String value, String radioName, String... paneName) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        String[] elementType;
        String fieldPath;
        String fieldMethod;
        String paneFrames;
        String selectBy = "";
        radioName = radioName.replace(" ", "");
        UtilFunctions.log("Radio name: " + radioName);
        elementType = UtilFunctions.getElementStringAndType(fileObj, "RADIOS." + radioName);
        fieldPath = elementType[0];
        fieldMethod = elementType[1];
        UtilFunctions.log("Radio field path: " + fieldPath);
        UtilFunctions.log("Radio field method: " + fieldMethod);

        if (paneName.length > 0)
            paneFrames = UtilFunctions.getFrameValue(frameMap,
                    UtilFunctions.getElementFromJSONFile(fileObj,
                            "PANES." + paneName[0].replace(" ", ""), "frame"));
        else
            paneFrames = UtilFunctions.getFrameValue(frameMap,
                    UtilFunctions.getElementFromJSONFile(fileObj,
                            "RADIOS." + radioName, "frame"));

        UtilFunctions.log("PaneFrames: " + paneFrames);
        SeleniumFunctions.selectFrame(driver, paneFrames, "id");
        try {
            selectBy = UtilFunctions.getElementFromJSONFile(fileObj, "RADIOS." + radioName, "select_by");
            if (selectBy == null)
                selectBy = "";
        } catch (Exception e) {
            UtilFunctions.log("Select by set to null.");
            selectBy = "";
        }
        return setRadio(driver, fieldPath, selectBy, value);
    }


    /**************************************************************************
     * name: setRadio(WebDriver driver, String fieldPath, String selectBy,
     * String value)
     * functionality: Function to generate radio button xpath, find object and
     * click on the button
     * param: WebDriver driver - WebDriver object
     * param: String fieldPath - Name of radio field
     * param: String selectBy - Radio button selecting criteria
     * param: String value - Radio button display text
     * return: boolean
     *************************************************************************/
    public static boolean setRadio(WebDriver driver, String fieldPath, String selectBy, String value) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        String xPath;
        String radioPos;
        switch (selectBy) {
            case "value":
                xPath = "//input[@type='radio' and @name='" + fieldPath + "' and (@value='" + value + "' or @displaylabel='" + value + "')]";
                break;
            case "label":
                xPath = "//input[@type='radio' and (@displaylabel='" + value + "' or following-sibling::label[text()='" + value + "'])]";
                break;
            case "span":
                xPath = "//input[@type='radio' and following-sibling::span[text()='" + value + "']]";
                break;
            case "xpath":
                xPath = fieldPath;
                break;
            case "position":
                if (value.toLowerCase().equals("yes")) {
                    radioPos = "1";
                } else {
                    radioPos = "2";
                }
                xPath = "//input[@type='radio' and @name='" + fieldPath + "' and position()='" + radioPos + "']";
                break;
            default:
                xPath = "//input[@type='radio' and @name='" + fieldPath + "' and (@value='" + value + "' or @displaylabel='" + value + "')]";
                break;
        }
        UtilFunctions.log("selectBy: " + selectBy);
        UtilFunctions.log("xpath: " + xPath);
        SeleniumFunctions.explicitWait(driver, GlobalConstants.FIVE, xPath + ";" + "xpath");
        WebElement element = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(xPath + ";" + "xpath"));
        if (element != null) {
            try {
                element.click();
                if (!SeleniumFunctions.isSelected(element)) {
                    SeleniumFunctions.click(element);
                    if (!SeleniumFunctions.isSelected(element)) {
                        Actions actions = new Actions(Hooks.getDriver());
                        actions.moveToElement(element).click().build().perform();
                        if (!SeleniumFunctions.isSelected(element)) {
                            UtilFunctions.log("Radio name: '" + fieldPath + "' with value: '" + value
                                    + "' is not clicked.  Returning false...");
                            return false;
                        }
                    }
                }
            } catch (ElementNotInteractableException e) {
                UtilFunctions.log("Radio name: '" + fieldPath + " not clickd due to: " + e.getMessage() +
                        ". Trying again w/ JS click");
                e.printStackTrace();
                SeleniumFunctions.click(element);
                if (!SeleniumFunctions.isSelected(element)) {
                    Actions actions = new Actions(Hooks.getDriver());
                    actions.moveToElement(element).click().build().perform();
                    if (!SeleniumFunctions.isSelected(element)) {
                        UtilFunctions.log("Radio name: '" + fieldPath + "' with value: '" + value
                                + "' is not clicked.  Returning false...");
                        return false;
                    }
                }
            }

            UtilFunctions.log("Radio name: '" + fieldPath + "' with value: '" + value + "' is not null and clicked on 1st try. Returning true.");
            System.out.println("Radio name: '" + fieldPath + "' with value: '" + value + "' is not null and clicked on 1st try. Returning true.");
            return true;
        } else {//find the element again and try again
            element = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(xPath + ";" + "xpath"));
            if (element != null) {
                try {
                    element.click();
                    if (!SeleniumFunctions.isSelected(element)) {
                        SeleniumFunctions.click(element);
                        if (!SeleniumFunctions.isSelected(element)) {
                            Actions actions = new Actions(Hooks.getDriver());
                            actions.moveToElement(element).click().build().perform();
                            if (!SeleniumFunctions.isSelected(element)) {
                                UtilFunctions.log("Radio name: '" + fieldPath + "' with value: '" + value
                                        + "' is not clicked.  Returning false...");
                                return false;
                            }
                        }
                    }
                } catch (ElementNotInteractableException e) {
                    UtilFunctions.log("Radio name: '" + fieldPath + " not clickd due to: " + e.getMessage() +
                            ". Trying again w/ JS click");
                    e.printStackTrace();
                    SeleniumFunctions.click(element);
                    if (!SeleniumFunctions.isSelected(element)) {
                        Actions actions = new Actions(Hooks.getDriver());
                        actions.moveToElement(element).click().build().perform();
                        if (!SeleniumFunctions.isSelected(element)) {
                            UtilFunctions.log("Radio name: '" + fieldPath + "' with value: '" + value
                                    + "' is not clicked.  Returning false...");
                            return false;
                        }
                    }
                }
                UtilFunctions.log("Radio name: '" + fieldPath + "' with value: '" + value + "' is not null and clicked on 2nd try. Returning true.");
                System.out.println("Radio name: '" + fieldPath + "' with value: '" + value + "' is not null and clicked on 2nd try. Returning true.");
                return true;
            } else {
                UtilFunctions.log("Radio name: '" + fieldPath + "' with value: '" + value + "' is null. Returning false.");
                System.out.println("Radio name: '" + fieldPath + "' with value: '" + value + "' is null. Returning false.");
                return false;
            }
        }
        /*if (element != null) {
            ((JavascriptExecutor) driver).executeScript("arguments[0].click();", element);
            if (!element.isSelected() || !element.getAttribute("class").contains("is-checked"))
                element.click();
            UtilFunctions.log("Radio name: '" + fieldPath + "' with value: '" + value + "' is not null and clicked on 1st try. Returning true.");
            System.out.println("Radio name: '" + fieldPath + "' with value: '" + value + "' is not null and clicked on 1st try. Returning true.");
            return true;
        } else {
            element = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(xPath + ";" + "xpath"));
            if (element != null) {
                ((JavascriptExecutor) driver).executeScript("arguments[0].click();", element);
                if (!element.isSelected())
                    element.click();
                UtilFunctions.log("Radio name: '" + fieldPath + "' with value: '" + value + "' is not null and clicked on 2nd try. Returning true.");
                System.out.println("Radio name: '" + fieldPath + "' with value: '" + value + "' is not null and clicked on 2nd try. Returning true.");
                return true;
            } else {
                UtilFunctions.log("Radio name: '" + fieldPath + "' with value: '" + value + "' is null. Returning false.");
                System.out.println("Radio name: '" + fieldPath + "' with value: '" + value + "' is null. Returning false.");
                return false;
            }
        }*/
    }


    /**************************************************************************
     * name: setRadio(WebDriver driver, String path, String method
     * functionality: Function to click on radio button
     * param: WebDriver driver - WebDriver object
     * param: String path - Name of radio field
     * param: String method - Select criteria such as xpath, id, name, etc.
     * return: boolean
     *************************************************************************/
    public static boolean setRadio(WebDriver driver, String path, String method) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        WebElement element = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(path + ";" + method));
        if (element == null) {
            UtilFunctions.log("Radio with path: '" + path + "' object is null. Returning false.");
            return false;
        } else {
            element.click();
            UtilFunctions.log("Radio with path: '" + path + "' object is not null and clicked. Returning true.");
            return true;
        }
    }


    /**************************************************************************
     * name: clickLinkText(WebDriver driver, String tabName, String link,
     * String pane)
     * functionality: Function to click on link
     * param: WebDriver driver - WebDriver object
     * param: String tabName - Name of tab
     * param: String link - Link display text
     * param: String pane - Parameter for pane name
     * return: boolean
     *************************************************************************/
    public static boolean clickLinkText(WebDriver driver, String tabName, String link, String pane,
                                        String sectionName, String category) {

        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);

        WebElement linkElement;

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        String paneFrames = UtilFunctions.getFrameValue(frameMap,
                UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + pane, "frame"));
        UtilFunctions.log("PaneFrames" + paneFrames);
        SeleniumFunctions.selectFrame(driver, paneFrames, "id");

        if (sectionName == "") {
            if (category == null)
                linkElement = findLinkText(driver, "Edit", "a", "td[contains(span, '" + link +
                        "') or starts-with(normalize-space(./text()), '" + link + "')]");
            else
                linkElement = findLinkText(driver, "Edit", "td", "tr[@description='" + link + "']");
        } else if (sectionName == null)
            linkElement = findLinkText(driver, link, "", "");
        else {
            String sectionPath = UtilFunctions.getElementFromJSONFile(fileObj, "PANE_SECTIONS." +
                    sectionName.replace(" ", ""), "path");
            linkElement = findLinkText(driver, link, "", sectionPath);
        }

        if (linkElement == null) {
            UtilFunctions.log("Link: '" + link + "' object is null. Returning false.");
            return false;
        } else {
//            linkElement.click();
            try {
                int linkClickCnt = 0;
                while (linkElement.isDisplayed()) {
                    linkClickCnt++;
                    UtilFunctions.sleep(500);
                    linkElement.click();
                    UtilFunctions.sleep(500);
                    if (linkClickCnt >= GlobalConstants.ONE) {
                        UtilFunctions.log("Link: '" + link + "' clicked. Returning true.");
                        return true;
                    } else {
                        UtilFunctions.log("Waiting for Link: '" + link + "' to be clicked.");
                        Thread.sleep(1000);
                    }
                }
            } catch (StaleElementReferenceException e) {
                System.out.println(e.getMessage());
                UtilFunctions.log("Link clicked and no longer visible.");
            } catch (InterruptedException | WebDriverException e) {
                e.printStackTrace();
                UtilFunctions.log("Link not clicked due to Exception: " + e.getMessage());
                System.out.println("Link not clicked due to Exception: " + e.getMessage());
            } catch (Exception e) {
                e.printStackTrace();
                count++;
                UtilFunctions.log("Link not clicked due to Exception: " + e.getMessage());
                System.out.println("Link not clicked due to Exception: " + e.getMessage());
                if (count <= GlobalConstants.ONE) {
                    clickLinkText(driver, tabName, link, pane, sectionName, category);
                } else
                    count = 0;
            }
            UtilFunctions.log("Link: '" + link + "' object not null and clicked. Returning true.");
            System.out.println("Link: '" + link + "' object not null and clicked. Returning true.");
            return true;
        }
    }


    /**************************************************************************
     * name: clickLinkText(WebDriver driver, String selectName)
     * functionality: Function to click on link text
     * param: WebDriver driver - WebDriver object
     * param: String selectName - Name of link to be clicked
     * return: boolean
     *************************************************************************/
    public static boolean clickLinkText(WebDriver driver, String selectName) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        WebElement linkObj = findLinkText(driver, selectName, "", "");
        if (linkObj == null) {
            UtilFunctions.log("Link text: '" + selectName + "' object is null. Returning false.");
            return false;
        } else {
            linkObj.click();
            UtilFunctions.log("Link text: '" + selectName + "' object not null and clicked. Returning true.");
            return true;
        }
    }


    /**************************************************************************
     * Find link via text and click it
     *
     * @param driver WebDriver object
     * @param text name of link text
     * @param tag tg of link
     * @param section section of xpath value
     * @return WebElement
     *************************************************************************/
    public static WebElement findLinkText(WebDriver driver, String text, String tag, String section) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        if (tag.equals(""))
            tag = "*";
        String xpath = "//" + tag + "[starts-with(normalize-space(./text()), '" + text + "')";
        if (!section.equals("")) {
            xpath += " and ancestor::" + section;
        }
        xpath += "]";
        if (xpath.contains(":://"))
            xpath = xpath.replace(":://", "::");
        UtilFunctions.log("Link text: '" + text + "'; xPath: '" + xpath + "'. Returning object of the link text.");
        SeleniumFunctions.explicitWait(driver, GlobalConstants.TWENTY, xpath + ";xpath");
        return SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(xpath + ";xpath"));
    }


    /**************************************************************************
     * Verify a list of links exist within a pane
     *
     * @param driver the WebDriver object
     * @param curTabName name of the currently selected tab
     * @param paneName the name of the pane comb for links
     * @param dataTable the list of links to search for
     * @return boolean
     *************************************************************************/
    public static boolean verifyLinks(WebDriver driver, String curTabName, String paneName, DataTable dataTable) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        boolean allLinksFound = true;

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        String paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName.replace(" ", ""), "frame"));
        SeleniumFunctions.selectFrame(driver, paneFrames, "id");

        List<String> dataList = dataTable.asList(String.class);
        for (String link : dataList) {
            if (findLinkText(driver, link, "", "") == null) {
                UtilFunctions.log("Link \"" + link + "\" not found in pane: " + paneName);
                allLinksFound = false;
            }
        }

        return allLinksFound;
    }


    /**************************************************************************
     * name: checkUnCheckTableBox(WebDriver driver, String tabName,
     * String tableName, String value, String where)
     * functionality: Function to check/un-check all checkboxes present in a
     * table
     * param: WebDriver driver - WebDriver object
     * param: String tabName - Name of tab
     * param: String tableName - Name of table containing checkboxes
     * param: String value - "On" or "Off", based on required result
     * param: String where - Place where checkbox is present, i.e. server
     * or at default location
     * return: returns "" string if successful
     *************************************************************************/
    public static String checkUnCheckTableBox(WebDriver driver, String tabName, String tableName, String value, String where) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);
        UtilFunctions.log("Table Name: " + tableName);
        UtilFunctions.log("Checkbox value: " + value);
        UtilFunctions.log("Checkbox location: " + where);

        tableName = tableName.replace(" ", "");
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        String checkBoxName;
        String failMessage = "";
        String paneFrames = (String) frameMap.get(UtilFunctions.getElementFromJSONFile(fileObj, "TABLES." +
                tableName, "frame"));
        String tablePath = UtilFunctions.getElementFromJSONFile(fileObj, "TABLES." + tableName, "path");
        String tableBody = UtilFunctions.getElementFromJSONFile(fileObj, "TABLES." + tableName, "body");

        UtilFunctions.log("PaneFrames: " + paneFrames);
        UtilFunctions.log("TablePath" + tablePath);
        UtilFunctions.log("TableBody" + tableBody);

        SeleniumFunctions.selectFrame(driver, paneFrames, "id");
        WebElement tableElement = findTable(driver, tablePath);
        if (tableElement == null) {
            failMessage += tablePath + " element not found.";
            UtilFunctions.log("Returning: " + failMessage);
            return failMessage;
        } else {
            WebElement tableBodyObj = findTableBody(tableElement, tableBody);
            if (tableBodyObj == null) {
                failMessage += tableBody + " element not found.";
                UtilFunctions.log(failMessage);
            } else {
                List<WebElement> rows = SeleniumFunctions.findElementsByWebElement(tableBodyObj, SeleniumFunctions.setByValues("tr;xpath"));
                switch (where) {
                    case "server":
                        checkBoxName = "starts-with(@name, 's')";
                        break;
                    default:
                        checkBoxName = "starts-with(@name, 'h')";
                }

                for (WebElement row : rows) {
                    WebElement checkBox = SeleniumFunctions.findElementByWebElement(row, SeleniumFunctions.setByValues(".//input[(@type='checkbox' or @type='Checkbox') and " + checkBoxName + "]"));
                    if (checkBox == null) {
                        failMessage = failMessage + "CheckBox:: " + row.getText() + " is not present.";
                        UtilFunctions.log(failMessage);
                    } else {
                        if (value.equals("on") && !checkBox.isSelected()) {
                            checkBox.click();
                            UtilFunctions.log("Checkbox: " + checkBox.getText() + " is clicked.");
                        } else if (!value.equals("on") && checkBox.isSelected()) {
                            checkBox.click();
                            UtilFunctions.log("Checkbox: " + checkBox.getText() + " is clicked.");
                        }
                    }
                }
            }
            UtilFunctions.log("Returning: " + failMessage);
            return failMessage;
        }

    }

    /**
     * clickDropdown(String dropdownName, String curTabName, String paneName)
     * <p>
     * Clicks/opens any kind of dropdown, PKOmniSelect, Select, omni-select, etc.
     *
     * @param dropdownName - name of dropdown to open/click
     * @param curTabName   - name of current tab you're on
     * @param paneName     - name of pane dropdown is in, optional
     * @return bool whether dropdown is clicked and opened or not
     */
    public static boolean clickDropdown(String dropdownName, String curTabName, String paneName) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        dropdownName = dropdownName.replace(" ", "");

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        String paneFrames;
        if (paneName == null) {
            paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj,
                    "DROPDOWNS." + dropdownName, "frame"));
        } else {
            paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj,
                    "PANES." + paneName.replace(" ", ""), "frame"));
        }
        UtilFunctions.log("PaneFrames: " + paneFrames);
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");

        String[] elementType = UtilFunctions.getElementStringAndType(fileObj, "DROPDOWNS." + dropdownName);
        String dropdownPath = elementType[0];
        String dropdownSelector = elementType[1];
        UtilFunctions.log("dropdownPath: " + dropdownPath);
        UtilFunctions.log("dropdown By Selector: " + dropdownSelector);

        boolean dropdownClicked = false;
        WebElement dropdownEl = SeleniumFunctions.findElement(Hooks.getDriver(), By.xpath(dropdownPath));

        if (dropdownEl == null) {
            UtilFunctions.log("Dropdown: '" + dropdownName + "' not found. Returning false.");
        } else {
            //try regular web driver .click()
            try {
                UtilFunctions.sleep(1000);
                dropdownEl.click();
                UtilFunctions.sleep(1000);
                dropdownClicked = true;
                UtilFunctions.log("Dropdown: '" + dropdownName + "' clicked and opened. Returning true.");
            } catch (ElementNotInteractableException ex) {
                //Else try JS style click
                UtilFunctions.log("Dropdown: '" + dropdownName + " not clicked due to exception: " +
                        ex.getMessage() +
                        "\nTrying again with SeleniumFunctions.click()");
                UtilFunctions.sleep(1000);
                SeleniumFunctions.click(dropdownEl);
                UtilFunctions.sleep(1000);
                //Sometimes the SeleniumFunctions.click(dropdownEl) is 'passing' but the element is not actually
                //getting clicked.  Make sure the element has a dynamic class/state added that changes state to clicked
                //before returning true.
                if (SeleniumFunctions.isSelected(dropdownEl)) {
                    dropdownClicked = true;
                    UtilFunctions.log("Dropdown: '" + dropdownName + "' clicked and opened. Returning true.");
                } else {
                    //Else try Actions builder style click
                    UtilFunctions.log("Dropdown: '" + dropdownName + " not clicked with JS click. " +
                            "\nTrying again with Actions builder.");

                    Actions action = new Actions(Hooks.getDriver());
                    UtilFunctions.sleep(1000);
                    action.moveToElement(dropdownEl).click().build().perform();
                    UtilFunctions.sleep(1000);
                    dropdownClicked = true;

                    UtilFunctions.log("Dropdown: '" + dropdownName + "' clicked and opened. Returning true.");
                }//end if selected
            }//end try - catch
        }//end if dropdownEl == null

        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
        return dropdownClicked;
    }


    /**************************************************************************
     * name: setCheckBox(WebDriver driver, String curTabName,
     * String checkBoxName, String checkType, String... paneName)
     * functionality: Function to check/un-check checkboxes
     * param: WebDriver driver - WebDriver object
     * param: String curTabName - Name of current tab
     * param: String checkBoxName - Name of checkbox
     * param: String checkType - Type of check, i.e. check or uncheck
     * param: String... paneName - Optional parameter for pane name
     * return: boolean
     *************************************************************************/
    public static boolean setCheckBox(WebDriver driver, String curTabName, String checkBoxName, String checkType,
                                      String paneName) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + curTabName);
        UtilFunctions.log("Checkbox name: " + checkBoxName);
        UtilFunctions.log("CheckType: " + checkType);

//        checkBoxName = checkBoxName.replace(" ", "");
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        String paneFrames;

        if (!curTabName.equals("")) {
            String[] elementType = UtilFunctions.getElementStringAndType(fileObj, "CHECKBOXES." +
                    checkBoxName.replace(" ", ""));
            String chBoxValue = elementType[0];
            String chBoxMethod = elementType[1];
            if (chBoxValue == null && chBoxMethod == null) {
                chBoxValue = checkBoxName.split(";")[0];
                chBoxMethod = checkBoxName.split(";")[1];
            }
            UtilFunctions.log("CheckBox value: " + chBoxValue);
            UtilFunctions.log("CheckBox method: " + chBoxMethod);

            if (paneName == null) {
                paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj,
                        "CHECKBOXES." + checkBoxName.replace(" ", ""), "frame"));
            } else {
                paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj,
                        "PANES." + paneName.replace(" ", ""), "frame"));
            }

            if (paneFrames != null) {
                UtilFunctions.log("PaneFrames: " + paneFrames);
                SeleniumFunctions.selectFrame(driver, paneFrames, "id");
            } else {
                UtilFunctions.log("No Frame for this checkbox");
            }

            UtilFunctions.log("PaneFrames: " + paneFrames);

            //Returning true/false when Exception is not observed.
            //Trying to perform action on checkbox for second time in case StaleElementReferenceException occurs.
            try {
                return performActionOnCheckBox(driver, checkBoxName, checkType, chBoxValue, chBoxMethod);
            } catch (Exception e) {
                UtilFunctions.log("StaleElementReferenceException observed while performing Action on CheckBox." +
                        " Trying again. StaleElementReferenceException: " + e.getMessage());
                e.printStackTrace();
                return performActionOnCheckBox(driver, checkBoxName, checkType, chBoxValue, chBoxMethod);
            }
        } else {
            UtilFunctions.log("Current tab : '" + curTabName + "' name is null. Returning false.");
            return false;
        }
    }


    //TODO: Refactor -- this isn't working
    public static boolean performActionOnCheckBox(WebDriver driver, String checkBoxName, String checkType,
                                                  String chBoxValue, String chBoxMethod) throws StaleElementReferenceException {

        WebElement checkBoxObj = findCheckBoxObj(driver, chBoxValue, chBoxMethod);

        if (checkBoxObj != null) {
            boolean setCheckboxSuccess = true;
            if (checkBoxObj.isSelected() && checkType.equals("uncheck")) {
                int retryCount = 0;
                while (checkBoxObj.isSelected()) {
                    if (retryCount >= 5) {
                        UtilFunctions.log("Unable to un-check checkbox after 5 attempts. " +
                                " Breaking out of retry loop.");
                        setCheckboxSuccess = false;
                        break;
                    }
                    UtilFunctions.log("Trying to un-check checkbox");
                    System.out.println("checkBoxObj.isDisplayed():  " + checkBoxObj.isDisplayed());
                    System.out.println("checkBoxObj.isEnabled(): " + checkBoxObj.isEnabled());
                    try {
                        UtilFunctions.sleep(500);
                        checkBoxObj.click();
                        UtilFunctions.sleep(500);
                    } catch (ElementNotInteractableException e) {
                        UtilFunctions.log(checkBoxName + " checkbox not unchecked due to: " + e.getMessage()
                                + ".  Trying again with JS click.");
                        e.printStackTrace();
                        SeleniumFunctions.click(checkBoxObj);
                    }
                    checkBoxObj = findCheckBoxObj(driver, chBoxValue, chBoxMethod);
                    retryCount += 1;
                }
            } else if (!checkBoxObj.isSelected() && checkType.equals("check")) {
                int retryCount = 0;
                while (!checkBoxObj.isSelected()) {
                    if (retryCount >= 5) {
                        UtilFunctions.log("Unable to check checkbox after 5 attempts. " +
                                " Breaking out of retry loop.");
                        setCheckboxSuccess = false;
                        break;
                    }
                    UtilFunctions.log("Trying to check checkbox");
                    System.out.println(checkBoxObj.isDisplayed());
                    System.out.println(checkBoxObj.isEnabled());
                    try {
                        UtilFunctions.sleep(500);
                        checkBoxObj.click();
                        UtilFunctions.sleep(500);
                    } catch (ElementNotInteractableException e) {
                        UtilFunctions.log(checkBoxName + " checkbox not checked due to: " + e.getMessage()
                                + ".  Trying again with JS click.");
                        e.printStackTrace();
                        SeleniumFunctions.click(checkBoxObj);
                    }
                    checkBoxObj = findCheckBoxObj(driver, chBoxValue, chBoxMethod);
                    retryCount += 1;
                }
            }
            if (setCheckboxSuccess) {
                UtilFunctions.log("Action performed on checkbox: '" + checkBoxName + "' is '" + checkType +
                        "'. Returning true.");
                return true;
            } else {
                UtilFunctions.log("Action failed on checkbox: '" + checkBoxName + "' is not '" + checkType +
                        "'. Returning false.");
                return false;
            }
        } else {
            UtilFunctions.log("Checkbox: '" + checkBoxName + "' object is null. Returning false.");
            return false;
        }
    }

    /*This method seems always to pass, even when it should fail.  For example, if a checkbox is supposed to be checked in the
        UI and it's not checked in the UI, this method will still pass.  Refactoring to try and prevent this. -- HIC 3/2719*/
    public static boolean getCheckBoxStatus(WebDriver driver, String curTabName, String checkBoxName, String checkType,
                                            String paneName) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + curTabName);
        UtilFunctions.log("Checkbox name: " + checkBoxName);
        UtilFunctions.log("CheckType: " + checkType);

        checkBoxName = checkBoxName.replace(" ", "");
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        String paneFrames;

        if (!curTabName.equals("")) {
            String[] elementType = UtilFunctions.getElementStringAndType(fileObj,
                    "CHECKBOXES." + checkBoxName);
            String chBoxValue = elementType[0];
            String chBoxMethod = elementType[1];
            UtilFunctions.log("CheckBox value: " + chBoxValue);
            UtilFunctions.log("CheckBox method: " + chBoxMethod);

            if (paneName == null || paneName == "") {
                paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj,
                        "CHECKBOXES." + checkBoxName, "frame"));
            } else {
                paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj,
                        "PANES." + paneName.replace(" ", ""), "frame"));
            }

            UtilFunctions.log("PaneFrames: " + paneFrames);
            SeleniumFunctions.selectFrame(driver, paneFrames, "id");
            WebElement checkBoxObj = findCheckBoxObj(driver, chBoxValue, chBoxMethod);

            if (checkBoxObj != null) {
                switch (checkType) {
                    case "unchecked":
                        if (checkBoxObj.isSelected()) {
                            UtilFunctions.log("Checkbox: '" + checkBoxName +
                                    "' is selected when it should be UNchecked. Returning false.");
                            System.out.println("Checkbox: '" + checkBoxName +
                                    "' is selected when it should be UNchecked. Returning false.");
                            return false;
                        } else {
                            UtilFunctions.log("Checkbox: '" + checkBoxName +
                                    "' is NOT selected. Returning true.");
                            System.out.println("Checkbox: '" + checkBoxName +
                                    "' is NOT selected. Returning true.");
                            return true;
                        }
                    case "checked":
                        if (!checkBoxObj.isSelected()) {
                            UtilFunctions.log("Checkbox: '" + checkBoxName +
                                    "' is NOT selected when it should be checked. Returning false.");
                            System.out.println("Checkbox: '" + checkBoxName +
                                    "' is NOT selected when it should be checked. Returning false.");
                            return false;
                        } else {
                            UtilFunctions.log("Checkbox: '" + checkBoxName +
                                    "' is selected. Returning true.");
                            System.out.println("Checkbox: '" + checkBoxName +
                                    "' is selected. Returning true.");
                            return true;
                        }
                    default: //checkType == null (which means checkType should be checked?)
                        if (!checkBoxObj.isSelected()) {
                            UtilFunctions.log("Checkbox: '" + checkBoxName +
                                    "' is NOT selected when it should be checked. Returning false.");
                            System.out.println("Checkbox: '" + checkBoxName +
                                    "' is NOT selected when it should be checked. Returning false.");
                            return false;
                        } else {
                            UtilFunctions.log("Checkbox: '" + checkBoxName +
                                    "' is selected. Returning true.");
                            System.out.println("Checkbox: '" + checkBoxName +
                                    "' is selected. Returning true.");
                            return true;
                        }
                }
                /*if (checkBoxObj.isSelected() && checkType == null) {
                    UtilFunctions.log("Checkbox: '" + checkBoxName + "' is selected. Returning true.");
                    return true;
                }
                else if (checkBoxObj.isSelected() && checkType.equals("un")) {
                    UtilFunctions.log("Checkbox: '" + checkBoxName + "' is selected. It should be unchecked. Returning false.");
                    return false;
                }
                else if (!checkBoxObj.isSelected() && checkType == null) {
                    UtilFunctions.log("Checkbox: '" + checkBoxName + "' is not selected. It should be checked. Returning false.");
                    return false;
                }
                else if (!checkBoxObj.isSelected() && checkType.equals("un")) {
                    UtilFunctions.log("Checkbox: '" + checkBoxName + "' is not selected. Returning true.");
                    return true;
                }
                UtilFunctions.log("Action performed on checkbox: '" + checkType + "'. Returning true.");
                return true;*/
            } else {
                UtilFunctions.log("Checkbox: '" + checkBoxName + "' object is null. Returning false.");
                return false;
            }
        } else {
            UtilFunctions.log("Current tab : '" + curTabName + "' name is null. Returning false.");
            return false;
        }
    }//end getCheckBoxStatus


    /**************************************************************************
     * name: findTable(WebDriver driver, String tablePath)
     * functionality: Function to find table element
     * param: WebDriver driver - WebDriver object
     * param: String tablePath - Xpath of table
     * return: returns table object
     *************************************************************************/
    public static WebElement findTable(WebDriver driver, String tablePath) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        SeleniumFunctions.explicitWait(driver, GlobalConstants.LONG_TIMEOUT, tablePath + ";xpath");
        WebElement tableObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(tablePath + ";xpath"));
        if (tableObj == null) {
            UtilFunctions.log("tableObj is null in first check itself. Returning null.");
            return null;
        }
        try {
            UtilFunctions.log("First Check whether tableObj displayed or not. Displayed property: " + tableObj.isDisplayed());
            if (tableObj.isDisplayed()) {
                UtilFunctions.log("tableObj is displayed. Returning tableObj.");
                return tableObj;
            }
            UtilFunctions.log("tableObj not displayed. Checking again.");
        } catch (Exception e) {
            UtilFunctions.log("First Exception for tableObj. Exception: " + e.getMessage());
        }
        try {
            List<WebElement> tableElementObj = SeleniumFunctions.findElements(driver, SeleniumFunctions.setByValues(tablePath + ";xpath"));
            for (WebElement tableEle : tableElementObj) {
                UtilFunctions.log("Second Check whether tableEle displayed or not. Displayed property: " + tableEle.isDisplayed());
                if (tableEle.isDisplayed()) {
                    UtilFunctions.log("tableEle is displayed. Returning tableEle.");
                    return tableEle;
                }
            }
        } catch (Exception e) {
            UtilFunctions.log("Second Exception for tableElementObj. Exception: " + e.getMessage());
        }
        UtilFunctions.log("tableObj is not displayed. Returning null.");
        return null;
    }

    /**************************************************************************
     * name: findTable(WebDriver driver, String tabName, String tableName)
     * functionality: Function to find and return table object
     * param: WebDriver driver - WebDriver object
     * param: String tabName - Name of tab
     * param: String tableName - Name of table
     * return: returns the table's object
     *************************************************************************/
    public static WebElement findTable(WebDriver driver, String tabName, String tableName) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);

        tableName = tableName.replace(" ", "");
        System.out.println("tableName:" + tableName);
        UtilFunctions.log("tableName: " + tableName);

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        String tablePath = UtilFunctions.getElementFromJSONFile(fileObj,
                "TABLES." + tableName, "path");
        UtilFunctions.log("table's xPath: " + tablePath);

        String tableFrames = UtilFunctions.getFrameValue(frameMap,
                UtilFunctions.getElementFromJSONFile(fileObj, "TABLES." + tableName, "frame"));
        System.out.println("tableFrames: " + tableFrames);
        UtilFunctions.log("tableFrames: " + tableFrames);

        SeleniumFunctions.selectFrame(driver, tableFrames, "id");
        SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, tablePath + ";" + "xpath");

        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        return SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(tablePath + ";" + "xpath"));
    }

    public static WebElement findInputElement(WebDriver driver, String tabName, String inputName) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        inputName = inputName.replace(" ", "");
        System.out.println("Finding input element: " + inputName);
        UtilFunctions.log("Finding input element:" + inputName);

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        String inputXpath = UtilFunctions.getElementFromJSONFile(fileObj,
                "BUTTONS." + inputName, "path");
        UtilFunctions.log("Input element's xpath: " + inputXpath);
        System.out.println("Input element's xpath: " + inputXpath);

        String inputFrame = UtilFunctions.getFrameValue(frameMap,
                UtilFunctions.getElementFromJSONFile(fileObj, "BUTTONS." + inputName, "frame"));
        System.out.println("Input element's frame: " + inputFrame);
        UtilFunctions.log("Input element's frame: " + inputFrame);

        SeleniumFunctions.selectFrame(driver, inputFrame, "id");
        SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, inputXpath + ";" + "xpath");

        return SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(inputXpath + ";xpath"));
    }


    public static boolean importFile(WebElement inputElement, String filePath) {
        try {
            inputElement.sendKeys(filePath);
            UtilFunctions.log("Successfully imported file: " + filePath);
            System.out.println("Successfully imported file: " + filePath);
            return true;
        } catch (Exception e) {
            UtilFunctions.log("Import failed for file: " + filePath + " due to exception: " + e.getMessage());
            System.out.println("Import failed for file: " + filePath + " due to exception: " + e.getMessage());
            return false;
        }
    }

    /**************************************************************************
     * name: findTableBody(WebElement element, String tableBody)
     * functionality: Function to find table body
     * param: WebDriver driver - WebDriver object
     * param: String tableBody - Xpath of table body
     * return: returns table body object
     *************************************************************************/
    public static WebElement findTableBody(WebElement element, String tableBody) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        return SeleniumFunctions.findElementByWebElement(element, SeleniumFunctions.setByValues(".//" + tableBody + ";xpath"));
    }


    public static WebElement findTableHead(WebElement element, String tableHead) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        return SeleniumFunctions.findElementByWebElement(element, SeleniumFunctions.setByValues(tableHead + ";xpath"));
    }


    /**************************************************************************
     * name: selectFromPKActionsMenu(WebDriver driver, String menu,
     * String value, String curTabName, String elementName, String elementType)
     * functionality: Function to select and check whether element exists
     * after item is selected from Actions menu
     * param: WebDriver driver - WebDriver object
     * param: String menu - Name of PK menu
     * param: String value - Name of menu
     * param: String curTabName - Name of current tab
     * param: String elementName - Name of element to check whether existing
     * or not
     * param: String elementType - Type of element, i.e. BUTTONS, PANES, etc.
     * return: boolean
     *************************************************************************/
    public static boolean selectFromPKActionsMenu(WebDriver driver, String menu, String value, String curTabName, String elementName, String elementType) throws InterruptedException {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + curTabName);
        boolean output;
        int cntCheck = 0;
        do {
            UtilFunctions.log("Check count no: " + cntCheck);
            Page.selectFromPKActionsMenu(driver, menu, value, curTabName);
            Thread.sleep(5000);
            cntCheck++;
            String element = "PatientSearchSubmit";
            if (Page.checkElementExists(driver, curTabName, elementName, elementType) || Page.checkElementExists(driver, curTabName, element, elementType)) {
                UtilFunctions.log("Element: '" + elementName + "' ElementType: '" + elementType + "' present. Returning true.");
                output = true;
                break;
            }
            if (cntCheck > 4) {
                UtilFunctions.log("Element: '" + elementName + "' ElementType: '" + elementType + "' not present after '" + cntCheck + "' trials. Returning false.");
                output = false;
                break;
            }
        } while (true);
        return output;
    }


    /**************************************************************************
     * name: selectFromPKActionsMenu(WebDriver driver, String menu,
     * String value, String tabName)
     * functionality: Function to select item from Actions menu
     * param: WebDriver driver - WebDriver object
     * param: String menu - Name of PK menu
     * param: String value - Name of menu
     * param: String tabName - Name of current tab
     * return: boolean
     *************************************************************************/
    public static boolean selectFromPKActionsMenu(WebDriver driver, String menu, String value, String tabName) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);
        UtilFunctions.log("Menu: " + menu);
        UtilFunctions.log("Value: " + value);

        menu = menu.replace(" ", "");
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        String menuFrame = (String) frameMap.get(UtilFunctions.getElementFromJSONFile(fileObj, "PKMENUS." + menu, "frame"));
        String menuPath = UtilFunctions.getElementFromJSONFile(fileObj, "PKMENUS." + menu, "path");
        String menuID = UtilFunctions.getElementFromJSONFile(fileObj, "PKMENUS." + menu, "id");

        UtilFunctions.log("MenuPath: " + menuPath);
        UtilFunctions.log("MenuID: " + menuID);

        SeleniumFunctions.selectFrame(driver, menuFrame, "id");
        SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, menuPath + ";xpath");
        WebElement menuDropdown = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(menuPath + ";xpath"));
        if (menuDropdown == null) {
            UtilFunctions.log("Menu object is null. Returning false.");
            return false;
        } else {
            menuDropdown.click();
            //find the element with the menu object by the menuID
            //WebElement menuObj = SeleniumFunctions.findElement(driver, By.xpath("//ul[@id='" + menuID + "']"));
            //find the menu option to be selected and click it
            /*WebElement menuOption = SeleniumFunctions.findElement(driver,
                    By.xpath("//ul[@id='" + menuID + "']//li[@" + STD_MENU_ATTR + "='" + value + "']"));
            if (menuOption != null) {
                try {
                    menuOption.click();
                } catch (ElementNotInteractableException e) {
                    SeleniumFunctions.click(menuOption);//This is 'passing', but click is often not happening
                    *//*Actions actions = new Actions(driver);
                    actions.click(menuOption).perform();*//*
                }
            } else {*/
            //Try to find the menu option to be selected and click it w/ this JS string
            //NOTE: This often 'passes', yet the mouse actions never happen.
            JavascriptExecutor js = (JavascriptExecutor) driver;
            String jsStr = "var menu = document.getElementsByTagName('ul')['" + menuID + "'];" +
                    "var subMenus = menu.getElementsByTagName('ul');" +
                    "var subMenu, item;" +
                    "for (j = 0; j < subMenus.length; j++) {" +
                    "subMenu = subMenus[j];" +
                    "menuItems = subMenu.getElementsByTagName('li');" +
                    "for (i = 0; i < menuItems.length; i++) {" +
                    "item = menuItems[i];" +
                    "if (item.getAttribute('" + STD_MENU_ATTR + "').indexOf('" + value + "') > -1) {" +
                    "item.onclick = mainPage.menuItemSelected;" +
                    "try {" +
                    "evt = document.createEvent('MouseEvent');" +
                    "evt.initMouseEvent('click', true, true, window, 0, 0, 0, 0, 0, false, false, false, false, 0, null);" +
                    "item.dispatchEvent(evt);" +
                    "} catch (ex) {" +
                    "evt = document.createEventObject(window.event);" +
                    "evt.button = 1;" +
                    "item.fireEvent('onclick', evt);" +
                    "}" +
                    "break;" +
                    "}" +
                    "}" +
                    "}";
            js.executeScript(jsStr);
            UtilFunctions.log("Menu object not null. Executed java script function to click button. Returning true.");
            //}
            return true;
        }
    }


    /**************************************************************************
     * name: selectFromPatientListMenu(WebDriver driver, String menu,
     * String value, String tabName)
     * functionality: Function to select item from patient list menu
     * param: WebDriver driver - WebDriver object
     * param: String menu - Name of PK menu
     * param: String value - Name of menu
     * param: String tabName - Name of current tab
     * param: String pane - Name of pane
     * return: boolean
     *************************************************************************/
    public static boolean selectFromPatientListMenu(WebDriver driver, String menu, String value, String tabName, String pane) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);
        UtilFunctions.log("Menu: " + menu);
        UtilFunctions.log("Value: " + value);

        menu = menu.replace(" ", "");
        if (value.contains("'")) {
            value = value.replace("'", "\\'");
        }

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        String menuFrame = null;
        if (pane == null) {
            menuFrame = (String) frameMap.get(UtilFunctions.getElementFromJSONFile(fileObj, "PKMENUS." + menu, "frame"));
        } else {
            menuFrame = (String) frameMap.get(UtilFunctions.getElementFromJSONFile(fileObj,
                    "PANES." + pane.replace(" ", ""), "frame"));
        }
        SeleniumFunctions.selectFrame(driver, menuFrame, "id");

        String menuPath = UtilFunctions.getElementFromJSONFile(fileObj, "PKMENUS." + menu, "path");
        String menuID = UtilFunctions.getElementFromJSONFile(fileObj, "PKMENUS." + menu, "id");
        UtilFunctions.log("MenuPath: " + menuPath);
        UtilFunctions.log("MenuID: " + menuID);
        SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, menuPath + ";xpath");

        WebElement menuObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(menuPath + ";xpath"));
        if (menuObj == null) {
            UtilFunctions.log("Menu object is null. Returning false.");
            return false;
        } else {
            menuObj.click();
            UtilFunctions.sleep(500);
            JavascriptExecutor js = (JavascriptExecutor) driver;
            String jsStr = "menu = document.getElementsByTagName('ul')['" + menuID + "'];" +
                    "menuItems = menu.getElementsByTagName('li');" +
                    "var item;" +
                    "for (i = 0; i < menuItems.length; i++) {" +
                    "item = menuItems[i];" +
                    "if (item.innerText.replace(/^\\s*/, \"\") == '" + value + "') {" +
                    "item.onclick = mainPage.menuItemSelected;" +
                    "try {" +
                    "evt = document.createEvent('MouseEvent');" +
                    "evt.initMouseEvent('click', true, true, window, 0, 0, 0, 0, 0, false, false, false, false, 0, null);" +
                    "item.dispatchEvent(evt);" +
                    "} catch (ex) {" +
                    "evt = document.createEventObject(window.event);" +
                    "evt.button = 1;" +
                    "item.fireEvent('onclick', evt);" +
                    "}" +
                    "break;" +
                    "}" +
                    "}";
            js.executeScript(jsStr);
            UtilFunctions.sleep(500);
            //Verify list was selected.
            SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, menuPath.replace("]", " and text()='" + value + "']") + ";xpath");
            menuObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(menuPath + ";xpath"));

            if (menuObj.getAttribute("title").equals(value) || menuObj.getText().equals(value)) {
                UtilFunctions.log("Patient List '" + value + "'successfully selected.  Returning true.");
                return true;
            } else {
                UtilFunctions.log("Patient List '" + value + "'not found in Patient List Selection Menu.  Returning false.");
                return false;
            }
        }
    }


    /**************************************************************************
     * name: selectFromPKMenu(WebDriver driver, String menu, String value,
     * String tabName)
     * functionality: Function to select item from PK menu
     * param: WebDriver driver - WebDriver object
     * param: String menu - Name of PK menu
     * param: String value - Name of menu
     * param: String tabName - Name of current tab
     * return: boolean
     *************************************************************************/
    public static boolean selectFromPKMenu(WebDriver driver, String menu, String value, String tabName) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);
        UtilFunctions.log("Menu: " + menu);
        UtilFunctions.log("Value: " + value);

        menu = menu.replace(" ", "");
        if (value.contains("'")) {
            value = value.replace("'", "\\'");
        }
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        String menuFrame = (String) frameMap.get(UtilFunctions.getElementFromJSONFile(fileObj, "PKMENUS." + menu, "frame"));
        String paneframe = UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(GlobalStepdefs.curTabName, "PKMENUS", menu, "frame", "", "");
        String menuPath = UtilFunctions.getElementFromJSONFile(fileObj, "PKMENUS." + menu, "path");
        String menuID = UtilFunctions.getElementFromJSONFile(fileObj, "PKMENUS." + menu, "id");

        UtilFunctions.log("MenuPath: " + menuPath);
        UtilFunctions.log("MenuID: " + menuID);

        if (menuFrame != null) {
            SeleniumFunctions.selectFrame(driver, menuFrame, "id");
        } else {
            SeleniumFunctions.selectFrame(driver, paneframe, "id");
        }

        SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, menuPath + ";xpath");
        WebElement menuObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(menuPath + ";xpath"));
        if (menuObj == null) {
            UtilFunctions.log("Menu object is null. Returning false.");
            return false;
        } else {
            menuObj.click();
            UtilFunctions.sleep(500);
            JavascriptExecutor js = (JavascriptExecutor) driver;
            String jsStr = "var menu = document.getElementsByTagName('ul')['" + menuID + "'];" +
                    "var menuItems = menu.getElementsByTagName('li');" +
                    "var item;" +
                    "for (i = 0; i < menuItems.length; i++) {" +
                    "item = menuItems[i];" +
                    "if (item.getAttribute('" + STD_MENU_ATTR + "').indexOf('" + value + "') > -1) {" +
                    "item.onclick = mainPage.menuItemSelected;" +
                    "try {" +
                    "evt = document.createEvent('MouseEvent');" +
                    "evt.initMouseEvent('click', true, true, window, 0, 0, 0, 0, 0, false, false, false, false, 0, null);" +
                    "item.dispatchEvent(evt);" +
                    "} catch (ex) {" +
                    "evt = document.createEventObject(window.event);" +
                    "evt.button = 1;" +
                    "item.fireEvent('onclick', evt);" +
                    "}" +
                    "break;" +
                    "}" +
                    "}";
            js.executeScript(jsStr);
            UtilFunctions.sleep(500);
            UtilFunctions.log("Menu object not null. Executed java script function to click button. Returning true.");
            return true;
        }
    }


    /**************************************************************************
     * Verify if a cucumber DataTable of options are, or are not, in the PLv2 selection menu
     *
     * @param driver WebDriver object
     * @param menu name of the menu
     * @param not validate if items are, or are not, in menu
     * @param dataTable table of options to check for in menu
     * @param curTabName name of the currently selected tab
     * @return boolean
     *************************************************************************/
    public static boolean verifyOptionsInPLv2Menu(WebDriver driver, String menu, boolean not, DataTable dataTable, String curTabName) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + curTabName);
        UtilFunctions.log("Menu: " + menu);

        menu = menu.replace(" ", "");
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        String menuFrame = (String) frameMap.get(UtilFunctions.getElementFromJSONFile(fileObj, "PKMENUS." + menu, "frame"));
        String menuPath = UtilFunctions.getElementFromJSONFile(fileObj, "PKMENUS." + menu, "path");
        String menuID = UtilFunctions.getElementFromJSONFile(fileObj, "PKMENUS." + menu, "id");

        UtilFunctions.log("MenuPath: " + menuPath);
        UtilFunctions.log("MenuID: " + menuID);

        SeleniumFunctions.selectFrame(driver, menuFrame, "id");
        SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, menuPath + ";xpath");
        WebElement menuObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(menuPath + ";xpath"));

        //Return true if not is true and no patient list is empty
        if (not) {
            if (menuObj == null || !menuObj.isDisplayed()) {
                UtilFunctions.log("Patient List is empty.");
                return true;
            }
        }

        menuObj.click();
        List<WebElement> menuOptionElements = SeleniumFunctions.findElements(driver, SeleniumFunctions.setByValues("//ul[@id='" + menuID + "']//li[boolean(@pkmenuitemvalue)]//span;xpath"));
        List<String> menuOptions = new ArrayList<String>();
        for (WebElement optionElement : menuOptionElements) {
            //Can't get text of the spans for some reason.  innerHTML returns correct text.
            menuOptions.add(optionElement.getAttribute("innerHTML").trim());
        }
        List<String> dataList = dataTable.asList(String.class);

        if (not == true)
            UtilFunctions.log("Verifying list of items are not in menu");
        else
            UtilFunctions.log("Verifying list of items are in menu");

        boolean success = true;
        for (String item : dataList) {
            //if menuOptions contains an item...
            if (menuOptions.contains(item)) {
                //and we are verifying that menuOptions DOES NOT contain a list of items...
                if (not == true) {
                    //then success is false if any one item is found in the menuOptions
                    UtilFunctions.log("'" + item + "' found in menu options.  Fail.");
                    success = false;
                }
            } else {
                //and we are verifying that menuOptions contains a list of items...
                if (not == false) {
                    //then success is false if any one item is NOT found in menuOptions
                    UtilFunctions.log("'" + item + "' not found in menu options.  Fail.");
                    success = false;
                }
            }
        }
        return success;
    }


    /**************************************************************************
     * name: findCheckBoxObj(WebDriver driver, String chBoxValue,
     * String chBoxMethod)
     * functionality: Function to find and return checkbox object
     * param: WebDriver driver - WebDriver object
     * param: String chBoxValue - Name of checkbox
     * param: String chBoxMethod - Locator type of checkbox, i.e. xpath, id,
     * name, etc.
     * return: returns checkbox object
     *************************************************************************/
    public static WebElement findCheckBoxObj(WebDriver driver, String chBoxValue, String chBoxMethod) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Check box value: " + chBoxValue);

        String xPathValue = "";

        if (chBoxMethod.equals("id") || chBoxMethod.equals("name"))
            xPathValue = "//input[(@type='checkbox' or @type='Checkbox') and (@name='" + chBoxValue + "' or @id='" + chBoxValue + "')]";
        else if (chBoxMethod.equals("value"))
            xPathValue = "//input[(@type='checkbox' or @type='Checkbox') and (@value='" + chBoxValue + "')]";
        else if (chBoxMethod.equals("xpath"))
            xPathValue = "//input[(@type='checkbox' or @type='Checkbox') and (" + chBoxValue + ")]";
        else if (chBoxMethod.equals("barexpath"))
            xPathValue = chBoxValue;

        UtilFunctions.log("Check box xpath value: " + xPathValue);
        SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, xPathValue + ";xpath");

        return SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(xPathValue + ";xpath"));
    }


    /**************************************************************************
     * name: selectFromTableByRowIndex(WebDriver driver, String tabName,
     * String tableName, int index)
     * functionality: Function to select table value based on index
     * param: WebDriver driver - WebDriver object
     * param: String tabName - Name of current tab
     * param: String tableName - Name of table in json file
     * param: int index - Location/Index of the item to be selected
     * return: boolean
     *************************************************************************/
    public static boolean selectFromTableByRowIndex(WebDriver driver, String tabName, String tableName, int index)
            throws InterruptedException {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);

        String[] tableDetailArr = UtilFunctions.getTableValues(tabName, tableName);
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

        SeleniumFunctions.selectFrame(driver, paneFrames, "id");
        WebElement tableObj = findTable(driver, tablePath);

        if (tableObj == null) {
            UtilFunctions.log(tableName + " Table not present. Returning false.");
            return false;
        } else {
            UtilFunctions.log(tableName + " Table present");
            WebElement tableBodyObj = SeleniumFunctions.findElementByWebElement(tableObj,
                    SeleniumFunctions.setByValues(tableBody + ";xpath"));
            if (tableBodyObj == null) {
                UtilFunctions.log(tableName + " Table body object not present. Returning false.");
                return false;
            } else {
                UtilFunctions.log("Table body present");
                List<WebElement> tableRows = SeleniumFunctions.findElementsByWebElement(tableBodyObj,
                        SeleniumFunctions.setByValues("tr;tagName"));
                if (tableRows.size() > 0) {
                    Actions action = new Actions(driver);
                    action.click(tableRows.get(index)).perform();
//                    tableRowObj.get(index).click();
                    if (!SeleniumFunctions.clickTableItemIfNotClickedProperly(tableRows.get(index), true))
                        return false;
                    UtilFunctions.log("Selected item no: '" + index + "' from table. Returning true.");
                    return true;
                } else {
                    UtilFunctions.log("Elements not present in table. Returning false.");
                    return false;
                }
            }
        }
    }

    public static WebElement getTableRowIndex(WebDriver driver, String tabName, String tableName, int index)
            throws InterruptedException {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);

        String[] tableDetailArr = UtilFunctions.getTableValues(tabName, tableName);
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

        SeleniumFunctions.selectFrame(driver, paneFrames, "id");
        WebElement tableObj = findTable(driver, tablePath);

        if (tableObj == null) {
            UtilFunctions.log(tableName + " Table not present. Returning false.");
            return null;
        } else {
            UtilFunctions.log(tableName + " Table present");
            WebElement tableBodyObj = SeleniumFunctions.findElementByWebElement(tableObj,
                    SeleniumFunctions.setByValues(tableBody + ";xpath"));
            if (tableBodyObj == null) {
                UtilFunctions.log(tableName + " Table body object not present. Returning false.");
                return null;
            } else {
                UtilFunctions.log("Table body present");
                List<WebElement> tableRows = SeleniumFunctions.findElementsByWebElement(tableBodyObj,
                        SeleniumFunctions.setByValues("tr;tagName"));
                if (tableRows.size() > 0) {
                    WebElement row = tableRows.get(index);
                    return row;
                }
            }
        }
        return null;
    }


    /**************************************************************************
     * name: selectFromTableByRowIndex(WebDriver driver, String tabName, String tableName, int index)
     * functionality: Function to select table value based on value
     * param: WebDriver driver - WebDriver object
     * param: String curTabName - Name of current tab
     * param: String tableName - Name of table in json file
     * param: String column - Name of column in the table
     * param: String value - Value used to determine which row to select
     * return: boolean
     *************************************************************************/
    //TODO: Refactor to make searching for meds more fuzzy but still have the correct med at the correct dose by the correct administration route (i.e., tablet, Oral , IV, etc.)
    public static boolean selectFromTableByValue(WebDriver driver, String curTabName, String tableName, String column,
                                                 String value) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        UtilFunctions.log("Current tab name: " + curTabName);
        WebElement selectRow = null;

        //First, try to find table row value in a specific column, if column was provided
        if ((column != null) && !(column.equals(""))) {
            try {
                selectRow = getColumnValueObjInTable(driver, curTabName, tableName, column, value);
            } catch (NullPointerException e) {
                UtilFunctions.log("NullPointer Exception: " + e.getMessage());
            }
        }

        //2nd, If row not found via column, continue on to other row selection methods
        if (selectRow == null) {
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

            SeleniumFunctions.selectFrame(driver, paneFrames, "id");
            WebElement tableObj = findTable(driver, tablePath);
            if (tableObj == null) {
                UtilFunctions.log(tableName + " table not present. Returning false.");
            } else {
                UtilFunctions.log(tableName + " table present");
                WebElement tableBodyObj = SeleniumFunctions.findElementByWebElement(tableObj,
                        SeleniumFunctions.setByValues(tableBody + ";xpath"));

                if (tableBodyObj == null) {
                    UtilFunctions.log("Table body object not present. Returning false.");
                } else {
                    UtilFunctions.log(tableName + " table body present");
                    List<WebElement> tableRows = SeleniumFunctions.findElementsByWebElement(tableBodyObj,
                            SeleniumFunctions.setByValues("tr;tagName"));

                    if (tableRows.size() < 1) {
                        tableRows = SeleniumFunctions.findElements(driver, By.xpath(tablePath + tableBody + "//tr"));
                    }

                    if (tableRows.size() < 1) {
                        UtilFunctions.log("No table rows found in table: " + tableName + ". Returning false.");
                    }

                    //Try to find table row by exact match(ignoring case if needed)
                    for (WebElement row : tableRows) {
                        if (SeleniumFunctions.findElementByWebElement(row, SeleniumFunctions.setByValues(".//*[text()= '" + value + "']")) != null) {
                            selectRow = SeleniumFunctions.findElementByWebElement(row, SeleniumFunctions.setByValues(".//*[text()= '" + value + "']"));
                            break;
                        }
                        if (selectRow == null) {
                            if (SeleniumFunctions.findElementByWebElement(row, SeleniumFunctions.setByValues(".//*[text()= '" + value.toUpperCase() + "']")) != null) {
                                selectRow = SeleniumFunctions.findElementByWebElement(row, SeleniumFunctions.setByValues(".//*[text()= '" + value.toUpperCase() + "']"));
                                break;
                            }
                        }
                    }

                    //Third, attempt to find row using less specific backup methods
                    if (selectRow == null) {
                        for (WebElement rowObj : tableRows) {
                            String rowText = rowObj.getText().trim().replace("\n", " ").replace("\r", " ").replace("  ", " ").toUpperCase();
                            if (rowText.contains(value.toUpperCase())) {
                                selectRow = rowObj;
                                break;
                            }

                            if (selectRow == null) {
                                if (SeleniumFunctions.findElementByWebElement(rowObj, SeleniumFunctions.setByValues(".//*[contains(text(), '" + value.toUpperCase() + "')]")) != null) {
                                    selectRow = SeleniumFunctions.findElementByWebElement(rowObj,
                                            SeleniumFunctions.setByValues(".//*[contains(text(), '" + value.toUpperCase() + "')]"));
                                    break;
                                }
                            }

                            if (selectRow == null) {
                                if (SeleniumFunctions.findElementByWebElement(rowObj, SeleniumFunctions.setByValues(".//*[contains(text(), '" + value + "')]")) != null) {
                                    selectRow = SeleniumFunctions.findElementByWebElement(rowObj, SeleniumFunctions.setByValues(".//*[contains(text(), '" + value + "')]"));
                                    break;
                                }
                            }
//                        if (selectRow == null)
//                            if (SeleniumFunctions.findElementByWebElement(rowObj, SeleniumFunctions.setByValues(".//*[contains(text(), '" + value + "')]")) != null) {
//                                selectRow = rowObj;
//                            }
                            if (selectRow == null) {
                                try {
                                    String text = "";
                                    WebElement col = SeleniumFunctions.findElementByWebElement(rowObj,
                                            SeleniumFunctions.setByValues("td;tagName"));
                                    if (col.getAttribute("innerHTML").contains(value) || col.getText().contains(value))
                                        selectRow = col;
                                    else {
                                        List<WebElement> colChild = SeleniumFunctions.findElementsByWebElement(col,
                                                SeleniumFunctions.setByValues("descendant-or-self::*[boolean(normalize-space(./text()))]"
                                                        + ";xpath"));
                                        for (WebElement child : colChild) {
                                            if (text.equals(""))
                                                text = text + child.getAttribute("innerHTML");
                                            else
                                                text = text + " " + child.getAttribute("innerHTML").trim();
                                        }
                                        UtilFunctions.log("Text: " + text);
                                        if (text.contains(value)) {
                                            selectRow = col;
                                            break;
                                        }
                                    }
                                } catch (Exception e) {
                                    UtilFunctions.log("Exception: " + e.getMessage());
                                }
                            }

                            if (selectRow == null) {
                                try {
                                    String text = "";
                                    List<WebElement> colArr = SeleniumFunctions.findElementsByWebElement(rowObj,
                                            SeleniumFunctions.setByValues("td;tagName"));

                                    for (WebElement col : colArr) {
                                        String colText = col.getText().replace(" ", "");
                                        if (colText.equalsIgnoreCase(value.replace(" ", ""))) {
                                            selectRow = col;
                                            break;
                                        }
                                    }
                                } catch (Exception e) {
                                    UtilFunctions.log("Exception: " + e.getMessage());
                                }
                            }
                            if (selectRow != null) {
                                //Row found.  No need to loop through remaining rows.
                                break;
                            }
                        }//end for (WebElement rowObj : tableRows) in Third Attempt
                    }

                }
            }
        }


        JavascriptExecutor jsExecutor = (JavascriptExecutor) driver;
        if (selectRow != null) {
            if (UtilProperty.browserType.contains("ie")) {//Selenium's .click() is 'passing' in IE, but the click is not actually happening
                try {
                    jsExecutor.executeScript("arguments[0].click();", selectRow);
                    UtilFunctions.sleep(1000);
                    //If JS click doesn't work:
                    if (selectRow.getAttribute("class").contains("ui-selectee")) {
                        selectRow.click();
                    }
                } catch (ElementClickInterceptedException e) {
                    UtilFunctions.log("Row not selected due to:" + e.getMessage() + ".  Trying again with SeleniumFunctions.click.");
                    e.printStackTrace();
                    SeleniumFunctions.click(selectRow);
                    UtilFunctions.sleep(1000);
                }
            } else {
                try {
                    selectRow.click();//This click is 'passing' in IE, but the click is not actually happening
                    UtilFunctions.sleep(1000);
                } catch (ElementNotInteractableException e) {
                    UtilFunctions.log("Row not selected due to:" + e.getMessage() + ".  Trying again with JS click.");
                    e.printStackTrace();
                    jsExecutor.executeScript("arguments[0].click();", selectRow);
                    UtilFunctions.sleep(1000);
                } catch (WebDriverException wde) {
                    UtilFunctions.log("Row not selected due to:" + wde.getMessage() + ".  Trying again with SeleniumFunctions.click.");
                    wde.printStackTrace();
                    SeleniumFunctions.click(selectRow);
                    UtilFunctions.sleep(1000);
                }
            }
            UtilFunctions.log("Element name: " + value + " present and clicked. Returning true.");
            return true;
        }

        UtilFunctions.log("Element name: '" + value + "' not selected.");
        return false;
    }

    /**
     * Function to select order based on string
     *
     * @param driver     WebDriver object
     * @param curTabName Name of current tab
     * @param value      Value used to determine which row to select
     * @return boolean
     */
    public static boolean selectOrderFromNewOrdersTable(WebDriver driver, String curTabName, String value) throws InterruptedException {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + curTabName);

        String[] tableDetailArr = UtilFunctions.getTableValues(curTabName, "NewOrders");
        String tablePath = tableDetailArr[0];
        String tableBody = tableDetailArr[3];
        String paneFrames = tableDetailArr[4];

        UtilFunctions.log("tablePath: " + tablePath);
        UtilFunctions.log("tableBody: " + tableBody);
        UtilFunctions.log("PaneFrames: " + paneFrames);

        SeleniumFunctions.selectFrame(driver, paneFrames, "id");
        WebElement tableObj = findTable(driver, tablePath);
        if (tableObj == null) {
            UtilFunctions.log("Table not present. Returning false.");
            return false;
        } else {
            UtilFunctions.log("Table present");
            WebElement tableBodyObj = SeleniumFunctions.findElementByWebElement(tableObj, SeleniumFunctions.setByValues(tableBody + ";xpath"));
            WebElement selectRow = SeleniumFunctions.findElementByWebElement(tableBodyObj, SeleniumFunctions.setByValues(".//font[normalize-space(text())= '" + value.replaceAll("\\s+", " ") + "']" + ";xpath"));
            if (selectRow == null) {
                UtilFunctions.log("Order with text: '" + value + "' not present.");
                return false;
            } else {
                //Need to click on text in font element
                //Offset required when text wraps as there may not be text at the center of the font element
                Actions actions = new Actions(driver);
                actions.moveToElement(selectRow, 0, (selectRow.getSize().height / 4)).click().build().perform();
                UtilFunctions.log("Order with text: '" + value + "' present and clicked. Returning true.");
                return true;
            }
        }
    }


    /**************************************************************************
     * name: checkTableExists(WebDriver driver, String curTabName,
     * String tableName)
     * functionality: Function to select table value based on value
     * param: WebDriver driver - WebDriver object
     * param: String curTabName - Name of current tab
     * param: String tableName - Name of table in json file
     * return: boolean
     *************************************************************************/
    public static boolean checkTableExists(WebDriver driver, String curTabName, String tableName) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + curTabName);

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

        SeleniumFunctions.selectFrame(driver, paneFrames, "id");
        SeleniumFunctions.explicitWait(driver, GlobalConstants.FIVE, tablePath + ";xpath");
        WebElement tableObj = findTable(driver, tablePath);
        if (tableObj == null) {
            UtilFunctions.log("Table name: " + tableName + " does not exist. Returning false.");
            return false;
        } else {
            UtilFunctions.log("Table name: " + tableName + " exist. Returning true.");
            return true;
        }
    }


    /**************************************************************************
     * name: textExists(WebDriver driver, String text, String sectionPath,
     * boolean exact)
     * functionality: Function to check whether text exists or not on the
     * required page
     * param: WebDriver driver - WebDriver object
     * param: String text - Text to be checked
     * param: String sectionPath - Name of text path
     * param: String column - Name of column in the table
     * param: boolean exact - Boolean value to generate xpath as per the value
     * return: boolean
     *************************************************************************/
    public static boolean textExists(WebDriver driver, String text, String sectionPath,
                                     boolean exact) throws InterruptedException {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("sectionPath: " + sectionPath);

        if (sectionPath == null)
            sectionPath = "";

        if (sectionPath.equals("")) {
            String xPath = "//*[";
            if (exact)
                xPath += "text()=\"" + text + "\"";
            else
                xPath += "contains(normalize-space(.), \"" + text + "\")";
            xPath += "]";
            UtilFunctions.log("xPath: " + xPath);
            SeleniumFunctions.explicitWait(driver, GlobalConstants.FIFTEEN, xPath + ";xpath");
            WebElement textObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(xPath + ";xpath"));
            if (textObj == null) {
                UtilFunctions.log("Text: '" + text + "' does not exist. Returning false.");
                WebElement newTextObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("body" + ";tagName"));
                if (newTextObj == null) {
                    UtilFunctions.log("Text: '" + text + "' does not exist. Returning false.");
                    return false;
                } else {
                    if (newTextObj.getAttribute("outerHTML").replace("&nbsp;", " ").indexOf(text) > 0) {
                        UtilFunctions.log("Text: '" + text + "' exist. Returning true.");
                        return true;
                    } else {
                        UtilFunctions.log("Text: '" + text + "' does not exist. Returning false.");
                        return false;
                    }
                }
            } else {
                if (textObj.getText().contains(text) || (textObj.getText().indexOf(text) > 0)) {
                    UtilFunctions.log("Text: '" + text + "' exists. Returning true.");
                    return true;
                } //Added innerHTML branch for the sake of IE. The two other If branches were failing in IE, but the text is there.
                else if (textObj.getAttribute("innerHTML").contains(text)) {
                    UtilFunctions.log("Text: '" + text + "' exists. Returning true.");
                    return true;
                } else {
                    WebElement newTextObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("body" + ";tagName"));
                    if (newTextObj == null) {
                        UtilFunctions.log("Text: '" + text + "' does not exist. Returning false.");
                        return false;
                    } else {
                        if (newTextObj.getAttribute("outerHTML").replace("&nbsp;", " ").trim().indexOf(text.replace("&nbsp;", " ").trim()) > 0) {
                            UtilFunctions.log("Text: '" + text + "' exists. Returning true.");
                            return true;
                        } else {
                            UtilFunctions.log("Text: '" + text + "' does not exist. Returning false.");
                            return false;
                        }
                    }
                }
            }
        } else {
            WebElement resultTextObj;
            int chkCnt = 0;
            do {
                chkCnt++;
                UtilFunctions.log("CheckCount: " + chkCnt);
                if (chkCnt > 5) {
                    UtilFunctions.log("Text: '" + text + "' does not exist after '" + chkCnt + "' no of executions. Returning false.");
                    return false;
                } else {
                    SeleniumFunctions.explicitWait(driver, GlobalConstants.TWENTY, sectionPath + ";xpath");
                    resultTextObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(sectionPath + ";xpath"));
                    if (resultTextObj == null) {
                        UtilFunctions.log("Text: '" + text + "' does not exist. Returning false.");
                        return false;
                    } else {
                        System.out.println(resultTextObj.getText());
                        System.out.println(resultTextObj.getText().indexOf(text));
                        UtilFunctions.log("Text object of text: '" + text + "' exists.");
                        UtilFunctions.log("Text visible on screen: " + resultTextObj.getText());
                        UtilFunctions.log("Index of text visible on screen: " + resultTextObj.getText().indexOf(text));

                        if ((resultTextObj.getText().contains(text)) || (resultTextObj.getText().indexOf(text) > 0)) {
                            UtilFunctions.log("Text: '" + text + "' exist. Returning true.");
                            return true;
                        } else {
                            UtilFunctions.log("Text: '" + text + "' does not exist. Waiting for 2sec.");
                            Thread.sleep(2000);
                        }
                    }
                }
            } while (true);
        }
    }

    //Overloaded textExists() method
    public static boolean textExists(WebDriver driver, String text, String sectionPath,
                                     boolean exact, String paneName, String tabName) throws InterruptedException {
        UtilFunctions.log("Class: " + page.className + "; Method: " +
                new Object() {
                }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("sectionPath: " + sectionPath);

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        String paneFrames = "";
        paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj,
                "PANES." + paneName.replace(" ", ""), "frame"));
        UtilFunctions.log("PaneFrames: " + paneFrames);
        SeleniumFunctions.selectFrame(driver, paneFrames, "id");

        if (sectionPath == null)
            sectionPath = "";

        if (sectionPath.equals("")) {
            String xPath = "//*[";
            if (exact)
                xPath += "text()=\"" + text + "\"";
            else
                xPath += "contains(normalize-space(.), \"" + text + "\")";
            xPath += "]";
            UtilFunctions.log("xPath: " + xPath);
            SeleniumFunctions.explicitWait(driver, GlobalConstants.FIFTEEN, xPath + ";xpath");
            WebElement textObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(xPath + ";xpath"));
            if (textObj == null) {
                UtilFunctions.log("Text: '" + text + "' does not exist. Returning false.");
                WebElement newTextObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("body" + ";tagName"));
                if (newTextObj == null) {
                    UtilFunctions.log("Text: '" + text + "' does not exist. Returning false.");
                    return false;
                } else {
                    if (newTextObj.getAttribute("outerHTML").replace("&nbsp;", " ").indexOf(text) > 0) {
                        UtilFunctions.log("Text: '" + text + "' exist. Returning true.");
                        return true;
                    } else {
                        UtilFunctions.log("Text: '" + text + "' does not exist. Returning false.");
                        return false;
                    }
                }
            } else {
                if (textObj.getText().contains(text) || (textObj.getText().indexOf(text) > 0)) {
                    UtilFunctions.log("Text: '" + text + "' exist. Returning true.");
                    return true;
                } else {
                    WebElement newTextObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("body" + ";tagName"));
                    if (newTextObj == null) {
                        UtilFunctions.log("Text: '" + text + "' does not exist. Returning false.");
                        return false;
                    } else {
                        if (newTextObj.getAttribute("outerHTML").replace("&nbsp;", " ").trim().indexOf(text.replace("&nbsp;", " ").trim()) > 0) {
                            UtilFunctions.log("Text: '" + text + "' exist. Returning true.");
                            return true;
                        } else {
                            UtilFunctions.log("Text: '" + text + "' does not exist. Returning false.");
                            return false;
                        }
                    }
                }
            }
        } else {
            WebElement resultTextObj;
            int chkCnt = 0;
            do {
                chkCnt++;
                UtilFunctions.log("CheckCount: " + chkCnt);
                if (chkCnt > 5) {
                    UtilFunctions.log("Text: '" + text + "' does not exist after '" + chkCnt + "' no of executions. Returning false.");
                    return false;
                } else {
                    SeleniumFunctions.explicitWait(driver, GlobalConstants.TWENTY, sectionPath + ";xpath");
                    resultTextObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(sectionPath + ";xpath"));
                    if (resultTextObj == null) {
                        UtilFunctions.log("Text: '" + text + "' does not exist. Returning false.");
                        return false;
                    } else {
                        System.out.println(resultTextObj.getText());
                        System.out.println(resultTextObj.getText().indexOf(text));
                        UtilFunctions.log("Text object of text: '" + text + "' exist.");
                        UtilFunctions.log("Text visible on screen: " + resultTextObj.getText());
                        UtilFunctions.log("Index of text visible on screen: " + resultTextObj.getText().indexOf(text));

                        if ((resultTextObj.getText().contains(text)) || (resultTextObj.getText().indexOf(text) > 0)) {
                            UtilFunctions.log("Text: '" + text + "' exist. Returning true.");
                            return true;
                        } else {
                            UtilFunctions.log("Text: '" + text + "' does not exist. Waiting for 2sec.");
                            Thread.sleep(2000);
                        }
                    }
                }
            } while (true);
        }
    }


    /**************************************************************************
     * name: textExists(WebDriver driver, String tabName, String text,
     * String paneName, String... sectionNameArr)
     * functionality: Function to check whether text exists or not on the
     * required page
     * param: WebDriver driver - WebDriver object
     * param: String tabName - Name of current tab
     * param: String text - Text to be checked
     * param: String paneName - Name of current pane
     * param: String... sectionNameArr - Optional parameter for pane section
     * name
     * return: boolean
     *************************************************************************/
    public static boolean textExists(WebDriver driver, String tabName, String text, String paneName,
                                     String... sectionNameArr) throws InterruptedException {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);

        String sectionName = null;
        boolean retValue;

        if (sectionNameArr.length > 0 && sectionNameArr[0] != null)
            sectionName = sectionNameArr[0].replace(" ", "");

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        String paneFrames = null;
        if (paneName != null)
            paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj,
                    "PANES." + paneName.replace(" ", ""), "frame"));
        else
            paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj,
                    "PANE_SECTIONS." + sectionName, "frame"));

        UtilFunctions.log("PaneFrames: " + paneFrames);
        SeleniumFunctions.selectFrame(driver, paneFrames, "id");

        if (sectionName == null) {
            retValue = textExists(driver, text, "", false);
        } else {
            String sectionPath = UtilFunctions.getElementFromJSONFile(fileObj, "PANE_SECTIONS." + sectionName, "path");
            retValue = textExists(driver, text, sectionPath, false);
        }

        UtilFunctions.log("Checking for text: '" + text + "'. Returning " + retValue);
        return retValue;
    }


    /**************************************************************************
     * name: clickMiscElement(WebDriver driver, String tabName,
     * String imageName, String sectionName, String... paneName)
     * functionality: Function to click on miscellaneous elements
     * param: WebDriver driver - WebDriver object
     * param: String tabName - Name of current tab
     * param: String imageName - Name of image to be clicked
     * param: String sectionName - Pane section name
     * param: String... paneName - Optional parameter for current pane
     * name
     * return: boolean
     *************************************************************************/
    public static boolean clickMiscElement(WebDriver driver, String tabName, String elementName, String sectionName,
                                           String paneName, String exists) {//Parameter "exists" is never used, but it's needed elsewhere. -- HIC 11/1/18
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);
        UtilFunctions.log("ImageName: " + elementName);
        UtilFunctions.log("SectionName: " + sectionName);

        elementName = elementName.replace(" ", "");
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        String paneFrames = "";
        String[] elementType = UtilFunctions.getElementStringAndType(fileObj, "MISC_ELEMENTS." + elementName);
        String path = elementType[0];
        String method = elementType[1];

        if (paneName == null)
            paneFrames = UtilFunctions.getFrameValue(frameMap,
                    UtilFunctions.getElementFromJSONFile(fileObj, "MISC_ELEMENTS." + elementName, "frame"));
        else
            paneFrames = UtilFunctions.getFrameValue(frameMap,
                    UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName.replace(" ", ""),
                            "frame"));

        UtilFunctions.log("PaneFrames: " + paneFrames);
        UtilFunctions.log("path: " + path);
        UtilFunctions.log("method: " + method);

        SeleniumFunctions.selectFrame(driver, paneFrames, "id");
        if (sectionName == null) {
            SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, path + ";" + method);
            WebElement eleObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(path + ";" + method));
            if (eleObj != null) {
                try {
                    try {
                        eleObj.click();
                    } catch (WebDriverException e) {
                        SeleniumFunctions.click(eleObj);
                    }
                    Thread.sleep(1000);
                    UtilFunctions.log("Element: '" + elementName + "' found and clicked on 1st try. " +
                            "Returning true.");
                    System.out.println("Element: '" + elementName + "' exists and clicked on 1st try.  " +
                            "Returning true.");
                    return true;
                } catch (InterruptedException e) {
                    e.printStackTrace();
                    UtilFunctions.log("Element: '" + elementName + "' not clicked on 1st try due to: " +
                            e.getMessage() + "\nTrying again.");
                    System.out.println("Element: '" + elementName + "' not clicked on 1st try due to: " +
                            e.getMessage() + "\nTrying again.");
                    return false;
                }
            } else {
                eleObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(path + ";" + method));
                try {
                    //eleObj.click();
                    SeleniumFunctions.click(eleObj);
                    Thread.sleep(1000);
                    UtilFunctions.log("Element: '" + elementName + "' found and clicked on 2nd try. " +
                            "Returning true.");
                    System.out.println("Element: '" + elementName + "' exists and clicked on 2nd try.  " +
                            "Returning true.");
                    return true;
                } catch (Exception e) {
                    UtilFunctions.log("Element: '" + elementName + "' is still NULL on 2nd try. Returning false."
                            + e.getMessage());
                    System.out.println("Element: '" + elementName + "' is still NULL on 2nd try. Returning false."
                            + e.getMessage());
                    return false;
                }

            }
            /*if (eleObj == null) {
                UtilFunctions.log("Element: '" + elementName + "' is NULL. Returning false.");
                return false;
            }
            else{
                try {
                    eleObj.click();
                    Thread.sleep(1000);
                    UtilFunctions.log("Element: '" + elementName + "' exists and clicked. Returning true.");
                } catch (InterruptedException e) {
                    e.printStackTrace();
                    UtilFunctions.log("Element: '" + elementName + "' not clicked due to: " + e.getMessage());
                }
                return true;
            }*/
        } else {
            sectionName = sectionName.replace(" ", "");
            String sectionPath = UtilFunctions.getElementFromJSONFile(fileObj,
                    "PANE_SECTIONS." + sectionName, "path");
            UtilFunctions.log("sectionPath: " + sectionPath);
            WebElement sectionObj = SeleniumFunctions.findElement(driver,
                    SeleniumFunctions.setByValues(sectionPath + ";" + "xpath"));
            if (sectionObj == null) {
                UtilFunctions.log("Section: '" + sectionName + "' is NULL. Returning false.");
                return false;
            } else {
                WebElement eleObj = SeleniumFunctions.findElementByWebElement(sectionObj,
                        SeleniumFunctions.setByValues(path + ";" + method));
                if (eleObj == null) {
                    UtilFunctions.log("Element: '" + elementName + "' is NULL. Returning false.");
                    return false;
                } else {
                    eleObj.click();
                    UtilFunctions.log("Element: '" + elementName + "' exists and clicked. Returning true.");
                    return true;
                }
            }
        }//end outermost If-else
    }//end clickMiscElement


    /**************************************************************************
     * name: countTableRows(WebDriver driver, String tabName,
     * String tableName)
     * functionality: Function to get the table row size
     * param: WebDriver driver - WebDriver object
     * param: String tabName - Name of current tab
     * param: String tableName - Name of current table
     * param: String sectionName - Pane section name
     * return: returns size of table
     *************************************************************************/
    public static int countTableRows(WebDriver driver, String tabName, String tableName, String text, String exclude)
            throws InterruptedException {

        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);

        tableName = tableName.replace(" ", "");
        String[] tableDetailArr = UtilFunctions.getTableValues(tabName, tableName);
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

        tableBody += "/tr";
        if (text == null)
            System.out.println("Do nothing");
        else {
            if (exclude == null)
                tableBody += "[descendant-or-self::*[contains(normalize-space(./text()), '" + text + "')]]";
            else
                tableBody += "[not(descendant-or-self::*[contains(normalize-space(./text()), '" + text + "')])]";
        }

        UtilFunctions.log("tableBody: " + tableBody);
        Thread.sleep(5000);
        SeleniumFunctions.selectFrame(driver, paneFrames, "id");
        SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, tablePath + ";xpath");
        WebElement tableObj = findTable(driver, tablePath);
        if (tableObj == null) {
            UtilFunctions.log("Table: " + tableName + " is not present. Returning 0 count.");
            return 0;
        } else {
            List<WebElement> rowObj;
            try {
                rowObj = SeleniumFunctions.findElementsByWebElement(tableObj, SeleniumFunctions.setByValues(tableBody + ";xpath"));
                UtilFunctions.log("Table: " + tableName + " present. Returning " + rowObj.size() + " count.");
                return rowObj.size();
            } catch (Exception staleElement) {
                UtilFunctions.log("Exception while finding the row in table using 'findElementsByWebElement'. Exception: " + staleElement.getMessage());
                UtilFunctions.log("Finding tableObj again and then rowObj.");
                count++;
                if (count <= GlobalConstants.ONE) {
                    UtilFunctions.log("Recursive calling of the function.");
                    return countTableRows(driver, tabName, tableName, text, exclude);
                } else
                    count = 0;
            }
        }
        return 0;
    }


    /**************************************************************************
     * name: sortTable(WebDriver driver, String tabName, String tableName,
     * String sortType, String header, String order)
     * functionality: Function to sort the table
     * param: WebDriver driver - WebDriver object
     * param: String tabName - Name of current tab
     * param: String tableName - Name of current table
     * param: String sortType - Sorting type (Ascending/Descending)
     * param: String header - Table header value
     * param: String order - Order type (Ascending/Descending)
     * return: boolean
     *************************************************************************/
    public static boolean sortTable(WebDriver driver, String tabName, String tableName, String sortType, String header, String order) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);

        String tableHeaderXPath = "";

        tableName = tableName.replace(" ", "");
        String[] tableDetailArr = UtilFunctions.getTableValues(tabName, tableName);
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

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName("");

        if (order.equals("Ascending")) {
            tableHeaderXPath = UtilFunctions.getElementFromJSONFile(fileObj, "GLOBAL_IMAGES." + "SortAscending", "path");
        } else if (order.equals("Descending")) {
            tableHeaderXPath = UtilFunctions.getElementFromJSONFile(fileObj, "GLOBAL_IMAGES." + "SortDescending", "path");
        }

        SeleniumFunctions.selectFrame(driver, paneFrames, "id");
        SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, tablePath + ";xpath");
        WebElement tableObj = findTable(driver, tablePath);
        if (tableObj == null) {
            UtilFunctions.log("Table: " + tableName + " is not present. Returning false.");
            return false;
        } else {
            WebElement tableHeaderObj = findTableHeaderCell(tableObj, tableName, tableHead, header);
            if (tableHeaderObj == null) {
                UtilFunctions.log("TableHeaderObject for table: " + tableName + " is not present. Returning false.");
                return false;
            } else {
                WebElement headerObj = SeleniumFunctions.findElementByWebElement(tableHeaderObj, SeleniumFunctions.setByValues(tableHeaderXPath + ";xpath"));
                int checkCnt = 0;
                while (headerObj == null) {
                    checkCnt++;
                    tableHeaderObj.click();
                    headerObj = SeleniumFunctions.findElementByWebElement(tableHeaderObj, SeleniumFunctions.setByValues(tableHeaderXPath + ";xpath"));
                    if (checkCnt > GlobalConstants.FIVE) {
                        UtilFunctions.log("HeaderObject for table: " + tableName + " is not present. Returning false.");
                        return false;
                    }
                }
                UtilFunctions.log("In: " + order + " order. Returning true.");
                return true;
            }
        }

    }


    /**************************************************************************
     * name: findTableHeaderCell(WebElement tableObj, String tableName,
     * String tableHead, String value)
     * functionality: Function to find table header cell object
     * param: WebElement tableObj - Table object
     * param: String tableName - Name of current table
     * param: String tableHead - Table head value
     * param: String value - Table header text
     * return: boolean
     *************************************************************************/
    public static WebElement findTableHeaderCell(WebElement tableObj, String tableName, String tableHead, String value) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("tableName: " + tableName);

        WebElement tHead = SeleniumFunctions.findElementByWebElement(tableObj, SeleniumFunctions.setByValues(tableHead + ";xpath"));
        if (tHead == null) {
            UtilFunctions.log("Table: " + tableName + " tHead not found. Returning null.");
            return null;
        } else {
            List<WebElement> headerElements = SeleniumFunctions.findElementsByWebElement(tHead, SeleniumFunctions.setByValues("th;tagName"));
            for (WebElement head : headerElements) {
                String text = head.getText();
                if (text.contains(value)) {
                    UtilFunctions.log("The value: " + value + " header is present. Returning object.");
                    return head;
                }
            }
        }
        return null;
    }

//TODO:Remove the below commented code once the boolean implementation of below function is executed successfully!
//    /**************************************************************************
//     * Check if rows of data are present within a table
//     *
//     * @param driver - WebDriver object
//     * @param curTabName - Name of current tab
//     * @param type type of data
//     * @param exactMatch exact match
//     * @param tableName name of table
//     * @param clinical clinical type
//     * @param dataTable data to be checked in table
//     * @return String
//     *************************************************************************/
//    public static String checkDataInTable(WebDriver driver, String curTabName, String type, String exactMatch, String tableName, String clinical, DataTable dataTable) throws InterruptedException {
//        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object(){}.getClass().getEnclosingMethod().getName());
//        UtilFunctions.log("tableName: " + tableName);
//
//        String retValue = "";
//
//        tableName = tableName.replace(" ", "");
//        String[] tableDetailArr = UtilFunctions.getTableValues(curTabName, tableName);
//        String tablePath = tableDetailArr[0];
//        String tableId = tableDetailArr[1];
//        String tableHead = tableDetailArr[2];
//        String tableBody = tableDetailArr[3];
//        String paneFrames = tableDetailArr[4];
//
//        UtilFunctions.log("tablePath: " + tablePath);
//        UtilFunctions.log("tableID: " + tableId);
//        UtilFunctions.log("tableHead: " + tableHead);
//        UtilFunctions.log("tableBody: " + tableBody);
//        UtilFunctions.log("PaneFrames: " + paneFrames);
//
//        SeleniumFunctions.selectFrame(driver, paneFrames, "id");
//        SeleniumFunctions.explicitWait(driver, GlobalConstants.TWENTY, tablePath + ";xpath");
//
//        ArrayList<String> headerArr = new ArrayList<String>();
//        ArrayList<Integer> headerArrLoc = new ArrayList<Integer>();
//        List<Map<String, String>> dataList = dataTable.asMaps(String.class, String.class);
//
//        int keyLen;
//        try{
//            keyLen = dataList.get(0).keySet().size();
//        }
//        catch (Exception e){
//            keyLen = 0;
//        }
//
//        for (int keySize = 0; keySize < keyLen; keySize++) {
//            headerArr.add((String) dataList.get(0).keySet().toArray()[keySize]);
//            UtilFunctions.log("Added Key: " + dataList.get(0).keySet().toArray()[keySize]);
//        }
//
//        if (checkTableExists(driver, curTabName, tableName)){
//            UtilFunctions.log("Table: " + tableName + " exists.");
//            WebElement tableElement = findTable(driver, tablePath);
//            WebElement tableHeaderObj = findTableHead(tableElement, tableHead);
//            if (tableHeaderObj == null){
//                UtilFunctions.log("Table Header: " + tableHead + " is not present.");
//                retValue += "Table Header: " + tableHead + " is not present.";
//            }
//            else{
//                List<WebElement> headersObjects = SeleniumFunctions.findElementsByWebElement(tableHeaderObj, SeleniumFunctions.setByValues(tableHead + "/tr" + ";xpath"));
//                if (headersObjects == null){
//                    UtilFunctions.log("Header values not displayed.");
//                    retValue += "Header values not displayed.";
//                }
//                else{
//                    WebElement rowHeaderObj;
//                    if (headersObjects.size() == 1)
//                        rowHeaderObj = headersObjects.get(0);
//                    else
//                        rowHeaderObj = headersObjects.get(headersObjects.size() - 1);
//                    List<WebElement> mainHeadersObjects = SeleniumFunctions.findElementsByWebElement(rowHeaderObj, By.xpath(".//descendant-or-self::th"));
////                    List<WebElement> mainHeadersObjects = SeleniumFunctions.findElementsByWebElement(rowHeaderObj, SeleniumFunctions.setByValues("descendant::th" + ";xpath"));
//                    for (String headerName : headerArr){
//                        int headerLoc = 0;
//                        for (WebElement headerObj : mainHeadersObjects){
//                            headerLoc++;
//                            if (headerName.endsWith("*")) {
//                                headerName = headerName.replace("*", "");
//                            }
////                            String regEx = "^" + headerName + "$";
////                            if (headerObj.getText().matches(regEx)){
//                          if (headerObj.getText().trim().contains(headerName.trim())){
//                                headerArrLoc.add(headerLoc);
//                                break;
//                            }
//                        }
//                    }
//                    int noOfRows = 0;
//                    noOfRows = countTableRows(driver, curTabName, tableName, null, null);
//                    UtilFunctions.log("No of rows in table: " + tableName + " is: " + noOfRows);
//                    List<WebElement> tableBodyObj = SeleniumFunctions.findElementsByWebElement(tableElement, SeleniumFunctions.setByValues(tableBody + "/tr" + ";xpath"));
//                    if (exactMatch != null)
//                    {
//                        if (exactMatch.equals("match")){
//                            if (noOfRows == tableBodyObj.size())
//                                UtilFunctions.log("Total no of rows: " + noOfRows + " matched.");
//                            else{
//                                UtilFunctions.log("Total no of rows: " + noOfRows + " not matched.");
//                                retValue += "Total no of rows: " + noOfRows + " not matched.";
//                            }
//                        }
//                    }
//                    if (dataList.size() > 0) {
//                        //For each Row in data set
//                        for (int dataRowIndex = 0; dataRowIndex < dataList.size(); dataRowIndex++) {
//                            Map data = dataList.get(dataRowIndex);
//                            String tempVal = "";
//                            //Check for values in each row of tableBodyObj
//                            boolean rowFound = false;
//                            for (int tableRowIndex = 0; tableRowIndex < tableBodyObj.size(); tableRowIndex++) {
//                                UtilFunctions.log("Complete row text: " + tableBodyObj.get(dataRowIndex).getText());
//                                int itemLoc;
//                                int headerLoc = 0;
//                                int foundItemCount = 0;
//                                tempVal = "Data Row " + (dataRowIndex+1) + ": ";
//                                Iterator<Entry<String, String>> iterator = data.entrySet().iterator();
//                                //For each column in data set
//                                while (iterator.hasNext()) {
//                                    Map.Entry<String, String> entry = (Map.Entry<String, String>) iterator.next();
//                                    String textToCheck = UtilFunctions.convertThruRegEx(entry.getValue());
//                                    if (headerArrLoc.size() == 0)
//                                        itemLoc = 1;
//                                    else
//                                        itemLoc = headerArrLoc.get(headerLoc);
//                                    UtilFunctions.log("xpath for row item: " + "descendant::td[" + itemLoc + "]");
//                                    WebElement textItemObj = SeleniumFunctions.findElementByWebElement(tableBodyObj.get(tableRowIndex), SeleniumFunctions.setByValues("descendant::td[" + itemLoc + "];xpath"));
//                                    String displayedText="";
//                                    if(textItemObj!=null){
//                                        displayedText = textItemObj.getText();
//                                    }
//                                    UtilFunctions.log("row item displayed text: " + displayedText);
//                                    //Empty displayedText may be correct.  Only check innerHTML if we ARE NOT expecting an empty string
//                                    if ((displayedText.equals("") && (!textToCheck.equals(""))) || displayedText.equals("   ")) {
//                                        WebElement textObj = SeleniumFunctions.findElementByWebElement(textItemObj, SeleniumFunctions.setByValues("descendant-or-self::.//*[normalize-space(./text())]" + ";xpath"));
//                                        if(textObj!=null){
//                                            displayedText = textObj.getAttribute("innerHTML");
//                                        }
//                                        else {
//                                            textItemObj = SeleniumFunctions.findElementByWebElement(tableElement, SeleniumFunctions.setByValues(tableBody + "/tr["+tableRowIndex+"]/td[" + itemLoc + "]" + ";xpath"));
//                                            try{
//                                                displayedText = textItemObj.getText();
//                                                System.out.print(displayedText);
//                                            }
//                                            catch (Exception e){
//                                                UtilFunctions.log("Text not present");
//                                            }
//                                        }
//                                    }
//                                    displayedText = displayedText.trim().replaceAll("\\s+", " ");
//                                    if (displayedText.contains(textToCheck)) {
//                                        UtilFunctions.log("Text: '" + textToCheck + "' is present.");
//                                        foundItemCount++;
//                                    } else {
//                                        UtilFunctions.log("Text: '" + textToCheck + "' is not present.");
//                                        tempVal += "Text: '" + textToCheck + "' is not present.  ";
//                                        //Move on to next row of tableBodyObj if item not found
//                                        break;
//                                    }
//                                    headerLoc++;
//                                }
//                                if (foundItemCount == data.size()) {
//                                    rowFound = true;
//                                    //Move on to next data row if entire data row is found within a row from tableBodyObj
//                                    break;
//                                }
//                            }
//                            if (rowFound == true) {
//                                UtilFunctions.log("All items found for row");
//                                System.out.println("All items found for row");
//                                retValue = "";
//                            } else {
//                                retValue += tempVal;
//                            }
//                        }
//                    }
//                    else {
//                        UtilFunctions.log("Checking again as data table does not contain row name.");
//                        int checkCnt = 0;
//                        for (String value : dataTable.asList(String.class)){
//                            for (WebElement row : tableBodyObj){
//                                if (row.getText().contains(value)){
//                                    checkCnt++;
//                                    break;
//                                }
//                            }
//                        }
//                        if (checkCnt == dataTable.asList(String.class).size())
//                            retValue = "";
//                        else
//                            retValue += "Text is not present.";
//                    }
//                }
//            }
//        }
//        else {
//            System.out.println("No table present");
//            UtilFunctions.log("No table present. Returning false.");
//        }
//        return retValue;
//    }


    /**************************************************************************
     * Check if rows of data are present within a table
     *
     * @param driver - WebDriver object
     * @param curTabName - Name of current tab
     * @param type type of data
     * @param exactMatch exact match
     * @param tableName name of table
     * @param clinical clinical type
     * @param dataTable data to be checked in table
     * @return String
     *************************************************************************/
    //TODO: Refactor so that when comparing AMR, DMR order, case does not matter and whether there's a space between the measurement and the unit of measurement does not matter, (i.e.: 20 mg vs. 20mg vs 20MG)
    //TODO: Refactor to take out unused parameters
    public static boolean checkDataInTable(WebDriver driver, String curTabName, String type, String exactMatch,
                                           String tableName, String clinical, DataTable dataTable)
            throws InterruptedException {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + ": Start");
        UtilFunctions.log("tableName: " + tableName);

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

        SeleniumFunctions.selectFrame(driver, paneFrames, "id");
        SeleniumFunctions.explicitWait(driver, GlobalConstants.TWENTY, tablePath + ";xpath");

        ArrayList<String> headerArr = new ArrayList<String>();
        ArrayList<Integer> headerArrLoc = new ArrayList<Integer>();
        List<Map<String, String>> dataList = dataTable.asMaps(String.class, String.class);

        int keyLen;
        try {
            keyLen = dataList.get(0).keySet().size();
        } catch (Exception e) {
            keyLen = 0;
        }

        for (int keySize = 0; keySize < keyLen; keySize++) {
            headerArr.add((String) dataList.get(0).keySet().toArray()[keySize]);
            UtilFunctions.log("Added Key: " + dataList.get(0).keySet().toArray()[keySize]);
        }

        if (checkTableExists(driver, curTabName, tableName)) {
            UtilFunctions.log("Table: " + tableName + " exists.");
            WebElement tableElement = findTable(driver, tablePath);
            WebElement tableHeaderObj = findTableHead(tableElement, tableHead);
            if (tableHeaderObj == null) {
                UtilFunctions.log("Table Header: " + tableHead + " is not present.");
                return false;
            } else {
                List<WebElement> headersObjects = SeleniumFunctions.findElementsByWebElement(tableHeaderObj, SeleniumFunctions.setByValues("tr" + ";xpath"));
                if (headersObjects == null) {
                    UtilFunctions.log("Header values not displayed.");
                    return false;
                } else {
                    WebElement rowHeaderObj;
                    if (headersObjects.size() == 1)
                        rowHeaderObj = headersObjects.get(0);
                    else
                        rowHeaderObj = headersObjects.get(headersObjects.size() - 1);
                    List<WebElement> mainHeadersObjects = SeleniumFunctions.findElementsByWebElement(rowHeaderObj, By.xpath(".//descendant-or-self::th"));
//                    List<WebElement> mainHeadersObjects = SeleniumFunctions.findElementsByWebElement(rowHeaderObj, SeleniumFunctions.setByValues("descendant::th" + ";xpath"));
                    //Get the width of the browser window for lo-res edge cases -- HIC 10/29/18
                    int windowWidth = driver.manage().window().getSize().getWidth();
                    for (String headerName : headerArr) {
                        int headerLoc = 0;
                        for (WebElement headerObj : mainHeadersObjects) {
                            headerLoc++;
                            if (windowWidth <= 1280) {
                                ((JavascriptExecutor) driver).executeScript("arguments[0].scrollIntoView(true);",
                                        headerObj);
                            }
                            if (headerName.endsWith("*")) {
                                headerName = headerName.replace("*", "");
                            }
//                            String regEx = "^" + headerName + "$";
//                            if (headerObj.getText().matches(regEx)){
                            if (headerObj.getText().trim().contains(headerName.trim())) {
                                headerArrLoc.add(headerLoc);
                                break;
                            }
                        }
                    }
                    //If the browser window or monitor is lo-res, scroll the table back to the 1st col by its header -- HIC 10/29/18
                    if (windowWidth <= 1280) {
                        ((JavascriptExecutor) driver).executeScript("arguments[0].scrollIntoView(true);",
                                mainHeadersObjects.get(0));
                    }
                    int noOfRows = 0;
                    noOfRows = countTableRows(driver, curTabName, tableName, null, null);
                    UtilFunctions.log("No of rows in table: " + tableName + " is: " + noOfRows);
                    List<WebElement> tableBodyObj = SeleniumFunctions.findElementsByWebElement(tableElement,
                            SeleniumFunctions.setByValues(tableBody + "/tr" + ";xpath"));
                    if (exactMatch != null) {
                        if (exactMatch.equals("match")) {
                            if (noOfRows == tableBodyObj.size())
                                UtilFunctions.log("Total no of rows: " + noOfRows + " matched.");
                            else {
                                UtilFunctions.log("Total no of rows: " + noOfRows + " not matched.");
                                return false;
                            }
                        }
                    }
                    if (dataList.size() > 0) {
                        //For each Row in data set
                        for (int dataRowIndex = 0; dataRowIndex < dataList.size(); dataRowIndex++) {
                            Map data = dataList.get(dataRowIndex);
                            String tempVal = "";
                            //Check for values in each row of tableBodyObj
                            boolean rowFound = false;
                            for (int tableRowIndex = 0; tableRowIndex < tableBodyObj.size(); tableRowIndex++) {
                                UtilFunctions.log("Complete row text: " +
                                        tableBodyObj.get(dataRowIndex).getText());
                                int itemLoc;
                                int headerLoc = 0;
                                int foundItemCount = 0;
                                tempVal = "Data Row " + (dataRowIndex + 1) + ": ";
                                Iterator<Map.Entry<String, String>> iterator = data.entrySet().iterator();
                                //For each column in data set
                                while (iterator.hasNext()) {
                                    Map.Entry<String, String> entry = (Map.Entry<String, String>) iterator.next();
                                    String textToCheck = UtilFunctions.convertThruRegEx(entry.getValue());
                                    if (headerArrLoc.size() == 0)
                                        itemLoc = 1;
                                    else
                                        itemLoc = headerArrLoc.get(headerLoc);
                                    UtilFunctions.log("xpath for row item: " + "descendant::td[" + itemLoc + "]");
//                                    WebElement textItemObj = SeleniumFunctions.findElementByWebElement(tableBodyObj.get(tableRowIndex), SeleniumFunctions.setByValues("descendant::td[" + itemLoc + "];xpath"));
                                    WebElement textItemObj = SeleniumFunctions.findElementByWebElement(tableBodyObj.get(tableRowIndex),
                                            SeleniumFunctions.setByValues("td[" + itemLoc + "];xpath"));
                                    String displayedText = "";
                                    if (textItemObj != null) {
                                        displayedText = textItemObj.getText();
                                    }
                                    UtilFunctions.log("row item displayed text: " + displayedText);
                                    //Empty displayedText may be correct.  Only check innerHTML if we ARE NOT expecting an empty string
                                    if ((displayedText.equals("") && (!textToCheck.equals(""))) || displayedText.equals("   ")) {
                                        WebElement textObj = SeleniumFunctions.findElementByWebElement(textItemObj,
                                                SeleniumFunctions.setByValues("descendant-or-self::.//*[normalize-space(./text())]" + ";xpath"));
                                        if (textObj != null) {
                                            displayedText = textObj.getAttribute("innerHTML");
                                        } else {
                                            textItemObj = SeleniumFunctions.findElementByWebElement(tableElement,
                                                    SeleniumFunctions.setByValues(tableBody +
                                                            "/tr[" + tableRowIndex + "]/td[" + itemLoc + "]" + ";xpath"));
                                            try {
                                                displayedText = textItemObj.getText();
                                                System.out.print(displayedText);
                                            } catch (Exception e) {
                                                UtilFunctions.log("Text not present");
                                            }
                                        }
                                    }
                                    displayedText = displayedText.trim().replaceAll("\\s+", " ");
                                    if (displayedText.contains(textToCheck)) {
                                        UtilFunctions.log("Text: '" + textToCheck + "' is present.");
                                        foundItemCount++;
                                    } else {
                                        UtilFunctions.log("Text: '" + textToCheck + "' is not present.");
                                        tempVal += "Text: '" + textToCheck + "' is not present.  ";
                                        //Move on to next row of tableBodyObj if item not found
                                        break;
                                    }
                                    headerLoc++;
                                }
                                if (foundItemCount == data.size()) {
                                    rowFound = true;
                                    //Move on to next data row if entire data row is found within a row from tableBodyObj
                                    break;
                                }
                            }
                            if (rowFound == true) {
                                UtilFunctions.log("All items found for row");
                                System.out.println("All items found for row");
                            } else {
                                return false;
                            }
                        }
                    } else {
                        UtilFunctions.log("Checking again as data table does not contain row name.");
                        int checkCnt = 0;
                        for (String value : dataTable.asList(String.class)) {
                            for (WebElement row : tableBodyObj) {
                                if (row.getText().contains(value)) {
                                    checkCnt++;
                                    break;
                                }
                            }
                        }
                        return checkCnt == dataTable.asList(String.class).size();
                    }
                }
            }
        } else {
            System.out.println("No table present");
            UtilFunctions.log("No table present. Returning false.");
            return false;
        }

        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + ": Complete");
        return true;
    }


    public static boolean checkDataInTableUsingList(WebDriver driver, String curTabName, String type, String exactMatch,
                                                    String tableName, String clinical, List<Map<String, String>> dataList)
            throws InterruptedException {

        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("tableName: " + tableName);

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

        SeleniumFunctions.selectFrame(driver, paneFrames, "id");
        SeleniumFunctions.explicitWait(driver, GlobalConstants.TWENTY, tablePath + ";xpath");

        ArrayList<String> headerArr = new ArrayList<String>();
        ArrayList<Integer> headerArrLoc = new ArrayList<Integer>();

        int keyLen;
        try {
            keyLen = dataList.get(0).keySet().size();
        } catch (Exception e) {
            keyLen = 0;
        }

        for (int keySize = 0; keySize < keyLen; keySize++) {
            headerArr.add((String) dataList.get(0).keySet().toArray()[keySize]);
            UtilFunctions.log("Added Key: " + dataList.get(0).keySet().toArray()[keySize]);
        }

        if (checkTableExists(driver, curTabName, tableName)) {
            UtilFunctions.log("Table: " + tableName + " exists.");
            WebElement tableElement = findTable(driver, tablePath);
            WebElement tableHeaderObj = findTableHead(tableElement, tableHead);
            if (tableHeaderObj == null) {
                UtilFunctions.log("Table Header: " + tableHead + " is not present.");
                return false;
            } else {
                List<WebElement> headersObjects = SeleniumFunctions.findElementsByWebElement(tableHeaderObj,
                        SeleniumFunctions.setByValues(tableHead + "/tr" + ";xpath"));
                if (headersObjects == null) {
                    UtilFunctions.log("Header values not displayed.");
                    return false;
                } else {
                    WebElement rowHeaderObj;
                    if (headersObjects.size() == 1)
                        rowHeaderObj = headersObjects.get(0);
                    else
                        rowHeaderObj = headersObjects.get(headersObjects.size() - 1);
                    List<WebElement> mainHeadersObjects = SeleniumFunctions.findElementsByWebElement(rowHeaderObj,
                            SeleniumFunctions.setByValues("descendant::th" + ";xpath"));
                    for (String headerName : headerArr) {
                        int headerLoc = 0;
                        for (WebElement headerObj : mainHeadersObjects) {
                            headerLoc++;
                            System.out.println(headerObj.getText());
                            if (headerObj.getText().toLowerCase().contains(headerName.toLowerCase())) {
                                headerArrLoc.add(headerLoc);
                                break;
                            }
                        }
                    }
                    int noOfRows = 0;
                    noOfRows = countTableRows(driver, curTabName, tableName, null, null);
                    UtilFunctions.log("No of rows in table: " + tableName + " is: " + noOfRows);
                    List<WebElement> tableBodyRows = SeleniumFunctions.findElementsByWebElement(tableElement,
                            SeleniumFunctions.setByValues(tableBody + "/tr" + ";xpath"));
                    if (exactMatch != null) {
                        if (exactMatch.equals("match")) {
                            if (noOfRows == tableBodyRows.size())
                                UtilFunctions.log("Total no of rows: " + noOfRows + " matched.");
                            else {
                                UtilFunctions.log("Total no of rows: " + noOfRows + " not matched.");
                                return false;
                            }
                        }
                    }
                    if (dataList.size() > 0) {
                        int tableSize = tableBodyRows.size();
                        for (WebElement tableRow : tableBodyRows) {
                            int listLen = 0;
                            List<String> checkStr = new ArrayList<>();
                            List<WebElement> textItemObj = SeleniumFunctions.findElementsByWebElement(tableRow,
                                    SeleniumFunctions.setByValues("descendant::td;xpath"));
                            for (int loc : headerArrLoc) {
                                WebElement curObj = textItemObj.get(loc - 1);
                                UtilFunctions.log("Row item displayed text: " + curObj.getText());
                                String displayedText = curObj.getText();
                                if (displayedText.equals("")) {
                                    WebElement textObj = SeleniumFunctions.findElementByWebElement(curObj,
                                            SeleniumFunctions.setByValues("descendant-or-self::.//*[normalize-space(./text())]"
                                                    + ";xpath"));
                                    displayedText = textObj.getAttribute("innerHTML");
                                }
                                checkStr.add(displayedText);
                            }
                            for (listLen = 0; listLen < dataList.size(); listLen++) {
                                Map<String, String> tempMap = dataList.get(listLen);
                                Collection tempMapSet = tempMap.values();
                                String present = "";
                                boolean presentFlag;
                                for (String text : checkStr) {
                                    presentFlag = false;
                                    for (Object tempMapSetText : tempMapSet) {
                                        if ((((String) tempMapSetText).replaceAll("\\s+", " ")).contains(text.replaceAll("\\s+", " ").trim())
                                                || text.replaceAll("\\s+", " ").trim().contains(((String) tempMapSetText).replaceAll("\\s+", " "))) {
                                            presentFlag = true;
                                            break;
                                        }
                                    }
                                    if (!presentFlag) {
                                        //present = present + "Text: " + text + " not present";
                                        UtilFunctions.log("Text not matching: '" + text + "'.  Not present");
                                        break;
                                    }

//                                    if (!tempMap.containsValue(text.trim())) {
//                                        present = present + "Text: " + text + " not present";
//                                        UtilFunctions.log("Text not matching: " + present);
//                                    }
                                }

                                if (present.equals("")) {
                                    dataList.remove(listLen);
                                    break;
                                }
                            }
                            tableSize = tableSize - 1;
                            if (exactMatch.equals("match")) {
                                if (dataList.size() != tableSize)
                                    return false;
                            }
                            if (dataList.size() == 0)
                                break;
                        }
                        if (exactMatch.equals("contain")) {
                            if (dataList.size() > 0)
                                return false;
                        }
                    }
                }
            }
        } else {
            System.out.println("No table present");
            UtilFunctions.log("No table present. Returning false.");
            return false;
        }
        return true;
    }


    /**************************************************************************
     * name: getColumnValueObjInTable(WebDriver driver, String curTabName,
     * String tableName, String column, String value)
     * functionality: Function to get column value object
     * param: WebDriver driver - WebDriver object
     * param: String curTabName - Name of current tab
     * param: String tableName - Name of table
     * param: String column - Column name
     * param: String value - Text value of object
     * return: WebElement for the object having text as value
     *************************************************************************/
    public static WebElement getColumnValueObjInTable(WebDriver driver, String curTabName, String tableName, String column, String value) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("tableName: " + tableName);

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

        SeleniumFunctions.selectFrame(driver, paneFrames, "id");
        SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, tablePath + ";xpath");

        if (checkTableExists(driver, curTabName, tableName)) {
            UtilFunctions.log("Table: " + tableName + " exists.");
            WebElement tableElement = findTable(driver, tablePath);
            WebElement tableHeaderObj = findTableHead(tableElement, tableHead);
            if (tableHeaderObj == null) {
                UtilFunctions.log("Table Header: " + tableHead + " is not present.");
            } else {
                List<WebElement> headersObjects = SeleniumFunctions.findElementsByWebElement(tableHeaderObj,
                        SeleniumFunctions.setByValues(tableHead + "/tr" + ";xpath"));

                //if headerObjects = 0 then finding hearder objects with "./tr"
                if (headersObjects.size() == 0) {
                    headersObjects = SeleniumFunctions.findElementsByWebElement(tableHeaderObj,
                            SeleniumFunctions.setByValues("./tr" + ";xpath"));
                }
                if (headersObjects == null) {
                    UtilFunctions.log("Header values not displayed.");
                    return null;
                } else {
                    WebElement rowHeaderObj;
                    if (headersObjects.size() == 1)
                        rowHeaderObj = headersObjects.get(0);
                    else
                        rowHeaderObj = headersObjects.get(headersObjects.size() - 1);
                    List<WebElement> mainHeadersObjects = SeleniumFunctions.findElementsByWebElement(rowHeaderObj,
                            SeleniumFunctions.setByValues("descendant::th" + ";xpath"));
                    int headerLoc = 0;
                    for (WebElement headerObj : mainHeadersObjects) {
                        headerLoc++;
                        String headerTxt = headerObj.getText();
                        if (headerTxt.contains(column)) {
                            break;
                        }
                    }

                    List<WebElement> tableBodyObj = SeleniumFunctions.findElementsByWebElement(tableElement,
                            SeleniumFunctions.setByValues(tableBody + "/tr" + ";xpath"));

                    for (WebElement tableBodyRowObj : tableBodyObj) {
                        UtilFunctions.log("Complete row text: " + tableBodyRowObj.getText());
                        WebElement textItemObj = SeleniumFunctions.findElementByWebElement(tableBodyRowObj,
                                SeleniumFunctions.setByValues("descendant::td[" + headerLoc + "];xpath"));
                        UtilFunctions.log("xpath for row item: " + "descendant::td[" + headerLoc + "]");
                        String displayedText = textItemObj.getText();
                        UtilFunctions.log("row item displayed text: " + displayedText);

                        if (displayedText.toUpperCase().replace(" ", "").contains(value.toUpperCase().replace(" ", ""))) {
                            UtilFunctions.log("Item: " + value + " found. Returning the item's object");
                            return textItemObj;
                        }
                    }
                    return null;
                }
            }
        } else {
            System.out.println("No table present");
            UtilFunctions.log("No table present. Returning false.");
        }
        return null;
    }


    /**************************************************************************
     * name: getElementObject(WebDriver driver, String tabName,
     * String elementName, String elementType, String... paneName)
     * functionality: Function to get element object
     * param: WebDriver driver - WebDriver object
     * param: String tabName - Name of current tab
     * param: String elementName - Name of element
     * param: String elementType - Type of element
     * param: String... paneName - Optional parameter for pane name
     * return: WebElement for the element object
     *************************************************************************/
    public static WebElement getElementObject(WebDriver driver, String tabName, String elementName, String elementType, String... paneName) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);
        UtilFunctions.log("Element Name: " + elementName);
        UtilFunctions.log("Element Type: " + elementType);
        UtilFunctions.log("PaneName: " + paneName);

        String paneFrames;
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        String[] elementTypeArr = UtilFunctions.getElementStringAndType(fileObj, elementType + "." + elementName);
        String elementPath = elementTypeArr[0];
        String elementMethod = elementTypeArr[1];

        UtilFunctions.log("Element Path: " + elementPath);
        UtilFunctions.log("Element Method: " + elementMethod);

        if (paneName.length > 0)
            paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName[0].replace(" ", ""), "frame"));
        else
            paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, elementType + "." + elementName, "frame"));
        UtilFunctions.log("PaneFrames: " + paneFrames);
        SeleniumFunctions.selectFrame(driver, paneFrames, "id");
        SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, elementPath + ";" + elementMethod);
        return SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(elementPath + ";" + elementMethod));
    }


    /**************************************************************************
     * name: getColumnCoverageRange(WebDriver driver, String curTabName,
     * String tableName, String columnName)
     * functionality: Returns the range of indices covered by a particular
     * th element
     * param: WebDriver driver - WebDriver object
     * param: String curTabName - Name of current tabe
     * param: String tableName - Name of table
     * param: String columnName - Name of column
     * return: int array with range of indices for th element
     *************************************************************************/
    //Returns the range of indices covered by a particular th element
    public static int[] getColumnCoverageRange(WebDriver driver, String curTabName, String tableName, String columnName) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

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

        SeleniumFunctions.selectFrame(driver, paneFrames, "id");

        SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, tableHead + ";xpath");
        WebElement head = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(tableHead + ";xpath"));
        if (head == null) {
            UtilFunctions.log("Head object not present. Returning null.");
            return null;
        } else {
            WebElement headRow = SeleniumFunctions.findElementByWebElement(head, SeleniumFunctions.setByValues("tr;tagName"));
            if (headRow == null) {
                UtilFunctions.log("Head Row object not present. Returning null.");
                return null;
            } else {
                int colSpan = 0;
                int th_colspan_val = 1;
                List<WebElement> thArr = SeleniumFunctions.findElementsByWebElement(headRow, SeleniumFunctions.setByValues("th;tagName"));
                for (WebElement th : thArr) {
                    try {
                        th_colspan_val = Integer.parseInt(th.getAttribute("colspan"));
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    if (th.getText().replace("\n", " ").trim().equals(columnName)) {
                        UtilFunctions.log("Returning: " + colSpan + " and " + ((colSpan + th_colspan_val) - 1));
                        return new int[]{colSpan, (colSpan + th_colspan_val) - 1};
                    }
                    colSpan += th_colspan_val;
                }
            }
        }

        return null;
    }


    /**************************************************************************
     * name: getRowIndexByCellText(WebDriver driver, String tabName,
     * String tableName, String value)
     * functionality: Get row index based on text
     * param: WebDriver driver - WebDriver object
     * param: String tabName - Name of current tabe
     * param: String tableName - Name of table
     * param: String value - Row text whose index is needed
     * return: int row index
     *************************************************************************/
    public static int getRowIndexByCellText(WebDriver driver, String tabName, String tableName, String value, String elementType) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        List<WebElement> rows = getTableRows(driver, tabName, tableName);
        UtilFunctions.log("Size of rows: " + rows.size());
        for (int index = 0; index < rows.size(); index++) {
            List<WebElement> elementArr = SeleniumFunctions.findElementsByWebElement(rows.get(index), SeleniumFunctions.setByValues(elementType + ";tagName"));
            for (WebElement el : elementArr) {
                if (el.getText().trim().toLowerCase().equals(value.toLowerCase())) {
                    UtilFunctions.log("Returning index: " + index);
                    return index;
                }
            }
            elementArr.clear();
        }
        return 0;
    }


    /**************************************************************************
     * name: getTableRows(WebDriver driver, String curTabName,
     * String tableName)
     * functionality: Get list of table rows
     * param: WebDriver driver - WebDriver object
     * param: String curTabName - Name of current tabe
     * param: String tableName - Name of table
     * return: list of webelements containing table rows object
     *************************************************************************/
    public static List<WebElement> getTableRows(WebDriver driver, String curTabName, String tableName) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
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

        SeleniumFunctions.selectFrame(driver, paneFrames, "id");
        SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, tablePath + ";xpath");
        WebElement tableObj = findTable(driver, tablePath);

        if (tableObj == null) {
            UtilFunctions.log("Table object is null. Returning null.");
            return null;
        } else {
            WebElement tableBodyObj = SeleniumFunctions.findElementByWebElement(tableObj, SeleniumFunctions.setByValues(tableBody + ";xpath"));
            if (tableBodyObj == null) {
                UtilFunctions.log("Table Body object is null. Returning null.");
                return null;
            } else {
                UtilFunctions.log("Returning rows.");
                return SeleniumFunctions.findElementsByWebElement(tableBodyObj, SeleniumFunctions.setByValues("tr;tagName"));
            }
        }
    }


    /**************************************************************************
     * name: findTableElementByRowAndColumnIndex(WebDriver driver,
     * String tabName, String tableName, int colIndex, int rowIndex)
     * functionality: Get element from table row/column index
     * param: WebDriver driver - WebDriver object
     * param: String tabName - Name of current tabe
     * param: String tableName - Name of table
     * param: int colIndex - Column index
     * param: int rowIndex - Row index
     * return: WebElement
     *************************************************************************/
    public static WebElement findTableElementByRowAndColumnIndex(WebDriver driver, String tabName, String tableName, int colIndex, int rowIndex) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        tableName = tableName.replace(" ", "");

        List<WebElement> rows = getTableRows(driver, tabName, tableName);
        return SeleniumFunctions.findElementByWebElement(rows.get(rowIndex), SeleniumFunctions.setByValues("td[" + colIndex + 1 + "]" + ";xpath"));
    }

    public static boolean validateTableSort(WebDriver driver, String tableName, String columnName, String sortType, String sortOrder) throws java.text.ParseException {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        tableName = tableName.replace(" ", "");

        List<WebElement> rows = getTableRows(driver, curTabName, tableName);
        Assert.assertNotNull("Call to getTableRows returned null", rows);
        Assert.assertTrue("No table rows found.", rows.size() > 0);

        int columnIndex = Integer.parseInt(findTableColumn(driver, curTabName, tableName, columnName)) + 1;
        Assert.assertNotNull("Call to findTableColumn returned null", columnIndex);

        //No point in checking sort order if table only has one row
        if (rows.size() == 1) {
            return true;
        }

        //Create generic type list since we don't know the type of list we'll need at initialization.
        // This causes some "Unchecked call" warnings for the 'items' object, but the code works correctly
        List items;
        DateFormat format = null;
        switch (sortType) {
            case "numerically":
            case "alphabetically":
                items = new ArrayList<String>();
                break;
            case "chronologically":
                items = new ArrayList<Date>();
                String columnFormat = getTableColumnFormat(tableName, columnName.replace(" ", ""));
                if (columnFormat == null) {
                    UtilFunctions.log("Column format not found in element defintion.  Using default.");
                    columnFormat = "MM/dd/yy hh:mm aa";
                }
                UtilFunctions.log("Column format is: " + columnFormat);
                format = new SimpleDateFormat(columnFormat, Locale.ENGLISH);
                break;
            default:
                return false;
        }

        String cellText = null;
        for (WebElement row : rows) {
            cellText = SeleniumFunctions.findElementByWebElement(row, SeleniumFunctions.setByValues("td[" + columnIndex + "]" + ";xpath")).getText();
            switch (sortType) {
                case "numerically":
                case "alphabetically":
                    items.add(cellText);
                    break;
                case "chronologically":
                    items.add(format.parse(cellText));
                    break;
                default:
                    return false;
            }
        }

        List itemsSorted;
        switch (sortType) {
            case "numerically":
            case "alphabetically":
                itemsSorted = new ArrayList<String>(items);
                break;
            case "chronologically":
                itemsSorted = new ArrayList<Date>(items);
                break;
            default:
                return false;
        }

        Collections.sort(itemsSorted);
        if (sortOrder.equals("Descending")) {
            Collections.reverse(itemsSorted);
        }

        return items.equals(itemsSorted);
    }

    //Simpler version of findTableColumn:
//    public static int getColumnIndexByColumnValue(WebDriver driver, String tableName, String columnName) {
//        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
//        }.getClass().getEnclosingMethod().getName());
//
//        tableName = tableName.replace(" ", "");
//        String[] tableDetailArr = UtilFunctions.getTableValues(curTabName, tableName);
//        String tablePath = tableDetailArr[0];
//        String tableHead = tableDetailArr[2];
//        String paneFrames = tableDetailArr[4];
//
//        UtilFunctions.log("tablePath: " + tablePath);
//        UtilFunctions.log("tableHead: " + tableHead);
//        UtilFunctions.log("PaneFrames: " + paneFrames);
//
//        SeleniumFunctions.selectFrame(driver, paneFrames, "id");
//        WebElement tableObj = findTable(driver, tablePath);
//        if (tableObj == null) {
//            UtilFunctions.log("Table not present. Returning null.");
//            return -1;
//        }
//
//        WebElement headerRow = SeleniumFunctions.findElementByWebElement(tableObj, SeleniumFunctions.setByValues(tableHead + ";xpath"));
//        List<WebElement> headerCells = SeleniumFunctions.findElementsByWebElement(headerRow, SeleniumFunctions.setByValues("th;xpath"));
//        int index = 1; //xpath array index starts at 1, not 0
//        for (WebElement cell : headerCells) {
//            if (cell.getText().equals(columnName)) {
//                return index;
//            }
//            index++;
//        }
//
//        return -1;
//    }

    public static String getTableColumnFormat(String tableName, String columName) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        tableName = tableName.replace(" ", "");
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        return UtilFunctions.getElementFromJSONFile(fileObj, "TABLES." + tableName, columName + "_Column_Format");
    }

    /**************************************************************************
     * name: highlight(WebDriver driver, WebElement contentDiv, int start_x,
     * int start_y, int end_x, int end_y)
     * functionality: Function to highlight a text area
     * param: WebDriver driver - WebDriver object
     * param: WebElement contentDiv - WebElement object
     * param: int start_x - Start x location
     * param: int start_y - Start y location
     * param: int end_x - End x location
     * param: int end_y - End y location
     * return: void
     *************************************************************************/
    public static void highlight(WebDriver driver, WebElement contentDiv, int start_x, int start_y, int end_x, int end_y) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        int distance_x = end_x - start_x;
        int distance_y = end_y - start_y;

        contentDiv.getText();
        contentDiv.click();
        Actions actions = new Actions(driver);
        Action action = actions.moveToElement(contentDiv, start_x, start_y).clickAndHold().moveByOffset(distance_x, distance_y).release().build();
        action.perform();
    }


    /**************************************************************************
     * name: getTableFieldValue(WebDriver driver, String curTabName,
     * String tableName, String sectionName, String label)
     * functionality: Function to get value from table
     * param: WebDriver driver - WebDriver object
     * param: String curTabName - Name of tab
     * param: String tableName - Table name
     * param: String sectionName - Section name
     * param: String label - Label value
     * return: returns field value
     *************************************************************************/
    public static String getTableFieldValue(WebDriver driver, String curTabName, String tableName, String sectionName, String label) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + curTabName);

        int startRow = -1;
        int endRow = -1;
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

        SeleniumFunctions.selectFrame(driver, paneFrames, "id");
        WebElement tableObj = findTable(driver, tablePath);
        if (tableObj == null) {
            UtilFunctions.log("Table not present. Returning null.");
            return null;
        }

        WebElement tBody = SeleniumFunctions.findElementByWebElement(tableObj, SeleniumFunctions.setByValues("tbody;tagName"));
        if (tBody == null) {
            UtilFunctions.log("Table body not present. Returning null.");
            return null;
        }

        List<WebElement> rows = SeleniumFunctions.findElementsByWebElement(tBody, SeleniumFunctions.setByValues("tr;tagName"));
        if (rows.size() < GlobalConstants.ONE) {
            UtilFunctions.log("Table rows not present. Returning null.");
            return null;
        }

        if (sectionName == null || sectionName.equals("")) {
            startRow = 0;
            endRow = rows.size();
        } else {
            startRow = Page.findTableSection(Hooks.getDriver(), curTabName, tableName, sectionName);
            for (int index = startRow + 1; index < rows.size(); index++) {
                List<WebElement> heads = SeleniumFunctions.findElementsByWebElement(rows.get(index), SeleniumFunctions.setByValues("td;xpath"));
                for (WebElement head : heads) {
                    if (head.getAttribute("class").equals("sectionHeader")) {
                        endRow = index;
                        break;
                    }
                }
                if (endRow > -1)
                    break;
            }
            if (endRow == -1)
                endRow = rows.size();
        }
        if (startRow == -1)
            return null;

        int labelRow = -1;
        int labelCol = -1;
        int valueCol = -1;
        String valueText = "";

        for (int cnt = startRow; cnt < endRow; cnt++) {
            List<WebElement> heads = SeleniumFunctions.findElementsByWebElement(rows.get(cnt), SeleniumFunctions.setByValues("td;xpath"));
            for (int cnt2 = 0; cnt2 < heads.size(); cnt2++) {
                if (heads.get(cnt2).getText().trim().equals(label)) {
                    labelRow = cnt;
                    labelCol = cnt2;
                    valueCol = cnt2 + 1;
                    valueText = heads.get(valueCol).getText();
                    for (int cnt3 = labelRow + 1; cnt3 < endRow; cnt3++) {
                        List<WebElement> cells = SeleniumFunctions.findElementsByWebElement(rows.get(cnt3), SeleniumFunctions.setByValues("td;xpath"));
                        if (cells.get(labelCol).getText().trim().equals(""))
                            valueText += " " + cells.get(valueCol).getText();
                        else
                            break;
                    }
                    valueText = valueText.trim();
                    return valueText;
                }
            }
        }
        return null;
    }


    /**************************************************************************
     * name: findTableSection(WebDriver driver, String curTabName,
     * String tableName, String sectionHeaderValue)
     * functionality: Function to get table section index
     * param: WebDriver driver - WebDriver object
     * param: String curTabName - Name of tab
     * param: String tableName - Table name
     * param: String sectionHeaderValue - Section haeder value
     * return: returns table section index
     *************************************************************************/
    public static int findTableSection(WebDriver driver, String curTabName, String tableName, String sectionHeaderValue) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + curTabName);

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

        SeleniumFunctions.selectFrame(driver, paneFrames, "id");
        WebElement tableObj = findTable(driver, tablePath);
        if (tableObj == null) {
            UtilFunctions.log("Table not present. Returning null.");
            return -1;
        }

        WebElement tBody = SeleniumFunctions.findElementByWebElement(tableObj, SeleniumFunctions.setByValues("tbody;tagName"));
        if (tBody == null) {
            UtilFunctions.log("Table body not present. Returning null.");
            return -1;
        }

        List<WebElement> rows = SeleniumFunctions.findElementsByWebElement(tBody, SeleniumFunctions.setByValues("tr;tagName"));
        if (rows.size() < GlobalConstants.ONE) {
            UtilFunctions.log("Table rows not present. Returning null.");
            return -1;
        }

        for (int index = 0; index < rows.size(); index++) {
            List<WebElement> heads = SeleniumFunctions.findElementsByWebElement(rows.get(index), SeleniumFunctions.setByValues("td;xpath"));
            for (WebElement head : heads) {
                if (head.getAttribute("class").equals("sectionHeader")) {
                    if (head.getText().trim().equals(sectionHeaderValue))
                        return index;
                }
            }
        }
        return -1;
    }


    /**************************************************************************
     * name: prepareQuery(String queryName, boolean... limitValue)
     * functionality: Function to prepare DB query
     * param: String queryName - Name of query
     * param:  boolean... limitValue - Optional boolean value
     * return: returns DBExecutor class object
     *************************************************************************/
    public static DBExecutor prepareQuery(String queryName, boolean... limitValue) throws SQLException, ParseException {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        DBExecutor dbExecutor = null;
        boolean limit;
        queryName = queryName.replace(" ", "");
        String table;
        table = UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(GlobalStepdefs.curTabName,
                "QUERIES", queryName, "table", "", "Query");

        if (table == null || table.equals(""))
            table = "nested_table";

        if (limitValue.length > 0) {
            limit = limitValue[0];
        } else {
            limit = true;
        }

        if (UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(GlobalStepdefs.curTabName,
                "QUERIES", queryName, "nolimit", "", "Query") != null &&
                UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(GlobalStepdefs.curTabName,
                        "QUERIES", queryName, "nolimit", "", "Query").equals("true"))
            limit = false;

        dbExecutor = new DBExecutor(table,
                UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(GlobalStepdefs.curTabName, "QUERIES", queryName, "columns", "", "Query"),
                limit,
                UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(GlobalStepdefs.curTabName, "QUERIES", queryName, "option", "", "Query"),
                UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(GlobalStepdefs.curTabName, "QUERIES", queryName, "helpers", "", "Query"),
                queryName);

        if (UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(GlobalStepdefs.curTabName, "QUERIES", queryName, "nested_columns", "", "Query") != null) {
            //Do Something
        }

        if (UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(GlobalStepdefs.curTabName, "QUERIES", queryName, "with", "", "Query") != null) {
            //Do Something
        }

        //Queries containing "set" are update queries
        if (UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(GlobalStepdefs.curTabName, "QUERIES", queryName, "update", "", "Query") != null &&
                UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(GlobalStepdefs.curTabName, "QUERIES", queryName, "update", "", "Query").equals("true") &&
                UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(GlobalStepdefs.curTabName, "QUERIES", queryName, "set", "", "Query") != null) {
            dbExecutor.addSet(UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(GlobalStepdefs.curTabName, "QUERIES", queryName, "set", "", "Query"));
        }

        if (UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(GlobalStepdefs.curTabName, "QUERIES", queryName, "join", "", "Query") != null) {
            String joinType = "LEFT";
            dbExecutor.addJoin(UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(GlobalStepdefs.curTabName, "QUERIES", queryName, "join", "", "Query"), joinType);
        }

        if (UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(GlobalStepdefs.curTabName, "QUERIES", queryName, "where", "", "Query") != null) {
            dbExecutor.addWhere(UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(GlobalStepdefs.curTabName, "QUERIES", queryName, "where", "", "Query"));
        }

        if (UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(GlobalStepdefs.curTabName, "QUERIES", queryName, "group", "", "Query") != null) {
            dbExecutor.addGroup(UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(GlobalStepdefs.curTabName, "QUERIES", queryName, "group", "", "Query"));
        }

        if (UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(GlobalStepdefs.curTabName, "QUERIES", queryName, "order", "", "Query") != null) {
            dbExecutor.addOrder(UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(GlobalStepdefs.curTabName, "QUERIES", queryName, "order", "", "Query"));
        }

        if (UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(GlobalStepdefs.curTabName, "QUERIES", queryName, "union", "", "Query") != null) {
            //Do Something
        }

        dbExecutorMap.put(dbExecutorMap.size(), dbExecutor);
        return dbExecutor;
    }


    public static String findTableColumn(WebDriver driver, String curTabName, String tableName, String headerValue) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("tableName: " + tableName);
        tableName = tableName.replace(" ", "");
        headerValue = headerValue.trim();
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

        SeleniumFunctions.selectFrame(driver, paneFrames, "id");
        SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, tablePath + ";xpath");

        if (checkTableExists(driver, curTabName, tableName)) {
            UtilFunctions.log("Table: " + tableName + " exists.");
            WebElement tableElement = findTable(driver, tablePath);
            //This is to accept the regEx like (\d of \d)
            headerValue = headerValue.replace("(", "\\(").replace(")", "\\)");
            if (headerValue.contains("\\d")) {
                headerValue = headerValue.replace("\\d", "\\d+");
                String splitStr = " \\d";
                String[] headerParts = headerValue.split(splitStr);
                int count = headerParts.length;
                headerValue = headerParts[0];
                for (int i = 1; i < count; i++) {
                    headerParts[i] = splitStr + headerParts[i];
                    headerParts[i] = headerParts[i].trim();
                    headerValue += ".*" + headerParts[i];
                }
            }
            //if (headerValue.matches("^" + headerValue + "\\*/"))
            if (headerValue.endsWith("*")) {
                headerValue = headerValue.replace("*", ".*");
            }

            WebElement tableHeaderObj = findTableHead(tableElement, tableHead);
            if (tableHeaderObj == null) {
                UtilFunctions.log("Table Header: " + tableHead + " is not present.");
            } else {
                List<WebElement> headersObjects;
                headersObjects = SeleniumFunctions.findElementsByWebElement(tableHeaderObj, SeleniumFunctions.setByValues("tr[descendant::th]" + ";xpath"));
                if (headersObjects == null || headersObjects.size() == 0) {
                    UtilFunctions.log("Header values not displayed. Checking again.");
                    headersObjects = SeleniumFunctions.findElementsByWebElement(tableHeaderObj, SeleniumFunctions.setByValues("tr" + ";xpath"));
                }

                for (int i = 0; i < headersObjects.size(); i++) {
                    List<WebElement> head = SeleniumFunctions.findElementsByWebElement(headersObjects.get(i), SeleniumFunctions.setByValues("th" + ";tagName"));
                    if (head == null)
                        head = SeleniumFunctions.findElementsByWebElement(headersObjects.get(i), SeleniumFunctions.setByValues("td" + ";tagName"));
                    for (int j = 0; j < head.size(); j++) {
                        if (!head.get(j).isDisplayed()) {
                            try {
                                ((JavascriptExecutor) driver).executeScript("arguments[0].scrollIntoView(true);", head.get(j));
                            } catch (Exception e) {
                                UtilFunctions.log("Optional try: Scroll bar is not found:" + e.getMessage());
                            }
                        }
                        String text = head.get(j).getText();
                        text = text.replace("\n", " ").trim();
                        int displayedCount = 0;
                        while (!head.get(j).isDisplayed()) {
                            displayedCount++;
                            WebElement innerElement = SeleniumFunctions.findElementByWebElement(head.get(j),
                                    SeleniumFunctions.setByValues(".//descendant-or-self::*[boolean(text()) and not(*)]"
                                            + ";xpath"));
                            if (innerElement != null) {
                                text = innerElement.getAttribute("innerHTML");
                                text = text.replace("&nbsp;", " ").trim();
                            }
                            if (displayedCount > GlobalConstants.TEN)
                                break;
                        }

                        String regEx = "^" + headerValue + "$";
                        if (text.matches(regEx) || text.contains(headerValue)) {
                            return String.valueOf(j);

                        }
                    }
                }
            }
        }
        return null;
    }


    public static boolean setPKList(WebDriver driver, String tabName, String value, String pkListName, String paneName) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);

        pkListName = pkListName.replace(" ", "");
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        String paneFrames;
        String[] elementType = UtilFunctions.getElementStringAndType(fileObj, "PKLISTS." + pkListName);
        String pkListPath = elementType[0];
        String pkListMethod = elementType[1];

        if (paneName == null)
            paneFrames = UtilFunctions.getFrameValue(frameMap,
                    UtilFunctions.getElementFromJSONFile(fileObj, "PKLISTS." + pkListName, "frame"));
        else
            paneFrames = UtilFunctions.getFrameValue(frameMap,
                    UtilFunctions.getElementFromJSONFile(fileObj,
                            "PANES." + paneName.replace(" ", ""), "frame"));

        UtilFunctions.log("PaneFrames: " + paneFrames);
        SeleniumFunctions.selectFrame(driver, paneFrames, "id");

        SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, pkListPath + ";" + pkListMethod);
        WebElement pkListObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(pkListPath +
                ";" + pkListMethod));

        if (pkListObj == null) {
            UtilFunctions.log("PK List '" + pkListName + "' object null. Returning false.");
            return false;
        } else {
            WebElement elt = SeleniumFunctions.findElementByWebElement(pkListObj,
                    SeleniumFunctions.setByValues(".//*[text()='" + value + "']" + ";xpath"));
            if (elt == null) {
                UtilFunctions.log("PK List child object null. Trying with all caps.");
                elt = SeleniumFunctions.findElementByWebElement(pkListObj,
                        SeleniumFunctions.setByValues(".//*[text()='" + value.toUpperCase() + "']" + ";xpath"));
                if (elt == null) {
                    UtilFunctions.log("PK List child object again null. Trying with position.");
                    elt = SeleniumFunctions.findElementByWebElement(pkListObj,
                            SeleniumFunctions.setByValues(".//*[position()='" + value + "']" + ";xpath"));
                    if (elt == null) {
                        UtilFunctions.log("PK List child object again null for the third time. Returning false.");
                        return false;
                    }
                }
            }

            String selectedText;
            try {
                SeleniumFunctions.click(elt);
                selectedText = Page.getSelectedOptionFromPKlist(Hooks.getDriver(), pkListPath);
                if (!(selectedText.equalsIgnoreCase(value))) {
                    SeleniumFunctions.click(elt);
                    selectedText = Page.getSelectedOptionFromPKlist(Hooks.getDriver(), pkListPath);
                    if (!(selectedText.equalsIgnoreCase(value))) {
                        Actions actions = new Actions(Hooks.getDriver());
                        actions.moveToElement(elt).click().build().perform();
                        selectedText = Page.getSelectedOptionFromPKlist(Hooks.getDriver(), pkListPath);
                        if (!(selectedText.equalsIgnoreCase(value))) {
                            UtilFunctions.log("'" + value + "' not selected from PK List: " + pkListName +
                                    " after trying with .click(), JS click, or Actions click.  Returning false...");
                            System.out.println("'" + value + "' not selected from PK List: " + pkListName +
                                    " after trying with .click(), JS click, or Actions click.  Returning false...");
                            return false;
                        }
                    }
                }
            } catch (ElementClickInterceptedException e) {
                UtilFunctions.log(value + " not selected from: " + pkListName + " on 1st try due to: " + e.getMessage()
                        + "Trying again w/ JS click.");
                e.printStackTrace();
                SeleniumFunctions.click(elt);
                selectedText = Page.getSelectedOptionFromPKlist(Hooks.getDriver(), pkListPath);
                if (!(selectedText.equalsIgnoreCase(value))) {
                    Actions actions = new Actions(Hooks.getDriver());
                    actions.moveToElement(elt).click().build().perform();
                    if (!(selectedText.equalsIgnoreCase(value))) {
                        UtilFunctions.log("'" + value + "' not selected from PK List: " + pkListName +
                                " after trying with .click(), JS click, or Actions click.  Returning false...");
                        System.out.println("'" + value + "' not selected from PK List: " + pkListName +
                                " after trying with .click(), JS click, or Actions click.  Returning false...");
                        return false;
                    }
                }
            }
            return true;
        }
    }


    /**************************************************************************
     * Override findTableRowsByValue method to pass default maxRows value of 1
     * @param driver WebDriver object
     * @param tableName table name
     * @param headerValue column name
     * @param value row value
     * @return WebElement Array
     *************************************************************************/
    public static List<WebElement> findTableRowsByValue(WebDriver driver, String tableName, String headerValue, String value) {
        return findTableRowsByValue(driver, tableName, headerValue, value, 1);
    }

    /**************************************************************************
     * Find table rows by value
     * @param driver WebDriver object
     * @param tableName table name
     * @param headerValue column name
     * @param value row value
     * @param maxRows the maximum number of rows to return in WebElement array
     * @return WebElement Array
     *************************************************************************/
    public static List<WebElement> findTableRowsByValue(WebDriver driver, String tableName, String headerValue, String value, int maxRows) {
        int colIndex;
        tableName = tableName.replace(" ", "");
        headerValue = headerValue.trim();
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

        try {
//            String rows[] = new String[1];
//            WebElement rows[] = new WebElement[5];

            ArrayList<WebElement> rows = new ArrayList<>();


            if (StringUtils.isEmpty(headerValue))
                colIndex = 0;
            else
                colIndex = Integer.parseInt(findTableColumn(driver, curTabName, tableName, headerValue));

            int checkTableCnt = 0;
            while (!checkTableExists(driver, curTabName, tableName)) {
                checkTableCnt++;
                if (checkTableCnt > GlobalConstants.TWO) {
                    UtilFunctions.log("Table: " + tableName + " is not present. Returning null.");
                    return null;
                }
            }
            WebElement tableObj = findTable(driver, tablePath);
            if (tableObj == null) {
                UtilFunctions.log("Table: " + tableName + " is not present. Returning null.");
                return null;
            } else {
                WebElement tableBodyObj = SeleniumFunctions.findElementByWebElement(tableObj, SeleniumFunctions.setByValues(tableBody + ";xpath"));
                if (tableBodyObj == null) {
                    UtilFunctions.log("TableBody object for table: " + tableName + " is not present. Returning null.");
                    return null;
                } else {
                    List<WebElement> tableRows = SeleniumFunctions.findElementsByWebElement(tableBodyObj, SeleniumFunctions.setByValues("tr" + ";tagName"));
                    int rowCount = 0;
                    int i = -1;
                    if (tableRows != null)
                        for (WebElement row : tableRows) {
                            i += 1;
                            WebElement col;
                            List<WebElement> cols = SeleniumFunctions.findElementsByWebElement(row, SeleniumFunctions.setByValues("td" + ";tagName"));
                            if (colIndex < cols.size()) {
                                col = cols.get(colIndex);
                                String text = col.getText();
                                if (text.isEmpty()) {
                                    try {
                                        WebElement colInput = SeleniumFunctions.findElementByWebElement(row, SeleniumFunctions.setByValues("input" + ";tagName"));
                                        text = colInput.getAttribute("value");
                                    } catch (NoSuchMethodError e) {
                                        //Do nothing.  NoMethodError occurs when colInput is nil, which is possible.
                                    }
                                }
                                text = text.trim().replaceAll("\\s+", " ");
                                if (text.equals(value)) {
                                    if (rows != null) {
//                                        rows[i] = row;
                                        rows.add(row);
                                        rowCount += 1;
                                        if (rowCount == maxRows) {
                                            return rows;
//                                            return row;
//                                        break;
                                        }
                                    }
                                    return rows;
//                                    return row;
//                                    return tableRows;
                                }
                            }
//                        //try alternate method of matching
//                        if (rowCount == 0) {
//                            i = -1;
//                            for (WebElement newRow : tableRows) {
//                                i += 1;
//                                String text = "";
//                                cols = SeleniumFunctions.findElementsByWebElement(newRow, SeleniumFunctions.setByValues("td" + ";tagName"));
//                                if (colIndex < cols.size()) {
//                                    col = cols.get(colIndex);
//                                    List<WebElement> txtObjects = SeleniumFunctions.findElementsByWebElement(col, SeleniumFunctions.setByValues("//descendant-or-self::*[boolean(text())]" + ";xpath"));
//                                    if (txtObjects != null)
//                                        for (WebElement textObj : txtObjects) {
//                                            text += textObj.getAttribute("innerHTML");
//                                        }
//                                    if (text.equals(value))
//                                        if (rows != null)
//                                            rows[i] = text;
//                                    rowCount += 1;
//                                    if (rowCount == maxRows)
//                                        return rows;
//                                    break;
//                                }
//                            }
//                        }
//                        //try matching without spaces. sometimes order strings from the db have extra spaces
//                        i = -1;
//                        for (WebElement newRows : tableRows) {
//                            i += 1;
//                            cols = SeleniumFunctions.findElementsByWebElement(newRows, SeleniumFunctions.setByValues("td" + ";tagName"));
//                            if (colIndex < cols.size()) {
//                                col = cols.get(colIndex);
//                                String text = col.getText();
//                                text = text.trim();
//                                if (text.replace(" ", "").equals(value.replace(" ", "")))
//                                    if (rows != null)
//                                        rows[i] = text;
//                                rowCount += 1;
//                                if (rowCount == maxRows)
//                                    return rows;
//                                break;
//
//                            }
//                        }
                        }
                }
            }
        } catch (StaleElementReferenceException e) {
            return null;
            //Do nothing.  StaleElementReferenceException occurs when element has been deleted entirely or is no longer attached to the DOM, which is possible.
        }
        return null;
    }

    /**
     * getSelectedOptionFromPKlist(WebDriver driver, String xpath)
     *
     * @param driver -- web driver
     * @param xpath  -- path of the PK List or multiselect listbox from which to get the selected option
     * @return the selected option in the PK List or multiselect listbox as a String
     */
    //Renaming this method, as it does not get a multiselect list.  It returns the selected option as a String.
    public static String getSelectedOptionFromPKlist(WebDriver driver, String xpath) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        WebElement pkList = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(xpath + ";xpath"));
        if (pkList == null) {
            UtilFunctions.log("PK List object with xpath: " + xpath + " is null. Returning null.");
            return null;
        } else {
            WebElement selectedEle = SeleniumFunctions.findElementByWebElement(pkList,
                    SeleniumFunctions.setByValues(".//li[@class='md-list-item selected']" + ";xpath"));
            if (selectedEle == null) {
                selectedEle = SeleniumFunctions.findElementByWebElement(pkList,
                        SeleniumFunctions.setByValues(".//div[@class='option-selected']" + ";xpath"));
            }
            if (selectedEle == null) {
                UtilFunctions.log("Selected Element object with xpath: .//li[@class='md-list-item selected'] is" +
                        " null. Returning null.");
                return null;
            } else {
                UtilFunctions.log("Returning text: " + selectedEle.getText());
                return selectedEle.getText();
            }
        }
    }


    public static WebElement findTableRowByCellText(WebDriver driver, String curTabName, String tableName, String headerValue, String value) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("tableName: " + tableName);

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

        int colIndex;
        if (headerValue == null) {
            colIndex = 0;
        } else {
            headerValue = headerValue.trim();
            colIndex = Integer.parseInt(findTableColumn(driver, curTabName, tableName.trim(), headerValue));
        }

        int checkTableCnt = 0;
        while (!checkTableExists(driver, curTabName, tableName)) {
            checkTableCnt++;
            if (checkTableCnt > GlobalConstants.TWO) {
                UtilFunctions.log("Table: " + tableName + " is not present. Returning null.");
                return null;
            }
        }
        WebElement tableObj = findTable(driver, tablePath);
        if (tableObj == null) {
            UtilFunctions.log("Table: " + tableName + " is not present. Returning null.");
            return null;
        } else {
            WebElement tableBodyObj = SeleniumFunctions.findElementByWebElement(tableObj,
                    SeleniumFunctions.setByValues(tableBody + ";xpath"));
            if (tableBodyObj == null) {
                UtilFunctions.log("TableBody object for table: " + tableName +
                        " is not present. Returning null.");
                return null;
            } else {
                List<WebElement> rows = SeleniumFunctions.findElementsByWebElement(tableBodyObj,
                        SeleniumFunctions.setByValues("tr" + ";xpath"));
                WebElement col;
                for (WebElement row : rows) {
                    List<WebElement> cols = SeleniumFunctions.findElementsByWebElement(row,
                            SeleniumFunctions.setByValues("td" + ";xpath"));
                    if (colIndex < cols.size()) {
                        col = cols.get(colIndex);
                        String text = col.getText().trim();
                        if (text.equals("") && value != null) {
                            List<WebElement> txtObjects = SeleniumFunctions.findElementsByWebElement(col,
                                    SeleniumFunctions.setByValues(".//descendant-or-self::*[boolean(normalize-space(./text()))]"
                                            + ";xpath"));
                            for (WebElement textObj : txtObjects)
                                text += textObj.getAttribute("innerHTML");
                        }
                        text = text.replace("&nbsp;", " ");
                        if (headerValue == "Name (\\d)" && text.equals(value)) {
                            UtilFunctions.log("Name: " + text + " is present. Returning row.");
                            return row;
                        } else if (text.equals(value) || text.contains(value)) {
                            UtilFunctions.log("Text: " + text + " is present. Returning row.");
                            return row;
                        }
                    }
                }
            }
        }
        UtilFunctions.log("Text: " + value + " not found in table. Returning null.");
        return null;
    }

    /**************************************************************************
     * name: checkIfLinkExists(WebDriver driver, String text, String tag,
     * String section)
     * functionality: Function to check if the link text exits
     * param: WebDriver driver - WebDriver object
     * param: String text - Name of link text
     * param: String tag - Tag of link
     * param: String section - Section of xpath value
     * return: returns True if the link text exists else false
     *************************************************************************/
    public static boolean checkIfLinkExists(WebDriver driver, String text) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        return findLinkText(driver, text, "", "") != null;
    }

    /**************************************************************************
     * name: dragAndDrop(WebDriver driver, WebElement source, WebElement target)
     * functionality: Function to drag and drop element
     * @param: WebDriver driver - WebDriver object
     * @param: WebElement source - source element to be dragged and dropped
     * @param: WebElement target - target element where the source element is dropped
     *************************************************************************/
    public static void dragAndDrop(WebDriver driver, WebElement source, WebElement target) throws InterruptedException {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        try {
            //This keeps failing in Patient Safety in IE when running overnight.  Splitting each action up
            // and increasing wait time (from 250ms to 500).
            Actions actions = new Actions(driver);
            actions.click(source).perform();// This click is needed for many of the drag and drops to work correctly.
            actions.clickAndHold(source).perform();
            Thread.sleep(500);
            actions.moveToElement(target).perform();
            Thread.sleep(500);
            actions.release(target).perform();
            Thread.sleep(500);
        } catch (StaleElementReferenceException se) {
            se.printStackTrace();
            UtilFunctions.log("Stale Element exception. Drag and Drop may already be performed by moveToElement(). Exception: "
                    + se.getMessage());
        }
    }


    //Overloaded dragAndDrop 2
    public static boolean dragAndDrop(WebDriver driver, String sourceXpath, String targetXpath)
            throws InterruptedException {

        WebElement source = null, target = null;

        for (int i = 0; i < GlobalConstants.FIVE; ++i) {
            source = SeleniumFunctions.findElement(driver, By.xpath(sourceXpath));
            target = SeleniumFunctions.findElement(driver, By.xpath(targetXpath));
            if (source != null && target != null) {
                try {
                    dragAndDrop(driver, source, target);//call to og method
                    return true;
                } catch (NullPointerException e) {
                    UtilFunctions.log("Drag and drop failed due to: " + e.getMessage());
                    e.printStackTrace();
                }
            }
        }//end for
        return false;
    }


    public static boolean javascriptDragAndDrop(WebDriver driver, String sourceXpath, String targetXpath) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + ": Start");

        JavascriptExecutor js = (JavascriptExecutor) driver;
        /*String jsStr = "function createEvent(typeOfEvent) {" +
                "    var event = document.createEvent('CustomEvent');" +
                "    event.initCustomEvent(typeOfEvent, true, true, null);" +
                "    event.dataTransfer = {" +
                "        data: {}," +
                "        setData: function (key, value) {" +
                "            this.data[key] = value;" +
                "        }," +
                "        getData: function (key) {" +
                "            return this.data[key];" +
                "        }" +
                "    };" +
                "    return event;" +
                "}" +
                "function dispatchEvent(element, event, transferData) {" +
                "    if (transferData !== undefined) {" +
                "        event.dataTransfer = transferData;" +
                "    }" +
                "    if (element.dispatchEvent) {" +
                "        element.dispatchEvent(event);" +
                "    } else if (element.fireEvent) {" +
                "        element.fireEvent('on' + event.type, event);" +
                "    }" +
                "}" +
                "function simulateHTML5DragAndDrop(element, target) {" +
                "    var dragStartEvent = createEvent('dragstart');" +
                "    dispatchEvent(element, dragStartEvent);" +
                "    var dropEvent = createEvent('drop');" +
                "    dispatchEvent(target, dropEvent, dragStartEvent.dataTransfer);" +
                "    var dragEndEvent = createEvent('dragend');" +
                "    dispatchEvent(element, dragEndEvent, dropEvent.dataTransfer);" +
                "}" +
                "var elementToDrag = arguments[0];" +
                "var target = arguments[1];" +
                "simulateHTML5DragAndDrop(elementToDrag, target);";
*/

        String jsStr = "function simulate(f,c,d,e){" +
                "var b, a=null;" +
                "for(b in eventMatchers) if(eventMatchers[b].test(c)){ a=b; break;}" +
                "if(!a) return!1;" +
                "document.createEvent?(" +
                "b=document.createEvent(a)," +
                "a=='HTMLEvents'?b.initEvent(c,!0,!0):b.initMouseEvent(c,!0,!0,document.defaultView,0,d,e,d,e,!1,!1,!1,!1,0,null)," +
                "f.dispatchEvent(b)):(a=document.createEventObject()," +
                "a.detail=0," +
                "a.screenX=d," +
                "a.screenY=e," +
                "a.clientX=d," +
                "a.clientY=e," +
                "a.ctrlKey=!1," +
                "a.altKey=!1," +
                "a.shiftKey=!1," +
                "a.metaKey=!1," +
                "a.button=1," +
                "f.fireEvent('on'+c,a));return!0} " +
                "var eventMatchers={" +
                "HTMLEvents:/^(?:load|unload|abort|error|select|change|submit|reset|focus|blur|resize|scroll)$/," +
                "MouseEvents:/^(?:click|dblclick|mouse(?:down|up|over|move|out))$/}; " +
                "simulate(arguments[0],'mousedown',0,0); " +
                "simulate(arguments[0],'mousemove',arguments[1],arguments[2]); " +
                "simulate(arguments[0],'mouseup',arguments[1],arguments[2]); ";

        WebElement source = SeleniumFunctions.findElement(driver, By.xpath(sourceXpath));
        WebElement target = SeleniumFunctions.findElement(driver, By.xpath(targetXpath));

        String xto = Integer.toString(target.getLocation().x);
        String yto = Integer.toString(target.getLocation().y);

        try {
            source.click();
            js.executeScript(jsStr, source, xto, yto);
            return true;
        } catch (NullPointerException e) {
            UtilFunctions.log("Drag and drop failed due to: " + e.getMessage());
            e.printStackTrace();
        }

        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + ": Complete");
        return false;
    }


    //Overloaded and Overridden dragAndDrop 3
    public static void dragAndDrop(WebDriver driver, String componentName, WebElement target, String tabName)
            throws InterruptedException {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);
        componentName = componentName.replace(" ", "");
        UtilFunctions.log("Component to be dragged and dropped: " + componentName);

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        String[] elementType = UtilFunctions.getElementStringAndType(fileObj, "MISC_ELEMENTS." + componentName);
        String componentPath = elementType[0];
        String componentMethod = elementType[1];
        WebElement source = SeleniumFunctions.findElement(driver,
                SeleniumFunctions.setByValues(componentPath + ";" + componentMethod));

        try {
            Actions actions = new Actions(driver);
            actions.clickAndHold(source).perform();
            Thread.sleep(250);
            actions.moveToElement(target).release(target).perform();
        } catch (StaleElementReferenceException se) {
            se.printStackTrace();
            UtilFunctions.log("Stale Element exception. Drag and Drop may already be performed by moveToElement()."
                    + " Exception: " + se.getMessage());
        }
    }


    /**************************************************************************
     * name: findDropDown(String searchString, String searchMethod)
     * functionality: Function to find the drop down element
     * param: WebDriver driver - WebDriver object
     * param: String searchString - xpath of the element
     * param: String searchMethod - search method for the element
     * return: String
     *************************************************************************/
    private static String findDropDown(String searchString, String searchMethod) {
        switch (searchMethod) {
            case "xpath":
                searchString = searchString;
                break;
            case "id":
                searchString = "//select[@name='" + searchString + "'or @id='" + searchString + "']";
                break;
            case "name":
                searchString = "//select[@name='" + searchString + "'or @id='" + searchString + "']";
                break;
        }
        return searchString;
    }

    /**************************************************************************
     * name: getDropDown(String searchString, String method)
     * functionality: Function to get the drop down element
     * param: WebDriver driver - WebDriver object
     * param: String searchString - xpath of the element
     * param: String method - search method for the element
     * return: Web Element
     *************************************************************************/

    public static WebElement getDropDown(String searchString, String method) {
        String dropDown = findDropDown(searchString, method);
        return SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues(dropDown + method));

    }

    /**************************************************************************
     * Validate checkBox status in table with cellText in row
     *
     * @param driver WebDriver object
     * @param checkType unchecked or checked
     * @param cellText with cellText
     * @param tableName  tableName
     * @return boolean
     *
     *************************************************************************/
    public static boolean validateCheckBoxInTableWithRow(WebDriver driver, String checkType, String cellText,
                                                         String tableName) throws Throwable {

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
        List<WebElement> tableRowObj = SeleniumFunctions.findElementsByWebElement(tableBodyObj,
                SeleniumFunctions.setByValues("tr;tagName"));

        for (WebElement rowObj : tableRowObj) {
            List<WebElement> rowCellObj = SeleniumFunctions.findElementsByWebElement(rowObj,
                    SeleniumFunctions.setByValues("td;tagName"));
            for (WebElement cellObj : rowCellObj) {
                String actualText = cellObj.getText().trim();
                if (actualText.equals(cellText)) {
                    WebElement checkBox = SeleniumFunctions.findElementByWebElement(rowObj,
                            SeleniumFunctions.setByValues(".//input[(@type='checkbox' or @type='Checkbox')];xpath"));
                    if (checkBox != null) {
                        if (checkType.equals("checked") && checkBox.isSelected()) {
                            UtilFunctions.log("Checkbox is checked as expected");
                            return true;
                        } else if (checkType.equals("checked") && !checkBox.isSelected()) {
                            UtilFunctions.log("Checkbox is unchecked when it should be checked.");
                            return false;
                        } else if (checkType.equals("unchecked") && !checkBox.isSelected()) {
                            UtilFunctions.log("Checkbox is unchecked as expected");
                            return true;
                        } else if (checkType.equals("unchecked") && checkBox.isSelected()) {
                            UtilFunctions.log("Checkbox is checked when it should be unchecked.");
                            return false;
                        } else {
                            UtilFunctions.log("Unexpectedly checkbox is " + checkType);
                            return false;
                        }
                    } else {
                        UtilFunctions.log("Checkbox element is not found for the row with text " + cellText);
                        return false;
                    }
                }
            }
        }
        UtilFunctions.log(cellText + "is not present in" + tableName);
        return false;
    }

    /**************************************************************************
     * name: findPatientRowByIndex(int rowNum, String tableType)
     * functionality: Function to find tablr row by index
     * param: int rowNum - row number
     * param: String tableType - table type
     * return: rows
     *************************************************************************/

    public static List<WebElement> findPatientRowByIndex(int rowNum, String tableType, int multiplier) throws InterruptedException {

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);

        //SeleniumFunctions.selectFrame(Hooks.getDriver(), UtilFunctions.getElementFromJSONFile(fileObj, "TABLES." + tableType, "frame"), "id");
        //int multiplier = countTableRows(Hooks.getDriver(), GlobalStepdefs.curTabName, tableType,null,null) / PatientListPage.getNumPatients(tableType);

        SeleniumFunctions.selectFrame(Hooks.getDriver(),
                UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "TABLES." + tableType, "frame")),
                "id");

        int target = 1 + rowNum * multiplier;
        int second = target + multiplier;
        String tablePath = UtilFunctions.getElementFromJSONFile(fileObj, "TABLES." + tableType, "path");
        WebElement table = findTable(Hooks.getDriver(), tablePath);
        Thread.sleep(2);
        WebElement tbody = Page.findTableBody(table, "tbody");

        List<WebElement> rows = SeleniumFunctions.findElementsByWebElement(tbody, By.xpath("tr[position()>=" + target + " and position()<" + second + "]"));
        return rows;
    }

    /**************************************************************************
     * name: setDynatreeCheckbox(String searchString, String method)
     * functionality: Function to check Location check box
     * param: WebDriver driver - WebDriver object
     * param: String checkBoxObj - xpath of the element
     * param: String checkBoxText - search method for the element
     * return: void
     *************************************************************************/

    public static void setDynatreeCheckbox(WebDriver driver, String checkBoxObj, String value, String checkBoxText) {
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
        String checkBoxVal = UtilFunctions.getElementFromJSONFile(fileObj, "CHECKBOXES." + checkBoxObj, "path");
        String checkBoxValue = checkBoxVal.replace("textVal", checkBoxText);
        WebElement elt = SeleniumFunctions.findElement(Hooks.getDriver(), By.xpath(checkBoxValue));
        if (value.equals("check")) {
            if (elt != null && !elt.isSelected()) {
                elt.click();
            } else {
                //Do nothing
            }
        }
        if (value.equals("uncheck")) {
            if (elt != null && !elt.isSelected()) {
                //Do nothing
            } else {
                elt.click();
            }
        }
    }

    /**************************************************************************
     * name: compareTableBodies(String tableName,
     * List<List<String>> expectedTable, String visitId)
     * functionality: Function to compare two table bodies
     * param: String tableName - actual table to be compared
     * param: List<List<String>> expectedTable - expected table for comparision
     * param: String visitId - visit ID of the patient
     * return: boolean
     *************************************************************************/
    public static boolean compareTableBodies(String tableName, List<List<String>> expectedTable, String visitId)
            throws InterruptedException {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        String tablePath = UtilFunctions.getElementFromJSONFile(fileObj, "TABLES." + tableName, "path");
        String paneFrames = (String) frameMap.get(UtilFunctions.getElementFromJSONFile(fileObj,
                "TABLES." + tableName, "frame"));
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");
        String miscEltPath = UtilFunctions.getElementFromJSONFile(fileObj,
                "MISC_ELEMENTS." + "VisitForAPatient", "path");
        List<WebElement> rows = null;

        if (visitId == null) {
            WebElement table = findTable(Hooks.getDriver(), tablePath);
            WebElement tbody = Page.findTableBody(table, "tbody");
            rows = SeleniumFunctions.findElementsByWebElement(tbody, By.tagName("tr"));
        } else {
            rows = SeleniumFunctions.findElements(Hooks.getDriver(), By.xpath(miscEltPath.replace("visitId", visitId)));
        }
        int rowCount = rows.size();
        if (rowCount == 0) {
            WebElement table = findTable(Hooks.getDriver(), tablePath);
            WebElement tbody = Page.findTableBody(table, "tbody");
            rows = SeleniumFunctions.findElementsByWebElement(tbody, By.tagName("tr"));
        }
        int expectedTableCount = expectedTable.size();

        if (visitId != null && rowCount != expectedTableCount) {
            return false;
        }
        int rowIndex = 0;
        for (WebElement row : rows) {
            int colIndex = 0;
            if (row.getAttribute("id").equals("VisitOnlyRow")) {
                colIndex = 4;
            }
            List<WebElement> cells = SeleniumFunctions.findElementsByWebElement(row, By.tagName("td"));
            int expectedCellCount = expectedTable.get(rowIndex).size();
            for (WebElement cell : cells) {
                String cellValue = "";
                WebElement cellImage = SeleniumFunctions.findElementByWebElement(cell, By.tagName("img"));
                List<WebElement> spans = SeleniumFunctions.findElementsByWebElement(cell, By.tagName("span"));
                if (cellImage != null) {
                    cellValue = cellImage.getAttribute("id");
                } else if (spans.size() != 0) {
                    cellValue = "";
                    for (WebElement spanElement : spans) {
                        cellValue = cellValue + " " + spanElement.getText();
                    }
                    cellValue = cellValue.trim();
                } else if (spans.size() == 0) {
                    cellValue = cell.getText().trim();
                }

                String colSpan = cell.getAttribute("colspan");
                if (cellValue.isEmpty() && colSpan != null) {
                    colIndex = colIndex + Integer.valueOf(colSpan);
                } else {
                    colIndex = colIndex + 1;
                }
                String compareTo = expectedTable.get(rowIndex).get(colIndex - 1);
                if (compareTo.contains("%")) {
                    compareTo = UtilFunctions.getCompareToValuesFromRegExConvertor(compareTo);
                }
                cellValue = cellValue.replace(" ", "");
                compareTo = compareTo.replace(" ", "");
                UtilFunctions.log("Row Index: " + rowIndex);
                UtilFunctions.log("Col Index: " + colIndex);
                UtilFunctions.log("Displayed Value: " + cellValue);
                UtilFunctions.log("Expected Value: " + compareTo);
                if (!cellValue.equals(compareTo)) {
                    return false;
                }
                if (!cellValue.isEmpty() && colSpan != null) {
                    colIndex = colIndex + Integer.valueOf(colSpan) - 1;
                }
            }
            if (colIndex != expectedCellCount) {
                return false;
            }
            rowIndex += 1;
        }
        return true;
    }

    /**************************************************************************
     * Verify if a cucumber DataTable of options are, or are not, in the PK menu
     *
     * @param driver WebDriver object
     * @param menu name of the menu
     * @param not validate if items are, or are not, in menu
     * @param dataTable table of options to check for in menu
     * @param curTabName name of the currently selected tab
     * @return boolean
     *************************************************************************/
    public static boolean verifyOptionsInMenu(WebDriver driver, String menu, boolean not, DataTable dataTable, String curTabName) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + curTabName);
        UtilFunctions.log("Menu: " + menu);

        menu = menu.replace(" ", "");
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        String menuFrame = (String) frameMap.get(UtilFunctions.getElementFromJSONFile(fileObj, "PKMENUS." + menu, "frame"));
        String menuPath = UtilFunctions.getElementFromJSONFile(fileObj, "PKMENUS." + menu, "path");
        String menuID = UtilFunctions.getElementFromJSONFile(fileObj, "PKMENUS." + menu, "id");

        UtilFunctions.log("MenuPath: " + menuPath);
        UtilFunctions.log("MenuID: " + menuID);

        SeleniumFunctions.selectFrame(driver, menuFrame, "id");
        SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, menuPath + ";xpath");
        WebElement menuObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(menuPath + ";xpath"));
        menuObj.click();
        boolean success = true;
        for (String value : dataTable.asList(String.class)) {
            WebElement menuItem = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//ul[@id='" + menuID + "']//li[@pkmenuitemvalue='" + value + "']"));
            if (menuItem == null) {
                if (not == false) {
                    UtilFunctions.log("Menu Item '" + value + "' not found in menu options. Fail.");
                    success = false;
                }
            } else {
                if (not == true) {
                    UtilFunctions.log("Menu Item '" + value + "' found in menu options. Fail.");
                    success = false;
                }
            }
        }
        return success;
    }

    /**************************************************************************
     * name: findTableRowByText(WebDriver driver, String tableName, String rowText)
     * functionality: Function select by row text where column header is not available
     * param: WebDriver driver - WebDriver object
     * param: String tableName - Name of the table
     * param: String rowText - Table row text
     * return: returns table row
     *************************************************************************/
    public static WebElement findTableRowByText(WebDriver driver, String tableName, String rowText) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        tableName = tableName.replace(" ", "");

//        tableName = tableName.replace(" ", "");
        String[] tableDetailArr = UtilFunctions.getTableValues(curTabName, tableName);
        String tableBody = tableDetailArr[3];

        UtilFunctions.log("tableBody: " + tableBody);

        WebElement tableObj = findTable(Hooks.getDriver(), curTabName, tableName);
        WebElement tableBodyObj, tableRow;
        //There is no tbody for the table,so identifying the row directly by tableobj.
        if (tableBody.equals("")) {
            tableRow = SeleniumFunctions.findElementByWebElement(tableObj, SeleniumFunctions.setByValues("//tr[descendant-or-self::td[.//*[normalize-space(./text()) = '" + rowText + "']]]" + ";xpath"));

        } else {
            if (tableBody.startsWith("//")) {
                tableBodyObj = SeleniumFunctions.findElementByWebElement(tableObj,
                        SeleniumFunctions.setByValues("." + tableBody + ";xpath"));
            } else {
                tableBodyObj = SeleniumFunctions.findElementByWebElement(tableObj,
                        SeleniumFunctions.setByValues(".//" + tableBody + ";xpath"));
            }

            tableRow = SeleniumFunctions.findElementByWebElement(tableBodyObj, SeleniumFunctions.setByValues("//tr[descendant-or-self::td[.//*[normalize-space(./text()) = '" + rowText + "']]]" + ";xpath"));
        }
        return tableRow;
    }

    /**************************************************************************
     * name: checkIfElementExists(WebDriver driver, String selector, String method)
     * functionality: Function check if an element exists
     * param: WebDriver driver - WebDriver object
     * param: String selector - element selector
     * param: String method - method type
     * return: returns boolean value
     *************************************************************************/
    public static boolean checkIfElementExists(WebDriver driver, String selector, String method) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        return SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues(selector + method)) != null;
    }

    /**************************************************************************
     * name: selectFromTableByRowAndColumnIndex(WebDriver driver, String tabName,
     * String tableName, int rowIndex, int colIndex)
     * functionality: Function to select table value based on row and column index
     * param: WebDriver driver - WebDriver object
     * param: String tabName - Name of current tab
     * param: String tableName - Name of table in json file
     * param: int rowIndex - Location/Index of the row item to be selected
     * param: int colIndex - Location/Index of the column item to be selected
     * return: boolean
     *************************************************************************/
    public static boolean selectFromTableByRowAndColumnIndex(WebDriver driver, String tabName, String tableName, int rowIndex, int colIndex) throws InterruptedException {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);

        String[] tableDetailArr = UtilFunctions.getTableValues(tabName, tableName);
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

        SeleniumFunctions.selectFrame(driver, paneFrames, "id");
        WebElement tableObj = findTable(driver, tablePath);
        if (tableObj == null) {
            UtilFunctions.log("Table not present. Returning false.");
            return false;
        } else {
            UtilFunctions.log("Table present");
            WebElement tableElement = findTableElementByRowAndColumnIndex(Hooks.getDriver(), GlobalStepdefs.curTabName, tableName, colIndex, rowIndex);
            if (tableElement == null) {
                UtilFunctions.log("Table Element is not present. Returning false.");
                return false;
            } else {
                tableElement.click();
                Thread.sleep(2000);
                UtilFunctions.log("Table Element is present and is clicked. Returning true.");
                return true;
            }
        }
    }

    /**************************************************************************
     * name: findTableCell(WebDriver driver,
     * String tabName, String tableName, int rowIndex, int colIndex)
     * functionality: Find cell element from table with row/column index
     * param: WebDriver driver - WebDriver object
     * param: String tabName - Name of current tab
     * param: String tableName - Name of table
     * param: int rowIndex - Row index
     * param: int colIndex - Column index
     * return: String
     *************************************************************************/
    public static WebElement findTableCell(WebDriver driver, String tabName, String tableName, int rowIndex, int colIndex) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
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

        SeleniumFunctions.selectFrame(driver, paneFrames, "id");
        SeleniumFunctions.explicitWait(driver, GlobalConstants.FIVE, tablePath + ";xpath");
        WebElement tableObj = findTable(driver, tablePath);
        if (tableObj == null) {
            UtilFunctions.log("Table name: " + tableName + " does not exist. Returning false.");
            return null;
        } else {
            WebElement tableBodyObj = SeleniumFunctions.findElementByWebElement(tableObj, SeleniumFunctions.setByValues(tableBody + ";xpath"));
            if (tableBodyObj == null) {
                UtilFunctions.log("TableBody object for table: " + tableName + " is not present. Returning null.");
                return null;
            } else {
                List<WebElement> tableRows = SeleniumFunctions.findElementsByWebElement(tableBodyObj, SeleniumFunctions.setByValues("tr" + ";tagName"));
                if (tableRows == null) {
                    UtilFunctions.log("Table rows from table: " + tableName + " is not retrieved. Returning null.");
                    return null;
                } else {
                    List<WebElement> tableCells = SeleniumFunctions.findElementsByWebElement(tableRows.get(rowIndex), SeleniumFunctions.setByValues("td" + ";xpath"));
                    if (tableCells == null) {
                        UtilFunctions.log("Table cells from table: " + tableName + " is not retrieved. Returning null.");
                        return null;
                    } else {
                        UtilFunctions.log("Table cell from table: " + tableName + " is retrieved. Returning cell element.");
                        return tableCells.get(colIndex);
                    }
                }
            }
        }
    }

    /**************************************************************************
     * name: getTableCellValue(WebDriver driver,
     * String tabName, String tableName, int rowIndex, int colIndex)
     * functionality: Get cell value from table with row/column index
     * param: WebDriver driver - WebDriver object
     * param: String tabName - Name of current tab
     * param: String tableName - Name of table
     * param: int rowIndex - Row index
     * param: int colIndex - Column index
     * return: String
     *************************************************************************/
    public static String getTableCellValue(WebDriver driver, String tabName, String tableName, int rowIndex, int colIndex) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        WebElement tableCell = findTableCell(driver, tabName, tableName, rowIndex, colIndex);
        String tableCellValue = tableCell.getText().trim();
        if (tableCellValue == "")
            tableCellValue = SeleniumFunctions.findElementByWebElement(tableCell, SeleniumFunctions.setByValues("descendant-or-self::*[boolean(text())]" + ";xpath")).getAttribute("innerHTML").trim();
        return tableCellValue;
    }

    /**************************************************************************
     * name: checkScrollExists(WebDriver driver, String curTabName, String elementName, String elementType, String scrollType)
     * functionality: Function to check whether scroll bar is exists or not
     * param: WebDriver driver - WebDriver object
     * param: String tabName - Name of current tab
     * param: String elementName - Name of element in json file
     * param: String elementType - Type of element in json file
     * param: String scrollType - Type of scroll bar like vertical or horizontal
     * param: String paneName - Optional parameter for pane name
     * return: boolean
     *************************************************************************/
    public static boolean checkScrollExists(WebDriver driver, String tabName, String elementName, String elementType,
                                            String scrollType, String... paneName) {
        UtilFunctions.log("Class: " + page.className + "; Method: " +
                new Object() {
                }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + curTabName);
        elementName = elementName.replace(" ", "");
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        String paneFrames;
        if (paneName.length > 0 && paneName[0] != null) {
            paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj,
                    "PANES." + paneName[0].replace(" ", ""), "frame"));
        } else {
            paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj,
                    elementType.toUpperCase() + "S." + elementName, "frame"));
        }
        UtilFunctions.log("PaneFrames: " + paneFrames);
        SeleniumFunctions.selectFrame(driver, paneFrames, "id");

        String[] elementAttributes = UtilFunctions.getElementStringAndType(fileObj,
                elementType.toUpperCase() + "S." + elementName);
        String searchString = elementAttributes[0];
        String searchCriteria = elementAttributes[1];
        SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, searchString + ";" + searchCriteria);
        WebElement elementObj = SeleniumFunctions.findElement(driver,
                SeleniumFunctions.setByValues(searchString + ";" + searchCriteria));
        boolean scrollExists = false;
        if (elementObj == null) {
            UtilFunctions.log("Element '" + elementName + "' object is null. Returning false");
        } else {
            UtilFunctions.log("Element '" + elementName + "' object is found. Checking for scroll bar");
            try {
                switch (scrollType) {
                    case "vertical":
                        scrollExists = (boolean) ((JavascriptExecutor) driver).executeScript(
                                "return arguments[0].scrollHeight>arguments[0].clientHeight;", elementObj);
                        UtilFunctions.log("Checked for vertical scrollbar, Returning " + scrollExists);
                        break;
                    case "horizontal":
                        scrollExists = (boolean) ((JavascriptExecutor) driver).executeScript(
                                "return arguments[0].scrollWidth>arguments[0].clientWidth;", elementObj);
                        UtilFunctions.log("Checked for horizontal scrollbar, Returning " + scrollExists);
                        break;
                    default:
                        UtilFunctions.log("Type of scrollbar to be checked is not provided, Returning false");
                        break;
                }
            } catch (Exception e) {
                UtilFunctions.log("Unable check scrollbar exists due to exception: " + e.getMessage() +
                        ", Returning false");
            }
        }
        return scrollExists;
    }

    /**************************************************************************
     * Check for these Note Templates Only
     *
     * @param driver WebDriver object
     * @param dataTable data table of note pickers you're looking for
     * @return boolean
     *************************************************************************/
    public static boolean checkForTheseNoteTemplatesOnly(WebDriver driver, DataTable dataTable) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        String paneFrameName = "FRAME_NOTEWRITER_MAIN";
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        paneFrameName = UtilFunctions.getFrameValue(frameMap, paneFrameName);
        UtilFunctions.log("PaneFrames: " + paneFrameName);
        SeleniumFunctions.selectFrame(driver, paneFrameName, "id");
        String templateName = "", notePickername = "";
        boolean listsMatch = true;

        List<String> dataList = dataTable.asList(String.class);

        SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.TEN,
                "//table[@id='hPickerTable']" + /*/div[@id='hPickerTreeCell']*/
                        "//div[@pkentity='HpickerNoteTemplate']" +
                        "/span[contains(@id, 'label')]");
        List<WebElement> noteTemplatesList = SeleniumFunctions.findElements(Hooks.getDriver(),
                SeleniumFunctions.setByValues("//table[@id='hPickerTable']" + /*/div[@id='hPickerTreeCell']*/
                        "//div[@pkentity='HpickerNoteTemplate']" +
                        "/span[contains(@id, 'label')]"));

        if (noteTemplatesList != null) {
            if (noteTemplatesList.size() != dataList.size()) {
                System.out.println("The onscreen template list and the given list are not the same length. Returning false.");
                UtilFunctions.log("The onscreen template list and the given list are not the same length. Returning false.");
                return false;
            } else {
                for (int i = 0; i < noteTemplatesList.size(); ++i) {
                    templateName = noteTemplatesList.get(i).getText();
                    System.out.println(templateName);
                    notePickername = dataList.get(i);
                    System.out.println(notePickername);
                    //for(String notePickername : dataList){
                    if (!notePickername.equalsIgnoreCase(templateName)) {
                        listsMatch = false;
                        System.out.println("The onscreen template list and the given list are not the same. " +
                                "Found: " + templateName + "   Expected: " + notePickername);
                        UtilFunctions.log("The onscreen template list and the given list are not the same. " +
                                "Found: " + templateName + "   Expected: " + notePickername);
                    }
                    if (!listsMatch)
                        break;

                }//end For
            }//end inner if-else
        } else {
            System.out.println("The onscreen template list is Nulll. Returning false.");
            UtilFunctions.log("The onscreen template list is Nulll. Returning false.");
            return false;
        }
        return listsMatch;
    }

    public static boolean getCheckBoxStatusDashboardMode(WebDriver driver, String curTabName, String checkBoxName, String checkType,
                                                         String paneName) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + curTabName);
        UtilFunctions.log("Checkbox name: " + checkBoxName);
        UtilFunctions.log("CheckType: " + checkType);

        checkBoxName = checkBoxName.replace(" ", "");
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        String paneFrames;

        if (!curTabName.equals("")) {
            String[] elementType = UtilFunctions.getElementStringAndType(fileObj,
                    "CHECKBOXES." + checkBoxName);
            String chBoxValue = elementType[0];
            String chBoxMethod = elementType[1];
            UtilFunctions.log("CheckBox value: " + chBoxValue);
            UtilFunctions.log("CheckBox method: " + chBoxMethod);

            if (paneName == null || paneName == "") {
                paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj,
                        "CHECKBOXES." + checkBoxName, "frame"));
            } else {
                paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj,
                        "PANES." + paneName.replace(" ", ""), "frame"));
            }

            UtilFunctions.log("PaneFrames: " + paneFrames);
            SeleniumFunctions.selectFrame(driver, paneFrames, "id");

            WebElement checkBoxObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(chBoxValue + ";" + chBoxMethod));
            if (checkBoxObj != null) {
                switch (checkType) {
                    case "unchecked":
                        if (checkBoxObj.getAttribute("class").contains("is-checked")) {
                            UtilFunctions.log("Checkbox: '" + checkBoxName +
                                    "' is selected when it should be UNchecked. Returning false.");
                            System.out.println("Checkbox: '" + checkBoxName +
                                    "' is selected when it should be UNchecked. Returning false.");
                            return false;
                        } else {
                            UtilFunctions.log("Checkbox: '" + checkBoxName +
                                    "' is NOT selected. Returning true.");
                            System.out.println("Checkbox: '" + checkBoxName +
                                    "' is NOT selected. Returning true.");
                            return true;
                        }
                    case "checked":
                        if (!checkBoxObj.getAttribute("class").contains("is-checked")) {
                            UtilFunctions.log("Checkbox: '" + checkBoxName +
                                    "' is NOT selected when it should be checked. Returning false.");
                            System.out.println("Checkbox: '" + checkBoxName +
                                    "' is NOT selected when it should be checked. Returning false.");
                            return false;
                        } else {
                            UtilFunctions.log("Checkbox: '" + checkBoxName +
                                    "' is selected. Returning true.");
                            System.out.println("Checkbox: '" + checkBoxName +
                                    "' is selected. Returning true.");
                            return true;
                        }
                    default: //checkType == null (which means checkType should be checked?)
                        if (!checkBoxObj.getAttribute("class").contains("is-checked")) {
                            UtilFunctions.log("Checkbox: '" + checkBoxName +
                                    "' is NOT selected when it should be checked. Returning false.");
                            System.out.println("Checkbox: '" + checkBoxName +
                                    "' is NOT selected when it should be checked. Returning false.");
                            return false;
                        } else {
                            UtilFunctions.log("Checkbox: '" + checkBoxName +
                                    "' is selected. Returning true.");
                            System.out.println("Checkbox: '" + checkBoxName +
                                    "' is selected. Returning true.");
                            return true;
                        }
                }
            } else {
                UtilFunctions.log("Checkbox: '" + checkBoxName + "' object is null. Returning false.");
                return false;
            }
        } else {
            UtilFunctions.log("Current tab : '" + curTabName + "' name is null. Returning false.");
            return false;
        }
    }

    //Clearing text field by calling Selenium Function "clear"
    //TODO: Refactor to remove method and use Page.setTextBox instead which already clears and enters txt in txtbox and uses Selenium Function "clear"
    public static boolean clearAndSetTextBox(WebDriver driver, String tabName, String value, String fieldName,
                                             String paneName) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);
        fieldName = fieldName.replace(" ", "");
        UtilFunctions.log("Text box field name: " + fieldName);

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        String paneFrames = "";
        String[] elementType = UtilFunctions.getElementStringAndType(fileObj, "TEXT_FIELDS." + fieldName);
        String textPath = elementType[0];
        String textMethod = elementType[1];

        UtilFunctions.log("Text box textPath: " + textPath);
        UtilFunctions.log("Text box textMethod: " + textMethod);

        if (paneName != null)
            paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj,
                    "PANES." + paneName.replace(" ", ""), "frame"));
        else {
            paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj,
                    "TEXT_FIELDS." + fieldName, "frame"));
        }
        UtilFunctions.log("PaneFrames: " + paneFrames);

        SeleniumFunctions.selectFrame(driver, paneFrames, "id");
        WebElement txtObj = findTextBox(driver, textPath, textMethod);
        if (txtObj == null) {
            UtilFunctions.log("Text box '" + fieldName + "' object is null. Returning false.");
            return false;
        } else {
            value = UtilFunctions.convertThruRegEx(value);
            try {
                txtObj.click();
                SeleniumFunctions.clear(driver, txtObj);

                txtObj.sendKeys(value);
                UtilFunctions.sleep(1000);
                UtilFunctions.log("Text box '" + fieldName + "' object not null. Entered Value: '" + value +
                        "'. Returning true.");
                return true;
            } catch (ElementNotInteractableException e) {
                UtilFunctions.log("Trying again. Exception: " + e.getMessage());
                e.printStackTrace();
                return false;

            }
        }
    }


    /**
     * @param toggleName - String name of element that should be opened or closed
     * @param tabName    - name of current tab
     * @param isOrIsNot  - String, whether the toggle's state should be open or not open (closed)
     * @param paneName   - String optional
     * @return true if the toggle is open/toggled On, false if it is closed/toggled Off
     */
    public static boolean toggleIsOpen(String toggleName, String tabName, String isOrIsNot, String paneName) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        WebDriver driver = Hooks.getDriver();
        UtilFunctions.log("Current tab name: " + tabName);
        toggleName = toggleName.replace(" ", "");

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        String paneFrames;

        String[] elementType = UtilFunctions.getElementStringAndType(fileObj, "TOGGLES." + toggleName);
        String toggleXpath = elementType[0];

        if (paneName != null) {
            paneFrames = UtilFunctions.getFrameValue(frameMap,
                    UtilFunctions.getElementFromJSONFile(fileObj, "PANES." +
                            paneName.replace(" ", ""), "frame"));
        } else {
            paneFrames = UtilFunctions.getFrameValue(frameMap,
                    UtilFunctions.getElementFromJSONFile(fileObj, "TOGGLES." +
                            toggleName, "frame"));
        }
        SeleniumFunctions.selectFrame(driver, paneFrames, "id");

        WebElement toggleEl = SeleniumFunctions.findElement(driver, By.xpath(toggleXpath));

        if (toggleEl == null) {
            UtilFunctions.log(toggleName + " toggle is NULL and not found.  Returning false.");
            return false;
        } else {
            if (isOrIsNot.equalsIgnoreCase("is")) {
                //If the toggle should be open
                if (SeleniumFunctions.isSelected(toggleEl)) {//And it is open
                    UtilFunctions.log(toggleName + " toggle is already open/toggled on.  Returning true.");
                    return true;
                } else {//Should be open and it's not
                    toggleEl.click();
                    if (SeleniumFunctions.isSelected(toggleEl)) {
                        UtilFunctions.log(toggleName + " toggle is now open/toggled on.  Returning true.");
                        return true;
                    } else {
                        SeleniumFunctions.click(toggleEl);
                        if (SeleniumFunctions.isSelected(toggleEl)) {
                            UtilFunctions.log(toggleName + " toggle is now open/toggled on.  Returning true.");
                            return true;
                        } else {
                            Actions actions = new Actions(driver);
                            actions.moveToElement(toggleEl).click().build().perform();
                            if (SeleniumFunctions.isSelected(toggleEl)) {
                                UtilFunctions.log(toggleName + " toggle is now open/toggled on.  Returning true.");
                                return true;
                            } else {
                                UtilFunctions.log(toggleName + " toggle did NOT open/turn on with .click(), " +
                                        "SeleniumFunctions.click(), or Actions Builder.  Returning false.");
                                return false;
                            }
                        }
                    }
                }
            } else {
                //If the toggle should be closed
                if (!SeleniumFunctions.isSelected(toggleEl)) {//And it is closed
                    UtilFunctions.log(toggleName + " toggle is already closed/toggled off.  Returning false.");
                    return false;
                } else {//Should be closed and it is not
                    toggleEl.click();
                    if (!SeleniumFunctions.isSelected(toggleEl)) {
                        UtilFunctions.log(toggleName + " toggle is now closed/toggled off.  Returning false.");
                        return false;
                    } else {
                        SeleniumFunctions.click(toggleEl);
                        if (!SeleniumFunctions.isSelected(toggleEl)) {
                            UtilFunctions.log(toggleName + " toggle is now closed/toggled off.  Returning false.");
                            return false;
                        } else {
                            Actions actions = new Actions(driver);
                            actions.moveToElement(toggleEl).click().build().perform();
                            if (!SeleniumFunctions.isSelected(toggleEl)) {
                                UtilFunctions.log(toggleName + " toggle is now closed/toggled off.  Returning false.");
                                return false;
                            } else {
                                UtilFunctions.log(toggleName + " toggle did NOT close/turn off with .click(), " +
                                        "SeleniumFunctions.click(), or Actions Builder.  Returning true.");
                                return true;
                            }
                        }
                    }
                }
            }//end if isOrIsNot
        }//end if toggleEl == null
    }


    /**
     * Click "add to note" checkboxes for the the first "numberOfRowsToCheck" table rows in a table,
     * where "numberOfRowsToCheck"" is a number or "All"
     *
     * @param driver              WebDriver object
     * @param numberOfRowsToCheck The number of rows to check (integer or "All")
     * @param tableName           Name of the table in which to check checkboxes
     * @param pane                The pane in which the table exists
     * @return
     */
    public static boolean clickNoteCheckboxesInTable(WebDriver driver, String numberOfRowsToCheck, String tableName, String pane) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

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

        if (pane != null) {
            JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
            HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
            paneFrames = (String) frameMap.get(UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + pane.replace(" ", ""), "frame"));
        }

        SeleniumFunctions.selectFrame(driver, paneFrames, "id");
        WebElement tableObj = findTable(driver, tablePath);
        if (tableObj == null) {
            UtilFunctions.log("Table not present. Returning false.");
            return false;
        }
        UtilFunctions.log("Table present");

        WebElement tableBodyObj = SeleniumFunctions.findElementByWebElement(tableObj, SeleniumFunctions.setByValues(tableBody + ";xpath"));
        if (tableBodyObj == null) {
            UtilFunctions.log("Table body object not present. Returning false.");
            return false;
        }
        UtilFunctions.log("Table body present");

        List<WebElement> tableRowObjects = SeleniumFunctions.findElementsByWebElement(tableBodyObj, SeleniumFunctions.setByValues("tr;tagName"));
        if (tableRowObjects == null || tableRowObjects.size() == 0) {
            UtilFunctions.log("Table body object not present. Returning false.");
            return false;
        }
        UtilFunctions.log("Table rows present");

        int loadMoreCount = 0;
        WebElement loadMore = null;

        int numRowsToCheck = 0;
        if (numberOfRowsToCheck.equalsIgnoreCase("All")) {
            System.out.println("*** loadMoreCount: " + loadMoreCount);
            System.out.println("*** tableRowObjects.size(): " + tableRowObjects.size());
            loadMore = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//button[contains(@class,'get-more')];xpath"));
            while (loadMore != null) {
                //Limit may need to be increased.  This will allow for loading up to 500 total rows via Load More.
                if (loadMoreCount > 4) {
                    break;
                }
                loadMore.click();
                UtilFunctions.sleep(500);
                loadMoreCount = loadMoreCount + 1;
                loadMore = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//button[contains(@class,'get-more')];xpath"));
            }
            tableObj = findTable(driver, tablePath);
            WebElement selectAll = SeleniumFunctions.findElementByWebElement(tableObj, SeleniumFunctions.setByValues(".//img[starts-with(@buttonid,'selectall')];xpath"));
            selectAll.click();
        } else {
            numRowsToCheck = Integer.parseInt(numberOfRowsToCheck);

            //Click Load More button until table has enough rows
            while (tableRowObjects.size() < numRowsToCheck) {
                System.out.println("Table has '" + tableRowObjects.size() + "' rows.  Need to check '" + numRowsToCheck + "' rows.  Attempting to click 'Load More' button.");
                //Limit may need to be increased.  This will allow for loading up to 500 total rows via Load More.
                if (loadMoreCount > 4) {
                    break;
                }
                System.out.println("*** loadMoreCount: " + loadMoreCount);
                System.out.println("*** tableRowObjects.size(): " + tableRowObjects.size());
                loadMore = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//button[contains(@class,'get-more')];xpath"));
                if (loadMore != null) {
                    loadMore.click();
                } else {
                    UtilFunctions.log("Load More button unavailable.  Patient does not have '" + numberOfRowsToCheck + "' clinical rows to check.");
                    return false;
                }
                //Wait for table to update
                UtilFunctions.sleep(500);
                tableBodyObj = SeleniumFunctions.findElementByWebElement(tableObj, SeleniumFunctions.setByValues(tableBody + ";xpath"));
                tableRowObjects = SeleniumFunctions.findElementsByWebElement(tableBodyObj, SeleniumFunctions.setByValues("tr;tagName"));
                loadMoreCount = loadMoreCount + 1;
            }
            //Scroll back up to first row to avoid scroll/click issues in tableRowObjects for loop
            ((JavascriptExecutor) driver).executeScript("arguments[0].scrollIntoView(true);", tableRowObjects.get(0));

            int checkedCount = 0;
            for (WebElement row : tableRowObjects) {
                if (checkedCount >= numRowsToCheck) {
                    break;
                }
                row.click();
                WebElement checkBox = SeleniumFunctions.findElementByWebElement(row, SeleniumFunctions.setByValues(".//input[@type='checkbox'];xpath"));
                checkBox.click();
                checkedCount = checkedCount + 1;
            }
        }

        return true;
    }


    public static boolean clickNoteCheckboxesInTableByTextInColumn(WebDriver driver, String rowText, String columnName, String tableName, String pane) {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

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

        if (pane != null) {
            JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
            HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
            paneFrames = (String) frameMap.get(UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + pane.replace(" ", ""), "frame"));
        }

        SeleniumFunctions.selectFrame(driver, paneFrames, "id");
        WebElement tableObj = findTable(driver, tablePath);
        if (tableObj == null) {
            UtilFunctions.log("Table not present. Returning false.");
            return false;
        }
        UtilFunctions.log("Table present");

        //Get index of header column via text
        WebElement tableHeaderObj = SeleniumFunctions.findElementByWebElement(tableObj, SeleniumFunctions.setByValues(tableHead + ";xpath"));
        if (tableHeaderObj == null) {
            UtilFunctions.log("Table header object not found. Returning false.");
            return false;
        }
        UtilFunctions.log("Table header present");

        List<WebElement> tableHeaderObjects = SeleniumFunctions.findElementsByWebElement(tableHeaderObj, SeleniumFunctions.setByValues("th;tagName"));
        if (tableHeaderObjects == null || tableHeaderObjects.size() == 0) {
            UtilFunctions.log("Table header objects not found. Returning false.");
            return false;
        }

        int columnIndex = 1;
        for (WebElement headerObj : tableHeaderObjects) {
            if (headerObj.getText().startsWith(columnName) ||
                    SeleniumFunctions.findElementByWebElement(headerObj,
                            SeleniumFunctions.setByValues(".//*[starts-with(text(), '" + columnName + "')];xpath")) != null) {
                break;
            }
            columnIndex = columnIndex + 1;
        }
        if (columnIndex > tableHeaderObjects.size()) {
            UtilFunctions.log("Table header object not found. Returning false.");
            return false;
        }

        WebElement tableBodyObj = SeleniumFunctions.findElementByWebElement(tableObj, SeleniumFunctions.setByValues(tableBody + ";xpath"));
        if (tableBodyObj == null) {
            UtilFunctions.log("Table body object not present. Returning false.");
            return false;
        }
        UtilFunctions.log("Table body present");

        WebElement targetRow = SeleniumFunctions.findElementByWebElement(tableBodyObj, SeleniumFunctions.setByValues(
                ".//tr[descendant::td[" + columnIndex + "][contains(text(), '" + rowText + "') or " +
                        "descendant::*[contains(text(), '" + rowText + "')]]];xpath"));
        if (targetRow == null) {
            UtilFunctions.log("Unable to find target row containing text '" + rowText + "' in column '"
                    + columnName + "'. Returning false.");
            return false;
        }

        targetRow.click();
        WebElement checkBox = SeleniumFunctions.findElementByWebElement(targetRow, SeleniumFunctions.setByValues(".//input[@type='checkbox'];xpath"));
        if (checkBox == null) {
            UtilFunctions.log("Unable to find checkbox within row WebELement. Returning false.");
            return false;
        }

        checkBox.click();
        UtilFunctions.sleep(250);
        //Retry click if isSelected is false after first click attempt
        if (checkBox.isSelected() == false) {
            checkBox.click();
        }

        return true;
    }

}//end class Page