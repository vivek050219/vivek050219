package features.step_definitions;

import common.SeleniumFunctions;
import cucumber.api.DataTable;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import features.Hooks;
import org.json.simple.JSONObject;
import org.junit.Assert;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import pageObject.PatientListPage;
import support.Page;
import utils.UtilFunctions;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

/**
 * Created by PatientKeeper on 7/5/2016.
 */

/******************************************************************************
 Class Name: PatientListDisplayStepdefs
 Contains step definitions related to patient list display
 ******************************************************************************/

public class PatientListDisplayStepdefs {

    public String className = getClass().getSimpleName();

    @Given("^I refresh the patient list$")
    public void refreshPatientList() throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        Assert.assertTrue("Page Not Refreshed.", PatientListPage.refreshPatientList(Hooks.getDriver()));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

//    @Then("^patients should be custom sorted( starting)? by following( specific)? locations$")
//    public void checkCustomLocationSort(String startingBy, String specific, DataTable dataTable) throws Throwable {
//        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
//        }.getClass().getEnclosingMethod().getName() + " : Start");
//
//        String tableType = "PatientListCreateView";
//        String field = "Location";
//
//        String prevLocation = "";
//        List<String> listLocationOrder = new ArrayList<>();
//        List<String> CustomLocSortList = new ArrayList<>();
//
//        int rowCount = PatientListPage.getNumPatients(tableType);
//        String order = "Ascending";
//
//        int multiplier = Page.countTableRows(Hooks.getDriver(), GlobalStepdefs.curTabName, tableType,null,null) / rowCount;
//
//        List<String> locations = dataTable.asList(String.class);
//        if(specific!=null){
//            for(String loc : locations){
////                String location = loc.split(".",2) + "."+ loc.lastIndexOf(".");
//                String[] locationArray = loc.split("\\.");
//
//                String location = locationArray[0];
//                CustomLocSortList.add(location);
//            }
//            int count = 0;
//            int index = 0;
//            while (count<CustomLocSortList.size()){
//                String currentLocation = null;
//                index += 1;
//                List<WebElement> current = Page.findPatientRowByIndex(index, tableType, multiplier);
//
//                for (WebElement row : current){
//                    try{
//                        if (!row.getAttribute("class").equals("selectable discharged") &&
//                                !row.getAttribute("class").equals("selectable odd discharged")) {
//                            JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
//                            String fieldElt = UtilFunctions.getElementFromJSONFile(fileObj, "MISC_ELEMENTS." + field, "path");
//                            String currentVal = SeleniumFunctions.findElementByWebElement(row, By.xpath(".//" + fieldElt)).getText();
//
//                            String[] currentLocationArray = currentVal.split("\\.");
//                            //currentLocation = currentLocationArray[1];
//                            currentLocation = currentLocationArray[currentLocationArray.length - 1];
//
//                            if (!prevLocation.equals(currentLocation)) {
//                                listLocationOrder.add(currentLocation);
//                                count += 1;
//                                prevLocation = currentLocation;
//                            }
//                        }
//                    }
//                    catch (Exception e){
//                        //Do nothing
//                    }
//                }
//            }
//        }
//        else {
//            for(String loc : locations){
//                CustomLocSortList.add(loc);
//            }
//            for(int i = 0; i <= rowCount-1; i++){
//                List<WebElement> current = null;
//                current = Page.findPatientRowByIndex(i, tableType, multiplier);
//                for (WebElement row : current){
//                    try{
//                        if (!row.getAttribute("class").equals("selectable discharged") &&
//                                !row.getAttribute("class").equals("selectable odd discharged")) {
//                            String txt = row.getText();
//
//                            System.out.println(txt);
//
//                            JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
//                            String fieldElt = UtilFunctions.getElementFromJSONFile(fileObj, "MISC_ELEMENTS." + field, "path");
//                            String currentVal = SeleniumFunctions.findElementByWebElement(row, By.xpath(".//" + fieldElt)).getText();
//
//                            String txt1 = row.getText();
//
//                            System.out.println(currentVal);
//
//                            int currentLocationIndex = currentVal.lastIndexOf(".");
//                            String currentLocation = currentVal.substring(currentLocationIndex + 1);
//
//                            if (!prevLocation.equals(currentLocation)) {
//                                listLocationOrder.add(String.valueOf(currentLocation));
//                                prevLocation = currentLocation;
//                            }
//                        }
//                    }
//                    catch (Exception e){
//                        //Do nothing
//                    }
//                }
//            }
//        }
//        if(order.equals("Ascending")){
//            if (startingBy == null)
//                Assert.assertTrue(listLocationOrder.equals(CustomLocSortList));
//            else{
//                for (int i = 0; i < CustomLocSortList.size(); i++){
//                    Assert.assertEquals("List Value does not matches. Expected Value at location: " + i + ", is: " + CustomLocSortList.get(i),
//                            CustomLocSortList.get(i),
//                            listLocationOrder.get(0));
//                    listLocationOrder.remove(0);
//                    if (listLocationOrder.contains(CustomLocSortList.get(i))){
//                        Assert.assertTrue("List Value: " + CustomLocSortList.get(i) + " is still present in listLocationOrder.", false);
//                    }
//                }
//            }
//        }
//
//    }


