package infra.setUp;

import common.SeleniumFunctions;
import constants.GlobalConstants;
import features.Hooks;
import pageObject.AdminPage;
import support.NavBar;
import support.Page;
import utils.UtilFunctions;
import utils.UtilProperty;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * Created by PatientKeeper on 09/12/2017.
 */
public class PatientChargeStatus {

    public String className = getClass().getSimpleName();
    private static PatientChargeStatus patientChargeStatus = new PatientChargeStatus();

    private static List<HashMap<String, String>> userList = new ArrayList<>();


    public static void initialize() {
        UtilFunctions.log("Class: " + patientChargeStatus.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        //Set User values
        userList.add(new HashMap<String, String>()
        {{
            put("id", "8885001");
            put("firstName", "JANE");
            put("lastName", "SMITH");
            put("userName", "SmithPCS");
            put("password", "123");
        }});
        userList.add(new HashMap<String, String>()
        {{
            put("id", "8885003");
            put("firstName", "JUDY");
            put("lastName", "JONES");
            put("userName", "JonesPCS");
            put("password", "123");
        }});
        userList.add(new HashMap<String, String>()
        {{
            put("id", "8885002");
            put("firstName", "LISA");
            put("lastName", "MICHAELS");
            put("userName", "MichaelsPCS");
            put("password", "123");
        }});

        String tabName = "Admin";

        try {
            Hooks.openBrowser(UtilProperty.userName, null);

            NavBar.selectNavigationTab(Hooks.getDriver(), tabName, "");
            NavBar.selectNavigationTab(Hooks.getDriver(), tabName, "User");

            for (HashMap<String, String> userMap : userList) {
//                Page.clickButton(Hooks.getDriver(), tabName, "Search", "QuickDetails");
//                Page.setTextBox(Hooks.getDriver(), tabName, userMap.get("userName"), "SearchForUser");
//                Page.clickButton(Hooks.getDriver(), tabName, "Search");
                if (!AdminPage.userExists(Hooks.getDriver(), userMap.get("userName"))){
                    Page.clickButton(Hooks.getDriver(), tabName, "CreateUserFromProvider");
                    Page.setTextBox(Hooks.getDriver(), tabName, userMap.get("id"), "ProviderNameIDAlias", "UserFromProviderMain");
                    Page.clickButton(Hooks.getDriver(), tabName, "Search", "UserFromProviderMain");
                    Page.getTableRows(Hooks.getDriver(), tabName, "UserProviderSearchResults").get(0).click();
                    SeleniumFunctions.selectFrame(Hooks.getDriver(), UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(tabName, "", "", "", "FRAME_USERFROMPROVIDER_DETAILS", ""), "id");
                    String providerID = SeleniumFunctions.findElement(Hooks.getDriver(),
                            SeleniumFunctions.setByValues(
                                    UtilFunctions.getElementStringAndType(UtilFunctions.getJSONFileObjBasedOnTabName(tabName), "TEXT_FIELDS" + "." + "ProviderID")[0] + ";" +
                                            UtilFunctions.getElementStringAndType(UtilFunctions.getJSONFileObjBasedOnTabName(tabName), "TEXT_FIELDS" + "." + "ProviderID")[1])).getText();
                    if (providerID.equals(userMap.get("id"))){
                        Page.setTextBox(Hooks.getDriver(), tabName, userMap.get("userName"), "ProviderUsername");
                        Page.setCheckBox(Hooks.getDriver(), tabName, "isMultiAuthUser;id", "check", "UserFromProviderDetail");
                        Page.setTextBox(Hooks.getDriver(), tabName, userMap.get("password"), "ProviderPassword");
                        Page.setTextBox(Hooks.getDriver(), tabName, userMap.get("password"), "ProviderConfirmPassword");
                        Page.clickButton(Hooks.getDriver(), tabName, "ProviderCreateUser");
                        SeleniumFunctions.selectFrame(Hooks.getDriver(), UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(tabName, "", "", "", "FRAME_DIALOG", ""), "id");
                        SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.TEN,
                                        UtilFunctions.getElementStringAndType(UtilFunctions.getJSONFileObjBasedOnTabName(tabName), "BUTTONS" + "." + "OK")[0] + ";" +
                                                UtilFunctions.getElementStringAndType(UtilFunctions.getJSONFileObjBasedOnTabName(tabName), "BUTTONS" + "." + "OK")[1]);
                        SeleniumFunctions.findElement(Hooks.getDriver(),
                                SeleniumFunctions.setByValues(
                                        UtilFunctions.getElementStringAndType(UtilFunctions.getJSONFileObjBasedOnTabName(tabName), "BUTTONS" + "." + "OK")[0] + ";" +
                                                UtilFunctions.getElementStringAndType(UtilFunctions.getJSONFileObjBasedOnTabName(tabName), "BUTTONS" + "." + "OK")[1])).click();
                    }
                    Page.clickButton(Hooks.getDriver(), tabName, "Close", "CreateUser");
                }
            }

//            Page.clickButton(Hooks.getDriver(), tabName, "Search", "QuickDetails");
//            Page.setTextBox(Hooks.getDriver(), tabName, "AdminPCS", "SearchForUser");
//            Page.clickButton(Hooks.getDriver(), tabName, "Search");
            if (!AdminPage.userExists(Hooks.getDriver(), "AdminPCS")){
                Page.clickButton(Hooks.getDriver(), tabName, "CreateUser");
                Page.setTextBox(Hooks.getDriver(), tabName, "PCS", "FirstName");
                Page.setTextBox(Hooks.getDriver(), tabName, "ADMIN", "LastName");
                Page.setTextBox(Hooks.getDriver(), tabName, "AdminPCS", "Username");
                Page.setCheckBox(Hooks.getDriver(), tabName, "isMAU;id", "check", "CreateUserPopUp");
                Page.setTextBox(Hooks.getDriver(), tabName, "123", "Password");
                Page.setTextBox(Hooks.getDriver(), tabName, "123", "VerifyPassword");
                Page.clickButton(Hooks.getDriver(), tabName, "CreateUserSave");
                SeleniumFunctions.selectFrame(Hooks.getDriver(), UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(tabName, "", "", "", "FRAME_DIALOG", ""), "id");
//                SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.TEN,
//                        UtilFunctions.getElementStringAndType(UtilFunctions.getJSONFileObjBasedOnTabName(tabName), "BUTTONS" + "." + "OK")[0] + ";" +
//                                UtilFunctions.getElementStringAndType(UtilFunctions.getJSONFileObjBasedOnTabName(tabName), "BUTTONS" + "." + "OK")[1]);
//                SeleniumFunctions.findElement(Hooks.getDriver(),
//                        SeleniumFunctions.setByValues(
//                                UtilFunctions.getElementStringAndType(UtilFunctions.getJSONFileObjBasedOnTabName(tabName), "BUTTONS" + "." + "OK")[0] + ";" +
//                                        UtilFunctions.getElementStringAndType(UtilFunctions.getJSONFileObjBasedOnTabName(tabName), "BUTTONS" + "." + "OK")[1])).click();
            }

            //Set charge access for users
            Page.clickButton(Hooks.getDriver(), tabName, "Search", "QuickDetails");
            Page.setTextBox(Hooks.getDriver(), tabName, "SmithPCS", "SearchForUser");
            Page.clickButton(Hooks.getDriver(), tabName, "Search");
            AdminPage.selectUserByUsername(Hooks.getDriver(), "SmithPCS");
            Page.clickButton(Hooks.getDriver(), tabName, "Edit", "QuickDetails");
            Page.selectDropDownInPane(Hooks.getDriver(), tabName, "General", "EditUserSettings");
            Page.selectDropDownInPane(Hooks.getDriver(), tabName, "Level 3", "PatAccess");
            Page.clickButton(Hooks.getDriver(), tabName, "InformationOK");
            Page.selectDropDownInPane(Hooks.getDriver(), tabName, "Charge Capture", "EditUserSettings");
            Page.selectDropDownInPane(Hooks.getDriver(), tabName, "Within the User's Department", "ChargeDesktopViewAccess");
            Page.selectDropDownInPane(Hooks.getDriver(), tabName, "User Permissions", "EditUserSettings");
            Page.setRadioValue(Hooks.getDriver(), tabName, "true", "Web-User");
            Page.clickButton(Hooks.getDriver(), tabName, "Save");
            SeleniumFunctions.handleAlert(Hooks.getDriver(), "OK");
            SeleniumFunctions.selectFrame(Hooks.getDriver(), UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(tabName, "", "", "", "FRAME_TOP", ""), "id");
            Page.clickLinkText(Hooks.getDriver(), "Return to Choose Users");

            Page.clickButton(Hooks.getDriver(), tabName, "Search", "QuickDetails");
            Page.setTextBox(Hooks.getDriver(), tabName, "JonesPCS", "SearchForUser");
            Page.clickButton(Hooks.getDriver(), tabName, "Search");
            AdminPage.selectUserByUsername(Hooks.getDriver(), "JonesPCS");
            Page.clickButton(Hooks.getDriver(), tabName, "Edit", "QuickDetails");
            Page.selectDropDownInPane(Hooks.getDriver(), tabName, "General", "EditUserSettings");
            Page.selectDropDownInPane(Hooks.getDriver(), tabName, "Level 3", "PatAccess");
            Page.clickButton(Hooks.getDriver(), tabName, "InformationOK");
            Page.selectDropDownInPane(Hooks.getDriver(), tabName, "Charge Capture", "EditUserSettings");
            Page.selectDropDownInPane(Hooks.getDriver(), tabName, "No Charges", "ChargeDesktopViewAccess");
            Page.selectDropDownInPane(Hooks.getDriver(), tabName, "User Permissions", "EditUserSettings");
            Page.setRadioValue(Hooks.getDriver(), tabName, "true", "Web-User");
            Page.clickButton(Hooks.getDriver(), tabName, "Save");
            SeleniumFunctions.handleAlert(Hooks.getDriver(), "OK");
            SeleniumFunctions.selectFrame(Hooks.getDriver(), UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(tabName, "", "", "", "FRAME_TOP", ""), "id");
            Page.clickLinkText(Hooks.getDriver(), "Return to Choose Users");

            Page.clickButton(Hooks.getDriver(), tabName, "Search", "QuickDetails");
            Page.setTextBox(Hooks.getDriver(), tabName, "MichaelsPCS", "SearchForUser");
            Page.clickButton(Hooks.getDriver(), tabName, "Search");
            AdminPage.selectUserByUsername(Hooks.getDriver(), "MichaelsPCS");
            Page.clickButton(Hooks.getDriver(), tabName, "Edit", "QuickDetails");
            Page.selectDropDownInPane(Hooks.getDriver(), tabName, "General", "EditUserSettings");
            Page.selectDropDownInPane(Hooks.getDriver(), tabName, "Level 2", "PatAccess");
            Page.clickButton(Hooks.getDriver(), tabName, "InformationOK");
            Page.selectDropDownInPane(Hooks.getDriver(), tabName, "Charge Capture", "EditUserSettings");
            Page.selectDropDownInPane(Hooks.getDriver(), tabName, "Within the User's Department", "ChargeDesktopViewAccess");
            Page.selectDropDownInPane(Hooks.getDriver(), tabName, "User Permissions", "EditUserSettings");
            Page.setRadioValue(Hooks.getDriver(), tabName, "true", "Web-User");
            Page.clickButton(Hooks.getDriver(), tabName, "Save");
            SeleniumFunctions.handleAlert(Hooks.getDriver(), "OK");
            SeleniumFunctions.selectFrame(Hooks.getDriver(), UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(tabName, "", "", "", "FRAME_TOP", ""), "id");
            Page.clickLinkText(Hooks.getDriver(), "Return to Choose Users");

            Page.clickButton(Hooks.getDriver(), tabName, "Search", "QuickDetails");
            Page.setTextBox(Hooks.getDriver(), tabName, "AdminPCS", "SearchForUser");
            Page.clickButton(Hooks.getDriver(), tabName, "Search");
            AdminPage.selectUserByUsername(Hooks.getDriver(), "AdminPCS");
            Page.clickButton(Hooks.getDriver(), tabName, "Edit", "QuickDetails");
            Page.selectDropDownInPane(Hooks.getDriver(), tabName, "General", "EditUserSettings");
            Page.selectDropDownInPane(Hooks.getDriver(), tabName, "Level 1", "PatAccess");
            Page.clickButton(Hooks.getDriver(), tabName, "InformationOK");
            Page.selectDropDownInPane(Hooks.getDriver(), tabName, "Charge Capture", "EditUserSettings");
            Page.selectDropDownInPane(Hooks.getDriver(), tabName, "All Charges", "ChargeDesktopViewAccess");
            Page.selectDropDownInPane(Hooks.getDriver(), tabName, "User Permissions", "EditUserSettings");
            Page.setRadioValue(Hooks.getDriver(), tabName, "true", "Web-User");
            Page.clickButton(Hooks.getDriver(), tabName, "Save");
            SeleniumFunctions.handleAlert(Hooks.getDriver(), "OK");
            SeleniumFunctions.selectFrame(Hooks.getDriver(), UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(tabName, "", "", "", "FRAME_TOP", ""), "id");
            Page.clickLinkText(Hooks.getDriver(), "Return to Choose Users");


            //Create departments
            NavBar.selectNavigationTab(Hooks.getDriver(), tabName, "Department");
            String[] createDepartments = {"PCSDepartmentA","PCSDepartmentB","PCSDepartmentC","PCSDepartmentD"};
            for (String department : createDepartments){
                if (AdminPage.findDepartmentItem(Hooks.getDriver(), department) == null){
                    Page.clickButton(Hooks.getDriver(), tabName, "NewDepartment");
                    Page.setTextBox(Hooks.getDriver(), tabName, department, "DepartmentName");
                    Page.setTextBox(Hooks.getDriver(), tabName, department, "DepartmentLabel");
                    Page.setRadioValue(Hooks.getDriver(), tabName, "true", "Sign-out");
                    Page.clickButton(Hooks.getDriver(), tabName, "Save");
                    SeleniumFunctions.handleAlert(Hooks.getDriver(), "OK");
                    SeleniumFunctions.selectFrame(Hooks.getDriver(), UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(tabName, "", "", "", "FRAME_TOP", ""), "id");
                    Page.clickLinkText(Hooks.getDriver(), "Return to Choose Departments");
                }
            }


            //Add users to departments
            //Department A
            String[] addUsersA = {"SmithPCS","MichaelsPCS","AdminPCS"};
            AdminPage.selectDepartmentItem(Hooks.getDriver(), "PCSDepartmentA");
            Page.clickButton(Hooks.getDriver(), tabName, "Edit", "QuickDetails");
            for (String user : addUsersA){
                if (!AdminPage.userInDeptUserListExists(Hooks.getDriver(), user)){

                    //Page.clickLinkText(Hooks.getDriver(), "Edit");
                    Page.findLinkText(Hooks.getDriver(), "Edit", "a", "td[@class='tableTdContent']").click();

                    Page.clickButton(Hooks.getDriver(), tabName, "Search", "QuickDetails");
                    Page.setTextBox(Hooks.getDriver(), tabName, user, "SearchForUser");
                    Page.clickButton(Hooks.getDriver(), tabName, "Search");
                    String boxPath = "parent::td[following-sibling::td[text()= '" + user + "']]";
                    Page.setCheckBox(Hooks.getDriver(), tabName, boxPath + ";xpath", "check", "DepartmentChargeCaptureSettings");
                    Page.clickButton(Hooks.getDriver(), tabName, "Save", "QuickDetails");
                }
            }
            //Add billing area to Department A
            Page.selectDropDownInPane(Hooks.getDriver(), tabName, "Charge Capture", "EditDepartmentSettings");
            SeleniumFunctions.selectFrame(Hooks.getDriver(), UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(tabName, "", "", "", "FRAME_DEPT_MAIN", ""), "id");

            //Page.clickLinkText(Hooks.getDriver(), "Edit");
            Page.findLinkText(Hooks.getDriver(), "Edit", "a", "td[@class='tableTdContent']/span[contains(text(), 'Configure Billing Areas')]").click();

            String billingArea = "PCS Billing Area 1A";
            String billingID = "PCS-1A";
            if (AdminPage.findDepartmentItem(Hooks.getDriver(), billingArea) == null){
                Page.clickButton(Hooks.getDriver(), tabName, "NewBillingArea");
                Page.setTextBox(Hooks.getDriver(), tabName, billingID, "BillingAreaID");
                Page.setTextBox(Hooks.getDriver(), tabName, billingArea, "BillingAreaName");
                Page.setTextBox(Hooks.getDriver(), tabName, billingArea, "BillingAreaAbbreviatedName");
                Page.setTextBox(Hooks.getDriver(), tabName, billingArea, "BillingAreaAliases");
                Page.clickButton(Hooks.getDriver(), tabName, "Save", "MainFramePane");
                SeleniumFunctions.handleAlert(Hooks.getDriver(), "OK");
            }
            SeleniumFunctions.selectFrame(Hooks.getDriver(), UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(tabName, "", "", "", "FRAME_DEPT_TOP", ""), "id");
            Page.clickLinkText(Hooks.getDriver(), "Return to Charge Capture Settings");
            Page.clickButton(Hooks.getDriver(), tabName, "Save");
            SeleniumFunctions.handleAlert(Hooks.getDriver(), "OK");
            SeleniumFunctions.selectFrame(Hooks.getDriver(), UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(tabName, "", "", "", "FRAME_TOP", ""), "id");
            Page.clickLinkText(Hooks.getDriver(), "Return to Choose Departments");

            //Department B
            String[] addUsersB = {"SmithPCS","JonesPCS","AdminPCS"};
            AdminPage.selectDepartmentItem(Hooks.getDriver(), "PCSDepartmentB");
            Page.clickButton(Hooks.getDriver(), tabName, "Edit", "QuickDetails");
            for (String user : addUsersB){
                if (!AdminPage.userInDeptUserListExists(Hooks.getDriver(), user)){

                    //Page.clickLinkText(Hooks.getDriver(), "Edit");
                    Page.findLinkText(Hooks.getDriver(), "Edit", "a", "td[@class='tableTdContent']").click();

                    Page.clickButton(Hooks.getDriver(), tabName, "Search", "QuickDetails");
                    Page.setTextBox(Hooks.getDriver(), tabName, user, "SearchForUser");
                    Page.clickButton(Hooks.getDriver(), tabName, "Search");
                    String boxPath = "parent::td[following-sibling::td[text()= '" + user + "']]";
                    Page.setCheckBox(Hooks.getDriver(), tabName, boxPath + ";xpath", "check", "DepartmentChargeCaptureSettings");
                    Page.clickButton(Hooks.getDriver(), tabName, "Save", "QuickDetails");
                }
            }
            //Add billing area to Department B
            Page.selectDropDownInPane(Hooks.getDriver(), tabName, "Charge Capture", "EditDepartmentSettings");
            SeleniumFunctions.selectFrame(Hooks.getDriver(), UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(tabName, "", "", "", "FRAME_DEPT_MAIN", ""), "id");

            //Page.clickLinkText(Hooks.getDriver(), "Edit");
            Page.findLinkText(Hooks.getDriver(), "Edit", "a", "td[@class='tableTdContent']/span[contains(text(), 'Configure Billing Areas')]").click();

            billingArea = "PCS Billing Area 1B";
            billingID = "PCS-1B";
            if (AdminPage.findDepartmentItem(Hooks.getDriver(), billingArea) == null){
                Page.clickButton(Hooks.getDriver(), tabName, "NewBillingArea");
                Page.setTextBox(Hooks.getDriver(), tabName, billingID, "BillingAreaID");
                Page.setTextBox(Hooks.getDriver(), tabName, billingArea, "BillingAreaName");
                Page.setTextBox(Hooks.getDriver(), tabName, billingArea, "BillingAreaAbbreviatedName");
                Page.clickButton(Hooks.getDriver(), tabName, "Save", "MainFramePane");
                SeleniumFunctions.handleAlert(Hooks.getDriver(), "OK");
            }
            billingArea = "PCS Billing Area 2B";
            billingID = "PCS-2B";
            if (AdminPage.findDepartmentItem(Hooks.getDriver(), billingArea) == null){
                Page.clickButton(Hooks.getDriver(), tabName, "NewBillingArea");
                Page.setTextBox(Hooks.getDriver(), tabName, billingID, "BillingAreaID");
                Page.setTextBox(Hooks.getDriver(), tabName, billingArea, "BillingAreaName");
                Page.setTextBox(Hooks.getDriver(), tabName, billingArea, "BillingAreaAbbreviatedName");
                Page.clickButton(Hooks.getDriver(), tabName, "Save", "MainFramePane");
                SeleniumFunctions.handleAlert(Hooks.getDriver(), "OK");
            }
            SeleniumFunctions.selectFrame(Hooks.getDriver(), UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(tabName, "", "", "", "FRAME_DEPT_TOP", ""), "id");
            Page.clickLinkText(Hooks.getDriver(), "Return to Charge Capture Settings");
            Page.clickButton(Hooks.getDriver(), tabName, "Save");
            SeleniumFunctions.handleAlert(Hooks.getDriver(), "OK");
            SeleniumFunctions.selectFrame(Hooks.getDriver(), UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(tabName, "", "", "", "FRAME_TOP", ""), "id");
            Page.clickLinkText(Hooks.getDriver(), "Return to Choose Departments");

            //Department C
            String[] addUsersC = {"SmithPCS","AdminPCS"};
            AdminPage.selectDepartmentItem(Hooks.getDriver(), "PCSDepartmentC");
            Page.clickButton(Hooks.getDriver(), tabName, "Edit", "QuickDetails");
            for (String user : addUsersC){
                if (!AdminPage.userInDeptUserListExists(Hooks.getDriver(), user)){

                    //Page.clickLinkText(Hooks.getDriver(), "Edit");
                    Page.findLinkText(Hooks.getDriver(), "Edit", "a", "td[@class='tableTdContent']").click();

                    Page.clickButton(Hooks.getDriver(), tabName, "Search", "QuickDetails");
                    Page.setTextBox(Hooks.getDriver(), tabName, user, "SearchForUser");
                    Page.clickButton(Hooks.getDriver(), tabName, "Search");
                    String boxPath = "parent::td[following-sibling::td[text()= '" + user + "']]";
                    Page.setCheckBox(Hooks.getDriver(), tabName, boxPath + ";xpath", "check", "DepartmentChargeCaptureSettings");
                    Page.clickButton(Hooks.getDriver(), tabName, "Save", "QuickDetails");
                }
            }
            //Add billing area to Department C
            Page.selectDropDownInPane(Hooks.getDriver(), tabName, "Charge Capture", "EditDepartmentSettings");
            SeleniumFunctions.selectFrame(Hooks.getDriver(), UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(tabName, "", "", "", "FRAME_DEPT_MAIN", ""), "id");

            //Page.clickLinkText(Hooks.getDriver(), "Edit");
            Page.findLinkText(Hooks.getDriver(), "Edit", "a", "td[@class='tableTdContent']/span[contains(text(), 'Configure Billing Areas')]").click();

            billingArea = "PCS Billing Area C1";
            billingID = "PCS-1C";
            if (AdminPage.findDepartmentItem(Hooks.getDriver(), billingArea) == null){
                Page.clickButton(Hooks.getDriver(), tabName, "NewBillingArea");
                Page.setTextBox(Hooks.getDriver(), tabName, billingID, "BillingAreaID");
                Page.setTextBox(Hooks.getDriver(), tabName, billingArea, "BillingAreaName");
                Page.setTextBox(Hooks.getDriver(), tabName, billingArea, "BillingAreaAbbreviatedName");
                Page.clickButton(Hooks.getDriver(), tabName, "Save", "MainFramePane");
                SeleniumFunctions.handleAlert(Hooks.getDriver(), "OK");
            }
            SeleniumFunctions.selectFrame(Hooks.getDriver(), UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(tabName, "", "", "", "FRAME_DEPT_TOP", ""), "id");
            Page.clickLinkText(Hooks.getDriver(), "Return to Charge Capture Settings");
            Page.clickButton(Hooks.getDriver(), tabName, "Save");
            SeleniumFunctions.handleAlert(Hooks.getDriver(), "OK");
            SeleniumFunctions.selectFrame(Hooks.getDriver(), UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(tabName, "", "", "", "FRAME_TOP", ""), "id");
            Page.clickLinkText(Hooks.getDriver(), "Return to Choose Departments");

            //Department D
            String[] addUsersD = {"MichaelsPCS","AdminPCS"};
            AdminPage.selectDepartmentItem(Hooks.getDriver(), "PCSDepartmentD");
            Page.clickButton(Hooks.getDriver(), tabName, "Edit", "QuickDetails");
            for (String user : addUsersD){
                if (!AdminPage.userInDeptUserListExists(Hooks.getDriver(), user)){

                    //Page.clickLinkText(Hooks.getDriver(), "Edit");
                    Page.findLinkText(Hooks.getDriver(), "Edit", "a", "td[@class='tableTdContent']").click();

                    Page.clickButton(Hooks.getDriver(), tabName, "Search", "QuickDetails");
                    Page.setTextBox(Hooks.getDriver(), tabName, user, "SearchForUser");
                    Page.clickButton(Hooks.getDriver(), tabName, "Search");
                    String boxPath = "parent::td[following-sibling::td[text()= '" + user + "']]";
                    Page.setCheckBox(Hooks.getDriver(), tabName, boxPath + ";xpath", "check", "DepartmentChargeCaptureSettings");
                    Page.clickButton(Hooks.getDriver(), tabName, "Save", "QuickDetails");
                }
            }
            //Add billing area to Department D
            Page.selectDropDownInPane(Hooks.getDriver(), tabName, "Charge Capture", "EditDepartmentSettings");
            SeleniumFunctions.selectFrame(Hooks.getDriver(), UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(tabName, "", "", "", "FRAME_DEPT_MAIN", ""), "id");

            //Page.clickLinkText(Hooks.getDriver(), "Edit");
            Page.findLinkText(Hooks.getDriver(), "Edit", "a", "td[@class='tableTdContent']/span[contains(text(), 'Configure Billing Areas')]").click();

            billingArea = "PCS Billing Area 1D";
            billingID = "PCS-1D";
            if (AdminPage.findDepartmentItem(Hooks.getDriver(), billingArea) == null){
                Page.clickButton(Hooks.getDriver(), tabName, "NewBillingArea");
                Page.setTextBox(Hooks.getDriver(), tabName, billingID, "BillingAreaID");
                Page.setTextBox(Hooks.getDriver(), tabName, billingArea, "BillingAreaName");
                Page.setTextBox(Hooks.getDriver(), tabName, billingArea, "BillingAreaAbbreviatedName");
                Page.clickButton(Hooks.getDriver(), tabName, "Save", "MainFramePane");
                SeleniumFunctions.handleAlert(Hooks.getDriver(), "OK");
            }
            SeleniumFunctions.selectFrame(Hooks.getDriver(), UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(tabName, "", "", "", "FRAME_DEPT_TOP", ""), "id");
            Page.clickLinkText(Hooks.getDriver(), "Return to Charge Capture Settings");
            Page.clickButton(Hooks.getDriver(), tabName, "Save");
            SeleniumFunctions.handleAlert(Hooks.getDriver(), "OK");
            SeleniumFunctions.selectFrame(Hooks.getDriver(), UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(tabName, "", "", "", "FRAME_TOP", ""), "id");
            Page.clickLinkText(Hooks.getDriver(), "Return to Choose Departments");


            //Closing the browser
            Hooks.closeBrowser();
            UtilFunctions.log("Patient Charge Status setUp successful.");
        }
        catch (Exception e){
            UtilFunctions.log("Patient Charge Status setUp not successful. Skipping setUp. Reason for exception: " + e.getMessage());
        }
    }
}
