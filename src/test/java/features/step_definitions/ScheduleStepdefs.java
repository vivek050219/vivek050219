package features.step_definitions;


import common.SeleniumFunctions;
import constants.GlobalConstants;
import cucumber.api.DataTable;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import features.Hooks;
import org.json.simple.JSONObject;
import org.junit.Assert;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import support.Page;
import utils.UtilFunctions;

import java.util.HashMap;
import java.util.List;

import static features.Hooks.driver;


/******************************************************************************
 Class Name: ScheduleStepDefsStepdefs
 Contains step definitions related to Schedule tab page
 ******************************************************************************/

public class ScheduleStepdefs {

    public String className = getClass().getSimpleName();

    @Then("^\"(.*?)\" visits should display on the Schedule tab$")
    public void checkVisitsInScheduleTab(String visitList) throws Throwable {
       UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
       }.getClass().getEnclosingMethod().getName() + " : Start");
       boolean patientfound = false;
       String patientName;
       String visitName;
       String[] visitArr = visitList.split(",");
       for (String visit : visitArr) {
           patientName = "SCHEDULE-" + visit + ", TEST";
           visitName = "Visit " + visit;
           String[] tableDetailArr = UtilFunctions.getTableValues(GlobalStepdefs.curTabName, "ScheduledVisits");
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
           SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.TEN, tablePath + ";xpath");
           WebElement tableObj = Page.findTable(Hooks.getDriver(), tablePath);
           WebElement tableBodyObj = SeleniumFunctions.findElementByWebElement(tableObj, SeleniumFunctions.setByValues(tableBody + ";xpath"));
           List<WebElement> tableRowsArr= SeleniumFunctions.findElementsByWebElement(tableBodyObj, SeleniumFunctions.setByValues(".//tr/td[@class='scheduledSlot']" + ";xpath"));
           if(tableRowsArr == null) {
               UtilFunctions.log("Rows of table Scheduled Visits not found.");
               Assert.assertTrue("Rows of table Scheduled Visits not found.", false);
           } else {
               UtilFunctions.log("Rows of table Scheduled Visits found.");
               for (WebElement tableRow : tableRowsArr){
                   UtilFunctions.log("Row with text: " +tableRow.getText() + " in table Scheduled Visits found.");
                   List<WebElement> tableCellArr = SeleniumFunctions.findElementsByWebElement(tableRow, SeleniumFunctions.setByValues(".//table[@id='AppointmentDetail']" + ";xpath"));
                   for (WebElement tableCell : tableCellArr) {
                       UtilFunctions.log("Cell with text: " +tableCell.getText() + " in table Scheduled Visits found.");
                       String cellName = SeleniumFunctions.findElementByWebElement(tableCell, SeleniumFunctions.setByValues(".//tr[@id='AppointmentDetailRow']//td[@id='Patient.WebFullName']")).getText();
                       String cellVisit = SeleniumFunctions.findElementByWebElement(tableCell, SeleniumFunctions.setByValues(".//tr//td[@id='Account.ReasonForVisit']")).getText();
                       if (cellName.equals(patientName) && cellVisit.contains(visitName)) {
                           patientfound = true;
                           UtilFunctions.log("Patient details found in Scheduled Visits table.");
                           break;
                       }
                   }
                   if (patientfound)
                       break;
               }
           }
           Assert.assertTrue("Patient " + patientName + " and visit " + visitName + " not found in Schedule Visits" , patientfound);
       }
       UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }
    @Then ("^\"(.*?)\" Charges should be viewable on the Schedule tab$")
    public void checkChargesInScheduleTab(String chargeList) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        boolean chargeFound = false;
        String[] chargeArr = chargeList.split(",");
        for (String charge : chargeArr) {
            String[] tableDetailArr = UtilFunctions.getTableValues(GlobalStepdefs.curTabName, "ScheduledVisits");
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
            SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.TEN, tablePath + ";xpath");
            WebElement tableObj = Page.findTable(Hooks.getDriver(), tablePath);
            WebElement tableBodyObj = SeleniumFunctions.findElementByWebElement(tableObj, SeleniumFunctions.setByValues(tableBody + ";xpath"));
            List<WebElement> tableRowsArr = SeleniumFunctions.findElementsByWebElement(tableBodyObj, SeleniumFunctions.setByValues(".//tr/td[@class='scheduledSlot']" + ";xpath"));
            if (tableRowsArr == null) {
                UtilFunctions.log("Rows of table Scheduled Visits not found.");
                Assert.assertTrue("Rows of table Scheduled Visits not found.", false);
            } else {
                UtilFunctions.log("Rows of table Scheduled Visits found.");
                for (WebElement tableRow : tableRowsArr) {
                    UtilFunctions.log("Row with text: " + tableRow.getText() + " in table Scheduled Visits found.");
                    List<WebElement> tableCellArr = SeleniumFunctions.findElementsByWebElement(tableRow, SeleniumFunctions.setByValues(".//table[@id='AppointmentDetail']" + ";xpath"));
                    for (WebElement tableCell : tableCellArr) {
                        UtilFunctions.log("Cell with text: " + tableCell.getText() + " in table Scheduled Visits found.");
                        String cellVisit = SeleniumFunctions.findElementByWebElement(tableCell, SeleniumFunctions.setByValues(".//tr//td[@id='Account.ReasonForVisit']")).getText();
                        String[] chargeDetails = cellVisit.split(" ");
                        for (String chargeName : chargeDetails) {
                            if (chargeName.equals(charge)) {
                                chargeFound = true;
                                UtilFunctions.log("Patient Charge details found in Scheduled Visits table.");
                                break;
                            }
                        }
                    }
                    if (chargeFound)
                        break;
                }
            }
            Assert.assertTrue("Patient with charge " + charge + " not found in Schedule Visits", chargeFound);
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }
    @Then ("^\"(.*?)\" Charges should be editable on the Schedule tab$")
    public void checkChargesEditableInScheduleTab(String chargeEditableList) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        boolean chargeEditable = false;
        String[] chargeEditArr = chargeEditableList.split(",");
        for (String chargeEdit : chargeEditArr) {
            String[] tableDetailArr = UtilFunctions.getTableValues(GlobalStepdefs.curTabName, "ScheduledVisits");
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
            SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.TEN, tablePath + ";xpath");
            WebElement tableObj = Page.findTable(Hooks.getDriver(), tablePath);
            WebElement tableBodyObj = SeleniumFunctions.findElementByWebElement(tableObj, SeleniumFunctions.setByValues(tableBody + ";xpath"));
            List<WebElement> tableRowsArr = SeleniumFunctions.findElementsByWebElement(tableBodyObj, SeleniumFunctions.setByValues(".//tr/td[@class='scheduledSlot']" + ";xpath"));
            if (tableRowsArr == null) {
                UtilFunctions.log("Rows of table Scheduled Visits not found.");
                Assert.assertTrue("Rows of table Scheduled Visits not found.", false);
            } else {
                UtilFunctions.log("Rows of table Scheduled Visits found.");
                for (WebElement tableRow : tableRowsArr) {
                    UtilFunctions.log("Row with text: " + tableRow.getText() + " in table Scheduled Visits found.");
                    List<WebElement> tableCellArr = SeleniumFunctions.findElementsByWebElement(tableRow, SeleniumFunctions.setByValues(".//table[@id='AppointmentDetail']" + ";xpath"));
                    for (WebElement tableCell : tableCellArr) {
                        UtilFunctions.log("Cell with text: " + tableCell.getText() + " in table Scheduled Visits found.");
                        String cellChargeStatus = SeleniumFunctions.findElementByWebElement(tableCell, SeleniumFunctions.setByValues(".//tr//td[@id='BillingStatus']")).getText();
                        String cellVisit = SeleniumFunctions.findElementByWebElement(tableCell, SeleniumFunctions.setByValues(".//tr//td[@id='Account.ReasonForVisit']")).getText();
                        String[] chargeDetails = cellVisit.split(" ");
                        for (String chargeName : chargeDetails) {
                            if (chargeName.equals(chargeEdit) && cellChargeStatus.trim().equals("Holding Bin")) {
                                chargeEditable = true;
                                UtilFunctions.log("Patient Charge details found in Scheduled Visits table.");
                                break;
                            }
                        }
                    }
                    if (chargeEditable)
                        break;
                }
            }
            Assert.assertTrue("Patient with charge " + chargeEdit + " is not editable in Schedule Visits", chargeEditable);
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^the following visits? should appear in the scheduled tab$")
    public void validateVisitsinScheduleTab(DataTable visitList) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        List<String> dataList = visitList.asList(String.class);
        //HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        //String paneFrame = "FRAME_SCHEDULE_TABLE";
        //String paneFrames = UtilFunctions.getFrameValue(frameMap, paneFrame);
        //SeleniumFunctions.selectFrame(driver, paneFrames, "id");
        String tableName = "ScheduledVisits";
        WebElement tableObj = Page.findTable(driver, GlobalStepdefs.curTabName, tableName);
        WebElement tableBody = Page.findTableBody(tableObj, "tbody");
        List<WebElement> tableRows = SeleniumFunctions.findElementsByWebElement(tableBody, SeleniumFunctions.setByValues("tr[descendant::td[@class='scheduledSlot']]" + ";xpath"));
        if (tableRows == null) {
            UtilFunctions.log("Table: " + tableName + " Object not found.");
            Assert.assertTrue("Rows of Table: " + tableName + " not found.", false);
        } else {
            boolean flag = false;
            for (String data : dataList) {
                for (WebElement row : tableRows) {
                    List<WebElement> tableCells = SeleniumFunctions.findElementsByWebElement(row, SeleniumFunctions.setByValues("td[@class='scheduledSlot']" + ";xpath"));
                    for (WebElement cell : tableCells) {
                        String cellText = cell.getText().toLowerCase();
                        if (cellText.contains(data.toLowerCase())) {
                            flag = true;
                            break;
                        }
                    }
                    if (flag)
                        break;
                }
                Assert.assertTrue("Visits " + data + " is not found in the Schedule tab", flag);
            }
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^the charge should be (viewable|editable)(?: with \"(.*?)\")? for the \"(.*?)\" visit in the scheduled tab$")
    public void checkChargesViewableOrEditableForVisit(String chargeState, String value, String visitName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        String paneFrame = "FRAME_SCHEDULE_TABLE";
        String paneFrames = UtilFunctions.getFrameValue(frameMap, paneFrame);
        SeleniumFunctions.selectFrame(driver, paneFrames, "id");
        String linkCheck;


        WebElement ele = Page.findTable(driver, GlobalStepdefs.curTabName, "ScheduledVisits");
        WebElement tableBody = Page.findTableBody(ele, "tbody");
        if (value != null && value.equals("Not Coded Outpatient")) {
            List<WebElement> cells = SeleniumFunctions.findElementsByWebElement(tableBody, By.xpath(".//td[@class='scheduledSlot']/span/table[@id='AppointmentDetail']"));
            for (WebElement cell : cells) {
                String cellName = SeleniumFunctions.findElementByWebElement(cell, By.xpath(".//tr[@id='AppointmentDetailRow']//td[@id='Patient.WebFullName']")).getText();
                WebElement linkName = SeleniumFunctions.findElementByWebElement(cell, By.xpath(".//a[@clickmessage='BillingStatus' and ancestor::td[@id='BillingStatus']]"));
                if (visitName.equals(cellName) && chargeState.equals("viewable")) {
                    linkName = SeleniumFunctions.findElementByWebElement(cell, By.xpath(".//img[@title='Display detailed information about the patient' and @clickmessage='patientdetails']"));
                    linkName.click();
                    paneLoadForVisit(chargeState);
                    break;
                }
                if (visitName.equals(cellName) && linkName.equals(value)) {
                    linkCheck = "true";
                }
            }
        } else {
            List<WebElement> cells = SeleniumFunctions.findElementsByWebElement(tableBody, By.xpath(".//td[@class='scheduledSlot']/span/table[@id='AppointmentDetail']"));
            for (WebElement cell : cells) {
                String cellName = SeleniumFunctions.findElementByWebElement(cell, By.xpath(".//tr[@id='AppointmentDetailRow']//td[@id='Patient.WebFullName']")).getText();
                WebElement linkName = SeleniumFunctions.findElementByWebElement(cell, By.xpath(".//a[@ClickMessage='BillingStatus' and ancestor::td[@id='BillingStatus']]"));
                if (visitName.equals(cellName) && linkName.getText().equals("Holding Bin")) {
                    linkName.click();
                    paneLoadForVisit(chargeState);
                    break;
                }
                if (visitName.equals(cellName) && chargeState.equals("viewable")) {
                    linkName = SeleniumFunctions.findElementByWebElement(cell, By.xpath(".//img[@title='Display detailed information about the patient' and @clickmessage='patientdetails']"));
                    linkName.click();
                    paneLoadForVisit(chargeState);
                    break;
                }
                if (visitName.equals(cellName) && linkName.getText().equals("Not Coded Outpatient") && !chargeState.equals("viewable")) {
                    linkName.click();
                    paneLoadForVisit(chargeState);
                    break;
                }
            }
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }
    public void paneLoadForVisit(String chargeState)throws Throwable{
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        if (chargeState.equals("viewable")) {
            globalStepdefs.checkPaneLoad("PatientDetail", "load", null);

            //Commenting out the hard-coded wait
            //Thread.sleep(4000);
            globalStepdefs.clickMiscElement("Close", null, null,"exists");
            globalStepdefs.clickButton("Close", null, "exists");
        } else if(chargeState.equals("editable")){
            //Commenting out the hard-coded wait
            //Thread.sleep(4000);

            //For Not Coded OutPatient
            globalStepdefs.clickMiscElement("Close", null, "ChargeEntry","exists");
            //For holding bin
            globalStepdefs.clickMiscElement("Close", null, null,"exists");
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then ("^All cells in the \"(.*?)\" table should contain the text \"(.*?)\"$")
    public void checkTextInTableAllCells(String tableName, String value) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        tableName = tableName.replace(" ", "");
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
        String tableRowPath = UtilFunctions.getElementFromJSONFile(fileObj,"TABLES." + tableName, "rowPath");
        String tableCellPath = UtilFunctions.getElementFromJSONFile(fileObj,"TABLES." + tableName, "cellPath");
        WebElement tableObj = Page.findTable(Hooks.driver,GlobalStepdefs.curTabName, tableName);
        WebElement tableBodyObj = Page.findTableBody(tableObj,"tbody");
        List<WebElement> tableRows = SeleniumFunctions.findElementsByWebElement(tableBodyObj,SeleniumFunctions.setByValues(tableRowPath + ";xpath"));
        if (tableRows == null) {
            UtilFunctions.log("Table: " + tableName + " Object not found.");
            Assert.assertTrue("Rows of Table: " + tableName + " not found.", false);
        } else {
            for (WebElement row : tableRows) {
                List<WebElement> tableCells = SeleniumFunctions.findElementsByWebElement(row, SeleniumFunctions.setByValues(tableCellPath + ";xpath"));
                for (WebElement cell : tableCells) {
                    String cellText = cell.getText().toLowerCase();
                    if (!cellText.equals(" ")){
                        Assert.assertTrue( value + " is not present in all cells of table " +  tableName, cellText.contains(value.toLowerCase()));
                    }
                }
            }
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then ("^All cells in the schedule visits table should( not)? be selected$")
    public void checkTableAllCellsSelection(String value) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        String tableName = "ScheduledVisits";
        WebElement tableObj = Page.findTable(driver, GlobalStepdefs.curTabName, tableName);
        WebElement tableBody = Page.findTableBody(tableObj, "tbody");
        List<WebElement> tableRows = SeleniumFunctions.findElementsByWebElement(tableBody, SeleniumFunctions.setByValues("tr[descendant::td[@class='scheduledSlot']]" + ";xpath"));
        if (tableRows == null) {
            UtilFunctions.log("Table: " + tableName + " Object not found.");
            Assert.assertTrue("Rows of Table: " + tableName + " not found.", false);
        } else {
            for (WebElement row : tableRows) {
                List<WebElement> tableCells = SeleniumFunctions.findElementsByWebElement(row, SeleniumFunctions.setByValues("td[@class='scheduledSlot']/span/table[@id='AppointmentDetail']" + ";xpath"));
                for (WebElement cell : tableCells) {
                    String cellText = cell.getAttribute("class");
                    if (value == null) {
                        Assert.assertTrue("All cells of Schedule Visit table are not selected in the Schedule tab", cellText.equals("scheduledItemSelected"));
                    } else {
                        Assert.assertTrue("Cells of Schedule Visit table are selected in the Schedule tab", cellText.equals("scheduledItem"));

                    }
                }
            }
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then ("^the cell with text \"(.*?)\" from the \"(.*?)\" column in the \"(.*?)\" table should( not)? exist")
    public void checkTableCellWithTextExists(String cellValue, String columnName, String tableName, String condition) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        cellValue = UtilFunctions.convertThruRegEx(cellValue);
        columnName = UtilFunctions.convertThruRegEx(columnName);
        tableName = tableName.replace(" ", "");
        String columnIndex = Page.findTableColumn(Hooks.getDriver(), GlobalStepdefs.curTabName, tableName, columnName);
        int colIndex = 0;
        if (columnIndex != null) {
            colIndex = Integer.parseInt(columnIndex);
            JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
            String tableRowPath = UtilFunctions.getElementFromJSONFile(fileObj,"TABLES." + tableName, "rowPath");
            WebElement tableObj = Page.findTable(Hooks.driver,GlobalStepdefs.curTabName, tableName);
            WebElement tableBodyObj = Page.findTableBody(tableObj,"tbody");
            List<WebElement> tableRows = SeleniumFunctions.findElementsByWebElement(tableBodyObj,SeleniumFunctions.setByValues(tableRowPath + ";xpath"));
            boolean flag = false;
            for (WebElement row : tableRows) {
                List<WebElement> tableColumns = SeleniumFunctions.findElementsByWebElement(row, SeleniumFunctions.setByValues("td" + ";xpath"));
                String text = tableColumns.get(colIndex).getText();
                    if (text.contains(cellValue)) {
                        flag = true;
                        break;
                    }
            }
            if (condition == null) {
                Assert.assertTrue("Cell with text" + cellValue + " is not found in table: " + tableName, flag);
            } else {
                Assert.assertFalse("Cell with text" + cellValue + " is found in table: " + tableName, flag);
            }
        }else{
            Assert.assertTrue("Cell with text" + cellValue + " is not found in table: " + tableName, condition != null);
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I select the cell( containing)? with text \"(.*?)\" from the \"(.*?)\" column in the \"(.*?)\" table$")
    public void selectCellFromTheTableColumn(String contains,  String value, String columnName, String tableName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        value = UtilFunctions.convertThruRegEx(value);
        columnName = UtilFunctions.convertThruRegEx(columnName);
        tableName = tableName.replace(" ", "");
        String columnIndex = Page.findTableColumn(Hooks.getDriver(), GlobalStepdefs.curTabName, tableName, columnName);
        int colIndex = 0;
        if (columnIndex != null) {
            colIndex = Integer.parseInt(columnIndex);
            JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
            String tableRowPath = UtilFunctions.getElementFromJSONFile(fileObj, "TABLES." + tableName, "rowPath");
            if (tableRowPath == null)
                tableRowPath = "tr";
            WebElement tableObj = Page.findTable(Hooks.driver, GlobalStepdefs.curTabName, tableName);
            WebElement tableBodyObj = Page.findTableBody(tableObj, "tbody");
            List<WebElement> tableRows = SeleniumFunctions.findElementsByWebElement(tableBodyObj, SeleniumFunctions.setByValues(tableRowPath + ";xpath"));
            Boolean cellFound = false;
            for (WebElement row : tableRows) {
                List<WebElement> tableColumns = SeleniumFunctions.findElementsByWebElement(row, SeleniumFunctions.setByValues("td" + ";xpath"));
//                String text = tableColumns.get(colIndex).getText();
                if (contains != null) {
                    if (tableColumns.get(colIndex).getText().contains(value))
                        cellFound = true;
                }else {
                    if (tableColumns.get(colIndex).getText().trim().equals(value))
                        cellFound = true;
                }
                if (cellFound) {
                    try {
                        tableColumns.get(colIndex).click();
                        Thread.sleep(1000);
                    } catch (Exception e) {
                        e.printStackTrace();
                        UtilFunctions.log("Cell of " + tableName + " is not selected. Exception: " + e.getMessage());
                        Assert.assertTrue("Cell of " + tableName + " is not selected. Exception: " + e.getMessage(), false);
                    }
                    break;
                }
            }
            Assert.assertTrue("Cell with value " + value + " is not found in column " + columnName + " in table " + tableName, cellFound);
        }else{
            Assert.assertTrue("Column " + columnName + " is not found in table: " + tableName, false);
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When ("^I click the \"(.*?)\" (?:link|\"(.*?)\") in the cell with text \"(.*?)\" in the \"(.*?)\" column of the \"(.*?)\" table$")
    public void clickElementFromFromTableCell(String obj, String objType , String cellText, String columnName, String tableName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        cellText = UtilFunctions.convertThruRegEx(cellText);
        columnName = UtilFunctions.convertThruRegEx(columnName);
        tableName = tableName.replace(" ", "");
        String columnIndex = Page.findTableColumn(Hooks.getDriver(), GlobalStepdefs.curTabName, tableName, columnName);
        int colIndex = 0;
        if (columnIndex != null) {
            colIndex = Integer.parseInt(columnIndex);
            JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
            String tableRowPath = UtilFunctions.getElementFromJSONFile(fileObj, "TABLES." + tableName, "rowPath");
            WebElement tableObj = Page.findTable(Hooks.driver, GlobalStepdefs.curTabName, tableName);
            WebElement tableBodyObj = Page.findTableBody(tableObj, "tbody");
            List<WebElement> tableRows = SeleniumFunctions.findElementsByWebElement(tableBodyObj, SeleniumFunctions.setByValues(tableRowPath + ";xpath"));
            for (WebElement row : tableRows) {
                List<WebElement> tableColumns = SeleniumFunctions.findElementsByWebElement(row, SeleniumFunctions.setByValues("td" + ";xpath"));
                WebElement cellObj = tableColumns.get(colIndex);
                if (cellObj.getText().contains(cellText)) {
                    try {
                        WebElement cellChildObj;
                        if (objType == null) {
                            cellChildObj = SeleniumFunctions.findElementByWebElement(cellObj, SeleniumFunctions.setByValues(".//a[normalize-space(./text())='" + obj + "']" + ";xpath"));
                        } else {
                            String xpath = UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName(GlobalStepdefs.curTabName, objType.toUpperCase()+"S", obj, "path", "", "");
                            cellChildObj = SeleniumFunctions.findElementByWebElement(cellObj, SeleniumFunctions.setByValues(xpath + ";xpath"));
                        }
                        Assert.assertTrue("Cell Element " + obj + " of " + tableName + " is not found", cellChildObj != null);
                        cellChildObj.click();
                        Thread.sleep(1000);
                    } catch (Exception e) {
                        e.printStackTrace();
                        UtilFunctions.log("Cell Element of " + tableName + " is not selected. Exception: " + e.getMessage());
                    }
                    break;
                }
            }
        }else{
            Assert.assertTrue("Column " + columnName + " is not found in table: " + tableName, false);
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then ("^the cell with text \"(.*?)\" from the \"(.*?)\" column in the \"(.*?)\" table should( not)? contain text \"(.*?)\"$")
    public void checkTableCellForTextExists(String cellValue, String columnName, String tableName, String condition,
                                            String textToCheck) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        cellValue = UtilFunctions.convertThruRegEx(cellValue);
        textToCheck = UtilFunctions.convertThruRegEx(textToCheck);
        columnName = UtilFunctions.convertThruRegEx(columnName);
        tableName = tableName.replace(" ", "");
        String columnIndex = Page.findTableColumn(Hooks.getDriver(), GlobalStepdefs.curTabName, tableName, columnName);
        int colIndex = 0;

        if (columnIndex != null) {
            colIndex = Integer.parseInt(columnIndex);
            JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
            String tableRowPath = UtilFunctions.getElementFromJSONFile(fileObj,"TABLES." + tableName, "rowPath");
            WebElement tableObj = Page.findTable(Hooks.driver,GlobalStepdefs.curTabName, tableName);
            WebElement tableBodyObj = Page.findTableBody(tableObj,"tbody");
            List<WebElement> tableRows = SeleniumFunctions.findElementsByWebElement(tableBodyObj,SeleniumFunctions.setByValues(tableRowPath + ";xpath"));
            boolean flag = false;
            for (WebElement row : tableRows) {
                List<WebElement> tableColumns = SeleniumFunctions.findElementsByWebElement(row, SeleniumFunctions.setByValues("td" + ";xpath"));
                String text = tableColumns.get(colIndex).getText();
                if (text.contains(cellValue) && text.contains(textToCheck)) {
                    flag = true;
                    break;
                }
            }
            if (condition == null) {
                Assert.assertTrue("Cell with text" + cellValue + " is not found with text" + textToCheck + " in table: " + tableName, flag);
            } else {
                Assert.assertFalse("Cell with text" + cellValue + " is found with text" + textToCheck + " in table: " + tableName, flag);
            }
        }else{
            Assert.assertTrue("Cell with text" + cellValue + " is not found in table: " + tableName, condition != null);
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }
}
