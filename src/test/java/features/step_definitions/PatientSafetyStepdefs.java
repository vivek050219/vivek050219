package features.step_definitions;

import common.SeleniumFunctions;
import constants.GlobalConstants;
import cucumber.api.DataTable;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import features.Hooks;
import org.json.simple.JSONObject;
import org.junit.Assert;
import org.openqa.selenium.*;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.support.ui.Select;
import pageObject.PatientListPage;
import support.PDFCompare;
import support.Page;
import support.db.DBExecutor;
import utils.UtilFunctions;
import utils.UtilProperty;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.text.SimpleDateFormat;
import java.util.*;

import static java.lang.Character.isDigit;

/**
 * Created by PatientKeeper on 7/6/2016.
 */

/******************************************************************************
 Class Name: PatientListChargesStepdefs
 Contains step definitions related to patient list charge page
 ******************************************************************************/

public class PatientSafetyStepdefs {

    public String className = getClass().getSimpleName();
    public static HashMap<String, String> persistent_state = new HashMap<>();
    public static String persistent_patID = null;
    public static int submissionRecordId = 0;
    public static int sessionId = 0;
    String mapSplitType = "&&##";

    @And("^I save the timestamp of the( HCA)? note under \"(.*)\" in persistent state$")
    public void setDateTimeStamp(String isHCAnote, String key) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        //This always selects "FRAME_NOTEWRITER_MAIN", might as well just pass in the name of the frame
        /*SeleniumFunctions.selectFrame(Hooks.getDriver(), UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(
                GlobalStepdefs.curTabName, null, null, "frame",
                "FRAME_NOTEWRITER_MAIN", ""), "id");*/
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        String paneFrames = UtilFunctions.getFrameValue(frameMap, "FRAME_NOTEWRITER_MAIN");
        UtilFunctions.log("PaneFrames: " + paneFrames);
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");

        WebElement date = null, time = null;
        if (isHCAnote != null) {//if the note type is an HCA note template
            date = SeleniumFunctions.findElement(Hooks.getDriver(),
                    SeleniumFunctions.setByValues("//input[@id='NoteDate_date']" + ";xpath"));
            time = SeleniumFunctions.findElement(Hooks.getDriver(),
                    SeleniumFunctions.setByValues("//input[@id='NoteDate_time']" + ";xpath"));
        } else {//else if the note is a responsive design template
            SeleniumFunctions.findElement(Hooks.getDriver(),
                    SeleniumFunctions.setByValues("//div[@class='nw-subheader-row DateView']" + ";xpath")).click();
            date = SeleniumFunctions.findElement(Hooks.getDriver(),
                    SeleniumFunctions.setByValues("//span[@class='selected-date nw-clickable']" + ";xpath"));
            time = SeleniumFunctions.findElement(Hooks.getDriver(),
                    SeleniumFunctions.setByValues("//input[@class='selected-time']" + ";xpath"));
        }

        Assert.assertNotNull("Date object is null and not found.", date);
        Assert.assertNotNull("Time object is null and not found.", time);

        String dateText = null;
        if (isHCAnote != null) {
            dateText = date.getAttribute("value");
        } else {
            dateText = date.getText();
        }
        String timeText = time.getAttribute("value");

        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        globalStepdefs.clickButton("CloseVisitMenu", null, "if it exists");

        SimpleDateFormat dateFormat = new SimpleDateFormat("mm/dd/yyyy");
        Date formatedDate = dateFormat.parse(dateText);
        String dateValue = new SimpleDateFormat("mm/dd/yy").format(formatedDate);
        String dateTime = dateValue + " " + timeText;
        persistent_state.put(key, dateTime);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @Then("^I select the item(?: under the \"(.*)\" column)? in the \"(.*)\" table that matches the value under \"(.*)\" in persistent state$")
    public void selectFromTable(String columnName, String tableName, String key) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        globalStepdefs.selectValueFromTheColumnInTable(persistent_state.get(key), columnName, tableName, "");

