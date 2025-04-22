package features.step_definitions;

import api.page.AdminPage;
import api.page.LoginPage;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.When;
import org.junit.Assert;
import utils.UtilFunctions;

import java.util.List;

/**
 * Created by Atripathi on 10/6/2016.
 */
public class APIStepDefs {

    public String className = getClass().getSimpleName();
    public static String curTabName = "";

    @Given("^API: I am logged into the portal with user \"(.*?)\" using the default password$")
    public void portalLogin(String userName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        LoginPage loginPage = new LoginPage();
        loginPage.getLoginResponse(userName);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    //Un/check multiple check boxes
    @When("^API: I (close|open)? the following tabs$")
    public void checkMultipleCheckBoxes(String checkType, List<String> dataList) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        for (String tabName : dataList){
            UtilFunctions.log("TabName: " + tabName);
            AdminPage adminPage = new AdminPage();
            Assert.assertTrue("TabName: " + tabName + " is not " + checkType, adminPage.openCloseTabs(checkType, tabName));
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }
}
