package infra.setUp;

import common.SeleniumFunctions;
import constants.GlobalConstants;
import features.Hooks;
import pageObject.AdminPage;
import support.NavBar;
import support.Page;
import support.db.DBExecutor;
import utils.UtilFunctions;
import utils.UtilProperty;

/**
 * Created by PatientKeeper on 11/21/2016.
 */
public class CodeEdits {

    public String className = getClass().getSimpleName();
    private static CodeEdits codeEdits = new CodeEdits();

    public static void initialize() {
        UtilFunctions.log("Class: " + codeEdits.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        String tabName = "Admin";

        try {
            Hooks.openBrowser(UtilProperty.userName, null);

            //Enable Code Edits - This part is not required as it is already being performed by the first scenario in code edit feature file.
            NavBar.selectNavigationTab(Hooks.getDriver(), tabName, "");

            //Allow pkadmin to enter charges well before today
            NavBar.selectNavigationTab(Hooks.getDriver(), tabName, "Preferences");
            Page.selectDropDownInPane(Hooks.getDriver(), tabName, "Charge Capture", "EditUserSettings");
            Page.setTextBox(Hooks.getDriver(), tabName, "100", "#ofDaysBeforeTodaytoAllowSettingtheServiceDate");
            Page.clickButton(Hooks.getDriver(), tabName, "Save");
            SeleniumFunctions.handleAlert(Hooks.getDriver(), "OK");

            //Set up user
            NavBar.selectNavigationTab(Hooks.getDriver(), tabName, "User");

            //Check if lnolan exists
            int userPresentCnt = 0;
            while (!AdminPage.userExists(Hooks.getDriver(), "lnolan")){
                userPresentCnt++;
                Page.clickButton(Hooks.getDriver(), tabName, "CreateUser");
                Page.setTextBox(Hooks.getDriver(), tabName, "Lisa", "FirstName");
                Page.setTextBox(Hooks.getDriver(), tabName, "Nolan", "LastName");
                Page.setTextBox(Hooks.getDriver(), tabName, "lnolan", "Username");
                Page.setTextBox(Hooks.getDriver(), tabName, "123", "Password");
                Page.setTextBox(Hooks.getDriver(), tabName, "123", "VerifyPassword");
                Page.clickButton(Hooks.getDriver(), tabName, "CreateUserSave");
                SeleniumFunctions.selectFrame(Hooks.getDriver(),
                        UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(tabName, "", "",
                                "", "FRAME_DIALOG", ""), "id");
                if (Page.checkElementOnPagePresent(Hooks.getDriver(), tabName, "OK", "BUTTONS",
                        "Information")){
                    Page.clickButton(Hooks.getDriver(), tabName, "OK", "Information");
                    break;
                }
                else{
                    if (userPresentCnt >= GlobalConstants.FIVE)
                        break;
                }
            }

            //Set user permissions
            AdminPage.selectUserByUsername(Hooks.getDriver(), "lnolan");
            Page.clickButton(Hooks.getDriver(), tabName, "Edit", "QuickDetails");
            //Patient List
            Page.selectDropDownInPane(Hooks.getDriver(), tabName, "Patient List", "EditUserSettings");
            Page.setRadioValue(Hooks.getDriver(), tabName, "true", "CanAccessPatientListontheWeb");
            Page.selectDropDownInPane(Hooks.getDriver(), tabName, "No Restriction", "RestrictPatientLookupto");
            Page.selectDropDownInPane(Hooks.getDriver(), tabName, "All Users", "CanSendPatientsto");
            Page.setRadioValue(Hooks.getDriver(), tabName, "true", "CanReceivePatients");
            Page.selectDropDownInPane(Hooks.getDriver(), tabName, "Interested Party",
                    "Defaultrelationshipforpatientssentbyotherusers");
            Page.selectDropDownInPane(Hooks.getDriver(), tabName, "All Users", "CanGetPatientsfrom");
            //Charge Capture
            Page.selectDropDownInPane(Hooks.getDriver(), tabName, "Charge Capture", "EditUserSettings");
            Page.setRadioValue(Hooks.getDriver(), tabName, "true", "Canaddeditchargesontheweb");
            Page.selectDropDownInPane(Hooks.getDriver(), tabName, "Never", "CopyDiagnoseswhenCreatingaNewTransaction");
            Page.selectDropDownInPane(Hooks.getDriver(), tabName, "All Charges", "ChargeDesktopViewAccess");
            Page.selectDropDownInPane(Hooks.getDriver(), tabName, "All Charges", "PatientListChargeViewAccess");
            //Save
            Page.clickButton(Hooks.getDriver(), tabName, "Save");
            SeleniumFunctions.handleAlert(Hooks.getDriver(), "OK");
            //Roles
            Page.selectDropDownInPane(Hooks.getDriver(), tabName, "Provider Info", "EditUserSettings");
            Page.clickButton(Hooks.getDriver(), tabName, "EditProviderInfo");
            Page.setCheckBox(Hooks.getDriver(), tabName, "Biller", "check", null);
            Page.clickButton(Hooks.getDriver(), tabName, "Save", "ChargeTransactionContent");
            SeleniumFunctions.selectFrame(Hooks.getDriver(),
                    UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(tabName, "", "",
                            "", "FRAME_TOP", ""), "id");
            Page.clickLinkText(Hooks.getDriver(), "Return to Choose Users");

            //Set up department
            NavBar.selectNavigationTab(Hooks.getDriver(), tabName, "Department");
            if (AdminPage.findDepartmentItem(Hooks.getDriver(), "CodeEditTest") != null){
                AdminPage.selectDepartmentItem(Hooks.getDriver(), "CodeEditTest");
                Page.clickButton(Hooks.getDriver(), tabName, "Edit", "QuickDetails");
            }
            else{
                Page.clickButton(Hooks.getDriver(), tabName, "NewDepartment");
                Page.setTextBox(Hooks.getDriver(), tabName, "CodeEditTest", "DepartmentName");
                Page.setTextBox(Hooks.getDriver(), tabName, "CodeEditTest", "DepartmentLabel");
                Page.setRadioValue(Hooks.getDriver(), tabName, "false", "Sign-out");
                Page.clickButton(Hooks.getDriver(), tabName, "Save");
                SeleniumFunctions.handleAlert(Hooks.getDriver(), "OK");
            }

            //Add pkadmin and lnolan
            Page.clickLinkText(Hooks.getDriver(), tabName, "Users",
                    "DepartmentChargeCaptureSettings", "", null);
            Page.clickButton(Hooks.getDriver(), tabName, "Search", "QuickDetails");
            Page.setTextBox(Hooks.getDriver(), tabName, "pkadmin", "SearchForUser");
            Page.clickButton(Hooks.getDriver(), tabName, "Search");
            Page.setCheckBox(Hooks.getDriver(), tabName, "element100;name", "check",
                    "DepartmentChargeCaptureSettings");
            Page.clickButton(Hooks.getDriver(), tabName, "Search", "QuickDetails");
            Page.setTextBox(Hooks.getDriver(), tabName, "lnolan", "SearchForUser");
            Page.clickButton(Hooks.getDriver(), tabName, "Search");
            String boxPath = "parent::td[following-sibling::td[text()='lnolan']];xpath";
            Page.setCheckBox(Hooks.getDriver(), tabName, boxPath, "check",
                    "DepartmentChargeCaptureSettings");
            Page.clickButton(Hooks.getDriver(), tabName, "Save", "QuickDetails");

            //Charge capture settings
            Page.selectDropDownInPane(Hooks.getDriver(), tabName, "Charge Capture",
                    "EditDepartmentSettings");
            SeleniumFunctions.selectFrame(Hooks.getDriver(),
                    UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(tabName, "", "",
                            "", "FRAME_DEPT_MAIN", ""), "id");
            Page.clickLinkText(Hooks.getDriver(), tabName, "Billing Areas",
                    "DepartmentChargeCaptureSettings", "", null);
            SeleniumFunctions.selectFrame(Hooks.getDriver(),
                    UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(tabName, "", "",
                            "", "FRAME_MAIN", ""), "id");

            if (AdminPage.findDepartmentItem(Hooks.getDriver(), "CodeEditTest") == null){
                Page.clickButton(Hooks.getDriver(), tabName, "NewBillingArea");
                Page.setTextBox(Hooks.getDriver(), tabName, "CET", "BillingAreaID");
                Page.setTextBox(Hooks.getDriver(), tabName, "CodeEditTest", "BillingAreaName");
                Page.setTextBox(Hooks.getDriver(), tabName, "CodeEditTest", "BillingAreaAbbreviatedName");
                Page.setTextBox(Hooks.getDriver(), tabName, "CodeEditTest", "BillingAreaAliases");
                Page.clickButton(Hooks.getDriver(), tabName, "Save", "MainFramePane");
                SeleniumFunctions.handleAlert(Hooks.getDriver(), "OK");
            }
            SeleniumFunctions.selectFrame(Hooks.getDriver(),
                    UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(tabName, "", "",
                            "", "FRAME_DEPT_TOP", ""), "id");
            Page.clickLinkText(Hooks.getDriver(), "Return to Charge Capture Settings");
            //CPT-CPT setting
            Page.setRadioValue(Hooks.getDriver(), tabName, "true", "ApplyCPTCPTcodeedits");
            //Save
            Page.clickButton(Hooks.getDriver(), tabName, "Save");
            SeleniumFunctions.handleAlert(Hooks.getDriver(), "OK");
            SeleniumFunctions.selectFrame(Hooks.getDriver(),
                    UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(tabName, "", "",
                            "", "FRAME_TOP", ""), "id");
            Page.clickLinkText(Hooks.getDriver(), "Return to Choose Departments");

            //Closing the browser
            Hooks.closeBrowser();
            UtilFunctions.log("Code edits setUp successful.");
        }
        catch (Exception e){
            UtilFunctions.log("Code edits setUp not successful. Skipping setUp. Reason for exception: " +
                    e.getMessage());
        }
        // Enabling Code Edits
        DBExecutor dbExecutor = new DBExecutor();
        try {
            UtilFunctions.log("Enabling all code edits on server.");
            dbExecutor.executeQuery("update PK_CODEEDIT set ACTIVE = '1'");
            dbExecutor.executeQuery("commit");
            UtilFunctions.log("All Code Edits successfully enabled");
        } catch (Exception e) {
            UtilFunctions.log("Enable All Code Edits failed.  Reason for exception: " + e.getMessage());
        }
    }

    public static void deInitialize() {
        UtilFunctions.log("Class: " + codeEdits.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        // Disabling Code Edits
        DBExecutor dbExecutor = new DBExecutor();
        try {
            UtilFunctions.log("Disabling all code edits on server.");
            dbExecutor.executeQuery("update PK_CODEEDIT set ACTIVE = '0'");
            dbExecutor.executeQuery("commit");
            UtilFunctions.log("All Code Edits successfully disabled");
        }
        catch (Exception e){
            UtilFunctions.log("Disable All Code Edits failed.  Reason for exception: " + e.getMessage());
        }
    }
}
