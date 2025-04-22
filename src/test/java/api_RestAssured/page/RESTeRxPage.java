package api_RestAssured.page;

import api_RestAssured.RequestResponseCommon;
import api_RestAssured.apiDataRepository.*;
import features.step_definitions.REST.RESTGlobalStepDefs;
import io.restassured.response.Response;
import org.joda.time.DateTime;
import org.joda.time.DateTimeZone;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.junit.Assert;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import support.db.DBExecutor;
import utils.UtilFunctions;
import utils.UtilProperty;

import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by atripathi on 6/15/2017.
 */
public class RESTeRxPage extends RequestResponseCommon {

    public String className = getClass().getSimpleName();
    private static RESTeRxPage page = new RESTeRxPage();
    private static boolean itemPresentFlag = true;

    public static long setID = 0;
    public static long setRefID = 0;

    public static APIPayload setPayloadProperties(APIPayload apiPayload, List<Map<String, String>> dataList) throws ParseException, SQLException {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        PatientDetail patientDetail = new PatientDetail();
        Name name = new Name();
        Address address = new Address();

        List<DiagnosisNomenList> diagnosisNomenLists = new ArrayList<>();
        DiagnosisNomenList diagnosisNomenList = new DiagnosisNomenList();
        DiagnosisSubelement diagnosisSubelement = new DiagnosisSubelement();

        WorkflowDetail workflowDetail = new WorkflowDetail();

        for (final Map<String, String> map : dataList){
            switch (map.get("Type")){
                case "lastName":
                    name.setLastName(map.get("Value"));
                    break;
                case "firstName":
                    name.setFirstName(map.get("Value"));
                    break;
                case "middleName":
                    if (!map.get("Value").equals("null"))
                        name.setMiddleName(map.get("Value"));
                    else
                        name.setMiddleName(null);
                    break;
                case "suffix":
                    if (!map.get("Value").equals("null"))
                        name.setSuffix(map.get("Value"));
                    else
                        name.setSuffix(null);
                    break;
                case "prefix":
                    if (!map.get("Value").equals("null"))
                        name.setPrefix(map.get("Value"));
                    else
                        name.setPrefix(null);
                    break;
                case "address1":
                    if (!map.get("Value").equals("null"))
                        address.setAddress1(map.get("Value"));
                    else
                        address.setAddress1(null);
                    break;
                case "address2":
                    if (!map.get("Value").equals("null"))
                        address.setAddress2(map.get("Value"));
                    else
                        address.setAddress2(null);
                    break;
                case "city":
                    if (!map.get("Value").equals("null"))
                        address.setCity(map.get("Value"));
                    else
                        address.setCity(null);
                    break;
                case "state":
                    if (!map.get("Value").equals("null"))
                        address.setState(map.get("Value"));
                    else
                        address.setState(null);
                    break;
                case "postalCode":
                    address.setPostalCode(map.get("Value"));
                    break;
                case "country":
                    if (!map.get("Value").equals("null"))
                        address.setCountry(map.get("Value"));
                    else
                        address.setCountry(null);
                    break;
                case "dob":
                    patientDetail.setDob(Long.valueOf(map.get("Value")));
                    break;
                case "gender":
                    patientDetail.setGender(map.get("Value"));
                    break;
                case "diagnosisNomenList":
                    if (!map.get("Value").equals("null"))
                        patientDetail.setDiagnosisNomenLists(null);
                    else
                        patientDetail.setDiagnosisNomenLists(null);
                    break;
                case "diagnosisNomenList_clinicalInformationQualifier":
                    if (!map.get("Value").equals("null"))
                        diagnosisNomenList.setClinicalInformationQualifier(map.get("Value"));
                    else
                        diagnosisNomenList.setClinicalInformationQualifier(null);
                    break;
                case "diagnosisSubelement_qualifier":
                    if (!map.get("Value").equals("null"))
                        diagnosisSubelement.setQualifier(map.get("Value"));
                    else
                        diagnosisSubelement.setQualifier(null);
                    break;
                case "diagnosisSubelement_value":
                    if (!map.get("Value").equals("null"))
                        diagnosisSubelement.setValue(map.get("Value"));
                    else
                        diagnosisSubelement.setValue(null);
                    break;
                case "phone":
                    List<HashMap> numberMapList = new ArrayList<>();
                    if (!map.get("Value").equals("null")){
                        String[] numberArr = map.get("Value").split(",");
                        for (String number : numberArr){
                            HashMap<String, String> tempMap = new HashMap<>();
                            tempMap.put("number", number.trim());
                            tempMap.put("qualifier", "TE");
                            numberMapList.add(tempMap);
                        }
                    }
                    else{
                        HashMap<String, String> tempMap = new HashMap<>();
                        tempMap.put("number", null);
                        tempMap.put("qualifier", "TE");
                        numberMapList.add(tempMap);
                    }
                    patientDetail.setPhone(numberMapList);
                    break;
                case "phone_newPrescription":
                    List<HashMap> numberMapList2 = new ArrayList<>();
                    if (!map.get("Value").equals("null")){
                        String[] numberArr = map.get("Value").split(",");
                        for (String number : numberArr){
                            HashMap<String, String> tempMap = new HashMap<>();
                            tempMap.put("number", number.trim());
                            tempMap.put("qualifier", "TE");
                            numberMapList2.add(tempMap);
                        }
                    }
                    else{
                        patientDetail.setPhone(null);
                        break;
                    }
                    patientDetail.setPhone(numberMapList2);
                    break;
                case "medId":
                    String id = String.valueOf(map.get("Value")).split("_")[0];
                    //apiPayload.setMedId(Integer.valueOf(map.get("Value")));
                    apiPayload.setMedId(Integer.valueOf(id));
                    break;
                case "prescriberSpi":
                    apiPayload.setPrescriberSpi(map.get("Value"));
                    break;
                case "id":
                    if (Integer.parseInt(map.get("Value")) > 0) {
                        DBExecutor dbExecutorObj = new DBExecutor("new_prescription", "id", false, null, null, null);
                        dbExecutorObj.setSQLite(true);
                        List<HashMap> rs = dbExecutorObj.executeQuery();
                        long maxID = 0;
                        for (HashMap sqlMap : rs) {
                            if (Long.parseLong(String.valueOf(sqlMap.get("ID"))) > maxID)
                                maxID = Long.parseLong(String.valueOf(sqlMap.get("ID")));
                        }
                        apiPayload.setId(maxID);

                        setID = maxID;

                        //SET updated ID in SQLite DB
                        maxID = maxID + 1;
                        String updateQuery = "update new_prescription SET id=" + maxID + ";";
                        dbExecutorObj.executeQuery(updateQuery);
                        dbExecutorObj.setSQLite(false);
                    }
                    else{
                        apiPayload.setId(Long.parseLong(map.get("Value")));
                    }
                    break;
                case "refId":
                    if (map.get("Value") != null &&
                            !map.get("Value").equals("null") &&
                            map.get("Value").replace(" ", "").toLowerCase().equalsIgnoreCase("previoussetid")){
                        setRefID = setID - 1;
                        apiPayload.setRefId(setRefID);
                    }
                    break;
                case "ndc":
                    if (!map.get("Value").equals("null"))
                        apiPayload.setNdc(map.get("Value"));
                    else
                        apiPayload.setNdc(null);
                    break;
                case "strength":
                    if (!map.get("Value").equals("null"))
                        apiPayload.setStrength(map.get("Value"));
                    else
                        apiPayload.setStrength(null);
                    break;
                case "prescriberAgentSpi":
                    if (!map.get("Value").equals("null"))
                        apiPayload.setPrescriberAgentSpi(map.get("Value"));
                    else
                        apiPayload.setPrescriberAgentSpi(null);
                    break;
                case "supervisorSpi":
                    if (!map.get("Value").equals("null"))
                        apiPayload.setSupervisorSpi(map.get("Value"));
                    else
                        apiPayload.setSupervisorSpi(null);
                    break;
                case "pharmacyId":
                    if (!map.get("Value").equals("null"))
                        apiPayload.setPharmacyId(map.get("Value"));
                    else
                        apiPayload.setPharmacyId(null);
                    break;
                case "drugDescription":
                    if (!map.get("Value").equals("null"))
                        apiPayload.setDrugDescription(map.get("Value"));
                    else
                        apiPayload.setDrugDescription(null);
                    break;
                case "quantity":
                    if (!map.get("Value").equals("null"))
                        apiPayload.setQuantity(map.get("Value"));
                    else
                        apiPayload.setQuantity(null);
                    break;
                case "potencyUnitCode":
                    if (!map.get("Value").equals("null"))
                        apiPayload.setPotencyUnitCode(map.get("Value"));
                    else
                        apiPayload.setPotencyUnitCode(null);
                    break;
                case "directions":
                    if (!map.get("Value").equals("null"))
                        apiPayload.setDirections(map.get("Value"));
                    else
                        apiPayload.setDirections(null);
                    break;
                case "note":
                    if (!map.get("Value").equals("null"))
                        apiPayload.setNote(map.get("Value"));
                    else
                        apiPayload.setNote(null);
                    break;
                case "refills":
                    apiPayload.setRefills(Integer.parseInt(map.get("Value")));
                    break;
                case "daysSupply":
                    apiPayload.setDaysSupply(Integer.parseInt(map.get("Value")));
                    break;
                case "substitutions":
                    apiPayload.setSubstitutions(Boolean.parseBoolean(map.get("Value")));
                    break;
                case "writtenDate":
                    if (!map.get("Value").equals("null")) {
                        long unixTime = System.currentTimeMillis();
                        //apiPayload.setWrittenDate(Long.parseLong(map.get("Value")));
                        //apiPayload.setWrittenDate(Long.parseLong(String.valueOf(unixTime)));\
                        apiPayload.setWrittenDate((String.valueOf(unixTime)));
                    }
                    else {
                        apiPayload.setWrittenDate(null);
                    }
                    break;
                case "payerId":
                    if (!map.get("Value").equals("null"))
                        apiPayload.setPayerId(map.get("Value"));
                    else
                        apiPayload.setPayerId(null);
                    break;
                case "planNetworkId":
                    if (!map.get("Value").equals("null"))
                        apiPayload.setPlanNetworkId(map.get("Value"));
                    else
                        apiPayload.setPlanNetworkId(null);
                    break;
                case "includeRxNorm":
                    apiPayload.setIncludeRxNorm(Boolean.parseBoolean(map.get("Value")));
                    break;
                case "targetLatitude":
                    if (!map.get("Value").equals("null"))
                        apiPayload.setTargetLatitude(map.get("Value"));
                    else
                        apiPayload.setTargetLatitude(null);
                    break;
                case "targetLongitude":
                    if (!map.get("Value").equals("null"))
                        apiPayload.setTargetLongitude(map.get("Value"));
                    else
                        apiPayload.setTargetLongitude(null);
                    break;
                case "maxDistanceInMiles":
                    if (!map.get("Value").equals("null"))
                        apiPayload.setMaxDistanceInMiles(map.get("Value"));
                    else
                        apiPayload.setMaxDistanceInMiles(null);
                    break;
                case "cityList":
                    if (!map.get("Value").equals("null"))
                        apiPayload.setCityList(new ArrayList<String>() {{
                            add(map.get("Value"));
                        }});
                    else
                        apiPayload.setCityList(null);
                    break;
                case "orgNamesList":
                    if (!map.get("Value").equals("null"))
                        apiPayload.setOrgNamesList(new ArrayList<String>() {{
                            add(map.get("Value"));
                        }});
                    else
                        apiPayload.setOrgNamesList(null);
                    break;
                case "benefitsCoordinationRequestList":
                    if (!map.get("Value").equals("null"))
                        workflowDetail.setBenefitsCoordinationRequestList(map.get("Value"));
                    else
                        workflowDetail.setBenefitsCoordinationRequestList(null);
                    break;
                case "effectiveDate":
                    workflowDetail.setEffectiveDate(map.get("Value"));
                    break;
                case "expirationDate":
//                    workflowDetail.setExpirationDate(map.get("Value"));
                    if (!map.get("Value").equals("null")) {
                        if (map.get("Value").contains("${now}")) {
                            //long unixTime = System.currentTimeMillis();
                            //workflowDetail.setExpirationDate((String.valueOf(unixTime)));
                            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                            Date date = new Date();
                            System.out.println(dateFormat.format(date)); //2016/11/16 12:08:43
                            workflowDetail.setExpirationDate((String.valueOf(dateFormat.format(date))));
                        }
                        else
                            workflowDetail.setExpirationDate(map.get("Value"));
                    }
                    else {
                        workflowDetail.setExpirationDate(null);
                    }
                    break;
                case "consent":
                    if (!map.get("Value").equals("null"))
                        workflowDetail.setConsent(map.get("Value"));
                    else
                        workflowDetail.setConsent(null);
                    break;
                default:
                    break;
            }
        }

        patientDetail.setName(name);
        patientDetail.setAddress(address);
        apiPayload.setPatient(patientDetail);

        if (UtilProperty.sectionName.toLowerCase().contains("erxv2")
                && RESTGlobalStepDefs.globalURLType.toLowerCase().contains("medhistory"))
            apiPayload.setWorkflowDetail(workflowDetail);

        diagnosisNomenList.setDiagnosisSubelement(diagnosisSubelement);
        if (diagnosisNomenList.getClinicalInformationQualifier() != null)
            diagnosisNomenLists.add(diagnosisNomenList);
        if (diagnosisNomenLists.size() > 0)
            patientDetail.setDiagnosisNomenLists(diagnosisNomenLists);

        return apiPayload;
    }


