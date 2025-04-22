package infra.setUp;

import common.SeleniumFunctions;

import features.Hooks;

import pageObject.AdminPage;
import support.NavBar;
import support.Page;
import support.db.DBExecutor;
import utils.UtilFunctions;
import utils.UtilProperty;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * Created by offshore on 5/11/2017.
 */
public class PasswordTest {

    public String className = getClass().getSimpleName();
    private static PasswordTest passwordTest = new PasswordTest();

    private static List<HashMap<String, String>> userList = new ArrayList<>();

    public static void initialize() {
        UtilFunctions.log("Class: " + passwordTest.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        String tabName = "Admin";
        DBExecutor dbExecutor = new DBExecutor();

        try {
            dbExecutor.executeQuery("update PK_PKPERSONNEL p set p.webloginattempts = 0 where p.username in ('pwdtest','noadaccount','badpassword')");
            dbExecutor.executeQuery("commit");
            UtilFunctions.log("PK_PKPERSONNEL.webloginattempts reset successful.");

            Hooks.openBrowser(UtilProperty.userName, null);

            //Setup users
            userList.add(new HashMap<String, String>() {{
                put("firstName", "VERVEPASSWORD");
                put("lastName", "TEST");
                put("userName", "pwdtest");
            }});
            userList.add(new HashMap<String, String>() {{
                put("firstName", "VERVE");
                put("lastName", "NOAD");
                put("userName", "noadaccount");
            }});
            userList.add(new HashMap<String, String>() {{
                put("firstName", "BADPASSWORD");
                put("lastName", "TEST");
                put("userName", "badpassword");
                put("password", "123");
            }});

            NavBar.selectNavigationTab(Hooks.getDriver(), "Admin", "");
            NavBar.selectNavigationTab(Hooks.getDriver(), "Admin", "User");
            for (HashMap<String, String> userMap : userList) {
                if (!AdminPage.userExists(Hooks.getDriver(), userMap.get("userName"))) {
                    Page.clickButton(Hooks.getDriver(), "Admin", "CreateUser");
                    Page.setTextBox(Hooks.getDriver(), "Admin", userMap.get("firstName"), "FirstName");
                    Page.setTextBox(Hooks.getDriver(), "Admin", userMap.get("lastName"), "LastName");
                    Page.setTextBox(Hooks.getDriver(), "Admin", userMap.get("userName"), "Username");
                    if (!(userMap.get("password") == null)) {
                        Page.setCheckBox(Hooks.getDriver(), tabName, "isMAU;id", "check", "CreateUserPopUp");
                        Page.setTextBox(Hooks.getDriver(), tabName, userMap.get("password"), "Password");
                        Page.setTextBox(Hooks.getDriver(), tabName, userMap.get("password"), "VerifyPassword");
                    }
                    Page.clickButton(Hooks.getDriver(), "Admin", "CreateUserSave");
                    SeleniumFunctions.selectFrame(Hooks.getDriver(), UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName("Admin", "", "", "", "FRAME_DIALOG", ""), "id");
                }
            }

            UtilFunctions.log("Password Test users exist or were created.");

            NavBar.selectNavigationTab(Hooks.getDriver(), tabName, "");
            NavBar.selectNavigationTab(Hooks.getDriver(), tabName, "Institution");
            Page.selectDropDownInPane(Hooks.getDriver(), tabName, "Site Administration", "EditInstitutionSettings");

            Page.setTextBox(Hooks.getDriver(), tabName, "3", "MinimumPasswordlength");
            Page.setRadioValue(Hooks.getDriver(), tabName, "false", "Passwordsmustbemixedcase");
            Page.setRadioValue(Hooks.getDriver(), tabName, "false", "Passwordsmustincludeatleast1numberand1letter");

            Page.clickButton(Hooks.getDriver(), tabName, "Save");
            SeleniumFunctions.handleAlert(Hooks.getDriver(), "OK");
            Thread.sleep(Integer.parseInt("2") * 1000);

            Hooks.closeBrowser();
            UtilFunctions.log("Institution settings successful.");
        }
        catch (Exception e){
            UtilFunctions.log("Institution settings not successful. Skipping setUp. Reason for exception: " + e.getMessage());
        }
    }

    public static void deInitialize() {
        UtilFunctions.log("Class: " + passwordTest.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        String tabName = "Admin";

        try {
            Hooks.openBrowser(UtilProperty.userName, null);

            NavBar.selectNavigationTab(Hooks.getDriver(), tabName, "");
            NavBar.selectNavigationTab(Hooks.getDriver(), tabName, "Institution");
            Page.selectDropDownInPane(Hooks.getDriver(), tabName, "Site Administration", "EditInstitutionSettings");

            Page.setTextBox(Hooks.getDriver(), tabName, "3", "MinimumPasswordlength");
            Page.setRadioValue(Hooks.getDriver(), tabName, "false", "Passwordsmustbemixedcase");
            Page.setRadioValue(Hooks.getDriver(), tabName, "false", "Passwordsmustincludeatleast1numberand1letter");

            Page.clickButton(Hooks.getDriver(), tabName, "Save");
            SeleniumFunctions.handleAlert(Hooks.getDriver(), "OK");
            Thread.sleep(Integer.parseInt("2") * 1000);

            Hooks.closeBrowser();
            UtilFunctions.log("Reverting Institution settings successful.");
        }
        catch (Exception e){
            UtilFunctions.log("Reverting Institution settings not successful. Skipping tearDown. Reason for exception: " + e.getMessage());
        }
    }
}
