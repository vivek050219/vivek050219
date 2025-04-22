package features;

import common.SeleniumFunctions;
import constants.GlobalConstants;
import cucumber.api.Scenario;
import cucumber.api.java.After;
import cucumber.api.java.Before;
import features.step_definitions.LoginStepdefs;
import org.openqa.selenium.OutputType;
import org.openqa.selenium.TakesScreenshot;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebDriverException;
import org.openqa.selenium.remote.UnreachableBrowserException;
import utils.SetUpFile;
import utils.UtilFunctions;

import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URISyntaxException;


/**
 * Created by PatientKeeper on 6/21/2016.
 */

/******************************************************************************
 Class Name: Hooks
 Class invoked to execute set-up functions
 ******************************************************************************/

public class Hooks {

    //Driver object
    public static WebDriver driver = null;
    public String className = getClass().getSimpleName();
    private static Hooks hooks = new Hooks();
    public static String loggedInUser = "";
    private static int sessionReuseCount = 0;
    //Used by takeScreenShot() to embed image in current scenario
    private static Scenario scenario = null;

    @Before
    public void setUp(Scenario scenario) throws MalformedURLException, URISyntaxException {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("Scenario: " + scenario.getName() + " starting.");
        this.scenario = scenario;
        System.out.println(scenario.getName());
        if (!scenario.getSourceTagNames().isEmpty()) {
            System.out.println(scenario.getSourceTagNames().iterator().next());
            UtilFunctions.log("Scenario Tag Name: " + scenario.getSourceTagNames().iterator().next());
        }
    }


