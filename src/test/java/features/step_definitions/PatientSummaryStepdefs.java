package features.step_definitions;


import cucumber.api.java.en.Then;
import features.Hooks;
import org.junit.Assert;
import org.openqa.selenium.WebElement;
import support.Page;
import utils.UtilFunctions;
import java.awt.Robot;
import java.awt.event.KeyEvent;



/******************************************************************************
 Class Name: PatientSummaryStepdefs
 Contains step definitions related to patient summary page
 ******************************************************************************/

public class PatientSummaryStepdefs {

    public String className = getClass().getSimpleName();

    @Then("^The Print Preview Should load(?: within \"(.*?)\" seconds)?$")
    public void printPreviewLoad(String time) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String  paneName="Print Preview";
        WebElement pane = null;
        int loopCount = 0;
        if (time == null) {
            pane = Page.findPane(Hooks.getDriver(), GlobalStepdefs.curTabName, paneName);
        }else {
            while (pane == null && loopCount <= Integer.parseInt(time)) {
                pane = Page.findPane(Hooks.getDriver(), GlobalStepdefs.curTabName, paneName);
                loopCount++;
            }
        }
        if (pane != null) {
            try {
                Robot printDialog = new Robot();
                printDialog.delay(1000);
                printDialog.keyPress(KeyEvent.VK_ESCAPE);
                printDialog.keyRelease(KeyEvent.VK_ESCAPE);
            }catch (Exception e){
                UtilFunctions.log(" Error while handling Print windows dialog" + e.getMessage());
            }
        }
        //WindowsUtils.tryToKillByName("AcroRd32.exe"); // this step can handle Print native dialog but works only with IE
        Assert.assertNotNull("Object: " + paneName + " Not Found", pane);
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

}
