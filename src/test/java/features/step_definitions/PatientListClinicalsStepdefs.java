package features.step_definitions;

import common.SeleniumFunctions;
import constants.GlobalConstants;
import cucumber.api.DataTable;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import features.Hooks;
import org.json.simple.JSONObject;
import org.junit.Assert;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import pageObject.PatientListPage;
import pageObject.PatientListV2Page;
import support.Page;
import support.db.DBExecutor;
import utils.UtilFunctions;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;

import static features.Hooks.driver;

/**
 * Created by PatientKeeper on 7/5/2016.
 */

/******************************************************************************
 Class Name: PatientListClinicalsStepdefs
 Contains step definitions related to patient list clinical page
 ******************************************************************************/

public class PatientListClinicalsStepdefs {

    public String className = getClass().getSimpleName();

    @When("^I select patient \"(.*?)\" from the patient list$")
    public void selectPatientFromPatientList(String patientName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        Assert.assertTrue("Patient: " + patientName + " not found.",
                PatientListPage.selectPatientByName(Hooks.getDriver(), patientName));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I select patient at index \"(.*?)\" from the patient list$")
    public void selectPatientFromPatientListByIndex(int index) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        Assert.assertTrue("Patient at index: " + index + " not found.", PatientListPage.selectPatientByIndex(Hooks.getDriver(), index));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @When("^I select \"(.*?)\" from clinical navigation$")
    public void selectFromClinicalNavigation(String selectName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        Assert.assertTrue("Navigation Button: " + selectName + " not found.",
                PatientListPage.selectClinicalNav(Hooks.getDriver(), selectName));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @And("^the \"(.*?)\" image is visible$")
    public void checkIfImageExists(String imageName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String imageXpath;
        WebElement imageElement;
        File image = new File(MessageStepdefs.buildPathTo("Images", imageName));
        FileInputStream imageInput = new FileInputStream(image);
        Assert.assertNotNull(String.format("The image %s does not exists in the current project", imageName), imageInput);

        byte[] byteArr = new byte[(int) image.length()];
        imageInput.read(byteArr);
        String imageBase64 = Base64.getEncoder().encodeToString(byteArr);
        imageXpath = String.format("//img[@src='data:image/jpeg;base64,%s'];xpath", imageBase64);

        SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.TEN, imageXpath);
        imageElement = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues(imageXpath));
        Assert.assertTrue(String.format("The image %s is not visible", imageName), imageElement != null);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    //Accepts optional pane in the below setep defination
    @Given("^I select \"(.*?)\" from clinical navigation in the \"(.*)\" pane?$")
    public void selectFromClinicalNavigation(String selectName, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        if (paneName == null)
            Assert.assertTrue("Navigation Button: " + selectName + " not found.", PatientListPage.selectClinicalNav(Hooks.getDriver(), selectName));
        else {
            Assert.assertTrue("Navigation Button: " + selectName + " not found.", PatientListPage.selectClinicalNav(Hooks.getDriver(), selectName, paneName));
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I refresh the clinical display$")
    public void refreshClinicalDisplay() throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        if(PatientListPage.refreshPatientList(Hooks.getDriver(), "FRAME_PATINFO"))
            Assert.assertTrue("Refresh icon not present and not clicked on 1st try.", true);
        else
            Assert.assertTrue("Refresh image not present and not clicked on 2nd try.",
                    PatientListPage.refreshPatientList(Hooks.getDriver(), "FRAME_PATINFO"));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @And("^the following clinical navigation options should( not)? be available$")
    public void checkClinicalNavigation(String no, DataTable dataTable) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        Assert.assertNotNull("Empty dataTable provided in cucumber step.", dataTable);
        if (dataTable != null) {
            List<String> dataList = dataTable.asList(String.class);
            if (dataList != null && dataList.size() > 0) {
                for (String selectName : dataList) {
                    UtilFunctions.log("Navigation Link to be checked: " + selectName);
                    if (no == null) {
                        Assert.assertTrue("Navigation Link: " + selectName + "not found.", PatientListPage.checkClinicalNav(Hooks.getDriver(), selectName));
                    } else {
                        Assert.assertFalse("Navigation Link: " + selectName + " found.", PatientListPage.checkClinicalNav(Hooks.getDriver(), selectName));
                    }
                }
                UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
                }.getClass().getEnclosingMethod().getName() + " : Complete");
            } else {
                Assert.assertTrue("dataList is null or empty.", false);
            }
        }
    }


    @And("^New Results display options are set$")
    public void setNewResultsOptions() throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        GlobalStepdefs globalStepsObj = new GlobalStepdefs();
        SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.TEN,
                "//div[@id='titleBar' and text()='Display Options']" + ";xpath");
        WebElement okRef = SeleniumFunctions.findElement(Hooks.getDriver(), By.xpath("//span[@pkwidget='Button' and text()='OK']"));
        if (okRef != null && okRef.isDisplayed()) {
            globalStepsObj.clickButton("OK", "", null);
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @And("^I add \"(.*)\" problem(?:s)? to the \"(.*)\" patient$")
    public void problemsToPatient(String problems, String patientName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        GlobalStepdefs globalStepsObj = new GlobalStepdefs();
        PatientListPage.selectPatientByName(Hooks.getDriver(), patientName);
        PatientListPage.selectClinicalNav(Hooks.getDriver(), problems);
        String[] problemsArr = problems.split(";");
        String paneFrames;
        for (String problem : problemsArr) {
            globalStepsObj.selectFromMenu("Add Problem", "Patient Header Actions", null, null);
            JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
            HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
            String probAddPane = "AddProblem";
            String panePath = UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + probAddPane, "path");
            SeleniumFunctions.selectFrame(Hooks.getDriver(), panePath, "id");
            globalStepsObj.clickButton("Find Problem", "AddProblem", null);
            globalStepsObj.waitGivenTime("5");
            globalStepsObj.enterInTheField(problem, "Problem Search Field", null);
            globalStepsObj.waitGivenTime("5");
            globalStepsObj.clickMiscElement("Add As Free Text", null, "Problem Selection", "");
//            globalStepsObj.clickLinkInPane("Add as Free Text","","","Problem Selection");

            paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + probAddPane, "frame"));
            UtilFunctions.log("PaneFrames: " + paneFrames);
            SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");
            UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + probAddPane, "path");
            globalStepsObj.clickButton("Save Problem", "AddProblem", null);
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I select the patient \"(.*)\" with index \"(.*)\" from the patient list$")
    public void selectPatientWithIndexFromPatientList(String patientName, Integer index) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        Assert.assertTrue("Patient: " + patientName + " not found.", PatientListPage.selectPatientByNameAndIndex(Hooks.getDriver(), patientName, index));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Given("^patient \"(.*?)\" has at least one problem$")
    public void patientHasAtleastOneCharge(String patientName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        GlobalStepdefs globalStepsObj = new GlobalStepdefs();
        PatientListChargesStepdefs patientListChargesStepdefs = new PatientListChargesStepdefs();
        PatientListClinicalsStepdefs patientListClinicalsStepdefs = new PatientListClinicalsStepdefs();
        patientListClinicalsStepdefs.selectPatientFromPatientList(patientName);
        patientListClinicalsStepdefs.selectFromClinicalNavigation("Problems");

        if (Page.checkTableExists(driver, GlobalStepdefs.curTabName, "Problem List")) {
            globalStepsObj.selectFromTheTable("the first item", "Problem List");
            UtilFunctions.log("Patient has a problem already");
        } else {
            UtilFunctions.log("Patient has no problems, associating a problem...");
            globalStepsObj.selectFromMenu("Add Problem", "Patient Header Actions", null, null);
            JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
            HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
            String probAddPane = "AddProblem";
            String panePath = UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + probAddPane, "path");
            SeleniumFunctions.selectFrame(Hooks.getDriver(), panePath, "id");
            globalStepsObj.clickButton("Find Problem", "AddProblem", null);
            globalStepsObj.waitGivenTime("5");
            globalStepsObj.enterInTheField("kidney", "Problem Search Field", null);
            globalStepsObj.waitGivenTime("5");
            globalStepsObj.clickMiscElement("Add As Free Text", null, "Problem Selection", "");
//            globalStepsObj.clickLinkInPane("Add as Free Text","","","Problem Selection");

            String paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + probAddPane, "frame"));
            UtilFunctions.log("PaneFrames: " + paneFrames);
            SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");
            UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + probAddPane, "path");
            globalStepsObj.clickButton("Save Problem", "AddProblem", null);
            UtilFunctions.log("Problem associated to patient");

            UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
            }.getClass().getEnclosingMethod().getName() + " : Complete");
        }
    }

    @Given("the \"(.*?)\" field in the \"(.*?)\" clinical detail pane should match the first item in the \"(.*?)\" column in the \"(.*?)\" table$")
    public void clinicalDetailFieldAgainstTable(String fieldValue, String paneName, String colName, String tableName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String tableCellValue;
        paneName = paneName.replaceAll(" ", "");
        tableName = tableName.replaceAll(" ", "");
        // get the field value
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        String paneFrames = (String) frameMap.get(UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
        UtilFunctions.log("PaneFrames: " + paneFrames);
        SeleniumFunctions.selectFrame(driver, paneFrames, "id");
        WebElement clinicalDetailTableHeader = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//table[@id='cedTable']/tbody/tr/td[@class='detailHeader']/table" + ";xpath"));
        String fieldText = SeleniumFunctions.findElementByWebElement(clinicalDetailTableHeader, SeleniumFunctions.setByValues("//td[preceding-sibling::td[@class='fieldLabel' and descendant-or-self::*[starts-with(text(), '" + fieldValue + "')]]]" + ";xpath")).getText().trim();
        // get the table value and compare with field value
        String colIndex = Page.findTableColumn(Hooks.getDriver(), GlobalStepdefs.curTabName, tableName, colName);
        if (colIndex != null) {
            tableCellValue = Page.getTableCellValue(Hooks.getDriver(), GlobalStepdefs.curTabName, tableName, 0, Integer.parseInt(colIndex));
            Assert.assertTrue("Pane title:" + tableCellValue + " is not same as selected value " + tableCellValue + "from table", fieldText.equals(tableCellValue));
        } else {
            Assert.assertTrue("Table column" + colName + " is not the table", false);
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

}