    public static boolean validateResponse(Object savedResponse, Response response, String responseLocation) throws ParseException, SQLException {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        List<String> doNotCheck;

        if (responseLocation.replace(" ", "").contains("FormularyMedications")){
            doNotCheck = Arrays.asList("ndc");
            if (validateFormularyMedicationsResponse(savedResponse, response, "medications", doNotCheck)){
                doNotCheck = Arrays.asList("interchangeControlNumber");
                return validateFormularyMedicationsResponse(savedResponse, response, "payerCoverageInfo", doNotCheck);
            }
        }
        else if (responseLocation.replace(" ", "").contains("RequestBenefits")){
            if (validateRequestBenefitsResponse(savedResponse, response, "eventId")){
                doNotCheck = Arrays.asList("interchangeControlNumber", "dob");
                return validateRequestBenefitsResponse(savedResponse, response, "message", doNotCheck);
            }
        }
        else if (responseLocation.replace(" ", "").contains("NewPrescription")){
            return validateRequestBenefitsResponse(savedResponse, response, "message");
        }
        else if (responseLocation.replace(" ", "").contains("NewRxJSON")){
            return validateRequestBenefitsResponse(savedResponse, response, "message");
        }
        else if (responseLocation.replace(" ", "").contains("Pharmacy")){
            doNotCheck = Arrays.asList("startTime", "specialtyType", "lastModifiedDate");
            if (validatePharmacyResponse(savedResponse, response, "pharmacies", doNotCheck)){
                if (validatePharmacyResponse(savedResponse, response, "foundCityList")){
                    return validatePharmacyResponse(savedResponse, response, "foundOrganizationNameList", doNotCheck);
                }
            }
        }
        else if (responseLocation.replace(" ", "").contains("MedHistory")){
            doNotCheck = Arrays.asList("expirationDate", "lastFillDate", "relatesToMessageId", "interchangeControlNumber", "drugDBCode", "drugDBCodeQualifier", "value", "diagnosis");
            if (validateMedHistoryResponse(savedResponse, response, "medHistoryResponseList", doNotCheck))
                return  validateMedHistoryResponse(savedResponse, response, "medHistoryErrorList", doNotCheck);
        }
        else if (responseLocation.replace(" ", "").contains("CancelRxJSON")){
            return validateRequestBenefitsResponse(savedResponse, response, "message");
        }
        else if (responseLocation.replace(" ", "").contains("CancelRxFinalResponse")){
            doNotCheck = Arrays.asList("cancelOrderId");
            return validateCancelRxResponse(savedResponse, response, "approvedOrDenied", doNotCheck);
        }
        return false;
    }


