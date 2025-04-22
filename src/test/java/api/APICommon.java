package api;

import features.step_definitions.GlobalStepdefs;
import org.apache.commons.lang3.StringUtils;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import support.db.DBExecutor;
import utils.UtilFunctions;
import utils.UtilProperty;

import java.io.FileReader;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by PatientKeeper on 10/6/2016.
 */
public class APICommon extends RequestResponse{

    public String className = getClass().getSimpleName();
    private String baseRestURL = "mcp/pl/api/v2/";

    public APICommon(String requestType, String jsonFile, String restURL){
        setCookies();
        setRequestType(requestType);
        setUrlName(UtilProperty.apiURL + restURL);
        setJsonFile(jsonFile);
    }

    public APICommon(String type, String name, String ownerName, String parentList, String otherData, String userName){
        try {
            setAuthorization(userName);
            setCookies();
            String fileName = GlobalStepdefs.curTabName + "_" + type + "_API";
            JSONParser parser = new JSONParser();
            System.out.println(UtilProperty.sMainDir + api.utils.UtilFunctions.getJsonAPILoc() + fileName + ".json");
            Object obj = parser.parse(new FileReader(UtilProperty.sMainDir + api.utils.UtilFunctions.getJsonAPILoc() + fileName + ".json"));
//            if(obj==null){
//                obj = parser.parse(new FileReader(UtilProperty.sMainDir + api.utils.UtilFunctions.getJsonAPILoc() + "_Create_API" + ".json"));
//            }
//            else {
//                UtilFunctions.log("Object not found");
//            }
            switch (type){
                case "Create":
                    //jsonObject = (JSONObject) obj;
                    setJsonObject((JSONObject) obj);
                    //Get id of list owner
                    Object id = getPersonnelId(api.utils.UtilFunctions.parseJson(getJsonObject(), "listOwner", "label"));
                    setJsonObject(api.utils.UtilFunctions.parseJsonAndSetValue(getJsonObject(), "listOwner", "label", "value", id));
                    setJsonObject(api.utils.UtilFunctions.parseJsonAndSetValue(getJsonObject(), "listCreator", "label", "value", id));

                    //Get codes for pk visit types
                    for (int index = 0; index < ((JSONArray) getJsonObject().get("timeBasedCriteria")).size(); index++){
                        JSONObject tempJSONObj = (JSONObject) ((JSONArray) getJsonObject().get("timeBasedCriteria")).get(index);
                        String tempName = api.utils.UtilFunctions.parseJson(tempJSONObj, "pkVisitType", "name");
                        Object code = getTimeCriterionValue(tempName);
                        ((JSONObject)((JSONObject) ((JSONArray) getJsonObject().get("timeBasedCriteria")).get(index)).get("pkVisitType")).put("code", code);
                    }

                    //Get codes for display positions
                    for (int index = 0; index < ((JSONArray) getJsonObject().get("displayPositions")).size(); index++){
                        JSONObject tempJSONObj = (JSONObject) ((JSONArray) getJsonObject().get("displayPositions")).get(index);
                        if (tempJSONObj.get("type").equals("DisplayPosition")) {
                            Object displayField = getPositionValue((String) tempJSONObj.get("label"));
                            ((JSONObject) ((JSONArray) getJsonObject().get("displayPositions")).get(index)).put("displayField", displayField);
                        }
                    }

                    for (int index = 0; index < ((JSONArray) getJsonObject().get("sortOrder")).size(); index++){
                        JSONObject tempJSONObj = (JSONObject) ((JSONArray) getJsonObject().get("sortOrder")).get(index);
                        Object displayField = getPositionValue((String) tempJSONObj.get("label"));
                        ((JSONObject) ((JSONArray) getJsonObject().get("sortOrder")).get(index)).put("displayField", displayField);
                    }
                    setUrlName(UtilProperty.apiURL + baseRestURL + "patient-lists/");
                    break;

                case "Permissions":
                    setJsonArr((JSONArray) obj);
                    //Put a loop to get ids of permission owner(s) ==> Don't see the need of this (ref. Ruby code) as we are already setting owner with id and name in setOwner function
                    for (int index = 0; index < getJsonArr().size(); index++){
                        //((JSONObject) jsonArr.get(index)).remove("ids");
                        if (((JSONObject)((JSONObject) getJsonArr().get(index)).get("ids")).size() > 0){
                            Set<String> entry = ((JSONObject)((JSONObject) getJsonArr().get(index)).get("ids")).keySet();
                            for (String key : entry){
                                String value = (String) ((JSONObject)((JSONObject) getJsonArr().get(index)).get("ids")).get(key);
                                String pID = (String) getPersonnelId(value);
                                ((JSONObject)((JSONObject) getJsonArr().get(index)).get("ids")).remove(key);
                                ((JSONObject)((JSONObject) getJsonArr().get(index)).get("ids")).put(pID, value);
                            }
                        }
                    }
                    if (ownerName != null)
                        setOwner("Permissions", ownerName);
                    setUrlName(UtilProperty.apiURL + baseRestURL + "patient-lists/" + getPatientListId(name, null, null) + "/permissions/");
                    break;

                case "Favorites":
                    setJsonObject((JSONObject) obj);
                    Object patientListID = getPatientListId(name, String.valueOf(getPersonnelIdByUsername(ownerName)), null);
                    getJsonObject().put("patientListId", patientListID);
                    setUrlName(UtilProperty.apiURL + baseRestURL + "patient-lists/" + patientListID + "/favorites/");
                    break;

                case "Delete":
                    setJsonObject((JSONObject) obj);
                    //Do something
                    break;

                case "Visits":
                    setJsonObject((JSONObject) obj);
                    //Do something
                    break;

                case "Reassign":
                    setJsonObject((JSONObject) obj);
                    //Do something
                    break;

                case "Filters":
//                    setJsonObject((JSONObject) obj);
                    patientListID = getPatientListId(name, String.valueOf(getPersonnelIdByUsername(ownerName)), null);
                    setUrlName(UtilProperty.apiURL + baseRestURL + "patient-lists/" + patientListID);
                    break;

                case "TimeCriteria":
//                    setJsonObject((JSONObject) obj);
                    patientListID = getPatientListId(name, String.valueOf(getPersonnelIdByUsername(ownerName)), null);
                    setUrlName(UtilProperty.apiURL + baseRestURL + "patient-lists/" + patientListID);
                    break;

                case "DisplayView":
//                    setJsonObject((JSONObject) obj);
                    //TODO: Need to get patientListID using list name AND owner ID.  Code currently works but may not return the correct ID if another user has a list with the same name.
                    //TODO: Object patientListID = getPatientListId(name, String.valueOf(getPersonnelIdByUsername(ownerName)), null);
                    //TODO: setUrlName(UtilProperty.apiURL + baseRestURL + "patient-lists/" + patientListID);
                    //Done
                    patientListID = getPatientListId(name, String.valueOf(getPersonnelIdByUsername(ownerName)), null);
                    setUrlName(UtilProperty.apiURL + baseRestURL + "patient-lists/" + patientListID);
//                    setUrlName(UtilProperty.apiURL + baseRestURL + "patient-lists/" + getPatientListId(name,null,null));
                    break;

                default:
                    break;
            }
        } catch (IOException e) {
            e.printStackTrace();
            utils.UtilFunctions.log("JSON File: " + getJsonFile() + " not found. Exception: " + e.getMessage());
        } catch (ParseException e) {
            e.printStackTrace();
            utils.UtilFunctions.log("JSON File: " + getJsonFile() + " not found. Exception: " + e.getMessage());
        } catch (SQLException e) {
            e.printStackTrace();
            utils.UtilFunctions.log("SQL Exception: " + e.getMessage());
        }
    }


