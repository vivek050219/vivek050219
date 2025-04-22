package utils;

import automationExceptions.ConnectionInterruptedException;
import automationExceptions.ElementsFileNotFound;
import common.SeleniumFunctions;
import constants.GlobalConstants;
import features.Hooks;
import frames.*;
import io.github.bonigarcia.wdm.WebDriverManager;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.junit.Assert;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.edge.EdgeDriver;
import org.openqa.selenium.edge.EdgeOptions;
import org.openqa.selenium.ie.InternetExplorerDriver;

import java.io.FileReader;
import java.io.IOException;
import java.lang.management.ManagementFactory;
import java.util.Scanner;

/**
 * Created by PatientKeeper on 6/24/2016.
 */

/******************************************************************************
 Class Name: SetUpFile
 Contains functions related to set-up
 ******************************************************************************/

public class SetUpFile {

    public String className = getClass().getSimpleName();
    private static SetUpFile setUpFile = null;

    /**************************************************************************
     * name: SetUpFile()
     * functionality: Constructor to initialize logger, frames map,
     * json object and initialization of global frame value
     *************************************************************************/
    public SetUpFile(){
        UtilFunctions.log("Class: " + className + "; Method: constructor");
        initializeFramesMap();
        initializeElementJSONFiles();
    }


    public static SetUpFile getSetUpFileObj(){
        if (setUpFile == null)
            setUpFile = new SetUpFile();
        GlobalConstants.setGlobalFrameValue("");
        return setUpFile;
    }


    /**************************************************************************
     * name: initializeFramesMap()
     * functionality: Function to initialize hash maps for frames and values
     * for each page
     * return: void
     *************************************************************************/
    public void initializeFramesMap(){
        Global_Frames.setGlobalFramesMap();
        Admin_Frames.setAdminFramesMap();
        PatientList_Frames.setPatientListFramesMap();
        PatientListV2_Frames.setPatientListV2FramesMap();
        Forms_Frames.setFormsFramesMap();
        Charges_Frames.setChargesFramesMap();
        Preferences_Frames.setPreferencesFramesMap();
        PatientSearch_Frames.setPatientSearchFramesMap();
        Assignment_Frames.setAssignmentFramesMap();
        PatientSummary_Frames.setPatientSummaryFramesMap();
        Inbox_Frames.setInboxFramesMap();
        ProviderDirectory_Frames.setProviderDirectoryFramesMap();
        Schedule_Frames.setScheduleFramesMap();
        NoteSearch_Frames.setNoteSearchFramesMap();
    }


