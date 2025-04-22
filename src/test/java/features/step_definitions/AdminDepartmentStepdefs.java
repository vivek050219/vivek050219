package features.step_definitions;

import common.SeleniumFunctions;
import constants.GlobalConstants;
import cucumber.api.DataTable;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.When;
import cucumber.api.java.en.Then;
import features.Hooks;
import org.json.simple.JSONObject;
import org.junit.Assert;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import pageObject.AdminPage;
import support.Page;
import utils.UtilFunctions;

import java.util.HashMap;
import java.util.List;

/**
 * Created by PatientKeeper on 6/29/2016.
 */

/******************************************************************************
 Class Name: AdminTabStepdefs
 Contains step definitions of admin tab
 ******************************************************************************/

public class AdminDepartmentStepdefs {

    public String className = getClass().getSimpleName();

    //When I search for the department ""
    @When("^I search for the department \"(.*?)\"$")
    public void searchForDeptInList(String deptName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        GlobalStepdefs globalStepsObj = new GlobalStepdefs();
        globalStepsObj.clickButton("Search", "QuickDetails", null);

        Assert.assertTrue("Text box not found or value not set for the value: " + deptName,
                Page.setTextBox(Hooks.getDriver(), "Admin", deptName, "SearchForDept"));
        globalStepsObj.clickButton("Search", null, null);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I select the department \"(.*?)\"$")
    public void selectDepartment(String departmentName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        departmentName = UtilFunctions.convertThruRegEx(departmentName);
        Assert.assertTrue("Department name: " + departmentName + " not present and not clicked.",
                AdminPage.selectDepartmentItem(Hooks.getDriver(), departmentName));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^the department \"(.*?)\" should appear in the department list$")
    public void findDepartmentInList(String departmentName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        departmentName = UtilFunctions.convertThruRegEx(departmentName);
        Assert.assertTrue("Department name: " + departmentName + " not present and not clicked.",
                AdminPage.selectDepartmentItem(Hooks.getDriver(), departmentName));

        //self.selectFrame(@@FRAME_DEPT_MAIN)
        //return self.findElementByXPath("td[@class='tableText' and contains(text(), '#{itemName}')]")

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @When("^the \"(.*?)\" template is loaded$")
    public void templateLoad(String templateName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        globalStepdefs.selectTab("Admin");
        globalStepdefs.selectSubTab("Institution");
        globalStepdefs.selectFromDropdown("NoteWriter", "Edit Institution Settings",
                "Institution Settings", null);
        AdminTabStepdefs adminTabStepdefs = new AdminTabStepdefs();
        adminTabStepdefs.clickEditLinkInPane("Note Templates", null, "NoteWriterSettings");
        //This pane: "NoteTemplateMaintenance" can take a really long time to load
        Thread.sleep(35000);
        //The wait below in findPane() doesn't work here b/c the pane technically loads, just none of its content loads in a timely manner
        Page.findPane(Hooks.getDriver(), GlobalStepdefs.curTabName, "NoteTemplateMaintenance"/*, GlobalConstants.THIRTY*/);

        Assert.assertTrue("NW Template: " + templateName + " not present ",
                AdminPage.templateLoad(Hooks.getDriver(), templateName));

        globalStepdefs.clickButton("Close Note Template", null, null);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @Then("^the following Notewriter templates should be loaded$")
    public void checkMultipleTemplatesLoad(DataTable dataTable) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        globalStepdefs.selectTab("Admin");
        globalStepdefs.selectSubTab("Institution");
        globalStepdefs.selectFromDropdown("NoteWriter", "Edit Institution Settings",
                "Institution Settings", null);
        AdminTabStepdefs adminTabStepdefs = new AdminTabStepdefs();
        adminTabStepdefs.clickEditLinkInPane("Note Templates", null, "NoteWriterSettings");
        //This pane: "NoteTemplateMaintenance" can take a really long time to load
        Thread.sleep(35000);
        //The wait below in findPane() doesn't work here b/c the pane technically loads, just none of its content loads in a timely manner
        Page.findPane(Hooks.getDriver(), GlobalStepdefs.curTabName, "NoteTemplateMaintenance"/*, GlobalConstants.THIRTY*/);

        List<String> dataList = dataTable.asList(String.class);
        for (String templateName : dataList) {
            Assert.assertTrue("NW Template: " + templateName + " not present ",
                    AdminPage.templateLoad(Hooks.getDriver(), templateName));
        }

        globalStepdefs.clickButton("Close Note Template", null, null);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @And("^the following note picker(?:s)? should be available for the \"(.*?)\" department$")
    public void checkNotePicker(String departmentName, DataTable dataTable) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        List<String> dataList = dataTable.asList(String.class);
        for (String notePickerName : dataList) {
            Assert.assertTrue("NotePicker: " + dataTable + " not present ",
                    AdminPage.checkNotePicker(Hooks.getDriver(), departmentName, notePickerName));
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @And("^only the following note picker(?:s)? should be available$")
    public void checkForThesePickersOnly(DataTable dataTable) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        Assert.assertTrue("The onscreen template list and the given list are not the same.",
                AdminPage.checkForTheseNotePickersOnly(Hooks.getDriver(), dataTable));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @Then("^the user \"(.*?)\" should appear in the department user list$")
    public void findUserInList(String userName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        userName = UtilFunctions.convertThruRegEx(userName);
        Assert.assertTrue("User name: " + userName + " not present ", AdminPage.userInDeptUserListExists(Hooks.getDriver(), userName));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Given("^the user \"(.*?)\" is associated with the \"(.*?)\" department$")
    public void associateUserToDept(String username, String deptName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        globalStepdefs.selectSubTab("Department");
        AdminDepartmentStepdefs adminDepartmentStepdefs = new AdminDepartmentStepdefs();
        adminDepartmentStepdefs.selectDepartment(deptName);
        globalStepdefs.clickButton("Edit", "Quick Details", null);
        AdminTabStepdefs adminTabStepdefs = new AdminTabStepdefs();
        adminTabStepdefs.clickEditLinkInPane("Users", null, "Department General Settings");
        AdminUserPreferencesStepdefs adminUserPreferencesStepdefs = new AdminUserPreferencesStepdefs();
        adminUserPreferencesStepdefs.searchForUserInList(username);
        AdminDepartmentStepdefs adminDepartmentStepdefs1 = new AdminDepartmentStepdefs();
        adminDepartmentStepdefs1.findUserInList(username);
        globalStepdefs.checkCheckBox(null, "User Select", "DepartmentUsers", null);
        globalStepdefs.clickButton("Save", "Quick Details", null);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");

    }
}