    public void setPrerequisites(String requestType, String restURL){
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        setRequestType(requestType);
        if (restURL != null)
            setUrlName(UtilProperty.apiURL + restURL);
    }


    public String getResponse(String urlParameters, APICommon... apiCommon) throws IOException {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String response;
        setUrlParameters(urlParameters);
        switch (getRequestType()){
            case "GET":
                response = getRequest();
                break;
            case "PUT":
                response = putRequest(apiCommon);
                break;
            case "POST":
                response = postRequest(apiCommon);
                break;
            case "PATCH":
                response = postRequest(apiCommon);
                break;
            default:
                response = "";
                break;
        }
        UtilFunctions.log("Response: " + response);
        System.out.println("Response: " + response);
        return response;
    }


    public Object getPersonnelId(String name) throws SQLException, ParseException {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String firstName = name.split(",")[1].trim();
        String lastName = name.split(",")[0].trim();
        DBExecutor dbExecutorObj = new DBExecutor("e_person", "pers_id", true, null, null, null);
        dbExecutorObj.addWhere("nm_first='" + firstName + "'");
        dbExecutorObj.addWhere("nm_last='" + lastName + "'");
        List<HashMap> rs = dbExecutorObj.executeQuery();
        for (HashMap map : rs)
            return map.get("PERS_ID");
        return 0;
    }