    /**************************************************************************
     * name: initializeElementJSONFiles
     * functionality: Function to initialize json file for each page
     * return: void
     *************************************************************************/
    public void initializeElementJSONFiles(){
        JSONParser parser = new JSONParser();

        try {
            UtilFunctions.log("Initializing JSON files");
            //Initializing Element repository
            GlobalConstants.jsonObjGlobalElements = (JSONObject)parser.parse(new FileReader(UtilProperty.sMainDir + "\\src\\test\\java\\elementRepository\\Global_Elements.json"));
            GlobalConstants.jsonObjLoginElements = (JSONObject)parser.parse(new FileReader(UtilProperty.sMainDir + "\\src\\test\\java\\elementRepository\\Login_Elements.json"));
            GlobalConstants.jsonObjAdminElements = (JSONObject)parser.parse(new FileReader(UtilProperty.sMainDir + "\\src\\test\\java\\elementRepository\\Admin_Elements.json"));
            GlobalConstants.jsonObjPatientListElements = (JSONObject)parser.parse(new FileReader(UtilProperty.sMainDir + "\\src\\test\\java\\elementRepository\\PatientList_Elements.json"));
            //PLv2 elements require a merge between existing PLv1 elements and new, or overriding, PLv2 elements
            JSONObject plv2Elements = (JSONObject)parser.parse(new FileReader(UtilProperty.sMainDir + "\\src\\test\\java\\elementRepository\\PatientListV2_Elements.json"));
            GlobalConstants.jsonObjPatientListV2Elements = UtilFunctions.mergeJsonObjects(GlobalConstants.jsonObjPatientListElements,plv2Elements);
            GlobalConstants.jsonObjFormsElements = (JSONObject)parser.parse(new FileReader(UtilProperty.sMainDir + "\\src\\test\\java\\elementRepository\\Forms_Elements.json"));
            GlobalConstants.jsonObjChargesElements = (JSONObject)parser.parse(new FileReader(UtilProperty.sMainDir + "\\src\\test\\java\\elementRepository\\Charges_Elements.json"));
            GlobalConstants.jsonObjPreferencesElements = (JSONObject)parser.parse(new FileReader(UtilProperty.sMainDir + "\\src\\test\\java\\elementRepository\\Preferences_Elements.json"));
            GlobalConstants.jsonObjPatientSearchElements = (JSONObject)parser.parse(new FileReader(UtilProperty.sMainDir + "\\src\\test\\java\\elementRepository\\PatientSearch_Elements.json"));
            GlobalConstants.jsonObjAssignmentElements = (JSONObject)parser.parse(new FileReader(UtilProperty.sMainDir + "\\src\\test\\java\\elementRepository\\Assignment_Elements.json"));
            GlobalConstants.jsonObjPatientSummaryElements = (JSONObject)parser.parse(new FileReader(UtilProperty.sMainDir + "\\src\\test\\java\\elementRepository\\PatientSummary_Elements.json"));
            GlobalConstants.jsonObjInboxElements = (JSONObject)parser.parse(new FileReader(UtilProperty.sMainDir + "\\src\\test\\java\\elementRepository\\Inbox_Elements.json"));
            GlobalConstants.jsonObjProviderDirectoryElements = (JSONObject)parser.parse(new FileReader(UtilProperty.sMainDir + "\\src\\test\\java\\elementRepository\\ProviderDirectory_Elements.json"));
            GlobalConstants.jsonObjScheduleElements = (JSONObject)parser.parse(new FileReader(UtilProperty.sMainDir + "\\src\\test\\java\\elementRepository\\Schedule_Elements.json"));
            GlobalConstants.jsonObjNoteSearchElements = (JSONObject)parser.parse(new FileReader(UtilProperty.sMainDir + "\\src\\test\\java\\elementRepository\\NoteSearch_Elements.json"));
            //Initializing Queries
            GlobalConstants.jsonObjGlobalQueries = (JSONObject)parser.parse(new FileReader(UtilProperty.sMainDir + "\\src\\test\\java\\queries\\Global_Queries.json"));
            JSONObject PatientListQueries = (JSONObject)parser.parse(new FileReader(UtilProperty.sMainDir + "\\src\\test\\java\\queries\\PatientList_Queries.json"));
            GlobalConstants.jsonObjPatientListQueries = UtilFunctions.mergeJsonObjects(GlobalConstants.jsonObjGlobalQueries, PatientListQueries);
            //PLv2 elements require a merge between existing PLv1 elements and new, or overriding, PLv2 elements
            JSONObject PatientListV2Queries = (JSONObject)parser.parse(new FileReader(UtilProperty.sMainDir + "\\src\\test\\java\\queries\\PatientListV2_Queries.json"));
            GlobalConstants.jsonObjPatientListV2Queries = UtilFunctions.mergeJsonObjects(GlobalConstants.jsonObjPatientListQueries,PatientListV2Queries);

        } catch (IOException e) {
            try{
                throw new ElementsFileNotFound("The Json file containing the elements information is not found");
            }
            catch (ElementsFileNotFound p){
                UtilFunctions.log("ElementsFileNotFound " + p.getMessage());
            }
            //UtilFunctions.log("IOException" + e.getMessage()); commented to implement custom exceptions
        } catch (ParseException e) {
            e.printStackTrace();
            UtilFunctions.log("ParseException" + e.getMessage());
        }
    }