    public static boolean validateFormularyMedicationsResponse(Object savedResponse, Response response, String itemToValidate, List... doNotCheck) throws ParseException, SQLException {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        itemPresentFlag = true;

        List<HashMap> savedMedicationsList = new ArrayList<>();
        List<HashMap> responseMedicationsList = new ArrayList<>();
        JSONParser parser = new JSONParser();
        JSONArray responseJson = (JSONArray) parser.parse(response.body().asString());

        if (((JSONObject)((JSONArray)savedResponse).get(0)).get(itemToValidate) instanceof JSONArray) {
            savedMedicationsList = (List<HashMap>) ((JSONObject) ((JSONArray) savedResponse).get(0)).get(itemToValidate);
            responseMedicationsList = (List<HashMap>) ((JSONObject) responseJson.get(0)).get(itemToValidate);
        }
        else{
            for (int i = 0; i < ((JSONArray) savedResponse).size(); i++) {
                savedMedicationsList.add((HashMap) ((JSONObject) ((JSONArray) savedResponse).get(i)).get(itemToValidate));
                responseMedicationsList.add((HashMap) ((JSONObject) responseJson.get(i)).get(itemToValidate));
            }
        }

        boolean mapPresent = true;
        int savedMedicationListSize = savedMedicationsList.size();
        for (HashMap<Object, Object> savedMedicationMap : savedMedicationsList){
            for (HashMap responseMedicationMap : responseMedicationsList) {
                mapPresent = true;
                for (Map.Entry<Object, Object> savedMapItem : savedMedicationMap.entrySet()) {

                    if (doNotCheck.length > 0 && doNotCheck[0].get(0) != null && doNotCheck[0].contains(savedMapItem.getKey()))
                        continue;
                    mapPresent = validateRecursivelyJSON(savedMapItem.getValue(), responseMedicationMap.get(savedMapItem.getKey()));
                    if (!mapPresent)
                        break;
                }
                if (mapPresent){
                    savedMedicationListSize--;
                    break;
                }
            }
            if (!mapPresent) {
                UtilFunctions.log("Following " + itemToValidate + " list map not present in response: " + savedMedicationMap.toString());
                System.out.println("\n\nFollowing " + itemToValidate + " list map not present in response: " + savedMedicationMap.toString());
                Assert.assertTrue("Following " + itemToValidate + " list map not present in response: "
                                + "\nSaved Map Value: " + savedMedicationMap.toString()
                                + "\nReceived Map Value: " + responseMedicationsList,
                        false);
            }
        }
        if (savedMedicationListSize > 0){
            UtilFunctions.log("Saved Test Data for " + itemToValidate + " Map does not match with the response. \nReturning False.");
            return false;
        }
        return true;
    }