    public Object getPersonnelIdByUsername(String userName) throws SQLException, ParseException {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        DBExecutor dbExecutorObj = new DBExecutor("u_user", "user_id", true, null, null, null);
        dbExecutorObj.addWhere("user_nm='" + userName + "'");
        dbExecutorObj.addWhere("del_ind=0");
        List<HashMap> rs = dbExecutorObj.executeQuery();
        for (HashMap map : rs)
            return map.get("USER_ID");
        return 0;
    }


    public Object getPersonnelName(Object id) throws SQLException, ParseException {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        DBExecutor dbExecutorObj = new DBExecutor("e_person", "nm_full", true, null, null, null);
        dbExecutorObj.addWhere("pers_id='" + id + "'");
        List<HashMap> rs = dbExecutorObj.executeQuery();
        for (HashMap map : rs)
            return map.get("NM_FULL");
        return 0;
    }


    public Object getPatientListId(String name, String ownerId, String description) throws SQLException, ParseException {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        DBExecutor dbExecutorObj = new DBExecutor("pl_patientlist", "id", true, null, null, null);
        dbExecutorObj.addWhere("name='" + name + "'");
        dbExecutorObj.addWhere("del_ind=0");

        if (ownerId != null)
            dbExecutorObj.addWhere("OWNER='" + ownerId + "'");
        if (description != null)
            dbExecutorObj.addWhere("DESCRIPTION='" + description + "'");

        List<HashMap> rs = dbExecutorObj.executeQuery();
        for (HashMap map : rs)
            return map.get("ID");
        return 0;
    }


    public Object getPatientListTypeById(Object id) throws SQLException, ParseException {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        DBExecutor dbExecutorObj = new DBExecutor("pl_patientlist", "listtype", true, null, null, null);
        dbExecutorObj.addWhere("id='" + id + "'");
        dbExecutorObj.addWhere("del_ind=0");
        List<HashMap> rs = dbExecutorObj.executeQuery();
        for (HashMap map : rs)
            return map.get("LISTTYPE");
        return 0;
    }


    public Object getDepartmentIdByName(String name) throws SQLException, ParseException {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        DBExecutor dbExecutorObj = new DBExecutor("pk_department", "syncid", true, null, null, null);
        dbExecutorObj.addWhere("name='" + name + "'");
        dbExecutorObj.addWhere("syncdeleted=0");
        List<HashMap> rs = dbExecutorObj.executeQuery();
        for (HashMap map : rs)
            return map.get("SYNCID");
        return 0;
    }


    public Object getFacilityIdByName(String name) throws SQLException, ParseException {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        DBExecutor dbExecutorObj = new DBExecutor("m_lctn", "lctn_id", true, null, null, null);
        dbExecutorObj.addWhere("lctn_nm='" + name + "'");
        dbExecutorObj.addWhere("parent_id IS NULL");
        dbExecutorObj.addWhere("del_ind=0");
        List<HashMap> rs = dbExecutorObj.executeQuery();
        for (HashMap map : rs)
            return map.get("LCTN_ID");
        return 0;
    }


    public Object getPatientListOwner(String listName) throws SQLException, ParseException {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        DBExecutor dbExecutorObj = new DBExecutor("pl_patientlist", "owner", true, null, null, null);
        dbExecutorObj.addWhere("name='" + listName + "'");
        List<HashMap> rs = dbExecutorObj.executeQuery();
        Object ownerId = null;
        for (HashMap map : rs) {
            ownerId = map.get("OWNER");
        }
        if (ownerId != null)
            return getPersonnelName(ownerId);
        return 0;
    }


