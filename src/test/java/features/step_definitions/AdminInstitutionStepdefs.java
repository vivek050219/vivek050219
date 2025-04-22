package features.step_definitions;

import common.SeleniumFunctions;
import constants.GlobalConstants;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.DataTable;
import features.Hooks;
import org.junit.Assert;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.Select;
import support.Page;
import utils.UtilFunctions;
import org.json.simple.JSONObject;
import java.util.*;

import static features.Hooks.driver;

/**
 * Created by PatientKeeper on 6/24/2016.
 */

/******************************************************************************
 Class Name: AdminInstitutionStepdefs
 Contains step definitions of admin institution tab
 ******************************************************************************/

public class AdminInstitutionStepdefs {

    public String className = getClass().getSimpleName();

    @Given("^I turn \"(.*?)\" all codeedits on \"(.*?)\"$")
    public void turnAllCodeEditsOn(String value, String where) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        /**************************************************************************
         * Following setps are performed by the below code:
         * When I am on the "Admin" tab
         * And I select the "Institution" subtab
         * And I select "Charge Capture" from the "Edit Institution Settings"
         dropdown in the "Institution Settings" pane
         * And I click the "Code Edits" edit link in the "Charge Capture
         Settings" pane
         *************************************************************************/
        GlobalStepdefs globalStepsObj = new GlobalStepdefs();
        globalStepsObj.selectTab("Admin");
        globalStepsObj.selectSubTab("Institution");
        globalStepsObj.selectFromDropdown("Charge Capture", "Edit Institution Settings", "Institution Settings", null);
        AdminTabStepdefs adminTabStepsObj = new AdminTabStepdefs();
        Page.clickLinkText(Hooks.getDriver(), GlobalStepdefs.curTabName, "Enable Code Edit Types", "ChargeCaptureSettings", null, null);
        Assert.assertEquals("", Page.checkUnCheckTableBox(Hooks.getDriver(), "Admin", "ValidityDictionary", value, where));
        /*************************************************************************/

        /**************************************************************************
         * Following setps are performed by the below code:
         * And I click the "OK" button in the "Edit Validity Dictionaries" pane
         * And I click the "Save" button
         * And I click "OK" in the confirmation box
         *************************************************************************/
        globalStepsObj.clickButton("OK", "Edit Validity Dictionaries", null);
        while (!Page.checkElementOnPagePresent(Hooks.getDriver(), "Admin", "Save", "BUTTONS"))
            globalStepsObj.clickButton("OK", "Edit Validity Dictionaries", null);
        while (!SeleniumFunctions.checkAlertPresent(Hooks.getDriver()))
            globalStepsObj.clickButton("Save", null, null);
        globalStepsObj.selectAlert("OK", null);
        /*************************************************************************/

