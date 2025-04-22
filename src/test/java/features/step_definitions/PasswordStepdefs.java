package features.step_definitions;


import common.SeleniumFunctions;
import constants.GlobalConstants;
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
import utils.UtilProperty;

import java.util.HashMap;
import java.util.Random;
import static features.Hooks.driver;


/******************************************************************************
 Class Name: PasswordStepdefs
 Contains step definitions related to password cleanup
 ******************************************************************************/

public class PasswordStepdefs {

    public String className = getClass().getSimpleName();

    public static String tempUsername, tempPassword, tempFirstName, tempLastName  ;
    public static String tempAdminUsername, tempAdminPassword, tempAdminFirstName;

    @Given("^I have created a temporary (admin )?password user$")
    public void createTempPasswordUser(String userType) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        String tabName = "Admin";
        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        LoginStepdefs loginStepdefs = new LoginStepdefs();
        String userName = null;
        String firstName = null;
        String password = null;
        boolean userNotExist = false;
        if (userType != null && tempAdminUsername == null) {
            userName = tempAdminUsername = "admin" + GlobalConstants.tempUser.get("Username");
            firstName = tempAdminFirstName = "Admin" + GlobalConstants.tempUser.get("FirstName");
            password = tempAdminPassword = "abc";
            UtilFunctions.log("Creating admin" + tempAdminUsername);
            userNotExist = true;
        } else if (tempUsername == null){
            userName = tempUsername = "tu" + GlobalConstants.tempUser.get("Username");
            firstName = tempFirstName = GlobalConstants.tempUser.get("FirstName");
            password = tempPassword = "abc";
            UtilFunctions.log("Creating user" + tempUsername);
            userNotExist = true;
        }
        if (userNotExist){
            tempLastName = GlobalConstants.tempUser.get("LastName");
            loginStepdefs.portalLogin();
            globalStepdefs.selectTab(tabName);
            UtilFunctions.log("Passwords Test Institution settings start");
            globalStepdefs.selectSubTab("Institution");
            globalStepdefs.selectFromDropdown("Site Administration", "Edit Institution Settings", null, null);
            globalStepdefs.enterInTheField("3", "Minimum Password length", null);
            globalStepdefs.selectRadioListButton("false", "Passwordsmustbemixedcase");
            globalStepdefs.selectRadioListButton("false", "Passwordsmustincludeatleast1numberand1letter");
            globalStepdefs.clickButton("Save", "", null);
            globalStepdefs.selectAlert("OK", null);
            Page.findPane(Hooks.getDriver(),GlobalStepdefs.curTabName,"Institution Status Summary",GlobalConstants.FIFTEEN);
            UtilFunctions.log("Passwords Test Institution settings completed");
            UtilFunctions.log("Check and delete temp user if already exists");
            loginStepdefs.portalLogin();
            globalStepdefs.selectTab(tabName);
            globalStepdefs.selectSubTab("User");
            if (AdminPage.userExists(Hooks.getDriver(), userName)) {
                UtilFunctions.log("User: " + userName + " exists");
                AdminPage.searchForUser(Hooks.getDriver(), userName);
                globalStepdefs.clickButton("Delete", "Quick Details", null);
                globalStepdefs.clickButton("Yes", "Delete User", null);
            }
            UtilFunctions.log("Temp user creation");
            globalStepdefs.clickButton("Create User", "", null);
            globalStepdefs.checkPaneLoad("Create User", "load", "20");
            AdminPage.createUser(Hooks.getDriver(), firstName, tempLastName, userName, password);
            globalStepdefs.clickButton("Create User Save", "", null);
            String questionPaneText = globalStepdefs.getPaneText("QuestionContent", " if it exists");
            if (questionPaneText.contains("There are already one or more people in the system with the name")) {
                globalStepdefs.clickButton("No", "Question", " if it exists");
                globalStepdefs.clickButton("Cancel", "", null);
                UtilFunctions.log("User: " + userName + " exists hence not changing the password to default");
                AdminPage.searchForUser(Hooks.getDriver(), userName);
                globalStepdefs.clickButton("Edit", "Quick Details", null);
                globalStepdefs.clickMiscElement("EditUserPasswordLink", null, null, null);
                globalStepdefs.enterInTheField(UtilProperty.userPwd, "Current Password", null);
                globalStepdefs.enterInTheField(tempPassword, "New Password", null);
                globalStepdefs.enterInTheField(tempPassword, "New Password Verification", null);
                globalStepdefs.clickButton("Change User Password Save", "", null);
                globalStepdefs.clickButton("OK", "Change User Password", null);
                globalStepdefs.clickLinkInPane("Return to Choose Users", null, null, "Personal Preferences");
            }
            UtilFunctions.log("Check Temp user creation");
            HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
            String paneFrames = "FRAME_QUICK_DETAILS";
            paneFrames = UtilFunctions.getFrameValue(frameMap, paneFrames);
            SeleniumFunctions.selectFrame(Hooks.getDriver(),paneFrames,"id");
            WebElement userCreated = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//td[@class='smallDetail' and contains(text(), 'Username:')]"));
            if (userCreated == null) {
                Assert.assertTrue("User: " + userName + " is not created", AdminPage.userExists(Hooks.getDriver(), userName));
            }else{
                Assert.assertTrue("User: " + userName + " is not created", userCreated.getText().contains(userName));
            }
        }else
            UtilFunctions.log("Users " + tempUsername +"or "+ tempAdminUsername + "is already present");
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Given("^I login as my temporary (admin )?user$")
    public void loginTempPasswordUser(String userType) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        if (Hooks.getDriver() != null) {
            Hooks.closeBrowser();
        }
        if (userType == null) {
            Hooks.openBrowser(tempUsername, tempPassword);
        }else
            Hooks.openBrowser(tempAdminUsername, tempAdminPassword);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Given("^An error message should( not)? appear(?: with the text \"(.*)\")?$")
    public void checkErrorMessage(String condition, String errText) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        WebElement errorMsg = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//td[contains(normalize-space(.), 'An error occurred setting your new password')]"));
        if (condition == null) {
            Assert.assertTrue("Error Text message is not displayed", errorMsg.isDisplayed());
            if(errText != null) {
                Assert.assertTrue("Error Text: " + errText + " is not displayed", errorMsg.getText().contains(errText));
            }
        } else {
            Assert.assertFalse("Error message displayed", errorMsg.isDisplayed());
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^I enter my temporary (admin )?user's password into the \"(.*)\" field$")
    public void setTempPassword(String userType, String textField) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        textField = textField.replace(" ", "");
        if (userType == null) {
            Page.setTextBox(Hooks.getDriver(), GlobalStepdefs.curTabName, tempPassword, textField);
        }else {
            Page.setTextBox(Hooks.getDriver(), GlobalStepdefs.curTabName, tempAdminPassword, textField);
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^There should( not)? be an alert(?: with the text \"(.*)\")?$")
    public void checkAlert(String condition, String alertText) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        boolean alert = SeleniumFunctions.checkAlertPresent(Hooks.getDriver());
        if (condition == null) {
            Assert.assertTrue("Alert is not displayed", alert);
            if (alertText != null){
                Assert.assertTrue("Alert text: " + alertText + " is not displayed", SeleniumFunctions.getAlertText(Hooks.getDriver()).contains(alertText));
            }
        }else {
            Assert.assertFalse("Alert displayed", alert);
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I dismiss the alert$")
    public void dismissAlert() throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        Assert.assertTrue("Alert is handled", SeleniumFunctions.handleAlert(Hooks.getDriver(),"OK"));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");

    }

    @Then("^I assign password \"(.*)\" to my temporary (admin )?user$")
    public String assignPasswordToTempUser(String newPassword, String userType) throws Throwable {

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        UtilFunctions.log(("Change the password of temporary user Start"));
        if (userType != null) {
            return tempAdminPassword = newPassword;
        }else {
            return tempPassword = newPassword;
        }
    }

    @Then("^The password should have changed successfully$")
    public void checkPasswordChange() throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        try{
            SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.FIFTEEN, "//td[contains(normalize-space(.),'Your password has been changed')]" + ";xpath");
            WebElement passwordChange = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//td[contains(normalize-space(.),'Your password has been changed')]"));
            Assert.assertTrue("Password change is not successfull", passwordChange.isDisplayed());
        } catch (Exception e) {
            e.printStackTrace();
            UtilFunctions.log("Password change is not successfull" + e.getMessage());
            Assert.assertTrue("Password change is not successfull due to exception: " + e.getMessage(), false);
        }


        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^I search for my temporary user$")
    public void searchForMyTempUser() throws Throwable{
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        AdminPage.searchForUser(Hooks.getDriver(), tempUsername);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I select my temporary user$")
    public void selectMyUserInList() throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        Assert.assertTrue("User object not found for the user: " + tempUsername, AdminPage.selectUserByUsername(Hooks.getDriver(), tempUsername));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I set my temporary (admin )?user's PAT level to (0|1|2|3)$")
    public void setPatLevel(String userType,String patLevel)throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        String patLevelValue = "Level " + patLevel;
        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        globalStepdefs.selectTab("Admin");
        globalStepdefs.selectSubTab("User");
        if (userType == null) {
            AdminPage.searchForUser(Hooks.getDriver(), tempUsername);
            AdminPage.selectUserByUsername(Hooks.getDriver(), tempUsername);
        }else{
            AdminPage.searchForUser(Hooks.getDriver(), tempAdminUsername);
            AdminPage.selectUserByUsername(Hooks.getDriver(), tempAdminUsername);
        }
        try {
            Page.clickButton(Hooks.getDriver(), globalStepdefs.curTabName, "Edit", "QuickDetails");
            Page.selectDropDownInPane(Hooks.getDriver(), globalStepdefs.curTabName, patLevelValue,"PatAccess", "");
            globalStepdefs.clickButton("OK","Information","if it exists");
            Page.clickButton(Hooks.getDriver(), globalStepdefs.curTabName,"Save","");
            Page.handleAlert(Hooks.getDriver(), "OK");
            Page.findPane(Hooks.getDriver(), globalStepdefs.curTabName, "UserGeneralSettings", GlobalConstants.FIVE);
        }
        catch (Exception e){
            Assert.assertTrue("Selection of PAT level is not successful with exception: " + e.getMessage(),false);
            UtilFunctions.log("Selection of PAT level is not successful with exception: " + e.getMessage());
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I select the popup pane$")
    public void selectPopupPane() throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        String paneFrame = "FRAME_POPUP_CONTENTS";
        String paneFrames = UtilFunctions.getFrameValue(frameMap, paneFrame);
        UtilFunctions.log("PaneFrames: " + paneFrames);
        SeleniumFunctions.selectFrame(driver, paneFrames, "id");

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }
    @When("^I save my new settings$")
    public void saveNewSettings() throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        globalStepdefs.clickButton("Save", null, null);
        globalStepdefs.selectAlert("OK", null);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }
    @When("^I create a temporary (admin|user) for testing passwords( which I keep)?$")
    public void createUserForTestingPasswords(String userType, String keep) throws Throwable {
        String FirstName;
        String LastName;
        String Username;
        Random random = new Random();
        int randomNum = random.nextInt(99999);
        if (userType.equals("admin")) {

            FirstName = "VervePwd" + randomNum;
            LastName = "Test";
            Username = tempAdminUsername = "passwordtest" + randomNum;

            System.out.print("Creating admin");
        } else {
            FirstName = "VervePwd" + randomNum;
            LastName = "Test";
            Username = tempUsername = "passwordtest" + randomNum;

            System.out.print("Creating user");
        }

        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        System.out.print("UserName");
        PasswordStepdefs passwordsStepdefs = new PasswordStepdefs();
        passwordsStepdefs.selectPopupPane();
        globalStepdefs.enterInTheField(FirstName, "FirstName", null);
        globalStepdefs.enterInTheField(LastName, "LastName", null);
        globalStepdefs.enterInTheField(Username, "Username", null);

    }
    // Returns to the "Create User" dialog, assuming the browser is already in the "Admin" tab

    @When("^I return to the Create User dialog$")
    public void returnToCreateUserDialog() throws Throwable {
        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        globalStepdefs.selectSubTab("User");
        globalStepdefs.clickButton("Create User", null, null);
        PasswordStepdefs passwordsStepdefs = new PasswordStepdefs();
        passwordsStepdefs.selectPopupPane();
        passwordsStepdefs.createUserForTestingPasswords("user", "");
        globalStepdefs.checkCheckBox(null, "Use Basic Authentication", null, "exists");

    }
    @And("^I handle the alert$")
    public void handleAlert() throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        Assert.assertTrue("Alert is not handled", SeleniumFunctions.handleAlert(Hooks.getDriver(),"OK"));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }
    @Given("^I open the Create User dialog and fill it with temporary information$")
    public void fillTempInformation() throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        globalStepdefs.selectSubTab("User");
        globalStepdefs.clickButton("Create User", null, null);
        PasswordStepdefs passwordsStepdefs = new PasswordStepdefs();
        passwordsStepdefs.selectPopupPane();
        globalStepdefs.checkCheckBox(null, "UseBasicAuthentication", null,"exists");
        passwordsStepdefs.createUserForTestingPasswords("user", null);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Given("^I delete the temporary (admin )?user$")
    public void deleteTempUser(String userType) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
            String userName;
        if (userType != null){
            userName = tempAdminUsername;
            tempAdminUsername = null;
        }else{
            userName = tempUsername;
            tempUsername = null;
        }
        AdminUserPreferencesStepdefs adminUserPreferencesStepdefs = new AdminUserPreferencesStepdefs();
        adminUserPreferencesStepdefs.addRemoveUser(null,userName,null, " not");
        Assert.assertFalse("User: " + userName + " is not deleted", AdminPage.userExists(Hooks.getDriver(), userName));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Given("^I check for temporary (admin )?user successfull creation$")
    public void checkTempUserSuccessfullCreation(String userType) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        String userName;
        if (userType != null){
            userName = tempAdminUsername;
        }else{
            userName = tempUsername;
        }
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        String paneFrames = "FRAME_QUICK_DETAILS";
        paneFrames = UtilFunctions.getFrameValue(frameMap, paneFrames);
        SeleniumFunctions.selectFrame(Hooks.getDriver(),paneFrames,"id");
        WebElement userCreated = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//td[@class='smallDetail' and contains(text(), 'Username:')]"));
        if (userCreated == null) {
            Assert.assertTrue("User: " + userName + " is not created", AdminPage.userExists(Hooks.getDriver(), userName));
        }else{
            Assert.assertTrue("User: " + userName + " is not created", userCreated.getText().contains(userName));
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
    }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

}

