package features.step_definitions;

import common.SeleniumFunctions;
import constants.GlobalConstants;
import cucumber.api.java.en.And;
import cucumber.api.java.en.When;
import features.Hooks;
import org.json.simple.JSONObject;
import org.openqa.selenium.support.ui.WebDriverWait;
import support.Page;
import utils.UtilFunctions;

import java.util.HashMap;

import static features.Hooks.driver;

/**
 * Created by PatientKeeper on 02/16/2017.
 */

/*
* Contains step definitions for Facility Group subtab
*/

public class AdminFacilityGroupStepdefs {

    public String className = getClass().getSimpleName();

    @When("^I (enable|disable) all the interaction checking options$")
    public void enableDisableAllCPOEInteractionChecks(String action) throws Throwable{
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        //Select nav tabs
        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        globalStepdefs.selectTab("Admin");
        globalStepdefs.selectSubTab("Facility Group");
        //Ensure you're on the Default Facility Group facility group: 'I select "DefaultFacilityGroup" from the "Facility Group" dropdown'
        globalStepdefs.selectFromDropdown("DefaultFacilityGroup", "FacilityGroup", null, null);
        Thread.sleep(500);
        //Edit CPOE Utilities
        globalStepdefs.clickLinkInPane("CPOE Utilities", null, null,
                "Facility Group Navigation");
        globalStepdefs.clickMiscElement("Interaction Checking", null, null,
                "");
        //Edit_CPOE Utilities
        globalStepdefs.clickButton("Edit_CPOE Utilities", null, null);
        globalStepdefs.waitGivenTime("2");
        //Wait for "Edit Facility Group Utilities Settings" pane to load
        SeleniumFunctions.explicitWait(driver, GlobalConstants.FIVE, "//div[@id='FacilityGroupUtilityScreen']" + ";xpath");
        globalStepdefs.checkPaneLoad("Edit Facility Group Utilities Settings", "load", "20");
        globalStepdefs.waitGivenTime("2");

        if (action.equals("enable")) {
            globalStepdefs.selectFromDropdown("Popup and Require Reason", "Non-Medication Duplicate Display",
                    null, null);
            globalStepdefs.selectFromDropdown("Disabled", "New Non-Medication Duplicate Display",
                    null, null);
            globalStepdefs.selectRadioListButton("true", "PreventRedundantOrdering");
            globalStepdefs.selectFromDropdown("Popup and Require Reason", "Medication Duplicate Display",
                    null, null);
            globalStepdefs.selectFromDropdown("Popup and Require Reason", "New Medication Duplicate Display",
                    null, null);
            globalStepdefs.selectFromDropdown("Popup and Require Reason", "Contraindicated Drug Combination",
                    null, "if it exists");
            globalStepdefs.selectFromDropdown("Popup and Require Reason", "Severe Interaction",
                    null, "if it exists");
            globalStepdefs.selectFromDropdown("Popup and Require Reason", "Moderate Interaction",
                    null, null);
            globalStepdefs.selectFromDropdown("Popup and Require Reason", "Drug Allergy Display",
                    null, null);
            globalStepdefs.selectFromDropdown("Popup and Require Reason", "Undetermined Severity",
                    null, null);
        } else {
            globalStepdefs.selectFromDropdown("Disabled", "Non-Medication Duplicate Display",
                    null, null);
            globalStepdefs.selectFromDropdown("Disabled", "New Non-Medication Duplicate Display",
                    null, null);
            globalStepdefs.selectRadioListButton("false", "PreventRedundantOrdering");
            globalStepdefs.selectFromDropdown("Disabled", "Medication Duplicate Display",
                    null, null);
            globalStepdefs.selectFromDropdown("Disabled", "New Medication Duplicate Display",
                    null, null);
            globalStepdefs.selectFromDropdown("Disabled", "Contraindicated Drug Combination",
                    null, "if it exists");
            globalStepdefs.selectFromDropdown("Disabled", "Severe Interaction", null,
                    "if it exists");
            globalStepdefs.selectFromDropdown("Disabled", "Moderate Interaction", null,
                    null);
            globalStepdefs.selectFromDropdown("Disabled", "Drug Allergy Display", null,
                    null);
            globalStepdefs.selectFromDropdown("Disabled", "Undetermined Severity", null,
                    null);
        }

        globalStepdefs.clickButton("Save_EditFacilityGroupUtilitySettings", null, null);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @And("^I (enable|disable) allow multiple diets with same start date$")
    public void enableDisableMultipleDiets(String action) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        /**************************************************************************
         * Following steps are performed by the below code:
         * Given I am on the "Admin" tab
         * And I select the "Facility Group" subtab
         * And I click the "CPOE Preferences" link in the "Facility Group Navigation" pane
         * And I click the "Edit CPOE Preferences" button
         * And I wait "2" seconds
         If the action is "enable" then enable the following:-
         And I select "true" from the "Allow Multiple Diets" radiolist
         And I click "Save Edit Facility Group Preferences" button

         If the action is "disabled" then the "Allow Multiple Diets" radiolist will be set to "false"

         *************************************************************************/

        //Select nav tabs
        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        globalStepdefs.selectTab("Admin");
        globalStepdefs.selectSubTab("FacilityGroup");
        //Edit CPOE Preferences
        globalStepdefs.clickLinkInPane("CPOE Preferences",null,null,
                "Facility Group Navigation");
        globalStepdefs.clickButton("Edit CPOE Preferences", null, null);
        globalStepdefs.waitGivenTime("2");

        if (action.equals("enable")) {
            globalStepdefs.selectRadioListButton("true", "AllowMultipleDiets");
        } else {
            globalStepdefs.selectRadioListButton("false", "AllowMultipleDiets");
        }

        globalStepdefs.clickButton("Save Edit Facility Group Preferences", null, null);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @And("^I (enable|disable) prevent ordering of redundant lab tests$")
    public void enableDisableRedundantLabTests(String action) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        //Select nav tabs
        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        globalStepdefs.selectTab("Admin");
        globalStepdefs.selectSubTab("FacilityGroup");
        //Ensure you're on the Default Facility Group facility group: 'I select "DefaultFacilityGroup" from the "Facility Group" dropdown'
        globalStepdefs.selectFromDropdown("DefaultFacilityGroup", "FacilityGroup", null, null);
        Thread.sleep(500);
        //Edit CPOE Utilities
        globalStepdefs.clickLinkInPane("CPOE Utilities", null, null, "Facility Group Navigation");
        //And I click the "Interaction Checking" element
        globalStepdefs.clickMiscElement("InteractionChecking", null, null, "exists");
        globalStepdefs.clickButton("Edit_CPOEUtilities", null, null);
        //Wait for "Edit Facility Group Utilities Settings" pane to load
        SeleniumFunctions.explicitWait(driver, GlobalConstants.FIVE, "//div[@id='FacilityGroupUtilityScreen']" + ";xpath");
        globalStepdefs.checkPaneLoad("Edit Facility Group Utilities Settings", "load", "20");
        globalStepdefs.waitGivenTime("3");

        if (action.equals("enable"))
            globalStepdefs.selectRadioListButton("true", "PreventRedundantOrdering");
        else
            globalStepdefs.selectRadioListButton("false", "PreventRedundantOrdering");

        globalStepdefs.clickButton("Save_EditFacilityGroupUtilitySettings", null, null);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @And("^I (enable|disable) the medication duplicate display interaction checking option$")
    public void enableDisableMedicationDisplayOptions(String action) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        //Select nav tabs
        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        globalStepdefs.selectTab("Admin");
        globalStepdefs.selectSubTab("FacilityGroup");
        //Ensure you're on the Default Facility Group facility group: 'I select "DefaultFacilityGroup" from the "Facility Group" dropdown'
        globalStepdefs.selectFromDropdown("DefaultFacilityGroup", "FacilityGroup", null, null);
        Thread.sleep(500);
        //Edit CPOE Utilities
        globalStepdefs.clickLinkInPane("CPOE Utilities", null, null, "Facility Group Navigation");
        //And I click the "Interaction Checking" element
        globalStepdefs.clickMiscElement("InteractionChecking", null, null, "exists");
        globalStepdefs.clickButton("Edit_CPOEUtilities", null, null);
        //Wait for "Edit Facility Group Utilities Settings" pane to load
        SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, "//div[@id='FacilityGroupUtilityScreen']" + ";xpath");
        globalStepdefs.checkPaneLoad("Edit Facility Group Utilities Settings", "load", "20");
        globalStepdefs.waitGivenTime("3");

