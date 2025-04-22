package utils;

import common.SeleniumFunctions;
import constants.GlobalConstants;
import features.step_definitions.GlobalStepdefs;
import frames.*;
import io.github.bonigarcia.wdm.WebDriverManager;
import org.ini4j.Ini;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.edge.EdgeDriver;
import org.openqa.selenium.edge.EdgeOptions;
import org.openqa.selenium.ie.InternetExplorerDriver;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Clob;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.TimeUnit;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by PatientKeeper on 6/21/2016.
 */

/******************************************************************************
 Class Name: UtilFunctions
 Contains util functions
 ******************************************************************************/

public class UtilFunctions {

    public String className = getClass().getSimpleName();
    private static UtilFunctions utilFunctions = new UtilFunctions();


    /**************************************************************************
     * name: getElementFromJSONFile(JSONObject jsonObj, String searchID,
     * String reqField)
     * functionality: Function to fetch value from json file
     * param: JSONObject jsonObj - JSON file object
     * param: String searchID - Name of element
     * param: String reqField - Type of field such as path, name, id, etc.
     * return: value from json file, null if not found
     *************************************************************************/
    public static String getElementFromJSONFile(JSONObject jsonObj, String searchID, String reqField){
        UtilFunctions.log("Class: " + utilFunctions.className + "; Method: " + new Object(){}.getClass().getEnclosingMethod().getName());

        //TODO: Clean up redundant code
        String result = null;
        //Try to find element definition within json sub-section
        try {
            if (GlobalStepdefs.subSection != "") {
                JSONObject subSectionObj = (JSONObject) jsonObj.get(GlobalStepdefs.subSection);
                if (searchID.contains(".") && reqField != "") {
                    String[] searchIDArr = searchID.split("\\.");
                    JSONObject childObj = (JSONObject) subSectionObj.get(searchIDArr[0]);
                    JSONObject childObj1 = (JSONObject) childObj.get(searchIDArr[1]);
                    UtilFunctions.log("Return: " + childObj1.get(reqField));
                    result = (String) childObj1.get(reqField);
                } else if (searchID.contains(".") && reqField == "") {
                    String[] searchIDArr = searchID.split("\\.");
                    JSONObject childObj = (JSONObject) subSectionObj.get(searchIDArr[0]);
                    if (childObj.get(searchIDArr[1]) != null) {
                        UtilFunctions.log("Return: " + childObj.get(searchIDArr[1]));
                        result = (String) childObj.get(searchIDArr[1]);
                    }
                } else {
                    UtilFunctions.log("Return: " + jsonObj.get(searchID));
                    result = (String) subSectionObj.get(searchID);
                }
                if (result != null) {
                    return result;
                }
            }
        }
        catch (Exception e){
            //Swallow errors.  This block will often throw an NPE, which is confusing and can be safely ignored
        }

        //If element not found in json sub-section, try to find element in main json
        try {
            if (searchID.contains(".") && reqField != "") {
                String[] searchIDArr = searchID.split("\\.");
                JSONObject childObj = (JSONObject) jsonObj.get(searchIDArr[0]);
                JSONObject childObj1 = (JSONObject) childObj.get(searchIDArr[1]);
                UtilFunctions.log("Return: " + childObj1.get(reqField));
                result = (String) childObj1.get(reqField);
            } else if (searchID.contains(".") && reqField == "") {
                String[] searchIDArr = searchID.split("\\.");
                JSONObject childObj = (JSONObject) jsonObj.get(searchIDArr[0]);
                if (childObj.get(searchIDArr[1]) == null) {
                    UtilFunctions.log("Return: null");
                    return null;
                }
                else {
                    UtilFunctions.log("Return: " + childObj.get(searchIDArr[1]));
                    result = (String) childObj.get(searchIDArr[1]);
                }
            } else {
                UtilFunctions.log("Return: " + jsonObj.get(searchID));
                result = (String) jsonObj.get(searchID);
            }
            if (result != null) {
                return result;
            }
        }
        catch (Exception e){
            //Swallow errors.  Still need to check Global elements
        }

        //If element still not found, check if element is available in Global elements
        try {
            if (searchID.contains(".") && reqField != "") {
                String[] searchIDArr = searchID.split("\\.");
                JSONObject childObj = (JSONObject) GlobalConstants.jsonObjGlobalElements.get(searchIDArr[0]);
                JSONObject childObj1 = (JSONObject) childObj.get(searchIDArr[1]);
                UtilFunctions.log("Return: " + childObj1.get(reqField));
                result = (String) childObj1.get(reqField);
            } else if (searchID.contains(".") && reqField == "") {
                String[] searchIDArr = searchID.split("\\.");
                JSONObject childObj = (JSONObject) GlobalConstants.jsonObjGlobalElements.get(searchIDArr[0]);
                if (childObj.get(searchIDArr[1]) == null) {
                    UtilFunctions.log("Return: null");
                    return null;
                }
                else {
                    UtilFunctions.log("Return: " + childObj.get(searchIDArr[1]));
                    result = (String) childObj.get(searchIDArr[1]);
                }
            } else {
                UtilFunctions.log("Return: " + jsonObj.get(searchID));
                result = (String) jsonObj.get(searchID);
            }
            return result;
        }
        catch (Exception e){
            e.printStackTrace();
            UtilFunctions.log("Exception: " + e.getMessage());
            return null;
        }
    }


