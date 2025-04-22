package features.step_definitions;

import api.APICommon;
import common.SeleniumFunctions;
import constants.GlobalConstants;
import cucumber.api.DataTable;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import features.Hooks;
import org.apache.commons.lang3.StringUtils;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.junit.Assert;
import org.openqa.selenium.By;
import org.openqa.selenium.*;
import org.openqa.selenium.support.ui.Select;
import support.Page;
import support.db.DBExecutor;
import utils.UtilFunctions;
import utils.UtilProperty;

import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.*;

import static features.Hooks.driver;
import static features.step_definitions.GlobalStepdefs.curTabName;
import static support.Page.*;

/**
 * Created by PatientKeeper on 7/6/2016.
 */

/******************************************************************************
 Class Name: PatientListV2Stepdefs
 Contains step definitions related to PLV2 API's
 ******************************************************************************/

public class PatientListV2Stepdefs {

    public String className = getClass().getSimpleName();
    public static JSONArray permissionAPIJSONArr = null;
    public static Date visitCreationDate;

    @When("^I use the API to create a patient list named \"(.*?)\" owned by \"(.*?)\" with the following parameters$")
    public void createPatientListWithAPI(String name, String userName, DataTable dataTable) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        DBExecutor dbExecutorObj = Page.prepareQuery("PatientListExist");
        dbExecutorObj.addWhere("pl_patientlist.name='" + name + "'");
        dbExecutorObj.addWhere("u_user.user_nm='" + userName + "'");
        List<HashMap> rs = dbExecutorObj.executeQuery();
        UtilFunctions.log("0 if Patient not present and 1 otherwise. Patient Name: " + name + "; Current status: " + rs.size());
        if (rs.size() == 0) {
            APICommon apiCommon = new APICommon("Create", null, null, null, null, userName);

            String listType = null;
            String listAlias = null;
            List<String> sourceLists = new ArrayList<>();
            List<String> subLists = new ArrayList<>();
            List<Map<String, String>> permissionList = new ArrayList<>();

            JSONObject tempObj = apiCommon.getJsonObject();
            Assert.assertNotNull("JSON Object is null", tempObj);
            tempObj.put("name", name);
            apiCommon.setJsonObject(tempObj);

            List<Map<String, String>> dataList = dataTable.asMaps(String.class, String.class);
            for (Map data : dataList) {
                switch ((String) data.get("Type")) {
                    case "Alias":
                        listAlias = (String) data.get("Value");
                        break;
                    case "Description":
                        apiCommon.setDescription((String) data.get("Value"));
                        break;
                    case "Filter":
                        //apiCommon.addFilter((String) data.get("Name"), (String) data.get("Value"));
                        apiCommon.addUpdateFilter((String) data.get("Name"), (String) data.get("Value"), "add");
                        break;
                    case "List Type":
                        listType = (String) data.get("Value");
                        apiCommon.setListType(listType);
                        break;
                    case "Source List":
                        sourceLists.add((String) data.get("Value"));
                        break;
                    case "Assignment List":
                        subLists.add((String) data.get("Value"));
                        break;
                    case "Permission":
                        Map<String, String> map = new HashMap<>();
                        map.put("name", (String) data.get("Name"));
                        map.put("value", (String) data.get("Value"));
                        permissionList.add(map);
                        break;
                    default:
                        //Do something
                        break;
                }
            }
            if (sourceLists.size() > 0) {
                apiCommon.addSourceLists(sourceLists, listType);
            }
            if (subLists.size() > 0) {
                apiCommon.addSubLists(subLists, listType);
            }
            apiCommon.setOwner("Create", userName);
            apiCommon.setPrerequisites("POST", null);
            String response = apiCommon.getResponse(null, apiCommon);
            Assert.assertTrue("API create failed.", api.utils.UtilFunctions.checkResponseSuccess(response));

            //ADD PERMISSIONS
            APICommon permissionAPICommon = new APICommon("Permissions", name, null, null, null, userName);
            for (Map<String, String> map : permissionList) {
                permissionAPICommon.addPermission(map.get("name"), map.get("value"));
            }
            permissionAPICommon.setOwner("Permissions", userName);
            permissionAPICommon.setPrerequisites("POST", null);
            String pResponse = permissionAPICommon.getResponse(null, permissionAPICommon);
            permissionAPIJSONArr = permissionAPICommon.getJsonArr();
            Assert.assertNotNull("Permission JSON Array is null", permissionAPIJSONArr);
            Assert.assertTrue("API Permissions failed.", api.utils.UtilFunctions.checkResponseSuccess(pResponse));

            //ADD FAVORITES
            APICommon favAPICommon = new APICommon("Favorites", name, userName, null, null, userName);
            favAPICommon.setOwner("Favorites", userName);
            if (listAlias != null)
                favAPICommon.setAlias(listAlias);
            favAPICommon.setPrerequisites("POST", null);
            String fResponse = favAPICommon.getResponse(null, favAPICommon);
            Assert.assertTrue("API Favorites failed.", api.utils.UtilFunctions.checkResponseSuccess(fResponse));
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @When("^I use the API to update the permissions for the patient list named \"(.*?)\" owned by \"(.*?)\" with the following")
    public void updatePatientListPermissionWithAPI(String name, String userName, DataTable dataTable) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        APICommon apiModify = new APICommon("Permissions", name, userName, null, null, userName);

//       apiModify.setJsonArr(permissionAPIJSONArr);

        List<Map<String, String>> dataList = dataTable.asMaps(String.class, String.class);
        for (Map data : dataList) {
            switch ((String) data.get("Action")) {
                case "Add":
                    apiModify.addPermission((String) data.get("Name"), (String) data.get("Value"));
                    break;
                case "Remove":
                    apiModify.removePermission((String) data.get("Name"), (String) data.get("Value"));
                    break;
                default:
                    //Do nothing
                    break;
            }
        }
        apiModify.setPrerequisites("POST", null);
        String pResponse = apiModify.getResponse(null, apiModify);
        Assert.assertTrue("API Permissions failed.", api.utils.UtilFunctions.checkResponseSuccess(pResponse));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^the patient list is (minimized|maximized)$")
    public void maxMinPatientList(String status) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        WebElement elt;

        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        String paneFrames = UtilFunctions.getFrameValue(frameMap, "FRAME_LIST");
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");
        if (status.equals("minimized"))
            elt = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//div[@id='SlideLeftControl']" + ";xpath"));
        else
            elt = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("SlideRightControl" + ";id"));