        if (action.equals("enable")) {
            globalStepdefs.selectFromDropdown("Popup and Require Reason", "Medication Duplicate Display",
                    null, null);
            globalStepdefs.selectFromDropdown("Popup and Require Reason", "New Medication Duplicate Display",
                    null,null);
        } else {
            globalStepdefs.selectFromDropdown("Disabled", "Medication Duplicate Display",
                    null,null);
            globalStepdefs.selectFromDropdown("Disabled", "New Medication Duplicate Display",
                    null,null);
        }

        globalStepdefs.clickButton("Save_EditFacilityGroupUtilitySettings", null, null);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @And("^I (enable|disable) the non medication duplicate display interaction checking option$")
    public void enableDisableNonMedicationDisplayOptions(String action) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        //Select nav tabs
        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        globalStepdefs.selectTab("Admin");
        globalStepdefs.selectSubTab("FacilityGroup");
        //Ensure you're on the Default Facility Group facility group: 'I select "DefaultFacilityGroup" from the "Facility Group" dropdown'
        globalStepdefs.selectFromDropdown("DefaultFacilityGroup", "FacilityGroup", null, null);
        Thread.sleep(500);
        //Edit CPOE Utilities
        globalStepdefs.clickLinkInPane("CPOE Utilities", null, null, "Facility Group Navigation");
        //And I click the "Interaction Checking" element
        globalStepdefs.clickMiscElement("InteractionChecking", null, null, "exists");
        globalStepdefs.clickButton("Edit_CPOEUtilities", null, null);
        //Wait for "Edit Facility Group Utilities Settings" pane to load
        SeleniumFunctions.explicitWait(driver, GlobalConstants.FIVE, "//div[@id='FacilityGroupUtilityScreen']" + ";xpath");
        globalStepdefs.checkPaneLoad("Edit Facility Group Utilities Settings", "load", "20");
        globalStepdefs.waitGivenTime("3");