    @Then("^patients should be custom sorted( starting)? by following( specific)? locations$")
    public void checkCustomLocationSort(String startingBy, String specific, DataTable dataTable) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String tableType = "PatientListCreateView";
        String field = "Location";

        String prevLocation = "";
        List<String> listLocationOrder = new ArrayList<>();
        List<String> CustomLocSortList = new ArrayList<>();

        int rowCount = PatientListPage.getNumPatients(tableType);
        String order = "Ascending";
        int multiplier = 0;
        if(rowCount == 0){
            Assert.assertTrue("The number of patients should be greater than 0.", rowCount > 0);
        }else{
            multiplier = Page.countTableRows(Hooks.getDriver(), GlobalStepdefs.curTabName, tableType, null, null) / rowCount;
        }

        List<String> locations = dataTable.asList(String.class);
        if (specific != null) {
            for (String loc : locations) {
//                String location = loc.split(".",2) + "."+ loc.lastIndexOf(".");
//                String[] locationArray = loc.split("\\.");
//
//                String location = locationArray[0];
                CustomLocSortList.add(loc);
            }
            int count = 0;
            int index = 0;
            while (count < CustomLocSortList.size()) {
                String currentLocation = null;
                index += 1;
                List<WebElement> current = Page.findPatientRowByIndex(index, tableType, multiplier);

                for (WebElement row : current) {
                    try {
                        if (!row.getAttribute("class").equals("selectable discharged") &&
                                !row.getAttribute("class").equals("selectable odd discharged")) {
                            JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
                            String fieldElt = UtilFunctions.getElementFromJSONFile(fileObj, "MISC_ELEMENTS." + field, "path");
                            String currentVal = SeleniumFunctions.findElementByWebElement(row, By.xpath(".//" + fieldElt)).getText();

                            String[] currentLocationArray = currentVal.split("\\.");
                            //currentLocation = currentLocationArray[1];
                            //currentLocation = currentLocationArray[currentLocationArray.length - 1];

                            currentLocation = currentLocationArray[currentLocationArray.length - 1] + "." + currentLocationArray[0];
                            if (locations.contains(currentLocation)) {

                                if (!prevLocation.equals(currentLocation)) {
                                    listLocationOrder.add(currentLocation);
                                    count += 1;
                                    prevLocation = currentLocation;
                                }
                            } else
                                count++;
                        }
                    } catch (Exception e) {
                        //Do nothing
                    }
                }
            }
        } else {
            for (String loc : locations) {
                CustomLocSortList.add(loc);
            }
            for (int i = 0; i <= rowCount - 1; i++) {
                List<WebElement> current = null;
                current = Page.findPatientRowByIndex(i, tableType, multiplier);
                for (WebElement row : current) {
                    try {
                        if (!row.getAttribute("class").equals("selectable discharged") &&
                                !row.getAttribute("class").equals("selectable odd discharged")) {
                            String txt = row.getText();

                            System.out.println(txt);

                            JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
                            String fieldElt = UtilFunctions.getElementFromJSONFile(fileObj, "MISC_ELEMENTS." + field, "path");
                            String currentVal = SeleniumFunctions.findElementByWebElement(row, By.xpath(".//" + fieldElt)).getText();

                            String txt1 = row.getText();

                            System.out.println(currentVal);

                            int currentLocationIndex = currentVal.lastIndexOf(".");
                            String currentLocation = currentVal.substring(currentLocationIndex + 1);

                            if (!prevLocation.equals(currentLocation)) {
                                listLocationOrder.add(String.valueOf(currentLocation));
                                prevLocation = currentLocation;
                            }
                        }
                    } catch (Exception e) {
                        //Do nothing
                    }
                }
            }
        }
        if (order.equals("Ascending")) {
            if (startingBy == null) {
                if (listLocationOrder.equals(CustomLocSortList)) {
                    Assert.assertTrue(true);
                }
                else {
                    //If the lists are not the same size/length, and listLocationOrder.size() > CustomLocSortList.size()
                    // Then the next for loop will always end with present = false
                    //And, the assertTrue will fail
                    if(listLocationOrder.size() != CustomLocSortList.size()){
                        Assert.fail("Expected List: " + CustomLocSortList + "\n Actual List: " +
                                listLocationOrder + "\n Are not the same length and therefore do not have the " +
                                "same sort order.");
                    } else {
                        int loc = 0;
                        boolean present = false;
                        for (int i = 0; i < listLocationOrder.size(); i++) {
                            present = false;
                            for (int j = i; j < CustomLocSortList.size(); j++) {
                                if (listLocationOrder.get(i).equals(CustomLocSortList.get(j))) {
                                    present = true;
                                    break;
                                }
                            }
                        }
                        Assert.assertTrue("Expected List: " + CustomLocSortList + "\n Actual List: " + listLocationOrder, present);
                    }
                }

            } else {
                for (int i = 0; i < CustomLocSortList.size(); i++) {
                    Assert.assertEquals("List Value does not matches. Expected Value at location: " + i + ", is: " + CustomLocSortList.get(i),
                            CustomLocSortList.get(i),
                            listLocationOrder.get(0));
                    listLocationOrder.remove(0);
                    if (listLocationOrder.contains(CustomLocSortList.get(i))) {
                        Assert.assertTrue("List Value: " + CustomLocSortList.get(i) + " is still present in listLocationOrder.", false);
                    }
                }
            }
        }

    }


    @Then("^the \"(.*?)\" should be sorted by \"(.*?)\" in \"(Ascending|Descending)\" order$")
    public void checkPreviewSortedOrder(String tableType, String field, String order) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        tableType = tableType.replace(" ", "");
        int rowCount = PatientListPage.getNumPatients(tableType);
