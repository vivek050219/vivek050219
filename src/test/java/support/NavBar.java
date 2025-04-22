package support;

import common.SeleniumFunctions;
import constants.GlobalConstants;
import features.Hooks;
import frames.Global_Frames;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import utils.UtilFunctions;

import java.util.HashMap;

/**
 * Created by PatientKeeper on 6/24/2016.
 */

/******************************************************************************
 Class Name: NavBar
 Contains functions related to navigation bar
 ******************************************************************************/

public class NavBar {

    private static HashMap<String, String> tabSet = new HashMap<>();
    private static HashMap<String, String> subTabSet = new HashMap<>();
    private static HashMap<String, String> tabFrames = new HashMap<>();
    private static HashMap<String, String> expectedPanes = new HashMap<>();

    public String className = getClass().getSimpleName();
    private static NavBar navBar = new NavBar();


    /**************************************************************************
     * name: setNavBarParameters()
     * functionality: Function used to set maps related to navigation bar
     * return: void
     *************************************************************************/
    public static void setNavBarParameters(){
        //Set tabSet
        tabSet.put("Admin", "ADMINNAV");
        tabSet.put("PatientList", "PT");
        tabSet.put("PatientListV2", "PT");
        tabSet.put("PatientSummary", "PTSUMMARYTABS");
        tabSet.put("Charges", "CHARGEDESKTOPNAV");
        tabSet.put("Inbox", "INBOX");
        tabSet.put("ProviderDirectory", "PROVIDERDIRECTORY");
        tabSet.put("PatientSearch", "PTSEARCH");
        tabSet.put("Forms", "FORMDESKTOPTABS");
        tabSet.put("Schedule", "SCHEDULE");
        tabSet.put("Preferences", "PREFNAV");
        tabSet.put("NoteSearch", "NWSEARCH");
        tabSet.put("Assignment", "PLASSIGNMENT");
//        tabSet.put("Assignment", "PLASSIGNMENTTABS");//This keeps changing back and forth b/w these two id's

        //Set subTabSet
        subTabSet.put("Admin:Institution", "INST");
        subTabSet.put("Admin:Department", "DEPT");
        subTabSet.put("Admin:User", "USER");
        subTabSet.put("Admin:BulkUserEdit", "BULKUSEREDIT");
        subTabSet.put("Admin:SystemManagement", "SYSMANAGE");
        subTabSet.put("Admin:Preferences", "PREFS");
        subTabSet.put("Admin:Location", "LOCATION");
        subTabSet.put("Admin:FacilityGroup", "FACILITYGROUP");
        subTabSet.put("Admin:Tracking/Reporting", "DEVICEREPORTS");

        subTabSet.put("Charges:Summary", "SUMMARY");
        subTabSet.put("Charges:HoldingBin", "HOLDINGBIN");
        subTabSet.put("Charges:BatchChargeEntry", "BATCHENTRY");
        subTabSet.put("Charges:PatientChargeStatus", "PTCHARGEVIEW");
        subTabSet.put("Charges:Worklist", "WORKLIST");
        subTabSet.put("Charges:Search", "CHARGES");
        subTabSet.put("Charges:Outbox", "OUTBOX");
        subTabSet.put("Charges:BatchChargeEntry", "BATCHENTRY");

        subTabSet.put("Inbox:eSigandPKMail", "MESSAGELISTINBOX");
        subTabSet.put("Inbox:Outbox", "MESSAGELISTOUTBOX");
        subTabSet.put("Inbox:SendPKMail", "SENDMESSAGE");

        subTabSet.put("PatientSummary:PatientSummary", "PTSUMMARY");
        subTabSet.put("PatientSummary:Sign-OutSummary", "SIGNOUT");

        subTabSet.put("Forms:Forms", "FORMNAV");
        subTabSet.put("Forms:Measures", "MEASURESEARCHNAV");

        //Set tabFrames
        tabFrames.put("Admin", "ADMIN");
        tabFrames.put("Charges", "CHARGENAV");
        tabFrames.put("Inbox", "INBOXTABSPANE");
        tabFrames.put("PatientSummary", "TABS");
        tabFrames.put("Forms", "TABS");

        //Set expectedPanes
        expectedPanes.put("Admin:Institution", "InstitutionSettings");
        expectedPanes.put("Admin:Department", "DepartmentSettings");
        expectedPanes.put("Admin:User", "UserSettings");
//        expectedPanes.put("Admin:BulkUserEdit", "UserSearch");
        expectedPanes.put("Admin:SystemManagement", "SystemManagementNavigation");
        expectedPanes.put("Admin:Preferences", "UserPreferences");
    }