        if (action.equals("enable")) {
            globalStepdefs.selectFromDropdown("Popup and Require Reason", "Non-Medication Duplicate Display",
                    null, null);
            globalStepdefs.selectFromDropdown("Popup and Require Reason", "New Non-Medication Duplicate Display",
                    null,null);
        } else {
            globalStepdefs.selectFromDropdown("Disabled", "Non-Medication Duplicate Display",
                    null,null);
            globalStepdefs.selectFromDropdown("Disabled", "New Non-Medication Duplicate Display",
                    null,null);
        }

        globalStepdefs.clickButton("Save_EditFacilityGroupUtilitySettings", null, null);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @And("^I (enable|disable) the drug allergy display interaction checking option$")
    public void enableDisableDrugAllergyDisplay(String action) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        //Select nav tabs
        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        globalStepdefs.selectTab("Admin");
        globalStepdefs.selectSubTab("FacilityGroup");
        //Ensure you're on the Default Facility Group facility group: 'I select "DefaultFacilityGroup" from the "Facility Group" dropdown'
        globalStepdefs.selectFromDropdown("DefaultFacilityGroup", "FacilityGroup", null, null);
        Thread.sleep(500);
        //Edit CPOE Utilities
        globalStepdefs.clickLinkInPane("CPOE Utilities", null, null, "Facility Group Navigation");
        globalStepdefs.clickMiscElement("InteractionChecking", null, null, "exists");
        globalStepdefs.clickButton("Edit_CPOE Utilities", null, null);
        //Wait for "Edit Facility Group Utilities Settings" pane to load
        SeleniumFunctions.explicitWait(driver, GlobalConstants.FIVE, "//div[@id='FacilityGroupUtilityScreen']" + ";xpath");
        globalStepdefs.checkPaneLoad("Edit Facility Group Utilities Settings", "load", "20");
        globalStepdefs.waitGivenTime("3");