    /**************************************************************************
     * name: getNestedElementObjectFromJSONFile(JSONObject jsonObj,
     * String searchID, String reqField)
     * functionality: Function to fetch nested element object from json object
     * param: JSONObject jsonObj - JSON file object
     * param: String searchID - Name of element
     * param: String reqField - Type of field such as path, name, id, etc.
     * return: object
     *************************************************************************/
    public static Object getNestedElementObjectFromJSONFile(JSONObject jsonObj, String searchID, String reqField){
        UtilFunctions.log("Class: " + utilFunctions.className + "; Method: " + new Object(){}.getClass().getEnclosingMethod().getName());
        try {
            if (searchID.contains(".") && reqField != "") {
                String[] searchIDArr = searchID.split("\\.");
                JSONObject childObj = (JSONObject) jsonObj.get(searchIDArr[0]);
                JSONObject childObj1 = (JSONObject) childObj.get(searchIDArr[1]);
                UtilFunctions.log("Return: " + childObj1.get(reqField));
                return childObj1.get(reqField);
            } else if (searchID.contains(".") && reqField == "") {
                String[] searchIDArr = searchID.split("\\.");
                JSONObject childObj = (JSONObject) jsonObj.get(searchIDArr[0]);
                if (childObj.get(searchIDArr[1]) == null) {
                    UtilFunctions.log("Return: null");
                    return null;
                }
                else {
                    UtilFunctions.log("Return: " + childObj.get(searchIDArr[1]));
                    return childObj;
                }
            } else {
                UtilFunctions.log("Return: " + jsonObj.get(searchID));
                return jsonObj;
            }
        }
        catch (Exception e){
            e.printStackTrace();
            UtilFunctions.log("Exception: " + e.getMessage());
            return null;
        }
    }


    /**************************************************************************
     * name: getElementFromJSONFile(JSONObject jsonObj, String searchID,
     * String reqField)
     * functionality: Function to fetch value from json file
     * param: JSONObject jsonObj - JSON file object
     * param: String searchID - Name of element
     * param: String reqField - Type of field such as path, name, id, etc.
     * return: value from json file
     *************************************************************************/
    public static JSONObject getJSONFileObjBasedOnTabName(String tabName){
        UtilFunctions.log("Class: " + utilFunctions.className + "; Method: " + new Object(){}.getClass().getEnclosingMethod().getName());
        switch (tabName){
            case "NoteSearch":
                return GlobalConstants.jsonObjNoteSearchElements;
            case "Admin":
                return GlobalConstants.jsonObjAdminElements;
            case "Login":
                return GlobalConstants.jsonObjLoginElements;
            case "PatientList":
                return GlobalConstants.jsonObjPatientListElements;
            case "PatientListV2":
                return GlobalConstants.jsonObjPatientListV2Elements;
            case "Forms":
                return GlobalConstants.jsonObjFormsElements;
            case "Charges":
                return GlobalConstants.jsonObjChargesElements;
            case "Preferences":
                return GlobalConstants.jsonObjPreferencesElements;
            case "PatientSearch":
                return GlobalConstants.jsonObjPatientSearchElements;
            case "Assignment":
                return GlobalConstants.jsonObjAssignmentElements;
            case "PatientSummary":
                return GlobalConstants.jsonObjPatientSummaryElements;
            case "Inbox":
                return GlobalConstants.jsonObjInboxElements;
            case "ProviderDirectory":
                return GlobalConstants.jsonObjProviderDirectoryElements;
            case "Schedule":
                return GlobalConstants.jsonObjScheduleElements;
            default:
                return GlobalConstants.jsonObjGlobalElements;
        }
    }


    /**************************************************************************
     * name: getJSONFileObjForQueriesBasedOnTabName(String tabName)
     * functionality: Function to queries json file object
     * param: String tabName - Tab name to get json file object
     * return: json file object
     *************************************************************************/
    public static JSONObject getJSONFileObjForQueriesBasedOnTabName(String tabName){
        UtilFunctions.log("Class: " + utilFunctions.className + "; Method: " + new Object(){}.getClass().getEnclosingMethod().getName());
        switch (tabName){
            case "PatientList":
                return  GlobalConstants.jsonObjPatientListQueries;
            case "PatientListV2":
                return  GlobalConstants.jsonObjPatientListV2Queries;
            default:
                return GlobalConstants.jsonObjGlobalQueries;
        }
    }


    /**************************************************************************
     * name: mergeJsonObjects(JSONObject source, JSONObject target)
     * functionality: Recursively merge two json objects
     * param: JSONObject source - The source file to be merged into target.
     * param: JSONObject target - The target file to be merged into.
     * return: json file object
     *************************************************************************/
    public static JSONObject mergeJsonObjects(JSONObject source, JSONObject target) {
        for (Object key : source.keySet()) {
            Object value = source.get(key);
            if (target.get(key) == null) {
                //New value for key, add to target
                target.put(key, value);
            } else {
                //Value for key exists in target, recursively merge child-keys
                if (value instanceof JSONObject) {
                    JSONObject valueJson = (JSONObject) value;
                    mergeJsonObjects(valueJson, (JSONObject) target.get(key));
                }
            }
        }
        return target;
    }


    /**************************************************************************
     * name: getFrameMapBasedOnTabName(String tabName)
     * functionality: Function to fetch frame map object
     * param: String tabName - Name of tab
     * return: frame hashmap
     *************************************************************************/
    public static HashMap getFrameMapBasedOnTabName(String tabName){
        UtilFunctions.log("Class: " + utilFunctions.className + "; Method: " + new Object(){}.getClass().getEnclosingMethod().getName());
        switch (tabName){
            case "NoteSearch":
                return NoteSearch_Frames.noteSearchFramesMap;
            case "Admin":
                return Admin_Frames.adminFramesMap;
            case "Global":
                return Global_Frames.globalFramesMap;
            case "PatientList":
                return PatientList_Frames.patientListFramesMap;
            case "PatientListV2":
                return PatientListV2_Frames.patientListV2FramesMap;
            case "Forms":
                return Forms_Frames.formsFramesMap;
            case "Charges":
                return Charges_Frames.chargesFramesMap;
            case "Preferences":
                return Preferences_Frames.preferencesFramesMap;
            case "PatientSearch":
                return PatientSearch_Frames.patientSearchFramesMap;
            case "Assignment":
                return Assignment_Frames.assignmentFramesMap;
            case "PatientSummary":
                return PatientSummary_Frames.patientSummaryFramesMap;
            case "Inbox":
                return Inbox_Frames.inboxFramesMap;
            case "ProviderDirectory":
                return ProviderDirectory_Frames.providerDirectoryFramesMap;
            case "Schedule":
                return Schedule_Frames.scheduleFramesMap;

            default:
                return Global_Frames.globalFramesMap;
        }
    }