    /**************************************************************************
     * name: selectNavigationTab(WebDriver driver, String tabName,
     * String subTabName)
     * functionality: Function used to select and click tab or sub-tab
     * param: WebDriver driver - WebDriver object
     * param: String tabName - Name of tab
     * param: String subTabName - Name of sub-tab
     * return: boolean
     *************************************************************************/
    public static boolean selectNavigationTab(WebDriver driver, String tabName, String subTabName){
        UtilFunctions.log("Class: " + navBar.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);
        UtilFunctions.log("Sub-tab name: " + subTabName);

        if (subTabName.equals("")) {
            setNavBarParameters();
            SeleniumFunctions.selectFrame(driver, Global_Frames.globalFramesMap.get("FRAME_MAIN_NAV"), "name");
            //Click on Tab
            SeleniumFunctions.explicitWait(driver, GlobalConstants.TWENTY, tabSet.get(tabName) + ";" + "id");
            WebElement tabElement = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(tabSet.get(tabName) + ";id"));
            if (tabElement != null) {
                tabElement.click();
                //Work-around for: #[DEV-82552] - System Error thrown in Assignment tab when a pre-selected patient list is deleted
                SeleniumFunctions.handleAlert(Hooks.getDriver(), "OK");
                tabElement.click(); //temp code - Not clicking on admin tab during first click
                UtilFunctions.log("Tab: " + tabName + " is present and clicked. Returning true.");
                return true;
            }
            else {
                UtilFunctions.log("Tab: " + tabName + " is not present. Returning false.");
                return false;
            }
        }
        else{
            SeleniumFunctions.selectFrame(driver, Global_Frames.globalFramesMap.get("FRAME_GLOBAL_MAIN") + "." + tabSet.get(tabName) + "." + tabFrames.get(tabName), "name");
            String subTabXPath = "//li[@id=" + "'" + subTabSet.get(tabName + ":" + subTabName) + "'" + "]";
            UtilFunctions.log("subTabXPath: " + subTabXPath);
            SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, subTabXPath + ";xpath");
            WebElement subTabElement = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(subTabXPath + ";xpath"));
            if (subTabElement != null){
                subTabElement.click();
                subTabElement.click(); //temp code - Not clicking on sub tab during first click
                UtilFunctions.log("subTab: " + subTabName + " is present and clicked.");
                if (expectedPanes.get(tabName + ":" + subTabName) == null){
                    UtilFunctions.log("Not checking for expected panes. Returning true.");
                    return true;
                }
                else{
//                    WebElement paneObj = Page.findPane(driver, tabName, expectedPanes.get(tabName + ":" + subTabName));
                    WebElement paneObj = Page.findPane(driver, tabName, expectedPanes.get(tabName + ":" + subTabName), GlobalConstants.FIFTEEN);
                    if (paneObj != null) {
                        UtilFunctions.log("Pane: " + expectedPanes.get(tabName + ":" + subTabName) + " is present. Returning true.");
                        return true;
                    }
                    else {
                        UtilFunctions.log("Pane: " + expectedPanes.get(tabName + ":" + subTabName) + " is not present. Returning false.");
                        return false;
                    }
                }
            }
            else {
                UtilFunctions.log("subTab: " + subTabName + " is not present. Returning false.");
                return false;
            }
        }
    }


    /**************************************************************************
     * name: navigationSubTabExists(WebDriver driver, String tabName,
     * String subTabName)
     * functionality: Function used to check whether sub-tab exists or not
     * param: WebDriver driver - WebDriver object
     * param: String tabName - Name of tab
     * param: String subTabName - Name of sub-tab
     * return: boolean
     *************************************************************************/
    public static boolean navigationSubTabExists(WebDriver driver, String tabName, String subTabName){
        UtilFunctions.log("Class: " + navBar.className + "; Method: " + new Object(){}.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);
        UtilFunctions.log("Sub-tab name: " + subTabName);

        String curFrame = Global_Frames.globalFramesMap.get("FRAME_GLOBAL_MAIN") + "." + tabSet.get(tabName) + "." + tabFrames.get(tabName);
        SeleniumFunctions.selectFrame(driver, curFrame, "id");
        String navSubTabXPath = "//li[@id='" + subTabSet.get(tabName + ":" + subTabName) + "']";
        UtilFunctions.log("navSubTabXPath: " + navSubTabXPath);
        SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, navSubTabXPath + ";xpath");
        WebElement element = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(navSubTabXPath + ";xpath"));
        if (element == null) {
            UtilFunctions.log("navSubTabXPath: " + navSubTabXPath + " does not exist. Returning false.");
            return false;
        }
        else {
            UtilFunctions.log("navSubTabXPath: " + navSubTabXPath + " exist. Returning true.");
            return true;
        }
    }

    /**************************************************************************
     * name: navigationTabExists(WebDriver driver, String tabName)
     * functionality: Function used to check whether tab exists or not
     * param: WebDriver driver - WebDriver object
     * param: String tabName - Name of tab
     * return: boolean
     *************************************************************************/
    public static boolean navigationTabExists(WebDriver driver, String tabName){
        UtilFunctions.log("Class: " + navBar.className + "; Method: " + new Object(){}.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);

        String curFrame = Global_Frames.globalFramesMap.get("FRAME_MAIN_NAV") + "." + tabSet.get(tabName) + "." + tabFrames.get(tabName);
        SeleniumFunctions.selectFrame(driver, curFrame, "id");

        String navTabXPath = "//li[@id='" + tabSet.get(tabName) + "']";
        UtilFunctions.log("navTabXPath: " + navTabXPath);
        SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, navTabXPath + ";xpath");
        WebElement element = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(navTabXPath + ";xpath"));

        String navTabXPath2 = "//td[@id='button_" + tabSet.get(tabName) + "']";
        UtilFunctions.log("navTabXPath2: " + navTabXPath);
        SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, navTabXPath2 + ";xpath");
        WebElement element2 = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(navTabXPath2 + ";xpath"));

        if (element == null && element2 == null) {
            UtilFunctions.log("navTabXPath: " + navTabXPath + "and" + navTabXPath2 + " does not exist. Returning false.");
            return false;
        }
        else{
            UtilFunctions.log("navTab exists. Returning true.");
            return true;
        }
    }
}