    /**
     * ***********************************************************************
     * name: setUpBrowser(WebDriver driver, String userName)
     * functionality: Function to open and login to browser
     * param: WebDriver driver - WebDriver object
     * param: String userName - Name of user
     * return: returns driver object
     * ***********************************************************************
     */
    public WebDriver setUpBrowser(WebDriver driver, String userName, String password) throws InterruptedException {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        String driverProcessName = "";
        String browserProcessName = "";
        if (UtilProperty.browserType.contains("ie")) {
            //kill existing IE browsers
            try {
                Runtime.getRuntime().exec("Taskkill /F /IM iexplore.exe /T");
            }
            catch(Exception e){
                //Swallow errors
            }
            //Too risky to use recent drivers without proper testing
            WebDriverManager.iedriver().arch32().version("3.14").setup();
            driver = new InternetExplorerDriver();
            driverProcessName = "IEDriverServer.exe";
            browserProcessName = "iexplore.exe";
            UtilFunctions.log("InternetExplorerDriver initialized");
        } else if (UtilProperty.browserType.equals("chrome")) {
            ChromeOptions options = new ChromeOptions();
            options.addArguments("--disable-popup-blocking");
            //Clear version map cache to avoid using the Beta Chrome driver against Prod Chrome
            WebDriverManager.chromedriver().clearPreferences();
            WebDriverManager.chromedriver().setup();
            driver = new ChromeDriver(options);
            driverProcessName = "chromedriver.exe";
            browserProcessName = "chrome.exe";
            UtilFunctions.log("ChromeDriver initialized");
        } else if (UtilProperty.browserType.equals("chromeBeta")) {
            ChromeOptions options = new ChromeOptions();
            options.setBinary("C:\\Program Files (x86)\\Google\\Chrome Beta\\Application\\chrome.exe");
            options.addArguments("--disable-popup-blocking");
            //Clear version map cache to avoid using the Prod Chrome driver against Beta Chrome
            WebDriverManager.chromedriver().clearPreferences();
            WebDriverManager.chromedriver().config().setUseBetaVersions(true);
            //Use specific driver version:
            //WebDriverManager.chromedriver().version("75");
            //Get driver version based on installed Chrome Beta browser version:
            WebDriverManager.chromedriver().browserPath("C:\\\\Program Files (x86)\\\\Google\\\\Chrome Beta\\\\Application\\\\chrome.exe");
            WebDriverManager.chromedriver().setup();
            driver = new ChromeDriver(options);
            driverProcessName = "chromedriver.exe";
            browserProcessName = "chrome.exe";
            UtilFunctions.log("ChromeDriver initialized");
        } else if (UtilProperty.browserType.equals("edgeBeta")) {
            ChromeOptions options = new ChromeOptions();
            options.setBinary("C:\\Program Files (x86)\\Microsoft\\Edge Beta\\Application\\msedge.exe");
            options.addArguments("--disable-popup-blocking");
            WebDriverManager.edgedriver().clearPreferences();
            WebDriverManager.edgedriver().browserPath("C:\\\\Program Files (x86)\\\\Microsoft\\\\Edge Beta\\\\Application\\\\msedge.exe");
            WebDriverManager.edgedriver().config().setEdgeDriverVersion("79.0.309.60");
            WebDriverManager.edgedriver().setup();
            EdgeOptions edgeOptions = new EdgeOptions().merge(options);
            driver = new EdgeDriver(edgeOptions);
            UtilFunctions.log("EdgeDriver initialized");
        } else {
            //Default browser is Chrome
            UtilProperty.browserType = "chrome";
            ChromeOptions options = new ChromeOptions();
            options.addArguments("--disable-popup-blocking");
            //Clear version map cache to avoid using the Beta Chrome driver against Prod Chrome
            WebDriverManager.chromedriver().clearPreferences();
            WebDriverManager.chromedriver().setup();
            driver = new ChromeDriver(options);
            driverProcessName = "chromedriver.exe";
            browserProcessName = "chrome.exe";
            UtilFunctions.log("ChromeDriver initialized");
        }

        driver.manage().window().maximize();

        String jvmProcessId = ManagementFactory.getRuntimeMXBean().getName().split("@")[0];
        if (jvmProcessId != null) {
            GlobalConstants.webDriverProcessId = getChildProcessID(jvmProcessId, driverProcessName);
            GlobalConstants.browserProcessId = getChildProcessID(GlobalConstants.webDriverProcessId, browserProcessName);
        }

        Hooks.setDriver(driver);

        openURL(driver);
        try {
            logInApplication(driver, userName, password);
        } catch (InterruptedException e) {
            throw new ConnectionInterruptedException("Error while logging in the application");
        }

        SeleniumFunctions.setInitialWindowHandles(driver);

        return driver;
    }