    /**************************************************************************
     * name: getElementStringAndType(JSONObject jsonObj, String searchID)
     * functionality: Function to fetch value from json file if search method
     * is not known
     * param: JSONObject jsonObj - JSON file object
     * param: String searchID - Name of element
     * return: value array from json file
     *************************************************************************/
    public static String[] getElementStringAndType(JSONObject jsonObj, String searchID) {
        UtilFunctions.log("Class: " + utilFunctions.className + "; Method: " + new Object(){}.getClass().getEnclosingMethod().getName());
        String[] retArr = new String[2];
        if (getElementFromJSONFile(jsonObj, searchID, "path") != null) {
            retArr[0] = getElementFromJSONFile(jsonObj, searchID, "path");
            retArr[1] = "xpath";
            UtilFunctions.log("xpath present");
            return retArr;
        }
        else if (getElementFromJSONFile(jsonObj, searchID, "id") != null) {
            retArr[0] = getElementFromJSONFile(jsonObj, searchID, "id");
            retArr[1] = "id";
            UtilFunctions.log("id present");
            return retArr;
        }
        else if (getElementFromJSONFile(jsonObj, searchID, "name") != null){
            retArr[0] = getElementFromJSONFile(jsonObj, searchID, "name");
            retArr[1] = "name";
            UtilFunctions.log("name present");
            return retArr;
        }
        if (getElementFromJSONFile(jsonObj, searchID, "barexpath") != null) {
            retArr[0] = getElementFromJSONFile(jsonObj, searchID, "barexpath");
            retArr[1] = "barexpath";
            UtilFunctions.log("barexpath present");
            return retArr;
        }
        else {
            UtilFunctions.log("Unknown Element Type");
            return retArr;
        }
    }


    /**************************************************************************
     * name: reformName(String patientName)
     * functionality: Function to reform patient name
     * param: String patientName - Name of patient
     * return: returns reformed patient name
     *************************************************************************/
    public static String reformName(String patientName) {
        UtilFunctions.log("Class: " + utilFunctions.className + "; Method: " + new Object(){}.getClass().getEnclosingMethod().getName());
        //Assume patient name is in correct format if it contains a ","
        if (patientName.indexOf(",") == -1){
            try {
                String[] patientNameArr = patientName.split(" ");
                UtilFunctions.log("Reformed Name: " + patientNameArr[1] + ", " + patientNameArr[0]);
                return patientNameArr[1] + ", " + patientNameArr[0];
            }
            catch (Exception e){
                UtilFunctions.log("Patient Name not proper: " + patientName);
                return patientName;
            }
        }
        UtilFunctions.log("Patient Name already in correct format: " + patientName);
        return patientName;
    }