//        int previousVal=0;
        String previousVal = "";
        Date previousDate = null;
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);

        int multiplier = Page.countTableRows(Hooks.getDriver(), GlobalStepdefs.curTabName, tableType, null, null) / rowCount;

        String case1 = "\"Admitting\",\"PatientName\",\"Attending\",\"Consulting\",\"LastName\",\"AccountNumber\",\"Location\"";
        String case2 = "\"Admit/ScheduledDate\"";

        for (int i = 0; i <= rowCount - 1; i++) {
            List<WebElement> current = null;
            current = Page.findPatientRowByIndex(i, tableType, multiplier);
            String currentVal;
            Date currentDate = null;
            field = field.replace(" ", "");
            if (case1.contains(field)) {
                for (WebElement row : current) {
                    try {
                        String fieldElt = UtilFunctions.getElementFromJSONFile(fileObj, "MISC_ELEMENTS." + field, "path");
                        currentVal = SeleniumFunctions.findElementByWebElement(row, By.xpath(".//" + fieldElt)).getText();
                        if (currentVal != null) {
                            String[] currentValArr = currentVal.split(" ");
                            List<String> wordList = Arrays.asList(currentValArr);
                            for (String txt : wordList) {
                                if (txt.contains(",")) {
                                    String[] temp = txt.split(",");
//                                    int t = txt.indexOf(",") - 1;
//                                    currentVal = String.valueOf(txt.charAt(t));
                                    currentVal = temp[0];
//                                    try{
//                                        Integer.valueOf(currentVal);
//                                    }
//                                    catch (NumberFormatException e){
//                                        String[] newArr = txt.split(",");
////                                        List<String> temp
//
//                                    }

                                    System.out.println(currentVal);
                                    break;
                                }
                            }
                        }
//                        int currIntVal = Integer.valueOf(currentVal);
//                        Assert.assertNotNull(currIntVal);
                        if (i != 0) {
                            if (order.equals("Ascending")) {
//                                Assert.assertTrue(currIntVal>=previousVal);
//                                if (currentVal.compareTo(previousVal) < 0)
                                Assert.assertTrue(currentVal.compareTo(previousVal) >= 0);
                            } else {
                                Assert.assertNotNull(previousVal);
//                                Assert.assertTrue(currIntVal<=previousVal);
                                Assert.assertTrue(currentVal.compareTo(previousVal) <= 0);
                            }
                        }
//                        previousVal = currIntVal;
                        previousVal = currentVal;
                    } catch (Exception e) {
                        UtilFunctions.log("Element not found found in the row. Check next row");
                    }
                }

            }
            if (case2.contains(field)) {
                if (field.equals("Admit/ScheduledDate")) {
                    for (WebElement row : current) {
                        try {
                            String fieldElt = UtilFunctions.getElementFromJSONFile(fileObj, "MISC_ELEMENTS." + field, "path");
                            currentVal = SeleniumFunctions.findElementByWebElement(row, By.xpath(".//" + fieldElt)).getText();
                            DateFormat format = new SimpleDateFormat("MM/dd/yy");
                            currentDate = format.parse(currentVal);
//                            currentVal = parsed.toString();
                        } catch (Exception e) {
                            if (e.getMessage() == null)
                                UtilFunctions.log("Element not found found in the row. Check next row");
                            else
                                UtilFunctions.log("Admit/ScheduledDate is not fetched  due to exception: " + e.getMessage());
                        }
                    }
                    if (i != 0) {
                        Assert.assertNotNull("Admit/ScheduledDate is not fetched from patient list", previousDate);
                        UtilFunctions.log("Current patient Admit/ScheduledDate: " + currentDate);
                        UtilFunctions.log("Previous patient Admit/ScheduledDate: " + previousDate);
                        if (order.equals("Ascending")) {
                            Assert.assertTrue(tableType + " not sorted by " + field + " in ascending order", currentDate.compareTo(previousDate) >= 0);
                        } else {
                            Assert.assertTrue(tableType + " not sorted by " + field + " in descending order", currentDate.compareTo(previousDate) <= 0);
                        }
                    }
                    previousDate = currentDate;

                }
            }
            //Need to fine tune this condition
            if (field.equals("Age")) {
                for (WebElement row : current) {
                    currentVal = SeleniumFunctions.findElementByWebElement(row, SeleniumFunctions.setByValues(UtilFunctions.getElementFromJSONFile(fileObj, "MISC_ELEMENTS." + field, "path"))).getText();
                    if (currentVal != null) {
                        String[] currentValArr = currentVal.split(",");
                        String currentValArrTxt = Arrays.copyOfRange(currentValArr, 0, -2).toString();
                        currentVal = currentValArrTxt;
                    }
                }
            }

        }
            UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
            }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @Then("^the \"(.*?)\" should be first sorted by \"(.*?)\" in (Ascending|Descending) order and then sorted by \"(.*?)\" in (Ascending|Descending) order$")
    public void checkTableSortAfterDoubleSort(String tableType, String firstSortBy, String firstOrder, String secondSortBy, String secondOrder) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        tableType = tableType.replace(" ", "");
        firstSortBy = firstSortBy.replace(" ", "");
        secondSortBy = secondSortBy.replace(" ", "");
        String previousFirstVal = "";
        String previousSecondVal = "";
        int rowCount = PatientListPage.getNumPatients(tableType);

        int multiplier = Page.countTableRows(Hooks.getDriver(), GlobalStepdefs.curTabName, tableType, null, null) / rowCount;

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
        for (int i = 0; i <= rowCount - 1; i++) {
            List<WebElement> current = null;
            current = Page.findPatientRowByIndex(i, tableType, multiplier);
            String firstVal = "";
            String secondVal = "";
            String currentfirstVal = "";
            String currentsecondVal = "";

            for (WebElement row : current) {
                try {
                    firstVal = UtilFunctions.getElementFromJSONFile(fileObj, "MISC_ELEMENTS." + firstSortBy, "path");
                    currentfirstVal = SeleniumFunctions.findElementByWebElement(row, By.xpath(".//" + firstVal)).getText().trim();
                    if (currentfirstVal.equals(null)) {
                        break;
                    }
                } catch (Exception e) {
                    UtilFunctions.log("Element not found found in the row. Check next row");
                }
            }
            for (WebElement row : current) {
                try {
                    secondVal = UtilFunctions.getElementFromJSONFile(fileObj, "MISC_ELEMENTS." + secondSortBy, "path");
                    currentsecondVal = SeleniumFunctions.findElementByWebElement(row, By.xpath(".//" + secondVal)).getText().trim();
                    if (currentsecondVal.equals(null)) {
                        break;
                    }
                } catch (Exception e) {
                    UtilFunctions.log("Element not found found in the row. Check next row");
                }
            }

            if (i != 0) {
                if (currentfirstVal.equals(previousFirstVal)) {
                    if (secondOrder.equals("Ascending")) {
                        Assert.assertTrue(currentsecondVal.compareTo(previousSecondVal) >= 0);

                    } else {
                        Assert.assertTrue(currentsecondVal.compareTo(previousSecondVal) <= 0);
                    }

                    if (firstOrder.equals("Ascending")) {
                        Assert.assertTrue(currentfirstVal.compareTo(previousFirstVal) >= 0);
                    } else {
                        Assert.assertTrue(currentfirstVal.compareTo(previousFirstVal) <= 0);
                    }
                }
            }
            previousFirstVal = currentfirstVal;
            previousSecondVal = currentsecondVal;

        }
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");

    }
}


