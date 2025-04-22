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
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.interactions.*;
import org.openqa.selenium.*;
import pageObject.PatientListPage;
import support.Page;
import support.db.DBExecutor;
import utils.UtilFunctions;

import java.text.SimpleDateFormat;
import java.time.Duration;
import java.util.*;

import static features.Hooks.driver;
import static features.step_definitions.GlobalStepdefs.curTabName;
import static support.Page.findTable;

import org.openqa.selenium.support.ui.Select;

/**
 * Created by PatientKeeper on 7/6/2016.
 */

/******************************************************************************
 Class Name: PatientListChargesStepdefs
 Contains step definitions related to patient list charge page
 ******************************************************************************/

public class NoteWriterStepdefs {

    public String className = getClass().getSimpleName();


    @When("^I load the \"(.*?)\" template note for the selected patient(?: in the \"(.*?)\" pane)?$")
    public void loadNWtemplate(String templateName, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        globalStepdefs.selectFromMenu("Write Note", "Patient Header Actions", null, null);
        //Added sleep b/c sometimes the "Write A Note" pane is slow to display
        Thread.sleep(2000);
        Assert.assertTrue("Template: " + templateName + " not present.",
                PatientListPage.selectNoteWriterTemplate(templateName, paneName, null));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @And("^the following templates should be available to select(?: in the \"(.*?)\" pane)?$")
    public void verifyNWTemplateList(String paneName, DataTable dataTable) {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        List<String> dataList = dataTable.asList(String.class);
        for (String templateName : dataList) {
            Assert.assertNotNull("Note template: '" + templateName + "' is NULL, does not exist.",
                    PatientListPage.findNoteWriterTemplate(templateName, paneName));
            UtilFunctions.log("Note template: '" + templateName + "' FOUND and exists.");
            System.out.println("Note template: '" + templateName + "' FOUND and exists.");
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    //And only the following note templates should be available to select
    @And("^only the following note templates should be available to select$")
    public void checkForTheseTemplatesOnly(DataTable dataTable) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        Assert.assertTrue("The onscreen template list and the given list are not the same.",
                Page.checkForTheseNoteTemplatesOnly(Hooks.getDriver(), dataTable));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    //Then the selection in the "Select a Visit" dropdown should contain "Inpatient"
    @And("^the selection in the \"(.*?)\" dropdown(?: in the \"(.*?)\" pane)? should contain \"(.*?)\"$")
    public void checkSelectionInDropdown(String dropdownName, String paneName, String value) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String paneFrame;
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);

        dropdownName = dropdownName.replace(" ", "");
        if (paneName == null) {
            paneFrame = UtilFunctions.getFrameValue(frameMap,
                    UtilFunctions.getElementFromJSONFile(fileObj, "DROPDOWNS." + dropdownName, "frame"));
            SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
        } else {
            paneName = paneName.replace(" ", "");
            paneFrame = (String) frameMap.get(UtilFunctions.getElementFromJSONFile(fileObj,
                    "PANES." + paneName, "frame"));
            SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
        }

        String dropdownID = UtilFunctions.getElementFromJSONFile(fileObj,
                "DROPDOWNS." + dropdownName, "id");
        String method = ";id";
        WebElement dropdownElement = Page.getDropDown(dropdownID, method);

        if (dropdownElement != null) {
            Select select = new Select(dropdownElement);
            WebElement selectedOption = select.getFirstSelectedOption();
            if (selectedOption.getText().toUpperCase().contains(value.toUpperCase())) {
                Assert.assertTrue("Value '" + value + "' selected in dropdown: " + dropdownName, true);
                UtilFunctions.log("Value '" + value + "' selected in dropdown: " + dropdownName);
                System.out.println("Value '" + value + "' selected in dropdown: " + dropdownName);
            } else {
                UtilFunctions.log("Value '" + value + "' NOT selected in dropdown: " + dropdownName);
                System.out.println("Value '" + value + "' NOT selected in dropdown: " + dropdownName);
                Assert.assertTrue("Value '" + value + "' NOT selected in dropdown: " +
                        dropdownName, selectedOption.getText().toUpperCase().contains(value.toUpperCase()));
            }
        } else {
            UtilFunctions.log("Dropdown '" + dropdownName + "' is NULL and can't be found.");
            System.out.println("Dropdown '" + dropdownName + "' is NULL and can't be found.");
            Assert.assertNotNull("Dropdown '" + dropdownName + "' is NULL and can't be found.", dropdownElement);
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    //And I select an ".*" visit from the "Select a Visit" dropdown
    @And("^I select a(?:n)? \"(.*?)\" visit from the \"(.*?)\" dropdown(?: in the \"(.*?)\" pane)?$")
    public void selectVisitFromDropdown(String visitType, String dropdownName, String paneName) {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String paneFrame;
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);

        dropdownName = dropdownName.replace(" ", "");
        if (paneName == null) {
            paneFrame = UtilFunctions.getFrameValue(frameMap,
                    UtilFunctions.getElementFromJSONFile(fileObj, "DROPDOWNS." + dropdownName, "frame"));
            SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
        } else {
            paneName = paneName.replace(" ", "");
            paneFrame = (String) frameMap.get(UtilFunctions.getElementFromJSONFile(fileObj,
                    "PANES." + paneName, "frame"));
            SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
        }

        String dropdownID = UtilFunctions.getElementFromJSONFile(fileObj,
                "DROPDOWNS." + dropdownName, "id");
        String method = ";id";
        WebElement dropdownElement = Page.getDropDown(dropdownID, method);

        if (dropdownElement != null) {
            Select select = new Select(dropdownElement);
            List<WebElement> selectOptions = select.getOptions();
            for (WebElement option : selectOptions) {
                if (option.getText().toUpperCase().contains(visitType.toUpperCase()))
                    select.selectByVisibleText(option.getText());
                if (option.isSelected()) {
                    Assert.assertTrue("Visit type '" + visitType + "' NOT selected from dropdown: " +
                            dropdownName, option.isSelected());
                    System.out.println("Visit type '" + visitType + "' selected from dropdown: " +
                            dropdownName);
                    UtilFunctions.log("Visit type '" + visitType + "' selected from dropdown: " +
                            dropdownName);
                    break;
                }
            }
        } else {
            UtilFunctions.log("Dropdown '" + dropdownName + "' is NULL and can't be found.");
            System.out.println("Dropdown '" + dropdownName + "' is NULL and can't be found.");
            Assert.assertNotNull("Dropdown '" + dropdownName + "' is NULL and can't be found.", dropdownElement);
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @When("^I select the note \"(.*?)\" section(?: in the \"(.*?)\" pane)?$")
    public void selectNoteSection(String sectionName, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        String paneFrames;
        if (paneName == null)
            paneFrames = "FRAME_NOTEWRITER_MAIN";
        else {
            JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
            paneFrames = UtilFunctions.getElementFromJSONFile(fileObj, "PANES." +
                    paneName.replace(" ", ""), "frame");
        }
        paneFrames = UtilFunctions.getFrameValue(frameMap, paneFrames);
        UtilFunctions.log("PaneFrames: " + paneFrames);
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");

        SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.TEN, "//a[text()='" + sectionName + "']"
                + ";xpath");
        /*WebElement link = SeleniumFunctions.findElement(Hooks.getDriver(),
                SeleniumFunctions.setByValues("//a[text()='" + sectionName + "']" + ";xpath"));*/
        WebElement link = SeleniumFunctions.findElement(Hooks.getDriver(),
                SeleniumFunctions.setByValues("//li[contains(@class, 'ProgressBarTab') and descendant::a[text()='" +
                        sectionName + "']]" + ";xpath"));
        Assert.assertNotNull(sectionName + " Element link is null.", link);
        UtilFunctions.log(sectionName + " Element link is present. Clicking now.");
        SeleniumFunctions.scrollIntoView(link);

        WebDriver driver = Hooks.getDriver();
        JavascriptExecutor jsExecutor = (JavascriptExecutor) driver;
        Actions actions = new Actions(driver);
        try {
            link.click();
            Thread.sleep(500);
            //Sometimes first click doesn't successfully select the section.  Retry a few times
            int retryCount = 0;
            while (!SeleniumFunctions.isSelected(link) && retryCount < 5) {
                link.click();
                Thread.sleep(200);
                retryCount++;
            }
            //Try click via javascript if still not selected
            if (!SeleniumFunctions.isSelected(link)) {
                jsExecutor.executeScript("arguments[0].click();", link);
                Thread.sleep(500);
                if (!SeleniumFunctions.isSelected(link)) {
                    actions.moveToElement(link).click().build().perform();
                }
            }
        } catch (ElementNotInteractableException e) {
            jsExecutor.executeScript("arguments[0].click();", link);
            Thread.sleep(500);
            if (!SeleniumFunctions.isSelected(link)) {
                actions.moveToElement(link).click().build().perform();
            }
        }
        Thread.sleep(500);

        Assert.assertTrue(sectionName + " note subtab not clicked.", SeleniumFunctions.isSelected(link));

        //This will just find the active link, which may not be the same link.
        /*SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.TEN,
                "//li[@class = 'ProgressBarTab active' and descendant::a[text()='" + sectionName + "']]" + ";xpath");*/
        /*WebElement activeSection = SeleniumFunctions.findElement(driver,
                SeleniumFunctions.setByValues("//li[@class = 'ProgressBarTab active']/a"));
        if (!activeSection.getText().equals(sectionName)) {
            link.click();
        }*/

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    /*   as per DEV-DEV-83107, problem need to be added in A/P section, so adding steps to enter problem. Also diagnosis search text field id changes
    for different notes so modified step def to read note type from user and added conditions ccordingly
    */
    @When("^I sign/submit the \"(.*?)\" note(?: in the \"(.*?)\" pane)?$")
    public void signSubmit(String noteType, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        if (paneName == null)
            paneName = "NoteWriterMain";

        selectNoteSection("A/P", paneName);
        globalStepdefs.waitForFieldAttributeValue("4", "DiagnosisSearch", "PANE", paneName, "be visible", null, null);

        if (noteType.equals("Progress Note")) {
            Page.setTextBox(Hooks.getDriver(), curTabName, "R52", "PN Diagnosis Search");
            selectFromTheList("Pain", "AP Problem Picker", "if it exists");
        } else if (noteType.equals("History and Physical")) {
            Page.setTextBox(Hooks.getDriver(), curTabName, "R52", "AP Diagnosis Search");
            selectFromTheList("Pain", "AP Problem Picker", "if it exists");
        } else if (!(noteType.contains("HCA")))
            Page.selectDropDownInPane(Hooks.driver, curTabName, "Moderate", "LevelOfDecision");

        Page.clickButton(Hooks.getDriver(), curTabName, "NoteWriterSign/Submit", paneName);
        globalStepdefs.waitGivenTime("2");
        //This Page.clickButton(), when run in IE, often comes back true, but the button is not getting clicked.
        Page.clickButton(Hooks.getDriver(), curTabName, "OKSignSubmit", "SignSubmitNote");

        //Ensure the Sign/Submit dialog closes, even in IE.  If not, click the OKSignSubmit btn again.
        if (Page.checkElementExists(Hooks.getDriver(), GlobalStepdefs.curTabName, "OKSignSubmit", "BUTTONS")) {
            HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
            JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
            String paneFrames = UtilFunctions.getFrameValue(frameMap,
                    UtilFunctions.getElementFromJSONFile(fileObj, "BUTTONS." + "OKSignSubmit", "frame"));
            SeleniumFunctions.selectFrame(driver, paneFrames, "id");
            String buttonPath = UtilFunctions.getElementFromJSONFile(fileObj, "BUTTONS." + "OKSignSubmit", "path");

            WebElement btnObj = SeleniumFunctions.findElement(driver, By.xpath(buttonPath));
            Assert.assertNotNull("The 'OK Sign/Submit' note button is null and not found. Note not signed and submitted.", btnObj);
            if (btnObj.isDisplayed()) {
                btnObj.click();
                Thread.sleep(500);
                if (Page.checkElementExists(Hooks.getDriver(), GlobalStepdefs.curTabName, "OKSignSubmit", "BUTTONS")) {
                    SeleniumFunctions.click(btnObj);
                    Thread.sleep(500);
                    if (Page.checkElementExists(Hooks.getDriver(), GlobalStepdefs.curTabName, "OKSignSubmit", "BUTTONS")) {
                        Actions actions = new Actions(Hooks.getDriver());
                        actions.moveToElement(btnObj).click().build().perform();
                        Thread.sleep(500);
                    }
                }
            }
        }
        Assert.assertFalse("The 'OK Sign/Submit' note button is still on screen and not clicked. Note not signed and submitted.",
                Page.checkElementExists(Hooks.getDriver(), GlobalStepdefs.curTabName, "OKSignSubmit", "BUTTONS"));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I save the template as Draft$")
    public void saveTemplate() throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        globalStepdefs.clickButton("Save as Draft", null, null);
//        globalStepdefs.waitGivenTime("3");
        globalStepdefs.checkPaneLoad("Question", "load", "5");
        globalStepdefs.clickButton("Yes", "Question", null);
        globalStepdefs.checkPaneLoad("Note Writer Form", "close", null);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @When("^I save the HCA note template as draft$")
    public void saveHCANoteTemplate() throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        globalStepdefs.mouseOverAndClick("Save as Draft", "button", "Popout Wizard");
        globalStepdefs.clickButton("Save as Draft", null, "if it exists");
        globalStepdefs.checkPaneLoad("Question", "load", "10");
        globalStepdefs.clickButton("Yes", "Question", null);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I delete the draft note in the \"(.*?)\" pane$")
    public void deleteDraft(String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        globalStepdefs.clickButton("Delete", paneName, null);
        globalStepdefs.clickButton("Yes", "Question", null);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @Then("^I delete all the draft notes(?: in the \"(.*?)\" pane)?$")
    public void deleteAllDraftNotes(String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        //Check if the Clinical Notes table has any notes with the word "*DRAFT*"
        while (Page.selectFromTableByValue(Hooks.getDriver(), GlobalStepdefs.curTabName, "ClinicalNotes",
                "Note Type", "*DRAFT*")) {
            if (Page.clickButton(Hooks.getDriver(), GlobalStepdefs.curTabName, "DeleteNote")) {
                Page.clickButton(Hooks.getDriver(), GlobalStepdefs.curTabName, "Yes", "Question");
            }
        }

        Assert.assertFalse("\"ClinicalNotes\" table still has Draft Notes that weren't deleted.",
                Page.selectFromTableByValue(Hooks.getDriver(), GlobalStepdefs.curTabName, "ClinicalNotes",
                        "Note Type", "*DRAFT*"));
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @Then("^I doubleClick on the searchtext in the \"(.*?)\" pane$")
    public void doubleClickOnSearchText(String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
        UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName.replace(" ", ""), "frame");

        //pass the Xpath value of search Text
        // searchtext= $curTab.findElementByXPath("span[@class='text-search-highlight text-search-active-highlight']")
        SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.TEN, "//span[contains(@class, 'text-search-highlight text-search-active-highlight')]" + ";xpath");
        WebElement searchText = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//span[contains(@class, 'text-search-highlight text-search-active-highlight')]" + ";xpath"));
        Assert.assertNotNull("Search text is null.", searchText);
        SeleniumFunctions.doubleClick(Hooks.getDriver(), searchText);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @When("^I select (auto-popout template )?\"(.*?)\" from the select template list(?: in the \"(.*?)\" pane)?$")
    public void selectNoteWriterTemplate(String autoPopout, String templateName, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        Assert.assertTrue("Template: " + templateName + " not present.",
                PatientListPage.selectNoteWriterTemplate(templateName, paneName, autoPopout));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @When("^I enter \"(.*)\" in the \"(.*)\" (free|rich) text field(?: in the \"(.*)\" pane)?$")
    public void enterDataInRichTextField(String value, String fieldName, String type, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        fieldName = fieldName.replace(" ", "");
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        String paneFrame;
        if (paneName == null) {
            paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "TEXT_FIELDS." + fieldName, "frame"));
            SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
        } else {
            paneName = paneName.replace(" ", "");
            paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
            SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
        }
        if (type.equals("rich")) {
            String[] elementType = UtilFunctions.getElementStringAndType(fileObj, "TEXT_FIELDS." + fieldName);
            String textPath = elementType[0];
            SeleniumFunctions.selectFrame(driver, paneFrame, "id");
            WebElement txtObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(textPath));
            txtObj.sendKeys(Keys.SPACE);
            txtObj.sendKeys(value);
            txtObj.sendKeys(Keys.ENTER);
        } else if (type.equals("free")) {
            SeleniumFunctions.selectFrame(driver, paneFrame, "id");
            //Below code compatible for 8.3.0
            //WebElement txtObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//input[@class='cke-qtt-input cke-quicktexttag-component']" + ";xpath"));
            //Below code compatible for 8.3.1
            WebElement txtObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//input[@class='cke-qtt-input cke-quicktexttag-component cke_enable_context_menu']" + ";xpath"));
            txtObj.click();
//            txtObj.clear();
            SeleniumFunctions.clear(Hooks.getDriver(), txtObj);

            txtObj.sendKeys(value);
            txtObj.sendKeys(Keys.ENTER);
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I click the \"(.*?)\" key in the \"(.*)\" (?:rich )?text field(?: in the \"(.*?)\" pane)?$")
    public void keyBordEntryInRichTextField(String keyName, String fieldName, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        String paneFrame;
        if (paneName == null) {
            paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "TEXT_FIELDS." + fieldName.replace(" ", ""), "frame"));
            SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
        } else {
            paneName = paneName.replace(" ", "");
            paneFrame = (String) frameMap.get(UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
            SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
        }
        String[] elementType = UtilFunctions.getElementStringAndType(fileObj, "TEXT_FIELDS." + fieldName.replace(" ", ""));
        String textPath = elementType[0];
        String textMethod = elementType[1];

        SeleniumFunctions.selectFrame(driver, paneFrame, "id");
        WebElement txtObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(textPath));

        if (txtObj == null) {
            txtObj = Page.findTextBox(driver, textPath, textMethod);
        }
//        txtObj.click();
        keyName = keyName.toUpperCase();
        switch (keyName) {
            case "ENTER":
                txtObj.sendKeys(Keys.ENTER);
                break;
            case "CONTROL + ENTER":
            case "CTRL + ENTER":
            case "ENTER + CTRL":
            case "ENTER + CONTROL":
                txtObj.sendKeys(Keys.CONTROL + "ENTER");
                break;
            case "SPACE":
            case "SPACEBAR":
                txtObj.sendKeys(Keys.SPACE);
                break;
            case "BACKSPACE":
            case "BACK SPACE":
            case "BACK-SPACE":
            case "BACK_SPACE":
                txtObj.sendKeys(Keys.BACK_SPACE);
                break;
            case "TAB":
                txtObj.sendKeys(Keys.TAB);
                break;
            case "TAB + SHIFT":
            case "SHIFT + TAB":
                txtObj.sendKeys(Keys.TAB + "SHIFT");
                break;
            case "CTRL ALL":
            case "CTRL A":
            case "CTRL + A":
            case "CONTROL ALL":
            case "CONTROL A":
            case "CONTROL + A":
                txtObj.sendKeys(Keys.CONTROL + "a");
                break;
            case "BOLD":
            case "CTRL B":
            case "CTRL + B":
            case "CONTROL B":
            case "CONTROL + B":
                txtObj.sendKeys(Keys.CONTROL + "b");
                break;
            case "ARROW_DOWN":
            case "ARROW-DOWN":
            case "ARROW DOWN":
            case "DOWN":
            case "DOWN ARROW":
            case "DOWN-ARROW":
            case "DOWN ARROW KEY":
            case "DOWN KEY":
                txtObj.sendKeys(Keys.ARROW_DOWN);
                break;
            case "CTRL + ARROW_DOWN":
            case "CTRL + ARROW-DOWN":
            case "CTRL + ARROW DOWN":
            case "CTRL + DOWN":
            case "CTRL + DOWN ARROW":
            case "CTRL + DOWN KEY":
            case "CONTROL + ARROW_DOWN":
            case "CONTROL + ARROW-DOWN":
            case "CONTROL + ARROW DOWN":
            case "CONTROL + DOWN":
            case "CONTROL + DOWN-ARROW":
            case "CONTROL + DOWN ARROW":
            case "CONTROL + DOWN KEY":
                txtObj.sendKeys(Keys.ARROW_DOWN + "CONTROL");
                break;
            case "ARROW_UP":
            case "ARROW-UP":
            case "ARROW UP":
            case "UP":
            case "UP ARROW":
            case "UP-ARROW":
            case "UP ARROW KEY":
            case "UP KEY":
                txtObj.sendKeys(Keys.ARROW_UP);
                break;
            case "CTRL + ARROW_UP":
            case "CTRL + ARROW-UP":
            case "CTRL + ARROW UP":
            case "CTRL + UP":
            case "CTRL + UP ARROW":
            case "CTRL + UP KEY":
            case "CONTROL + ARROW_UP":
            case "CONTROL + ARROW-UP":
            case "CONTROL + ARROW UP":
            case "CONTROL + UP":
            case "CONTROL + UP-ARROW":
            case "CONTROL + UP ARROW":
            case "CONTROL + UP KEY":
                txtObj.sendKeys(Keys.ARROW_UP + "CONTROL");
                break;
            case "ESC":
                txtObj.sendKeys(Keys.ESCAPE);
                break;
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^I highlight the text in the \"(.*?)\" pane$")
    public void highlightedTheText(String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        paneName = paneName.replace(" ", "");
        String paneFrame = (String) frameMap.get(UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");

        WebElement searchText = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//div[@id='SelectedText']" + ";xpath"));
        Assert.assertNotNull("Search text is null.", searchText);
        //pass the ID value when id changes
        String value = "SelectedText";
        SeleniumFunctions.highlightText(value);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I click the \"(.*?)\" (textbox|list) in the rich text field$")
    public void clickTheFreeText(String value, String type) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        if (type.equals("textbox")) {
            WebElement searchText = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//span[@data-widget='qtTag_freeText' and contains(text(),'" + value + "')]" + ";xpath"));
            Assert.assertNotNull("Not able to found " + value, searchText);
            searchText.click();
            Thread.sleep(500);
        } else if (type.equals("list")) {
            WebElement searchText = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//span[@data-widget='qtTag_singleSelect' and contains(text(),'" + value + "')]" + ";xpath"));
            Assert.assertNotNull("Not able to found " + value, searchText);
//            searchText.click();
//            JavascriptExecutor jsExecutor = (JavascriptExecutor) driver;
//            jsExecutor.executeScript("arguments[0].scrollIntoView(true)", searchText);
//            Thread.sleep(500);
//            searchText.click();
            Actions actions = new Actions(driver);
            actions.moveToElement(searchText).click().perform();
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I select \"(.*?)\" option from the \"(.*?)\" list( if it exists)?$")
    public void selectFromTheList(String option, String listName, String exists) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        listName = listName.replace(" ", "");
        WebElement searchText = null;
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "MISC_ELEMENTS." + listName, "frame"));
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
        searchText = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//li[descendant-or-self::*[contains(text(),'" + option + "')]]" + ";xpath"));
        if (exists == null) {
            Assert.assertNotNull("Not able to found " + option + " from the list", searchText);
            try {

                searchText.click();
            } catch (ElementNotInteractableException exc) {
                String xpath = UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(curTabName, "MISC_ELEMENTS", listName, "path", "", "");
                WebElement listObj = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues(xpath + ";xpath"));
                listObj.click();
                Thread.sleep(500);
                searchText = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//li[descendant-or-self::*[contains(text(),'" + option + "')]]" + ";xpath"));
                searchText.click();
            }
        } else {
            if (searchText != null) {
                searchText.click();
            } else {
                UtilFunctions.log(option + "not found. Hence not clicked");
            }
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I drag the text \"(.*?)\" from the \"(.*?)\" clinical order to hospital course text field$")
    public void dragClinicalOrder(String value, String clinicalOrder) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        Calendar cal = Calendar.getInstance();
        SimpleDateFormat dateConvertor = new SimpleDateFormat("MM/dd/yy");
        Date refDate = dateConvertor.parse(dateConvertor.format(cal.getTime()));
        value = UtilFunctions.convertDateThruRegExWithRefDate(value, refDate);
        UtilFunctions.log("Formatted text is " + value);
        WebElement sourceElement = SeleniumFunctions.findElement(Hooks.getDriver(), By.xpath("//div[contains(@id, '" + clinicalOrder + "') and contains(@class, 'accordionHeader') and child::span[contains(text(),'" + value + "')]]"));
        WebElement targetElement = SeleniumFunctions.findElement(Hooks.getDriver(), By.xpath("//div[@role='textbox' and @testid='it_HospitalCourseTextArea']"));

        ((JavascriptExecutor) driver).executeScript("arguments[0].scrollIntoView(true)", sourceElement);
        Actions action = new Actions(driver);
        action.clickAndHold(sourceElement).pause(Duration.ofSeconds(2)).release(targetElement).perform();
        // Page.dragAndDrop(Hooks.getDriver(), sourceElement, targetElement);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^I press the \"(.*?)\" key \"(.*?)\" time(?:s)? in the \"(.*)\" (?:rich )?text field$")
    public void pressKeyBordEntryMultipleTimes(String keyName, int times, String fieldName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        for (int i = 1; i <= times; i++) {
            keyBordEntryInRichTextField(keyName, fieldName, null);
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @And("^I click the \"(.*?)\" abc link in the \"(.*?)\" section of the \"(.*?)\" template$")
    public void clickABCLink(String linkName, String sectionName, String templateName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        NoteWriterStepdefs noteWriterStepdefs = new NoteWriterStepdefs();
        noteWriterStepdefs.loadNWtemplate(templateName, null);

        globalStepdefs.clickButton("OK", "Information", "if it exists");
        noteWriterStepdefs.selectNoteSection(sectionName, null);

        globalStepdefs.clickMiscElement(linkName, null, "NoteWriter", null);
        globalStepdefs.checkPaneLoad("ClickToInsertV2", "load", null);
        globalStepdefs.clickButton("ManageQuickText", null, null);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @When("^I click the \"(.*?)\" quicktext in the \"(.*)\" pane$")
    public void clickTheQuickTextInThePane(String quickTextName, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        paneName = paneName.replace(" ", "");
        String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
        Thread.sleep(3000);
        WebElement quickText = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//li[@class='quicktext-item' and @data-name='" + quickTextName + "']" + ";xpath"));
        Assert.assertNotNull("Not able to found " + quickTextName + " from the list", quickText);
        //quickText.click();
        SeleniumFunctions.click(quickText);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I drag the \"(.*?)\" quick text from group \"(.*?)\" to group \"(.*?)\"$")
    public void dragQuickTextToGroup(String quickTextName, String fromGroupName, String toGroupName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        clickTheQuickTextInThePane(quickTextName, "AddQuickTextV2left");
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        String paneName = "AddQuickTextV2left";
        paneName = paneName.replace(" ", "");
        String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");

        WebElement sourceElement = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//span[@class='drag_handle' and parent::li[@data-name='" + quickTextName + "' and parent::ul[@data-viewname='" + fromGroupName + "']]]"));
        WebElement targetElement = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//ul[@data-viewname='" + toGroupName + "']/li[@class='quicktext-item qtPlaceholder qtManualPlaceholder']"));
        //Assert.assertNotNull("Not able to found " + sourceElement + " " + targetElement + " from the list");

        Assert.assertNotNull("quick text " + quickTextName + " not found in the list " + fromGroupName, sourceElement);
        Assert.assertNotNull("group " + toGroupName + " not found to move the quick text", targetElement);
        Page.dragAndDrop(Hooks.getDriver(), sourceElement, targetElement);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^the underlined color of the (text|list) should be (blue|red) (?:before|on) editing$")
    public void verifyUnderlinedColor(String name, String type) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        String paneName = "PatientNarrativeQTV2";
        paneName = paneName.replace(" ", "");
        String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");

        if (name.equals("text")) {
            switch (type) {
                case "blue":
                    WebElement uiColorblue = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//span[@data-widget='qtTag_freeText' and (not(contains(@class, 'qt-error')))]"));
                    Assert.assertNotNull(uiColorblue);
                    break;
                case "red":
                    WebElement uiColorred = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//span[@data-widget='qtTag_freeText' and contains(@class, 'qt-error')]"));
                    Assert.assertNotNull(uiColorred);
                    break;
            }
        } else if (name.equals("list")) {
            switch (type) {
                case "blue":
                    WebElement uiColor = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//span[@data-widget='qtTag_singleSelect' and (not(contains(@class, 'qt-error')))]"));
                    Assert.assertNotNull(uiColor);
                    break;
                case "red":
                    WebElement uiColorRed = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//span[@data-widget='qtTag_singleSelect' and contains(@class, 'qt-error')]"));
                    Assert.assertNotNull(uiColorRed);
            }

        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I verify the text \"(.*?)\" is (bold|italic|strikethrough|numbered|bulleted|plaintext) in (normal|advanced|other) mode(?: in the \"(.*?)\" pane)?$")
    public void verifyTheTextMode(String text, String type, String mode, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        switch (type) {
            case "bold":
                if (mode.equals("normal")) {

                    String pane = "QTV2Description";

                    String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + pane, "frame"));
                    SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
                    WebElement uiColor = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//div[@role='textbox']/strong[contains(text(),'" + text + "')]" + ";xpath"));
                    Assert.assertNotNull(uiColor);
                    break;

                } else if (mode.equals("other")) {
                    paneName = paneName.replace(" ", "");
                    String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
                    SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
                    WebElement uiColor = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//strong[contains(text(),'" + text + "')]" + ";xpath"));
                    Assert.assertNotNull(uiColor);
                    break;
                } else {
                    String panename = "NoteWriterContentDiv";
                    String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + panename, "frame"));
                    SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
                    WebElement uiColor = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//strong[contains(text(),'" + text + "')]" + ";xpath"));
                    Assert.assertNotNull(uiColor);
                    break;

                }
            case "italic":
                if (mode.equals("normal")) {

                    String pane = "QTV2Description";

                    String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + pane, "frame"));
                    SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
                    WebElement uiColor = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//div[@role='textbox']/em[contains(text(),'" + text + "')]" + ";xpath"));
                    Assert.assertNotNull(uiColor);
                    break;

                } else if (mode.equals("other")) {
                    paneName = paneName.replace(" ", "");
                    String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
                    SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
                    WebElement uiColor = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//div[@role='textbox']/em[contains(text(),'" + text + "')]" + ";xpath"));
                    Assert.assertNotNull(uiColor);
                    break;
                } else {
                    String panename = "NoteWriterContentDiv";
                    String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + panename, "frame"));
                    SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
                    WebElement uiColor = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//em[contains(text(),'" + text + "')]" + ";xpath"));
                    Assert.assertNotNull(uiColor);
                    break;
                }
            case "strikethrough":
                if (mode.equals("normal")) {

                    String pane = "QTV2Description";

                    String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + pane, "frame"));
                    SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
                    WebElement uiColor = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//div[@role='textbox']/s[contains(text(),'" + text + "')]" + ";xpath"));
                    Assert.assertNotNull(uiColor);
                    break;

                } else if (mode.equals("other")) {
                    paneName = paneName.replace(" ", "");
                    String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
                    SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
                    WebElement uiColor = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//div[@role='textbox']/s[contains(text(),'" + text + "')]" + ";xpath"));
                    Assert.assertNotNull(uiColor);
                    break;
                } else {
                    String panename = "NoteWriterContentDiv";
                    String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + panename, "frame"));
                    SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
                    WebElement uiColor = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("div[@id='mainDiv' and child::div and descendant-or-self::s[text() = '" + text + "']]" + ";xpath"));
                    Assert.assertNotNull(uiColor);
                    break;
                }
            case "numbered":
                if (mode.equals("normal")) {

                    String pane = "QTV2Description";

                    String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + pane, "frame"));
                    SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
                    WebElement uiColor = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//div[@role='textbox']/ol/li[contains(text(),'" + text + "')]" + ";xpath"));
                    Assert.assertNotNull(uiColor);
                    break;

                } else if (mode.equals("other")) {
                    paneName = paneName.replace(" ", "");
                    String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
                    SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
                    WebElement uiColor = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//div[@role='textbox']/ol/li[contains(text(),'" + text + "')]" + ";xpath"));
                    Assert.assertNotNull(uiColor);
                    break;
                } else {
                    String panename = "NoteWriterContentDiv";
                    String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + panename, "frame"));
                    SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
                    WebElement uiColor = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//li[contains(text(),'" + text + "')]" + ";xpath"));
                    Assert.assertNotNull(uiColor);
                    break;
                }
            case "bulleted":
                if (mode.equals("normal")) {

                    String pane = "QTV2Description";

                    String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + pane, "frame"));
                    SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
                    WebElement uiColor = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//div[@role='textbox']/ul/li[contains(text(),'" + text + "')]" + ";xpath"));
                    Assert.assertNotNull(uiColor);
                    break;

                } else if (mode.equals("other")) {
                    paneName = paneName.replace(" ", "");
                    String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
                    SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
                    WebElement uiColor = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//div[@role='textbox']/ul/li[contains(text(),'" + text + "')]" + ";xpath"));
                    Assert.assertNotNull(uiColor);
                    break;
                }
            case "plaintext":
                if (mode.equals("normal")) {

                    String pane = "QTV2Description";

                    String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + pane, "frame"));
                    SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
                    WebElement uiColor = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//div[@role='textbox' and text()='" + text + "']" + ";xpath"));
                    Assert.assertNotNull(uiColor);
                    break;

                } else if (mode.equals("other")) {
                    paneName = paneName.replace(" ", "");
                    String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
                    SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
                    WebElement uiColor = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//div[@role='textbox' and contains(text(),'" + text + "')]" + ";xpath"));
                    Assert.assertNotNull(uiColor);
                    break;
                } else {
                    String panename = "NoteWriterContentDiv";
                    String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + panename, "frame"));
                    SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
                    WebElement uiColor = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//li[contains(text(),'" + text + "')]"));
                    Assert.assertNotNull(uiColor);
                    break;
                }

        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @And("^I verify if the text is bold$")
    public void verifyTheTextIsBold() throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        NoteWriterStepdefs noteWriterStepdefs = new NoteWriterStepdefs();
        globalStepdefs.clickMiscElement("Bold", null, null, "");
        noteWriterStepdefs.enterDataInRichTextField("Bold", "QTV2Description", "rich", null);
        verifyTheTextMode("Bold", "bold", "normal", null);
        globalStepdefs.clickMiscElement("Bold", null, null, "");

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @And("^I verify if the text is italics$")
    public void verifyTheTextIsItalics() throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        NoteWriterStepdefs noteWriterStepdefs = new NoteWriterStepdefs();
        globalStepdefs.clickMiscElement("Italic", null, null, "");
        noteWriterStepdefs.enterDataInRichTextField("Italics", "QTV2Description", "rich", null);
        verifyTheTextMode("Italics", "italic", "normal", null);
        globalStepdefs.clickMiscElement("Italic", null, null, "");

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @And("^I verify if the text is strikethrough$")
    public void verifyTheTextIsStrikethrough() throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        NoteWriterStepdefs noteWriterStepdefs = new NoteWriterStepdefs();
        globalStepdefs.clickMiscElement("Strike", null, null, "");
        noteWriterStepdefs.enterDataInRichTextField("Strikethrough", "QTV2Description", "rich", null);
        verifyTheTextMode("Strikethrough", "Strikethrough", "normal", null);
        globalStepdefs.clickMiscElement("Strike", null, null, "");

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @And("^I verify if the text is numbered list$")
    public void verifyTheTextIsNumbered() throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        NoteWriterStepdefs noteWriterStepdefs = new NoteWriterStepdefs();
        globalStepdefs.clickMiscElement("NumberedList", null, null, "");
        noteWriterStepdefs.enterDataInRichTextField("Numbered", "QTV2Description", "rich", null);
        verifyTheTextMode("Numbered", "numbered", "normal", null);
        globalStepdefs.clickMiscElement("NumberedList", null, null, "");

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @And("^I verify if the text is bullet list$")
    public void verifyTheTextIsBullet() throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        NoteWriterStepdefs noteWriterStepdefs = new NoteWriterStepdefs();
        globalStepdefs.clickMiscElement("BulletList", null, null, "");
        noteWriterStepdefs.enterDataInRichTextField("Bulleted", "QTV2Description", "rich", null);
        verifyTheTextMode("Bulleted", "Bulleted", "normal", null);
        globalStepdefs.clickMiscElement("BulletList", null, null, "");

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I move the mouse over the \"(.*?)\" (text|element|image) in the \"(.*?)\" pane( if it exists)?$")
    public void moveMouseAction(String value, String type, String paneName, String exists) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        paneName = paneName.replace(" ", "");
        String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
        Actions actions = new Actions(driver);
        WebElement obj = null;
        if (type.equals("text")) {
            obj = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//*[text() = '" + value + "']" + ";xpath"));
        } else if (type.equals("image")) {
            obj = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//img[contains(@src,'" + value + "')]" + ";xpath"));
        } else if (type.equals("element")) {
            String xpath = UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(curTabName, "MISC_ELEMENTS", value, "path", "", "");
            obj = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues(xpath + ";xpath"));
        }
        if (exists == null)
            Assert.assertNotNull(type + " " + value + " is not found", obj);
        boolean mouseOverStatus = SeleniumFunctions.mouseOver(Hooks.getDriver(), obj);
        Assert.assertTrue("Mouse move on " + type + " " + value + " is not not successful", mouseOverStatus);