    /**************************************************************************
     * name: getTableValues(String tabName, String tableName)
     * functionality: Function to fetch table values from json file
     * param: String tabName - Name of tab
     * param: String tableName - Name of table
     * return: returns array of table values
     *************************************************************************/
    public static String[] getTableValues(String tabName, String tableName){
        UtilFunctions.log("Class: " + utilFunctions.className + "; Method: " + new Object(){}.getClass().getEnclosingMethod().getName());
        String[] tableDetailArr = new String[10];
        tabName = tabName.replace(" ", "");
        tableName = tableName.replace(" ", "");
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        try {
            tableDetailArr[0] = UtilFunctions.getElementFromJSONFile(fileObj, "TABLES." + tableName, "path"); //tablePath
            tableDetailArr[1] = UtilFunctions.getElementFromJSONFile(fileObj, "TABLES." + tableName, "id"); //tableId
            tableDetailArr[2] = UtilFunctions.getElementFromJSONFile(fileObj, "TABLES." + tableName, "head"); //tableHead
            tableDetailArr[3] = UtilFunctions.getElementFromJSONFile(fileObj, "TABLES." + tableName, "body"); //tableBody
            tableDetailArr[4] = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "TABLES." + tableName, "frame")); //paneFrames
        }
        catch (Exception e){
            e.printStackTrace();
            UtilFunctions.log("Exception: " + e.getMessage());
        }
        return tableDetailArr;
    }


    /**************************************************************************
     * name: getFrameValue(HashMap frameMap, String frameName)
     * functionality: Function to fetch frame value from frame map
     * param: HashMap frameMap - HashMap of frame
     * param: String frameName - Name of frame
     * return: returns frame value
     *************************************************************************/
    public static String getFrameValue(HashMap frameMap, String frameName) {
        UtilFunctions.log("Class: " + utilFunctions.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        String frameValue = "";
        frameValue = (String) frameMap.get(frameName);

        if (frameValue == null)
            frameValue = Global_Frames.globalFramesMap.get(frameName);

        UtilFunctions.log("FrameValue: " + frameValue);

        return frameValue;
    }


    /**************************************************************************
     * Convert parts of a string wrapped in % characters to specified format
     *
     * @param value the string to parse and convert
     * @return string
     *************************************************************************/
    public static String convertThruRegEx(String value){
        UtilFunctions.log("Class: " + utilFunctions.className + "; Method: " + new Object(){}.getClass().getEnclosingMethod().getName());
        Pattern pattern = Pattern.compile("%(.*?)%");
        Matcher matcher = pattern.matcher(value);
        while (matcher.find()) {
            String token = matcher.group();
            if (token.equals("%Current Date MMDDYYYY%")){
                Date date = new Date(System.currentTimeMillis());
                SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");
                value = value.replaceFirst(token, formatter.format(date));
            }
            else if (token.equals("%Current Date MMDDYY%")){
                Date date = new Date(System.currentTimeMillis());
                SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yy");
                value = value.replaceFirst(token, formatter.format(date));
            }
            else if (token.equals("%Current Date MMMMDDYYYY%")){
                Date date = new Date(System.currentTimeMillis());
                SimpleDateFormat formatter = new SimpleDateFormat("MMMM/dd/yyyy");
                value = value.replaceFirst(token, formatter.format(date));
            }
            else if (token.equals("%Current Date%")){
                java.util.Date date = new Date();
                Calendar calendar = Calendar.getInstance();
                calendar.setTime(date);
                value = value.replaceFirst(token, new SimpleDateFormat("MM/dd").format(date));
            }
            else if (token.equals("%Current Time%")){
                java.util.Date date = new Date();
                Calendar calendar = Calendar.getInstance();
                calendar.setTime(date);
                value = value.replaceFirst(token, new SimpleDateFormat("HHmmss").format(date));
            }
            else if (token.equals("%Current Time HHMM%")){
                java.util.Date date = new Date();
                Calendar calendar = Calendar.getInstance();
                calendar.setTime(date);
                value = value.replaceFirst(token, new SimpleDateFormat("HH:mm").format(date));
            }
            else if (token.matches("%calcYear:(\\d+)\\/(\\d+)\\/(\\d+)%")){
                java.util.Date date = new Date();
                Calendar calendar = Calendar.getInstance();
                calendar.setTime(date);
                String[] dayArr = token.replace("%","").split(":");

                SimpleDateFormat myFormat = new SimpleDateFormat("MM/dd/yyyy");
                String startDate = dayArr[1];
                String currDate = new SimpleDateFormat("MM/dd/yyyy").format(date);
                Date d1 = null;
                Date d2 = null;
                try {
                    d1 = myFormat.parse(startDate);
                    d2 = myFormat.parse(currDate);
                    //Making this a double due to size of number, still will come out in scientific notation is so big
                    double diff = d2.getTime() - d1.getTime();

                    //MILLISECONDS_IN_YEAR = (MILLIS_IN_SECOND -> 1000 * SECONDS_IN_MINUTE -> 60 * MINUTES_IN_HOUR -> 60 * HOURS_IN_DAY -> 24 * DAYS_IN_YEAR -> 365)
                    //Days in a year is more accurate at 365.25
                    double MILLISECONDS_IN_YEAR = 1000*60*60*24*365.25;
                    //Cast this to an Int to get the floor of the value
                    value = String.valueOf((int)(diff / MILLISECONDS_IN_YEAR));
                    System.out.println(value);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            else if (token.matches("%calcLOSDate date:(\\d+)\\/(\\d+)\\/(\\d+) time:(\\d+):(\\d+)%")){
                java.util.Date date = new Date();
                Calendar calendar = Calendar.getInstance();
                calendar.setTime(date);
                String[] arr = token.replace("%","").split(":", 3);
                String[] dayArr = arr[1].split(" ");
                String startTime = arr[2];

                SimpleDateFormat myFormat = new SimpleDateFormat("MM/dd/yyyy");
                String startDate = dayArr[0];
                String currDate = new SimpleDateFormat("MM/dd/yyyy").format(date);
                Date d1 = null;
                Date d2 = null;
                try {
                    d1 = myFormat.parse(startDate);
                    d2 = myFormat.parse(currDate);
                    long diff = d2.getTime() - d1.getTime();

                    //MILLISECONDS_IN_DAYS = (MILLIS_IN_SECOND -> 1000 * SECONDS_IN_MINUTE -> 60 * MINUTES_IN_HOUR -> 60 * HOURS_IN_DAY -> 24)
                    long MILLISECONDS_IN_DAYS = (long)1000*60*60*24;
                    String differenceInDays = String.valueOf(diff / MILLISECONDS_IN_DAYS);
                    if(Integer.valueOf(differenceInDays) > 1){
                        value = differenceInDays + "D";
                    }
                    else if(Integer.valueOf(differenceInDays) > 0){
                        value = "0.0d";
                    }
                    else {
                        int temp = 1 % Integer.valueOf(differenceInDays);
                        temp = temp * 24;
                        value = String.valueOf(temp) + "h";
                    }
                    System.out.println(value);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            else if (token.matches("%calcLOS daysAgo:(\\d+) time:(\\d+)%")){
                java.util.Date date = new Date();
                Date currentDate = new Date();
                Calendar calendar = Calendar.getInstance();
                calendar.setTime(date);
                calendar.set(Calendar.HOUR_OF_DAY, 0);
                calendar.set(Calendar.MINUTE, 0);
                calendar.set(Calendar.SECOND, 0);
                calendar.set(Calendar.MILLISECOND, 0);
                date.setTime(calendar.getTime().getTime());

                String[] arr = token.replace("%","").split(":", 3);
                String daysAgo = arr[1].split(" ")[0].trim();
                String startTime = arr[2];

                //Date currentDate = new Date();
                Date dateBefore = new Date(date.getTime() + TimeUnit.HOURS.toMillis(Integer.parseInt(startTime)));
                dateBefore = new Date(dateBefore.getTime() - Long.parseLong(daysAgo) * 24 * 3600 * 1000);

                try {
                    double diff = currentDate.getTime() - dateBefore.getTime();
                    //MILLISECONDS_IN_DAYS = (MILLIS_IN_SECOND -> 1000 * SECONDS_IN_MINUTE -> 60 * MINUTES_IN_HOUR -> 60 * HOURS_IN_DAY -> 24)
                    long MILLISECONDS_IN_DAYS = (long)1000*60*60*24;
                    double differenceInDays = diff / MILLISECONDS_IN_DAYS;
                    if(differenceInDays >= 1){
                        value = (int)Math.round(differenceInDays) + "d";
                    }
                    else if(differenceInDays == 0){
                        value = "0.0d";
                    }
                    else {
                        double temp = differenceInDays % 1;
                        temp = temp * 24;
                        log("temp*24 = temp:" + ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> " + temp + " <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");

                        //Do not round-off if 2nd decimal digit is 5 (Ex: if 1.25, O/P should be 1.2, and not 1.3).
                        if (String.valueOf(temp).split("\\.")[1].toCharArray()[1] == '5'){
                            value = String.valueOf(Double.valueOf(String.format("%.1f", temp)) - 0.1);
                        }
                        else
                            value = String.format("%.1f", temp);

                        //value = String.format("%.1f", temp);
//                        DecimalFormat df = new DecimalFormat("#.#");
//                        value = df.format(temp);
                        if (!value.contains("."))
                            value = value + ".0";
                        value = value + "h";
                        log("Formatted hour value:" + ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> " + value + " <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
                    }
                    System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> " + value + " <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            else if (token.contains("day ago MMDDYYYY") ||
                    token.contains("days ago MMDDYYYY")){
                String[] dayArr = token.replace("%","").split(" ");
                int dayNo = Integer.parseInt(dayArr[0]);
                Calendar calendar = Calendar.getInstance(); // this would default to now
                calendar.add(Calendar.DAY_OF_MONTH, -dayNo);
                Date date = calendar.getTime();
                SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");
                value = value.replaceFirst(token, formatter.format(date));
            }
            else if (token.contains("day ago MMDDYY") ||
                     token.contains("days ago MMDDYY")){
                String[] dayArr = token.replace("%","").split(" ");
                int dayNo = Integer.parseInt(dayArr[0]);
                Calendar calendar = Calendar.getInstance(); // this would default to now
                calendar.add(Calendar.DAY_OF_MONTH, -dayNo);
                Date date = calendar.getTime();
                SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yy");
                value = value.replaceFirst(token, formatter.format(date));
            }
            else if (token.contains("day ago MMDD") ||
                    token.contains("days ago MMDD")){
                String[] dayArr = token.replace("%","").split(" ");
                int dayNo = Integer.parseInt(dayArr[0]);
                Calendar calendar = Calendar.getInstance(); // this would default to now
                calendar.add(Calendar.DAY_OF_MONTH, -dayNo);
                Date date = calendar.getTime();
                SimpleDateFormat formatter = new SimpleDateFormat("MM/dd");
                value = value.replaceFirst(token, formatter.format(date));
            }
            else if (token.contains("day from now MMDDYYYY") ||
                    token.contains("days from now MMDDYYYY")){
                String[] dayArr = token.replace("%","").split(" ");
                int dayNo = Integer.parseInt(dayArr[0]);
                Calendar calendar = Calendar.getInstance(); // this would default to now
                calendar.add(Calendar.DAY_OF_MONTH, +dayNo);
                Date date = calendar.getTime();
                SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");
                value = value.replaceFirst(token, formatter.format(date));
            }
            else if (token.contains("day from now MMDDYY") ||
                    token.contains("days from now MMDDYY")){
                String[] dayArr = token.replace("%","").split(" ");
                int dayNo = Integer.parseInt(dayArr[0]);
                Calendar calendar = Calendar.getInstance(); // this would default to now
                calendar.add(Calendar.DAY_OF_MONTH, +dayNo);
                Date date = calendar.getTime();
                SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yy");
                value = value.replaceFirst(token, formatter.format(date));
            }else if (token.contains("day from now MMMMDDYYYY") ||
                    token.contains("days from now MMMMDDYYYY")){
                String[] dayArr = token.replace("%","").split(" ");
                int dayNo = Integer.parseInt(dayArr[0]);
                Calendar calendar = Calendar.getInstance(); // this would default to now
                calendar.add(Calendar.DAY_OF_MONTH, +dayNo);
                Date date = calendar.getTime();
                SimpleDateFormat formatter = new SimpleDateFormat("MMMM/dd/yyyy");
                value = value.replaceFirst(token, formatter.format(date));
            }
            else if (token.equals("%Version%")){
                value = value.replaceFirst(token, GlobalConstants.mobilizerVersion);
            }
            else if (token.equals("%Build Tag%")){
                value = value.replaceFirst(token, GlobalConstants.mobilizerTag);
            }
            else if (token.equals("%SolrURL%")){
                value = getValueFromIniFile(UtilProperty.sectionName, "SolrURL");
            }
            else if (token.equals("%SolrSearchURL%")){
                value = getValueFromIniFile(UtilProperty.sectionName, "SolrSearchURL");
            }
        }
        UtilFunctions.log("RegEx return value: " + value);
        return value;
    }


    public static String getCompareToValuesFromRegExConvertor(String compareTo){
        if(compareTo.contains("calc")){
            List<String> temp = new ArrayList<>();
            String[] regEx = compareTo.split("%");
            List<String> wordList = Arrays.asList(regEx);
            for(String txt : wordList){
                if(txt.contains("calc")){
                    txt = "%" + txt + "%";
                    compareTo = UtilFunctions.convertThruRegEx(txt);
                    temp.add(compareTo);
                }
                if(!txt.contains("calc")){
                    temp.add(txt);
                }
            }
            compareTo = "";
            for (String tempStr : temp) {
                if (compareTo.equals(""))
                    compareTo = compareTo + tempStr;
                else
                    compareTo = compareTo + ";" + tempStr;
            }
            compareTo = compareTo.replace(";", "");
            System.out.println(compareTo);
        }
        else if (compareTo.contains("MMDD")){
            List<String> temp = new ArrayList<>();
            String[] regEx = compareTo.split("%");
            List<String> wordList = Arrays.asList(regEx);
            for(String txt : wordList){
                if(txt.contains("MMDD")){
                    txt = "%" + txt + "%";
                    compareTo = UtilFunctions.convertThruRegEx(txt);
                    temp.add(compareTo);
                }
                if(!txt.contains("MMDD") && !txt.equals("")){
                    temp.add(txt);
                }
            }
            compareTo = "";
            for (String tempStr : temp) {
                if (compareTo.equals(""))
                    compareTo = compareTo + tempStr;
                else
                    compareTo = compareTo + ";" + tempStr;
            }
            compareTo = compareTo.replace(";", "");
            System.out.println(compareTo);
        }
        if(compareTo.contains("Current") || compareTo.contains("HH") || compareTo.contains("mm")) {
            compareTo = UtilFunctions.convertThruRegEx(compareTo);
        }
        return compareTo;
    }


    /**************************************************************************
     * name: log(String logDetail)
     * functionality: Function for logging
     * param: String logDetail - String to be logged
     * return: void
     *************************************************************************/
    public static void log(String logDetail){
        try{
            GlobalConstants.getLogger().info(logDetail);
        }
        catch (Exception e){
            GlobalConstants.getLogger().info("Exception while logging. Exception message: " + e.getMessage());
        }
    }


    /**************************************************************************
     * name: getValueFromTextFile(String valueToRead)
     * functionality: Get value as stored in text file
     * param: String valueToRead - Value to read
     * return: returns value from text file in String format
     *************************************************************************/
    public static String getValueFromTextFile(String valueToRead){
        UtilFunctions.log("Class: " + utilFunctions.className + "; Method: " + new Object(){}.getClass().getEnclosingMethod().getName());
        try (BufferedReader br = new BufferedReader(new FileReader(UtilProperty.setUpFile))) {
            String line;
            while ((line = br.readLine()) != null) {
                if (line.contains(valueToRead)){
                    UtilFunctions.log("Value to read: " + valueToRead);
                    String value = br.readLine();
                    if (value.equals("") || value == null)
                        break;
                    else
                        return value;
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
            UtilFunctions.log("File or value not present.");
        }
        if (valueToRead.contains("SECTION"))
            return "DEFAULT";
        else if (valueToRead.contains("APP"))
            return "chrome";
        else
            return "";
    }


    /**************************************************************************
     * name: getValueFromIniFile(String section, String key)
     * functionality: Get value stored in ini file
     * param: String section - Name of ini section
     * param: String key - Key to get value of
     * return: returns value from ini file in String format
     *************************************************************************/
    public static String getValueFromIniFile(String section, String key) {
        UtilFunctions.log("Class: " + utilFunctions.className + "; Method: " + new Object(){}.getClass().getEnclosingMethod().getName());
        try {
            Ini ini = new Ini(new File(UtilProperty.setUpIni));
            System.out.println(ini.get(section, key));
            UtilFunctions.log("SectionName: " + section);
            UtilFunctions.log("KeyName: " + key);
            UtilFunctions.log("Value: " + ini.get(section, key));
            if (ini.get(section, key) == null) {
                UtilFunctions.log("Returning: " + ini.get("DEFAULT", key));
                return ini.get("DEFAULT", key);
            }
            else {
                UtilFunctions.log("Returning: " + ini.get(section, key));
                return ini.get(section, key);
            }
        }
        catch (IOException e){
            e.printStackTrace();
            UtilFunctions.log("File or value not present. Retuning Default values.");
            return "";
        }
    }


    /**************************************************************************
     * name: getJSONValueBasedOnTabTypeAndSearchName(String tabName,
     * String searchType, String searchName, String search, String frameName,
     * String fileType)
     * functionality: Get string value from json file based on tab name and
     * element type
     * param: String tabName - Name of tab
     * param: String searchType - Element name (BUTTONS, PANES, etc.)
     * param: String searchName - Item name (Child of element name)
     * param: String search - Type of search item (xpath, id, name, etc.)
     * param: String frameName - Frame name
     * param: String fileType - File type such as Query, etc.
     * return: returns value from json file
     *************************************************************************/
    public static String getJSONValueBasedOnTabTypeAndSearchName(String tabName, String searchType, String searchName, String search, String frameName, String fileType){
        UtilFunctions.log("Class: " + utilFunctions.className + "; Method: " + new Object(){}.getClass().getEnclosingMethod().getName());

        JSONObject fileObj;
        if (fileType.equals("Query"))
            fileObj = getJSONFileObjForQueriesBasedOnTabName(tabName);
        else
            fileObj = getJSONFileObjBasedOnTabName(tabName);
        HashMap frameMap = getFrameMapBasedOnTabName(tabName);
        if (search == null){
            UtilFunctions.log("Search value is null. Returning element name and element type.");
            String[] elementTypeArr = getElementStringAndType(fileObj, searchType + "." + searchName);
            String elementPath = elementTypeArr[0];
            String elementMethod = elementTypeArr[1];
            UtilFunctions.log("Returning: " + elementPath + ";" + elementMethod);
            return elementPath + ";" + elementMethod;
        }
        else {
            if (frameName == null || frameName == "") {
                if (search.equals("frame")) {
                    UtilFunctions.log("Returning: " + UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, searchType + "." + searchName.replace(" ", ""), search)));
                    return UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, searchType + "." + searchName.replace(" ", ""), search));
                } else {
                    UtilFunctions.log("Returning: " + UtilFunctions.getElementFromJSONFile(fileObj, searchType + "." + searchName.replace(" ", ""), search));
                    return UtilFunctions.getElementFromJSONFile(fileObj, searchType + "." + searchName.replace(" ", ""), search);
                }
            }
            else{
                UtilFunctions.log("Returning: " + UtilFunctions.getFrameValue(frameMap, frameName));
                return UtilFunctions.getFrameValue(frameMap, frameName);
            }
        }
    }


    /**************************************************************************
     * name: tryClob2String(Object value)
     * functionality: Convert clob object to string
     * param: Object value - Object to be converted
     * return: returns converted object in string format
     *************************************************************************/
    public static String tryClob2String(Object value)
    {
        UtilFunctions.log("Class: " + utilFunctions.className + "; Method: " + new Object(){}.getClass().getEnclosingMethod().getName());
        final Clob clobValue = (Clob) value;
        String result = null;

        try
        {
            final long clobLength = clobValue.length();

            if (clobLength < Integer.MIN_VALUE || clobLength > Integer.MAX_VALUE)
            {
                UtilFunctions.log("CLOB size too big for String!");
            }
            else
            {
                result = clobValue.getSubString(1, (int) clobValue.length());
            }
        }
        catch (SQLException e)
        {
            UtilFunctions.log("tryClob2String ERROR: {}");
        }
        finally
        {
            if (clobValue != null)
            {
                try
                {
                    clobValue.free();
                }
                catch (SQLException e)
                {
                    UtilFunctions.log("CLOB FREE ERROR: {}");
                }
            }
        }

        return result;
    }


    public static long getCurrentDateTimeValues(String getType){
        UtilFunctions.log("Class: " + utilFunctions.className + "; Method: " + new Object(){}.getClass().getEnclosingMethod().getName());

        java.util.Date date= new Date();
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        long retVal;
        switch (getType) {
            case "MONTH":
                retVal = cal.get(Calendar.MONTH) + 1;
                break;
            case "DAY":
                retVal = cal.get(Calendar.DAY_OF_MONTH);
                break;
            case "YEAR":
                retVal = cal.get(Calendar.YEAR);
                break;
            case "HOUR":
                //retVal = TimeUnit.MILLISECONDS.toHours(GlobalConstants.endTime.getTime() - GlobalConstants.startTime.getTime());
                retVal = Long.parseLong(GlobalConstants.startTime.split(":")[0]);
                break;
            case "MINUTES":
                //retVal = TimeUnit.MILLISECONDS.toMinutes(GlobalConstants.endTime.getTime() - GlobalConstants.startTime.getTime());
                retVal = Long.parseLong(GlobalConstants.startTime.split(":")[1]);
                break;
            default:
                retVal = 0;
                break;
        }
        return retVal;
    }


    public static void setMobVersionAndTag() {
        UtilFunctions.log("Class: " + utilFunctions.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        String url = UtilProperty.url.replace("index.jsp", "version.jsp");
        UtilFunctions.log("Version URL: " + url);
        WebDriver driver = null;
        if (UtilProperty.browserType.contains("ie")) {
            //Too risky to use recent drivers without proper testing
            WebDriverManager.iedriver().arch32().version("3.14").setup();
            driver = new InternetExplorerDriver();
            UtilFunctions.log("InternetExplorerDriver initialized");
        } else if (UtilProperty.browserType.equals("chrome")) {
            //Clear version map cache to avoid using the Beta Chrome driver against Prod Chrome
            WebDriverManager.chromedriver().clearPreferences();
            WebDriverManager.chromedriver().setup();
            driver = new ChromeDriver();
            UtilFunctions.log("ChromeDriver initialized");
        } else if (UtilProperty.browserType.equals("chromeBeta")) {
            ChromeOptions options = new ChromeOptions();
            String chromeBetaPath = System.getenv("CHROME_BETA_HOME") + "\\chrome.exe";
            if (chromeBetaPath.startsWith("null")) {
                System.out.println("Bad CHROME_BETA_HOME environment variable path.  Expected full dir path to chrome beta \"chrome.exe\"");
                System.out.println("Using default path: C:\\Program Files (x86)\\Google\\Chrome Beta\\Application");
                chromeBetaPath = "C:\\Program Files (x86)\\Google\\Chrome Beta\\Application\\chrome.exe";
            }
            options.setBinary(chromeBetaPath);
            WebDriverManager.chromedriver().config().setUseBetaVersions(true);
            //Use specific driver version:
            //WebDriverManager.chromedriver().version("75");
            //Get driver version based on installed Chrome Beta browser version:
            WebDriverManager.chromedriver().browserPath("C:\\\\Program Files (x86)\\\\Google\\\\Chrome Beta\\\\Application\\\\chrome.exe");
            //Clear version map cache to avoid using the Prod Chrome driver against Beta Chrome
            WebDriverManager.chromedriver().clearPreferences();
            WebDriverManager.chromedriver().setup();
            driver = new ChromeDriver(options);
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
        }
        driver.get(url);
        SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, "/html/body;xpath");
        WebElement textEle = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("/html/body;xpath"));
        try {
            GlobalConstants.mobilizerTag = textEle.getText().split("Tag: ")[1];
            GlobalConstants.mobilizerVersion = textEle.getText().split("Version ")[1].split("Tag: ")[0].trim();
        } catch (Exception e) {
            UtilFunctions.log("Unable to get mobilizer tag information.  Text found: " + textEle.getText());
        }
        UtilFunctions.log("Mobilizer Tag: " + GlobalConstants.mobilizerTag);
        UtilFunctions.log("Mobilizer Version: " + GlobalConstants.mobilizerVersion);
        driver.quit();
    }


    public static void setRESTMobVersionAndTag(){
        UtilFunctions.log("Class: " + utilFunctions.className + "; Method: " + new Object(){}.getClass().getEnclosingMethod().getName());

        String url = UtilProperty.url + "healthcheck";
        UtilFunctions.log("Version URL: " + url);
        WebDriver driver = null;
        if (UtilProperty.browserType.contains("ie")) {
            driver = new InternetExplorerDriver();
            UtilFunctions.log("InternetExplorerDriver initialized");
        }
        else if (UtilProperty.browserType.equals("chrome")) {
            driver = new ChromeDriver();
            UtilFunctions.log("ChromeDriver initialized");
        }
        driver.get(url);
        SeleniumFunctions.explicitWait(driver, GlobalConstants.TEN, "/html/body;xpath");
        WebElement textEle = SeleniumFunctions.findElement(driver, SeleniumFunctions.setByValues("/html/body;xpath"));

        JSONParser parser = new JSONParser();
        JSONObject json = null;
        try {
            json = (JSONObject) parser.parse(textEle.getText().trim());
            GlobalConstants.mobilizerTag = UtilProperty.sectionName + "_" + json.get("buildNumber");
            GlobalConstants.mobilizerVersion = UtilProperty.sectionName;
        } catch (ParseException e) {
            e.printStackTrace();
        }

        UtilFunctions.log("Mobilizer Tag: " + GlobalConstants.mobilizerTag);
        UtilFunctions.log("Mobilizer Version: " + GlobalConstants.mobilizerVersion);
        driver.quit();
    }


    public static void deleteLogFiles(){
        UtilFunctions.log("Class: " + utilFunctions.className + "; Method: " + new Object(){}.getClass().getEnclosingMethod().getName());

        String logFolderPath = UtilProperty.sMainDir + "\\logs";
        int datePastWeek = 7;
        long purgeTime = System.currentTimeMillis() - ((long)datePastWeek * 24 * 60 * 60 * 1000);
        File[] files = new File(logFolderPath).listFiles();
        for (File file : files){
            if (file.lastModified() < purgeTime){
                UtilFunctions.log("Deleting Log File: " + file.getName());
                if (!file.delete())
                    UtilFunctions.log("Not able to delete log file: " + file.getName());
            }
        }
    }

    public static boolean deleteFile(String filePath){
        try{
            File file = new File(filePath);
            if(file.delete()){
                log(file.getName() + " is deleted!");
                return true;
            }else{
                log("Delete operation is failed.");
                return false;
            }
        }catch(Exception e){
            e.printStackTrace();
            log("Delete operation is failed.");
            return false;
        }
    }

    /**************************************************************************
     * Returns the index of the cell that contains string(findString)
     *
     * @param array Array to search through for string value
     * @param findString The string to search for
     * @return Index of the first cell found that contains findString.  -1 if not found.
     *************************************************************************/
    public static int getArrayIndexOfString(String[] array, String findString) {
        UtilFunctions.log("Class: " + utilFunctions.className + "; Method: " + new Object(){}.getClass().getEnclosingMethod().getName());

        for (int index = 0; index < array.length; index++) {
            if (array[index].contains(findString)) {
                return index;
            }
        }

        //Return -1 if string not found in array
        return -1;
    }

    /***************************************************************************************************
     * Convert date in a string wrapped in % characters to specified format with reference to given date
     *
     * @param text the string to parse and convert
     * @param refDate the reference Date from which dates in the string to parse and convert
     * @return string
     ***************************************************************************************************/

    public static String convertDateThruRegExWithRefDate(String text, Date refDate) {
        UtilFunctions.log("Class: " + utilFunctions.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        // Implemented only for dates, can extend for time later if needed
        try{
            Pattern pattern = Pattern.compile("%(.*?)%");
            Matcher matcher = pattern.matcher(text);
            while (matcher.find()) {
                String token = matcher.group();
                String[] dayArr = token.replace("%","").split(" ");
                int dayNo;
                SimpleDateFormat dateFormater = new SimpleDateFormat(dayArr[dayArr.length-1]);
                Date visitCreatedDate= dateFormater.parse(dateFormater.format(refDate));
                Calendar calendar = Calendar.getInstance();
                calendar.setTime(visitCreatedDate);
                if(token.contains("days from") || token.contains("day from")) {
                    dayNo = Integer.parseInt(dayArr[0]);
                    calendar.add(Calendar.DAY_OF_MONTH, +dayNo);
                }else if(token.contains("days ago") || token.contains("day ago")) {
                    dayNo = Integer.parseInt(dayArr[0]);
                    calendar.add(Calendar.DAY_OF_MONTH, -dayNo);
                }else if(token.contains("exact day")) {
                    dayNo = 0;
                    calendar.add(Calendar.DAY_OF_MONTH, -dayNo);
                }else
                    UtilFunctions.log("Date text is not in valid format");
                text = text.replaceFirst(token, dateFormater.format(calendar.getTime()));
            }
            UtilFunctions.log("Text with formated date: "+text);
            return text;
        }catch(Exception e){
            UtilFunctions.log("Converting dates in the text with RegEx faied: "+e.getMessage());
            return null;
        }
    }

    public static void sleep(int ms){
        UtilFunctions.log("Class: " + utilFunctions.className + "; Method: " + new Object(){
        }.getClass().getEnclosingMethod().getName());

        try {
            Thread.sleep(ms);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }


}//end class
