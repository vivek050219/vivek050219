package api.utils;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import utils.UtilProperty;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Iterator;
import java.util.Set;

/**
 * Created by PatientKeeper on 10/7/2016.
 */
public class UtilFunctions {

    public String className = getClass().getSimpleName();
    private static UtilFunctions utilFunctions = new UtilFunctions();

    public static String jsonFileFolderLoc = "\\src\\test\\java\\api\\requestJSON\\";
    private static String jsonAPILoc = "\\src\\test\\java\\api\\apiRepository\\";

    public static String getJsonAPILoc(){
        return jsonAPILoc;
    }


    public static String convertJSONFileToString(String jsonFile){
        utils.UtilFunctions.log("Class: " + utilFunctions.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        try {
            JSONParser parser = new JSONParser();
            Object obj = parser.parse(new FileReader(UtilProperty.sMainDir + jsonFileFolderLoc + jsonFile + ".json"));
            JSONObject jsonObj = (JSONObject) obj;
            utils.UtilFunctions.log("Returning jsonObj inString format:" + jsonObj.toString());
            return jsonObj.toString();

        } catch (FileNotFoundException e) {
            e.printStackTrace();
            utils.UtilFunctions.log("JSON File: " + jsonFile + " not found. Exception: " + e.getMessage());
            utils.UtilFunctions.log("Returning null");
            return null;
        } catch (ParseException e) {
            e.printStackTrace();
            utils.UtilFunctions.log("JSON File: " + jsonFile + " parse exception: " + e.getMessage());
            utils.UtilFunctions.log("Returning null");
            return null;
        } catch (IOException e) {
            e.printStackTrace();
            utils.UtilFunctions.log("JSON File: " + jsonFile + " I/O exception: " + e.getMessage());
            utils.UtilFunctions.log("Returning null");
            return null;
        }
    }

    public static boolean updateJSONFileValue(String jsonFile, String key, String newValue){
        utils.UtilFunctions.log("Class: " + utilFunctions.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        boolean retVal;
        try {
            JSONParser parser = new JSONParser();
            Object obj = parser.parse(new FileReader(UtilProperty.sMainDir + jsonFileFolderLoc + jsonFile + ".json"));
            JSONObject jsonObj = (JSONObject) obj;
            jsonObj.remove(key);
            jsonObj.put(key, newValue);

            FileWriter file = new FileWriter(UtilProperty.sMainDir + jsonFileFolderLoc + jsonFile + ".json");
            file.write(jsonObj.toJSONString());
            utils.UtilFunctions.log("JSON File: " + jsonFile + " successfully updated. Returning true.");
            retVal = true;
            file.flush();
            file.close();

        } catch (ParseException e) {
            e.printStackTrace();
            utils.UtilFunctions.log("JSON File: " + jsonFile + " parse exception: " + e.getMessage());
            utils.UtilFunctions.log("Returning false");
            retVal = false;
        } catch (FileNotFoundException e) {
            e.printStackTrace();
            utils.UtilFunctions.log("JSON File: " + jsonFile + " not found. Exception: " + e.getMessage());
            utils.UtilFunctions.log("Returning false");
            retVal = false;
        } catch (IOException e) {
            e.printStackTrace();
            utils.UtilFunctions.log("JSON File: " + jsonFile + " I/O exception: " + e.getMessage());
            utils.UtilFunctions.log("Returning false");
            retVal = false;
        }
        return retVal;
    }

    public static JSONObject convertStringToJSONObject(String toBeConvertedToJSONObj){
        utils.UtilFunctions.log("Class: " + utilFunctions.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        JSONParser parser = new JSONParser();
        try {
            JSONObject jsonObj = (JSONObject) parser.parse(toBeConvertedToJSONObj);
            utils.UtilFunctions.log("Returning jsonObj");
            return jsonObj;
        } catch (ParseException e) {
            e.printStackTrace();
            utils.UtilFunctions.log("Not able to convert to JSON obj. Returning null");
            return null;
        }
    }

    public static String getArray(Object object2, String checkIdentifier, String checkValue, String getValue) throws ParseException {
        utils.UtilFunctions.log("Class: " + utilFunctions.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        JSONArray jsonArr = (JSONArray) object2;
        for (int k = 0; k < jsonArr.size(); k++) {
            JSONObject jsonArrObj = (JSONObject) jsonArr.get(k);
            if (jsonArrObj.get((Object)checkIdentifier).equals(checkValue)){
                utils.UtilFunctions.log("Returning: " + jsonArrObj.get((Object)getValue).toString());
                return jsonArrObj.get((Object)getValue).toString();
            }
        }
        utils.UtilFunctions.log("Returning null");
        return null;
    }

    public static String parseJson(JSONObject jsonObject, String parentValue, String checkIdentifier, String checkValue, String getValue) throws ParseException {
        utils.UtilFunctions.log("Class: " + utilFunctions.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        Set<Object> set = jsonObject.keySet();
        Iterator<Object> iterator = set.iterator();
        while (iterator.hasNext()) {
            Object obj = iterator.next();
                if (jsonObject.get(obj) instanceof JSONArray) {
                    System.out.println(obj);
                    return getArray(jsonObject.get(obj), checkIdentifier, checkValue, getValue);
                } else {
                    if (jsonObject.get(obj) instanceof JSONObject) {
                        System.out.println(obj);
                        return parseJson((JSONObject) jsonObject.get(obj), parentValue, checkIdentifier, checkValue, getValue);
                    } else {
                        if (jsonObject.get(obj).equals(checkValue)) {
                            utils.UtilFunctions.log("Returning: " + jsonObject.get(obj).toString());
                            return jsonObject.get(obj).toString();
                        }
                    }
                }
        }
        utils.UtilFunctions.log("Returning null");
        return null;
    }


    public static String parseJson(JSONObject jsonObject, String parentValue, String getValue) throws ParseException {
        utils.UtilFunctions.log("Class: " + utilFunctions.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        Set<Object> set = jsonObject.keySet();
        Iterator<Object> iterator = set.iterator();
        while (iterator.hasNext()) {
            Object obj = iterator.next();
            try {
                if (jsonObject.get(obj) instanceof JSONArray) {
                    System.out.println(obj);
                    //return getArray(jsonObject.get(obj), checkIdentifier, checkValue, getValue);
                } else {
                    if (jsonObject.get(obj) instanceof JSONObject) {
                        System.out.println(obj);
                        if (obj.equals(parentValue))
                            return parseJson((JSONObject) jsonObject.get(obj), parentValue, getValue);
                    } else {
                        if (obj.equals(getValue)) {
                            utils.UtilFunctions.log("Returning: " + jsonObject.get(obj).toString());
                            return jsonObject.get(obj).toString();
                        }
                    }
                }
            }
            catch (Exception e){
                e.printStackTrace();
                utils.UtilFunctions.log("Exception in parseJSON:" + e.getMessage());
            }
        }
        utils.UtilFunctions.log("Returning null");
        return null;
    }


    public static boolean elementPresentInJsonArray(JSONArray jsonArray, String[] keyArray, String[] valueArray) throws ParseException {
        utils.UtilFunctions.log("Class: " + utilFunctions.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        boolean tempCheck = false;
        for (Object obj : jsonArray){
            JSONObject tJObj = (JSONObject) obj;
            for (int index = 0; index < keyArray.length; index++){
                if (tJObj.get(keyArray[index]).equals(valueArray[index])) {
                    tempCheck = true;
                }
                else{
                    tempCheck = false;
                    break;
                }
            }
            if (tempCheck) {
                utils.UtilFunctions.log("Returning true");
                return true;
            }
        }
        utils.UtilFunctions.log("Returning false");
        return false;
    }


    public static JSONObject parseJsonAndSetValue(JSONObject jsonObject, String parentValue, String checkValue, Object setKey, Object setValue) throws ParseException {
        utils.UtilFunctions.log("Class: " + utilFunctions.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        Set<Object> set = jsonObject.keySet();
        Iterator<Object> iterator = set.iterator();
        while (iterator.hasNext()) {
            Object obj = iterator.next();
            try {
                if (jsonObject.get(obj) instanceof JSONArray) {
                    System.out.println(obj);
                    if (obj.equals(parentValue)) {
                        //Do something
                        //return getArray(jsonObject.get(obj), checkIdentifier, checkValue, getValue);
                    }
                } else {
                    if (jsonObject.get(obj) instanceof JSONObject) {
                        System.out.println(obj);
                        if (obj.equals(parentValue)) {
                            ((JSONObject) jsonObject.get(obj)).put(setKey, setValue);
                            return jsonObject;
                        }
                    } else {
                        if (obj.equals(checkValue)) {
                            utils.UtilFunctions.log("Returning: " + jsonObject.get(obj).toString());
                            jsonObject.put(setKey, setValue);
                            return jsonObject;
                        }
                    }
                }
            }
            catch (Exception e){
                e.printStackTrace();
                utils.UtilFunctions.log("Exception in parseJsonAndSetValue:" + e.getMessage());
            }
        }
        utils.UtilFunctions.log("Returning null");
        return null;
    }


    public static String getIDFromTabName(String response, String parentValue, String checkIdentifier, String checkValue, String getValue) throws ParseException {
        utils.UtilFunctions.log("Class: " + utilFunctions.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        JSONObject jsonObj = convertStringToJSONObject(response);
        return parseJson(jsonObj, parentValue, checkIdentifier, checkValue, getValue);
    }


    public static boolean checkResponseSuccess(String response){
        utils.UtilFunctions.log("Class: " + utilFunctions.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        JSONParser parser = new JSONParser();
        try {
            JSONObject json = (JSONObject) parser.parse(response);
            if (((JSONObject)json.get("response")).get("success").equals(true)) {
                utils.UtilFunctions.log("Response success! Returning true");
                return true;
            }
            else {
                utils.UtilFunctions.log("Response not adequate. Success value is false. Returning false");
                return false;
            }
        } catch (ParseException e) {
            e.printStackTrace();
            utils.UtilFunctions.log("Exception in parseJsonAndSetValue:" + e.getMessage());
            utils.UtilFunctions.log("Success not present in the response. Returning false");
            return false;
        }
    }
}