    public static boolean validateRequestBenefitsResponse(Object savedResponse, Response response, String itemToValidate, List... doNotCheck) throws ParseException, SQLException {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        String savedRequestBenefits;
        String responseRequestBenefits;
        JSONParser parser = new JSONParser();
        JSONObject responseJson = (JSONObject) parser.parse(response.body().asString());

        savedRequestBenefits = (String) ((JSONObject) savedResponse).get(itemToValidate);
        responseRequestBenefits = (String) responseJson.get(itemToValidate);

        if (savedRequestBenefits == null){
            Assert.assertNull("Validated Item: " + itemToValidate + "\nSaved Value is null. " + "\nReceived Value: " + responseRequestBenefits,
                    responseRequestBenefits);
            return true;
        }

        if (itemToValidate.equals("message")){
            List savedRequestBenefitsList = Arrays.asList(savedRequestBenefits.split(","));
            List responseRequestBenefitsList = Arrays.asList(responseRequestBenefits.split(","));

            Assert.assertEquals("Size does not matches. Validated Item: " + itemToValidate + "\nSaved Value: " + savedRequestBenefits + "\nReceived Value: " + responseRequestBenefits,
                    savedRequestBenefitsList.size(),
                    responseRequestBenefitsList.size());

            for (Object savedItem : savedRequestBenefitsList){
                if (doNotCheck.length > 0 && doNotCheck[0].get(0) != null) {
                    boolean skipItemFlag = false;
                    for (Object itemToNotCheck : doNotCheck[0]) {
                        if (((String)savedItem).trim().contains(((String)itemToNotCheck).trim())) {
                            skipItemFlag = true;
                            break;
                        }
                    }
                    if (skipItemFlag)
                        continue;
                }
                if (responseRequestBenefitsList.contains(savedItem))
                    UtilFunctions.log("Item Present. Saved Item: " + savedItem + "\nResponse :List: " + responseRequestBenefitsList);
                else {
                    boolean itemPresentInSecondCheck = false;
                    for (Object responseItem : responseRequestBenefitsList){
                        if (((String)responseItem).trim().contains(((String)savedItem).trim())){
                            itemPresentInSecondCheck = true;
                            UtilFunctions.log("Item Present. Saved Item: " + savedItem + "\nResponse :List: " + responseRequestBenefitsList);
                            break;
                        }
                    }
                    if (!itemPresentInSecondCheck)
                        Assert.assertTrue("Item Not Present. Saved Item: " + savedItem + "\nResponse :List: " + responseRequestBenefitsList, false);
                }
            }

        }
        else {
            Assert.assertEquals("Validated Item: " + itemToValidate + "\nSaved Value: " + savedRequestBenefits + "\nReceived Value: " + responseRequestBenefits,
                    savedRequestBenefits,
                    responseRequestBenefits);
        }

        return true;
    }


