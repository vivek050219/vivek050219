package features.step_definitions;

import common.SeleniumFunctions;
import cucumber.api.DataTable;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import features.Hooks;
import org.json.simple.JSONObject;
import org.junit.Assert;
import org.openqa.selenium.WebElement;
import pageObject.AdminPage;
import support.Page;
import utils.UtilFunctions;

import java.util.HashMap;
import java.util.List;

import static features.Hooks.driver;
import static features.step_definitions.GlobalStepdefs.curTabName;

/**
 * Created by PatientKeeper on 6/29/2016.
 */

/******************************************************************************
 Class Name: AdminTabStepdefs
 Contains step definitions of admin tab
 ******************************************************************************/

public class AdminTabStepdefs {

    public String className = getClass().getSimpleName();

    @When("^I click the \"(.*?)\" edit( category)? link in the \"(.*?)\" pane$")
    public void clickEditLinkInPane(String link, String category, String pane) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        pane = pane.replace(" ", "");
        Assert.assertTrue("Link: " + link + " not found",
                Page.clickLinkText(Hooks.getDriver(), curTabName, link, pane, "", category));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Given("^the provider group \"(.*?)\" is( not)? in the provider group list$")
    public void verifyProviderGroupInList(String providerGroup, String no) throws Throwable{
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        WebElement providerGroupFound = AdminPage.findProviderGroup(Hooks.getDriver(), providerGroup);
        //If provider group should exist
        if (no == null){
            //but provider group doesn't exist
            if (providerGroupFound == null){
                //create provider group
                UtilFunctions.log("Provider Group '"+ providerGroup + "' not found.  Creating.");
                Page.clickButton(Hooks.getDriver(), "Admin", "Create New Provider Group");
                Page.setTextBox(Hooks.getDriver(), curTabName, providerGroup, "Provider Group Name", "Enter Provider Group Name");
                Page.clickButton(Hooks.getDriver(), "Admin", "OK", "Enter Provider Group Name");
            }
        }
        else {
            //Delete provider group if it exists
            if (providerGroupFound != null){
                UtilFunctions.log("Provider Group '"+ providerGroup + "' found.  Deleting.");
                AdminPage.selectProviderGroup(Hooks.getDriver(), providerGroup);
                Page.clickButton(Hooks.getDriver(), "Admin", "Delete Selected Provider Group");
                Page.clickButton(Hooks.getDriver(), "Admin", "Yes", "Question");
            }
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I select the provider group \"(.*?)\" in the list$")
    public void selectProviderGroup(String providerGroup) throws Throwable{
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        Assert.assertTrue("Provider Group '" + providerGroup + "' not found", AdminPage.selectProviderGroup(Hooks.getDriver(), providerGroup));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^the provider group \"(.*?)\" should( not)? appear in the list$")
    public void verifyProviderGroupExists(String providerGroup, String no) throws Throwable{
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        WebElement temp = AdminPage.findProviderGroup(Hooks.getDriver(), providerGroup);
        if (no == null) {
            Assert.assertTrue("Provider Group '" + providerGroup + "' not found", (AdminPage.findProviderGroup(Hooks.getDriver(), providerGroup) != null));
        } else {
            Assert.assertFalse("Provider Group '" + providerGroup + "' found", (AdminPage.findProviderGroup(Hooks.getDriver(), providerGroup) != null));
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @And("^I add the following provider(?:s)? to the short list$")
    public void addProvider(DataTable dataTable) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        List<String> dataList = dataTable.asList(String.class);

        Assert.assertTrue(" providers: " + dataTable + " not able to add ", AdminPage.addProvider(Hooks.getDriver(),dataList));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @And("^I remove all the providers from the short list$")
    public void removeProvider() throws Throwable{
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        Assert.assertTrue(" providers: not able to remove ", AdminPage.removeProvider(Hooks.getDriver()));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @And("^I navigate to the note writer quick text admin view page for selected \"(.*?)\" quick text template$")
    public void navigateToQuickTextTemplate(String tamplateName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        globalStepdefs.selectFromDropdown("NoteWriter", "Edit Department Settings", "Department Edit Settings", null);
        globalStepdefs.selectFromDropdown(tamplateName, "Quick Text Template View", null, null);
        globalStepdefs.waitGivenTime("3");
        clickEditLinkInPane("Quick Text (Template View)", null, "Department General Settings");
        globalStepdefs.checkPaneLoad("Note Writer Quick Text Admin View", "load", null);


        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @And("^I load the edit my pickers page for selected \"(.*?)\" user$")
    public void loadEditMyPickers(String userName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        globalStepdefs.selectSubTab("User");
        AdminUserPreferencesStepdefs adminUserPreferencesStepdefs = new AdminUserPreferencesStepdefs();
        adminUserPreferencesStepdefs.searchForUserInList(userName);
        adminUserPreferencesStepdefs.searchForUserInList(userName);
        globalStepdefs.clickButton("Edit", "Quick Details", null);
        globalStepdefs.selectFromDropdown("NoteWriter", "Edit User Settings", null, null);
        globalStepdefs.waitGivenTime("3");
        clickEditLinkInPane("Quick Text (Summary View)", null, "User NoteWriter Settings");
        globalStepdefs.waitGivenTime("2");
        globalStepdefs.clickButton("Reset User Pickers", "Quick Text Editor Content", null);
        globalStepdefs.clickButton("Delete All", "Question", null);
        globalStepdefs.waitGivenTime("2");
        clickEditLinkInPane("My Pickers", "category", "Quick Text Editor Content");
        globalStepdefs.checkPaneLoad("Edit My Pickers", "load", "5");

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");

    }

    @Then("^the picker \"(.*?)\" should( not)? appear in the children picker list$")
    public void verifyPickersInThePickerList(String pickerName, String value) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        String panename = "QuickTextContent";
        String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + panename, "frame"));
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
        WebElement searchObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//input[@id='Description' and @value='"+ pickerName +"']" + ";xpath"));
        if(value==null){
            Assert.assertNotNull("Picker name: '"+pickerName+"'did not appearing",searchObj);
        }else{
            Assert.assertNull("Picker name: '"+pickerName+"'appearing",searchObj);
        }


        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I create a new group \"(.*?)\" in the update quick text grouping pane$")
    public void creatNewGroup(String groupName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        deleteGrouping(groupName,"exists","Update Quick Text Groupings Content");
        GlobalStepdefs globalStepdefs=new GlobalStepdefs();
        globalStepdefs.enterInTheField(groupName,"New Grouping","Update Quick Text Groupings Content");
        globalStepdefs.clickButton("Add","Update Quick Text Groupings Content",null);
        globalStepdefs.clickButton("Save","Update Quick Text Groupings Content",null);
        globalStepdefs.verifyDropDownList(groupName,null,"Display",null);
        globalStepdefs.clickLinkInPane("Update Groupings",null,null,"Quick Text Content");
        globalStepdefs.checkPaneLoad("Update Quick Text Groupings","load",null);
        globalStepdefs.waitGivenTime("3");
        validateGroupingName(groupName,null);


        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I create a new quick text with label \"(.*?)\" and shortcut \"(.*?)\" for selected group \"(.*?)\" in the \"(.*?)\" pane$")
    public void createNewQuickText(String labelName,String shortcutName,String groupName,String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        GlobalStepdefs globalStepdefs=new GlobalStepdefs();
        globalStepdefs.clickButton("New Quick Text",paneName,null);
       globalStepdefs.waitGivenTime("3");
       globalStepdefs.enterInTheField(labelName,"Label","Label");
        globalStepdefs.selectFromDropdown(groupName,"Grouping",null,null);
        globalStepdefs.getFromTheField("Text to Insert",null,labelName);
        globalStepdefs.enterInTheField(shortcutName,"Shortcut","Label");
        globalStepdefs.clickButton("Add","NewQuickTextContent",null);
        globalStepdefs.clickButton("Save","NewQuickTextContent",null);


        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }
    @When("^I delete the \"(.*?)\" grouping( if it exists)? in the \"(.*)\" pane$")
            public void deleteGrouping(String groupingName,String exists,String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        paneName = paneName.replace(" ", "");
        if (exists == null) {
            JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
            HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
            String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
            SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
            WebElement searchObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//tr[@MainRow='Y' and descendant::input[@id= 'Description' and @value='" + groupingName + "']]" + ";xpath"));
            WebElement delObj=SeleniumFunctions.findElementByWebElement(searchObj, SeleniumFunctions.setByValues("//img[@buttonID='deletegrouping']" + ";xpath"));
            delObj.click();
            delObj.click();
        }
        try {
            JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
            HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
            String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
            SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
            UtilFunctions.log("Selected Fame '" + paneFrame + "'");
            WebElement searchObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//tr[@MainRow='Y' and descendant::input[@id= 'Description' and @value='" + groupingName + "']]" + ";xpath"));
           // WebElement searchObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//input[@id= 'Description' and @value='" + groupingName + "']]" + ";xpath"));
            WebElement delObj= SeleniumFunctions.findElementByWebElement(searchObj, SeleniumFunctions.setByValues("//img[@buttonID='deletegrouping']" + ";xpath"));
            delObj.click();
            delObj.click();
        } catch (Exception e) {
            e.printStackTrace();

            UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
            }.getClass().getEnclosingMethod().getName() + " : Complete");
        }
    }
    @Then("^the grouping name \"(.*?)\" should( not)? appear in the grouping list$")
    public void validateGroupingName(String groupingName,String no) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

            JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
            HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
            String panename = "AddQuickTextContent";
            String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + panename, "frame"));
            SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
            WebElement searchObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//input[@id='Description' and @value='"+groupingName+"']" + ";xpath"));
          if(no==null){
              Assert.assertNotNull("Grouping name: '"+groupingName+"'did not appearing",searchObj);
          }else{
              Assert.assertNull("Grouping name: '"+groupingName+"'appearing",searchObj);
          }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }
    @And("^I click the \"(.*?)\" link$")
    public void clickLink(String linkName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        String panename = "QuickTextContent";
        String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + panename, "frame"));
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
        WebElement searchObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//span[@class='commandLink' and starts-with(text(), '"+ linkName +"')]" + ";xpath"));
        searchObj.click();

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I expand the \"(.*?)\" group and select the \"(.*?)\" quick text in the \"(.*?)\" pane$")
    public void expandTheGroupAndSelectQuickText(String groupName,String qtName,String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        paneName = paneName.replace(" ", "");
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
        SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//td[@class='HpickerTreeLevel0 branch' and descendant::td[text()='"+ groupName +"']]" + ";xpath")).click();
        GlobalStepdefs globalStepdefs=new GlobalStepdefs();
        globalStepdefs.waitGivenTime("3");
        SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//td[@class='HpickerTreeLevel1' and descendant::td[text()='"+ qtName +"']]" + ";xpath")).click();

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


}