        if (elt != null && elt.isDisplayed()) {
            elt.click();
        } else {
            UtilFunctions.log("Patient list is in the desired state");
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I use the API to (un)?favorite patient list \"(.*?)\"(?: with alias \"(.*?)\")? for user \"(.*?)\" owned by \"(.*?)\"$")
    public void favoriteUnfavoritePatientListWithAPI(String un, String name, String listAlias, String userName, String ownerName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        APICommon favAPICommon = new APICommon("Favorites", name, ownerName, null, null, ownerName);
        favAPICommon.setOwner("Favorites", userName);

        if (un != null && un.equals("un")) {
            favAPICommon.setFavorite("false");
        } else {
            favAPICommon.setFavorite("true");
        }

        if (listAlias != null)
            favAPICommon.setAlias(listAlias);
        favAPICommon.setPrerequisites("POST", null);
        String fResponse = favAPICommon.getResponse(null, favAPICommon);
        Assert.assertTrue("API Favorites failed.", api.utils.UtilFunctions.checkResponseSuccess(fResponse));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^the patient count of the \"(.*?)\" should be equal to \"(.*?)\"$")
    public void checkPatientCount(String assignmentList, String subList) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        String paneFrames = UtilFunctions.getFrameValue(frameMap, "FRAME_PATIENTLIST_ASSIGNMENT");
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");
        String t1, t2, t3, t4;
        boolean compareText;

        String countText = SeleniumFunctions.findElement(Hooks.getDriver(), By.xpath("//span[@class='count' and ancestor::div[@class='count-wrapper']]")).getText();

        t1 = SeleniumFunctions.findElement(Hooks.getDriver(), By.xpath("//span[@class='count' and ancestor::div[@class='sublist-header-right' and preceding-sibling::div[@class='sublist-name-header' and child::div[text()='" + assignmentList + "']]]]")).getText();
        t2 = SeleniumFunctions.findElement(Hooks.getDriver(), By.xpath("//span[@class='count' and ancestor::div[@class='sublist-header-right' and preceding-sibling::div[@class='sublist-name-header' and child::div[text()='" + subList + "']]]]")).getText();
        t3 = SeleniumFunctions.findElement(Hooks.getDriver(), By.xpath("//span[@class='count' and preceding::div[text()='" + assignmentList + "']]")).getText();
        t4 = SeleniumFunctions.findElement(Hooks.getDriver(), By.xpath("//span[@class='count' and preceding::div[text()='" + subList + "']]")).getText();

        List<String> eltText = new ArrayList<>();
        eltText.add(t1);
        eltText.add(t2);
        eltText.add(t3);
        eltText.add(t4);