    public static boolean validatePharmacyResponse(Object savedResponse, Response response, String itemToValidate, List... doNotCheck) throws ParseException, SQLException {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        itemPresentFlag = true;

        List<HashMap> savedMedicationsList = new ArrayList<>();
        List<HashMap> responseMedicationsList = new ArrayList<>();
        JSONParser parser = new JSONParser();
        JSONObject responseJson = (JSONObject) parser.parse(response.body().asString());

        if (((JSONObject)savedResponse).get(itemToValidate) instanceof JSONArray) {
            savedMedicationsList = (List<HashMap>) ((JSONObject) savedResponse).get(itemToValidate);
            responseMedicationsList = (List<HashMap>) responseJson.get(itemToValidate);
        }
        else{
            for (int i = 0; i < ((JSONArray) savedResponse).size(); i++) {
                savedMedicationsList.add((HashMap) ((JSONObject) ((JSONArray) savedResponse).get(i)).get(itemToValidate));
                responseMedicationsList.add((HashMap) ((JSONObject) responseJson.get(i)).get(itemToValidate));
            }
        }

        boolean mapPresent = true;
        int savedMedicationListSize = savedMedicationsList.size();

        if (savedMedicationListSize > 0 && savedMedicationsList.get(0) instanceof HashMap) {
            for (HashMap<Object, Object> savedMedicationMap : savedMedicationsList) {
                for (HashMap responseMedicationMap : responseMedicationsList) {
                    mapPresent = true;
                    for (Map.Entry<Object, Object> savedMapItem : savedMedicationMap.entrySet()) {

                        if (doNotCheck.length > 0 && doNotCheck[0].get(0) != null && doNotCheck[0].contains(savedMapItem.getKey()))
                            continue;
                        mapPresent = validateRecursivelyJSON(savedMapItem.getValue(), responseMedicationMap.get(savedMapItem.getKey()));
                        if (!mapPresent)
                            break;
                    }
                    if (mapPresent) {
                        savedMedicationListSize--;
                        break;
                    }
                }
                if (!mapPresent) {
                    UtilFunctions.log("Following " + itemToValidate + " list map not present in response: " + savedMedicationMap.toString());
                    System.out.println("\n\nFollowing " + itemToValidate + " list map not present in response: " + savedMedicationMap.toString());
                    Assert.assertTrue("Following " + itemToValidate + " list map not present in response: "
                                    + "\nSaved Map Value: " + savedMedicationMap.toString()
                                    + "\nReceived Map Value: " + responseMedicationsList,
                            false);
                }
            }
        }
        else if (savedMedicationListSize > 0){
            for (int i  =0; i < savedMedicationsList.size(); i++) {
                if (responseMedicationsList.contains(savedMedicationsList.get(i)))
                    savedMedicationListSize--;
                else
                    Assert.assertTrue("Saved Item in Response: " + savedMedicationsList.get(0) + " is not present in Received Response: " + responseMedicationsList,
                        false);
            }
        }

        if (savedMedicationListSize > 0){
            UtilFunctions.log("Saved Test Data for " + itemToValidate + " Map does not match with the response. \nReturning False.");
            return false;
        }
        return true;
    }


