package api_RestAssured.utils;

import features.step_definitions.REST.RESTGlobalStepDefs;
import org.custommonkey.xmlunit.DetailedDiff;
import org.custommonkey.xmlunit.XMLUnit;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import support.db.DBExecutor;
import utils.UtilProperty;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import java.io.*;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

/**
 * Created by PatientKeeper on 10/7/2016.
 */
public class UtilFunctions {

    public String className = getClass().getSimpleName();
    private static api.utils.UtilFunctions utilFunctions = new api.utils.UtilFunctions();

    public static String restURL = "api/";
    public static String plv2RestURL = "mcp/pl/api/v2/";
    public static String eRxRestURL = "api/";

    public static String jsonFileFolderLoc = "\\src\\test\\java\\api\\requestJSON\\";
    private static String jsonAPILoc = "\\src\\test\\java\\api\\apiRepository\\";

    private static String cookieID = "";

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


    public static String getURL(String urlType, String... type){
        utils.UtilFunctions.log("Class: " + utilFunctions.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        String rest;
        if (type.length > 0 && type[0] != null && !type[0].equals("")){
            switch(type[0]){
                case "plv2":
                    rest = plv2RestURL;
                    break;
                case "eRx":
                    rest = eRxRestURL;
                    break;
                default:
                    rest = restURL;
            }
        }
        else
            rest = restURL;

        if (!RESTGlobalStepDefs.globalURLType.equals(""))
            return UtilProperty.apiURL + rest + RESTGlobalStepDefs.globalURLType;
        else
            return UtilProperty.apiURL + rest + urlType;
    }


    public static String replaceStringBasedOnTimeInterval(String main, String replace, String replaceWith, String duration) throws SQLException, ParseException {
        utils.UtilFunctions.log("Class: " + utilFunctions.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        String retStr = "";
        if (duration != null && !duration.equals("")){
            duration = duration.replace(" ", "");
            switch(duration){
                case "Last24Hours":
                    replaceWith = replaceWith + " > sysdate - 1 and " + replaceWith + " < sysdate";
                    retStr = main.replace(replace, replaceWith);
                    return retStr;
                case "Last48Hours":
                    replaceWith = replaceWith + " > sysdate - 2 and " + replaceWith + " < sysdate";
                    retStr = main.replace(replace, replaceWith);
                    return retStr;
                case "Last5Days":
                    replaceWith = replaceWith + " > sysdate - 5";
                    retStr = main.replace(replace, replaceWith);
                    return retStr;
                case "Last30Days":
                    replaceWith = replaceWith + " > sysdate - 30";
                    retStr = main.replace(replace, replaceWith);
                    return retStr;
                case "Last90Days":
                    replaceWith = replaceWith + " > sysdate - 30";
                    retStr = main.replace(replace, replaceWith);
                    return retStr;
                case "LastCalendarWeek":
                    replaceWith = replaceWith + " > sysdate - 6";
                    retStr = main.replace(replace, replaceWith);
                    return retStr;
                default:
                    break;
            }
        }
        return retStr;
    }


    public static DBExecutor addNullCheckInQuery(DBExecutor dbExecutorObj, String checkCol){
        String[] splitStr = dbExecutorObj.where.split(";;");
        String newStr = "";
        boolean occur = false;
        for (int i = 0; i < splitStr.length; i++){
            String tempStr = splitStr[i];
            if (tempStr.contains(checkCol) && !occur){
                tempStr = tempStr.replace(checkCol, "(" + checkCol);
                occur = true;
            }
            if (i == 0)
                newStr = newStr + tempStr;
            else
                newStr = newStr + ";;" + tempStr;
        }
        dbExecutorObj.where = newStr;

        dbExecutorObj.where = dbExecutorObj.where + " or " + checkCol + " is null)";
        return dbExecutorObj;
    }


    public static Document getXMLDocFromFilePath(String filePath){
        File fXmlFile = new File(filePath);
        DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
        DocumentBuilder dBuilder = null;
        try {
            dBuilder = dbFactory.newDocumentBuilder();
            Document doc = dBuilder.parse(fXmlFile);
            doc.getDocumentElement().normalize();
            return doc;
        } catch (ParserConfigurationException e) {
            e.printStackTrace();
            return null;
        } catch (SAXException e) {
            e.printStackTrace();
            return null;
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }


    public static Document getXMLDocFromString(String xmlStr){
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder;
        try
        {
            builder = factory.newDocumentBuilder();
            Document doc = builder.parse( new InputSource( new StringReader( xmlStr ) ) );
            return doc;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }


    public static void writeToNewXML(String filePath, Document doc){
        try {
            // write the content into xml file
            TransformerFactory transformerFactory = TransformerFactory.newInstance();
            Transformer transformer = transformerFactory.newTransformer();
            DOMSource source = new DOMSource(doc);
            StreamResult result = new StreamResult(new File(filePath));
            transformer.transform(source, result);
            System.out.println("Done");

        } catch (TransformerException tfe) {
            tfe.printStackTrace();
        }
    }

    public static String getValueFromTableInSQLServer(String tableName, String colName, String addWhere, String addJoin, int... waitTimeInSecs){
        DBExecutor dbExecutorObj = null;
        try {
            dbExecutorObj = new DBExecutor(tableName, colName, false, null, null, null);
            dbExecutorObj.setSQLServer(true);
            dbExecutorObj.addWhere(addWhere);

            if (addJoin != null)
                dbExecutorObj.addJoin(addJoin, "left");

            List<HashMap> rs = dbExecutorObj.executeQuery();
            if  (waitTimeInSecs.length > 0 && waitTimeInSecs[0] != 0 && rs.size() == 0){
                int waitCnt = 1;
                while (rs.size() == 0){
                    utils.UtilFunctions.log("TRYING FOR TIME: " + waitCnt);
                    System.out.println("TRYING FOR TIME: " + waitCnt);
                    if (waitCnt > waitTimeInSecs[0]) {
                        utils.UtilFunctions.log("BREAKING THE LOOP AFTER TRY COUNT: " + waitCnt);
                        break;
                    }
                    Thread.sleep(1000);
                    rs = dbExecutorObj.executeQuery();
                    waitCnt++;
                }
            }

            dbExecutorObj.setSQLServer(false);
            return "" + rs.get(rs.size() - 1).get(colName.toUpperCase());
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        } catch (InterruptedException e) {
            e.printStackTrace();
            return null;
        }
    }


    public static Document removeNodeFromXML(Document doc, String nodeToRemove){
        // retrieve the element 'link'
        try {
            Element element = (Element) doc.getElementsByTagName(nodeToRemove).item(0);

            // remove the specific node
            element.getParentNode().removeChild(element);
            doc.normalize();
            return doc;
        }
        catch (Exception e){
            return doc;
        }
    }


    public static Document removeAttributeFromNodeFromXML(Document doc, String nodeToRemove, List<String> attributeListToRemove){
        // retrieve the element 'link'
        Element element = (Element) doc.getElementsByTagName(nodeToRemove).item(0);

        // remove the specific attribute
        for (String attribute : attributeListToRemove){
            element.removeAttribute(attribute);
        }
        doc.normalize();
        return doc;
    }

    public static String getStringFromXMLDoc(Document xml) throws Exception{
        Transformer tf = TransformerFactory.newInstance().newTransformer();
        tf.setOutputProperty(OutputKeys.ENCODING, "UTF-8");
        tf.setOutputProperty(OutputKeys.INDENT, "yes");
        Writer out = new StringWriter();
        tf.transform(new DOMSource(xml), new StreamResult(out));
        utils.UtilFunctions.log(out.toString());
        return out.toString();
    }


    public static List<?> compareXMLObjects(Document doc1, Document doc2) throws Exception {
        XMLUnit.setIgnoreWhitespace(true);
        XMLUnit.setIgnoreAttributeOrder(true);

        DetailedDiff diff = new DetailedDiff(XMLUnit.compareXML(doc1, doc2));

        List<?> allDifferences = diff.getAllDifferences();
        return allDifferences;
    }


}