        for (String text : eltText) {
            compareText = countText.equals(text);
            Assert.assertTrue(compareText);
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^for the following options, following should be visible$")
    public void checkOptionsVisible(DataTable rows) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        Thread.sleep(1000);
        List<Map<String, String>> dataList = rows.asMaps(String.class, String.class);
        for (Map data : dataList) {
            String section = ((String) data.get("Section")).replace(" ", "");
            String name = ((String) data.get("Name")).replace(" ", "");
            String image = ((String) data.get("Image")).replace(" ", "");

            JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
            HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
            String paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "MISC_ELEMENTS." + section, "frame"));
            SeleniumFunctions.selectFrame(driver, paneFrame, "id");
            String sectionPath = UtilFunctions.getElementFromJSONFile(fileObj, "MISC_ELEMENTS." + section, "path");
            sectionPath = sectionPath.replace("Name", name);


            paneFrame = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "MISC_ELEMENTS." + image, "frame"));
            SeleniumFunctions.selectFrame(driver, paneFrame, "id");
            String imagePath = UtilFunctions.getElementFromJSONFile(fileObj, "MISC_ELEMENTS." + image, "path");
            WebElement found = SeleniumFunctions.findElement(Hooks.getDriver(), By.xpath(sectionPath + imagePath));
            Assert.assertNotNull("Elements '"+name+"' and '"+image+"' not visible", found);
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");


    }

    @And("^I (un)?favorite the patient list \"(.*?)\" from patient list search table$")
    public void favoritePatientListFromSearchTable(String condition, String patientList) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String[] tableDetailArr = UtilFunctions.getTableValues(curTabName, "PatientListSearchResults");
        String tablePath = tableDetailArr[0];
        String tableHead = tableDetailArr[2];
        String tableBody = tableDetailArr[3];
        String paneFrames = tableDetailArr[4];
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");
        SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.TWENTY, tablePath + ";xpath");
        WebElement tableElement = findTable(Hooks.getDriver(), tablePath);
        WebElement tableHeaderObj = findTableHead(tableElement, tableHead);
        if (tableHeaderObj == null)
            Assert.assertNotNull("Table Header: " + tableHead + " is not present", null);
        else {
            List<WebElement> headersObjects = SeleniumFunctions.findElementsByWebElement(tableHeaderObj, SeleniumFunctions.setByValues(tableHead + "/tr" + ";xpath"));
            if (headersObjects == null)
                Assert.assertNotNull("Table Header: " + tableHead + " is not present", null);
            else {
                WebElement rowHeaderObj;
                if (headersObjects.size() == 1)
                    rowHeaderObj = headersObjects.get(0);
                else
                    rowHeaderObj = headersObjects.get(headersObjects.size() - 1);
                List<WebElement> mainHeadersObjects = SeleniumFunctions.findElementsByWebElement(rowHeaderObj, SeleniumFunctions.setByValues("descendant::th" + ";xpath"));
                int headerLoc = 0;
                for (WebElement headerObj : mainHeadersObjects) {
                    headerLoc++;
                    if (headerObj.getText().contains("Name")) {
                        List<WebElement> tableBodyObj = SeleniumFunctions.findElementsByWebElement(tableElement, SeleniumFunctions.setByValues(tableBody + "/tr" + ";xpath"));
                        for (WebElement tableRowObj : tableBodyObj) {
                            WebElement tableCellObj = SeleniumFunctions.findElementByWebElement(tableRowObj, SeleniumFunctions.setByValues("descendant::td[" + headerLoc + "];xpath"));
                            UtilFunctions.log("row item displayed text: " + tableCellObj.getText());
                            if (tableCellObj.getText().trim().toLowerCase().equals(patientList.toLowerCase())) {
                                WebElement favObj = SeleniumFunctions.findElementByWebElement(tableRowObj, SeleniumFunctions.setByValues("//img[@class='favorite-img' and ancestor::td[" + headerLoc + "]];xpath"));
                                if (favObj !=null){
                                    if (((favObj.getAttribute("isfavorite").equals("Y")) && (condition != null)) || ((favObj.getAttribute("isfavorite").equals("N")) && (condition == null))) {
                                        try{
                                            favObj.click();
                                        }catch (Exception e) {
                                            Assert.assertTrue("Favorite icon of the patient list " + patientList + " is not clicked due to exception: " + e.getMessage(), false);
                                        }
                                        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
                                        globalStepdefs.clickButton("EditFavoriteSave",null,"if it exists");
                                        //regetting favorite object as attributes will refresh after click.
                                        favObj = SeleniumFunctions.findElementByWebElement(tableRowObj, SeleniumFunctions.setByValues("//img[@class='favorite-img' and ancestor::td[" + headerLoc + "]];xpath"));
                                        if (condition == null)
                                            Assert.assertTrue("Favoriting the patient list " + patientList + " is unsuccessful", (favObj.getAttribute("isfavorite").equals("Y")));
                                        else
                                            Assert.assertTrue("UnFavoriting the patient list " + patientList + " is unsuccessful", (favObj.getAttribute("isfavorite").equals("N")));
                                    }
                                }else
                                    Assert.assertNotNull("Favorite icon for patient list "+patientList+" is not found",null);
                                break;
                            }
                        }
                        break;
                    }
                }
            }
        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I set the Patient List display options$")
    public void setPatientListDisplayOptions() throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        GlobalStepdefs globalStepObj = new GlobalStepdefs();
        if (Page.findPane(Hooks.getDriver(), GlobalStepdefs.curTabName, "DisplayOptionsExist", GlobalConstants.TWO) != null) {

            ArrayList<String> checkBoxes = new ArrayList<>();
            checkBoxes.add("Allergies");
            checkBoxes.add("Clinical Notes");
            checkBoxes.add("Medications");
            checkBoxes.add("Orders");
            checkBoxes.add("Problems");
            checkBoxes.add("Test Results");

            globalStepObj.checkMultipleCheckBoxes("check", null, checkBoxes);
            globalStepObj.clickButton("OptionsOK", null, null);
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I set the Base Condition to Favorite the \"(.*?)\" list for \"(.*?)\" \"(.*?)\"$")
    public void setBaseConditionToFavorite(String listName, String userName, String nameType) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String type = null;
        GlobalStepdefs globalStepObj = new GlobalStepdefs();
        switch (nameType) {
            case "name":
                type = "Last Name";
                break;
            case "department":
                type = "Departments";
                break;
            case "facility":
                type = "Facilities";
                break;
            case "user":
                type = "Username";
                break;
        }

        globalStepObj.clickButtonInTableRow("Favorited", listName, "NAME (\\d)", "Patient List Search Results");
        SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.FIFTEEN, "//div[@class='edit-favorite-view']" + ";xpath");
        favoriteOrUnfavoriteList(null, "Favorite In Edit Screen", "Edit Favorite");
        globalStepObj.checkCheckBox(null, "Me", null, null);
        globalStepObj.checkCheckBox(null, "OtherUsers", null, null);
        globalStepObj.enterInTheField(userName, "Users", null);