    public static boolean validateMedHistoryResponse(Object savedResponse, Response response, String itemToValidate, List doNotCheck) throws ParseException, SQLException {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        itemPresentFlag = true;

        List<HashMap> savedMedicationsList = new ArrayList<>();
        List<HashMap> responseMedicationsList = new ArrayList<>();
        JSONParser parser = new JSONParser();
        JSONObject responseJson = (JSONObject) parser.parse(response.body().asString());

        if (((JSONObject)savedResponse).get(itemToValidate) instanceof JSONArray) {
            savedMedicationsList = (List<HashMap>) ((JSONObject) savedResponse).get(itemToValidate);
            responseMedicationsList = (List<HashMap>) responseJson.get(itemToValidate);
        }
        else{
            for (int i = 0; i < ((JSONArray) savedResponse).size(); i++) {
                savedMedicationsList.add((HashMap) ((JSONObject) ((JSONArray) savedResponse).get(i)).get(itemToValidate));
                responseMedicationsList.add((HashMap) ((JSONObject) responseJson.get(i)).get(itemToValidate));
            }
        }

        boolean mapPresent = true;
        int savedMedicationListSize = savedMedicationsList.size();

        if (savedMedicationListSize > 0 && savedMedicationsList.get(0) instanceof HashMap) {
            for (HashMap<Object, Object> savedMedicationMap : savedMedicationsList) {
                for (int i = 0; i < responseMedicationsList.size(); i++) {
                    mapPresent = true;
                    for (Map.Entry<Object, Object> savedMapItem : savedMedicationMap.entrySet()) {

                        if (doNotCheck.size() > 0 && doNotCheck.contains(savedMapItem.getKey()))
                            continue;
                        mapPresent = validateRecursivelyJSON(savedMapItem.getValue(), responseMedicationsList.get(i).get(savedMapItem.getKey()), doNotCheck);
                        if (!mapPresent)
                            break;
                    }
                    if (mapPresent) {
                        savedMedicationListSize--;
                        break;
                    }
                }
                if (!mapPresent) {
                    UtilFunctions.log("Following " + itemToValidate + " list map not present in response: " + savedMedicationMap.toString());
                    System.out.println("\n\nFollowing " + itemToValidate + " list map not present in response: " + savedMedicationMap.toString());
                    Assert.assertTrue("Following " + itemToValidate + " list map not present in response: "
                                    + "\nSaved Map Value: " + savedMedicationMap.toString()
                                    + "\nReceived Map Value: " + responseMedicationsList,
                            false);
                }
            }
        }
        else if (savedMedicationListSize > 0){
            for (int i  =0; i < savedMedicationsList.size(); i++) {
                if (responseMedicationsList.contains(savedMedicationsList.get(i)))
                    savedMedicationListSize--;
                else
                    Assert.assertTrue("Saved Item in Response: " + savedMedicationsList.get(0) + " is not present in Received Response: " + responseMedicationsList,
                            false);
            }
        }

        if (savedMedicationListSize > 0){
            UtilFunctions.log("Saved Test Data for " + itemToValidate + " Map does not match with the response. \nReturning False.");
            return false;
        }
        return true;
    }


