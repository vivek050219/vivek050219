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
import org.openqa.selenium.*;
import org.openqa.selenium.interactions.Actions;
import support.Page;
import utils.UtilFunctions;

import java.util.*;

import static features.Hooks.driver;

public class AssignmentStepdefs {

    public String className = getClass().getSimpleName();

    @When("^I open the search screen from the assignment list dropdown?$")
    public void openSearchScreen() throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        String dropDownName = "AssignmentList";
        String LinkName = "Search";
        UtilFunctions.log("Dropdown Name: " + dropDownName);
        String dropDown = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PKDROPDOWNS." + dropDownName, "frame"));
        SeleniumFunctions.selectFrame(driver, dropDown, "id");
        String[] elementType = UtilFunctions.getElementStringAndType(fileObj, "PKDROPDOWNS." + dropDownName);
        String dropdownPath = elementType[0];
        String dropdownMethod = elementType[1];
        SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(dropdownPath + ";" + dropdownMethod)).click();
        elementType = UtilFunctions.getElementStringAndType(fileObj, "LINKS." + LinkName);
        String LinkPath = elementType[0];
        String LinkMethod = elementType[1];
        Thread.sleep(2000);
        SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(LinkPath + ";" + LinkMethod)).click();

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^patient \"(.*?)\" should( not)? be on the \"(.*?)\" sublist$")
    public void checkPatientOnAssignmentSublist(String patientName, String shouldNotBeOnList, String sublist)
            throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        String paneFrames = UtilFunctions.getFrameValue(frameMap, "FRAME_PATIENTLIST_ASSIGNMENT");
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");

        patientName = UtilFunctions.reformName(patientName).toUpperCase();
        UtilFunctions.log("reformedPatientName: " + patientName);
        WebElement elt = SeleniumFunctions.findElement(Hooks.getDriver(),
                By.xpath("//div[contains(@class, 'dataTables_wrapper') and " +
                        "preceding-sibling::div[contains(@class, 'sublist-header') and " +
                        "child::div/div[text()='" + sublist +
                        "']]]//td[starts-with(normalize-space(text()),'" + patientName + "')]"));


        if ((" not").equals(shouldNotBeOnList)) {
            Assert.assertNull(elt);
            UtilFunctions.log("Patient " + patientName + " correctly not found on " + sublist + " list.");
            System.out.println("Patient " + patientName + " correctly not found on " + sublist + " list.");
        } else {
            if (elt == null) {
                UtilFunctions.log("Patient " + patientName + " not found trying again.");
                System.out.println("Patient " + patientName + " not found trying again.");
                elt = SeleniumFunctions.findElement(Hooks.getDriver(),
                        By.xpath("//div[contains(@class, 'dataTables_wrapper') and " +
                                "preceding-sibling::div[contains(@class, 'sublist-header') and " +
                                "child::div/div[text()='" + sublist +
                                "']]]//td[starts-with(normalize-space(text()),'" + patientName + "')]"));
                Assert.assertNotNull(elt);
                UtilFunctions.log("Patient " + patientName + " found on " + sublist + " list on 2nd try.");
                System.out.println("Patient " + patientName + " found on " + sublist + " list on 2nd try.");
            } else {
                Assert.assertNotNull(elt);
                UtilFunctions.log("Patient " + patientName + " found on " + sublist + " list on 1st try.");
                System.out.println("Patient " + patientName + " found on " + sublist + " list on 1st try.");
            }
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Given("^I check the following sublists$")
    public void checkSublistCheckboxes(List<String> dataList) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        Thread.sleep(1000);
        for (String checkBoxName : dataList) {
            UtilFunctions.log("CheckBoxName: " + checkBoxName);
            if (Page.setCheckBox(Hooks.getDriver(), GlobalStepdefs.curTabName,
                    "following-sibling::span[text()='" + checkBoxName + "']" + ";xpath",
                    "check", null)) {
                Assert.assertTrue("CheckBox: " + checkBoxName + " didn't set properly.",
                        true);
            } else {
                Assert.assertTrue("CheckBox: " + checkBoxName + " didn't set properly.",
                        Page.setCheckBox(Hooks.getDriver(), GlobalStepdefs.curTabName,
                                "following-sibling::span[text()='" + checkBoxName + "']" + ";xpath",
                                "check", null));
            }
        }
        Thread.sleep(1000);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I reassign the following patients$")
    public void reassignPatients(DataTable dataTable) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        String paneFrames = UtilFunctions.getFrameValue(frameMap, "FRAME_PATIENTLIST_ASSIGNMENT");
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");

        List<Map<String, String>> dataList = dataTable.asMaps(String.class, String.class);
        for (Map row : dataList) {
            String patientName = (String) row.get("Patient Name");
            String sourceList = (String) row.get("Source List");
            String targetList = (String) row.get("Target List");

            String patientXpath = "//div[contains(@class, 'dataTables_wrapper') and " +
                    "preceding-sibling::div[contains(@class, 'sublist-header') and " +
                    "child::div/div[text()='" + sourceList +
                    "']]]//tr[child::td[starts-with(normalize-space(text()),'" + patientName + "')]]";
            String targetListXpath = "//div[contains(@class, 'dataTables_wrapper') and " +
                    "preceding-sibling::div[contains(@class, 'sublist-header') and " +
                    "child::div/div[text()='" + targetList +
                    "']]]//div[starts-with(@class, 'dataTables_scrollBody ui-droppable')]";

            Assert.assertTrue("Failed to drag and drop: " + patientName,
                    Page.dragAndDrop(Hooks.getDriver(), patientXpath, targetListXpath));
            /*if (!Page.dragAndDrop(Hooks.getDriver(), patientXpath, targetListXpath))
                Assert.assertTrue("Failed to drag and drop: " + patientName,
                        Page.javascriptDragAndDrop(Hooks.getDriver(), patientXpath, targetListXpath));*/

            Thread.sleep(3000);
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I reassign all patients from the \"(.*?)\" sublist to the \"(.*?)\" sublist$")
    public void reassignPatients(String sourceList, String targetList) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        String paneFrames = UtilFunctions.getFrameValue(frameMap, "FRAME_PATIENTLIST_ASSIGNMENT");
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");

        SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.TEN, "//div[contains(@class, 'select-all-none') and preceding-sibling::div[contains(@class, 'sublist-header') and child::div/div[text()='" + sourceList + "']]]//span[text()='Select All']" + ";xpath");
        WebElement selectAllButton = SeleniumFunctions.findElement(Hooks.getDriver(), By.xpath("//div[contains(@class, 'select-all-none') and preceding-sibling::div[contains(@class, 'sublist-header') and child::div/div[text()='" + sourceList + "']]]//span[text()='Select All']"));
        selectAllButton.click();

        WebElement patientElement = SeleniumFunctions.findElement(Hooks.getDriver(), By.xpath("//div[contains(@class, 'dataTables_wrapper') and preceding-sibling::div[contains(@class, 'sublist-header') and child::div/div[text()='" + sourceList + "']]]//tr[child::td[starts-with(normalize-space(text()),'')]]"));
        WebElement targetListElement = SeleniumFunctions.findElement(Hooks.getDriver(), By.xpath("//div[contains(@class, 'dataTables_wrapper') and preceding-sibling::div[contains(@class, 'sublist-header') and child::div/div[text()='" + targetList + "']]]//div[starts-with(@class, 'dataTables_scrollBody ui-droppable')]"));

        Page.dragAndDrop(Hooks.getDriver(), patientElement, targetListElement);
        Thread.sleep(3000);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I select the following patients in the \"(.*?)\" sublist$")
    public void selectPatientsInSublist(String list, DataTable dataTable) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        String paneFrames = UtilFunctions.getFrameValue(frameMap, "FRAME_PATIENTLIST_ASSIGNMENT");
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");

        List<String> dataList = dataTable.asList(String.class);

        for (String patientName : dataList) {
            patientName = UtilFunctions.reformName(patientName);
            WebElement elt = SeleniumFunctions.findElement(Hooks.getDriver(), By.xpath("//div[contains(@class, 'dataTables_wrapper') and preceding-sibling::div[contains(@class, 'sublist-header') and child::div/div[text()='" + list + "']]]//td[starts-with(normalize-space(text()),'" + patientName + "')]"));
            elt.click();
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I click the \"(.*?)\" button for the \"(.*?)\" sublist$")
    public void clickButtonInSublist(String button, String subList) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        String paneFrames = UtilFunctions.getFrameValue(frameMap, "FRAME_PATIENTLIST_ASSIGNMENT");
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");

        WebElement elt = SeleniumFunctions.findElement(Hooks.getDriver(), By.xpath("//div[contains(@class, 'select-all-none') and preceding-sibling::div[contains(@class, 'sublist-header') and child::div/div[text()='" + subList + "']]]//span[text()='" + button + "']"));
        elt.click();

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^all rows in the \"(.*?)\" sublist should be \"(Selected|Unselected)\"$")
    public void checkRowsSelectedInSublist(String subList, String desiredState) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        String paneFrames = UtilFunctions.getFrameValue(frameMap, "FRAME_PATIENTLIST_ASSIGNMENT");
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");

        List<WebElement> tableRows = SeleniumFunctions.findElements(Hooks.getDriver(), By.xpath("//div[contains(@class, 'dataTables_wrapper') and preceding-sibling::div[contains(@class, 'sublist-header') and child::div/div[text()='" + subList + "']]]//tbody/tr"));
        boolean success = false;
        if (tableRows != null)
            for (WebElement rowElt : tableRows) {
                String row = rowElt.getAttribute("class");

                System.out.println(row);
                boolean selectedState = row.contains("");

                if (desiredState.equals("Selected") && selectedState) {
                    success = true;
                } else if (desiredState.equals("Unselected") && !selectedState) {
                    success = true;
                } else {
                    success = false;
                }
                if (!success) {
                    break;
                }
            }
        Assert.assertTrue(success);
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @And("^I sort the \"(.*?)\" sublist by \"(Name|Location)\" in \"(Ascending|Descending)\" order$")
    public void sortSublist(String subList, String column, String order) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