        persistent_state.clear();

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    /**
     * changeCustomOrderIVdripRate(String ogRate, String newRate)
     * function: Change the IV drip rate in a custom order
     *
     * @param ogRate  -- original rate to be changed, e.g.: 30 mls/hr
     * @param newRate -- new rate to be selected, e.g.: 50 mls/hr
     * @throws Throwable -- for the Thread.sleep's
     */
    @Then("^I change the custom order's IV drip rate from \"(.*)\" to \"(.*)\"$")
    public void changeCustomOrderIVdripRate(String ogRate, String newRate) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        ogRate = ogRate.toUpperCase();
        UtilFunctions.log("Un-checking old IV drip rate: " + ogRate);
        SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.FIVE,
                "//div[contains(@class, 'md-checkbox') and descendant::*[text()='" + ogRate + "']]" + ";xpath");
        WebElement ogCheckBox = SeleniumFunctions.findElement(Hooks.getDriver(),
                SeleniumFunctions.setByValues("//div[contains(@class, 'md-checkbox') and descendant::*[text()='" + ogRate + "']]"
                        + ";xpath"));
        WebElement checkBoxContainer = null;
        if (ogCheckBox != null) {
            checkBoxContainer = SeleniumFunctions.findElementByWebElement(ogCheckBox,
                    By.xpath(".//div[@class='md-checkbox-container']"));
        }
        Assert.assertNotNull("Unable to find the '" + ogRate + "' checkbox.", checkBoxContainer);
        SeleniumFunctions.scrollIntoView(checkBoxContainer);
        try {
            checkBoxContainer.click();
            Thread.sleep(500);
            if (SeleniumFunctions.isSelected(ogCheckBox)) {
                SeleniumFunctions.click(checkBoxContainer);
                Thread.sleep(500);
                if (SeleniumFunctions.isSelected(ogCheckBox)) {
                    Actions actions = new Actions(Hooks.getDriver());
                    actions.moveToElement(checkBoxContainer).click().build().perform();
                    Thread.sleep(500);
                    Assert.assertFalse("'" + ogRate + "' checkbox is STILL checked. Asserting false...",
                            SeleniumFunctions.isSelected(ogCheckBox));
                }
            }
        } catch (ElementNotInteractableException e) {
            UtilFunctions.log(e.getMessage());
            e.printStackTrace();
            SeleniumFunctions.click(checkBoxContainer);
            Thread.sleep(500);
            if (SeleniumFunctions.isSelected(ogCheckBox)) {
                Actions actions = new Actions(Hooks.getDriver());
                actions.moveToElement(checkBoxContainer).click().build().perform();
                Thread.sleep(500);
                Assert.assertFalse("'" + ogRate + "' checkbox is STILL checked. Asserting false...",
                        SeleniumFunctions.isSelected(ogCheckBox));
            }
        }

        UtilFunctions.log("Checking new drip rate: '" + newRate + "'.");
        WebElement newCheckBox = SeleniumFunctions.findElement(Hooks.getDriver(),
                SeleniumFunctions.setByValues("//div[contains(@class, 'md-checkbox') and descendant::*[text()='" + newRate + "']]"
                        + ";xpath"));
        checkBoxContainer = null;
        if (newCheckBox != null) {
            checkBoxContainer = SeleniumFunctions.findElementByWebElement(newCheckBox,
                    By.xpath(".//div[@class='md-checkbox-container']"));
        }
        Assert.assertNotNull("Unable to find the '" + newRate + "' checkbox.", checkBoxContainer);
        SeleniumFunctions.scrollIntoView(checkBoxContainer);

        try {
            checkBoxContainer.click();
            Thread.sleep(500);
            if (!SeleniumFunctions.isSelected(newCheckBox)) {
                SeleniumFunctions.click(checkBoxContainer);
                Thread.sleep(500);
                if (!SeleniumFunctions.isSelected(newCheckBox)) {
                    Actions actions = new Actions(Hooks.getDriver());
                    actions.moveToElement(checkBoxContainer).click().build().perform();
                    Thread.sleep(500);
                    Assert.assertTrue("'" + newRate + "' checkbox is STILL not checked.",
                            SeleniumFunctions.isSelected(newCheckBox));
                }
            }
        } catch (ElementNotInteractableException e) {
            UtilFunctions.log(e.getMessage());
            e.printStackTrace();
            SeleniumFunctions.click(checkBoxContainer);
            Thread.sleep(500);
            if (!SeleniumFunctions.isSelected(newCheckBox)) {
                Actions actions = new Actions(Hooks.getDriver());
                actions.moveToElement(checkBoxContainer).click().build().perform();
                Thread.sleep(500);
                Assert.assertTrue("'" + newRate + "' checkbox is STILL not checked.",
                        SeleniumFunctions.isSelected(newCheckBox));
            }
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @When("^I select a lab result with a comment$")
    public void selectLabResultWithComment() throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        persistent_state.clear();
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        String paneFrames = UtilFunctions.getFrameValue(frameMap, "FRAME_LABLIST");
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");

        SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.TEN, "//tr[(@id='rtwMainPanListRow') and descendant::div[@class='CI']]" + ";xpath");
        WebElement labResult = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//tr[(@id='rtwMainPanListRow') and descendant::div[@class='CI']]" + ";xpath"));
        if (labResult == null)
            Assert.assertNotNull("Lab result object not found.", labResult);
        else {
            String labResStr = labResult.getText().replace("*", "##");
            String[] labResStrArr = labResStr.split("##");
            persistent_state.put("datetime", labResStrArr[0].trim());
            WebElement tooltip = SeleniumFunctions.findElementByWebElement(labResult, SeleniumFunctions.setByValues("//td/font/div[@class='CI' and @tooltip]" + ";xpath"));
            if (tooltip == null)
                Assert.assertNotNull("Tooltip object not found.", tooltip);
            else {
                String toolTip = tooltip.getAttribute("tooltip");
                persistent_state.put("subject", toolTip.split("<br>")[0].replace(":", ""));
                persistent_state.put("tooltip", toolTip.split("<br>")[1]);
                labResult.click();
            }

        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I select the corresponding lab result in the Panel Table$")
    public void selectCorrespondingLabResult() throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        String paneFrames = UtilFunctions.getFrameValue(frameMap, "FRAME_PANELTABLE");
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");

        int[] colIndexArr = Page.getColumnCoverageRange(Hooks.getDriver(), GlobalStepdefs.curTabName, "PanelTableDateTimeHeader", persistent_state.get("datetime"));
        Assert.assertNotNull("Column Index is null.", colIndexArr);
        int colIndex = colIndexArr[0];
        int rowIndex = Page.getRowIndexByCellText(Hooks.getDriver(), GlobalStepdefs.curTabName, "PanelTableSubject", persistent_state.get("subject"), "td");
        if (rowIndex == 0)
            Assert.assertTrue("Row Index not retrieved.", false);
        //Table used to calculate row_index has one extra empty row, need to compensate by subtracting 1 from rowIndex.
        WebElement element = Page.findTableElementByRowAndColumnIndex(Hooks.getDriver(), GlobalStepdefs.curTabName, "PanelTableData", colIndex, rowIndex - 1);
        Assert.assertNotNull("Element Object is null.", element);
        element.click();
        WebElement e = SeleniumFunctions.findElementByWebElement(element, SeleniumFunctions.setByValues(".//descendant-or-self::*[@tooltip]" + ";xpath"));
        Assert.assertNotNull("Child Element Object is null.", e);
        Assert.assertTrue("Not true", persistent_state.get("tooltip").equals(e.getAttribute("tooltip")));
        e.click();

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^the content of the \"(.*)\" (div|field) should (not )?(match|include|contain) the value stored at \"(.*)\" in persistent state$")
    public void checkStoredContent(String elementName, String elementType, String no, String exact, String stateKey) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String elementContent;
        elementName = elementName.replace(" ", "");
        if (elementType.equals("div")) {
            WebElement element = Page.getElementObject(Hooks.getDriver(), GlobalStepdefs.curTabName, elementName, "MISC_ELEMENTS");
            Assert.assertNotNull("Element object is null.", element);
            elementContent = element.getText();
        } else {
            WebElement element = Page.getElementObject(Hooks.getDriver(), GlobalStepdefs.curTabName, elementName, "TEXT_FIELDS");
            Assert.assertNotNull("Element object is null.", element);
            elementContent = element.getAttribute("value");
        }

        String[] elementContentArr = elementContent.trim().split("\n");
        String[] dbValue = null;
        String dbValueStr = null;
        if (persistent_state.get(stateKey).getClass().getName().contains("String"))
            dbValue = persistent_state.get(stateKey).trim().split("\n");
        else if (persistent_state.get(stateKey).getClass().getName().contains("Array")) {
            dbValueStr = persistent_state.get(stateKey).trim();
        }

        boolean found;
        switch (exact) {
            case "match":
                found = true;
                int eleIndex = 0;
                for (String item : dbValue) {
                    if (!elementContentArr[eleIndex].trim().equals(item.trim())) {
                        found = false;
                        break;
                    }
                    eleIndex++;
                }
                break;
            case "include":
                found = elementContentArr.equals(dbValueStr);
                break;
            case "contain":
                found = true;
                int eleIndex1 = 0;
                for (String item : dbValue) {
                    if (elementContentArr[eleIndex1].equals(item)) {
                        found = true;
                        break;
                    }
                    eleIndex1++;
                }
                break;
            default:
                found = false;
                break;
        }

        Assert.assertTrue("Item not present.", found);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @Then("^I save column \"([0-9])\"(?: through \"([0-9])\")? under name \"(.*)\" in persistent state$")
    public void saveColumnInPersistentState(String column_startnum, String column_endnum, String key) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        WebElement selectedRow = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//tr[@selected='Y']" + ";xpath"));
        Assert.assertNotNull("Selected row object not null.", selectedRow);
        String result = "";

        for (int index = Integer.parseInt(column_startnum); index <= Integer.parseInt(column_endnum); index++) {
            WebElement rowEle = SeleniumFunctions.findElementByWebElement(selectedRow,
                    SeleniumFunctions.setByValues(".//td[" + index + "]" + ";xpath"));
            Assert.assertNotNull("Row element object not found.", rowEle);
            if (result.equals(""))
                result = result + rowEle.getText().trim();
            else
                result = result + mapSplitType + rowEle.getText().trim();
        }

        persistent_state.put(key, result);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @Then("^I select some text to add to the note$")
    public void selectTextToAddToNote() throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        SeleniumFunctions.selectFrame(Hooks.getDriver(),
                UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(GlobalStepdefs.curTabName, null,
                        null, "frame", "FRAME_TESTDETAIL", ""),
                "id");
        SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.TEN, "//div[@id='CONTENTDIV']" + ";xpath");

        WebElement contentDiv = SeleniumFunctions.findElement(Hooks.getDriver(),
                SeleniumFunctions.setByValues("//div[@id='CONTENTDIV']" + ";xpath"));
        Assert.assertNotNull("ContentDiv object not found.", contentDiv);

        int width = (int) (contentDiv.getSize().width * 0.5);
        int height = (int) (contentDiv.getSize().height * 0.4);
        Page.highlight(Hooks.getDriver(), contentDiv, 0, 0, width, height);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @Then("^there should be a lab matching the lab I found with the proper date( in the HCA note)?$")
    public void labMatching(String isHCAnote) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        SeleniumFunctions.selectFrame(Hooks.getDriver(),
                UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(GlobalStepdefs.curTabName, null,
                        null, "frame", "FRAME_NOTEWRITER", ""),
                "id");
        String labResultDate = persistent_state.get("lab_result").split(mapSplitType)[0].trim();
        String labResultName = persistent_state.get("lab_result").split(mapSplitType)[1].trim();

        WebElement labNoteName = null, labNoteDate = null;

        if (isHCAnote != null) {
            labNoteName = SeleniumFunctions.findElement(Hooks.getDriver(),
                    By.xpath("//font[@id='Name' and text()='" + labResultName + "']"));
            if (labNoteName == null) {
                labNoteName = SeleniumFunctions.findElement(Hooks.getDriver(),
                        By.xpath("//font[@id='Name' and text()='" + labResultName.toUpperCase() + "']"));
                if (labNoteName == null) {
                    labNoteName = SeleniumFunctions.findElement(Hooks.getDriver(),
                            By.xpath("//font[@id='Name' and text()='" + labResultName.toLowerCase() + "']"));
                }
            }

            labNoteDate = SeleniumFunctions.findElement(Hooks.getDriver(),
                    By.xpath("//font[@id='LabDate' and text()='" + labResultDate + "']"));
            if (labNoteDate == null) {
                labNoteDate = SeleniumFunctions.findElement(Hooks.getDriver(),
                        By.xpath("//font[@id='LabDate' and text()='" + labResultDate.toUpperCase() + "']"));
                if (labNoteDate == null) {
                    labNoteDate = SeleniumFunctions.findElement(Hooks.getDriver(),
                            By.xpath("//font[@id='LabDate' and text()='" + labResultDate.toLowerCase() + "']"));
                }
            }
        } else {
            SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.FIFTEEN,
                    "//span[@class='type cd-title' and text()='" + labResultName
                            + "'and ancestor::div[contains(@class,'LabsView')]]" + ";xpath");
            labNoteName = SeleniumFunctions.findElement(Hooks.getDriver(),
                    SeleniumFunctions.setByValues("//span[@class='type cd-title' and text()='" + labResultName
                            + "'and ancestor::div[contains(@class,'LabsView')]]" + ";xpath"));

            labNoteDate = SeleniumFunctions.findElementByWebElement(labNoteName,
                    SeleniumFunctions.setByValues("//span[@class='type cd-secondary-title' and" +
                            " ancestor::div[contains(@class,'LabsView')]]" + ";xpath"));
        }

        Assert.assertNotNull("Lab Name object in note's Data section not found.", labNoteName);
        Assert.assertNotNull("Lab Date object in note's Data section not found.", labNoteDate);

        String labNameText = labNoteName.getText().trim();
        //date in UI is surrounded by parens., hence replacing them w/ empty character
        String labDateText = labNoteDate.getText().replace("(", "").replace(")", "").trim();

        Assert.assertTrue("Lab Name result not matched.", labResultName.equalsIgnoreCase(labNameText));
        Assert.assertTrue("Lab Date result not matched.", labResultDate.equalsIgnoreCase(labDateText));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @Then("^there should be a test result matching the test I found with the proper date( in the HCA note)?$")
    public void testResultMatching(String isHCAnote) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        SeleniumFunctions.selectFrame(Hooks.getDriver(), UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(
                GlobalStepdefs.curTabName, null, null, "frame",
                "FRAME_NOTEWRITER", ""), "id");
        String testResultDate = persistent_state.get("test_result").split(mapSplitType)[0].trim();
        String testResultName = persistent_state.get("test_result").split(mapSplitType)[1].trim();

        WebElement testNoteName = null, testNoteDate = null;

        if (isHCAnote != null) {
            testNoteName = SeleniumFunctions.findElement(Hooks.getDriver(),
                    By.xpath("//font[@id='Type' and text()='" + testResultName + "']"));
            if (testNoteName == null) {
                testNoteName = SeleniumFunctions.findElement(Hooks.getDriver(),
                        By.xpath("//font[@id='Type' and text()='" + testResultName.toUpperCase() + "']"));
                if (testNoteName == null) {
                    testNoteName = SeleniumFunctions.findElement(Hooks.getDriver(),
                            By.xpath("//font[@id='Type' and text()='" + testResultName.toLowerCase() + "']"));
                }
            }

            testNoteDate = SeleniumFunctions.findElement(Hooks.getDriver(),
                    By.xpath("//font[@id='ResultDate' and text()='" + testResultDate + "']"));
            if (testNoteDate == null) {
                testNoteDate = SeleniumFunctions.findElement(Hooks.getDriver(),
                        By.xpath("//font[@id='ResultDate' and text()='" + testResultDate.toUpperCase() + "']"));
                if (testNoteDate == null) {
                    testNoteDate = SeleniumFunctions.findElement(Hooks.getDriver(),
                            By.xpath("//font[@id='ResultDate' and text()='" + testResultDate.toLowerCase() + "']"));
                }
            }

        } else {
            SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.FIFTEEN,
                    "//span[@class='type cd-title' and text()='" + testResultName +
                            "' and ancestor::div[contains(@class,'TestResultsView')]]" + ";xpath");
            testNoteName = SeleniumFunctions.findElement(Hooks.getDriver(),
                    SeleniumFunctions.setByValues("//span[@class='type cd-title' and text()='" + testResultName +
                            "' and ancestor::div[contains(@class,'TestResultsView')]]" + ";xpath"));

            testNoteDate = SeleniumFunctions.findElementByWebElement(testNoteName,
                    SeleniumFunctions.setByValues("//span[@class='noteDate cd-secondary-title' and " +
                            "ancestor::div[contains(@class,'TestResultsView')]]" + ";xpath"));
        }

        Assert.assertNotNull("Test Name object in note's Data section not found.", testNoteName);
        Assert.assertNotNull("Test Date object in note's Data section not found.", testNoteDate);

        String testNameText = testNoteName.getText().trim();
        //date is UI is surrounded by braces, hence replacing them empty character
        String testDateText = testNoteDate.getText().replace("(", "").replace(")", "").trim();
        Assert.assertTrue("Test Name not matched.", testResultName.equalsIgnoreCase(testNameText));
        Assert.assertTrue("Test Date not matched.", testResultDate.equalsIgnoreCase(testDateText));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @Then("^these rows should appear in the \"(.*)\" table$")
    public void rowsAppearInTable(String tableName, DataTable dataTable) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        boolean dataFound;
        int foundCount = 0;
        int loc = 0;
        List<WebElement> rows = Page.getTableRows(Hooks.getDriver(), GlobalStepdefs.curTabName, tableName);
        List<List<String>> dataList = dataTable.asLists(String.class);
        for (WebElement row : rows) {
            dataFound = false;
            List<WebElement> tdArr = SeleniumFunctions.findElementsByWebElement(row, SeleniumFunctions.setByValues("td;tagName"));
            for (int index = 0; index < tdArr.size(); index++) {

                if (index >= dataList.get(loc).size())
                    break;

                if (tdArr.get(index).getText().trim().toLowerCase().equals(dataList.get(loc).get(index).trim().toLowerCase())) {
                    UtilFunctions.log("Text: " + dataList.get(loc).get(index) + " is present.");
                    dataFound = true;
                    foundCount++;
                }
            }
            if (dataFound)
                loc++;
            if (loc >= dataList.size())
                break;
        }
        Assert.assertEquals("Text missing.", dataTable.asList(String.class).size(), foundCount);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^I check the patient's MRN against the database$")
    public void checkFromDatabase() throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        DBExecutor dbExecutorObj = Page.prepareQuery("PatientDemographics");

        String patID = PatientListPage.getPatientID(Hooks.getDriver(), "");
        dbExecutorObj.addWhere("pat_id=" + patID);
        List<HashMap> rs = dbExecutorObj.executeQuery();
        String mrn = Page.getTableFieldValue(Hooks.getDriver(), GlobalStepdefs.curTabName, "Patient Detail", "Demographics", "MRN");
        Assert.assertNotNull("MRN field not present in table.", mrn);
        Assert.assertEquals("MRN not matching with db value.", mrn, rs.get(rs.size() - 1).get("MRN"));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^I store the (results of the|\"(.*)\" column from the) \"(.*)\" query(?: with the following additional columns)?(?: and filtered by (the currently selected patient)?(\"(.*)\"|, the following additional filters)?( on \"(.*)\"| on the value stored at \"(.*)\")?)? under name \"(.*)\"$")
    public void storeColumn(String save_all, String column_name, String query_name, String patient_filter, String additional_filters, String filter_column,
                            String use_storage, String user_filter_value, String storage_filter_value, String var_name, DataTable dataTable) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        DBExecutor dbExecutorObj = Page.prepareQuery(query_name);

        List<List<String>> dataList = dataTable.asLists(String.class);
        for (int index = 0; index < dataList.size(); index++) {
            if (!dataList.get(index).get(0).equals(""))
                dbExecutorObj.addColumn(dataList.get(index).get(0));
        }

        if (additional_filters != null) {
            if (user_filter_value == null) {
                for (int index = 0; index < dataList.size(); index++) {
                    if (storage_filter_value == null)
                        dbExecutorObj.addWhere(dataList.get(index).get(1));
                    else {
                        if (persistent_state.get(storage_filter_value).split(mapSplitType)[index].matches("\\d\\d\\/\\d\\d\\/\\d\\d \\d\\d:\\d\\d(AM|PM)")) {
                            dbExecutorObj.addWhere(dataList.get(index).get(1) + "=to_date('" + persistent_state.get(storage_filter_value).split(mapSplitType)[index] + "', 'MM/DD/YY HH:MIAM')");
                        } else {
                            dbExecutorObj.addWhere(dataList.get(1).get(index) + "='" + persistent_state.get(storage_filter_value).split(mapSplitType)[index] + "'");
                        }
                    }
                }
            }
        }

        if (patient_filter != null) {
            String patID = PatientListPage.getPatientID(Hooks.getDriver(), "");
            if (dbExecutorObj.getHelperValue("patientidcolumn") == null)
                dbExecutorObj.addWhere("pat_id=" + patID);
            else {
                dbExecutorObj.addWhere(dbExecutorObj.getHelperValue("patientidcolumn") + "=" + patID);
            }
        }

        List<HashMap> rs = dbExecutorObj.executeQuery();
        String value = "";
        HashMap<String, String> valueMap = new HashMap<>();
        for (HashMap map : rs) {
            //String value;
            if (column_name == null) {
                //value = map.toString();
                value = value + map.toString();
                valueMap.put("", value);
            } else if (map.get(column_name).getClass().getName().contains("CLOB")) {
                value = UtilFunctions.tryClob2String(map.get(column_name));
            } else
                value = (String) map.get(column_name);

            if (persistent_state.get(var_name) == null)
                persistent_state.put(var_name, value);
            else {
                //System.out.println("Do something");
                persistent_state.put(var_name, valueMap.get(""));
            }
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^I add the title of the test to the value stored at \"(.*)\" in persistent state$")
    public void addTestTitle(String stateKey) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        persistent_state.put(stateKey, persistent_state.get("my_test_result").split(mapSplitType)[1] + "\n" + persistent_state.get(stateKey));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^(the \"(.*)\"|each) row in the \"(.*)\" table(?: in the \"(.*)\" column)? should (contain|match( the regex)?) \"(.*)\"$")
    public void rowRegExMatch(String num_rows, String row_name, String table_name, String column_name, String exact, String regex, String value) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        int startIndex = -1;
        int endIndex = -1;
        boolean success;
        if (column_name != null) {
            int[] indexArr = Page.getColumnCoverageRange(Hooks.getDriver(), GlobalStepdefs.curTabName, table_name, column_name);
            startIndex = indexArr[0];
            endIndex = indexArr[1];
        }

        List<WebElement> tableRows = Page.getTableRows(Hooks.getDriver(), GlobalStepdefs.curTabName, table_name);
        for (WebElement row : tableRows) {
            List<WebElement> tdArr = SeleniumFunctions.findElementsByWebElement(row, SeleniumFunctions.setByValues("td;tagName"));
            success = false;
            for (int index = 0; index < tdArr.size(); index++) {
                if (startIndex <= index && index <= endIndex) {
                    if (regex == null) {
                        if (exact.contains("contain"))
                            success = tdArr.get(index).getText().contains(value);
                        else
                            success = tdArr.get(index).getText().equals(value);
                    } else {
                        success = tdArr.get(index).getText().matches(value);
                    }
                }
            }
            Assert.assertTrue("Value not matched.", success);
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    //TODO: Refactored enough to make it work, but could be optimized.
    @Then("^the patient's \"(.*)\" \"(.*)\" vitals should match their values in the database$")
    public void vitalMatchInDatabase(String columnNamePassedIn, String rowNamePassedIn) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String patID;
        if (persistent_patID == null)
            patID = PatientListPage.getPatientID(Hooks.getDriver(), "");
        else
            patID = persistent_patID;

        int startIndex = -1;
        if (columnNamePassedIn != null) {
            int[] positionArr = Page.getColumnCoverageRange(Hooks.getDriver(), GlobalStepdefs.curTabName,
                    "VitalSigns", columnNamePassedIn);
            startIndex = positionArr[0];
        }

        List<WebElement> tableRows = Page.getTableRows(Hooks.getDriver(), GlobalStepdefs.curTabName, "VitalSigns");
        Assert.assertNotNull("No rows found in 'VitalSigns' table.", tableRows);

        // sbp and dbp stand for Systolic Blood Pressure and Diastolic Blood Pressure, ex: sbp/dbp = 120/80
        String sbpLabelUI = null, dbpLabelUI = null, sbpValUI = null, dbpValUI = null, vitalLabelUI = null, vitalValUI = null;

        for (WebElement row : tableRows) {
            List<WebElement> tdArr = SeleniumFunctions.findElementsByWebElement(row, SeleniumFunctions.setByValues("td;tagName"));
            /*if (tdArr != null) {//testing
                for (WebElement cell : tdArr) {
                    System.out.println(cell.getText());
                }
            }*/

            //if the 0th cell in the table is empty, the row name/header must be in the 1st cell
            if ((tdArr.get(0).getText().toLowerCase().trim()).equals("") ||
                    (tdArr.get(0).getText().toLowerCase().trim()).equals(" ") ||
                    tdArr.get(0).getText().toLowerCase().trim() == null) {
                //This is the row header, e.g.: temp, rr, fsbg, etc.
                vitalLabelUI = tdArr.get(1).getText().toLowerCase().trim();
            } else {
                vitalLabelUI = tdArr.get(0).getText().toLowerCase().trim();
            }

            //If the row header in the UI matches the one we've passed in, get the vital's value from the UI
            if (vitalLabelUI.equalsIgnoreCase(rowNamePassedIn)) {
                if (rowNamePassedIn.contains("/")) {
                    sbpLabelUI = rowNamePassedIn.split("/")[0].toLowerCase().trim();
                    sbpValUI = tdArr.get(startIndex).getText().split("/")[0].trim();

                    dbpLabelUI = rowNamePassedIn.split("/")[1].toLowerCase().trim();
                    dbpValUI = tdArr.get(startIndex).getText().split("/")[1].trim();
                } else {
                    vitalValUI = tdArr.get(startIndex).getText().trim();
                }
                break;
            }
        }//end for (WebElement row : tableRows)

        //testing
//        System.out.println("vitalLabelUI: " + vitalLabelUI);
//        System.out.println("vitalValUI: " + vitalValUI);

        String qryName = null;
        if (columnNamePassedIn.equals("Most Recent"))
            qryName = "PatientVitalsMostRecent";
        else if (columnNamePassedIn.equals("Previous"))
            qryName = "PatientVitalsPrevious";
        else
            Assert.fail("Invalid column name: '" + columnNamePassedIn + "' specified. Asserting fail.");
        DBExecutor dbExecutorObj = Page.prepareQuery(qryName);

        List<HashMap> qryResults = dbExecutorObj.executeQuery("addWhere", "pat_id=" + patID);
        Assert.assertNotNull(qryName + " qryResult is NULL.", qryResults);
        Assert.assertTrue(qryName + " qryResults came back as 0 results.", qryResults.size() > 0);

        boolean success = false;

        String vitalLabelDB = null, vitalValDB = null;
        for (HashMap map : qryResults) {
            vitalLabelDB = (String) map.get("VITAL_NAME");
            vitalValDB = (String) map.get("VALUE_TXT");

            //If the vital value to be checked is SBP or DBP, the vitalValUI will be set to null or empty string
            // because their values from the UI are set to separate variables (sbpValUI, dbpValUI respectively).  See above blocks.
            if (vitalValUI == null || vitalValUI.equals("")) {
                if (vitalLabelDB.equalsIgnoreCase(sbpLabelUI)) {
                    vitalLabelUI = sbpLabelUI;
                    vitalValUI = sbpValUI;
                } else if (vitalLabelDB.equalsIgnoreCase(dbpLabelUI)) {
                    vitalLabelUI = dbpLabelUI;
                    vitalValUI = dbpValUI;
                }
            }

            if (vitalLabelDB.equalsIgnoreCase(vitalLabelUI)) {
                if (vitalValDB.equalsIgnoreCase(vitalValUI)) {
                    success = true;
                }
            }
            if (success) {
                break;
            }
        }//end for (HashMap map : qryResults)

        //If the height or weight was not taken by the dr's offc for the Most Recent or Previous vitals, neither
        // will be listed in the db at all for these queries. Set success to true in that case.
        if (vitalLabelUI.equalsIgnoreCase("weight") &&
                (vitalValUI.equals("  ") || vitalValUI.equals(" ") || vitalValUI.equals(""))) {
            success = true;
            vitalLabelDB = "Weight";
            vitalValDB = "";
        } else if (vitalLabelUI.equalsIgnoreCase("height") &&
                (vitalValUI.equals("  ") || vitalValUI.equals(" ") || vitalValUI.equals(""))) {
            success = true;
            vitalLabelDB = "Height";
            vitalValDB = "";
        }

        Assert.assertTrue("Vital UI '" + vitalLabelUI + "' value: " + vitalValUI + " and Vital DB '" +
                vitalLabelDB + "' value: " + vitalValDB + "\tdo NOT MATCH.", success);
        UtilFunctions.log("Vital UI '" + vitalLabelUI + "' value: " + vitalValUI + " and Vital DB '" +
                vitalLabelDB + "' value: " + vitalValDB + "\tMATCH.");
        System.out.println("Vital UI '" + vitalLabelUI + "' value: " + vitalValUI + " and Vital DB '" +
                vitalLabelDB + "' value: " + vitalValDB + "\tMATCH.");

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    //TODO: Refactored enough to make it work, but could be optimized.
    @Then("^the patient's \"(Most Recent|Previous)\" vitals should match their values in the database$")
    public void patientRecentOldVitalMatchInDatabase(String column_name) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        //This is also done in vitalMatchInDatabase().
        persistent_patID = PatientListPage.getPatientID(Hooks.getDriver(), "");
        List<String> vitalSigns = new ArrayList<>();

        List<WebElement> tableRows = Page.getTableRows(Hooks.getDriver(), GlobalStepdefs.curTabName, "VitalSigns");
        Assert.assertNotNull("\"VitalSigns\" table rows came back as Null.", tableRows);
        Assert.assertTrue("\"VitalSigns\" table has 0 rows.", tableRows.size() > 0);

        String vitalSignText = null;
        for (WebElement row : tableRows) {
            vitalSignText = SeleniumFunctions.findElementsByWebElement(row,
                    SeleniumFunctions.setByValues("td;tagName")).get(1).getText();
            vitalSigns.add(vitalSignText);
        }

        for (String vital : vitalSigns) {
            vitalMatchInDatabase(column_name, vital);
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    //TODO: Refactor
    @Then("^I store the (?:results of the|\"(.*)\" column from the) \"(.*)\" query run using the currently selected patient under name \"(.*)\"$")
    public void storeColumnFromQueryRun(String column_name, String query_name, String key) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String value = "";
        persistent_state.clear();
        String patID = PatientListPage.getPatientID(Hooks.getDriver(), "");

        DBExecutor dbExecutorObj = Page.prepareQuery(query_name);
        dbExecutorObj.addWhere("PAT_ID=" + patID);
        List<HashMap> rs = dbExecutorObj.executeQuery();

        for (HashMap map : rs) {
            if (column_name != null && !column_name.equals(""))
                value = value + map.get(column_name) + ";";
        }

        persistent_state.put(key, value);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^the \"(.*)\"(?: allergy)? div should match the value stored at \"(.*)\" in persistent state$")
    public void checkAllergyDivValueWithStoredValue(String elementName, String stateKey) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        WebElement divElement = Page.getElementObject(Hooks.getDriver(), GlobalStepdefs.curTabName, elementName, "MISC_ELEMENTS");
        Assert.assertNotNull("Element: " + elementName + " object not found.", divElement);

        String[] textToCheck = divElement.getText().split(", ");

        for (String text : textToCheck) {
            if (!persistent_state.get(stateKey).contains(text))
                Assert.assertTrue("Text: " + text + " is not present in DB. DBValue as stored: " + persistent_state.get(stateKey), false);
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^I select a lab with a (chemical|blood content) diagram and save the diagram's contents to persistent state under name \"(.*)\"$")
    public void saveDiagramContentToPersistentState(String diagramType, String key) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        HashMap<String, String> components = new HashMap<>();
        String labResultPath;

        if (diagramType.equals("chemical")) {
            components.put("chem7BoneTopLeft", "Na");
            components.put("chem7BoneTopMiddle", "Cl");
            components.put("chem7BoneTopRight", "BUN");
            components.put("chem7BoneRight", "Glu");
            components.put("chem7BoneBottomLeft", "K");
            components.put("chem7BoneBottomMiddle", "HCO3");
            components.put("chem7BoneBottomRight", "cr");

            labResultPath = "//td[@class='chem7BoneTopLeft']/ancestor::tr[@id='rtwMainPanListRow']";
        } else {
            components.put("cbcBoneLeft", "WBC");
            components.put("cbcBoneTop", "Hb");
            components.put("cbcBoneRight", "Plt");
            components.put("cbcBoneBottom", "Hct");

            labResultPath = "//td[@class='cbcBoneLeft']/ancestor::tr[@id='rtwMainPanListRow']";
        }

        SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.TEN, "", SeleniumFunctions.setByValues(labResultPath + ";xpath"));
        WebElement labResult = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues(labResultPath + ";xpath"));
        Assert.assertNotNull("LabResultPath: " + labResultPath + " object not found.", labResult);
        labResult.click();

        String frameName = UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(GlobalStepdefs.curTabName, "", "", "", "FRAME_LABLIST", "");
        SeleniumFunctions.selectFrame(Hooks.getDriver(), frameName, "id");
        WebElement diagram = SeleniumFunctions.findElementByWebElement(labResult, SeleniumFunctions.setByValues("dxmlTable_selectedRow" + ";className"));
        Assert.assertNotNull("Diagram Object with class name: dxmlTable_selectedRow not found.", diagram);

        persistent_state.clear();

        HashMap<String, String> text = new HashMap<>();
        List<WebElement> rows = SeleniumFunctions.findElementsByWebElement(diagram, SeleniumFunctions.setByValues("tr;tagName"));
        for (WebElement row : rows) {
            List<WebElement> tdArr = SeleniumFunctions.findElementsByWebElement(row, SeleniumFunctions.setByValues("td;tagName"));
            for (WebElement td : tdArr) {
                String compText = components.get(td.getAttribute("class"));
                String tdText = td.getText().replace("*", "");

                if (compText != null && !compText.equals("") && tdText != null && !tdText.equals("")) {
                    text.put(compText, tdText);
                }
            }
        }
        persistent_state.put(key, text.toString());

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^the contents of the selected fishbone table stored at \"(.*)\" should match the database values stored at \"(.*)\" in persistent state$")
    public void fishBoneDBTableContentMatch(String portalTable, String dbValue) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String[] dbTextArr = persistent_state.get(dbValue).replace("}{", mapSplitType).replace("}", "").replace("{", "").replace("TEST=", "").replace(", VALUE_TXT", "").split(mapSplitType);
        for (String dbText : dbTextArr) {
            if (!persistent_state.get(portalTable).toLowerCase().contains(dbText.toLowerCase()))
                Assert.assertTrue("DBText: " + dbText + " is not present in portal table DB. PortalTableDB Value: " + persistent_state.get(portalTable), false);
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @Then("^the difference between each value in row Intake and row Output should equal the value in row Net in the I\\/O table$")
    public void diffBtwRowInRowOut() throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String presentStr = "";
        //IO table's data section has as hidden "sizing" row.  Add 1 to each index to account for this hidden row.
        int netIndex = Page.getRowIndexByCellText(Hooks.getDriver(), GlobalStepdefs.curTabName,
                "I/OTableRowReference", "Net (mL) (mL)", "div") + 1;
        int inIndex = Page.getRowIndexByCellText(Hooks.getDriver(), GlobalStepdefs.curTabName,
                "I/OTableRowReference", "Intake (mL) (mL)", "div") + 1;
        int outIndex = Page.getRowIndexByCellText(Hooks.getDriver(), GlobalStepdefs.curTabName,
                "I/OTableRowReference", "Output (mL) (mL)", "div") + 1;

        //Get all the table's rows
        List<WebElement> ioTableRows = Page.getTableRows(Hooks.getDriver(), GlobalStepdefs.curTabName,
                "I/OTableData");
        Assert.assertNotEquals("Table rows for I/OTableData is zero.", ioTableRows.size(), 0);

        //Get all the cells for each type of row (In, Out, Net)
        List<WebElement> net_td = SeleniumFunctions.findElementsByWebElement(ioTableRows.get(netIndex),
                SeleniumFunctions.setByValues("td;tagName"));
        Assert.assertNotEquals("Table cells for Net is zero.", net_td.size(), 0);
        List<WebElement> in_td = SeleniumFunctions.findElementsByWebElement(ioTableRows.get(inIndex),
                SeleniumFunctions.setByValues("td;tagName"));
        Assert.assertNotEquals("Table cells for Intake is zero.", in_td.size(), 0);
        List<WebElement> out_td = SeleniumFunctions.findElementsByWebElement(ioTableRows.get(outIndex),
                SeleniumFunctions.setByValues("td;tagName"));
        Assert.assertNotEquals("Table cells for Output is zero.", out_td.size(), 0);

        //testing
        /*for(WebElement cell : net_td){
            String net = cell.getText();
            System.out.println("net = " + net);
        }
        for(WebElement cell : in_td){
            String intake = cell.getText();
            System.out.println("intake = " + intake);
        }
        for(WebElement cell : out_td){
            String output = cell.getText();
            System.out.println("output = " + output);
        }*/

        for (int i = 0; i < net_td.size(); i++) {
            try {
                //testing
               /* int intake = Integer.parseInt(in_td.get(i).getText().replace(",", ""));
                int output = Integer.parseInt(out_td.get(i).getText().replace(",", ""));*/
                int net = Integer.parseInt(net_td.get(i).getText().replace(",", ""));

                //Net = Intake - Output
                int difference = Integer.parseInt(in_td.get(i).getText().replace(",", "")) -
                        Integer.parseInt(out_td.get(i).getText().replace(",", ""));

                Assert.assertEquals("The Net: " + net + " in row: " + i + " does not equal: " + difference,
                        difference, net);
            } catch (Exception e) {
                WebElement header_table = Page.findTable(Hooks.getDriver(),
                        UtilFunctions.getTableValues(GlobalStepdefs.curTabName, "I/OTableDateTime")[0]);
                Assert.assertNotNull("Header Table I/OTableDateTime is null.", header_table);

                WebElement header_table_row = SeleniumFunctions.findElementByWebElement(header_table,
                        SeleniumFunctions.setByValues("tr;tagName"));
                Assert.assertNotNull("Header table row is null.", header_table_row);

                //Get all the table header cells
                List<WebElement> th_array = SeleniumFunctions.findElementsByWebElement(header_table_row, SeleniumFunctions.setByValues("th;tagName"));
                presentStr = presentStr + " Data under the following column is incorrect: " + th_array.get(i).getText();
            }
        }
        //Assert.assertEquals("Error in matching the values. Error: " + presentStr, presentStr, "");

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @And("^I save the Submission Record ID for the \"(.*)\" order$")
    public void storeColumnFromQueryRun(String orderString) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        //Separating this step out to its own step b/c sometimes IE doesn't actaully click the item in the table
        //"When I select "#{orderString}" from the "Existing orders for*" column in the "Orders" table"
        //sometimes the order doesn't get selected the 1st time, especially in IE
        /*if (Page.selectFromTableByValue(Hooks.getDriver(), GlobalStepdefs.curTabName, "Orders",
                "Existing orders for", orderString)) {
            Assert.assertTrue("'" + orderString + "' not selected from:\ncolumn: 'Existing orders for' in table: 'Orders'.",
                    true);
        } else {
            Assert.assertTrue("'" + orderString + "' not selected from:\ncolumn: 'Existing orders for' in table: 'Orders'.",
                    Page.selectFromTableByValue(Hooks.getDriver(), GlobalStepdefs.curTabName, "Orders",
                            "Existing orders for", orderString));
        }
        UtilFunctions.log("'" + orderString + "' not selected from:\ncolumn: 'Existing orders for*' in table: 'Orders'.");
        System.out.println("'" + orderString + "' not selected from:\ncolumn: 'Existing orders for*' in table: 'Orders'.");*/

        String paneFrame = UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(GlobalStepdefs.curTabName,
                "PANES", "OrderDetail", "frame", "", "");
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrame, "id");
        SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.TEN, "//span[text()='Order ID: ']/span" + ";xpath");
        WebElement orderIDObj = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//span[text()='Order ID: ']/span" + ";xpath"));
        Assert.assertNotNull("Order ID Object not present.", orderIDObj);
        String orderID = orderIDObj.getText();

        DBExecutor dbExecutorObj = Page.prepareQuery("SubmissionRecordId");
        dbExecutorObj.addWhere("cpoe_order.order_id=" + orderID);
        int dbExecCnt = 0;
        List<HashMap> rs = dbExecutorObj.executeQuery();
        while (rs.size() == 0) {
            dbExecCnt++;
            Thread.sleep(6000);
            rs = dbExecutorObj.executeQuery();
            if (dbExecCnt > GlobalConstants.TWENTY)
                Assert.assertTrue("Submission record id not obtained as query returned null. Query executed: "
                        + dbExecutorObj.query, false);
        }

        for (HashMap map : rs) {
            BigDecimal bg = (BigDecimal) map.get("SYNCREPOSITORYID");
            submissionRecordId = bg.intValue();
            persistent_patID = map.get("PAT_ID").toString();
            bg = (BigDecimal) map.get("SESSION_ID");
            sessionId = bg.intValue();
            UtilFunctions.log("SubmissionRecordID: " + submissionRecordId);
        }

        System.out.println("submissionRecordId is: " + submissionRecordId);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @And("^I wait for the updated PDF to generate$")
    public void waitForUpdatedPDF() throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

