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
import pageObject.PatientListPage;
import support.Page;
import utils.UtilFunctions;

import java.util.*;


/******************************************************************************
 Class Name: AssignmentStepdefs
 Contains step definitions related to PLV2 Assignment
 ******************************************************************************/

public class AdminLocationStepdefs {

    public String className = getClass().getSimpleName();


    @And("^I select the(?: \"(.*?)\" unit under)? \"(.*?)\" facility$")
    public void selectFacilityUnit(String unitName, String facilityName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
        String paneFrames = "FRAME_MAIN";
        paneFrames = UtilFunctions.getFrameValue(frameMap, paneFrames);
        UtilFunctions.log("PaneFrames: " + paneFrames);
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");

        SeleniumFunctions.explicitWait(Hooks.getDriver(), 10, "", By.id("ItemListContainer"));

        if (unitName == null) {
            WebElement titleDiv = SeleniumFunctions.findElement(Hooks.getDriver(), By.xpath("//div[@title='" + facilityName + "']"));
            Assert.assertNotNull(facilityName + " is Null and not found.", titleDiv);
            try {
                titleDiv.click();
            } catch (ElementNotInteractableException e) {
                UtilFunctions.log(facilityName + " not clicked on 1st try due to: " + e.getMessage() + ".  Trying again w/ JS click.");
                e.printStackTrace();
                SeleniumFunctions.click(titleDiv);
            }

            Thread.sleep(1000);
            WebElement locationHeader = SeleniumFunctions.findElement(Hooks.getDriver(), By.xpath("//div[@id='LocationHeader']"));
            Assert.assertTrue("Text does not match", locationHeader.getText().contains(facilityName));
        } else {
            WebElement expand = SeleniumFunctions.findElement(Hooks.getDriver(),
                    By.xpath("//img[@class='dijitTreeExpando dijitTreeExpandoClosed' and parent::div[@title='" + facilityName + "']]"));
            if (expand != null) {
                expand.click();
            }
            Thread.sleep(2000);
            String facilityNode = "div[starts-with(@class,'dijitTreeNode') and descendant::div[@title='" + facilityName + "']]";
            SeleniumFunctions.findElement(Hooks.getDriver(),
                    By.xpath("//span[@class='dijitTreeLabel' and text()='" + unitName + "' and ancestor::" + facilityNode + "")).click();
            Thread.sleep(1000);
            WebElement locationHeader = SeleniumFunctions.findElement(Hooks.getDriver(), By.xpath("//div[@id='LocationHeader']"));
            Assert.assertTrue("Text does not match", locationHeader.getText().contains(facilityName));
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

}