    /**************************************************************************
     * name: openBrowser(String userName)
     * functionality: Function to invoke setup browser functionality
     * param: String userName - Name of user
     * return: void
     *************************************************************************/
    public static void openBrowser(String userName, String password) throws InterruptedException, IOException {
        UtilFunctions.log("Class: " + hooks.className + "; Method: " + new Object(){}.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("userName: " + userName);
        if (loggedInUser.equals(userName) && (sessionReuseCount < 10)) {
            sessionReuseCount++;
            UtilFunctions.log("*** sessionReuseCount is: " + sessionReuseCount);
            UtilFunctions.log("User already logged in: " + userName);
        } else {
            if(!(driver == null)){
                closeBrowser();
            }
            sessionReuseCount = 0;
            UtilFunctions.log("*** New browser session.  sessionReuseCount is: " + sessionReuseCount);
            loggedInUser = userName;
            setDriver(SetUpFile.getSetUpFileObj().setUpBrowser(driver, userName, password));
        }
    }


    /**************************************************************************
     * name: closeBrowserAndTakeScreenShot(Scenario scenario)
     * functionality: Function to take screen shot and close browser
     * param: Scenario scenario - Scenario object
     * return: void
     *************************************************************************/
    @After
    public static void closeBrowserAndTakeScreenShot(Scenario scenario) throws IOException {
        try {
            UtilFunctions.log("Class: " + hooks.className + "; Method: " + new Object() {
            }.getClass().getEnclosingMethod().getName());
            if (driver == null) {
                System.out.println("Do nothing");
            } else if (scenario.isFailed()) {
                UtilFunctions.log("Scenario: " + scenario.getName() + " - Failed");
                loggedInUser = "";
                takeScreenShot();
                //Skip logout if not logged in to PK.  Window count should be greater than 1 if PK is logged in.
                if (driver.getWindowHandles().size() > 1) {
                    LoginStepdefs loginStepdefs = new LoginStepdefs();
                    try {
                        loginStepdefs.logOut();
                    } catch (Throwable throwable) {
                        throwable.printStackTrace();
                    }
                }
                driver.close();
                driver.quit();
                driver = null;
                UtilFunctions.log("Browser closed");
                sessionReuseCount = 0;
                UtilFunctions.log("*** closeBrowserAndTakeScreenShot reset sessionReuseCount: " + sessionReuseCount);
                Runtime.getRuntime().exec("Taskkill /PID " + GlobalConstants.webDriverProcessId + " /F");
                UtilFunctions.log("Tried to kill process with PID: " + GlobalConstants.webDriverProcessId);
                Runtime.getRuntime().exec("Taskkill /PID " + GlobalConstants.browserProcessId + " /F");
                UtilFunctions.log("Tried to kill process with PID: " + GlobalConstants.browserProcessId);

                UtilFunctions.log("Clear driverWindowsHandleMap.");
                SeleniumFunctions.driverWindowsHandleMap.clear();
            }
            UtilFunctions.log("Scenario: " + scenario.getName() + " complete.");
        }
        catch (UnreachableBrowserException ubEx){
            driver = null;
            loggedInUser = "";
            UtilFunctions.log("// Ignore. The browser was killed properly due to UnreachableBrowserException: " + ubEx.getMessage());
            UtilFunctions.log("Scenario: " + scenario.getName() + " complete.");
            UtilFunctions.log("Browser closed");
            Runtime.getRuntime().exec("Taskkill /PID " + GlobalConstants.webDriverProcessId + " /F");
            UtilFunctions.log("Tried to kill process with PID: " + GlobalConstants.webDriverProcessId);
            Runtime.getRuntime().exec("Taskkill /PID " + GlobalConstants.browserProcessId + " /F");
            UtilFunctions.log("Tried to kill process with PID: " + GlobalConstants.browserProcessId);

            UtilFunctions.log("Clear driverWindowsHandleMap.");
            SeleniumFunctions.driverWindowsHandleMap.clear();
        }
    }


    /**************************************************************************
     * name: getDriver()
     * functionality: Function to return driver object
     * return: returns driver object
     *************************************************************************/
    public static WebDriver getDriver(){
        UtilFunctions.log("Class: " + hooks.className + "; Method: " + new Object(){}.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("get driver object");
        return driver;
    }


    /**************************************************************************
     * name: setDriver(WebDriver setDriver)
     * functionality: Function to set WebDriver
     * param: WebDriver setDriver - WebDriver object
     * return: void
     *************************************************************************/
    public static void setDriver(WebDriver setDriver){
        UtilFunctions.log("Class: " + hooks.className + "; Method: " + new Object(){}.getClass().getEnclosingMethod().getName());
        UtilFunctions.log("get driver object");
        driver = setDriver;
    }


    /**************************************************************************
     * name: closeBrowser()
     * functionality: Function to close browser and set driver object to null
     * return: void
     *************************************************************************/
    public static void closeBrowser(WebDriver... drivers) throws IOException{
        UtilFunctions.log("Class: " + hooks.className + "; Method: " + new Object(){}.getClass().getEnclosingMethod().getName());

        loggedInUser = "";
        UtilFunctions.log("DEBUG: Checking # of window handles");
        //Skip logout if not logged in to PK.  Window count should be greater than 1 if PK is logged in.
        if (driver.getWindowHandles().size() > 1) {
            UtilFunctions.log("DEBUG: getWindowHandles().size()>1, attempting to log out of PK");
            LoginStepdefs loginStepdefs = new LoginStepdefs();
            try {
                UtilFunctions.log("DEBUG: Start logout()");
                loginStepdefs.logOut();
                UtilFunctions.log("DEBUG: logOut() complete");
            } catch (Throwable throwable) {
                throwable.printStackTrace();
            }
        }

        UtilFunctions.log("DEBUG: Checking drivers.length");
        //TODO: Is drivers.length ever greater than zero?  Can't find call to closeBrowser that passes along a drivers object
        if (drivers.length > 0){
            UtilFunctions.log("DEBUG: drivers.length > 0, calling drivers[0].quit()");
            drivers[0].quit();
            UtilFunctions.log("DEBUG: drivers[0].quit() complete");
            //TODO: Should this be driver = null?
            drivers = null;
        }
        else {
            UtilFunctions.log("DEBUG: Calling driver.quit()");
            driver.quit();
            UtilFunctions.log("DEBUG: driver.quit() complete");
            driver = null;
        }
        UtilFunctions.log("Browser closed");
        sessionReuseCount = 0;
        UtilFunctions.log("*** closeBrowser reset sessionReuseCount: " + sessionReuseCount);
        Runtime.getRuntime().exec("Taskkill /PID " + GlobalConstants.webDriverProcessId + " /F");
        UtilFunctions.log("Tried to kill process with PID: " + GlobalConstants.webDriverProcessId);
        Runtime.getRuntime().exec("Taskkill /PID " + GlobalConstants.browserProcessId + " /F");
        UtilFunctions.log("Tried to kill process with PID: " + GlobalConstants.browserProcessId);

        UtilFunctions.log("Clear driverWindowsHandleMap.");
        SeleniumFunctions.driverWindowsHandleMap.clear();
    }


    /**************************************************************************
     * name: takeScreenShot(Scenario scenario)
     * functionality: Function to take screen shot
     * * param: Scenario scenario - Scenario object
     * return: void
     *************************************************************************/
    public static void takeScreenShot(){
        UtilFunctions.log("Class: " + hooks.className + "; Method: " + new Object(){}.getClass().getEnclosingMethod().getName());
        try {
            byte[] screenShot = ((TakesScreenshot) driver).getScreenshotAs(OutputType.BYTES);
            scenario.embed(screenShot, "image/png");
        } catch (WebDriverException wde) {
            System.err.println(wde.getMessage());
        } catch (ClassCastException cce) {
            cce.printStackTrace();
        }
    }

    /**************************************************************************
     * Helper method to set the loggedInUser variable
     *
     * @param userName the name of the user currently logged in to PK
     * @return void
     *************************************************************************/
    public static void setLoggedInUser(String userName){
        loggedInUser = userName;
    }
}
