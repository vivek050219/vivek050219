package features.step_definitions;

/**
 * Created by chaitra.sg on 21-Apr-17.
 */

import cucumber.api.DataTable;
import cucumber.api.java.en.Then;
import org.junit.Assert;
import support.Page;
import utils.UtilFunctions;

import java.util.List;

/******************************************************************************
 Class Name: ChargesTabStepdefs
 Contains step definitions of Charges tab
 ******************************************************************************/

public class ChargesTabStepdefs {
    public String className = getClass().getSimpleName();


    @Then("^the \"(.*?)\" table should look like this:$")
    public void tableLook(String tableName, DataTable dataTable) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

//        String[] tableDetailArr = UtilFunctions.getTableValues(GlobalStepdefs.curTabName, tableName.replace(" ", ""));
//        String tablePath = tableDetailArr[0];
//
//        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
//        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
//        String paneFrames = (String) frameMap.get(UtilFunctions.getElementFromJSONFile(fileObj, "TABLES." + tableName.replace(" ", ""), "frame"));
//        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");
//
//            WebElement tableObject = Page.findTable(Hooks.getDriver(), tablePath);
//            String path = "//" + "table[@id='dynamicDetailTable' and descendant::tr[@id='PatientRow' and descendant::td[@id='PatientNameColumn']]]";
//
//            WebElement rows = SeleniumFunctions.findElementByWebElement(tableObject, By.xpath(path));
//            System.out.print(rows);
//            List<WebElement> cells = SeleniumFunctions.findElementsByWebElement(rows, By.tagName("tr"));
//            int rowIndex=0;
//
//            for (WebElement cell : cells) {
//                String cellValue = "";
////            WebElement cellImage = SeleniumFunctions.findElementByWebElement(cell, By.tagName("tr"));
//                List<WebElement> patientName = SeleniumFunctions.findElementsByWebElement(cell, By.xpath("//td[@id='PatientNameColumn']"));
//                for (WebElement patient : patientName) {
//                    List<List<String>> table = dataTable.raw();
//                    String compareTo =  table.get(rowIndex).get(0);
//                    String colcompareTo =  table.get(rowIndex).get(4);
//                    String patients = patient.getText();
//                    if (patients != null) {
//
//                        if (patients.equals(compareTo)) {
//                            rowIndex=rowIndex+1;
//
//                            String locationName = SeleniumFunctions.findElementByWebElement(cell, By.xpath("//td[@id='LocationColumn']")).getText();
//                            if (locationName != null) {
//                                if (locationName.equals(colcompareTo)) {
////                                    Location = Location + 1;
//                                    locationName = SeleniumFunctions.findElementByWebElement(cell, By.xpath("//td[@id='LocationColumnLast']")).getText();
//                                    Assert.assertTrue("", (colcompareTo).contains(locationName));
//
//                                }
//                                UtilFunctions.log("Patient not present");
//                            }
//                        }
//                        UtilFunctions.log("Patient not present");
//                    }
//                }
//
//
//            }

        tableName = tableName.replace(" ", "");
        List<List<String>> table = dataTable.raw();
        Assert.assertTrue("Table does not matches.", Page.compareTableBodies(tableName, table, null));
    }
}




