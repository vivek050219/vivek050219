package features.step_definitions;

import cucumber.api.java.en.Given;
import features.Hooks;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import support.Page;
import utils.UtilFunctions;

/**
 * Created by PatientKeeper on 6/24/2016.
 */

/******************************************************************************
 Class Name: GlobalStepdefs
 Contains global step definitions used with every feature file
 ******************************************************************************/

public class DMRStepDefs {

    public String className = getClass().getSimpleName();
    public static String curTabName = "";
    public static String subSection = "";

    @Given("^I delete previous Discharge Orders if Present$")
    public void deletePreviousCharge() throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        PatientListClinicalsStepdefs patientListClinicalsStepdefs = new PatientListClinicalsStepdefs();

        patientListClinicalsStepdefs.selectFromClinicalNavigation("Discharge Orders");
        globalStepdefs.checkPaneLoad("Discharge Orders", "load", null);

        WebElement dischargeTableObj = Page.getElementObject(Hooks.getDriver(), GlobalStepdefs.curTabName, "DischargeOrders", "TABLES");

        if (dischargeTableObj != null &&
                dischargeTableObj.findElement(By.tagName("tbody")).findElements(By.tagName("tr")).size() > 0) {
            //And I click the "Discharge Med Rec" button in the "Orders" pane
            globalStepdefs.clickButton("Discharge Med Rec", "DischargeOrders", null);

            //And I click the "Delete All" link if it exists in the "Discharge Medication Reconciliation" pane
            globalStepdefs.clickLinkInPane("Delete All", "if it exists", null, "Discharge Medication Reconciliation");

            //And I click the "Yes" button in the "Question" pane if it exists
            globalStepdefs.clickButton("Yes", "Question", "if it exists");

            //And I reconcile and Submit the Orders
            globalStepdefs.reconcileSubmitOrders("reconcile and");
        }


        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }
}
