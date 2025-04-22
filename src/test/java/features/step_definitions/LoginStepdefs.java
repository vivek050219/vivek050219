package features.step_definitions;

//import runners.cucumber.Hooks;

import automationExceptions.ConnectionInterruptedException;
import common.SeleniumFunctions;
import constants.GlobalConstants;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import features.Hooks;
import frames.Global_Frames;
import org.junit.Assert;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.edge.EdgeDriver;
import org.openqa.selenium.edge.EdgeOptions;
import org.openqa.selenium.ie.InternetExplorerDriver;
import utils.SetUpFile;
import utils.UtilFunctions;
import utils.UtilProperty;

import java.lang.management.ManagementFactory;
import java.util.HashMap;

import static common.SeleniumFunctions.parentWindow;
import static features.Hooks.driver;

/**
 * Created by PatientKeeper on 6/21/2016.
 */

/******************************************************************************
 Class Name: LoginStepdefs
 Contains step definitions related to login
 ******************************************************************************/

public class LoginStepdefs {

    public String className = getClass().getSimpleName();

    @Given("^I am logged into the portal with user \"(.*?)\" using the default password$")
    public void portalLogin(String userName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String defaultPassword = UtilProperty.userPwd;
        Hooks.openBrowser(userName, defaultPassword);

        //Set up for hash maps
        PatientSafetyStepdefs.persistent_state.clear();

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Given("^I am logged into the portal with the default user$")
    public void portalLogin() throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String defaultUserName = UtilProperty.userName;
        String defaultPassword = UtilProperty.userPwd;

        Hooks.openBrowser(defaultUserName, defaultPassword);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Given("^I am logged into the portal with user \"(.*?)\" and password \"(.*?)\"$")
    public void portalLogin(String userName, String password) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        Hooks.openBrowser(userName, password);

        //Set up for hash maps
        PatientSafetyStepdefs.persistent_state.clear();

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I am logged out of the portal$")
    public void portalLogout() throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        this.logOut();
        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        globalStepdefs.switchFocus("Login Window");

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Given("^I open new tab and log into the portal with user \"(.*?)\" using the default password$")
    public void portalLoginInNewTab(String userName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String defaultPassword = UtilProperty.userPwd;

        ((JavascriptExecutor) Hooks.getDriver()).executeScript("window.open('" + UtilProperty.url + "');");
        SeleniumFunctions.explicitWait(driver, GlobalConstants.FIVE, Global_Frames.globalFramesMap.get("PARENT_FRAME") + ";name");
        //((JavascriptExecutor) Hooks.getDriver()).executeScript("window.open('" + Hooks.getDriver().getCurrentUrl() + "');");

        //Switch to latest tab
        String latestWindowHandle = (String) Hooks.getDriver().getWindowHandles().toArray()[Hooks.getDriver().getWindowHandles().size() - 1];
        Hooks.getDriver().switchTo().window(latestWindowHandle);

        int cntCheck = 0;
        while (!Hooks.getDriver().getCurrentUrl().contains("onewindow=Y")){
            UtilFunctions.log("URL: " + Hooks.getDriver().getCurrentUrl() + " does not contain query param: 'onewindow=Y'. Trying Again!");
            cntCheck++;
            Hooks.getDriver().close();
            Hooks.getDriver().switchTo().window(parentWindow);
            ((JavascriptExecutor) Hooks.getDriver()).executeScript("window.open('" + UtilProperty.url + "');");
            latestWindowHandle = (String) Hooks.getDriver().getWindowHandles().toArray()[Hooks.getDriver().getWindowHandles().size() - 1];
            Hooks.getDriver().switchTo().window(latestWindowHandle);

            if (cntCheck >= GlobalConstants.FIVE && !Hooks.getDriver().getCurrentUrl().contains("onewindow=Y")){
                UtilFunctions.log("URL: " + Hooks.getDriver().getCurrentUrl() + " still does not contain query param: 'onewindow=Y' after 5 tries. Stopping the execution now!");
                Assert.assertTrue("URL: " + Hooks.getDriver().getCurrentUrl() + " still does not contain query param: 'onewindow=Y' after 5 tries. Stopping the execution now!", false);
            }
        }

        SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, Global_Frames.globalFramesMap.get("PARENT_FRAME") + ";name");
        SeleniumFunctions.switchToFrame(driver, SeleniumFunctions.setByValues(Global_Frames.globalFramesMap.get("PARENT_FRAME") + ";name"));

        SetUpFile.getSetUpFileObj().logInApplication(Hooks.getDriver(), userName, defaultPassword);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I click the logout button$")
    public void logOut()throws Throwable{
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        //Set loggedInUser to empty string.  This will for the next scenario to close the browser and log back in
        Hooks.setLoggedInUser("");

        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        String paneFrame = "FRAME_LOGOUT";
        String paneFrames = UtilFunctions.getFrameValue(frameMap, paneFrame);
        UtilFunctions.log("PaneFrames: " + paneFrames);
        SeleniumFunctions.selectFrame(driver, paneFrames, "id");

        WebElement logOutObj = SeleniumFunctions.findElement(driver,SeleniumFunctions.setByValues("//div[@class='inactive pointer' and @id='LogoutImg']"));
        if (logOutObj != null)
            logOutObj.click();

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^the portal should load(?: with user \"(.*?)\")?$")
    public void checkPortalLoad(String userName)throws Throwable{
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        Thread.sleep(1000);
        String title= Hooks.getDriver().getTitle();
        if(userName == null){
            Assert.assertTrue("Portal is not loaded",title.contains("User:"));
        }else{
            Assert.assertTrue("Portal is not loaded with user" + userName,title.contains(userName));
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }
    @Given("^I should receive an error message \"(.*)\"$")
    public void checkErrorMessage(String errorText) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        String paneFrame = "LOGIN_FRAME";
        String paneFrames = UtilFunctions.getFrameValue(frameMap, paneFrame);
        UtilFunctions.log("PaneFrames: " + paneFrames);
        SeleniumFunctions.selectFrame(driver, paneFrames, "id");

        String errorMsg = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("//div[@id='errorMsg']")).getText();
        Assert.assertTrue("Error Text: " + errorText + " is not displayed",errorMsg.equalsIgnoreCase(errorText));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }
    @When("^I login as \"(.*)\" with password \"(.*)\"$")
    public void LoginWithIncorrectPassword(String userName,String password)throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        PasswordStepdefs passwordsStepdefs=new PasswordStepdefs();
        if (Hooks.getDriver() == null) {
            //Do Nothing
        } else {
            Hooks.closeBrowser();
        }

        String driverProcessName = "";
        String browserProcessName = "";
        if (UtilProperty.browserType.contains("ie")) {

            try {
                Runtime.getRuntime().exec("Taskkill /F /IM iexplore.exe /T");
            } catch (Exception e) {
                //Swallow errors
            }
            driver = new InternetExplorerDriver();
            driverProcessName = "IEDriverServer.exe";
            browserProcessName = "iexplore.exe";
            UtilFunctions.log("InternetExplorerDriver initialized");
        } else if (UtilProperty.browserType.equals("chrome")) {
            ChromeOptions options = new ChromeOptions();
            options.addArguments("--disable-popup-blocking");
            driver = new ChromeDriver(options);
            driverProcessName = "chromedriver.exe";
            browserProcessName = "chrome.exe";
            UtilFunctions.log("ChromeDriver initialized");
        } else if (UtilProperty.browserType.equals("edgeBeta")) {
            driver = new EdgeDriver();
            driverProcessName = "msedgedriver.exe";
            browserProcessName = "msedge.exe";
            UtilFunctions.log("EdgeDriver initialized");
        } else {
            UtilProperty.browserType = "chrome";
            ChromeOptions options = new ChromeOptions();
            options.addArguments("--disable-popup-blocking");
            driver = new ChromeDriver(options);
            driverProcessName = "chromedriver.exe";
            browserProcessName = "chrome.exe";
            UtilFunctions.log("ChromeDriver initialized");
        }

        driver.manage().window().maximize();

        String jvmProcessId = ManagementFactory.getRuntimeMXBean().getName().split("@")[0];
        if (jvmProcessId != null) {
            String webDriverProcessId = SetUpFile.getSetUpFileObj().getChildProcessID(jvmProcessId, driverProcessName);
            GlobalConstants.browserProcessId = SetUpFile.getSetUpFileObj().getChildProcessID(webDriverProcessId, browserProcessName);
        }

        Hooks.setDriver(driver);
        SetUpFile.getSetUpFileObj().openURL(driver);


        if (userName.equals("") )
            userName="";
        if ( password.equals("") )
            password="";

        SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(UtilFunctions.getElementFromJSONFile(GlobalConstants.jsonObjLoginElements, "TEXT_FIELDS.Username", "barexpath"))).clear();
        SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(UtilFunctions.getElementFromJSONFile(GlobalConstants.jsonObjLoginElements, "TEXT_FIELDS.Username", "barexpath"))).sendKeys(userName);
        UtilFunctions.log("UserName: " + userName + " entered");
        //Per DEV-56253, password field is readonly until it is given focus.  Need to click element before it can be cleared.
        WebElement passwordPrompt = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(UtilFunctions.getElementFromJSONFile(GlobalConstants.jsonObjLoginElements, "TEXT_FIELDS.Password", "barexpath")));
        passwordPrompt.click();
        passwordPrompt.clear();
        passwordPrompt.sendKeys(password);
        UtilFunctions.log("Password: " + password + " entered");

        SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(UtilFunctions.getElementFromJSONFile(GlobalConstants.jsonObjLoginElements, "BUTTONS.Login", "barexpath"))).click();
        try {
            Thread.sleep(2000);
        } catch (InterruptedException e) {
            throw new ConnectionInterruptedException("Error while logging in the application");
        }
        UtilFunctions.log("Login button clicked");

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Given("^I open new tab and validate the text \"(.*?)\"$")
    public void newTabWindowAndValidateText(String text) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String defaultPassword = UtilProperty.userPwd;

        ((JavascriptExecutor) Hooks.getDriver()).executeScript("window.open('" + UtilProperty.url + "');");
        SeleniumFunctions.explicitWait(driver, GlobalConstants.FIVE, Global_Frames.globalFramesMap.get("PARENT_FRAME") + ";name");
        //((JavascriptExecutor) Hooks.getDriver()).executeScript("window.open('" + Hooks.getDriver().getCurrentUrl() + "');");

        //Switch to latest tab
        String latestWindowHandle = (String) Hooks.getDriver().getWindowHandles().toArray()[Hooks.getDriver().getWindowHandles().size() - 1];
        Hooks.getDriver().switchTo().window(latestWindowHandle);

        int cntCheck = 0;
        while (!Hooks.getDriver().getCurrentUrl().contains("onewindow=Y")) {
            UtilFunctions.log("URL: " + Hooks.getDriver().getCurrentUrl() + " does not contain query param: 'onewindow=Y'. Trying Again!");
            cntCheck++;
            Hooks.getDriver().close();
            Hooks.getDriver().switchTo().window(parentWindow);
            ((JavascriptExecutor) Hooks.getDriver()).executeScript("window.open('" + UtilProperty.url + "');");
            latestWindowHandle = (String) Hooks.getDriver().getWindowHandles().toArray()[Hooks.getDriver().getWindowHandles().size() - 1];
            Hooks.getDriver().switchTo().window(latestWindowHandle);

            if (cntCheck >= GlobalConstants.FIVE && !Hooks.getDriver().getCurrentUrl().contains("onewindow=Y")) {
                UtilFunctions.log("URL: " + Hooks.getDriver().getCurrentUrl() + " still does not contain query param: 'onewindow=Y' after 5 tries. Stopping the execution now!");
                Assert.assertTrue("URL: " + Hooks.getDriver().getCurrentUrl() + " still does not contain query param: 'onewindow=Y' after 5 tries. Stopping the execution now!", false);
            }
        }

        SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, Global_Frames.globalFramesMap.get("PARENT_FRAME") + ";name");
        SeleniumFunctions.switchToFrame(driver, SeleniumFunctions.setByValues(Global_Frames.globalFramesMap.get("PARENT_FRAME") + ";name"));

        WebElement textpath = driver.findElement(By.xpath("//div[@id='veilMessage']"));
        Assert.assertTrue("Text: '" + text + "' not displayed.", textpath.getText().contains(text));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }
}


