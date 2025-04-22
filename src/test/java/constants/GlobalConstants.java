package constants;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.json.simple.JSONObject;
import utils.UtilProperty;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Random;

/**
 * Created by PatientKeeper on 6/27/2016.
 */

/******************************************************************************
 Class Name: GlobalConstants
 Contains constants used across the project
 ******************************************************************************/

public class GlobalConstants {
    //Elements
    public static JSONObject jsonObjGlobalElements;
    public static JSONObject jsonObjLoginElements;
    public static JSONObject jsonObjAdminElements;
    public static JSONObject jsonObjPatientListElements;
    public static JSONObject jsonObjPatientListV2Elements;
    public static JSONObject jsonObjFormsElements;
    public static JSONObject jsonObjChargesElements;
    public static JSONObject jsonObjPreferencesElements;
    public static JSONObject jsonObjPatientSearchElements;
    public static JSONObject jsonObjAssignmentElements;
    public static JSONObject jsonObjPatientSummaryElements;
    public static JSONObject jsonObjInboxElements;
    public static JSONObject jsonObjProviderDirectoryElements;
    public static JSONObject jsonObjScheduleElements;
    public static JSONObject jsonObjNoteSearchElements;
    //Queries
    public static JSONObject jsonObjPatientListQueries;
    public static JSONObject jsonObjPatientListV2Queries;
    public static JSONObject jsonObjGlobalQueries;

    static int randomNum = (new Random().nextInt(89999)) + 10000;
    public static HashMap<String, String> tempUser = new HashMap<String, String>() {{
        put("FirstName", "Verve" + randomNum);
        put("LastName", "Test");
        put("Username", "testcreateuser" + randomNum);
        put("Password", "123");
    }};

    private static Logger log;
    public static String frameValue = "";


    public static String startTime;
    public static String endTime;

    public static String mobilizerTag;
    public static String mobilizerVersion;


    public static int ONE = 1;
    public static int TWO = 2;
    public static int FIVE = 5;
    public static int TEN = 10;
    public static int FIFTEEN = 15;
    public static int TWENTY = 20;
    public static int THIRTY = 30;
    public static int SIXTY = 60;

    public static int LONG_TIMEOUT = TEN;

    public static String webDriverProcessId = "";
    public static String browserProcessId = "";


    /**************************************************************************
     * name: setGlobalFrameValue(String value)
     * functionality: Initialize global frameValue with current frame value
     * param: String value - Current frame value
     * return: void
     *************************************************************************/
    public static void setGlobalFrameValue(String value){
        frameValue = value;
    }


    /**************************************************************************
     * name: getGlobalFrameValue()
     * return: returns the global frameValue
     *************************************************************************/
    public static String getGlobalFrameValue(){
        return frameValue;
    }


    public static void setStartTime() {
        Date date = new Date();
        GlobalConstants.startTime = new SimpleDateFormat("HH:mm").format(date);
    }


    public static void setEndTime() {
        Date date = new Date();
        GlobalConstants.endTime = new SimpleDateFormat("HH:mm").format(date);
    }


    /**************************************************************************
     * name: getLogger()
     * functionality: Get Logger class object for logging
     * return: logger object
     *************************************************************************/
    public static Logger getLogger(){
        if (log == null){
            SimpleDateFormat dateFormat = new SimpleDateFormat("MM-dd-yyyy-hh-mm-ss");
            System.setProperty("current.date.time", dateFormat.format(new Date()));
            PropertyConfigurator.configure(UtilProperty.sMainDir + "\\log4j.properties");
            log = Logger.getLogger("rootLogger");
        }
        return log;
    }
}