        if (action.equals("enable")) {
            globalStepdefs.selectFromDropdown("Popup and Require Reason", "Drug Allergy Display",
                    null, null);
        } else {
            globalStepdefs.selectFromDropdown("Disabled", "Drug Allergy Display",null,
                    null);
        }

        globalStepdefs.clickButton("Save_EditFacilityGroupUtilitySettings", null, null);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


//Changed this method and step so the language better reflects what it does
    @And("^I (enable|disable) interaction display alerts$")
    public void enableDisableInteractionOptions(String action) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        //Select nav tabs
        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        globalStepdefs.selectTab("Admin");
        globalStepdefs.selectSubTab("FacilityGroup");
        //Ensure you're on the Default Facility Group facility group: 'I select "DefaultFacilityGroup" from the "Facility Group" dropdown'
        globalStepdefs.selectFromDropdown("DefaultFacilityGroup", "FacilityGroup", null, null);
        Thread.sleep(500);
        //Edit "CPOE Utilities"
        globalStepdefs.clickLinkInPane("CPOE Utilities", null, null, "Facility Group Navigation");
        //And I click the "Interaction Checking" element
        globalStepdefs.clickMiscElement("InteractionChecking", null, null, "exists");
        globalStepdefs.clickButton("Edit_CPOE Utilities", null, null);
        //Wait for "Edit Facility Group Utilities Settings" pane to load
        SeleniumFunctions.explicitWait(driver, GlobalConstants.FIVE, "//div[@id='FacilityGroupUtilityScreen']" + ";xpath");
        globalStepdefs.checkPaneLoad("Edit Facility Group Utilities Settings", "load", "20");
        globalStepdefs.waitGivenTime("3");

        if (action.equals("enable")) {
            globalStepdefs.selectFromDropdown("Popup and Require Reason", "Contraindicated Drug Combination",
                    null, null);
            globalStepdefs.selectFromDropdown("Popup and Require Reason", "Severe Interaction",
                    null,null);
            globalStepdefs.selectFromDropdown("Popup and Require Reason", "Moderate Interaction",
                    null,null);
            globalStepdefs.selectFromDropdown("Popup and Require Reason", "Undetermined Severity",
                    null,null);
        } else {
            globalStepdefs.selectFromDropdown("Disabled", "Contraindicated Drug Combination",
                    null,null);
            globalStepdefs.selectFromDropdown("Disabled", "Severe Interaction",null,
                    null);
            globalStepdefs.selectFromDropdown("Disabled", "Moderate Interaction",null,
                    null);
            globalStepdefs.selectFromDropdown("Disabled", "Undetermined Severity",null,
                    null);
        }

        globalStepdefs.clickButton("Save_EditFacilityGroupUtilitySettings", null, null);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @And("^I (set|revert) prevent ordering of redundant lab tests$")
    public void setRevertLabTests(String action) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        //Select nav tabs
        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        globalStepdefs.selectTab("Admin");
        globalStepdefs.selectSubTab("FacilityGroup");
        //Ensure you're on the Default Facility Group facility group: 'I select "DefaultFacilityGroup" from the "Facility Group" dropdown'
        globalStepdefs.selectFromDropdown("DefaultFacilityGroup", "FacilityGroup", null, null);
        Thread.sleep(500);
        //Edit CPOE Utilities
        globalStepdefs.clickLinkInPane("CPOE Utilities", null, null, "Facility Group Navigation");
        globalStepdefs.clickMiscElement("InteractionChecking", null, null, "exists");
        globalStepdefs.clickButton("Edit_CPOEUtilities", null, null);
        //Wait for "Edit Facility Group Utilities Settings" pane to load
        SeleniumFunctions.explicitWait(driver, GlobalConstants.FIVE, "//div[@id='FacilityGroupUtilityScreen']" + ";xpath");
        globalStepdefs.checkPaneLoad("Edit Facility Group Utilities Settings", "load", "20");
        globalStepdefs.waitGivenTime("3");

