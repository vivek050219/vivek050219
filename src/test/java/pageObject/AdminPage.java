package pageObject;

import common.SeleniumFunctions;
import constants.GlobalConstants;
import cucumber.api.DataTable;
import features.Hooks;
import features.step_definitions.AdminDepartmentStepdefs;
import features.step_definitions.AdminTabStepdefs;
import features.step_definitions.GlobalStepdefs;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import support.Page;
import utils.UtilFunctions;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.openqa.selenium.By;

/**
 * Created by PatientKeeper on 9/12/2016.
 */
public class AdminPage {

    public String className = getClass().getSimpleName();
    private static AdminPage adminPage = new AdminPage();

    static String tabName = "Admin";

    /**************************************************************************
     * name: selectUserByUsername(WebDriver driver, String userName)
     * functionality: Select user on admin page
     * param: WebDriver driver - WebDriver object
     * param: String userName - User name
     * return: boolean
     *************************************************************************/
    public static boolean selectUserByUsername(WebDriver driver, String userName) {
        UtilFunctions.log("Class: " + adminPage.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        WebElement userObj = findUserByUsername(driver, userName);
        if (userObj == null)
            return false;
        else {
            userObj.click();
            UtilFunctions.log("User: " + userName + " selected.");
            return true;
        }
    }


    /**************************************************************************
     * name: findUserByUsername(WebDriver driver, String userName)
     * functionality: Find user element object on admin page
     * param: WebDriver driver - WebDriver object
     * param: String userName - User name
     * return: WebElement object for user name
     *************************************************************************/
    public static WebElement findUserByUsername(WebDriver driver, String userName) {
        UtilFunctions.log("Class: " + adminPage.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        String userFrameName = "FRAME_USER_MAIN";
        String userNameXPath = "//td[@class='tableText' and text()='" + userName + "']";
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);

        SeleniumFunctions.selectFrame(driver, UtilFunctions.getFrameValue(frameMap, userFrameName), "id");
        return SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(userNameXPath + ";" + "xpath"));
    }