//        if(checkTableExists(driver,GlobalStepdefs.curTabName,"Users Search")){
//            globalStepObj.selectValueFromTheColumnInTable(userName, type, "Users Search", "");
//        }
        globalStepObj.clickButton("Edit Favorite Save", null, null);
        globalStepObj.clickButtonInTableRow("Favorite", listName, "NAME (\\d)", "Patient List Search Results");
        SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.FIFTEEN, "//div[@class='edit-favorite-view']" + ";xpath");
        favoriteOrUnfavoriteList("un", "Favorited In Edit Screen", "Edit Favorite");
        globalStepObj.checkCheckBox("uncheck", "Me", null, null);
        globalStepObj.checkCheckBox(null, "OtherUsers", null, null);
        globalStepObj.enterInTheField(userName, "Users", null);
//        globalStepObj.selectValueFromTheColumnInTable(userName, type, "Users Search", "");
        globalStepObj.clickButton("Edit Favorite Save", null, null);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I (un)?favorite the list by clicking the \"(.*?)\" button in the \"(.*?)\" pane$")
    public void favoriteOrUnfavoriteList(String un, String buttonName, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.FIFTEEN, "//div[@class='edit-favorite-view']" + ";xpath");
        paneName = paneName.replace(" ", "");
        String check;
        if (StringUtils.isEmpty(un)) {
            check = "Y";
        } else {
            check = "N";
        }
        String button;
        WebElement buttonElt;
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        String paneFrames = (String) frameMap.get(UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
        ;
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");

        buttonName = buttonName.replace(" ", "");
        if (UtilFunctions.getElementFromJSONFile(fileObj, "BUTTONS." + buttonName, "id") == null) {
            button = UtilFunctions.getElementFromJSONFile(fileObj, "BUTTONS." + buttonName, "path");
            buttonElt = SeleniumFunctions.findElement(Hooks.getDriver(), By.xpath(button));
        } else {
            button = UtilFunctions.getElementFromJSONFile(fileObj, "BUTTONS." + buttonName, "id");
            buttonElt = SeleniumFunctions.findElement(Hooks.getDriver(), By.id(button));
        }

        String favorite = buttonElt.getAttribute("isfavorite");
        if (favorite == null) {
            button = UtilFunctions.getElementFromJSONFile(fileObj, "BUTTONS." + buttonName, "image");
            buttonElt = SeleniumFunctions.findElement(Hooks.getDriver(), By.xpath(button));
            favorite = buttonElt.getAttribute("isfavorite");
        }

        if (!favorite.equals(check)) {
            buttonElt.click();
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^the text \"(.*?)\" for PLv2 user (NoteWriter|ChargeCapture|CPOE) should be(?: selected by default)?(?: visible)? in the \"(.*?)\" pane$")
    public void checkDefaultVisitInPane(String text, String type, String paneName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        paneName = paneName.replace(" ", "");
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
        String panePath = UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "path");
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        String paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName, "frame"));
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");
        SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, panePath + ";" + "xpath");
        WebElement dropDownObj = null;
        WebElement divVisitObj = null;
        switch (type) {
            case "NoteWriter":
                SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, "//select[@id= 'visits']" + ";xpath");
                dropDownObj = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//select[@id= 'visits']"));
                break;
            case "ChargeCapture":
                SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, "//select[@class= 'visitSelection']" + ";xpath");
                dropDownObj = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//select[@class= 'visitSelection']"));
                if (dropDownObj == null) {
                    SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, "//div[@id='status_info_area']" + ";xpath");
                    divVisitObj = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//div[@id='status_info_area']"));
                }
                break;
            case "CPOE":
                SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, "//select[@id= 'visits']" + ";xpath");
                dropDownObj = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues("//select[@id= 'visits']"));
                break;
        }
        text = UtilFunctions.convertDateThruRegExWithRefDate(text, visitCreationDate);

        if (dropDownObj == null && divVisitObj != null)
            Assert.assertTrue("Visit " + text + " is not selected by default in " + type + " pane", divVisitObj.getText().contains(text));
        if (dropDownObj != null && divVisitObj == null){
            Select visit = new Select(dropDownObj);
            Assert.assertTrue("Visit " + text + " is not selected by default in " + type + " pane", visit.getFirstSelectedOption().getText().contains(text));
        }else
            Assert.assertTrue("Visit dropdown is not found in the " + type + " pane", false);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");

    }

    @When("^I use the API to update the display view for the patient list named \"(.*?)\" owned by \"(.*?)\" with the following$")
    public void updateDisplayViewWithAPI(String name, String userName, DataTable dataTable) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        APICommon displayViewModify = new APICommon("DisplayView", name, userName, null, null, userName);
        displayViewModify.setPrerequisites("GET", null);
        String fResponse = displayViewModify.getResponse("patientList", displayViewModify);

        JSONParser parser = new JSONParser();
        JSONObject json = (JSONObject) parser.parse(fResponse);
        String a = ((JSONArray)((JSONObject)((JSONObject)json.get("response")).get("patientList")).get("displayPositions")).toJSONString();

