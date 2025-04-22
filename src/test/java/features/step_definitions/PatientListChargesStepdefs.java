package features.step_definitions;

import common.SeleniumFunctions;
import constants.GlobalConstants;
import cucumber.api.DataTable;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.When;
import features.Hooks;
import org.json.simple.JSONObject;
import org.junit.Assert;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebElement;
import pageObject.PatientListPage;
import support.Page;
import utils.UtilFunctions;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import static features.Hooks.driver;

/**
 * Created by PatientKeeper on 7/6/2016.
 */

/******************************************************************************
 Class Name: PatientListChargesStepdefs
 Contains step definitions related to patient list charge page
 ******************************************************************************/

public class PatientListChargesStepdefs {

    public String className = getClass().getSimpleName();

    @Given("^patient \"(.*?)\" has no charges$")
    public void patientHasNoCharges(String patientName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        Assert.assertTrue("Patient: " + patientName + " not found.", PatientListPage.selectPatientByName(Hooks.getDriver(), patientName));
        Assert.assertTrue("Charges Navigation Button not found.", PatientListPage.selectClinicalNav(Hooks.getDriver(), "Charges"));
        Thread.sleep(2000);
        Assert.assertTrue("Visits Checkbox does not exist", Page.setCheckBox(Hooks.getDriver(),GlobalStepdefs.curTabName,"ShowVisits","uncheck",null));
        Assert.assertTrue("Charges Table does not exist", PatientListPage.checkPatientCharges(Hooks.getDriver(), patientName, "Charges"));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Given("^I set the quantity on the CPT code \"(.*?)\" to \"(.*?)\"$")
    public void setQtyOnCpt(String cpt, String qty) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        Assert.assertTrue("Qty: " + qty + " set unsuccessful on cpt: " + cpt, PatientListPage.setQtyOnCpt(Hooks.getDriver(), "ChargeList", cpt, qty));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Given("^I add the modifier \"(.*?)\" to the CPT code \"(.*?)\"$")
    public void addModifierToCPT(String mod, String cpt) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        Assert.assertTrue("Mod: " + mod + " set unsuccessful on cpt: " + cpt, PatientListPage.addModifierOnCpt(Hooks.getDriver(), "ChargeList", mod, cpt));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Given("^I set the \"(.*?)\" charge header to \"(.*?)\"$")
    public void setChargeHeaders(String name, String value) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        List<List<String>> dataList = Arrays.asList(Arrays.asList("Name", "Value"), Arrays.asList(name, value));
        DataTable dataTable = DataTable.create(dataList);
        PatientListPage.setChargeHeaders(Hooks.getDriver(),dataTable);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I remove (?:the \"(.*?)\"|all the) ICD-10 code(?:s)?(?: in the \"(.*?)\" pane)?$")
    public void removeCodesFromDiagnosisList(String code, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        Assert.assertTrue("ICD Code: " + code + " not removed.", PatientListPage.removeCodesFromDiagnosisList(Hooks.getDriver(), code, paneName));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I remove (?:the \"(.*?)\"|all the) CPT code(?:s)?(?: in the \"(.*?)\" pane)?$")
    public void removeCodesFromCPTList(String code, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        Assert.assertTrue("CPT Code: " + code + " not removed.", PatientListPage.removeCodesFromChargeList(Hooks.getDriver(), code, paneName));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I choose the \"(.*?)\" code( description)? in the \"(.*?)\"( picker)? list in the \"(.*?)\" search section(?: in the \"(.*?)\" pane)?$")
    public void selectCodeInListInSearchSection(String value, String valueType, String list, String listType, String section, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        Assert.assertTrue("Code: " + value + " not selected.", PatientListPage.selectCodeInListInSearchSection(Hooks.getDriver(), value, valueType, list, listType, section, paneName));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I expand the \"(.*?)\"( picker)? list in the \"(.*?)\" search section(?: in the \"(.*?)\" pane)?$")
    public void expandListInSearchSection(String list, String listType, String section, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        PatientListPage.expandListInSearchSection(Hooks.getDriver(), list, listType, section, paneName);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I \"(expand|collapse)\" the \"(.*?)\" search section(?: in the \"(.*?)\" pane)?$")
    public void expandInSearchSection(String operation, String sectionName, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        PatientListPage.expandInSearchSection(Hooks.getDriver(), operation, sectionName, paneName);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    //Accepts optional pane in the below setep defination
    @Given("^I set the following charge headers(?: in the \"(.*)\" pane)?$")
    public void setChargeHeaders(String paneName, DataTable dataTable) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        if (paneName == null)
            Assert.assertEquals("", PatientListPage.setChargeHeaders(Hooks.getDriver(), dataTable, "ChargeEntry"));
        else {
            Assert.assertEquals("", PatientListPage.setChargeHeaders(Hooks.getDriver(), dataTable, paneName));
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    //Accepts optional pane in the below setep defination
    @Given("^I enter the CPT codes? \"(.*?)\"(?: in the \"(.*)\" pane)?$")
    public void enterCPTCodes(String cptCode, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        GlobalStepdefs globalstepdefs = new GlobalStepdefs();
        if (paneName == null){
            globalstepdefs.clickButton("CPT","ChargeEntry", null);
            Assert.assertEquals("", PatientListPage.enterCPTCodes(Hooks.getDriver(), cptCode, "ChargeEntry"));
        } else {
            globalstepdefs.clickButton("CPT", paneName, null);
            Assert.assertEquals("", PatientListPage.enterCPTCodes(Hooks.getDriver(), cptCode, paneName));
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    //Accepts optional pane in the below setep defination
    @Given("^I enter the ICD-10 codes? \"(.*?)\"(?: in the \"(.*)\" pane)?$")
    public void enterICDCodes(String Code, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        if (paneName == null)
            Assert.assertEquals("", PatientListPage.enterICDCodes(Hooks.getDriver(), "ChargeEntry", Code));
        else {
            Assert.assertEquals("", PatientListPage.enterICDCodes(Hooks.getDriver(), paneName, Code));
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @And("^I click the \"(.*?)\" button in the \"(.*?)\" header section(?: in the \"(.*?)\" pane)?$")
    public void clickButtonInHeaderSection(String buttonName, String headName, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        Assert.assertTrue("buttonName: " + buttonName + " not clicked", PatientListPage.clickButtonInHeaderSection(Hooks.getDriver(), buttonName, headName,paneName));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }
    @When("^I select the \"(.*?)\" code(description)? in the (?:Diagnoses|Charges) search list(?: in the \"(.*?)\" pane)?$")
    public void selectFromSearchList(String code,String valueType, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        if (paneName == null)
            paneName= "Charge Entry";
        WebElement reqCode;
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        String paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName.replace(" ", ""), "frame"));
        UtilFunctions.log("PaneFrames: " + paneFrames);
        SeleniumFunctions.selectFrame(driver, paneFrames, "id");
        if (valueType == null) {
            SeleniumFunctions.explicitWait(driver, GlobalConstants.FIVE, "//span[@class='code_text' and text()= '" + code + "' and ancestor::div[@id='results_placeholder']]" + ";xpath");
            reqCode = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//span[@class='code_text' and text()= '" + code + "' and ancestor::div[@id='results_placeholder']]" + ";xpath"));
        }else{
            SeleniumFunctions.explicitWait(driver, GlobalConstants.FIVE, "//*[normalize-space(./text())='" + code + "' and ancestor::div[@id='results_placeholder']]" + ";xpath");
            reqCode = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//*[normalize-space(./text())='" + code + "' and ancestor::div[@id='results_placeholder']]" + ";xpath"));
        }
        if (reqCode != null){
            try{
                reqCode.click();
            }catch(Exception e){
                UtilFunctions.log("Code "+code+" is not selected due to error: "+e.getMessage());
                Assert.assertTrue("Code "+code+" is not selected due to error: "+e.getMessage(), false);
            }
        }else
            Assert.assertTrue("Code "+code+" is not found", false);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I make the \"(.*?)\" code(?:s)? as favorites in the \"(.*?)\" search section(?: in the \"(.*?)\" pane)?$")
    public void makeCodeAsFavorites(String code, String section, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        section=section.replace(" ","");
        if (paneName == null)
            paneName = "ChargeEntry";
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        String paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName.replace(" ", ""), "frame"));
        UtilFunctions.log("PaneFrames: " + paneFrames);
        SeleniumFunctions.selectFrame(driver, paneFrames, "id");
        String[] codeArr = code.split(";");
        String sectionListPath="";
        for (int codeIndex= 0; codeIndex < codeArr.length; codeIndex++ ){
            code=codeArr[codeIndex];
            switch (section){
                case "Diagnoses":
                    sectionListPath = UtilFunctions.getElementFromJSONFile(fileObj, "PANE_SECTIONS." + "DiagnosisList", "path");
                    enterICDCodes(code, null);
                    break;
                case "Charges":
                    sectionListPath = UtilFunctions.getElementFromJSONFile(fileObj, "PANE_SECTIONS." + "ChargeList", "path");
                    enterCPTCodes(code, null);
                    break;
                default:
                    Assert.assertTrue("Search Section is not valid",false);
                    break;
            }
            WebElement selectedList= SeleniumFunctions.findElement(Hooks.getDriver(),SeleniumFunctions.setByValues(sectionListPath + ";xpath"));
            SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.FIVE,"//div[contains(@class, 'favorite_icon clickable')]" + ";xpath");
            WebElement favoriteIcon= SeleniumFunctions.findElementByWebElement(selectedList,SeleniumFunctions.setByValues(".//div[contains(@class, 'favorite_icon clickable')]" + ";xpath"));
            if (favoriteIcon != null){
                WebElement trashIcon= SeleniumFunctions.findElementByWebElement(selectedList,SeleniumFunctions.setByValues(".//div[contains(@class, 'ui-icon-trash')]" + ";xpath"));
                try{
                    favoriteIcon.click();
                    trashIcon.click();
                }catch(Exception e){
                    Assert.assertTrue("Favorite Icon of code "+code+" is not clicked due to error: "+e.getMessage(), false);
                }
            }else{
                Assert.assertTrue("Favorite Icon of code "+code+" is not found", false);
            }

        }
///        if (paneName == null) {
//            PatientListPage.makeCodeAsFavorites(Hooks.getDriver(), code, section, "ChargeEntry");
//        }else{
//            PatientListPage.makeCodeAsFavorites(Hooks.getDriver(), code, section,paneName);
//        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @And ("^I make the \"(.*?)\" modifier as unfavorite in the modifier list( if it exists)?")
    public void selectModifierAsUnfavorite(String mod, String exists) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        GlobalStepdefs globalStepdefs= new GlobalStepdefs();
        globalStepdefs.clickMiscElement("Favorite Mod List",null,"ChargeEntry" ,null);
        WebElement favModList = SeleniumFunctions.findElement(driver,SeleniumFunctions.setByValues(".//div[contains(@class, 'favoriteModifiersList')]" + ";xpath"));
        if (favModList != null) {
            WebElement favModRow = SeleniumFunctions.findElementByWebElement(favModList, SeleniumFunctions.setByValues(".//tr[descendant::a[@class='favCode' and text()='" + mod + "']]" + ";xpath"));
            if (favModRow != null) {
                WebElement favIcon = SeleniumFunctions.findElementByWebElement(favModList, SeleniumFunctions.setByValues(".//div[starts-with(@class, 'modifierFavorite')]" + ";xpath"));
                if (favIcon != null) {
                    try {
                        //favIcon.click();
                        SeleniumFunctions.click(favIcon);
                    } catch (Exception e) {
                        UtilFunctions.log("Modifier " + mod + " is not unfovrited due to error: " + e.getMessage());
                        Assert.assertTrue("Modifier " + mod + " is not unfovrited due to error: " + e.getMessage(), false);
                    }
                } else
                    Assert.assertTrue("Favorite Icon for modifier " + mod + " is not found", false);
            } else {
                UtilFunctions.log("Modifier " + mod + " is not found");
                Assert.assertTrue("Modifier " + mod + " is not found", exists != null);
            }
        } else {
            UtilFunctions.log("Modifier list is not found");
            Assert.assertTrue("Modifier list is not found", exists != null);
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Given("^\"(.*?)\" has a charge with a billing area of \"(.*?)\"$")
    public boolean ChargeHasBillingArea(String patientName, String value) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        GlobalStepdefs globalStepsObj = new GlobalStepdefs();
        PatientListChargesStepdefs patientListChargesStepdefs = new PatientListChargesStepdefs();
        PatientListClinicalsStepdefs patientListClinicalsStepdefs = new PatientListClinicalsStepdefs();
        patientListClinicalsStepdefs.selectPatientFromPatientList(patientName);
        patientListClinicalsStepdefs.selectFromClinicalNavigation("Charges");
        if (Page.checkTableExists(driver, GlobalStepdefs.curTabName, "Charges")) {


            globalStepsObj.selectFromTheTable("the first item", "Charges");
            UtilFunctions.log("Clicking Edit button");
            globalStepsObj.clickButton("Edit", "Charge Detail", null);
            globalStepsObj.checkPaneLoad("ChargeEntry", "load", null);


            if (Page.textExists(Hooks.getDriver(), GlobalStepdefs.curTabName, "Verve", "ChargeEntry")) {
                globalStepsObj.clickMiscElement("Close", null, null, null);

                return true;


            } else {
                patientListChargesStepdefs.setChargeHeaders("Bill Area", "Verve");
                globalStepsObj.clickButton("Submit", "ChargeEntry", null);
                globalStepsObj.clickButton("SaveAsIs", "Confirm", "yes");

            }
        } else {
            globalStepsObj.clickButton("Charges+", null, null);
            patientListChargesStepdefs.setChargeHeaders("Bill Area", "Verve");
            patientListChargesStepdefs.setChargeHeaders("Svc Site", "Inpatient");


            patientListChargesStepdefs.enterCPTCodes("78000", "ChargeEntry");
            patientListChargesStepdefs.enterICDCodes("B65.0", "ChargeEntry");
            globalStepsObj.clickButton("Submit", "ChargeEntry", null);
            Page.textExists(Hooks.getDriver(), GlobalStepdefs.curTabName, "verve", "ChargeDetail");

        }
        return true;
    }
    @Given("^patient \"(.*?)\" has at least one charge$")
    public void patientHasAtleastOneCharge(String patientName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        GlobalStepdefs globalStepsObj = new GlobalStepdefs();
        PatientListChargesStepdefs patientListChargesStepdefs = new PatientListChargesStepdefs();
        PatientListClinicalsStepdefs patientListClinicalsStepdefs = new PatientListClinicalsStepdefs();
        patientListClinicalsStepdefs.selectPatientFromPatientList(patientName);
        patientListClinicalsStepdefs.selectFromClinicalNavigation("Charges");

        if (Page.checkTableExists(driver, GlobalStepdefs.curTabName, "Charges")) {
            globalStepsObj.selectFromTheTable("the first item", "Charges");
            UtilFunctions.log("Patient has a charge already");
        } else {
            UtilFunctions.log("Patient has no charges, associating a charge...");
            globalStepsObj.clickButton("Charges+", null, null);
            patientListChargesStepdefs.setChargeHeaders("Bill Area", "Verve");
            patientListChargesStepdefs.setChargeHeaders("Billing Prov", "USER3, ADDCHARGE");
            patientListChargesStepdefs.setChargeHeaders("Svc Site", "Inpatient");
            patientListChargesStepdefs.enterCPTCodes("78000", "ChargeEntry");
            patientListChargesStepdefs.enterICDCodes("B65.0", "ChargeEntry");
            globalStepsObj.clickButton("Submit", "ChargeEntry", null);
            UtilFunctions.log("charge associated to patient");

            UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
            }.getClass().getEnclosingMethod().getName() + " : Complete");
        }
    }

    @Given("^I select \"(.*?)\" option from more options menu of charge entry pane$")
    public void selectOptionFromMoreOptions(String optionName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
//        String paneFrames = (String) frameMap.get(UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + "ChargeEntry", "frame"));
        String paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + "ChargeEntry", "frame"));
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");
        SeleniumFunctions.explicitWait(Hooks.driver, GlobalConstants.TEN, "//span[@class='ui-icon menudots']" + ";xpath");
        WebElement menu = SeleniumFunctions.findElement(Hooks.driver, SeleniumFunctions.setByValues("//span[@class='ui-icon menudots']" + ";xpath"));
        if (menu != null){
            String optionPath = "//li[normalize-space(./text())='" + optionName + "' and ancestor::ul[@class='options-menu-message-list']]";
            try {
              ((JavascriptExecutor) driver).executeScript("arguments[0].click();", menu);
              Thread.sleep(1000);
              SeleniumFunctions.explicitWait(Hooks.driver, GlobalConstants.TEN, optionPath + ";xpath");
              SeleniumFunctions.findElement(Hooks.driver, SeleniumFunctions.setByValues(optionPath + ";xpath")).click();
              Thread.sleep(1000);
            } catch (Exception e) {
                UtilFunctions.log("Option " + optionName +" is not selected due to exception " + e.getMessage());
                Assert.assertTrue("Option " + optionName +" is not selected due to exception " + e.getMessage(), false);
            }
        } else {
            UtilFunctions.log("More Options element is not found");
            Assert.assertTrue("More Options element is not found", false);
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


}