//        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
//        String paneFrames = UtilFunctions.getFrameValue(frameMap, "FRAME_PATIENTLIST_ASSIGNMENT");
//        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");
        order = order.toLowerCase();
        if (order.equals("ascending")) {
            order = "asc";
        } else {
            order = "desc";
        }

        WebElement headerParentElement = SeleniumFunctions.findElement(Hooks.getDriver(), By.xpath("//div[contains(@class, 'dataTables_wrapper') and preceding-sibling::div[contains(@class, 'sublist-header') and child::div/div[text()='" + subList + "']]]//thead"));
        WebElement headerElement = SeleniumFunctions.findElement(Hooks.getDriver(), By.xpath("//div[contains(@class, 'dataTables_wrapper') and preceding-sibling::div[contains(@class, 'sublist-header') and child::div/div[text()='" + subList + "']]]//div[text()='" + column + "']"));

        String desiredSortOrderClass = column.toLowerCase() + " name sorting ui-state-default sorting_" + order;

//        int retryCount = 0;

//        while (retryCount < GlobalConstants.TWO) {
//            retryCount++;
//            try {
//                SeleniumFunctions.findElementByWebElement(headerParentElement, SeleniumFunctions.setByValues(".//th[@class='" + desiredSortOrderClass + "']" + ";xpath"));
//            } catch (TimeoutException|ElementNotVisibleException|NoSuchElementException|NullPointerException e) {
//                retryCount = retryCount + 1;
//                headerElement.click();
//                Thread.sleep(1);
//                if (retryCount >= GlobalConstants.TWO) throw e;
//            }
//        }
        WebElement elt = SeleniumFunctions.findElementByWebElement(headerParentElement, SeleniumFunctions.setByValues(".//th[@class='" + desiredSortOrderClass + "']" + ";xpath"));
        if (elt == null) {
            Thread.sleep(2000);
            headerElement.click();
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^the \"(.*?)\" sublist should be sorted by \"(.*?)\" in \"(Ascending|Descending)\" order$")
    public void checkIfSublistIsSorted(String subList, String column, String order) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        column = column.toLowerCase();
        if (column.equals("name")) {
            column = "name sorting_1";
        }

        List<WebElement> tableElements = SeleniumFunctions.findElements(Hooks.getDriver(), By.xpath("//div[contains(@class, 'dataTables_wrapper') and preceding-sibling::div[contains(@class, 'sublist-header') and child::div/div[text()='" + subList + "']]]//tbody//td[@class='" + column + "']"));

        List<String> unsorted = new ArrayList<>();
        if (tableElements != null)
            for (WebElement element : tableElements) {

                String eltText = element.getText();
                unsorted.add(eltText);
            }
        List<String> sorted = new ArrayList(unsorted);

        if (order.equals("Ascending")) {
            Collections.sort(sorted);
        } else {
            Collections.sort(sorted, Collections.reverseOrder());
        }
        boolean success = unsorted.equals(sorted);
        Assert.assertTrue(success);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    //When I search for "VerveDel AssignmentTab Reassign1 Test" from the Assignment List pkdropdown
    @When("^I search for \"(.*?)\" from the Assignment List pkdropdown?$")
    public void selectFromPKDropDown(String listItemName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String dropDownName = "AssignmentList";
        String tabName = GlobalStepdefs.curTabName;
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        String paneFrames = (String) frameMap.get(UtilFunctions.getElementFromJSONFile(fileObj, "PKDROPDOWNS." +
                dropDownName, "frame"));
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");

        String dropdownPath = UtilFunctions.getElementFromJSONFile(fileObj, "PKDROPDOWNS." + dropDownName,
                "path");
        if (dropdownPath == null) {
            UtilFunctions.log(dropDownName + " dropdown has no path set in its JSON element.  Asserting fail.");
            Assert.fail(dropDownName + " dropdown has no path set in its JSON element. The JSON object's path needs to be defined.");
        }
        WebElement dropDownElt = SeleniumFunctions.findElement(Hooks.getDriver(), By.xpath(dropdownPath));
        Assert.assertNotNull(dropDownName + " PK dropdown is NULL and not found.", dropDownElt);

        //click the PK dropdown
        WebElement filterBox = null;
        try {
            dropDownElt.click();
            //dropDownElt.click();//sometimes 1st click not working in ie
            //sometimes 2nd click not working in ie either -- doesn't throw an exception, the click just doesn't happen

            //If the 'Assignment List' PK List dropdown is clicked successfully, the search box should display
            filterBox = SeleniumFunctions.findElement(Hooks.getDriver(),
                    By.xpath("//div[@testid='AssignmentList_MultiSelect_Menu']//input[@type='search']"));
            Thread.sleep(500);
            Assert.assertNotNull("filterBox for Assignment List dropdown is Null and not found.", filterBox);
            if (!filterBox.isDisplayed()) {
                SeleniumFunctions.click(dropDownElt);
                Thread.sleep(500);
                if (!filterBox.isDisplayed()) {
                    Actions actions = new Actions(Hooks.getDriver());
                    actions.moveToElement(dropDownElt).click().build().perform();
                    Thread.sleep(500);
                    if (!filterBox.isDisplayed()) {
                        UtilFunctions.log("'Assignment List' PK List dropdown not clicked.  Asserting fail...");
                        System.out.println("'Assignment List' PK List dropdown not clicked.  Asserting fail...");
                        Assert.fail("'Assignment List' PK List dropdown not clicked.  Asserting fail...");
                    }
                }
            }
        } catch (ElementNotInteractableException e) {
            UtilFunctions.log(e.getMessage());
            e.printStackTrace();
            SeleniumFunctions.click(dropDownElt);
            Thread.sleep(500);

            //If the 'Assignment List' PK List dropdown is clicked successfully, the search box should display
            filterBox = SeleniumFunctions.findElement(Hooks.getDriver(),
                    By.xpath("//div[@testid='AssignmentList_MultiSelect_Menu']//input[@type='search']"));
            Thread.sleep(500);
            Assert.assertNotNull("filterBox for Assignment List dropdown is Null and not found.", filterBox);
            if (!filterBox.isDisplayed()) {
                Actions actions = new Actions(Hooks.getDriver());
                actions.moveToElement(dropDownElt).click().build().perform();
                Thread.sleep(500);
                if (!filterBox.isDisplayed()) {
                    UtilFunctions.log("'Assignment List' PK List dropdown not clicked.  Asserting fail...");
                    System.out.println("'Assignment List' PK List dropdown not clicked.  Asserting fail...");
                    Assert.fail("'Assignment List' PK List dropdown not clicked.  Asserting fail...");
                }
            }
        }
        Thread.sleep(500);
        //type the value in the Filter or Search box
        filterBox.sendKeys(listItemName);

        String dropDownMenuPath = UtilFunctions.getElementFromJSONFile(fileObj, "PKDROPDOWNS." + dropDownName,
                "listPath");
        WebElement menuItem = SeleniumFunctions.findElement(Hooks.getDriver(),
                By.xpath(dropDownMenuPath + "//input[@title='" + listItemName + "']"));//ul[@testid='AssignmentList_MultiSelect_MenuItems']//input[@title='VerveDel AssignmentTab Reassign1 Test']

        Assert.assertNotNull(listItemName + " menuItem is NULL and not found.", menuItem);
        Thread.sleep(1000);

        try {
            menuItem.click();
            Thread.sleep(500);
            if (!dropDownElt.getText().equalsIgnoreCase(listItemName)) {
                WebDriver driver = Hooks.getDriver();
                JavascriptExecutor jsExecutor = (JavascriptExecutor) driver;
                jsExecutor.executeScript("arguments[0].click();", menuItem);
                Thread.sleep(500);
                if (!dropDownElt.getText().equalsIgnoreCase(listItemName)) {
                    Actions actions = new Actions(Hooks.getDriver());
                    actions.moveToElement(menuItem).click().build().perform();
                    Thread.sleep(500);
                }
            }
        } catch (ElementNotInteractableException e) {
            UtilFunctions.log(e.getMessage());
            e.printStackTrace();
            WebDriver driver = Hooks.getDriver();
            JavascriptExecutor jsExecutor = (JavascriptExecutor) driver;
            jsExecutor.executeScript("arguments[0].click();", menuItem);
            Thread.sleep(500);
            if (!dropDownElt.getText().equalsIgnoreCase(listItemName)) {
                Actions actions = new Actions(Hooks.getDriver());
                actions.moveToElement(menuItem).click().build().perform();
                Thread.sleep(500);
            }
        }
        Thread.sleep(500);

        Assert.assertTrue(listItemName + " menuItem not selected from Assignment List dropdown.  Asserting fail.",
                dropDownElt.getText().equalsIgnoreCase(listItemName));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

}//end class