        int checkCnt = 0;
        while (!Page.checkElementOnPagePresent(Hooks.getDriver(), "Admin", "EditInstitutionSettings", "DROPDOWNS")) {
            checkCnt++;
            if (checkCnt > GlobalConstants.FIVE) {
                UtilFunctions.log("Element not loaded.");
                break;
            }
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    //Navigating to the Add Section pages from Institution settings
    @And("^I am on the \"(.*?)\" add section page$")
    public void sectionPage(String sectionName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        /*********************************************************************
         And I am on the manage sections page
         And I click the "Add Section" button in the "Sections List" pane
         And I click the "#{sectionName}" link in the "Sections List" pane

         **************************************************************/
        GlobalStepdefs globalStepsObj = new GlobalStepdefs();
        globalStepsObj.clickButton("Add Section","Sections List", null);
        globalStepsObj.clickLinkInPane(sectionName, null, "Add Section Options", "SectionsList");
//        globalStepsObj.clickMiscElement("EM",null,null,null);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    //  Navigating to Manage Sections page from Institution settings
    @And("^I am on the manage sections page$")
    public void manageSectionPage() throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
//**************************************************************************************
//        And I select the "Institution" subtab
//        And I select "Charge Capture" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
//        And I click the "Manage Sections" link in the "Charge Capture Settings" pane
//        And I wait "2" seconds
//        Then the "SectionsList" pane should load
//    ************************************************************************************
        GlobalStepdefs globalStepsObj = new GlobalStepdefs();
        globalStepsObj.selectSubTab("Institution");
        globalStepsObj.selectFromDropdown("Charge Capture", "Edit Institution Settings", "Institution Settings", null);
        globalStepsObj.clickLinkInPane("Manage Sections", null,null,"ChargeCaptureSettings");
//        Page.clickLinkText(Hooks.getDriver(), GlobalStepdefs.curTabName, "Manage Sections", "ChargeCaptureSettings", null, null);
        globalStepsObj.checkPaneLoad("SectionsList", "load", "10");

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    //********************************************************************************************************************
    // Delete the section from the section list

    @Given("^the section \"(.*?)\" not in the sections list$")
    public void sectionsList(String sectionName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        GlobalStepdefs globalStepsObj = new GlobalStepdefs();

        globalStepsObj.enterInTheField(sectionName, "SearchSection", null);


        boolean status = Page.textExists(Hooks.getDriver(), GlobalStepdefs.curTabName, "No matching records found", "SectionList");
        if (!status) {
            try {
                int count = Page.countTableRows(Hooks.getDriver(), GlobalStepdefs.curTabName, "Sections", null, null);
                for (int i = 1; i <= count; i++) {
                    globalStepsObj.clickButton("DeleteLink", "SectionsList", "null");
                    globalStepsObj.clickButton("OKDeleteSection", "SectionsList", "null");
                    Thread.sleep(2000);
                }
            } catch (NullPointerException e) {
                UtilFunctions.log("Rows not deleted");

            }

        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }



//////**********************************************************************************************************
//Newly created section display in the section list with Active-X

    @Then("^the section \"(.*?)\" should display (with|with no) active X in the section list$")
    public void sectionDisplay(String sectionName, String Action) throws Throwable {

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        globalStepdefs.enterInTheField(sectionName, "SearchSection", null);
        WebElement tableRowObj = Page.findTableRowByCellText(Hooks.getDriver(), GlobalStepdefs.curTabName,"Sections","Label", sectionName);
        String cellText = SeleniumFunctions.findElementByWebElement(tableRowObj, SeleniumFunctions.setByValues("//td[@class= 'activeCell']"+";xpath")).getText();
        if (Action.equals("with no")) {
            Assert.assertFalse("Section "+ sectionName + " is present with active X", cellText.equals("X"));
        } else {
            Assert.assertTrue("Section "+ sectionName + " is not present with active X", cellText.equals("X"));
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


//    *******************************************************************************************

    @And("^I create new field rule \"(.*?)\" by selecting \"(.*?)\" as level selector$")
    public void newField(String ruleName, String dropdownValue) throws Throwable {

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        globalStepdefs.clickButton("Create New", null, null);
        globalStepdefs.checkPaneLoad("AddField", "load", "10");
        globalStepdefs.enterInTheField(ruleName, "AddFieldText", null);
        globalStepdefs.clickButton("SaveAddField", null, null);
        globalStepdefs.checkTableLoad("FieldRules", null);
        globalStepdefs.checkNoOfRowsInTable("FieldRules", "null", "1", null, ruleName);

//        SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//select[@class='levelSelector' and ancestor::tr[@fieldtype='PLAIN' and descendant::td[contains(text(), '" + ruleName + "')]]]")).click();
        WebElement dropDownItem = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//select[@class='levelSelector' and ancestor::tr[@fieldtype='PLAIN' and descendant::td[contains(text(), '" + ruleName + "')]]]"));
        if (dropDownItem != null) {
            UtilFunctions.log("Drop down element not null");
            try {
                Select select = new Select(dropDownItem);
                select.selectByVisibleText(dropdownValue);
            }catch (Exception e){
                Assert.assertTrue("Level "+dropdownValue+" is not selected due to error "+ e.getMessage(),false);
            }
        }else{
            Assert.assertTrue("Level dropdown is not found ", false);
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");

    }


    //    ***************************************************************************************************************
//    #Select the location from the locations list
    @And("^I select the \"(.*?)\" in the locations list$")
    public void locationList(String locationName) throws Throwable {

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        try {
            WebElement location = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//a[@class='dynatree-title' and text()='" + locationName + "']"));
            SeleniumFunctions.findElementByWebElement(location, SeleniumFunctions.setByValues("//span[@class='dynatree-checkbox']")).click();
        }catch (Exception e){
            Assert.assertTrue("Location " + locationName + " is not selected due to error "+ e.getMessage(), false);
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");

    }

    //**********************************************************************************************************************
//    #Delete the section from the section list
    @And("^I delete the locations from the locations list$")
    public void deletelocationList() throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        WebElement tableObj = Page.findTable(Hooks.getDriver(), GlobalStepdefs.curTabName, "Locations");
        if (tableObj.isDisplayed()) {
            try {
                int size = Page.countTableRows(Hooks.getDriver(), GlobalStepdefs.curTabName, "Locations", null, null);
                for (int i = 1; i <= size; i++) {
                    Page.clickMiscElement(Hooks.getDriver(),GlobalStepdefs.curTabName,"RemoveLocationSelection",null,null,null);
                }
            }catch (Exception e){
                Assert.assertTrue("Location are not deleted due to error "+ e.getMessage(),false);
            }
        }else {
            Assert.assertTrue("Locations table is not displayed", false);
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");

    }


    //****************************************************************************************************
//    #Add the field from Dictionary
    @And("^I add the \"(.*?)\" field from dictionary by selecting \"(.*?)\" as level selector$")
    public void addField(String dictionaryName, String dropdownValue) throws Throwable {

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        globalStepdefs.clickButton("Select From Dictionary", null, null);
        globalStepdefs.selectFromTheTable(dictionaryName, "Dictionary List");
        globalStepdefs.clickButton("OKFieldSelect", "Dictionary Add Field", null);
        globalStepdefs.checkTableLoad("FieldRules", null);
        globalStepdefs.checkNoOfRowsInTable("FieldRules", "null", "1", null, dictionaryName);

        //        SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//select[@class='levelSelector' and ancestor::tr[@fieldtype='PLAIN' and descendant::td[contains(text(), '" + ruleName + "')]]]")).click();
        WebElement dropDownItem = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//select[@class='levelSelector' and ancestor::tr[@fieldtype='PLAIN' and descendant::td[contains(text(), '" + dictionaryName + "')]]]"));
        if (dropDownItem != null) {
            UtilFunctions.log("Drop down element not null");
            try {
                Select select = new Select(dropDownItem);
                select.selectByVisibleText(dropdownValue);
            }catch (Exception e){
                Assert.assertTrue("Level "+dropdownValue+" is not selected due to error "+ e.getMessage(),false);
            }
        }else{
                Assert.assertTrue("Level dropdown is not found ", false);
        }
        WebElement selectCheckbox = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//input[@class='selectedByDefault' and ancestor::tr[@fieldtype='PLAIN' and descendant::td[contains(text(),'" + dictionaryName + "')]]]"));
        if (selectCheckbox != null){
            Assert.assertFalse("Select checkbox is checked by default", selectCheckbox.isSelected());
            selectCheckbox.click();
            Assert.assertTrue("Select checkbox is not checked", selectCheckbox.isSelected());
        }else{
                Assert.assertTrue("Select checkbox is not found ", false);
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


//************************************************************************************************************

    @And("^I add \"(.*?)\" section in the E&M Section pane$")
    public void addSectionInPane(String sectionName) throws Throwable {

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        GlobalStepdefs globalStepsObj = new GlobalStepdefs();
        globalStepsObj.enterInTheField(sectionName, "SearchSection", null);

        boolean status = Page.textExists(Hooks.getDriver(), GlobalStepdefs.curTabName, "No matching records found", "SectionList");
        if (!status) {
            globalStepsObj.clickButton("Add Section", "Sections List", null);
            globalStepsObj.clickMiscElement("EM",null,null,null);
            globalStepsObj.enterInTheField(sectionName, "Display Label", "E&M Section");
            globalStepsObj.enterInTheField(sectionName, "Description", "E&M Section");
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    //  Navigating to Manage page from Institution settings for Hold for Review
    @And("^I am on the manage hold for review page$")
    public void holdForReviewManagePage() throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
//    **************************************************************************************
//        And I select the "Institution" subtab
//        And I select "Charge Capture" from the "Edit Institution Settings" dropdown in the "Institution Settings" pane
//        And I click the "Manage Link" in the "Charge Capture Settings" pane
//        And I wait "2" seconds
//        Then the "ManageHoldForReview" pane should load
//    ************************************************************************************
        GlobalStepdefs globalStepsObj = new GlobalStepdefs();
        globalStepsObj.selectSubTab("Institution");
        globalStepsObj.selectFromDropdown("Charge Capture", "Edit Institution Settings", "Institution Settings", null);
        globalStepsObj.clickMiscElement("ManageLink",null,null,null);
        globalStepsObj.waitForFieldAttributeValue("20", "Manage Hold For Review Reasons", "PANE", "Manage Hold For Review Reasons", "be visible", null, null);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }
    @And("^The following sub columns should present under the columns of manage hold for review reasons table$")
    public void checkManageHoldForReviewReasonsTableSubColumns(DataTable dataTable) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        WebElement tableObj = Page.findTable(Hooks.getDriver(), GlobalStepdefs.curTabName, "Manage Hold For Review Reasons");
        List<WebElement> col = SeleniumFunctions.findElementsByWebElement(tableObj, SeleniumFunctions.setByValues("//th[@class='ui-state-default' and ancestor::div[@class= 'dataTables_scrollHeadInner']]"));
        List<Map<String, String>> dataList = dataTable.asMaps(String.class, String.class);
        for (Map data : dataList) {
            String column = ((String) data.get("Column"));
            String subColumn = ((String) data.get("Sub Column"));
            UtilFunctions.log("Column: " + column + "\nSub Column: " + subColumn);

            for (int index = 0; index < col.size(); index++) {
                if (col.get(index).getText().trim().equals(column)) {
                    WebElement elt = SeleniumFunctions.findElementByWebElement(tableObj, SeleniumFunctions.setByValues("//th[@class='ui-state-default rowClickable' and ancestor::div[@class= 'dataTables_scrollHeadInner'] and descendant-or-self::text()='" + subColumn + "'][" + (index+1) + "]"));
                    Assert.assertNotNull("Column " + column + " doesn't conatin sub column " + subColumn, elt);
                    break;
                }
            }
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @And("I (activate|deactivate) the following reasons in manage hold for review pane")
    public void reasonsActivateDeactivate(String validationType, DataTable dataTable) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        WebElement tableObj= Page.findTable(Hooks.driver,GlobalStepdefs.curTabName,"ManageHoldForReviewReasons");
        List<String> dataList = dataTable.asList(String.class);
        for (String reason : dataList) {
            WebElement checkboxObj = SeleniumFunctions.findElementByWebElement(tableObj,SeleniumFunctions.setByValues("//a[ancestor::td[@class='activeHandler' and preceding-sibling::td[text()='" + reason + "']]]" + ";xpath"));
            if (checkboxObj != null) {
                if ((validationType.equals("activate") && !checkboxObj.getAttribute("class").equals("selected")) || (validationType.equals("deactivate") && checkboxObj.getAttribute("class").equals("selected"))) {
                    try{
                        checkboxObj.click();
                        Thread.sleep(1000);
                    }catch(Exception e){
                        Assert.assertTrue(reason+" reason check box is not clicked due to execpetion: "+e.getMessage(), false);
                    }
                }
                if (validationType.equals("activate"))
                    Assert.assertTrue("Reason "+reason+" is not activated", checkboxObj.getAttribute("class").equals("selected"));
                else
                    Assert.assertTrue("Reason "+reason+" is activated", !checkboxObj.getAttribute("class").equals("selected"));
            }
            else{
                Assert.assertNotNull("Checkbox for reason "+reason+" is not found",null);
            }

        }
    }

}