        if (action.equals("set")) {
            globalStepdefs.selectFromDropdown("Popup and Require Reason", "Non-Medication Duplicate Display",
                    null, null);
            globalStepdefs.selectFromDropdown("Popup and Require Reason", "New Non-Medication Duplicate Display",
                    null,null);
            globalStepdefs.selectRadioListButton("true", "PreventRedundantOrdering");

        } else {
            globalStepdefs.selectFromDropdown("Disabled", "Non-Medication Duplicate Display",
                    null,null);
            globalStepdefs.selectFromDropdown("Disabled", "New Non-Medication Duplicate Display",
                    null,null);
            globalStepdefs.selectRadioListButton("false", "PreventRedundantOrdering");
        }

        globalStepdefs.clickButton("Save_EditFacilityGroupUtilitySettings", null, null);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @And("^I click on Refresh for the status change in AutoCreate Favorites$")
    public void refreshAutoCreateFavorites() throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        WebDriverWait wait = new WebDriverWait(Hooks.getDriver(), 10);
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");

        Page.clickMiscElement(Hooks.getDriver(), GlobalStepdefs.curTabName, "RefreshAutoCreateFavorites",
                null, null, "");

        boolean status = Page.textExists(Hooks.getDriver(), "Running", "", false);
        int count = 0;
        int maxTries = 3;
        while (!status) {
            try {
                Page.textExists(Hooks.getDriver(), "Not Running", "", false);
                break;
            } catch (NullPointerException e) {
                Page.clickMiscElement(Hooks.getDriver(), GlobalStepdefs.curTabName, "RefreshAutoCreateFavorites",
                        null, null, "");
                if (++count == maxTries) throw e;
            }
        }

        //        Page.clickMiscElement(Hooks.getDriver(), GlobalStepdefs.curTabName, "RefreshAutoCreateFavorites", null, null, "");
//
//        if(!status){
//            Page.textExists(Hooks.getDriver(), "Not Running", "", false);
//        }
//        else{
//            Page.clickMiscElement(Hooks.getDriver(), GlobalStepdefs.curTabName, "RefreshAutoCreateFavorites", null, null, "");
//        }

    }


//    Sections have to have unique names in order to work properly and be selectable by the WebDriver
    @And("^I open the \"(.*)\" section item for editing in Edit Order Set$")
    public void doubleClickOrderSetSectionItem(String itemText) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName("Admin");
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName("Admin");
        String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES.EditOrderSet", "frame"));
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");

        String xpath = "//div[@class='sectionLayoutItem']/*[normalize-space(text()='" + itemText + "')]";
        SeleniumFunctions.explicitWait(driver, GlobalConstants.FIVE, xpath + ";xpath");
        SeleniumFunctions.doubleClick(driver, SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(xpath + ";xpath")));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @And("^I open the \"(.*)\" component for editing in the Content Tab$")
    public void doubleClickOrderSetContentComponent(String componentText) throws Throwable {

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName("Admin");
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName("Admin");
        String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj,
                "PANES.EditOrderSet", "frame"));
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");

        String xpath = "//div[@class='sectionTitleBarName' and text()='" + componentText +
                "' and ancestor::div[@id='mainLayoutContentContainer']]";
        SeleniumFunctions.explicitWait(driver, GlobalConstants.FIVE, xpath + ";xpath");
        SeleniumFunctions.doubleClick(driver, SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(xpath
                + ";xpath")));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


}//end class