    public static boolean validateCancelRxResponse(Object savedResponse, Response response, String itemToValidate, List... doNotCheck) throws ParseException, SQLException {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        itemPresentFlag = true;

        HashMap<Object, Object> savedMedicationsMap = new HashMap();
        HashMap<Object, Object> responseMedicationsMap = new HashMap();
        JSONParser parser = new JSONParser();
        JSONObject responseJson = (JSONObject) parser.parse(response.body().asString());

        if (((JSONObject)savedResponse).get(itemToValidate) instanceof JSONObject) {
            savedMedicationsMap = (HashMap) ((JSONObject) savedResponse).get(itemToValidate);
            responseMedicationsMap = (HashMap) responseJson.get(itemToValidate);
        }

        boolean mapPresent = true;
        for (Map.Entry<Object, Object> savedMapItem : savedMedicationsMap.entrySet()) {
            if (doNotCheck.length > 0 && doNotCheck[0].get(0) != null && doNotCheck[0].contains(savedMapItem.getKey())) {
                if (savedMapItem.getKey().toString().toLowerCase().equals("cancelorderid")){
                    mapPresent = (responseMedicationsMap.get(savedMapItem.getKey()).toString().equals("" + RESTeRxPage.setID));
                }
            }
            else
                mapPresent = validateRecursivelyJSON(savedMapItem.getValue(), responseMedicationsMap.get(savedMapItem.getKey()), doNotCheck);

            if (!mapPresent)
                break;
        }
        if (!mapPresent) {
            UtilFunctions.log("Following " + itemToValidate + " list map not present in response: " + savedMedicationsMap.toString());
            System.out.println("\n\nFollowing " + itemToValidate + " list map not present in response: " + savedMedicationsMap.toString());
            Assert.assertTrue("Following " + itemToValidate + " list map not present in response: "
                            + "\nSaved Map Value: " + savedMedicationsMap.toString()
                            + "\nReceived Map Value: " + responseMedicationsMap,
                    false);
        }

        return true;
    }



    public static boolean validateRecursivelyJSON(Object savedResponse, Object response, List<String>... doNotCheck) throws ParseException, SQLException {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        if (response == null)
            return false;

        itemPresentFlag = true;
        if (savedResponse instanceof JSONObject){
            HashMap<Object, Object> tempSavedJSONMap = (HashMap) savedResponse;
            HashMap<Object, Object> tempReceivedJSONMap = (HashMap) response;
            for (Map.Entry<Object, Object> map : tempSavedJSONMap.entrySet()){
                if (map.getValue() instanceof JSONObject
                        || map.getValue() instanceof JSONArray) {
                    itemPresentFlag = validateRecursivelyJSON(map.getValue(), tempReceivedJSONMap.get(map.getKey()), doNotCheck);
                }
                else{
                    if (doNotCheck != null && doNotCheck.length > 0 && doNotCheck[0].size() > 0){
                        if (doNotCheck[0].contains(map.getKey())) {
                            UtilFunctions.log("DO NOT CHECK: " + map.getKey());
                            continue;
                        }
                    }
                    if (tempReceivedJSONMap.containsKey(map.getKey())
                            && tempReceivedJSONMap.containsValue(map.getValue())){
                        //
                    }
                    else {
                        itemPresentFlag = false;
                        break;
                    }
                }
            }
        }
        else if (savedResponse instanceof JSONArray){
            List<HashMap<Object, Object>> tempSavedJSONMapList = (List<HashMap<Object, Object>>) savedResponse;
            List<HashMap<Object, Object>> tempReceivedJSONMapList = (List<HashMap<Object, Object>>) response;

            if (tempSavedJSONMapList.size() != tempReceivedJSONMapList.size()){
                UtilFunctions.log("List Size does not match. RETURNING FALSE.");
                return false;
            }

            for (int i = 0; i < tempSavedJSONMapList.size(); i++) {
                if (tempSavedJSONMapList.get(i) instanceof HashMap) {
                    for (Map.Entry<Object, Object> map : tempSavedJSONMapList.get(i).entrySet()) {
                        if (map.getValue() instanceof JSONObject
                                || map.getValue() instanceof JSONArray) {

                            if (doNotCheck != null && doNotCheck.length > 0 && doNotCheck[0].size() > 0){
                                if (doNotCheck[0].contains(map.getKey())) {
                                    UtilFunctions.log("DO NOT CHECK: " + map.getKey());
                                    break;
                                }
                            }

                            for (int k = 0; k < tempReceivedJSONMapList.size(); k++) {
                                itemPresentFlag = validateRecursivelyJSON(map.getValue(), tempReceivedJSONMapList.get(k).get(map.getKey()), doNotCheck);
                                if (itemPresentFlag)
                                    break;
                            }
                            if (!itemPresentFlag)
                                break;
                        }
                        else {
                            boolean tempFlag = false;
                            for (HashMap tempReceivedJSONMap : tempReceivedJSONMapList) {
                                tempFlag = true;
                                if (doNotCheck != null && doNotCheck.length > 0 && doNotCheck[0].size() > 0){
                                    if (doNotCheck[0].contains(map.getKey())) {
                                        UtilFunctions.log("DO NOT CHECK: " + map.getKey());
                                        break;
                                    }
                                }

                                if (tempReceivedJSONMap.containsKey(map.getKey())
                                        && tempReceivedJSONMap.containsValue(map.getValue())) {
                                    break;
                                } else {
                                    tempFlag = false;
                                }
                            }
                            if (!tempFlag) {
                                itemPresentFlag = false;
                            }
                        }
                    }
                }
                else {
                    boolean tempFlag = false;
                    String savedStr = String.valueOf(tempSavedJSONMapList.get(i));
                    for (int j = 0; j < tempReceivedJSONMapList.size(); j++) {
                        tempFlag = true;
                        String receivedStr = String.valueOf(tempReceivedJSONMapList.get(j));
                        if (savedStr.equals(receivedStr))
                            break;
                        else {
                            tempFlag = false;
                        }
                    }
                    if (!tempFlag) {
                        itemPresentFlag = false;
                    }
                }
            }
        }
        else {
            if ((savedResponse != null && response != null && savedResponse.equals(response))
                    || (savedResponse == null && response == null)) {
                //System.out.println("Yay!!!!!");
                return true;
            } else {
                return false;
            }
        }

        return itemPresentFlag;
    }