//        try {
//            actions.moveToElement(obj).perform();
//        } catch (Exception e) {
//            Assert.assertNotNull("Mouse move on " + type + " " + value + " is not not successful due to exception: " + e.getMessage(), null);
//        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @And("^I verify the tool tip (text|image) \"(.*?)\"(?: for quicktext \"(.*?)\")? in the \"(.*?)\" pane$")
    public void verifyToolTip(String type, String value, String quickText, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        paneName = paneName.replace(" ", "");
        String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
        if (type.equals("text")) {
            WebElement ele = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//li[contains(@class , 'quicktext-item') and @data-name='" + quickText + "']" + ";xpath"));
            String text = ele.getAttribute("title");
            if (text.equals(value)) {
                Assert.assertNotNull(ele);
            }
        } else if (type.equals("image")) {
            WebElement ele = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//img[contains(@src,'" + value + "')]" + ";xpath"));
            Assert.assertNotNull(ele);
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @And("^I add the following (admin )?quick texts?$")
    public void AddMultipleQuickText(String value, DataTable dataTable) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String paneName = "Add Quick Text Content";
        String fieldName = "NameQTV2";
        String buttonName = "SaveNw";
        //if (value.equals("admin ")) {
        if (value != null && value.equals("admin ")) {
            paneName = "EditQuickTextV2Content";
            fieldName = "NameQTV2Quick";
            buttonName = "Save";
        }
        List<Map<String, String>> dataList = dataTable.asMaps(String.class, String.class);
        for (Map data : dataList) {
            String name = (String) data.get("Name");
            String shortcut = (String) data.get("Shortcut");
            GlobalStepdefs globalStepdefs = new GlobalStepdefs();
            globalStepdefs.enterInTheField(name, fieldName, paneName);
            globalStepdefs.enterInTheField(shortcut, "Keyboard Shortcut", paneName);
            globalStepdefs.clickButton(buttonName, paneName, "");
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @And("^I verify the newly created \"(.*?)\" quick text is first in the click to insert list$")
    public void verifyNewTextPosition(String quickText) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        String paneName = "ClickToInsertV2";
        String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
        WebElement ele = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//ul[@class='quicktext-entries']/li[1][text()='" + quickText + "']" + ";xpath"));
        Assert.assertNotNull(ele);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @And("^I click the \"(.*?)\" button in the click to insert \"(.*?)\" popup in the \"(.*?)\" section$")
    public void clickToinsertPopupInSection(String buttonName, String label, String section) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        label = label.replace(" ", "");
        section = section.replace(" ", "");
        String pathId = "";
        switch (section + label) {
            case "ExamRESPIRATORY":
                pathId = "ExamResp__QT_DIV";
                break;
            case "ExamCONSTITUTIONAL":
                pathId = "ExamConstitutional__QT_DIV";
                break;
            case "ExamEENT":
                pathId = "ExamENTMouth__QT_DIV";
                break;
            case "SubjectiveCONSTITUTIONAL":
                pathId = "ROSConstitutional__QT_DIV";
                break;
            case "HistoryChiefComplaint":
                pathId = "Complaint__QT_DIV";
                break;
            case "DataAnnotation":
                pathId = "Annotation__QT_DIV";
                break;
            case "SubjectivePatientnarrative":
                pathId = "PTHistory__QT_DIV";
                break;
            case "HistoryPresentIllness":
                pathId = "HPI__QT_DIV";
                break;
        }
        if (pathId.equals("Annotation__QT_DIV")) {
            JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
            HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
            String paneName = "ClickToInsert";
            String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
            SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
            SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//span[text()='" + buttonName + "' and ancestor::div[@id='Annotation__QT_DIV' and descendant::div[@class='QuickTextSelectorPickers']]]" + ";xpath")).click();
        } else {
            WebElement searchObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(pathId + ";id"));
            SeleniumFunctions.findElementByWebElement(searchObj, SeleniumFunctions.setByValues(".//span[@pkwidget='Button' and text()='" + buttonName + "']" + ";xpath")).click();
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @And("^I enter \"(.*?)\" in the \"(.*?)\" note field$")
    public void clickToinsertPopupInSection(String text, String fieldName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        fieldName = fieldName.replace(" ", "");
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "NOTE_FIELDS." + fieldName, "frame"));
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
        String[] elementType = UtilFunctions.getElementStringAndType(fileObj, "NOTE_FIELDS." + fieldName);
        String textPath = elementType[0];
        SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.TEN, textPath + ";xpath");
        WebElement fieldObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(textPath + ";xpath"));
        fieldObj.click();
        fieldObj.clear();
        fieldObj.sendKeys(text);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I select the \"(.*?)\" in the clinical data$")
    public void selectNoteFromClinicalDatA(String noteName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        String panename = "ClickToInsertV2";
        String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + panename, "frame"));
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
        SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.FIVE, "//div[starts-with(@id, 'ClinicalNotes') and descendant::span[@class='q2' and text()='" + noteName + "']]" + ";xpath");
        WebElement searchObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//div[starts-with(@id, 'ClinicalNotes') and descendant::span[@class='q2' and text()='" + noteName + "']]" + ";xpath"));
        WebElement reqObj = SeleniumFunctions.findElementByWebElement(searchObj, SeleniumFunctions.setByValues("//span[@class='q4 ui-icon ui-icon-plus']" + ";xpath"));
        reqObj.click();

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I select the \"(.*?)\" department and \"(.*?)\" template and click \"(.*?)\" edit link in the NoteWriter pane$")
    public void selectDepeartment(String departmentName, String template, String editLink) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        GlobalStepdefs GlobalStepdefs = new GlobalStepdefs();
        GlobalStepdefs.clickButton("Close", "EditQuickTextV2", "Yes");
        GlobalStepdefs.clickButton("Close", "DepartmentQuickTextEditorContentQTV2", "Yes");
        GlobalStepdefs.clickButton("Close", "Note Writer Quick Text Admin View Content", "Yes");
        AdminDepartmentStepdefs adminDepartmentStepdefs = new AdminDepartmentStepdefs();
        adminDepartmentStepdefs.selectDepartment(departmentName);
        GlobalStepdefs.clickButton("Edit", "Quick Details", null);
        GlobalStepdefs.selectFromDropdown("NoteWriter", "Edit Department Settings", "Department Edit Settings", null);
        GlobalStepdefs.checkPaneLoad("Department NoteWriter Settings", "load", null);
        GlobalStepdefs.selectFromDropdown(template, "QuickText Template View", "Department NoteWriter Settings", null);
        AdminTabStepdefs adminTabStepdefs = new AdminTabStepdefs();
        adminTabStepdefs.clickEditLinkInPane(editLink, null, "Department General Settings");


        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I drag and drop the \"(.*?)\" quick text on to the \"(.*?)\" quick text within the \"(.*?)\" group$")
    public void dragAndDropWithInGroup(String quickText1, String quickText2, String groupName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        clickTheQuickTextInThePane(quickText1, "AddQuickTextV2left");
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        String paneName = "AddQuickTextV2left";
        paneName = paneName.replace(" ", "");
        String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");

        WebElement sourceElement = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//span[@class='drag_handle' and parent::li[@data-name='" + quickText1 + "' and parent::ul[@data-viewname='" + groupName + "']]]"));
        WebElement targetElement = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//ul[@data-viewname='" + groupName + "']/li[@data-name='" + quickText2 + "']"));
        Assert.assertNotNull("Not able to found " + sourceElement + " " + targetElement + " from the list");
        Page.dragAndDrop(Hooks.getDriver(), sourceElement, targetElement);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^the quicktext \"(.*?)\" should appear under the group \"(.*?)\" in the \"(.*)\" pane$")
    public void validateTheTextUnderGroup(String quickTextName, String groupName, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        paneName = paneName.replace(" ", "");
        String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
        String qckTxtParentXpath = null;
        switch (paneName) {
            case "AddQuickTextV2left":
                qckTxtParentXpath = "//ul[@data-viewname='" + groupName + "']/li[@class='quicktext-item' and text()='" + quickTextName + "']";
                break;
            case "ClickToInsertV2":
                qckTxtParentXpath = "//li[contains(@class,'quicktext-entry') and contains(text(),'" + quickTextName + "') and ancestor::li[@class='quicktext-entry-folder-contents' and preceding-sibling::li[contains(@class,'quicktext-entry-folder') and contains(text(),'" + groupName + "')]]]";
                break;
        }
//        String qckTxtParentXpath = "//li[contains(@class,'quicktext-entry') and contains(text(),'" + quickTextName + "') and ancestor::li[@class='quicktext-entry-folder-contents' and preceding-sibling::li[contains(@class,'quicktext-entry-folder') and contains(text(),'" + groupName + "')]]]";
        WebElement targetElement = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues(qckTxtParentXpath + ";xpath"));
        Assert.assertNotNull(quickTextName + " not displayed under the group " + groupName, targetElement);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @And("^the \"(.*?)\" (quicktext|group) should be (saved|deleted|updated)$")
    public void quicktextsValidation(String quickTextName, String value, String action) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        String paneName = "AddQuickTextV2Right";
        String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
        switch (action) {
            case "saved":
                WebElement status = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//div[@class = 'statusbar' and text() = '" + quickTextName + " was Saved']"));
                Assert.assertNotNull(status);
                break;
            case "deleted":
                WebElement uiColor = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//div[@class = 'statusbar' and text() = '" + quickTextName + " was Deleted']"));
                Assert.assertNotNull(uiColor);
                break;
            case "updated":
                WebElement ele = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//div[@class = 'statusbar' and text() = '" + quickTextName + " was Updated']"));
                Assert.assertNotNull(ele);
                break;
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @And("^I verify \"(.*?)\" is selected$")
    public void verifySelection(String textName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        String paneName = "PatientNarrativeQTV2";
        String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
        //Below line of code is compatible with 8.3.0
        //WebElement txtObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//input[@class='cke-qtt-input cke-quicktexttag-component']" + ";xpath"));
        //Below line of code is compatible with 8.3.1
        WebElement txtObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//input[@class='cke-qtt-input cke-quicktexttag-component cke_enable_context_menu']" + ";xpath"));
        Assert.assertNotNull(textName + "Not selected ", txtObj);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @And("^I remove the (medical|surgery) problem \"(.*?)\" in the \"(.*?)\" pane$")
    public void removeproblem(String type, String value, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        paneName = paneName.replace(" ", "");
        String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
        Actions actions = new Actions(driver);
        if (type.equals("medical")) {
            ////i[contains(@class, 'remove-problem') and ancestor::div[contains(@class,'HistoryProblem') and descendant::span[contains(text(),'Typhoid fever')]]]
            WebElement Obj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//i[contains(@class, 'remove-problem') and ancestor::div[contains(@class,'HistoryProblem') and descendant::span[contains(text(),'" + value + "')]]]" + ";xpath"));
            Assert.assertNotNull(value + "Not able to remove ", Obj);
//            Obj.click();
            actions.moveToElement(Obj).click().perform();
        }
        if (type.equals("surgery")) {
            WebElement Obj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//i[contains(@class, 'remove-problem') and ancestor::div[contains(@class,'SurgicalProblem') and descendant::span[contains(text(),'" + value + "')]]]" + ";xpath"));
            Assert.assertNotNull(value + "Not able to remove ", Obj);
//            Obj.click();
            actions.moveToElement(Obj).click().perform();
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I create a new draft note$")
    public void createDraftNote() throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        globalStepdefs.clickButton("ClinicalNotes+", "", "");
        globalStepdefs.waitGivenTime("2");
        selectNoteWriterTemplate(null, "ProgressNoteHTML5DragAndDrop", "");
        globalStepdefs.waitGivenTime("2");
        globalStepdefs.clickButton("SaveasDraft", "ClinicalNote", "");
        globalStepdefs.clickButton("Yes", "Information", "");
        globalStepdefs.selectFromTheTable("*DRAFT* ProgressNoteHTML5DragAndDrop", "Notes");

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I sign/submit the Co-sig note as cosignature \"(.*?)\"$")
    public void signSubmitCosig(String cosig) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        features.step_definitions.NoteWriterStepdefs noteWriterStepdefs = new features.step_definitions.NoteWriterStepdefs();
        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        // noteWriterStepdefs.selectNoteSection("A/P", null);
        // globalStepdefs.selectFromDropdown("Moderate", "LevelOfDecision", null, null);
        String paneName;
        if (curTabName.equals("Inbox")) {
            globalStepdefs.clickButton("Sign/Submit", "CoSig Note", null);
            paneName = "Sign/SubmitNote";
        } else {
            globalStepdefs.clickButton("NoteWriterSign/Submit", "Note Writer Main", null);
            paneName = "Note Writer Main";
        }
        //globalStepdefs.clickButton("NoteWriterSign/Submit", paneName, null);
        globalStepdefs.enterInTheField("123", "PasswordField", paneName);
        globalStepdefs.waitGivenTime("2");
        globalStepdefs.enterInTheField(cosig, "lookupField", paneName);
        globalStepdefs.waitGivenTime("2");
        selectFromTheList(cosig, "CoSign LookUp Search List", "");
        globalStepdefs.clickButton("SubmitCoSigNoteConfirm", paneName, null);
        //globalStepdefs.waitForFieldAttributeValue("5",paneName,"PANE",null,"be invisible",null,null);
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I share draft with the co-signer \"(.*?)\"$")
    public void shareDraftCosig(String cosig) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        String paneName;
        if (curTabName.equals("Inbox")) {
            globalStepdefs.clickButton("ShareDraft", "CoSig Note", null);
            paneName = "Sign/SubmitNote";
        } else {
            globalStepdefs.clickButton("ShareDraft", "Note Writer Main", null);
            paneName = "Submit Note";
        }
        globalStepdefs.enterInTheField(cosig, "lookupField", paneName);
        globalStepdefs.waitGivenTime("2");
        globalStepdefs.clickMiscElement("SearchImage", null, paneName, "null");
        globalStepdefs.clickButton("OK", paneName, null);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^The button \"(.*?)\" should be (enabled|disabled) in the \"(.*?)\" pane$")
    public void verifyTheButtonStatus(String buttonName, String type, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        buttonName = buttonName.replace(" ", "");
        String[] elementType = UtilFunctions.getElementStringAndType(fileObj, "BUTTONS." + buttonName);
        String buttonPath = elementType[0];
        String buttonMethod = elementType[1];
        paneName = paneName.replace(" ", "");
        String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
        if (type.equals("enabled")) {
            WebElement btnObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(buttonPath + ";" + buttonMethod));
            Assert.assertNotNull("Unable to fine element ", btnObj);
        }
        if (type.equals("disabled")) {
            WebElement btnObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(buttonPath + ";" + buttonMethod));
            String verify = btnObj.getAttribute("disabled");
            if (verify.equals("true")) {
                UtilFunctions.log("Button " + buttonName + " is " + type + "");
            } else {
                UtilFunctions.log("Button " + buttonName + " is enabled");
                Assert.assertNull(btnObj);
            }
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I verify the note count of the \"(.*?)\" table and click the \"(.*?)\" button(?: with \"(.*?)\" password)?$")
    public void verifyTheCountOfTheTable(String tableName, String buttonName, String password) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        tableName = tableName.replace(" ", "");
        String[] tableDetailArr = UtilFunctions.getTableValues(curTabName, tableName);
        String tablePath = tableDetailArr[0];
        String tableId = tableDetailArr[1];
        String tableHead = tableDetailArr[2];
        String tableBody = tableDetailArr[3];
        String paneFrames = tableDetailArr[4];

        UtilFunctions.log("tablePath: " + tablePath);
        UtilFunctions.log("tableID: " + tableId);
        UtilFunctions.log("tableHead: " + tableHead);
        UtilFunctions.log("tableBody: " + tableBody);
        UtilFunctions.log("PaneFrames: " + paneFrames);
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");
        SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.TWENTY, tablePath + ";xpath");
        WebElement tableElement = findTable(Hooks.getDriver(), tablePath);
        WebElement tableBodyObj = SeleniumFunctions.findElementByWebElement(tableElement, SeleniumFunctions.setByValues(tableBody + ";xpath"));
        List<WebElement> tableRowObj = SeleniumFunctions.findElementsByWebElement(tableBodyObj, SeleniumFunctions.setByValues("tr;tagName"));
        UtilFunctions.log("Note count of the " + tableName + " before sign is" + tableRowObj.size());
        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        globalStepdefs.clickButton(buttonName, null, null);
        String paneName = null;
        if (buttonName.equals("Submit")) {
            paneName = "Sign/SubmitNote";
            globalStepdefs.enterInTheField(password, "PasswordField", paneName);
            globalStepdefs.clickButton("SubmitCoSigNoteConfirm", paneName, null);
        } else if (buttonName.equals("Delete")) {
            paneName = "Confirm";
            globalStepdefs.clickButton("OK", paneName, null);
        } else {
            paneName = "SignNote";
            globalStepdefs.enterInTheField(password, "Password", paneName);
            globalStepdefs.clickButton("OK", paneName, null);
        }
        //globalStepdefs.enterInTheField(password, "PasswordField", paneName);