//        displayViewModify.setJsonObject((JSONObject)((JSONObject)json.get("response")).get("patientList"));
        displayViewModify.setJsonObject(((JSONObject)((JSONObject)json.get("response")).get("patientList")));

        String r = (((JSONObject)json.get("response")).get("patientList")).toString();

        System.out.println(r);

        System.out.println(a);
        int countRow = 0;
        int countColumn = 0;

        String dispElt = null;
        Object dispField;
        List<List<String>> dataList = dataTable.raw();
        for(List<String> row : dataList) {
            for (String col : row) {
                String[] displayArray = col.split(",");
                int textOrder = -1;
                for (String element : displayArray) {
                    if (element.equals("")) {
                        dispElt = "BlankDisplayPosition";
                        textOrder = 0;
                        dispField = "BLANK";
                        element = null;
                    } else {
                        dispElt = "DisplayPosition";
                        dispField = displayViewModify.getPositionValue(element.trim());

                    }
                    for (int index = 0; index < ((JSONArray) ((JSONObject) ((JSONObject) json.get("response")).get("patientList")).get("displayPositions")).size(); index++) {
                        JSONObject tempJSONObj = (JSONObject) ((JSONArray) ((JSONObject) ((JSONObject) json.get("response")).get("patientList")).get("displayPositions")).get(index);
                        String t = tempJSONObj.get("displayField").toString();
                        System.out.println(t);
                        Object chkDispName = tempJSONObj.get("displayField").toString();
                        String rowPosObj = tempJSONObj.get("rowPosition").toString();
                        int colSpan = Integer.valueOf(tempJSONObj.get("columnSpan").toString());
                        int rowPos = Integer.valueOf(rowPosObj);

                        if(dispField.equals(chkDispName)) {
                            if(dispField.equals("BLANK") && rowPos != countRow){
                                break;
                            }
                            tempJSONObj.put("type", dispElt);

                            tempJSONObj.put("columnSpan", colSpan);

                            if(!dispField.equals("BLANK"))
                                textOrder += 1;

                            tempJSONObj.put("textOrder", textOrder);

                            tempJSONObj.put("columnPosition", countColumn);

                            if(element!=null){
                                t = tempJSONObj.get("label").toString();
                                System.out.println(t);

                                tempJSONObj.put("label", element.trim());
                            }

                            tempJSONObj.put("displayField", dispField);

                            tempJSONObj.put("rowPosition", countRow);
                            break;
                        }
                    }
                }
                countColumn = +1;
            }
            countRow += 1;
            countColumn = 0;
            System.out.println(fResponse);

        }

        //This returns the updated the JSON string