    public static boolean updateXML(String filePath, List<String> itemToUpdateList) throws ParseException, SQLException {
        UtilFunctions.log("Class: " + page.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        Document doc = updateXMLObjForCancelRX(filePath.replace(".xml", "_Sample.xml"), itemToUpdateList);
        api_RestAssured.utils.UtilFunctions.writeToNewXML(filePath, doc);
        return true;
    }


    public static Document updateXMLObjForCancelRX(String filePath, List<String> itemToValidate){
        try {
//            File fXmlFile = new File(filePath);
//            DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
//            DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
//            Document doc = dBuilder.parse(fXmlFile);
//            doc.getDocumentElement().normalize();

            Document doc = api_RestAssured.utils.UtilFunctions.getXMLDocFromFilePath(filePath);
            for (String item : itemToValidate) {
                String[] itemArr = item.split("\\.");

                UtilFunctions.log("Root element :" + doc.getDocumentElement().getNodeName());
                NodeList nList = doc.getElementsByTagName(itemArr[1]);
                UtilFunctions.log("----------------------------");

                for (int temp = 0; temp < nList.getLength(); temp++) {
                    Node nNode = nList.item(temp);
                    UtilFunctions.log("\nCurrent Element :" + nNode.getNodeName());
                    if (nNode.getNodeType() == Node.ELEMENT_NODE) {
                        NodeList nodeList = nNode.getChildNodes();
                        for (int i = 0; i < nodeList.getLength(); i++){
                            if (itemArr[2].equalsIgnoreCase(nodeList.item(i).getNodeName())) {
                                String itemToSet = "";
                                switch (itemArr[2].toUpperCase()){
                                    case "MESSAGEID":
                                        itemToSet = api_RestAssured.utils.UtilFunctions.getValueFromTableInSQLServer(
                                                "prescription_order_envelope", "COMPOSITE_ID", "id=" + setID, null);
                                        itemToSet = itemToSet.substring(0, itemToSet.length() - ("" + setID).length());
                                        itemToSet = itemToSet + setID;
                                        break;
                                    case "RELATESTOMESSAGEID":
                                        itemToSet = api_RestAssured.utils.UtilFunctions.getValueFromTableInSQLServer(
                                                "prescription_order_envelope", "COMPOSITE_ID", "id=" + setID, null);
                                        break;
                                    case "SENTTIME":
                                        DateTime dt = new DateTime(DateTimeZone.UTC);
                                        itemToSet = dt.toString();
                                        break;
                                    case "PRESCRIBERORDERNUMBER":
                                        itemToSet = "" + (setRefID);
                                        break;
                                    default:
                                        break;
                                }

                                nNode.getChildNodes().item(i).setTextContent(itemToSet);
                                break;
                            }
                        }
                    }
                }
            }
            return doc;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }


}