    public Object getTimeCriterionValue(String name) throws SQLException, ParseException {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        DBExecutor dbExecutorObj = new DBExecutor("m_code", "cd_cd", true, null, null, null);
        dbExecutorObj.addWhere("cd_title='" + name + "'");

        DBExecutor subDBExecutorObj = new DBExecutor("m_code_set", "cd_set_cd", true, null, null, null);
        subDBExecutorObj.addWhere("cd_set_nm='Visit Class'");
        subDBExecutorObj.setQuery();

        dbExecutorObj.addWhere("cd_set_cd IN (" + subDBExecutorObj.query + ")");

        List<HashMap> rs = dbExecutorObj.executeQuery();
        for (HashMap map : rs)
            return map.get("CD_CD");
        return 0;
    }


    public Object getPositionValue(String label) throws SQLException, ParseException, IOException {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        setPrerequisites("GET", baseRestURL + "patient-lists/display-fields");
        String response = this.getResponse(null);
        JSONParser parser = new JSONParser();
        JSONObject json = (JSONObject) parser.parse(response);

        for (int index = 0; index < ((JSONArray)((JSONObject)json.get("response")).get("displayFields")).size(); index++){
            JSONObject tempJSONObj = (JSONObject) ((JSONArray)((JSONObject)json.get("response")).get("displayFields")).get(index);
            if (tempJSONObj.get("label").equals(label)) {
                return tempJSONObj.get("name");
            }
        }

        return null;
    }


    public Object getFilterCriterionType(String label) throws SQLException, ParseException, IOException {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        APICommon tempAPICommon = new APICommon("GET", null, baseRestURL + "patient-lists/filter-criteria-fields");
        String response = tempAPICommon.getResponse(null);
        JSONParser parser = new JSONParser();
        JSONObject json = (JSONObject) parser.parse(response);

        for (int index = 0; index < ((JSONArray)((JSONObject)json.get("response")).get("filterCriteriaFields")).size(); index++){
            JSONObject tempJSONObj = (JSONObject) ((JSONArray)((JSONObject)json.get("response")).get("filterCriteriaFields")).get(index);
            if (((JSONObject)tempJSONObj.get("criterion")).get("label").equals(label)) {
                return ((JSONObject)tempJSONObj.get("criterion")).get("value");
            }
        }

        return null;
    }


    public Object getFilterCriterionValue(String typeLabel, String valLabel) throws SQLException, ParseException, IOException {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        APICommon tempAPICommon = new APICommon("GET", null, baseRestURL + "patient-lists/filter-criteria-fields");
        String response = tempAPICommon.getResponse(null);
        JSONParser parser = new JSONParser();
        JSONObject json = (JSONObject) parser.parse(response);

        for (int index = 0; index < ((JSONArray)((JSONObject)json.get("response")).get("filterCriteriaFields")).size(); index++){
            JSONObject tempJSONObj = (JSONObject) ((JSONArray)((JSONObject)json.get("response")).get("filterCriteriaFields")).get(index);
            if (((JSONObject)tempJSONObj.get("criterion")).get("label").equals(typeLabel)) {
                JSONArray jArr = (JSONArray) tempJSONObj.get("fieldValues");
                for (Object jObj : jArr){
                    if (((JSONObject)jObj).get("label").equals(valLabel))
                        return ((JSONObject)jObj).get("value");
                }

                return ((JSONObject)tempJSONObj.get("criterion")).get("value");
            }
        }

        return null;
    }