//        String b = ((JSONArray)((JSONObject)((JSONObject)json.get("response")).get("patientList")).get("displayPositions")).toJSONString();

//        System.out.println(b);

        Object patientListID = displayViewModify.getPatientListId(name, String.valueOf(displayViewModify.getPersonnelIdByUsername(userName)), null);
        displayViewModify.getJsonObject().put("patientListId", patientListID);
        displayViewModify.setUrlName(UtilProperty.apiURL + "mcp/pl/api/v2/" + "patient-lists/" + patientListID);
        JSONArray jsonArr = new JSONArray();

        jsonArr.add((((JSONObject)((JSONObject)json.get("response")).get("patientList")).get("displayPositions")));

        displayViewModify.getJsonObject().put("displayPositions", jsonArr);

        //Changed the requestType from PUT to POST, using the PUT method is throwing error "The request sent by the client was syntactically incorrect."
        displayViewModify.setPrerequisites("POST", null);
        fResponse = displayViewModify.getResponse(null, displayViewModify);
        Assert.assertTrue("API Display view update failed.", api.utils.UtilFunctions.checkResponseSuccess(fResponse));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I use the API to update the time criteria for the patient list named \"(.*?)\" owned by \"(.*?)\" with the following$")
    public void updateTimeCriteriaWithAPI(String name, String userName, DataTable dataTable) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        APICommon timeCriteriaModify = new APICommon("TimeCriteria", name, userName, null, null, userName);
        timeCriteriaModify.setPrerequisites("GET", null);
        String fResponse = timeCriteriaModify.getResponse("patientList", timeCriteriaModify);

        JSONParser parser = new JSONParser();
        JSONObject json = (JSONObject) parser.parse(fResponse);
//        String a = ((JSONArray)((JSONObject)((JSONObject)json.get("response")).get("patientList")).get("timeBasedCriteria")).toJSONString();

        timeCriteriaModify.setJsonObject(((JSONObject)((JSONObject)json.get("response")).get("patientList")));