    public static void searchForUser(WebDriver driver, String userName) {
        UtilFunctions.log("Class: " + adminPage.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        SeleniumFunctions.selectFrame(driver, UtilFunctions.getFrameValue(frameMap, "FRAME_QUICK_DETAILS"), "id");
        try {
            Page.clickButton(driver, tabName, "Search", "QuickDetails");
            Thread.sleep(2000);
            Page.setTextBox(Hooks.getDriver(), tabName, userName, "SearchForUser");
            Page.clickButton(Hooks.getDriver(), tabName, "Search");
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }


    public static boolean userExists(WebDriver driver, String userName) {
        UtilFunctions.log("Class: " + adminPage.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        searchForUser(driver, userName);
        if (findUserByUsername(driver, userName) == null)
            return false;
        else
            return true;
    }


    /**************************************************************************
     * name: editUserSettings(WebDriver driver, DataTable dataTable,
     * String clickSave)
     * functionality: Used to edit user settings on admin page
     * param: WebDriver driver - WebDriver object
     * param: DataTable dataTable - DataTable storing values to be edited
     * param: String clickSave - Shows status of Save button, to be clicked
     * or not
     * return: void
     *************************************************************************/
    public static void editUserSettings(WebDriver driver, DataTable dataTable, String clickSave) throws Throwable {
        UtilFunctions.log("Class: " + adminPage.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Current tab name: " + tabName);

        GlobalStepdefs globalStepdefs = new GlobalStepdefs();

        List<Map<String, String>> dataList = dataTable.asMaps(String.class, String.class);
        for (Map data : dataList) {
            String page = (String) data.get("Page");
            String name = ((String) data.get("Name"));
            String type = (String) data.get("Type");
            String value = ((String) data.get("Value"));

            UtilFunctions.log("Page: " + page);
            UtilFunctions.log("Name: " + name);
            UtilFunctions.log("Type: " + type);
            UtilFunctions.log("Value: " + value);

            switch (type) {
                case "dropdown":
                    globalStepdefs.selectFromDropdown(page, "Edit User Settings", null, null);
                    globalStepdefs.selectFromDropdown(value, name, null, null);
                    break;

                case "radio":
                    globalStepdefs.selectFromDropdown(page, "Edit User Settings", null, null);
                    globalStepdefs.selectRadioListButton(value, name);
                    break;
                default:
                    break;
            }
        }
        if (!clickSave.equals("")) {
            globalStepdefs.clickButton("InformationOK", null, "fsd");
            globalStepdefs.clickButton("Save", null, null);
            while (!SeleniumFunctions.checkAlertPresent(Hooks.getDriver()))
                globalStepdefs.clickButton("Save", null, null);
            globalStepdefs.selectAlert("OK", null);

            GlobalConstants.setGlobalFrameValue("");
            Page.checkElementOnPagePresent(driver, tabName, "Save", "BUTTONS");
        }
    }

    /**************************************************************************
     * Create a temporary user
     *
     * @param driver the WebDriver object
     *************************************************************************/
    public static void createUser(WebDriver driver, String firstName, String lastName, String username, String password) {
        //try {
        Page.setCheckBox(driver, "Admin", "UseBasicAuthentication", "check",
                null);
        /*} catch (InterruptedException e) {
            e.printStackTrace();
        }*/
        Page.setTextBox(driver, "Admin", firstName, "FirstName");
        Page.setTextBox(driver, "Admin", lastName, "LastName");
        Page.setTextBox(driver, "Admin", username, "Username");
        Page.setTextBox(driver, "Admin", password, "Password");
        Page.setTextBox(driver, "Admin", password, "VerifyPassword");
    }


    /**************************************************************************
     * name: selectDepartmentItem(WebDriver driver, String itemName)
     * functionality: Used to select department item on admin page
     * param: WebDriver driver - WebDriver object
     * param: String itemName - Department item to be clicked
     * return: boolean
     *************************************************************************/
    public static boolean selectDepartmentItem(WebDriver driver, String itemName) {
        UtilFunctions.log("Class: " + adminPage.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        WebElement deptItemObj = findDepartmentItem(driver, itemName);
        if (deptItemObj == null) {
            UtilFunctions.log("Department Item: " + itemName + " is not present. Returning false.");
            return false;
        } else {
            deptItemObj.click();
            UtilFunctions.log("Department Item: " + itemName + " present and clicked. Returning true.");
            return true;
        }
    }


    /**************************************************************************
     * name: findDepartmentItem(WebDriver driver, String itemName)
     * functionality: Used to find department item object on admin page
     * param: WebDriver driver - WebDriver object
     * param: String itemName - Department item to be clicked
     * return: WebElement object for department item on admin page
     *************************************************************************/
    public static WebElement findDepartmentItem(WebDriver driver, String itemName) {
        UtilFunctions.log("Class: " + adminPage.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        String deptFrameName = "FRAME_DEPT_MAIN";
        String deptNameXPath = "//td[@class='tableText' and contains(text(), '" + itemName + "')]";
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        SeleniumFunctions.selectFrame(driver, UtilFunctions.getFrameValue(frameMap, deptFrameName), "id");
        return SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(deptNameXPath + ";" + "xpath"));
    }


    /**************************************************************************
     * Find a provider group within the Provider Group Maintenance table
     *
     * @param driver WebDriver object
     * @param providerGroup provider group to find
     * @return WebElement
     *************************************************************************/
    public static WebElement findProviderGroup(WebDriver driver, String providerGroup) {
        UtilFunctions.log("Class: " + adminPage.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        String providerFrameName = "FRAME_PROVIDERGROUP_SEARCHRESULTS";
        String providerNameXPath = "//td[@class='rBB' and text()='" + providerGroup + "']";
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        SeleniumFunctions.selectFrame(driver, UtilFunctions.getFrameValue(frameMap, providerFrameName), "id");
        return SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(providerNameXPath + ";" + "xpath"));
    }


    /**************************************************************************
     * Select a provider group form the Provider Group Maintenance table
     *
     * @param driver WebDriver object
     * @param providerGroup provider group to select
     * @return boolean
     *************************************************************************/
    public static boolean selectProviderGroup(WebDriver driver, String providerGroup) {
        UtilFunctions.log("Class: " + adminPage.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        WebElement providerGroupObj = findProviderGroup(driver, providerGroup);
        if (providerGroupObj == null)
            return false;
        else {
            providerGroupObj.click();
            UtilFunctions.log("User: " + providerGroup + " selected.");
            return true;
        }
    }

    private static WebElement findBulkUserByUsername(WebDriver driver, String userName, String paneName) {
        UtilFunctions.log("Class: " + adminPage.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        paneName = paneName.replace(" ", "");
        String tabName = GlobalStepdefs.curTabName;
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        String paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
        UtilFunctions.log("PaneFrames: " + paneFrames);
        SeleniumFunctions.selectFrame(driver, paneFrames, "id");

        return SeleniumFunctions.findElement(driver, By.xpath("//td[@class='rBB' and text()='" + userName + "']"));
    }

    public static void selectBulkUserByUserName(WebDriver driver, String userName, String paneName) {
        UtilFunctions.log("Class: " + adminPage.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        findBulkUserByUsername(driver, userName, paneName).click();
    }

    /**************************************************************************
     * Check template is loaded or not
     *
     * @param driver WebDriver object
     * @param templateName name of template to check
     * @return boolean
     *************************************************************************/

    public static boolean templateLoad(WebDriver driver, String templateName) throws Throwable {
        UtilFunctions.log("Class: " + adminPage.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + ": Start");

        if (templateName == null) {
            UtilFunctions.log("NW template name can't be null, name must be passed in as a String.  Returning false...");
            System.out.println("NW template name can't be null, name must be passed in as a String.  Returning false...");
            return false;
        }

        String paneFrameName = "FRAME_POPUP_CONTENTS";
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        paneFrameName = UtilFunctions.getFrameValue(frameMap, paneFrameName);
        UtilFunctions.log("PaneFrames: " + paneFrameName);
        SeleniumFunctions.selectFrame(driver, paneFrameName, "id");

        SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.ONE,
                "//td[@name='" + templateName + "']" + ";xpath");
        WebElement template = SeleniumFunctions.findElement(Hooks.getDriver(),
                SeleniumFunctions.setByValues("//td[@name='" + templateName + "']"));
        if (template != null) {
            UtilFunctions.log("NW template: " + templateName + " FOUND.  Returning true...");
            System.out.println("NW template: " + templateName + " FOUND.  Returning true...");
            return true;
        }

        UtilFunctions.log("NW template: " + templateName + " is NULL and not found.  Returning false...");
        System.out.println("NW template: " + templateName + " is NULL and not found.  Returning false...");

        UtilFunctions.log("Class: " + adminPage.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + ": Complete");
        return false;
    }


    /**************************************************************************
     * Check for Picker
     *
     * @param driver WebDriver object
     * @param notePickerName name of template to check
     * @return boolean
     *************************************************************************/
    public static boolean checkNotePicker(WebDriver driver, String departmentName, String notePickerName)
            throws Throwable {
        UtilFunctions.log("Class: " + adminPage.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        //AdminDepartmentStepdefs adminDepartmentStepdefs = new AdminDepartmentStepdefs();
        AdminTabStepdefs adminTabStepdefs = new AdminTabStepdefs();

        //Commenting out, so this method can be used with more scenarios.  -- HIC 03/21/19
        //globalStepdefs.selectSubTab("Department");
        /*adminDepartmentStepdefs.selectDepartment(departmentName);
        globalStepdefs.clickButton("Edit", "Quick Details", null);
        globalStepdefs.selectFromDropdown("NoteWriter",
                "Edit Department Settings", "Department Edit Settings", null);
        adminTabStepdefs.clickEditLinkInPane("Note Pickers", null, "Note Writer Settings");*/

        String paneFrameName = "FRAME_POPUP_CONTENTS";
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        paneFrameName = UtilFunctions.getFrameValue(frameMap, paneFrameName);
        UtilFunctions.log("PaneFrames: " + paneFrameName);
        SeleniumFunctions.selectFrame(driver, paneFrameName, "id");

        SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.TEN,
                "//td[@class='underline default-cursor' and descendant-or-self::*/text()='" +
                        notePickerName + "']" + ";xpath");
        WebElement templateName = SeleniumFunctions.findElement(Hooks.getDriver(),
                SeleniumFunctions.setByValues("//td[@class='underline default-cursor' and descendant-or-self::*/text()='"
                        + notePickerName + "']"));

        if (departmentName.equals("Verve")) {
            if (templateName != null) {
                //commented below step as method should verify all the templates in department note pickers pane in datatable
                //globalStepdefs.clickButton("Close", "Department Note Pickers", null);
                System.out.println("Template '" + notePickerName + "' found. Returning true.");
                UtilFunctions.log("Template '" + notePickerName + "' found. Returning true.");
                return true;
            } else {
                adminTabStepdefs.clickEditLinkInPane("Department Pickers", "category", "Department Note Pickers");
                globalStepdefs.waitGivenTime("3");
                globalStepdefs.enterInTheField(notePickerName, "AddCode", null);
                globalStepdefs.clickMiscElement("Lookup Values", null,
                        "Edit Department Note Pickers", null);
                globalStepdefs.clickButton("Save", "Edit Department Note Pickers", null);
                globalStepdefs.waitGivenTime("2");
                globalStepdefs.clickButton("Close", "Department Note Pickers", null);
                System.out.println("Template '" + notePickerName + "' added for Verve Dept. Returning true.");
                UtilFunctions.log("Template '" + notePickerName + "' added for Verve Dept. Returning true.");
                return true;
            }
        } else {
            if (templateName != null) {
                System.out.println("Template '" + notePickerName + "' found. Returning true.");
                UtilFunctions.log("Template '" + notePickerName + "' found. Returning true.");
                return true;
            }
        }

        System.out.println("Template '" + notePickerName + "' NOT found. Returning false.");
        UtilFunctions.log("Template '" + notePickerName + "' NOT found. Returning false.");
        return false;
    }//end checkNotePicker


    /**************************************************************************
     * Check for these Note Pickers Only
     *
     * @param driver WebDriver object
     * @param dataTable data table of note pickers you're looking for
     * @return boolean
     *************************************************************************/
    public static boolean checkForTheseNotePickersOnly(WebDriver driver, DataTable dataTable)
            throws Throwable {
        UtilFunctions.log("Class: " + adminPage.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        String paneFrameName = "FRAME_POPUP_CONTENTS";
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        paneFrameName = UtilFunctions.getFrameValue(frameMap, paneFrameName);
        UtilFunctions.log("PaneFrames: " + paneFrameName);
        SeleniumFunctions.selectFrame(driver, paneFrameName, "id");
        String templateName = "", notePickername = "";
        boolean listsMatch = true;

        List<String> dataList = dataTable.asList(String.class);

        SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.TEN,
                "//table[@id='pickerTable']//tr[@class='pointer' and @pkentity='Hpicker']" +
                        "/td[@class='underline default-cursor']" +
                        "/div[contains(@style,'padding-left:')]");
        List<WebElement> noteTemplatesList = SeleniumFunctions.findElements(Hooks.getDriver(),
                SeleniumFunctions.setByValues("//table[@id='pickerTable']//tr[@class='pointer' and @pkentity='Hpicker']" +
                        "/td[@class='underline default-cursor']" +
                        "/div[contains(@style,'padding-left:')]"));

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
    }//end checkForTheseNotePickersOnly


    /**************************************************************************
     * Search Provider in search result
     *
     * @param driver WebDriver object
     * @param providerName name of Provider
     * @param paneName name of Pane
     * @return WebElement
     *************************************************************************/
    public static WebElement findProviderByName(WebDriver driver, String providerName, String paneName) {
        UtilFunctions.log("Class: " + adminPage.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");


        paneName = paneName.replace(" ", " ");
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        String paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName.replace(" ", ""), "frame"));
        UtilFunctions.log("PaneFrames: " + paneFrames);
        SeleniumFunctions.selectFrame(driver, paneFrames, "id");

        return SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//tr[@class='Person_row pointer' and @fullname='" + providerName + "']" + ";xpath"));
    }

    /**************************************************************************
     * Functionality for adding Provider
     *
     * @param driver WebDriver object
     * @param data name of Provider
     * @return boolean
     *************************************************************************/

    public static boolean addProvider(WebDriver driver, List<String> data) throws Throwable {
        UtilFunctions.log("Class: " + adminPage.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        String providerFrameName = "FRAME_TERTIARY_POPUP_CONTENTS";
        SeleniumFunctions.selectFrame(driver, UtilFunctions.getFrameValue(frameMap, providerFrameName), "id");
        SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.FIFTEEN, "//div[@id='SelectedValueTable']" + ";xpath");
        SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//div[@id='SelectedValueTable']"));
        String tableName = "SelectedList";
        GlobalStepdefs globalStepsObj = new GlobalStepdefs();
        if (Page.checkTableExists(driver, tabName, tableName)) {
            int noOfRows = Page.countTableRows(driver, tabName, tableName, "", null);
            if (noOfRows > 0) {
                UtilFunctions.log("No of rows in table: " + tableName + " is: " + noOfRows);

                globalStepsObj.clickButton("Select All", "Edit Short List", null);
                globalStepsObj.clickButton("Remove", "Edit Short List", null);
            }
            for (String providerName : data) {
                globalStepsObj.waitGivenTime("2");
                globalStepsObj.enterInTheField(providerName, "ProviderNameIdAlias", "EditShortListProviderSearch");
                globalStepsObj.selectFromDropdown("PROVIDER", "Role", "EditShortListProviderSearch", null);
                globalStepsObj.clickButton("Search", "EditShortListProviderSearch", null);
                globalStepsObj.waitGivenTime("2");
                WebElement searchResult = AdminPage.findProviderByName(Hooks.getDriver(), providerName, "EditShortListProviderSearchResults");
                searchResult.click();
                globalStepsObj.clickButton("MoveRightButton", "Edit Short List", null);
            }
            globalStepsObj.clickButton("OK", "Edit Short List", null);
            return true;
        }
        UtilFunctions.log("Table: " + tableName + "not present");
        return false;
    }

    /**************************************************************************
     * Functionality for remove Provider
     *
     * @param driver WebDriver object
     * @return boolean
     *************************************************************************/
    public static boolean removeProvider(WebDriver driver) throws Throwable {
        UtilFunctions.log("Class: " + adminPage.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        String providerFrameName = "FRAME_TERTIARY_POPUP_CONTENTS";
        SeleniumFunctions.selectFrame(driver, UtilFunctions.getFrameValue(frameMap, providerFrameName), "id");
        SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.FIFTEEN, "//div[@id='SelectedValueTable']" + ";xpath");
        SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//div[@id='SelectedValueTable']"));
        String tableName = "SelectedList";
        GlobalStepdefs globalStepsObj = new GlobalStepdefs();
        if (Page.checkTableExists(driver, tabName, tableName)) {
            int noOfRows = Page.countTableRows(driver, tabName, tableName, "", null);
            if (noOfRows > 0) {
                UtilFunctions.log("No of rows in table: " + tableName + " is: " + noOfRows);
                globalStepsObj.clickButton("Select All", "Edit Short List", null);
                globalStepsObj.clickButton("Remove", "Edit Short List", null);
                globalStepsObj.clickButton("OK", "Edit Short List", null);
                return true;
            }
            UtilFunctions.log("No data present in " + tableName + ".");
            globalStepsObj.clickButton("OK", "Edit Short List", null);
            return true;
        }
        UtilFunctions.log("Table: " + tableName + "not present");
        return false;
    }

    public static WebElement findUserInDeptUserList(WebDriver driver, String userName) {
        UtilFunctions.log("Class: " + adminPage.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        String userFrameName = "FRAME_DEPT_MAIN";
        String userNameXPath = "//td[@class='tableText' and text()='" + userName + "']";
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);

        SeleniumFunctions.selectFrame(driver, UtilFunctions.getFrameValue(frameMap, userFrameName), "id");
        return SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(userNameXPath + ";" + "xpath"));
    }

    public static boolean userInDeptUserListExists(WebDriver driver, String userName) {
        UtilFunctions.log("Class: " + adminPage.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        WebElement userObj = findUserInDeptUserList(driver, userName);
        if (userObj == null) {
            UtilFunctions.log("User: " + userName + " is not present in user list. Returning false.");
            return false;
        } else {
            UtilFunctions.log("User: " + userName + " present in user list. Returning true.");
            return true;
        }
    }

    public static boolean bulkUserExists(WebDriver driver, String userName, String paneName) {
        UtilFunctions.log("Class: " + adminPage.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        WebElement bulkUserObj = findBulkUserByUsername(driver, userName, paneName);
        if (bulkUserObj == null) {
            UtilFunctions.log("Bulk User: " + userName + " is not present in " + paneName + " pane. Returning false.");
            return false;
        } else {
            UtilFunctions.log("Bilk User: " + userName + " present in " + paneName + " pane. Returning true.");
            return true;
        }
    }
}