    /**************************************************************************
     * name: openURL(WebDriver driver)
     * functionality: Function to open given url
     * param: WebDriver driver - WebDriver object
     * return: void
     *************************************************************************/
    public void openURL(WebDriver driver){
        UtilFunctions.log("Class: " + className + "; Method: " + new Object(){}.getClass().getEnclosingMethod().getName());
        try{
            if (UtilProperty.tagName.toLowerCase().contains("onewindow") &&
                    !UtilProperty.url.contains("?onewindow=Y")) {
                    UtilProperty.url = UtilProperty.url + "?onewindow=Y";
            }
            driver.get(UtilProperty.url);
        }
        catch (Exception e){
            UtilFunctions.log("URL: "+ UtilProperty.url + " not present. ABORTING!!");
            Assert.assertTrue("URL not present", false);
        }
        SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, Global_Frames.globalFramesMap.get("PARENT_FRAME") + ";name");

        if (SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues(Global_Frames.globalFramesMap.get("PARENT_FRAME") + ";name")) == null){
            Assert.assertTrue("URL: " + UtilProperty.url + " does not work.", false);
        }

        SeleniumFunctions.switchToFrame(driver, SeleniumFunctions.setByValues(Global_Frames.globalFramesMap.get("PARENT_FRAME") + ";name"));
    }


    /**************************************************************************
     * Function to login to application
     *
     * @param driver WebDriver object
     * @param userName name of user to login as
     * @param password password for user
     *************************************************************************/
    public void logInApplication(WebDriver driver, String userName, String password) throws ConnectionInterruptedException {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object(){}.getClass().getEnclosingMethod().getName());
        //Use default username or password if null/empty values passed
        if (userName == null || userName.equals(""))
            userName = UtilProperty.userName;
        if (password == null || password.equals(""))
            password = UtilProperty.userPwd;
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
        }
        catch (InterruptedException e)
        {
            throw new ConnectionInterruptedException("Error while logging in the application");
        }
        UtilFunctions.log("Login button clicked");

        SeleniumFunctions.setDriverWindowHandleMap(driver);
    }


    /**
     * ***********************************************************************
     * Helper function to get the process ID of a child process
     *
     * @param parentID process ID of parent process
     * @param childProcessName name of child process to find
     * @return the process ID of the child process with name matching childProcessName
     * ***********************************************************************
     */
    public String getChildProcessID(String parentID, String childProcessName) {
        try {
            Scanner scan = new Scanner(Runtime.getRuntime().exec("wmic process where (ParentProcessId=" + parentID + ") get Caption,ProcessId").getInputStream());
            scan.useDelimiter("\\A");
            String childProcessIds = scan.hasNext() ? scan.next() : "";
            String[] stringTokens = childProcessIds.split("\\s+");
            for (int i = 0; i < stringTokens.length; i = i + 2) {
                if (childProcessName.equalsIgnoreCase(stringTokens[i])) {
                    scan.close();
                    return stringTokens[i + 1];
                }
            }
            scan.close();
            UtilFunctions.log("No child process " + childProcessName + " found for parent process " + parentID + ".");
            return "";
        } catch (Exception e) {
            e.printStackTrace();
            UtilFunctions.log("Error getting child PID for " + childProcessName + " from parent process " + parentID + ". " + e.getMessage());
            return "";
        }
    }
}