//        JSONObject tempJSONObj = (JSONObject) ((JSONArray) ((JSONObject) ((JSONObject) json.get("response")).get("patientList")).get("displayPositions")).get(index);
        JSONObject tempJSONObj = new JSONObject();
        JSONArray arr = new JSONArray();
        JSONArray ar = new JSONArray();

        List<Map<String, String>> dataList = dataTable.asMaps(String.class, String.class);
        for (Map data : dataList) {
            String[] nameArr = ((String) data.get("Name")).split(" ");
            String cName = nameArr[0];
            switch ((String) data.get("Action")) {
                case "Add": case "Update":
                    JSONObject tempObject1 = new JSONObject();
                    tempObject1.put("name", cName);
                    tempObject1.put("addEvent", data.get("Add Patients"));
                    tempObject1.put("removeEvent", data.get("Remove Patients"));
                    tempObject1.put("infacility", timeCriteriaModify.getInfacility(cName));
                    tempObject1.put("code", timeCriteriaModify.getTimeCriterionValue(cName));
                    tempJSONObj.put("daysAfterRemoveEvent", timeCriteriaModify.getEventDaysCount(null, (String) data.get("Remove Patients")));
                    tempJSONObj.put("daysBeforeAddEvent", timeCriteriaModify.getEventDaysCount((String) data.get("Add Patients"), null));

                    if (data.get("Remove Patients") != null && ((String) data.get("Remove Patients")).contains("Immediately"))
                        tempJSONObj.put("removeNow", true);
                    else
                        tempJSONObj.put("removeNow", false);

                    tempJSONObj.put("pkVisitType", tempObject1);
                    ((JSONArray)timeCriteriaModify.getJsonObject().get("timeBasedCriteria")).add(tempJSONObj);
                    break;
                case "Remove":
                    int index;
                    for ( index = 0; index < ((JSONArray) ((JSONObject) ((JSONObject) json.get("response")).get("patientList")).get("timeBasedCriteria")).size(); index++) {
                        tempJSONObj = (JSONObject) ((JSONArray) ((JSONObject) ((JSONObject) json.get("response")).get("patientList")).get("timeBasedCriteria")).get(index);
                        ar.add(tempJSONObj);
                        int s = ar.size();
                        System.out.println(s);
                        String timeCrit = ((JSONObject) tempJSONObj.get("pkVisitType")).get("name").toString();
                        if(timeCrit.equals(cName)){
                            ar.remove(index);
                        }
                    }
                    timeCriteriaModify.getJsonObject().put("timeBasedCriteria", ar);
                    break;
                default:
                    //Do nothing
                    break;
            }
        }

        timeCriteriaModify.setPrerequisites("POST", null);
        String pResponse = timeCriteriaModify.getResponse(null, timeCriteriaModify);
        Assert.assertTrue("API Time Based Criteria failed.", api.utils.UtilFunctions.checkResponseSuccess(pResponse));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I use the API to update the filters for the patient list named \"(.*?)\" owned by \"(.*?)\" with the following$")
    public void updateFilterCriteriaWithAPI(String name, String userName, DataTable dataTable) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        APICommon filtersModify = new APICommon("Filters", name, userName, null, null, userName);
        filtersModify.setPrerequisites("GET", null);
        String fResponse = filtersModify.getResponse("patientList", filtersModify);

        JSONParser parser = new JSONParser();
        JSONObject json = (JSONObject) parser.parse(fResponse);