    //Might need to update this function later!!!!!
//    public void addFilter(String type, String value) throws ParseException, SQLException, IOException {
//        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
//        }.getClass().getEnclosingMethod().getName() + " : Start");
//
//        Object criterionValue = getFilterCriterionType(type);
//        Object codeSetValue = getFilterCriterionValue(type, value);
//
//        String criterion = "\"type\":\"CodeSetFilterBasedCriterionModel\",\"criterion\":{\"value\":\"" + criterionValue + "\",\"label\":\"" + type + "\"},\"codeSetValues\":[{\"label\":\"" + value + "\", \"value\":\"" + codeSetValue + "\"}]";
//
//        try {
//            if (getJsonObject().get("filterBasedCriteria") == null) {
//                ((JSONObject) getJsonObject().get("filterBasedCriteria")).put("logicExpression", "1");
//                ((JSONObject) getJsonObject().get("filterBasedCriteria")).put("criterionMap", null);
//            }
//        }
//        catch (Exception e){
//            getJsonObject().put("filterBasedCriteria", null);
//            ((JSONObject) getJsonObject().get("filterBasedCriteria")).put("logicExpression", "1");
//            ((JSONObject) getJsonObject().get("filterBasedCriteria")).put("criterionMap", null);
//        }
//
//        int count = 1;
//        String criterionMapStr = "{\"" + count + "\":{" + criterion + "}}";
//        JSONParser parser = new JSONParser();
//        JSONObject tempCriterionJson = (JSONObject) parser.parse(criterionMapStr);
//        ((JSONObject) getJsonObject().get("filterBasedCriteria")).put("criterionMap", tempCriterionJson);
//    }


    public void addUpdateFilter(String type, String value, String action) throws ParseException, SQLException, IOException {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        Object criterionValue = getFilterCriterionType(type);
        Object codeSetValue = getFilterCriterionValue(type, value);

        try {
            if (getJsonObject().get("filterBasedCriteria") == null) {
                JSONObject tempJSON = new JSONObject();
                tempJSON.put("logicExpression", "1");

                JSONObject tempJSONCriterion = new JSONObject();
                //tempJSON.put("criterionMap", tempJSONCriterion);

                tempJSON.put("criterionMap", tempJSONCriterion);

                getJsonObject().put("filterBasedCriteria", tempJSON);
            }
        }
        catch (Exception e){
            getJsonObject().put("filterBasedCriteria", null);
            ((JSONObject) getJsonObject().get("filterBasedCriteria")).put("logicExpression", "1");
            ((JSONObject) getJsonObject().get("filterBasedCriteria")).put("criterionMap", null);
        }

        String logicExpression = (String) ((JSONObject) getJsonObject().get("filterBasedCriteria")).get("logicExpression");
        String[] logicExArr = logicExpression.split(" AND ");

        int removeCnt = 0;
        boolean criterionMapSizeIsZero = false;

        for (int i = 1; i <= logicExArr.length; i++){
            String logicCntStr = logicExArr[i-1];
            JSONObject criterionMap = (JSONObject) ((JSONObject) getJsonObject().get("filterBasedCriteria")).get("criterionMap");

            if (criterionMap.size() == 0) {
                criterionMapSizeIsZero = true;
                break;
            }

            if (((JSONObject)((JSONObject)criterionMap.get(logicCntStr)).get("criterion")).get("label").equals(type) &&
                    (((JSONObject)((JSONArray)((JSONObject)criterionMap.get(logicCntStr)).get("codeSetValues")).get(0)).get("label").equals(value))) {
                if (action.equals("remove")){
                    ((JSONObject)((JSONObject) getJsonObject().get("filterBasedCriteria")).get("criterionMap")).remove(String.valueOf(i));
                    removeCnt++;
                }
                else {
                    System.out.println("Filter already present. Hence, no need to add it again. Returning.");
                    return;
                }
            }
        }
        if (action.equals("remove")) {
            String exp = "";
            for (int cnt = 1; cnt <= logicExArr.length - removeCnt; cnt++){
                if (cnt == 1)
                    exp = exp + cnt;
                else
                    exp = exp + " AND " + cnt;
            }
            ((JSONObject) getJsonObject().get("filterBasedCriteria")).put("logicExpression", exp);
            return;
        }

        int count = 1;

        if (!criterionMapSizeIsZero) {
            logicExpression = logicExpression + " AND " + (logicExArr.length + 1);
            count = logicExArr.length + 1;
        }

        String criterion = "";
        switch (type) {
            case "Location":
                //Iterate through locations in value string to get lowest level location info from database
                String parentID = null;
                DBExecutor dbExecutorObj = null;
                HashMap rs = null;
                List<String> locations = Arrays.asList(value.split("\\."));
                for (String loc : locations) {
                    dbExecutorObj = new DBExecutor("M_LCTN", "LCTN_ID, PARENT_ID, LCTN_TYP_CD", true, null, null, null);
                    dbExecutorObj.addWhere("LCTN_NM='" + loc + "'");
                    if (parentID != null) {
                        dbExecutorObj.addWhere("PARENT_ID='" + parentID + "'");
                    }
                    rs = dbExecutorObj.executeQuery().get(0);
                    //Set parentID to be used in next iteration of for loop.
                    parentID = rs.get("LCTN_ID").toString();
                }
                String locationID = rs.get("LCTN_ID").toString();
                String locationTypeCD = rs.get("LCTN_TYP_CD").toString();
                //Get location type string from M_CODE table
                dbExecutorObj = new DBExecutor("M_CODE", "CD_TITLE", true, null, null, null);
                dbExecutorObj.addWhere("CD_CD='" + locationTypeCD + "'");
                rs = dbExecutorObj.executeQuery().get(0);
                String locationType = rs.get("CD_TITLE").toString();
                criterion = "{\"type\":\"LocationFilterBasedCriterionModel\",\"criterion\":{\"value\":\"" + criterionValue + "\",\"label\":\"" + type + "\"},\"locations\":[{\"id\":\"" + locationID + "\", \"name\":\"" + value + "\", \"type\":\"" + locationType + "\"}]}";
                break;
            default:
                //Default to previously coded criterion type, which was always "CodeSetFilterBasedCriterionModel"
                //May not be correct, but avoids breaking existing scenarios that rely on previous behavior.
                criterion = "{\"type\":\"CodeSetFilterBasedCriterionModel\",\"criterion\":{\"value\":\"" + criterionValue + "\",\"label\":\"" + type + "\"},\"codeSetValues\":[{\"label\":\"" + value + "\", \"value\":\"" + codeSetValue + "\"}]}";
        }

        JSONParser parser = new JSONParser();
        JSONObject tempCriterionJson = (JSONObject) parser.parse(criterion);
        ((JSONObject) getJsonObject().get("filterBasedCriteria")).put("logicExpression", logicExpression);
        ((JSONObject) ((JSONObject) getJsonObject().get("filterBasedCriteria")).get("criterionMap")).put(String.valueOf(count), tempCriterionJson);
    }


