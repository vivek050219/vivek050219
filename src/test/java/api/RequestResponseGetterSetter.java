package api;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import utils.UtilFunctions;

/**
 * Created by PatientKeeper on 10/6/2016.
 */
public class RequestResponseGetterSetter {

    private String requestType;
    private String urlName;
    private String jsonFile;
    private String urlParameters;
    private JSONObject jsonObject = null;
    private JSONArray jsonArr = null;

    public JSONArray getJsonArr() {
        return jsonArr;
    }

    public void setJsonArr(JSONArray jsonArr) {
        this.jsonArr = jsonArr;
    }

    public String getRequestType() {
        return requestType;
    }

    public String getUrlName() {
        return urlName;
    }

    public String getJsonFile() {
        return jsonFile;
    }

    public String getUrlParameters() {
        return urlParameters;
    }

    public JSONObject getJsonObject() {
        return jsonObject;
    }

    public void setJsonObject(JSONObject jsonObject) {
        this.jsonObject = jsonObject;
    }

    public void setUrlParameters(String urlParameters) {
        this.urlParameters = urlParameters;
    }

    public void setJsonFile(String jsonFile) {
        this.jsonFile = jsonFile;
    }

    public void setUrlName(String urlName) {
        UtilFunctions.log("API URL Name: " + urlName);
        this.urlName = urlName;
    }

    public void setRequestType(String requestType) {
        this.requestType = requestType;
    }
}