//        String a = ((JSONArray)((JSONObject)((JSONObject)json.get("response")).get("patientList")).get("timeBasedCriteria")).toJSONString();
        filtersModify.setJsonObject(((JSONObject)((JSONObject)json.get("response")).get("patientList")));

        List<Map<String, String>> dataList = dataTable.asMaps(String.class, String.class);
        for (Map data : dataList) {
            switch ((String) data.get("Action")) {
                case "Add":
                    filtersModify.addUpdateFilter((String) data.get("Name"), (String) data.get("Value"), "add");
                    break;
                case "Remove":
                    filtersModify.addUpdateFilter((String) data.get("Name"), (String) data.get("Value"), "remove");
                    break;
                default:
                    //Do nothing
                    break;
            }
        }

        Object patientListID = filtersModify.getPatientListId(name, String.valueOf(filtersModify.getPersonnelIdByUsername(userName)), null);
        filtersModify.getJsonObject().put("patientListId", patientListID);
        filtersModify.setUrlName(UtilProperty.apiURL + "mcp/pl/api/v2/" + "patient-lists/" + patientListID);

        filtersModify.setPrerequisites("POST", null);
        String pResponse = filtersModify.getResponse(null, filtersModify);
        Assert.assertTrue("API Filter Based Criteria failed.", api.utils.UtilFunctions.checkResponseSuccess(pResponse));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    //      Check multiple checkboxes under dropdown
    @Then("I (verify the availability of|check|uncheck) the following checkbox(?:es)? in the \"(.*?)\" dropdown")
    public void verifyCheckboxInDropdown(String validationType, String dropdownName, DataTable dataTable) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        dropdownName = dropdownName.replace(" ", "");
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        String dropdownFrame = UtilFunctions.getElementFromJSONFile(fileObj, "PKDROPDOWNS." + dropdownName, "frame");
        String dropdownFrames = UtilFunctions.getFrameValue(frameMap, dropdownFrame);
        SeleniumFunctions.selectFrame(driver, dropdownFrames, "id");

        String[] elementType = UtilFunctions.getElementStringAndType(fileObj, "PKDROPDOWNS." + dropdownName);
        String fieldPath = elementType[0];
        String fieldMethod = elementType[1];
        SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, fieldPath + ";" + fieldMethod);
        WebElement dropDownButtonObj= SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(fieldPath + ";" + fieldMethod));
        if (dropDownButtonObj == null)
            Assert.assertNotNull("'" + dropdownName + "' dropDown is not found", null);
        else{
            dropDownButtonObj.click();
            String dropDownListPath = UtilFunctions.getElementFromJSONFile(fileObj, "PKDROPDOWNS." + dropdownName, "listPath");
            SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, dropDownListPath + ";xpath");
            WebElement dropDownListObj= SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(dropDownListPath + ";xpath"));

            List<String> dataList = dataTable.asList(String.class);
            for (String checkbox : dataList) {
                WebElement checkobj = SeleniumFunctions.findElementByWebElement(dropDownListObj,
                        SeleniumFunctions.setByValues("//input[(@type='checkbox' or @type='Checkbox') and " +
                        "ancestor::div[text()='" + checkbox + "']]"));
                if (checkobj != null) {
                    if ((validationType.equals("check") && !checkobj.isSelected()) ||
                            (validationType.equals("uncheck") && checkobj.isSelected())) {
                        try {
                            checkobj.click();
                            Thread.sleep(2000);
                        } catch (WebDriverException e) {
                            Assert.assertFalse("Checkbox " + checkbox + " is not clicked due to exception: " + e.getMessage(), true);
                        }
                    }
                    if (validationType.equals("check"))
                        Assert.assertTrue("Checkbox " + checkbox + " is not checked", checkobj.isSelected());
                    else if (validationType.equals("uncheck"))
                        Assert.assertTrue("Checkbox " + checkbox + " is not unchecked", !checkobj.isSelected());
                    else
                        Assert.assertTrue("Checkbox " + checkbox + " is not displayed", checkobj.isDisplayed());
                } else {
                    Assert.assertNotNull("'" + checkbox + "' checkbox not found", checkobj);
                }
            }
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }
    @And("^I favorite the list by clicking the \"(.*?)\" button in the row with \"(.*?)\" as the value under \"(.*?)\" in the \"(.*?)\" table$")
    public boolean clickFavoriteButton(String buttonName, String srcValue, String srcHeader, String tableName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        buttonName = buttonName.replace(" ", "");
        UtilFunctions.log("Button to be clicked: " + buttonName);
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        String paneFrames;
        if (!GlobalStepdefs.curTabName.equals("")) {
            //Check condition for ._Frame map selection
        }
        tableName = tableName.replace(" ", "");
        String[] tableDetailArr = UtilFunctions.getTableValues(curTabName, tableName);
        String tablePath = tableDetailArr[0];
        String tableId = tableDetailArr[1];
        String tableHead = tableDetailArr[2];
        String tableBody = tableDetailArr[3];
        paneFrames = tableDetailArr[4];

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

        int tempCount = 0;
        for (WebElement rowObj : tableRowObj) {
            String[] elementType = UtilFunctions.getElementStringAndType(fileObj, "MISC_ELEMENTS." + buttonName);
            String buttonPath = elementType[0];
            String buttonMethod = elementType[1];

            paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "MISC_ELEMENTS." + buttonName, "frame"));
            SeleniumFunctions.selectFrame(driver, paneFrames, "id");
            SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, buttonPath + ";" + buttonMethod);
            WebElement btnObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(buttonPath + ";" + buttonMethod));


            List<WebElement> selectName = SeleniumFunctions.findElementsByWebElement(rowObj, SeleniumFunctions.setByValues("td;tagName"));
            for (int s = 0; s < selectName.size(); s++) {

                String actualText = selectName.get(s).getText();
                actualText = actualText.trim().replaceAll("\\s+", " ");
                if (actualText.equals(srcValue)) {

                    if (btnObj == null) {
                        return false;
                    } else {
                        if (btnObj.getAttribute("isfavorite").equals("Y"))
                            btnObj.click();
                    }

                }
            }
            tempCount++;
        }
        UtilFunctions.log(srcValue + "is not presrnt in" + tableName);
        return false;

    }

    @And("^I save the visits creation date \"(.*?)\" for later$")
    public void storeVisitCreationDate(Date date) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

            SimpleDateFormat dateConvertor = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
            visitCreationDate = dateConvertor.parse(dateConvertor.format(date));
            UtilFunctions.log("Visit Creation Date: "+visitCreationDate);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^I select the order \"(.*?)\" from the 'Favorites' list under 'Add Order'$")
    public void selectOrderFromFavorites(String orderName) throws Throwable{

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        WebElement orderElement;
        String paneFrames;
        String favoriteOrder = String.format("//div[@class='hpickerChildContainer']/div[@title='%s']", orderName);

        paneFrames = UtilFunctions.getFrameValue(UtilFunctions.getFrameMapBasedOnTabName("PatientListV2"), "FRAME_EDITORDER");
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");

        SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.FIVE, favoriteOrder);
        orderElement = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues(favoriteOrder + ";xpath"));

        Assert.assertNotNull(String.format("The %s order was not found on the favorites list\n", orderName), orderElement);

        orderElement.click();

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }
}