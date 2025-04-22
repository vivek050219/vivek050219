package features.step_definitions.REST;

import api_RestAssured.support.TabBar;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.When;
import features.step_definitions.GlobalStepdefs;
import utils.UtilFunctions;
import utils.UtilProperty;

import static io.restassured.RestAssured.given;

/**
 * Created by Atripathi on 10/6/2016.
 */
public class RESTGlobalStepDefs extends TabBar {

    public String className = getClass().getSimpleName();
    public static String globalURLType = "";
    public static String authToken = "";

    @Given("^API: The auth token is set to \"(.*?)\"$")
    public void apiPortalLogin(String authTokenValue) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        //authToken = authTokenValue;
        authToken = UtilProperty.userPwd;
        request = given().header("AUTHTOKEN", authToken);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @When("^API: I am on the \"(.*?)\" tab$")
    public void setURLThroughTab(String checkType) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        checkType = checkType.replace(" ", "");
        globalURLType = tabSet.get(checkType);
        GlobalStepdefs.curTabName = checkType.replace(" ", "");

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @When("^API: I perform actions on \"(.*?)\" api$")
    public void setAPI(String checkType) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        checkType = checkType.replace(" ", "");
        setURLThroughTab(checkType);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }
}
