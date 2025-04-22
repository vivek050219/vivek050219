package features.step_definitions;

import cucumber.api.java.en.Given;
import cucumber.api.java.en.When;
import features.Hooks;
import pageObject.AdminPage;
import utils.UtilFunctions;
import org.junit.Assert;

/**
 * Created by PatientKeeper on 6/29/2016.
 */

/******************************************************************************
 Class Name: AdminTabStepdefs
 Contains step definitions of admin tab
 ******************************************************************************/

public class AdminBulkUserStepdefs {

    public String className = getClass().getSimpleName();

    @When("^I select the user \"(.*?)\" in the \"(.*?)\" pane$")
    public void selectBulkUserByName(String userName, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        AdminPage.selectBulkUserByUserName(Hooks.getDriver(), userName, paneName);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }
    @Given("^the user \"(.*?)\" should( not)? appear in the \"(.*?)\" pane$")
    public void bulkUserExistsInPane(String userName, String condition, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        userName = UtilFunctions.convertThruRegEx(userName);
        paneName = UtilFunctions.convertThruRegEx(paneName);
        if (condition == null) {
            Assert.assertTrue("Bulk User: " + userName + " not present in " + paneName + " in the pane", AdminPage.bulkUserExists(Hooks.getDriver(), userName, paneName));
        }
        else{
            Assert.assertFalse("Bulk User: " + userName + " is present in " + paneName + " in the pane", AdminPage.bulkUserExists(Hooks.getDriver(), userName, paneName));
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }
}