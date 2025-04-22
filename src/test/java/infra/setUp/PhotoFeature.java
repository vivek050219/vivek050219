package infra.setUp;

import common.SeleniumFunctions;
import cucumber.api.DataTable;
import features.Hooks;
import features.step_definitions.GlobalStepdefs;
import features.step_definitions.PatientListV2Stepdefs;
import pageObject.AdminPage;
import support.NavBar;
import support.Page;
import utils.UtilFunctions;
import utils.UtilProperty;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

public class PhotoFeature {

    public String className = getClass().getSimpleName();
    private static PhotoFeature photoFeature = new PhotoFeature();

    private static List<HashMap<String, String>> userList = new ArrayList<>();

    public static void initialize() {
        UtilFunctions.log("Class: " + photoFeature.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        try {
            Hooks.openBrowser(UtilProperty.userName, null);

            //Setup users
            userList.add(new HashMap<String, String>() {{
                put("firstName", "PHOTO");
                put("lastName", "CHSORTTEST");
                put("userName", "PhotoSort1");
            }});
            userList.add(new HashMap<String, String>() {{
                put("firstName", "PHOTO");
                put("lastName", "CKSORTTEST");
                put("userName", "PhotoSort2");
            }});
            userList.add(new HashMap<String, String>() {{
                put("firstName", "PHOTO");
                put("lastName", "JKSORTTEST");
                put("userName", "PhotoSort3");
            }});
            userList.add(new HashMap<String, String>() {{
                put("firstName", "PHOTO");
                put("lastName", "JKSORTTEST");
                put("userName", "PhotoSort3");
            }});
            userList.add(new HashMap<String, String>() {{
                put("firstName", "VERVE");
                put("lastName", "1DEPT6NOFAC");
                put("userName", "Verve1Dept6NoFac");
            }});

            NavBar.selectNavigationTab(Hooks.getDriver(), "Admin", "");
            NavBar.selectNavigationTab(Hooks.getDriver(), "Admin", "User");
            for (HashMap<String, String> userMap : userList) {
                if (!AdminPage.userExists(Hooks.getDriver(), userMap.get("userName"))) {
                    Page.clickButton(Hooks.getDriver(), "Admin", "CreateUser");
                    Page.setTextBox(Hooks.getDriver(), "Admin", userMap.get("firstName"), "FirstName");
                    Page.setTextBox(Hooks.getDriver(), "Admin", userMap.get("lastName"), "LastName");
                    Page.setTextBox(Hooks.getDriver(), "Admin", userMap.get("userName"), "Username");
                    Page.clickButton(Hooks.getDriver(), "Admin", "CreateUserSave");
                    SeleniumFunctions.selectFrame(Hooks.getDriver(), UtilFunctions.getJSONValueBasedOnTabTypeAndSearchName("Admin", "", "", "", "FRAME_DIALOG", ""), "id");
                    //TODO: Configure users to use PLv2
                }
            }

            //TODO: Setup department for Verve1Dept6NoFac

            //Create Photo Test plv2 lists if they don't already exist.
            GlobalStepdefs globalStepdefs = new GlobalStepdefs();
            globalStepdefs.selectTab("Patient List V2");
            List<List<String>> dataList = Arrays.asList(Arrays.asList("Type", "Name", "Value"), Arrays.asList("Filter", "Medical Service", "Card Group"));
            DataTable dataTable = DataTable.create(dataList);
            PatientListV2Stepdefs stepDefs = new PatientListV2Stepdefs();
            stepDefs.createPatientListWithAPI("Photo Test", "pkadminv2", dataTable);
            stepDefs.createPatientListWithAPI("Photo Test", "PhotoSort1", dataTable);
            stepDefs.createPatientListWithAPI("Photo Test", "PhotoSort2", dataTable);
            stepDefs.createPatientListWithAPI("Photo Test", "PhotoSort3", dataTable);
            stepDefs.createPatientListWithAPI("Photo Test", "Verve1Dept3FacB", dataTable);
            stepDefs.createPatientListWithAPI("Photo Test", "Verve1Dept6NoFac", dataTable);
            stepDefs.createPatientListWithAPI("Photo Test", "Verve1Dept2FacA", dataTable);
            stepDefs.createPatientListWithAPI("Photo Test", "Verve2Dept1FacA", dataTable);
            stepDefs.createPatientListWithAPI("Photo Test", "Verve1Dept1FacA", dataTable);
            Hooks.closeBrowser();
            UtilFunctions.log("Photo Test patient list ready for use.");
        } catch (Exception e) {
            UtilFunctions.log("Failed to create Photo Test patient list. Reason for exception: " + e.getMessage());
        } catch (Throwable throwable) {
            UtilFunctions.log("Failed to create Photo Test patient list. Reason for exception: " + throwable.getMessage());
        }
    }
}