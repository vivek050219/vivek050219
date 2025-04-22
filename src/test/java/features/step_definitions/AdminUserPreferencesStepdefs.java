package features.step_definitions;

import constants.GlobalConstants;
import cucumber.api.DataTable;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import features.Hooks;
import org.junit.Assert;
import org.openqa.selenium.WebElement;
import pageObject.AdminPage;
import support.Page;
import utils.UtilFunctions;

/**
 * Created by PatientKeeper on 9/12/2016.
 */
public class AdminUserPreferencesStepdefs {
    public String className = getClass().getSimpleName();

    @When("^I search for the user \"(.*?)\"$")
    public void searchForUserInList(String userName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        GlobalStepdefs globalStepsObj = new GlobalStepdefs();
        globalStepsObj.clickButton("Search", "QuickDetails", null);

        Assert.assertTrue("Text box not found or value not set for the value: " + userName,
                Page.setTextBox(Hooks.getDriver(), "Admin", userName, "SearchForUser"));
        globalStepsObj.clickButton("Search", null, null);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @When("^I select the user \"(.*?)\"$")
    public void selectUserInList(String userName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        Assert.assertTrue("User object not found for the user: " + userName,
                AdminPage.selectUserByUsername(Hooks.getDriver(), userName));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Given("^the user \"(.*?)\" with username \"(.*?)\"(?: and password \"(.*?)\")? is( not)? in the user list$")
    public void addRemoveUser(String fullName, String username, String password, String not) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        //Use default password of "123" if password is not supplied
        if (password == null) {
            password = "123";
        }
        AdminPage.searchForUser(Hooks.getDriver(), username);
        WebElement userFound =  AdminPage.findUserByUsername(Hooks.getDriver(), username);
        //If user should exist
        if (not == null) {
            //but user doesn't exist
            if (userFound == null) {
                //then create user
                Page.clickButton(Hooks.getDriver(), "Admin", "Create User");
                Page.findPane(Hooks.getDriver(), "Admin", "Create User");
                //Fill out fields with tempUser details(name, username, etc.)
                String firstName = fullName.split(" ")[0];
                String lastName = fullName.split(" ")[1];
                AdminPage.createUser(Hooks.getDriver(), firstName, lastName, username, password);
                Page.clickButton(Hooks.getDriver(), "Admin", "Create User Save");
                Page.clickButton(Hooks.getDriver(), "Admin", "Yes", "Question");
            }
        } else {
            //If user shouldn't exist, but user does exist
            if (userFound != null) {
                //then delete user
                AdminPage.searchForUser(Hooks.getDriver(), username);
                AdminPage.selectUserByUsername(Hooks.getDriver(), username);
                Page.clickButton(Hooks.getDriver(), "Admin", "Delete", "Quick Details");
                Page.setCheckBox(Hooks.getDriver(),"Admin", "Delete Provider", "check", "Delete User");
                Page.clickButton(Hooks.getDriver(), "Admin", "Yes", "Delete User");
            }
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @Given("^I open \"(.*?)\" settings page for the user \"(.*?)\"$")
    public void navigateToSettingsPageForUser(String pageName, String userName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        /**************************************************************************
         * Following setps are performed by the below code:
            * And I select the "User" subtab
            * And I search for the user "#{userName}"
            * And I select the user "#{userName}"
            * And I click the "Edit" button in the "Quick Details" pane
            * And I select "#{pageName}" from the "Edit User Settings" dropdown in
              the "User Preferences" pane
         *************************************************************************/
        GlobalStepdefs globalStepsObj = new GlobalStepdefs();
        globalStepsObj.selectSubTab("User");
        searchForUserInList(userName);
        selectUserInList(userName);
        globalStepsObj.clickButton("Edit", "Quick Details", null);
        globalStepsObj.selectFromDropdown(pageName, "Edit User Settings", "User Preferences", null);
        /*************************************************************************/

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @When("^I edit the following user settings( and I click save)?$")
    public void editUserSettingsAndSave(String clickSave, DataTable dataTable) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        AdminPage.editUserSettings(Hooks.getDriver(), dataTable, clickSave);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @When("^I create a temporary user$")
    public void createTempUser() throws Throwable{
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        AdminPage.createUser(Hooks.getDriver(), GlobalConstants.tempUser.get("FirstName"), GlobalConstants.tempUser.get("LastName"), GlobalConstants.tempUser.get("Username"), GlobalConstants.tempUser.get("Password"));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @And("^I search for the temporary user$")
    public void searchForTempUser() throws Throwable{
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        searchForUserInList(GlobalConstants.tempUser.get("Username"));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @Then("^I select the temporary user$")
    public void selectTempUser() throws Throwable{
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        selectUserInList(GlobalConstants.tempUser.get("Username"));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @Given("^a temporary user is in the user list$")
    public void givenTempUserInList() throws Throwable{
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String fullName = GlobalConstants.tempUser.get("FirstName") + " " + GlobalConstants.tempUser.get("LastName");
        addRemoveUser(fullName, GlobalConstants.tempUser.get("Username"), GlobalConstants.tempUser.get("Password"), null);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^the temporary user should( not)? appear in the user list$")
    public void verifyTempUserInList(String not){
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String username = GlobalConstants.tempUser.get("Username");
        WebElement userFound =  AdminPage.findUserByUsername(Hooks.getDriver(), username);
        if (not == null){
            Assert.assertTrue("User not found: " + username, (userFound != null));
        } else {
            Assert.assertTrue("User found: " + username, (userFound == null));
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @When("^I launch the charge transaction headers for \"(.*?)\" user$")
    public void launchHeaderForUser(String userName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        /**************************************************************************
         * Following setps are performed by the below code:
            * And I am on the "Admin" tab
            * And I select the "User" subtab
            * And I search for the user "#{userName}"
            * And I select the user "#{userName}"
            * And I click the "Edit" button in the "Quick Details" pane
            * And I select "Charge Capture" from the "Edit User Settings"
              dropdown in the "User Preferences" pane
            * And I click the "Charge Transaction Headers" edit link in the
              "Charge Capture Settings" pane
         *************************************************************************/
        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        globalStepdefs.selectTab("Admin");
        globalStepdefs.selectSubTab("User");
        searchForUserInList(userName);
        selectUserInList(userName);
        globalStepdefs.clickButton("Edit", "Quick Details", null);
        globalStepdefs.selectFromDropdown("Charge Capture", "Edit User Settings", "User Preferences", null);
        AdminTabStepdefs adminTabStepdefs = new AdminTabStepdefs();
        adminTabStepdefs.clickEditLinkInPane("Add/Edit Charge Headers", null, "Charge Capture Settings");

        int editLinkCnt = 0;
        while(!Page.checkElementOnPagePresent(Hooks.getDriver(), GlobalStepdefs.curTabName, "ChargeTransactionHeaders", "TABLES")) {
            editLinkCnt++;
            adminTabStepdefs.clickEditLinkInPane("Add/Edit Charge Headers", null, "Charge Capture Settings");
            if (editLinkCnt > GlobalConstants.FIVE) {
                UtilFunctions.log("Error: Add/Edit Charge Headers Edit Link not clicked.");
                break;
            }
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }
    @When("^the user \"(.*?)\" should( not)? appear in the user list$")
    public void userExistInUserList(String userName, String not) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        AdminPage.searchForUser(Hooks.getDriver(), userName);
        if (not == null) {
            Assert.assertTrue("User " + userName + " not found in the user list", AdminPage.userExists(Hooks.getDriver(), userName));
        } else{
            Assert.assertFalse("User " + userName + " found in the user list", AdminPage.userExists(Hooks.getDriver(), userName));
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }
}
