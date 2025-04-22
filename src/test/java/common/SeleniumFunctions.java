package common;

import constants.GlobalConstants;
import features.Hooks;
import features.step_definitions.GlobalStepdefs;
import org.junit.Assert;
import org.openqa.selenium.*;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.remote.UnreachableBrowserException;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import utils.UtilFunctions;

import java.time.Duration;
import java.util.*;

/*
 * Created by PatientKeeper on 6/21/2016.
 */

/******************************************************************************
 Class Name: SeleniumFunctions
 Contains functions related to Selenium APIs
 ******************************************************************************/

public class SeleniumFunctions {

    public String className = getClass().getSimpleName();
    private static SeleniumFunctions seleniumFunctions = new SeleniumFunctions();

    public static String parentWindow;
    public static String portalWindow;
    public static String popoutWindow;

    public static HashMap<String, Set<String>> driverWindowsHandleMap = new HashMap<String, Set<String>>();

    /**************************************************************************
     * Returns the first displayed element found by value, or the the first
     * element if no found elements are displayed.  null if no elements found.
     *
     * @param driver WebDriver object
     * @param value value(xpath, id, name, etc.) to search for
     * @return element object
     *************************************************************************/
    public static WebElement findElement(WebDriver driver, By value) {
        UtilFunctions.log("Class: " + seleniumFunctions.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        try {
            List<WebElement> listElement = driver.findElements(value);
            for (WebElement element : listElement) {
                if (element.isDisplayed())
                    return element;
            }
            if (listElement.size() > 0) {
                UtilFunctions.log("Elements found, but none are displayed.  Returning first element found.");
                return listElement.get(0);
            }
            UtilFunctions.log("Element not found. Returning null.");
            return null;
        } catch (Exception e) {
            UtilFunctions.log("Exception occurred when attempting to find element. Returning null. Exception: " + e.getMessage());
            return null;
        }
    }


    /**************************************************************************
     * name: findElements(WebDriver driver, By value)
     * functionality: Get list of elements obtained from driver object
     * param: WebDriver driver - WebDriver object
     * param: By value - By value of object based on xpath, id or name, etc
     * return: returns list of elements obtained from driver object
     *************************************************************************/
    public static List<WebElement> findElements(WebDriver driver, By value) {
        UtilFunctions.log("Class: " + seleniumFunctions.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        try {
            return driver.findElements(value);
        } catch (Exception e) {
            e.printStackTrace();
            UtilFunctions.log("Element not found. Returning null. Exception: " + e.getMessage());
            return null;
        }
    }


    /**************************************************************************
     * name: findElementByWebElement(WebElement element, By value)
     * functionality: Function tries twice to fetch not null element object.
     * Returns the object of element with element object
     * param: WebElement element - WebElement object
     * param: By value - By value of object based on xpath, id or name, etc
     * return: returns the element object
     *************************************************************************/
    public static WebElement findElementByWebElement(WebElement element, By value) {
        UtilFunctions.log("Class: " + seleniumFunctions.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        int findCnt = 0;
        WebElement elementObj;
        while (true) {
            findCnt++;
            try {
                elementObj = element.findElement(value);
                UtilFunctions.log("Element found. Returning element: " + elementObj.getText());
                break;
            } catch (Exception e) {
                e.printStackTrace();
                elementObj = null;
                if (findCnt > 1) {
                    UtilFunctions.log("Element not found. Returning null. Exception: " + e.getMessage());
                    break;
                }
            }
        }
        return elementObj;
    }


    /**************************************************************************
     * name: findElementsByWebElement(WebElement element, By value)
     * functionality: Returns the object of elements with element object
     * param: WebElement element - WebElement object
     * param: By value - By value of object based on xpath, id or name, etc
     * return: returns the list of element object
     *************************************************************************/
    public static List<WebElement> findElementsByWebElement(WebElement element, By value) {
        UtilFunctions.log("Class: " + seleniumFunctions.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        try {
            return element.findElements(value);
        } catch (Exception e) {
            e.printStackTrace();
            UtilFunctions.log("Element not found. Returning null. Exception: " + e.getMessage());
            return null;
        }
    }


    /**************************************************************************
     * name: explicitWait(WebDriver driver, String frame, By... frameByValue)
     * functionality: Explicit wait until object gets visible (Max timeout - 10 seconds)
     * @param: WebDriver driver - WebDriver object
     * @param: String path - Locator + Locator type (xpath, id, etc)
     * @param: By... selector - By value of object based on xpath, id or name, etc. Optional variable
     * @return: void
     *************************************************************************/
    public static void explicitWait(WebDriver driver, int timeOut, String path, By... selector) {
        UtilFunctions.log("Class: " + seleniumFunctions.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("path: " + path);

        String[] propArr = path.split(";");
        String value = "";
        String searchCriteria = "";
        if (propArr.length > 1) {
            value = propArr[0];
            searchCriteria = propArr[1];
        }
        By locator;
        WebDriverWait wait = new WebDriverWait(driver, timeOut);
        if (selector.length == 0) {
            switch (searchCriteria) {
                case "xpath":
                    /*locator = By.xpath(value);
                    break;*/
                case "path":
                    locator = By.xpath(value);
                    break;
                case "name":
                    locator = By.name(value);
                    break;
                case "id":
                    locator = By.id(value);
                    break;
                case "className":
                    locator = By.className(value);
                    break;
                default:
                    UtilFunctions.log("Valid By value or selector not passed in.  Setting by locator to NULL.");
                    locator = null; //Need to edit default criteria
                    break;
            }
        } else
            locator = selector[0];

        try {
            wait.until(ExpectedConditions.visibilityOfElementLocated(locator));
        } catch (Exception e) {
            e.printStackTrace();
            UtilFunctions.log("Element not found after timeout of " + timeOut + " seconds. Exception: " + e.getMessage());
        }
    }


    /**************************************************************************
     * name: switchToFrame(WebDriver driver, By value)
     * functionality: Function used to switch frames. Explicit wait before
     * switching to each element
     * param: WebDriver driver - WebDriver object
     * param: By value - By value of object based on xpath, id or name, etc
     * return: driver object of new frame
     *************************************************************************/
    public static WebDriver switchToFrame(WebDriver driver, By value) {
        UtilFunctions.log("Class: " + seleniumFunctions.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        WebElement element;
        try {
//            explicitWait(driver, GlobalConstants.FIVE, "", value);
            explicitWait(driver, GlobalConstants.ONE, "", value);
            element = driver.findElement(value);
            return driver.switchTo().frame(element);
        } catch (Exception exception) {
            exception.printStackTrace();
            UtilFunctions.log("Element not found for switching frames. Exception: " + exception.getMessage());
            return null;
        }
    }


    /**************************************************************************
     * name: setByValues(String propField)
     * functionality: Create By values based on locator and locator type
     * param: String propField - Locator + Locator type (xpath, id, etc)
     * return: returns By object
     *************************************************************************/
    public static By setByValues(String propField) {
        UtilFunctions.log("Class: " + seleniumFunctions.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("propField: " + propField);
        String switchValue;
        String switchType;
        if (propField.contains(";")) {
            switchType = propField.substring(propField.lastIndexOf(";") + 1, propField.length());
            switchValue = propField.substring(0, propField.lastIndexOf(";"));
        } else {
            switchType = "xpath";
            switchValue = propField;
        }
        UtilFunctions.log("switchType: " + switchType);
        UtilFunctions.log("switchValue: " + switchValue);
        switch (switchType) {
            case "xpath":
                return By.xpath(switchValue);
            case "name":
                return By.name(switchValue);
            case "id":
                return By.id(switchValue);
            case "tagName":
                return By.tagName(switchValue);
            case "className":
                return By.className(switchValue);
            default:
                return null;
        }
    }


    /**************************************************************************
     * name: setInitialWindowHandles(WebDriver driver)
     * functionality: Set the window variables for the main window
     * param: WebDriver driver - WebDriver object
     * return: void
     *************************************************************************/
    public static void setInitialWindowHandles(WebDriver driver) {
        UtilFunctions.log("Class: " + seleniumFunctions.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        //TODO: Replace all usage of "parentWindow" with "portalWindow"
        //Setting both parentWindow and portalWindow for legacy code support
        parentWindow = driver.getWindowHandle();
        UtilFunctions.log("parentWindow: " + parentWindow);
        portalWindow = parentWindow;
        UtilFunctions.log("portalWindow: " + portalWindow);
    }


    /**************************************************************************
     * name: switchToPopoutWindow(WebDriver driver)
     * functionality: Function used to switch to a note writer popout window
     * param: WebDriver driver - WebDriver object
     * return: void
     *************************************************************************/
    public static boolean switchToNWPopoutWindow(WebDriver driver) {
        UtilFunctions.log("Class: " + seleniumFunctions.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        UtilFunctions.log("parentWindow: " + parentWindow);
        UtilFunctions.log("portalWindow: " + portalWindow);
        Set<String> handles;
        handles = driver.getWindowHandles();
        if (handles.size() == 1) {
            UtilFunctions.sleep(2000);
            handles = driver.getWindowHandles();
        }
        for (String windowHandle : handles) {
            UtilFunctions.log("windowHandle: " + windowHandle);
            if (!windowHandle.equals(parentWindow) && !windowHandle.equals(portalWindow)) {
                popoutWindow = windowHandle;
                UtilFunctions.log("Window handle not equal to parent or portal windows. Switching to new popout window now: " + windowHandle);
                driver.switchTo().window(windowHandle);
                driver.manage().window().maximize();
                UtilFunctions.log("Switched to new popout window: " + windowHandle);
                return true;
            }
        }
        return false;
    }

    public static void switchToWindow(WebDriver driver, String window) {
        UtilFunctions.log("Class: " + seleniumFunctions.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        window = window.replace(" ", "");
        if (window.equals("portalWindow"))
            driver.switchTo().window(portalWindow);
        else if (window.equals("popoutWindow"))
            driver.switchTo().window(popoutWindow);
        else if (window.equals("LoginWindow")) {
            driver.switchTo().window(parentWindow);
            GlobalStepdefs.curTabName = "Login";
        } else
            Assert.assertTrue("Unrecognized window argument: " + window, false);
    }

    public static void switchToWindowTab(WebDriver driver, String windowTab) {
        UtilFunctions.log("Class: " + seleniumFunctions.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        try {
            String windowHandle;
            if (driverWindowsHandleMap.get(windowTab).size() > 1) {
                UtilFunctions.log("Window Opened in Pop-Up!!");
                windowHandle = String.valueOf(driverWindowsHandleMap.get(windowTab).toArray()[1]);
            } else {
                UtilFunctions.log("Window Opened in Same Tab, WITHOUT Pop-Up!!");
                windowHandle = String.valueOf(driverWindowsHandleMap.get(windowTab).toArray()[0]);
            }

            UtilFunctions.log("Switching to windowHandleTAB: " + windowHandle);
            driver.switchTo().window(windowHandle);
        } catch (Exception e) {
            Assert.assertTrue("Unrecognized window argument...", false);
        }
    }

    public static void setDriverWindowHandleMap(WebDriver driver) {
        UtilFunctions.log("Class: " + seleniumFunctions.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        String driverKey;
        if (driverWindowsHandleMap.size() == 0)
            driverKey = "1";
        else
            driverKey = String.valueOf(driverWindowsHandleMap.size() + 1);

        Set<String> windowHandles = driver.getWindowHandles();
        UtilFunctions.log("Retrieved Window Handles: " + windowHandles);

        //Remove already saved window handles from Set windowHandle
        for (Map.Entry<String, Set<String>> map : driverWindowsHandleMap.entrySet()) {
            for (String wHandle : map.getValue()) {
                if (windowHandles.contains(wHandle))
                    windowHandles.remove(wHandle);
            }
        }
        UtilFunctions.log("Updated Window Handles: " + windowHandles);

        for (String windowHandle : windowHandles) {
            UtilFunctions.log("Adding windowHandle: " + windowHandle);
            windowHandles.add(windowHandle);
        }
        driverWindowsHandleMap.put(driverKey, windowHandles);
    }

    /**************************************************************************
     * name: selectFrame(WebDriver driver, String frameName,
     * String identifierType)
     * functionality: Function used to separate list of frames and invoke
     * switchToFrame function one at a time
     * param: WebDriver driver - WebDriver object
     * param: String frameName - String containing the frame hierarchy
     * separated by "."
     * param: String identifierType - xpath, id, name, etc
     * return: void
     *************************************************************************/
    public static void selectFrame(WebDriver driver, String frameName, String identifierType) {
        UtilFunctions.log("Class: " + seleniumFunctions.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("frameName: " + frameName);
        UtilFunctions.log("identifierType: " + identifierType);
        //Some panes, usually popups, have the same frame path.  Elements cannot be found until frame is reselected.
//        if (GlobalConstants.getGlobalFrameValue().equals(frameName)){
//            System.out.println("Already in required frame");
//            UtilFunctions.log("Already in required frame.");
//        }
//        else{
        GlobalConstants.setGlobalFrameValue(frameName);
        String[] frameArray = frameName.split("\\.");
        try {
            driver.switchTo().defaultContent();
            if (frameName.equals("NO_FRAME"))
                return;
            for (String frame : frameArray) {
                System.out.println("Frame Name :: " + frame);
                UtilFunctions.log("FrameName: " + frame);
                if (frame.startsWith("**")) {
                    frame = frame.replace("**", "");
                    UtilFunctions.log("Frame name is dynamic. Switching using xpath/element.");
                    if (switchToFrame(driver, setByValues("//iframe[starts-with(@id, '" + frame + "')]" + ";xpath")) == null) {
                        UtilFunctions.log("Dynamic value is null when searched using xpath. Using identifierType 'element name' now.");
                        switchToFrame(driver, setByValues("//frame[@name='" + frame + "']" + ";xpath"));
                    }
                } else if (frame.startsWith("TASK")) {
                    UtilFunctions.log("Frame name is dynamic. Switching using xpath/element.");
                    if (switchToFrame(driver, setByValues("//iframe[starts-with(@id, '" + frame + "')]" + ";xpath")) == null) {
                        UtilFunctions.log("Dynamic value is null when searched using xpath. Using identifierType 'element name' now.");
                        switchToFrame(driver, setByValues("//frame[@name='" + frame + "']" + ";xpath"));
                    }
                } else if (switchToFrame(driver, setByValues(frame + ";" + identifierType)) == null) {
                    UtilFunctions.log("identifierType: " + identifierType + " value is null. Using identifierType 'name' now.");
                    switchToFrame(driver, setByValues(frame + ";name"));
                }
            }
        } catch (UnreachableBrowserException e) {
            UtilFunctions.log("Caught UnreachableBrowserException during Page.selectFrame: " + e.getMessage());
            //Not much we can do if this occurs.  Return and let the scenario fail.
            return;
        }
//        }
    }


    /**************************************************************************
     * name: handleAlert(WebDriver driver, String buttonName)
     * functionality: Function used to handle alerts on pages
     * param: WebDriver driver - WebDriver object
     * param: String buttonName - Name of button on alert
     * return: boolean
     *************************************************************************/
    public static boolean handleAlert(WebDriver driver, String buttonName) {
        UtilFunctions.log("Class: " + seleniumFunctions.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("buttonName: " + buttonName);

        WebDriverWait wait = new WebDriverWait(driver, 5);

        if (!checkAlertPresent(driver)) {
            UtilFunctions.log("No alert found");
            return false;
        }

        wait.until(ExpectedConditions.alertIsPresent());
        Alert alert = driver.switchTo().alert();
        switch (buttonName) {
            case "OK":
                alert.accept();
                UtilFunctions.log("Alert accepted. Returning true.");
                return true;
            case "Cancel":
                alert.dismiss();
                UtilFunctions.log("Alert dismissed. Returning false.");
                return false;
            default:
                return false;
        }
    }


    /**************************************************************************
     * name: checkAlertPresent(WebDriver driver)
     * functionality: Function used to check whether alert is present or not
     * param: WebDriver driver - WebDriver object
     * return: boolean
     *************************************************************************/
    public static boolean checkAlertPresent(WebDriver driver) {
        UtilFunctions.log("Class: " + seleniumFunctions.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        boolean alertPresent;
        WebDriverWait wait = new WebDriverWait(driver, 0);
        try {
            wait.until(ExpectedConditions.alertIsPresent());
            alertPresent = true;
            UtilFunctions.log("Alert present. Returning true.");
        } catch (org.openqa.selenium.TimeoutException eTO) {
            eTO.printStackTrace();
            alertPresent = false;
            UtilFunctions.log("Alert not present. Returning false. Exception: " + eTO.getMessage());
        }
        return alertPresent;
    }


    /**************************************************************************
     * name: clickTableItemIfNotClickedProperly(WebElement elementObj,
     *                                              boolean notFirstItem)
     * functionality: Click on table element. Retries multiple time unless item
     *                is selected
     * param: WebElement element - WebElement object
     * return: boolean true if element present and selected
     *************************************************************************/
    public static boolean clickTableItemIfNotClickedProperly(WebElement elementObj, boolean isRowObject) throws InterruptedException {
        UtilFunctions.log("Class: " + seleniumFunctions.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        WebElement parentObj;
        if (isRowObject) {
            parentObj = elementObj;
        } else {
            parentObj = SeleniumFunctions.findElementByWebElement(elementObj, SeleniumFunctions.setByValues(".." + ";xpath"));
            try {
                elementObj.click();
                Thread.sleep(2000);
                parentObj.click();
                UtilFunctions.log("Elements present in table and selected. Returning true.");
                return true;
            } catch (Exception e) {
                UtilFunctions.log("Exception occurred. Returning true.");
                return true;
            }
        }
        int firstItemClickCnt = 0;
        try {
            while ((parentObj.getAttribute("selected") == null) || (parentObj.getAttribute("selected").equals("N"))) {
                firstItemClickCnt++;
                elementObj.click();
                UtilFunctions.log("Waiting for element in table to be clicked!");
                Thread.sleep(1000);
                if (firstItemClickCnt > GlobalConstants.TEN) {
                    UtilFunctions.log("Elements present in table but not selected. Returning false.");
                    Assert.assertTrue("Elements present in table but not selected.", false);
                    return false;
                }
            }
            return true;
        } catch (Exception staleEle) {
            UtilFunctions.log("Exception occurred. Returning true.");
            return true;
        }
    }

    /**************************************************************************
     * Double click function
     *
     * @param driver WebDriver object
     * @param elementObj element object
     * @return void
     *
     *************************************************************************/
    public static void doubleClick(WebDriver driver, WebElement elementObj) throws InterruptedException {
        UtilFunctions.log("Class: " + seleniumFunctions.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        try {
            Actions act = new Actions(driver);
            act.doubleClick(elementObj).perform();
            UtilFunctions.log("double click on element");
        } catch (Exception e) {
            e.printStackTrace();
            UtilFunctions.log("Unable to Double Click on elment " + e.getMessage());
        }

    }

    /**************************************************************************
     * Highlighting the text function
     * @param value  Id of required text to highlight
     * @return void
     *
     *************************************************************************/
    public static void highlightText(String value) throws InterruptedException {
        UtilFunctions.log("Class: " + seleniumFunctions.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        //Java script for hailighting the text
        try {
            WebDriver driver = Hooks.getDriver();
            JavascriptExecutor js = (JavascriptExecutor) driver;
            String jsStr = "if (document.selection) {" +
                    "var div = document.body.createTextRange();" +
                    "div.moveToElementText(document.getElementById('" + value + "'));" +
                    "div.select();" +
                    "}" +
                    "else {" +
                    "var div = document.createRange();" +
                    "div.setStartBefore(document.getElementById('" + value + "'));" +
                    "div.setEndAfter(document.getElementById('" + value + "'));" +

                    "window.getSelection().addRange(div);" +
                    "}";
            js.executeScript(jsStr);
        } catch (Exception e) {
            e.printStackTrace();
            UtilFunctions.log("Unable to highlight the text " + e.getMessage());
        }
    }

    /**************************************************************************
     * name: getAlertText(WebDriver driver)
     * functionality: Function used to get alert text
     * param: WebDriver driver - WebDriver object
     * return: String
     *************************************************************************/
    public static String getAlertText(WebDriver driver) {
        UtilFunctions.log("Class: " + seleniumFunctions.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        String alertText;
        WebDriverWait wait = new WebDriverWait(driver, 5);
        try {
            wait.until(ExpectedConditions.alertIsPresent());
            Alert alert = driver.switchTo().alert();
            alertText = alert.getText();
            UtilFunctions.log("Got the alert text, returning the text");
        } catch (org.openqa.selenium.TimeoutException eTO) {
            eTO.printStackTrace();
            UtilFunctions.log("Unable to get the text " + eTO.getMessage());
            alertText = null;
        }
        return alertText;
    }

    /**
     * This method clicks an element via a JS click method.  Used as a workaround for various click issues,
     * such as ElementNotInteractableException errors, that occur in IE11, which is not W3C compliant.
     * <p>
     * Edited to match PortalUXF 9x Dashboard project
     *
     * @param element Element to be clicked
     * @return void
     */
    public static void click(WebElement element) {
        UtilFunctions.log("Class: " + seleniumFunctions.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        //Edits to match PortalUXF 9x Dashboard project
        WebDriver driver = Hooks.getDriver();
        JavascriptExecutor jsExecutor = (JavascriptExecutor) driver;
        jsExecutor.executeScript("arguments[0].scrollIntoView(true)", element);
        jsExecutor.executeScript("arguments[0].click()", element);

        //Former back up click action with Actions builder
        /*Actions actions = new Actions(driver);
        JavascriptExecutor jsExecutor = (JavascriptExecutor) driver;
        jsExecutor.executeScript("arguments[0].scrollIntoView(true)", element);
        actions.pause(Duration.ofMillis(1000)).perform();
        actions.click(element).perform();*/
    }

    /* name: clear(WebDriver driver, WebElement textField)
     * functionality: Clears the text field value with javascript.
     * @param: WebDriver driver - WebDriver object
     * @param: WebElement textField text field to be cleared
     * @return void
     */
    public static void clear(WebDriver driver, WebElement textField) {
        UtilFunctions.log("Class: " + seleniumFunctions.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        try {
            JavascriptExecutor jsExecutor = (JavascriptExecutor) driver;
            jsExecutor.executeScript("arguments[0].value='';", textField);
        } catch (Exception e) {
            UtilFunctions.log("Text field is not cleared due to exception: " + e.getMessage());
        }
    }

    /* name: mouseOver(WebDriver driver, WebElement textField)
     * functionality: Mouse overs on the given element with javascript.
     * @param: WebDriver driver - WebDriver object
     * @param: WebElement targetElement - Element to be mouseover
     * @return void
     */
    public static boolean mouseOver(WebDriver driver, WebElement targetElement) {
        UtilFunctions.log("Class: " + seleniumFunctions.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        try {
            JavascriptExecutor jsExecutor = (JavascriptExecutor) driver;
            String mouseOverScript = "if(document.createEvent){var evObj = document.createEvent('MouseEvents');" +
                    "evObj.initEvent('mouseover',true, false); arguments[0].dispatchEvent(evObj);}" +
                    " else if(document.createEventObject) { arguments[0].fireEvent('onmouseover');}";
            jsExecutor.executeScript(mouseOverScript, targetElement);
            UtilFunctions.log("Mouse over is successful");
            return true;
        } catch (Exception e) {
            UtilFunctions.log("Mouse over is not successful due to exception: " + e.getMessage());
            return false;
        }
    }

    /**
     * Utility function to check if a web element is selected or clicked
     *
     * @param webElement -- element that is the event listener and receives the click and state change
     * @return a bool whether element is selected / is checked / is active / etc.
     */
    public static boolean isSelected(WebElement webElement) {
        return webElement.getAttribute("class").contains("is-checked") ||
                webElement.getAttribute("class").contains("checked") ||
                webElement.getAttribute("class").contains("is-active") ||
                webElement.getAttribute("class").contains("active") ||
                webElement.getAttribute("class").contains("md-checked") ||
                webElement.getAttribute("class").contains("md-focused") ||
                webElement.getAttribute("class").contains("is-focused") ||
                webElement.getAttribute("class").contains("ui-state-active") ||
                webElement.getAttribute("class").contains("ui-tabs-active") ||
                webElement.getAttribute("class").contains("is-visible") ||
                webElement.getAttribute("class").contains("is-expanded") ||
                webElement.isSelected();
    }

    /**
     * scroll item into view; defaults alignToTop value to `true` to match default behavior in JavaScript
     *
     * @param element element to scroll into view
     */
    public static void scrollIntoView(WebElement element) {
        scrollIntoView(element, true);
    }

    /**
     * scroll item into view
     *
     * @param element    element to scroll into view
     * @param alignToTop if true, the top of the element will be aligned to the top of the visible area of the scrollable ancestor
     *                   if false, the bottom of the element will be aligned to the bottom of the visible area of the scrollable ancestor
     */
    public static void scrollIntoView(WebElement element, boolean alignToTop) {
        UtilFunctions.log("Class: " + seleniumFunctions.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        String bString = alignToTop ? "true" : "false";
        ((JavascriptExecutor) Hooks.getDriver()).executeScript("arguments[0].scrollIntoView(" + bString + ");", element);

        UtilFunctions.log("Class: " + seleniumFunctions.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + ": Complete");
    }

    public static WebElement getParentWebElement(String childsXpath) {
        UtilFunctions.log("Class: " + seleniumFunctions.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + ": Start");

        WebElement parentElement = findElement(Hooks.getDriver(), By.xpath(childsXpath + "/.."));

        UtilFunctions.log("Class: " + seleniumFunctions.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + ": Complete");

        return parentElement;
    }

    public static void hoverElement(WebElement element) {
        UtilFunctions.log("Class: " + seleniumFunctions.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + ": Start");

        scrollIntoView(element);
        UtilFunctions.sleep(500);
        Actions actions = new Actions(Hooks.getDriver());
        actions.moveToElement(element);
        UtilFunctions.sleep(500);
    }


}//end class
