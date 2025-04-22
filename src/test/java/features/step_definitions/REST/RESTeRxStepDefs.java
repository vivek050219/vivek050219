package features.step_definitions.REST;

import api_RestAssured.RequestResponseCommon;
import api_RestAssured.apiDataRepository.APIPayload;
import api_RestAssured.page.RESTeRxPage;
import cucumber.api.DataTable;
import cucumber.api.java.en.And;
import cucumber.api.java.en.When;
import org.json.simple.parser.JSONParser;
import org.junit.Assert;
import org.w3c.dom.Document;
import testData.CreateERXTestData;
import utils.UtilFunctions;
import utils.UtilProperty;

import java.io.FileReader;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import static api_RestAssured.utils.UtilFunctions.getURL;

/**
 * Created by Atripathi on 10/6/2016.
 */
public class RESTeRxStepDefs extends RequestResponseCommon {

    public String className = getClass().getSimpleName();

    @When("^API: I set the following as payload(?: and check for status code \"(.*?)\")?$")
    public void setPayload(String statusCode, DataTable dataTable) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        List<Map<String, String>> dataList = dataTable.asMaps(String.class, String.class);
        String url = getURL("");

        UtilFunctions.log("URL: " + url);

        APIPayload apiPayload = new APIPayload();
        apiPayload = RESTeRxPage.
                setPayloadProperties(apiPayload, dataList);

        response = request.contentType("application/json").body(apiPayload).when().post(url);
        Thread.sleep(1000);
        //UtilFunctions.log("Response: " + response.body().asString());
        UtilFunctions.log("Response: " + response.body().prettyPrint());