    public void setOwner(String type, String userName) throws ParseException, SQLException, IOException {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        Object id = getPersonnelIdByUsername(userName);
        Object name = getPersonnelName(id);

        switch (type){
            case "Create":
                ((JSONObject)getJsonObject().get("listOwner")).put("label", name);
                ((JSONObject)getJsonObject().get("listCreator")).put("label", name);
                ((JSONObject)getJsonObject().get("listOwner")).put("value", id);
                ((JSONObject)getJsonObject().get("listCreator")).put("value", id);
                break;
            case "Permissions":
                for (int index = 0; index < getJsonArr().size(); index++){
                    if (((JSONObject) getJsonArr().get(index)).get("groupType").equals("PERSONNEL")){
                        String ids = "{\"" + id + "\":\"" + name + "\"}";
                        JSONParser parser = new JSONParser();
                        ((JSONObject) getJsonArr().get(index)).put("ids", parser.parse(ids));
                    }
                }
                break;
            case "Favorites":
                String users = "[{\"label\":\"" + name + "\",\"value\":\"" + id + "\"}]";
                JSONParser parser = new JSONParser();
                JSONArray tempUsers = (JSONArray) parser.parse(users);
                getJsonObject().put("users", tempUsers);
                break;
            default:
                break;
        }
    }