//        globalStepdefs.clickButton("OK", paneName, null);
        //After sign the note table count should be 1 less
        int countAfterSign = tableRowObj.size() - 1;
        globalStepdefs.clickButton("Xclose", null, "if it exists");
        globalStepdefs.clickButton("Refresh", null, "if it exists");
        List<WebElement> newTableRowObj = SeleniumFunctions.findElementsByWebElement(tableBodyObj, SeleniumFunctions.setByValues("tr;tagName"));
        Assert.assertNotEquals("Table count more than -1", countAfterSign, newTableRowObj);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I verify the \"(.*?)\" list has \"(.*?)\" rows with following text$")
    public void verifyTheCosigTable(String listName, int count, List<String> dataTable) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String[] elementType = null;
        String paneFrame;
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        elementType = UtilFunctions.getElementStringAndType(fileObj, "MISC_ELEMENTS." + listName);
        paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "MISC_ELEMENTS." + listName, "frame"));
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
        WebElement upperListEle = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(elementType[0]));
        List<WebElement> listItems = SeleniumFunctions.findElementsByWebElement(upperListEle, SeleniumFunctions.setByValues("li;tagName"));

        Assert.assertTrue("The list have more/less then" + count + " row ", listItems.size() == count);
        UtilFunctions.log("The list have " + count + " row(s)");
        List<String> listText = new ArrayList<>();
        for (WebElement option : listItems) {
            String optionText = option.getText().replace("\n", " ");
            listText.add(optionText);
        }

        Assert.assertTrue("List not matching", dataTable.equals(listText));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I sign/submit the note for vibra template$")
    public void signSubmitForVibra() throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        globalStepdefs.clickButton("NoteWriterSign/Submit", "Note Writer Main", null);
        //globalStepdefs.waitGivenTime("2");
        globalStepdefs.clickButton("OK", "Submit Note", null);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^the following text should appear in the \"(.*?)\" pane and count should be \"(.*?)\"$")
    public void checkForMultipleTextEntriesWithCount(String paneName, int count, DataTable dataTable) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        paneName = paneName.replace(" ", "");
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        String[] elementType = UtilFunctions.getElementStringAndType(fileObj, "PANES." + paneName);
        String buttonPath = elementType[0];
        String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
        List<WebElement> ObjCount = SeleniumFunctions.findElements(driver, SeleniumFunctions.setByValues("" + buttonPath + "//span[contains(@class,'problemDesc')]" + ";xpath"));
        // ObjCount.size();
        Assert.assertTrue("The Pane have more/less then " + count + " text ", ObjCount.size() == count);

        List<String> textList = dataTable.asList(String.class);
        for (String text : textList) {
            text = UtilFunctions.convertThruRegEx(text);
            GlobalStepdefs globalStepdefs = new GlobalStepdefs();
            globalStepdefs.textAppearInPane(text, null, null, paneName.replace(" ", ""));
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @And("^I (pop out|pop in) note writer$")
    public void popNoteWriter(String writerOption) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String tabName = curTabName;

        if (writerOption.equals("pop out")) {
            Page.clickButton(Hooks.getDriver(), curTabName, "PopOut", "");
            Thread.sleep(500);
            SeleniumFunctions.switchToNWPopoutWindow(Hooks.getDriver());
        } else if (writerOption.equals("pop in")) {
            Page.clickButton(Hooks.getDriver(), curTabName, "PopIn", "PopoutWizard");
            Thread.sleep(500);
            //Window Name changed from portalWindow to LoginWindow because in 9.2 application open's in login window itself.
            SeleniumFunctions.switchToWindow(Hooks.getDriver(), "LoginWindow");
            curTabName = tabName;
        } else {
            Assert.assertTrue("Unrecognized argument: " + writerOption, false);
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @And("I clear the \"(.*?)\" rich text field(?: in the \"(.*?)\" pane)?$")
    public void clearingTheRichTextField(String fieldName, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        fieldName = fieldName.replace(" ", "");
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        String paneFrame;
        if (paneName == null) {
            paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "TEXT_FIELDS." + fieldName, "frame"));
            SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
        } else {
            paneName = paneName.replace(" ", "");
            paneFrame = (String) frameMap.get(UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
            SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
        }
        String[] elementType = UtilFunctions.getElementStringAndType(fileObj, "TEXT_FIELDS." + fieldName);
        String textPath = elementType[0];
        SeleniumFunctions.selectFrame(driver, paneFrame, "id");
        WebElement txtObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(textPath));

        txtObj.sendKeys(Keys.ARROW_DOWN);
        txtObj.sendKeys(Keys.ARROW_UP);
        txtObj.click();
        txtObj.clear();

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Given("^\"(.*?)\" note(?:s)? should present in the database for the patient(?: \"(.*?)\")?(?: and the user \"(.*?)\")?$")
    public void checkTheNotesCountFromDatabase(String noteCount, String patientName, String userName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        int noteRecords = Integer.parseInt(noteCount);
        if (patientName == null)
            patientName = "";
        String patID = PatientListPage.getPatientID(Hooks.getDriver(), patientName);

        DBExecutor dbExecutorObj = Page.prepareQuery("ActiveNotesCount");
        dbExecutorObj.addWhere("pk_formresult.patientid='" + patID + "'");
        if (userName != null)
            dbExecutorObj.addWhere("u_user.user_nm='" + userName + "'");
        List<HashMap> rs = dbExecutorObj.executeQuery();
        Assert.assertTrue(rs.size() + " notes are present instead of " + noteRecords + " in database", rs.size() == noteRecords);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I click the \"(.*?)\" insert previous link in the \"(.*?)\" pane$")
    public void clickInsertPreviousLInk(String linkName, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        linkName = linkName.replace(" ", "");
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        paneName = paneName.replace(" ", "");
        String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
        UtilFunctions.log("PaneFrames: " + paneFrame);
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
        SeleniumFunctions.explicitWait(driver, 15, paneFrame, SeleniumFunctions.setByValues("//a[@class='commandLink' and @insertpreviousid='" + linkName + "']" + ";xpath"));
        WebElement linkObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//a[@class='commandLink' and @insertpreviousid='" + linkName + "']" + ";xpath"));
        if (linkObj != null) {
            try {
                linkObj.click();
            } catch (Exception e) {
                Assert.assertTrue("Insert previous link is not clicked due to exception: " + e.getMessage(), false);
            }
        } else
            Assert.assertNotNull("Element not present or doesnt exist", linkObj);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^the checkbox for the following text should (not present|present with the given status) in the insert previous notes pane$")
    public void checkTheDataInInsertPrevious(String exists, DataTable dataTable) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        String paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + "DataToInsertFromPreviousNotes", "frame"));
        UtilFunctions.log("PaneFrames: " + paneFrames);
        SeleniumFunctions.selectFrame(driver, paneFrames, "id");
        List<Map<String, String>> dataList = dataTable.asMaps(String.class, String.class);
        for (Map data : dataList) {
            String state = (String) data.get("Status");
            String text = ((String) data.get("Text"));
            SeleniumFunctions.explicitWait(driver, GlobalConstants.FIFTEEN, "//input[@id='selectcheck' and ancestor::tr[contains(normalize-space(), '" + text + "')]]" + ";xpath");
            WebElement dataElement = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//input[@id='selectcheck' and ancestor::tr[contains(normalize-space(), '" + text + "')]]" + ";xpath"));
            if (!exists.contains("not") && dataElement != null) {
                switch (state.toLowerCase()) {
                    case "checked":
                        Assert.assertTrue("Checkbox with text " + text + " is not checked", dataElement.isSelected());
                        break;
                    case "unchecked":
                        Assert.assertTrue("Checkbox with text " + text + " is checked", !dataElement.isSelected());
                        break;
                    case "enabled":
                        Assert.assertTrue("Checkbox with text " + text + " is disabled", dataElement.isEnabled());
                        break;
                    case "disabled":
                        Assert.assertTrue("Checkbox with text " + text + " is enabled", !dataElement.isEnabled());
                        break;
                    default:
                        Assert.assertTrue("Given checkbox state is not valid", false);
                        break;
                }
            } else if (!exists.contains("not"))
                Assert.assertNotNull("Checkbox with text " + text + " is not displayed", dataElement);
            else
                Assert.assertNull("Checkbox with text " + text + " is displayed", dataElement);
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @And("^I verify if \"(.*?)\" insert previous link is (enabled|disabled) in the \"(.*?)\" pane$")
    public void checkInsertPreviousLinkDisabled(String linkName, String type, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        linkName = linkName.replace(" ", "");
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        paneName = paneName.replace(" ", "");
        String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
        UtilFunctions.log("PaneFrames: " + paneFrame);
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
        SeleniumFunctions.explicitWait(driver, 15, paneFrame, SeleniumFunctions.setByValues("//a[@class='commandLink' and @insertpreviousid='" + linkName + "']" + ";xpath"));
        if (type.equals("enabled")) {
            Assert.assertNotNull("Insert Previous link is disabled", SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//a[@class='commandLink' and @insertpreviousid='" + linkName + "']" + ";xpath")));
        }
        if (type.equals("disabled")) {
            Assert.assertNotNull("Insert Previous link is enabled", SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//a[@class='disabled' and @insertpreviousid='" + linkName + "']" + ";xpath")));
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");

    }

    @Then("^I click the \"(.*?)\" element(?: in the \"(.*?)\" pane)? for \"(.*)\" times$")
    public void clickImageManyTimes(String elementName, String paneName, Integer count) {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        String paneFrame;
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        if (paneName == null)
            paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "MISC_ELEMENTS." + elementName.replace(" ", ""), "frame"));
        else
            paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName.replace(" ", ""), "frame"));
        UtilFunctions.log("PaneFrames: " + paneFrame);
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");

        String[] elementType = UtilFunctions.getElementStringAndType(fileObj, "MISC_ELEMENTS." + elementName.replace(" ", ""));
        String path = elementType[0];
        String method = elementType[1];
        WebElement eleObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(path + ";" + method));
        if (eleObj == null) {
            UtilFunctions.log("Element: '" + elementName + "' does not exist. Returning false.");
            Assert.assertNotNull("Element: " + elementName + " is not found", null);
        } else {
            int clickIndex = 0;
            try {
                for (clickIndex = 0; clickIndex < count; clickIndex++) {
                    eleObj.click();
                    Thread.sleep(2000);
                }
            } catch (InterruptedException e) {
                UtilFunctions.log("Unable to click the element " + clickIndex + " time due to exception" + e.getMessage());
                Assert.assertTrue("Unable to click the element " + clickIndex + " time due to exception" + e.getMessage(), false);
            }
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^the text \"(.*?)\" should be disabled(?: in the \"(.*?)\" pane)?")
    public void checkTextDisabled(String text, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        String paneFrame;
        if (paneName == null)
            paneFrame = "FRAME_NOTEWRITER_MAIN";
        else {
            paneName = paneName.replace(" ", "");
            paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
        }
        UtilFunctions.log("PaneFrames: " + paneFrame);

        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
        WebElement eleObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//div[contains(text(),'" + text + "')])"));
        if (eleObj != null) {
            try {
                Assert.assertEquals("Text is disabled", false, eleObj.isEnabled());
            } catch (Exception e) {
                UtilFunctions.log("Text is enabled " + e.getMessage());
                Assert.assertTrue("Text is enabled" + e.getMessage(), false);
            }
        } else {
            try {
                Assert.assertNull("Text not found", eleObj);
            } catch (Exception e) {
                UtilFunctions.log("Text is not found " + e.getMessage());
            }
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @And("^I move the following problems to the mentioned position in the \"(.*?)\" pane$")
    public void moveProblem(String paneName, DataTable dataTable) {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName.replace(" ", ""), "frame"));
        UtilFunctions.log("PaneFrames: " + paneFrame);
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
        List<Map<String, String>> dataList = dataTable.asMaps(String.class, String.class);
        for (Map data : dataList) {
            String problem = (String) data.get("Problem");
            String position = ((String) data.get("Position"));

            WebElement sourceElement = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//div[@id='dragHandle' and following-sibling::div[@id='ProblemDescriptionDiv' and descendant::*[@id='ProblemDescription' and contains(normalize-space(),'" + problem + "')]]]"));
            WebElement targetElement = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//div[@id='dragHandle' and following-sibling::div[@id='ProblemDescriptionDiv' and descendant::*[@id='ProblemNumber' and contains(normalize-space(),'" + position + "')]]]"));
            if (sourceElement != null && targetElement != null) {
                try {
                    Page.dragAndDrop(Hooks.getDriver(), sourceElement, targetElement);
                } catch (InterruptedException e) {
                    Assert.assertTrue("Problem " + problem + " is not changed to position " + position + " due to " + e.getMessage(), false);
                }
            } else {
                if (sourceElement == null)
                    Assert.assertNull("Unable to find the problem " + problem, sourceElement);
                else
                    Assert.assertNull("Unable to find the position" + position, targetElement);
            }
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^the following problems should appear in the mentioned position in the \"(.*?)\" pane$")
    public void checkProblemsForSameOrder(String paneName, DataTable dataTable) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName.replace(" ", ""), "frame"));
        UtilFunctions.log("PaneFrames: " + paneFrame);
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
        List<Map<String, String>> dataList = dataTable.asMaps(String.class, String.class);
        for (Map data : dataList) {
            String problem = (String) data.get("Problem");
            String expPosNumber = ((String) data.get("Position"));
            WebElement probNumberElement = SeleniumFunctions.findElement(Hooks.driver, SeleniumFunctions.setByValues("//*[@class='problemNumber' and following-sibling::div[@class='problemDescriptionFieldWrapper' and descendant::*[contains(normalize-space(),'" + problem + "')]]]"));
            if (probNumberElement != null) {
                String actualPosNumber = probNumberElement.getText().replace(".", "");
                Assert.assertEquals("Position of problem " + problem + "is not " + expPosNumber, expPosNumber, actualPosNumber.trim());
            } else
                Assert.assertNull("Unable to find the problem " + problem, probNumberElement);
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^I pop out note writer and check the pop out width as \"(.*?)\" percent when clinical data percent width in pop out mode is set to \"(.*?)\" percent?")
    public void checkPopOutWidth(int popOutSize, int windowSize) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        UtilFunctions.log("Pop out note writer");
        Page.clickButton(Hooks.getDriver(), curTabName, "PopOut", "");
        Thread.sleep(3000);
        int popOutWidth, mainWindowWidth;
        mainWindowWidth = driver.manage().window().getSize().getWidth();
        UtilFunctions.log("Main window width is: " + mainWindowWidth);
        Set<String> handles = driver.getWindowHandles();
        for (String windowHandle : handles) {
            UtilFunctions.log("windowHandle: " + windowHandle);
            if (!windowHandle.equals(SeleniumFunctions.parentWindow) && !windowHandle.equals(SeleniumFunctions.portalWindow)) {
                SeleniumFunctions.popoutWindow = windowHandle;
                UtilFunctions.log("Window handle not equal to parent or portal windows. Switching to new pop out window now: " + windowHandle);
                driver.switchTo().window(windowHandle);
                UtilFunctions.log("Switched to new pop out window: " + windowHandle);
                break;
            }
        }
        popOutWidth = driver.manage().window().getSize().getWidth();
        UtilFunctions.log("Pop out window width is: " + popOutWidth);
        Assert.assertTrue("Pop out width is not " + popOutSize + " percent when clinical data percent width is set to " + windowSize + " percent", popOutSize == Math.round(((float) popOutWidth / (mainWindowWidth + popOutWidth)) * 100));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^I resize portal window to \"(.*?)\" percent?")
    public void resizePortal(int windowSize) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        int portalWidth, portalHeight, newPortalWidth, expectedPortalWidth;
        portalWidth = driver.manage().window().getSize().getWidth();
        UtilFunctions.log("Portal width is: " + portalWidth);
        portalHeight = driver.manage().window().getSize().getHeight();
        expectedPortalWidth = Math.round((float) (windowSize * portalWidth) / 100);
        Dimension windowDimensions = new Dimension(expectedPortalWidth, portalHeight);
        driver.manage().window().setSize(windowDimensions);
        newPortalWidth = driver.manage().window().getSize().getWidth();
        UtilFunctions.log("Portal new width is: " + newPortalWidth);
        Assert.assertTrue("Portal width is not set to " + windowSize + " percent", windowSize == Math.round(((float) newPortalWidth / portalWidth) * 100));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^I highlight the search text in the \"(.*?)\" pane$")
    public void highlightSearchText(String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        paneName = paneName.replace(" ", "");
        String paneFrame = (String) frameMap.get(UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");

        WebElement contentDiv = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//*[@class='text-search-highlight text-search-active-highlight']" + ";xpath"));
        Assert.assertNotNull("Search text is null.", contentDiv);

        int width = (int) (contentDiv.getSize().width * 0.5);
        int height = (int) (contentDiv.getSize().height * 0.5);
        ((JavascriptExecutor) driver).executeScript("arguments[0].scrollIntoView(true)", contentDiv);
        Thread.sleep(1000);
        Page.highlight(Hooks.getDriver(), contentDiv, -width, 0, contentDiv.getSize().width, 0);
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    //Then I press ".*" to highlight all the text in the detail's "ContentDiv" div in the ".*" pane
    @Then("^I press \"(.*?)\" to highlight all the text in the detail's \"(.*?)\" div(?: in the \"(.*?)\" pane)?$")
    public void highlightAllTextInDiv(String keyName, String divName, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        String paneFrame;
        if (paneName == null) {
            paneFrame = UtilFunctions.getFrameValue(frameMap,
                    UtilFunctions.getElementFromJSONFile(fileObj, "MISC_ELEMENTS." +
                            divName.replace(" ", ""), "frame"));
            SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
        } else {
            paneName = paneName.replace(" ", "");
            paneFrame = (String) frameMap.get(UtilFunctions.getElementFromJSONFile(fileObj, "PANES." +
                    paneName, "frame"));
            SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
        }

        String[] elementType = UtilFunctions.getElementStringAndType(fileObj, "MISC_ELEMENTS." +
                divName.replace(" ", ""));
        String divPath = elementType[0];
        String divMethod = elementType[1];

        SeleniumFunctions.selectFrame(driver, paneFrame, "id");
        WebElement divElement = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(divPath));

        if (divElement != null) {
            try {
                SeleniumFunctions.click(divElement);
                System.out.println("Div '" + divName + "' clicked.");

                keyName = keyName.toUpperCase();
                switch (keyName) {
                    case "CTRL ALL":
                    case "CTRL A":
                    case "CTRL + A":
                    case "CONTROL ALL":
                    case "CONTROL A":
                    case "CONTROL + A":
                        try {
                            Actions action = new Actions(Hooks.getDriver());
                            action.moveToElement(divElement).sendKeys(Keys.CONTROL + "a").build().perform();
                            System.out.println("Text in div '" + divName + "' highlighted successfully. ");
                        } catch (Exception e) {
                            System.out.println("Text in div '" + divName + "' not highlighted due to Exception: " +
                                    e.getMessage());
                        }
                        break;
                    default:
                        try {
                            divElement.sendKeys(Keys.CONTROL + "a");
                            System.out.println("Text in div '" + divName + "' highlighted successfully. ");
                        } catch (Exception e) {
                            System.out.println("Text in div '" + divName + "' not highlighted due to Exception: " +
                                    e.getMessage());
                        }
                        break;
                }//end switch
            } catch (Exception e) {
                System.out.println("Div '" + divName + "' not clicked due to Exception: " + e.getMessage());
            }
        } else {
            System.out.println("Div '" + divName + "' is NULL.");
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @And("^the following field(?:s)? should have corresponding text in the (Subjective|ROS|Exam|Objective) section in the \"(.*?)\" pane$")
    public void checkFieldText(String sectionName, String paneName, DataTable dataTable) {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String path = "";
        String partialPath = "";
        String paneFrame = null;
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName.replace(" ", ""), "frame"));
        UtilFunctions.log("PaneFrames: " + paneFrame);
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
        List<Map<String, String>> dataList = dataTable.asMaps(String.class, String.class);
        if (sectionName.equals("Subjective") || sectionName.equals("ROS")) {
            partialPath = "//div[@role='textbox' and @testid='it_ROS";
        } else if (sectionName.equals("Objective") || sectionName.equals("Exam")) {
            partialPath = "//div[@role='textbox' and @testid='it_Exam";
        }
        for (Map data : dataList) {
            path = "";
            String fieldName = (String) data.get("Field");
            String fieldText = ((String) data.get("Text"));
            path = partialPath + fieldName + "']";
            WebElement textfield = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues(path + ";xpath"));
            if (textfield != null) {
                Assert.assertTrue("Text in the " + fieldName + " field did not match with default text", textfield.getText().equals(fieldText));
            } else {
                Assert.assertNull("Text field " + fieldName + " is not found");
            }

        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @And("^(Nothing should|the option \"(.*?)\" should( not)?) be selected (?:by default )?in the \"(.*?)\" radio list(?: in the \"(.*?)\" pane)?$")
    public void verifyDefaultRadioOption(String condition, String value, String display, String elementName, String paneName) {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        String paneFrame;

        if (paneName == null)
            paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "RADIOS." + elementName.replace(" ", ""), "frame"));
        else
            paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName.replace(" ", ""), "frame"));

        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");

        String[] elementType = UtilFunctions.getElementStringAndType(fileObj, "RADIOS." + elementName.replace(" ", ""));
        String elementValue = elementType[0];
        String elementMethod = elementType[1];
        List<WebElement> radiosList = SeleniumFunctions.findElements(Hooks.getDriver(), SeleniumFunctions.setByValues(elementValue + ";" + elementMethod));
        Assert.assertTrue(elementName + " radio list not found", (radiosList.size() != 0));

        if (condition.contains("Nothing")) {
            for (WebElement radio : radiosList) {
                Assert.assertFalse(radio.getAttribute("value") + " radio button in the list is selected", Boolean.parseBoolean(radio.getAttribute("checked")));
            }
        } else {
            for (WebElement radio : radiosList) {
                if (radio.getAttribute("value").equals(value)) {
                    if (display == null) {
                        Assert.assertTrue(value + " radio option is not selected", Boolean.parseBoolean(radio.getAttribute("checked")));
                    } else {
                        Assert.assertFalse(value + " radio option is selected", Boolean.parseBoolean(radio.getAttribute("checked")));
                    }
                }
            }
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @And("^I verify the following checkbox(?:es)? (?:default )?state in the \"(.*?)\" pane$")
    public void verifyCheckboxState(String paneName, DataTable dataTable) {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName.replace(" ", ""), "frame"));
        UtilFunctions.log("PaneFrames: " + paneFrame);
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
        List<Map<String, String>> dataList = dataTable.asMaps(String.class, String.class);

        for (Map data : dataList) {
            String name = (String) data.get("Checkbox");
            String state = ((String) data.get("State"));
            String[] elementType = UtilFunctions.getElementStringAndType(fileObj, "CHECKBOXES." + name.replace(" ", ""));
            String chBoxValue = elementType[0];
            String chBoxMethod = elementType[1];
            WebElement checkBoxObj = Page.findCheckBoxObj(driver, chBoxValue, chBoxMethod);

            if (state.equals("checked")) {
                Assert.assertTrue("checkbox " + name + " is unchecked", checkBoxObj.isSelected());
            } else if (state.equals("unchecked")) {
                Assert.assertTrue("checkbox " + name + " is checked", !checkBoxObj.isSelected());
            } else {
                Assert.assertFalse("please mention valid state as either checked or unchecked", true);
            }
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");

    }

    @And("^I enter( and search for)? the following text in the \"(.*?)\" field(?: in the \"(.*?)\" pane)?$")
    public void enterAndSearchText(String search, String fieldName, String paneName, DataTable dataTable) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        String paneFrame;

        if (paneName == null)
            paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "TEXT_FIELDS." + fieldName.replace(" ", ""), "frame"));
        else
            paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName.replace(" ", ""), "frame"));

        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");

        String[] fieldElement = UtilFunctions.getElementStringAndType(fileObj, "TEXT_FIELDS." + fieldName.replace(" ", ""));
        String txtPath = fieldElement[0];
        String txtMethod = fieldElement[1];
        WebElement txtObj = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues(txtPath + ";" + txtMethod));
        Assert.assertNotNull("Text field element not found", txtObj);
        List<String> textList = dataTable.asList(String.class);
        for (String text : textList) {
            if (search == null) {
                try {
                    txtObj.clear();
                    txtObj.sendKeys(text);
                } catch (Exception e) {
                    Assert.assertFalse("Unable to enter text in the field due to exception " + e, true);
                }
            } else {
                txtObj.clear();
                txtObj.sendKeys(text);
                List<WebElement> searchList = SeleniumFunctions.findElements(Hooks.getDriver(), SeleniumFunctions.setByValues("//*[contains(@class,'text-search-highlight') and contains(text(),'" + text + "')]" + ";xpath"));
                if (searchList.size() == 0 || searchList == null) {
                    Assert.assertFalse("search text is not present", true);
                } else {
                    UtilFunctions.log("Search text is present in the pane");
                }

            }
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @Given("^I enter \"(.*)\" at (last|first) in the \"(.*)\" field(?: in the \"(.*)\" pane)?$")
    public void appendOrPrefixTextInTextField(String value, String position, String fieldName, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        fieldName = fieldName.replace(" ", "");
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        String paneFrame;
        if (paneName == null)
            paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "TEXT_FIELDS." + fieldName, "frame"));
        else
            paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName.replace(" ", ""), "frame"));
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
        String[] elementType = UtilFunctions.getElementStringAndType(fileObj, "TEXT_FIELDS." + fieldName);
        String textPath = elementType[0];
        String textMethod = elementType[1];
        WebElement txtObj = Page.findTextBox(driver, textPath, textMethod);
        if (txtObj == null) {
            txtObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(textPath + ";" + textMethod));
        }
        Assert.assertNotNull("Text field " + fieldName + " not found", txtObj);
        Actions actions = new Actions(Hooks.driver);
        try {
            if (position.equals("last")) {
                actions.moveToElement(txtObj).click().pause(Duration.ofSeconds(1))
                        .sendKeys(Keys.chord(Keys.CONTROL, Keys.END)).pause(Duration.ofSeconds(1))
                        .sendKeys(value).sendKeys(Keys.ENTER).perform();
            } else {
                actions.moveToElement(txtObj).click().pause(Duration.ofSeconds(1))
                        .sendKeys(Keys.chord(Keys.CONTROL, Keys.HOME)).pause(Duration.ofSeconds(1))
                        .sendKeys(value).sendKeys(Keys.ENTER).perform();
            }
        } catch (Exception e) {
            UtilFunctions.log("Value not entered in text field " + fieldName + " due to exception: " + e.getMessage());
            Assert.assertFalse("Value not entered in text field " + fieldName + " due to exception: " + e.getMessage(), true);
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @And("^the child note \"(.*?)\" should be sticky to its parent note \"(.*?)\" in the \"(.*?)\" table$")
    public void childNoteStickyToParentNote(String childNote, String parentNote, String tableName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        WebElement childRow = null;
        boolean parentFound = false;
        String parentEntityId = null;
        childNote = " - " + childNote;
        String[] tableDetailArr = UtilFunctions.getTableValues(curTabName, tableName);
        String tablePath = tableDetailArr[0];
        String tableId = tableDetailArr[1];
        String tableHead = tableDetailArr[2];
        String tableBody = tableDetailArr[3];
        String paneFrames = tableDetailArr[4];

        UtilFunctions.log("tablePath: " + tablePath);
        UtilFunctions.log("tableID: " + tableId);
        UtilFunctions.log("tableHead: " + tableHead);
        UtilFunctions.log("tableBody: " + tableBody);
        UtilFunctions.log("PaneFrames: " + paneFrames);

        SeleniumFunctions.selectFrame(driver, paneFrames, "id");
        WebElement tableObj = findTable(driver, tablePath);
        Assert.assertNotNull("Table not " + tableName + " found", tableObj);
        WebElement tableBodyObj = SeleniumFunctions.findElementByWebElement(tableObj, SeleniumFunctions.setByValues(tableBody + ";xpath"));
        List<WebElement> tableRowObj = SeleniumFunctions.findElementsByWebElement(tableBodyObj, SeleniumFunctions.setByValues("tr;tagName"));

        for (WebElement rowObj : tableRowObj) {
//            if (!parentFound && SeleniumFunctions.findElementByWebElement(rowObj, SeleniumFunctions.setByValues(".//*[contains(text(), '" + parentNote + "')]")) != null) {
            if (!parentFound && rowObj.getAttribute("textContent").contains(parentNote)) {

                parentFound = true;
                parentEntityId = rowObj.getAttribute("entityid");
            } else if (parentFound && SeleniumFunctions.findElementByWebElement(rowObj, SeleniumFunctions.setByValues(".//*[contains(text(), '" + parentNote + "')]")) != null) {
                Assert.assertFalse("Child note is not sticky to its parent", true);
            } else if (parentFound) {
                childRow = SeleniumFunctions.findElementByWebElement(rowObj, SeleniumFunctions.setByValues(".//*[contains(@sortvalue, '" + parentNote + " - " + parentEntityId + "') and contains(text(),'" + childNote + "')]"));
                Assert.assertNotNull("Child note " + childNote + " not found", childRow);
                break;
            }
        }
        Assert.assertTrue("Parent note " + parentNote + " not found", parentFound);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @Then("^I verify if the following text is displayed in multiple lines in the field \"(.*?)\" in the \"(.*?)\" pane$")
    public void verifyTextInMultipleLines(String fieldName, String paneName, DataTable dataTable) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        List<String> dataList = dataTable.asList(String.class);
        fieldName = fieldName.replace(" ", "");

        List<String> actualRowData = new ArrayList<>();

        List<String> expectedRowData = dataTable.asList(String.class);

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        String paneFrame;
        if (paneName == null)
            paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "TEXT_FIELDS." + fieldName, "frame"));
        else
            paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName.replace(" ", ""), "frame"));
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
        String[] elementType = UtilFunctions.getElementStringAndType(fileObj, "TEXT_FIELDS." + fieldName);
        String textPath = elementType[0];
        String textMethod = elementType[1];
        WebElement txtObj = Page.findTextBox(driver, textPath, textMethod);
        if (txtObj == null) {
            txtObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(textPath + ";" + textMethod));
        }
        Assert.assertNotNull("Text field " + fieldName + " not found", txtObj);

        String actualText = txtObj.getText();
        String textWithNewline[] = actualText.split("\\n");
        for (String arr : textWithNewline) {
            actualRowData.add(arr);
        }
        Assert.assertFalse("There is no multiple line text", textWithNewline.length == 1);
        Assert.assertFalse("Data table size does not match with number of lines of text", textWithNewline.length != dataList.size());
        int arrCnt = 0;
        for (String arr : textWithNewline) {
            UtilFunctions.log("Splitted text is " + arr);
            Assert.assertFalse("Given text " + dataList.get(arrCnt) + " does not match with " + "arr",
                    actualRowData.equals(expectedRowData.get(arrCnt)));
            arrCnt++;
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");

    }

    /**
     * verify if the elements are checked or unchecked
     * this works for Inbox tab which has 9x UI
     *
     * @param checkType checked  or unchecked
     * @param paneName  panename
     * @param dataTable list of element names
     */
    @Then("^the following elements should be (checked|unchecked)(?: in the \"(.*?)\" pane)?$")
    public void verifyCheckboxStatus(String checkType, String paneName, DataTable dataTable) {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");


        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        String paneFrame;

        List<String> dataList = dataTable.asList(String.class);
        for (String element : dataList) {
            if (paneName == null)
                paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "MISC_ELEMENTS." + element.replace(" ", ""), "frame"));
            else
                paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName.replace(" ", ""), "frame"));

            SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");

            String[] dataElement = UtilFunctions.getElementStringAndType(fileObj, "MISC_ELEMENTS." + element.replace(" ", ""));
            String elePath = dataElement[0];
            String eleMethod = dataElement[1];
            WebElement eleObj = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues(elePath + ";" + eleMethod));
            Assert.assertNotNull("Element not found", eleObj);
            if (eleObj != null) {
                int pos = elePath.lastIndexOf("]");
                String partialPath = elePath.substring(0, pos);

                if (checkType.equals("checked")) {
                    String parentPath = partialPath + " and parent::label[contains(@class, 'is-checked')]]";
                    WebElement parentObj = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues(parentPath + ";" + eleMethod));
                    Assert.assertNotNull("Element " + element + " is not checked", parentObj);
                } else if (checkType.equals("unchecked")) {
                    String parentPath = partialPath + " and parent::label[not(contains(@class, 'is-checked'))]]";
                    WebElement parentObj = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues(parentPath + ";" + eleMethod));
                    Assert.assertNotNull("Element " + element + "  is checked", parentObj);

                }
            }
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I click the Add To Note checkbox for (?:the first )?\"(.*?)\" rows in the \"(.*?)\" table(?: in the \"(.*)\" pane)?$")
    public void clickNoteCheckboxesInTable(String rowCount, String tableName, String pane) {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        Assert.assertTrue("Failed to check 'Add to Note' checkbox for '" + rowCount + "' rows in table '" + rowCount + "'"
                , Page.clickNoteCheckboxesInTable(Hooks.getDriver(), rowCount, tableName, pane));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I click the Add To Note checkbox for the row with text \"(.*?)\" in the \"(.*?)\" column in the \"(.*?)\" table(?: in the \"(.*)\" pane)?$")
    public void clickNoteCheckboxesInTableByTextInColumn(String rowText, String columnName, String tableName, String pane) {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        Assert.assertTrue("Failed to check 'Add to Note' checkbox for row with text '" + rowText + "' table '" + tableName + "'"
                , Page.clickNoteCheckboxesInTableByTextInColumn(Hooks.getDriver(), rowText, columnName, tableName, pane));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


}