        if (statusCode == null)
            json = response.then().statusCode(200);
        else
            json = response.then().statusCode(Integer.parseInt(statusCode));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^API: I set file \"(.*?)\" present at location \"(.*?)\" as payload and update the following$")
    public void setXMLPayload(String fileName, String fileLocation, DataTable dataTable) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        List<Map<String, String>> dataList = dataTable.asMaps(String.class, String.class);
        String url = getURL("");

        if (url.contains("ss/process"))
            url = url.replace("api/", "");

        UtilFunctions.log("URL: " + url);

        String filePath = UtilProperty.sMainDir + "\\src\\test\\java\\testData" + fileLocation.replace("/", "\\") + fileName + ".xml";

        List<String> itemToUpdateList = new ArrayList<>();
        itemToUpdateList = dataTable.asList(String.class);
        RESTeRxPage.updateXML(filePath, itemToUpdateList);

        String requestBody = new String(Files.readAllBytes(Paths.get(filePath)));

        UtilFunctions.deleteFile(filePath);

        response = request.contentType("application/xml").body(requestBody).when().post(url);
        Thread.sleep(1000);
        //UtilFunctions.log("Response: " + response.body().asString());
        UtilFunctions.log("Response: " + response.body().prettyPrint());

        json = response.then().statusCode(200);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^API: I set the following as params(?: and check for status code \"(.*?)\")?$")
    public void setParams(String statusCode, DataTable dataTable) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        List<Map<String, String>> dataList = dataTable.asMaps(String.class, String.class);
        String url = getURL("");

        UtilFunctions.log("URL: " + url);

        for (Map<String, String> map : dataList) {
            request = request.param(map.get("Type"), map.get("Value"));
        }

        response = request.when().get(url);
        Thread.sleep(1000);
        //UtilFunctions.log("Response: " + response.body().asString());
        UtilFunctions.log("Response: " + response.body().prettyPrint());

        if (statusCode == null)
            json = response.then().statusCode(200);
        else
            json = response.then().statusCode(Integer.parseInt(statusCode));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^API: I add reference id in URL(?: and check for status code \"(.*?)\")?$")
    public void modifyURLForReferenceID(String statusCode) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        String url = getURL("");
        url = url + RESTeRxPage.setID;

        UtilFunctions.log("URL: " + url);

        Thread.sleep(5000);
        response = request.when().get(url);
        Thread.sleep(1000);
        UtilFunctions.log("Response: " + response.body().prettyPrint());

        if (statusCode == null)
            json = response.then().statusCode(200);
        else
            json = response.then().statusCode(Integer.parseInt(statusCode));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @And("^API: I validate the (?:medID|pharmacy no|pharmacy) \"(.*?)\" response with pre-saved response at \"(.*?)\"$")
    public void validateResponse(String medID, String responseLocation) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String responsePath = UtilProperty.sMainDir + "\\src\\test\\java\\testData" + responseLocation.replace("/", "\\") + medID + ".json";

        if (UtilProperty.erxCreateJSON.equalsIgnoreCase("YES")){
            StringBuilder responseStr = new StringBuilder(response.prettyPrint());
            Assert.assertTrue("File not created:\n" + responsePath, CreateERXTestData.createERXJSONData(responseStr, responsePath));
        }

        try {
            Object savedResponse;
            JSONParser parser = new JSONParser();
            savedResponse = parser.parse(new FileReader(responsePath));

            System.out.println(savedResponse.toString());

            Assert.assertTrue("Saved and received response does not match.", RESTeRxPage.validateResponse(savedResponse, response, responseLocation));
            System.out.println("");

        } catch (Exception e) {
            e.printStackTrace();
            UtilFunctions.log(new StringBuilder().append("Saved Response and Received Response did not match. Exception received: ").append(e.getMessage()).toString());
            Assert.assertTrue("Exception: " + e.getMessage(), false);
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @And("^API: I validate the message \"(.*?)\"$")
    public void validateResponse(String messageToValidate) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String responseString = response.body().prettyPrint();
        Assert.assertNotNull("Response body is null.", responseString);

        if (!responseString.contains(messageToValidate))
            Assert.assertTrue("Message to validate: " + messageToValidate + " is not present in Response String: " + responseString, false);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @And("^API: I validate the \"(.*?)\" xml response sent to SS by ERX for medID \"(.*?)\" with pre-saved response at \"(.*?)\"$")
    public void validateXMLFromDbWithSavedResponse(String apiType, String medID, String responseLocation) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String responsePath = UtilProperty.sMainDir + "\\src\\test\\java\\testData" + responseLocation.replace("/", "\\") + medID + ".xml";

        long addWhereId = 0;
        addWhereId = RESTeRxPage.setID;

        String addWhere = "id=" + addWhereId + " and erx_aggregate.is_outgoing_to_ss='true'";
        String addJoin = "prescription_order_envelope on prescription_order_envelope.composite_id=erx_aggregate.composite_id";

        String dbXMLStr = api_RestAssured.utils.UtilFunctions.getValueFromTableInSQLServer(
                "erx_aggregate", "MSG_DETAILS", addWhere, addJoin, 180);

        Document xmlFromDBDoc = api_RestAssured.utils.UtilFunctions.getXMLDocFromString(dbXMLStr);
        xmlFromDBDoc = api_RestAssured.utils.UtilFunctions.removeNodeFromXML(xmlFromDBDoc, "Header");
        xmlFromDBDoc = api_RestAssured.utils.UtilFunctions.removeNodeFromXML(xmlFromDBDoc, "WrittenDate");
        xmlFromDBDoc = api_RestAssured.utils.UtilFunctions.removeNodeFromXML(xmlFromDBDoc, "MutuallyDefined");

        List<String> attributeListToRemove = Arrays.asList("version", "release", "xmlns");
        xmlFromDBDoc = api_RestAssured.utils.UtilFunctions.removeAttributeFromNodeFromXML(xmlFromDBDoc, "Message", attributeListToRemove);

        if (UtilProperty.erxCreateJSON.equalsIgnoreCase("YES")) {
            StringBuilder responseStr = new StringBuilder(api_RestAssured.utils.UtilFunctions.getStringFromXMLDoc(xmlFromDBDoc));
            Assert.assertTrue("File not created:\n" + responsePath, CreateERXTestData.createERXJSONData(responseStr, responsePath));
        }

        Document savedXMLDoc = api_RestAssured.utils.UtilFunctions.getXMLDocFromFilePath(responsePath);

        List<?> allDifferences = api_RestAssured.utils.UtilFunctions.compareXMLObjects(xmlFromDBDoc, savedXMLDoc);
        Assert.assertEquals("Differences found: "+ allDifferences.toString(), 0, allDifferences.size());

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }
}