    public void addPermission(String accessLevel, String user) throws ParseException, SQLException {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        boolean tempBool = false;
        accessLevel = accessLevel.toUpperCase().replace("/", "_");
        String jsonText = null;
        if (user.toUpperCase().equals("ALL USERS")){
//            for (int index = 0; index < jsonArr.size(); index++){
//                if (((JSONObject) jsonArr.get(index)).get("groupType").equals("PERSONNEL") &&
//                        ((JSONObject) jsonArr.get(index)).get("accessLevel").equals(accessLevel)){
//                    jsonArr.remove(index);
//                    break;
//                }
//            }
            jsonText = "{\"groupType\":\"INSTITUTION\",\"accessLevel\":\"" + accessLevel + "\",\"ids\":{\"" + "0" + "\":\"" + "Public" + "\"}}";
            getJsonArr().add(new JSONParser().parse(jsonText));
        }
        else if (user.toUpperCase().startsWith("DEPT:")){
            user = user.split("DEPT:")[1];
            Object deptID = getDepartmentIdByName(user);

            for (int index = 0; index < getJsonArr().size(); index++){
                tempBool = false;
                if (((JSONObject) getJsonArr().get(index)).get("groupType").equals("DEPARTMENT") &&
                        ((JSONObject) getJsonArr().get(index)).get("accessLevel").equals(accessLevel)){
                    tempBool = true;
                    String ids = "{\"" + deptID + "\":\"" + user + "\"}";
                    JSONParser parser = new JSONParser();
                    ((JSONObject) getJsonArr().get(index)).put("ids", parser.parse(ids));
                    break;
                }
            }

            if (!tempBool){
                jsonText = "{\"groupType\":\"DEPARTMENT\",\"accessLevel\":\"" + accessLevel + "\",\"ids\":{\"" + deptID + "\":\"" + user + "\"}}";
                getJsonArr().add(new JSONParser().parse(jsonText));
            }
        }
        else if (user.toUpperCase().startsWith("FAC:")){
            user = user.split("FAC:")[1];
            Object facID = getFacilityIdByName(user);

            for (int index = 0; index < getJsonArr().size(); index++){
                tempBool = false;
                if (((JSONObject) getJsonArr().get(index)).get("groupType").equals("FACILITY") &&
                        ((JSONObject) getJsonArr().get(index)).get("accessLevel").equals(accessLevel)){
                    tempBool = true;
                    String ids = "{\"" + facID + "\":\"" + user + "\"}";
                    JSONParser parser = new JSONParser();
                    ((JSONObject) getJsonArr().get(index)).put("ids", parser.parse(ids));
                    break;
                }
            }

            if (!tempBool){
                jsonText = "{\"groupType\":\"FACILITY\",\"accessLevel\":\"" + accessLevel + "\",\"ids\":{\"" + facID + "\":\"" + user + "\"}}";
                getJsonArr().add(new JSONParser().parse(jsonText));
            }
        }
        else{
            Object userID = getPersonnelIdByUsername(user);

            for (int index = 0; index < getJsonArr().size(); index++){
                tempBool = false;
                if (((JSONObject) getJsonArr().get(index)).get("groupType").equals("PERSONNEL") &&
                        ((JSONObject) getJsonArr().get(index)).get("accessLevel").equals(accessLevel)){
                    tempBool = true;
                    String ids = "{\"" + userID + "\":\"" + user + "\"}";
                    JSONParser parser = new JSONParser();
                    ((JSONObject) getJsonArr().get(index)).put("ids", parser.parse(ids));
                    break;
                }
            }

            if (!tempBool){
                jsonText = "{\"groupType\":\"PERSONNEL\",\"accessLevel\":\"" + accessLevel + "\",\"ids\":{\"" + userID + "\":\"" + user + "\"}}";
                getJsonArr().add(new JSONParser().parse(jsonText));
            }
        }
    }


    public void removePermission(String accessLevel, String user) throws ParseException, SQLException {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        boolean tempBool = false;
        String groupType;
        Object id;
        accessLevel = accessLevel.toUpperCase().replace("/", "_");
        if (user.toUpperCase().equals("ALL USERS")){
            groupType = "INSTITUTION";
            id = 0;
        }
        else if (user.toUpperCase().startsWith("DEPT:")){
            user = user.split("DEPT:")[1];
            groupType = "DEPARTMENT";
            id = getDepartmentIdByName(user);
        }
        else if (user.toUpperCase().startsWith("FAC:")){
            user = user.split("FAC:")[1];
            groupType = "FACILITY";
            id = getFacilityIdByName(user);
        }
        else{
            groupType = "PERSONNEL";
            id = getPersonnelIdByUsername(user);
        }

        for (int index = 0; index < getJsonArr().size(); index++){
            tempBool = false;
            if (((JSONObject) getJsonArr().get(index)).get("groupType").equals(groupType) &&
                    ((JSONObject) getJsonArr().get(index)).get("accessLevel").equals(accessLevel)){
                tempBool = true;
                //Removing entire object as of now. I guess will have to remove element based on ids.
                getJsonArr().remove(index);
                break;
            }
        }
    }