//        WebElement messageArea = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//div[@id='MsgBoardSection'];xpath"));
//        WebElement messageArea = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//span[text()='Order ID: '];xpath"));

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        String paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "MISC_ELEMENTS.MessageArea", "frame"));
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");
        String[] elementType = UtilFunctions.getElementStringAndType(fileObj, "MISC_ELEMENTS.MessageArea");
        String messageAreaPath = elementType[0];
        String messageAreaMethod = elementType[1];
        WebElement messageAreaObj = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues(messageAreaPath + ";" + messageAreaMethod));

        DBExecutor dbExecutorObj = Page.prepareQuery("SubmissionRecordId");
        dbExecutorObj.addWhere("pk_submission.pat_id = " + persistent_patID);
        dbExecutorObj.addWhere("pk_submission.routing_session_id > " + sessionId);
        int dbExecCnt = 0;
        List<HashMap> rs = dbExecutorObj.executeQuery();
        while (rs.size() == 0) {
            dbExecCnt++;
            Thread.sleep(12000);
            rs = dbExecutorObj.executeQuery();
            if (dbExecCnt > 50)
                Assert.assertTrue("Submission record id not obtained as query returned null. Query executed: " + dbExecutorObj.query, false);
            //Click something useless to keep the window alive.
            messageAreaObj.click();
        }

        for (HashMap map : rs) {
            BigDecimal bg = (BigDecimal) map.get("SYNCREPOSITORYID");
            submissionRecordId = bg.intValue();
            UtilFunctions.log("SubmissionRecordID: " + submissionRecordId);
        }

        System.out.println("submissionRecordId is: " + submissionRecordId);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @And("^I verify the \"(.*)\" PDF output using the \"(.*)\" output directory and the \"(.*)\" expected directory$")
    public void verifyPDFOutput(String pdfName, String outputDir, String expectedDir) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        PDFCompare pdfCompare = new PDFCompare();
        outputDir = UtilFunctions.getValueFromIniFile(UtilProperty.sectionName, outputDir);
        expectedDir = UtilFunctions.getValueFromIniFile(UtilProperty.sectionName, expectedDir);
        UtilFunctions.log("outputDir: " + outputDir);
        UtilFunctions.log("expectedDir: " + expectedDir);

        String outputFileName = pdfCompare.findFileBySubmissionID(submissionRecordId, outputDir);
        //String outputFileName = "1912161449_141697.pdf";//testing
        Assert.assertNotNull("File name ending with: " + outputFileName + " does not exist.", outputFileName);

        String[] outputStrList = pdfCompare.readPDFFileToStrArray(outputDir, outputFileName);
        Assert.assertNotNull("PDF: " + outputDir + outputFileName + " not found.", outputStrList);
        //testing
        System.out.println("\nOutput Results:");
        System.out.println("-----------------------------");
        for (String str : outputStrList)
            System.out.println(str);
        System.out.println();

        String expectedFileName = pdfName + ".pdf";
        String[] expectedStrList = pdfCompare.readPDFFileToStrArray(expectedDir, expectedFileName);
        Assert.assertNotNull("PDF: " + expectedDir + expectedFileName + " not found.", expectedStrList);
        //testing
        System.out.println("\nExpected Results:");
        System.out.println("-----------------------------");
        for (String str : expectedStrList)
            System.out.println(str);
        System.out.println();

        Assert.assertTrue("Output PDF: " + outputFileName + " and Expected PDF: " + expectedFileName + " do not match.",
                pdfCompare.comparePDFStrArrays(outputStrList, expectedStrList));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @Then("^the most recent visit should be selected by default in the (Note|HCA Note|Charge|Order) \"(.*)\" pane for the patient id stored at \"(.*)\" in persistent state$")
    public void patientRecentVisitMatch(String type, String paneName, String hashMapKey) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        paneName = paneName.replace(" ", "");
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
        String panePath = UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "path");
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        String paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");
        SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.TEN, panePath + ";" + "xpath");

        WebElement selectedVisitObj = null;
        WebElement divVisitObj = null;
        String visitContent = null;

        switch (type) {
            case "HCA Note":
                SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.TEN,
                        "//select[@id='visits']//option[@selected]" + ";xpath");
                selectedVisitObj = SeleniumFunctions.findElement(Hooks.getDriver(),
                        By.xpath("//select[@id='visits']//option[@selected='']"));
                Assert.assertNotNull("The selected visit is NULL and not found.", selectedVisitObj);
                visitContent = selectedVisitObj.getText().trim();
                break;
            case "Note":
                SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.TEN,
                        "//div[contains(@class,'selected-visit')]" + ";xpath");
                selectedVisitObj = SeleniumFunctions.findElement(Hooks.getDriver(),
                        SeleniumFunctions.setByValues("//div[contains(@class,'selected-visit')]/span" + ";xpath"));
                Assert.assertNotNull(selectedVisitObj);
                visitContent = selectedVisitObj.getText().trim();
                break;
            case "Charge":
                SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.TEN,
                        "//select[@class= 'visitSelection']" + ";xpath");
                selectedVisitObj = SeleniumFunctions.findElement(Hooks.getDriver(),
                        SeleniumFunctions.setByValues("//select[@class= 'visitSelection']"));
                if (selectedVisitObj == null) {
                    SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.TEN,
                            "//div[@id='status_info_area']" + ";xpath");
                    divVisitObj = SeleniumFunctions.findElement(Hooks.getDriver(),
                            SeleniumFunctions.setByValues("//div[@id='status_info_area']"));
                    visitContent = divVisitObj.getText();
                } else {
                    Select visit = new Select(selectedVisitObj);
                    visitContent = visit.getFirstSelectedOption().getText();
                }
                break;
            case "Order":
                SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.TEN,
                        "//select[@id= 'visits']" + ";xpath");
                selectedVisitObj = SeleniumFunctions.findElement(Hooks.getDriver(),
                        SeleniumFunctions.setByValues("//select[@id= 'visits']"));
                if (selectedVisitObj != null) {
                    {
                        Select visit = new Select(selectedVisitObj);
                        visitContent = visit.getFirstSelectedOption().getText();
                    }
                }
                break;
        }

        String patID = persistent_state.get(hashMapKey).trim();
        DBExecutor dbExecutorObj = Page.prepareQuery("PatientMostRecentVisits");
        dbExecutorObj.addWhere("pat_id=" + patID);
        List<HashMap> rs = dbExecutorObj.executeQuery();
        String mostRecentVisitDate = rs.get(0).get("MOST_RECENT").toString();

        if (selectedVisitObj == null && divVisitObj != null)
            Assert.assertTrue("Most recent visit " + mostRecentVisitDate + " is not selected by default in " +
                    type + " pane", visitContent.contains(mostRecentVisitDate));
        else if (selectedVisitObj != null && divVisitObj == null)
            Assert.assertTrue("Most recent visit " + mostRecentVisitDate + " is not selected by default in " +
                    type + " pane", visitContent.contains(mostRecentVisitDate));
        else
            Assert.assertTrue("Visit dropdown is not found in the " + type + " pane", false);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @Then("^I save the patient ID(?: of \"(.*)\")? under name \"(.*)\" in persistent state$")
    public void savePatientID(String patientName, String key) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String patID = "";
        persistent_state.clear();

        if (patientName == null)
            patID = PatientListPage.getPatientID(Hooks.getDriver(), "");
        else
            patID = PatientListPage.getPatientID(Hooks.getDriver(), patientName);

        Assert.assertNotNull("patID is NULL and not found.", patID);

        System.out.println("patID: " + patID);
        UtilFunctions.log("patID: " + patID);
        persistent_state.put(key, patID);

        System.out.println("patID: " + persistent_state.get(key));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    /**************************************************************************
     * name: savePatientDetail(String patientDetail, String patientName, String key)
     * functionality: Saves the required patient detail in persistent state to be used later
     * param: String patientDetail - required patient detail example : arrival date, Length Of Stay, PK patient Key. Pass the value as displayed in patient details pane
     * param: String patientName - Patient name
     * param: String key - variable to store the value retireved from patient detail
     *************************************************************************/
    @Then("^I save the \"(.*)\" value of patient(?: of \"(.*)\")? under name \"(.*)\" in persistent state$")
    public void savePatientDetail(String patientDetail, String patientName, String key) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String patdetail = "";
        persistent_state.clear();
        if (patientName != null && !patientName.equals("")) {
            PatientListPage.selectPatientByName(Hooks.getDriver(), patientName);
        }
        String curNav = PatientListPage.getClinicalNav(Hooks.getDriver(), "").trim();
        PatientListPage.selectClinicalNav(Hooks.getDriver(), "Patient Detail");
        List<WebElement> rows = Page.getTableRows(Hooks.getDriver(), "PatientList", "Patient Account");
        for (WebElement row : rows) {
            List<WebElement> tdArr = SeleniumFunctions.findElementsByWebElement(row, SeleniumFunctions.setByValues("td;tagName"));
            for (int index = 0; index < tdArr.size(); index++) {
                if (tdArr.get(index).getText().trim().equals(patientDetail)) {
                    patdetail = tdArr.get(index + 1).getText().trim();
                }
            }
        }
        UtilFunctions.log("Required patient detail for " + patientDetail + " is " + patdetail);
        persistent_state.put(key, patdetail);
        PatientListPage.selectClinicalNav(Hooks.getDriver(), curNav);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    //Click checkbox for screens/panes/windows that have been redone in Vue.js, like CPOE and NW, but that are used in
    //Classic mode
    //Added menu item as a choice in here, then didn't need it.  Left it in for future use.
    @Then("^I click the \"(.*?)\" (radio|checkbox|menu item)(?: in the \"(.*?)\" pane)?$")
    public void clickRadioOrCheckbox(String elementName, String elementType, String paneName) {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        elementName = elementName.replace(" ", "");

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        String paneFrames = null;
        String elementXpath;

        if (elementType.equalsIgnoreCase("radio")) {
            String[] elementTypeArr = UtilFunctions.getElementStringAndType(fileObj, "RADIOS." + elementName);
            elementXpath = elementTypeArr[0];
            if (paneName == null)
                paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj,
                        "RADIOS." + elementName, "frame"));
        } else {
            String[] elementTypeArr = UtilFunctions.getElementStringAndType(fileObj, "CHECKBOXES." + elementName);
            elementXpath = elementTypeArr[0];
            if (paneName == null)
                paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj,
                        "CHECKBOXES." + elementName, "frame"));
        }

        if (paneName != null) {
            paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj,
                    "PANES." + paneName.replace(" ", ""), "frame"));
        }

        UtilFunctions.log(elementType + " xpath: " + elementXpath);
        UtilFunctions.log("PaneFrames: " + paneFrames);
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");

        WebElement element = SeleniumFunctions.findElement(Hooks.getDriver(), By.xpath(elementXpath));
        Assert.assertNotNull(elementName + " " + elementType + " is NULL and not found.", element);

        try {
            element.click();
            if (!SeleniumFunctions.isSelected(element)) {
                SeleniumFunctions.click(element);
                if (!SeleniumFunctions.isSelected(element)) {
                    Actions action = new Actions(Hooks.getDriver());
                    action.moveToElement(element).click().build().perform();
                }
            }
        } catch (ElementClickInterceptedException e) {
            SeleniumFunctions.click(element);
            if (!SeleniumFunctions.isSelected(element)) {
                Actions action = new Actions(Hooks.getDriver());
                action.moveToElement(element).click().build().perform();
            }
        } catch (ElementNotInteractableException ex) {
            SeleniumFunctions.click(element);
            if (!SeleniumFunctions.isSelected(element)) {
                Actions action = new Actions(Hooks.getDriver());
                action.moveToElement(element).click().build().perform();
            }
        }

        //If the radio, checkbox, menu item is still not selected, try checking if its parent is selected.
        //This is for new Vue.js UI, mostly in CPOE and NW screens
        if (!SeleniumFunctions.isSelected(element)) {
            WebElement parentEl = SeleniumFunctions.getParentWebElement(elementXpath);
            if (parentEl != null) {
                if (SeleniumFunctions.isSelected(parentEl))
                    element = parentEl;
            }
        }

        Assert.assertTrue(elementName + " " + elementType + " is NOT selected after 3 tries.",
                SeleniumFunctions.isSelected(element));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @Then("^I enter \"(.*?)\" in the \"(.*?)\" discoverable textbox that appears$")
    public void enterInDiscoverableTextbox(String value, String textBoxName) {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        textBoxName = textBoxName.replace(" ", "");
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        String[] elementType = UtilFunctions.getElementStringAndType(fileObj, "TEXT_FIELDS." + textBoxName);
        String textXpath = elementType[0];
        String bySelector = elementType[1];
        UtilFunctions.log("Text box textPath: " + textXpath);

        String paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj,
                "TEXT_FIELDS." + textBoxName, "frame"));
        UtilFunctions.log("PaneFrames: " + paneFrames);
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");
        //Find and click on the parent element of the textbox to make the textbox appear and have focus
        WebElement txtboxParent = Page.findTextBox(Hooks.getDriver(), textXpath, bySelector);
        Assert.assertNotNull(textBoxName + " textbox is NULL and not found.", txtboxParent);
        txtboxParent.click();
        Assert.assertTrue(textBoxName + " textbox not selected/clicked.", SeleniumFunctions.isSelected(txtboxParent));

        WebElement textbox = SeleniumFunctions.findElementByWebElement(txtboxParent, By.xpath(".//input[@type='text']"));
        Assert.assertNotNull(textBoxName + " textbox is NULL and not found.", textbox);

        if (txtboxParent.getAttribute("class").contains("md-has-value")) {
            textbox.clear();
        }
        textbox.sendKeys(value);
        //Can't use getText() on the input itself b/c it has no text, even after sending keys, and has no value attrib.
        Assert.assertTrue(textBoxName + " textbox does NOT contain a value.",
                txtboxParent.getAttribute("class").contains("md-has-value"));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @Then("^I clear or empty the HashMap$")
    public void clearPersistentState() {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        persistent_state.clear();
        Assert.assertTrue("The HashMap called persistent_state is not empty or cleared.",
                persistent_state.isEmpty());

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

//------------------------Private & Other Methods--------------------------------------------------------------------

    private String stripAlphaCharsOut(String testOrLabLevelStr) {
        char[] testOrLabLevelArr = testOrLabLevelStr.toCharArray();
        String newString = "";

        for (int i = 0; i < testOrLabLevelArr.length; ++i) {
            if (isDigit(testOrLabLevelArr[i])) {
                newString += testOrLabLevelArr[i];
            } else if (Character.toString(testOrLabLevelArr[i]).equals(".")) {
                newString += testOrLabLevelArr[i];
            }
        }
        return newString;
    }

}//end class
