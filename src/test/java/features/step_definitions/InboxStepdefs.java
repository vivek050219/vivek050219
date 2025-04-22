package features.step_definitions;

import common.SeleniumFunctions;
import cucumber.api.java.en.And;
import cucumber.api.java.en.When;
import org.json.simple.JSONObject;
import org.junit.Assert;
import org.openqa.selenium.WebElement;
import utils.UtilFunctions;
import static features.Hooks.driver;
import static features.step_definitions.GlobalStepdefs.curTabName;
import java.awt.Robot;
import java.awt.event.KeyEvent;


/**
 * Created on 1/31/2020.
 */

/******************************************************************************
 * Class Name: InboxStepdefs Contains step definitions related to Inbox flow
 ******************************************************************************/

public class InboxStepdefs {

	public String className = getClass().getSimpleName();

	/**
	 * Verify the row count of message table for Scanned / Orders screen this
	 * works for Inbox tab which has 9x UI
	 * @param linkName
	 * @param buttonName
	 */
	@When("^I verify the note count appear with the \"(.*?)\" link and click the \"(.*?)\" button?$")
	public void verifyTheCountOfTheTableInAll(String elementName, String buttonName) throws Throwable {
		UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
		}.getClass().getEnclosingMethod().getName() + " : Start");

		elementName = elementName.replace(" ", "");
		JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
		String[] elementType = UtilFunctions.getElementStringAndType(fileObj, "MISC_ELEMENTS." + elementName);
		String path = elementType[0];
		String method = elementType[1];

		WebElement eleObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(path + ";" + method));
		String textAppearingOnElement = eleObj.getText();

		int noteCountBeforeAnyOperation = Integer.parseInt(textAppearingOnElement.replaceAll("[^0-9]", ""));
		int countAfterOperationPerformed = 0;

		UtilFunctions.log("Count of the data before any operation is" + noteCountBeforeAnyOperation);
		System.out.println("Total count before" + noteCountBeforeAnyOperation);

		GlobalStepdefs globalStepdefs = new GlobalStepdefs();
		String paneName = null;

		if (buttonName.equals("Sign")) {
			paneName = "CollapsedScannedDialog";
			globalStepdefs.clickButton("Sign", paneName, null);
			countAfterOperationPerformed = noteCountBeforeAnyOperation - 1;
		} else if (buttonName.equals("Save")) {
			paneName = "CollapsedScannedDialog";
			globalStepdefs.clickButton("Save", paneName, null);
			countAfterOperationPerformed = noteCountBeforeAnyOperation;
		} else if (buttonName.equals("Save&Sign")) {
			paneName = "CollapsedScannedDialog";
			globalStepdefs.clickButton("Save&Sign", paneName, null);
			countAfterOperationPerformed = noteCountBeforeAnyOperation - 1;
		} else if (buttonName.equals("Skip")) {
			paneName = "CollapsedScannedDialog";
			globalStepdefs.clickButton("Skip", paneName, null);
			countAfterOperationPerformed = noteCountBeforeAnyOperation;
		} else if (buttonName.equals("ConfirmOK")) {
			paneName = "CollapsedScannedDialog";
			globalStepdefs.clickButton("ConfirmOK", paneName, null);
			countAfterOperationPerformed = noteCountBeforeAnyOperation - 1;
		}

		eleObj = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(path + ";" + method));
		textAppearingOnElement = eleObj.getText();

		int noteCountAfterAnyOperation = Integer.parseInt(textAppearingOnElement.replaceAll("[^0-9]", ""));

		Assert.assertEquals("Count on" + elementName + "link is not same after operation performed", countAfterOperationPerformed, noteCountAfterAnyOperation);
		System.out.println("Total row countAfterOperationPerformed" + countAfterOperationPerformed);
		System.out.println("Total row noteCountAfterAnyOperation" + noteCountAfterAnyOperation);

		UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
		}.getClass().getEnclosingMethod().getName() + " : Complete");
	}
	
	/**
     * To close any window popup
     */
    @And("^I close windows popup$")
    public void closePrintPreview() throws Throwable {
       UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

       Robot r = new Robot();
       r.keyPress(KeyEvent.VK_ESCAPE);
       r.keyRelease(KeyEvent.VK_ESCAPE);
       
       GlobalStepdefs globalStepdefs = new GlobalStepdefs();
       globalStepdefs.waitGivenTime("5");

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


}