    public void setAlias(String listAlias) {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        getJsonObject().put("alias", listAlias);
    }


    public void setListType(String listType) {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        listType = listType.toUpperCase();
        if (listType.equals("LIST") || listType.equals("ASSIGNMENT") || listType.equals("VIEW")){
            getJsonObject().put("listType", listType);
        }
    }


    public void addSourceLists(List<String> sourceLists, String listType) throws SQLException, ParseException {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        if (listType.equals("VIEW")){
            String tempStr = "";
            for (String list : sourceLists){
                Object sourceID = getPatientListId(list, null, null);
                String sourceListType = (String) getPatientListTypeById(sourceID);
                String sourceListOwner = (String) getPatientListOwner(list);
                String jsonStr = "{\"patientListId\":\"" + sourceID + "\",\"listType\":\"" + sourceListType + "\",\"listOwner\":{\"label\":\"" + sourceListOwner + "\",\"value\":\"\"}}";
                if (tempStr.equals(""))
                    tempStr = tempStr + jsonStr;
                else
                    tempStr = tempStr + "," + jsonStr;
            }
            tempStr = "[" + tempStr + "]";
            JSONParser parser = new JSONParser();
            getJsonObject().put("sourceLists", parser.parse(tempStr));
            System.out.println(getJsonObject().toJSONString());
        }
    }


    public void addSubLists(List<String> subLists, String listType) throws SQLException, ParseException {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        if (listType.equals("ASSIGNMENT")){
            String tempStr = "";
            String subListType = "SUB_LIST";
            for (String list : subLists){
                String jsonStr = "{\"listType\":\"" + subListType + "\",\"patientListId\":\"\",\"name\":\"" + list + "\"}";
                if (tempStr.equals(""))
                    tempStr = tempStr + jsonStr;
                else
                    tempStr = tempStr + "," + jsonStr;
            }
            tempStr = "[" + tempStr + "]";
            JSONParser parser = new JSONParser();
            getJsonObject().put("subLists", parser.parse(tempStr));
            System.out.println(getJsonObject().toJSONString());
        }
    }

    public void setFavorite(String value) {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        value = value.toLowerCase();
        getJsonObject().put("favorite", value);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    public void setDescription(String value) {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        getJsonObject().put("description", value);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    public void addTimeCriteria(String cname, String addPat, String removePat){
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");



        if(StringUtils.isEmpty(cname)){
            UtilFunctions.log("No time criteria mentioned to add in the mentioned patient list");
        }
        else {
            String[] cnameArr = cname.split(" ");
            cname = cnameArr[0];

//            getJsonObject().put("timeBasedCriteria",);

        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    public boolean getInfacility(String cname){
        if(cname.equals("Outpatient")){
            return true;
        }
        else {
            return false;
        }
    }

    public boolean getRemoveNowValue(String removePat){
        if(removePat.contains("Immediately")){
            return true;
        }
        else {
            return false;
        }
    }

    public Object getEventDaysCount(String addPat, String removePat){

        Object obj = null;
        Pattern pattern = Pattern.compile("\\d+");
        if(StringUtils.isNotEmpty(addPat)){
            if(addPat.contains("Admit Date")){
                obj = 0;
            }
            else if(addPat.contains("On Discharge Date")){
                obj = 0;
            }
            else if(addPat.contains("Never")){
                obj = null;
            }
            else if(addPat.contains("Scheduled Date")){
                obj = 0;
            }
            else if(addPat.contains("days")){
                Matcher matcher = pattern.matcher(addPat);
                Object days = matcher.group();
                obj = days;
            }
        }
        else {
            if (removePat == null)
                return null;

            if(removePat.contains("Admit Date")){
                obj = 0;
            }
            else if(removePat.contains("On Discharge Date")){
                obj = 0;
            }
            else if(removePat.contains("Never")){
                obj = null;
            }
            else if(removePat.contains("Scheduled Date")){
                obj = 0;
            }
            else if(removePat.contains("Immediately")){
                obj = null;
            }
            else if(removePat.contains("days")){
                Matcher matcher = pattern.matcher(addPat);
                Object days = matcher.group();
                obj = days;
            }
        }
        return obj;
    }
}
