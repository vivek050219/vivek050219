package features;

 /*
 * Created by PatientKeeper on 6/21/2016.
 */

import constants.GlobalConstants;
import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import infra.setUp.*;
import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.runner.RunWith;
import utils.UtilFunctions;
import utils.UtilProperty;
import java.io.IOException;

/******************************************************************************
 Class Name: CukesRunnerTest
 Cucumber - JUnit Runner Class
 ******************************************************************************/

//To execute through command line, use: mvn test -Dcucumber.options="--tags @CodeEdits"
//OR
//To execute through command line, use: mvn -D"cucumber.options=--tags @CodeEdits" test

@RunWith(Cucumber.class)
@CucumberOptions(features={"src/test/resources/feature/"}, format = {"json:Reports/cucumber.json", "model.Report"},
 tags={"@Ver"}) //, tags={"@LoginTest"}
public class CukesRunnerTest {

    @BeforeClass
    public static void setUp() {

        if (!UtilProperty.sectionName.contains("REST"))
            UtilFunctions.setMobVersionAndTag();
        else
            UtilFunctions.setRESTMobVersionAndTag();

        UtilFunctions.deleteLogFiles();

        //Disable popup blocker for IE via registry edit
        if (UtilProperty.browserType.contains("ie")) {
            try {
                Runtime.getRuntime().exec("REG ADD \"HKEY_CURRENT_USER\\Software\\Microsoft\\Internet Explorer\\New Windows\" /F /V \"PopupMgr\" /T REG_DWORD /D \"0\"");
            } catch (Exception e) {
                System.out.println("Error occurred when attempting to disable popup blocker for Internet Explorer");
            }
        }

        switch(UtilProperty.tagName){
            case "CodeEdits":
                UtilFunctions.log("In Set up section. Performing setUp for tag: " + UtilProperty.tagName);
                CodeEdits.initialize();
                break;
            case "CodeEditPreferences":
                UtilFunctions.log("In Set up section. Performing setUp for tag: " + UtilProperty.tagName);
                CodeEditPreferences.initialize();
                break;
            case "savecharge":
                UtilFunctions.log("In Set up section. Performing setUp for tag: " + UtilProperty.tagName);
                //setUp
                break;
            case "PatientSafety":
                UtilFunctions.log("In Set up section. Performing setUp for tag: " + UtilProperty.tagName);
                //setUp
                break;
            case "Performance":
                UtilFunctions.log("In Set up section. Performing setUp for tag: " + UtilProperty.tagName);
                Performance.initialize();
                break;
            case "PasswordTest":
                UtilFunctions.log("In Set up section. Performing setUp for tag: " + UtilProperty.tagName);
                PasswordTest.initialize();
                break;
            case "PatientListV2":
                UtilFunctions.log("In Set up section. Performing setUp for tag: " + UtilProperty.tagName);
                PatientListV2.initialize();
                break;
            case "PhotoFeature":
                UtilFunctions.log("In Set up section. Performing setUp for tag: " + UtilProperty.tagName);
                PhotoFeature.initialize();
                break;
            case "PatientChargeStatus":
                UtilFunctions.log("In Set up section. Performing setUp for tag: " + UtilProperty.tagName);
                PatientChargeStatus.initialize();
                break;
            case "CPOEMicro":
                UtilFunctions.log("In Set up section. Performing setUp for tag: " + UtilProperty.tagName);
                CPOEMicro.initialize();
                break;
            case "CombinationCodeEdits":
                UtilFunctions.log("In clean up section. Performing tearDown for tag: " + UtilProperty.tagName);
                CombinationCodeedits.deInitialize();
                break;
            default:
                UtilFunctions.log("In default section of setUp. No setUp file required!");
                break;
        }

        GlobalConstants.setStartTime();
    }

    @AfterClass
    public static void cleanUp() throws IOException {
        //Driver may be null if the previous test failed, meaning the browser has already been closed.
        if(!(Hooks.getDriver() == null)){
            Hooks.closeBrowser();
        }
        switch(UtilProperty.tagName){
            case "CodeEditPreferences":
                UtilFunctions.log("In clean up section. Performing tearDown for tag: " + UtilProperty.tagName);
                CodeEditPreferences.deInitialize();
                break;
            case "Performance":
                UtilFunctions.log("In clean up section. Performing tearDown for tag: " + UtilProperty.tagName);
                Performance.deInitialize();
                break;
            case "PasswordTest":
                UtilFunctions.log("In clean up section. Performing tearDown for tag: " + UtilProperty.tagName);
                PasswordTest.deInitialize();
                break;
            case "CPOEMicro":
                UtilFunctions.log("In clean up section. Performing tearDown for tag: " + UtilProperty.tagName);
                CPOEMicro.deInitialize();
                break;
            case "CodeEdits":
                UtilFunctions.log("In clean up section. Performing tearDown for tag: " + UtilProperty.tagName);
                CodeEdits.deInitialize();
                break;
            case "CombinationCodeEdits":
                UtilFunctions.log("In clean up section. Performing tearDown for tag: " + UtilProperty.tagName);
                CombinationCodeedits.deInitialize();
                break;
            default:
                UtilFunctions.log("In default section of cleanUp. No cleanUp file required!");
                break;
        }
    }
}
