package api;

import features.Hooks;
import org.junit.Assert;
import org.openqa.selenium.Cookie;
import utils.UtilFunctions;
import utils.UtilProperty;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.Set;

/**
 * Created by PatientKeeper on 10/6/2016.
 */
public class RequestResponse extends RequestResponseGetterSetter{

    protected URL url;
    private String authorization = "Basic cGthZG1pbjoxMjM=";
    private String cookies = "";

    //FOR PLV2LVL3 USER
    //private final String authorization = "Basic cGx2Mmx2bDM6MTIz";
    //FOR PKADMIN USER
    //private final String authorization = "Basic cGthZG1pbjoxMjM=";

//    String userpass = Hooks.loggedInUser + ":" + UtilProperty.userPwd;
//    String basicAuth = "Basic " + javax.xml.bind.DatatypeConverter.printBase64Binary(userpass.getBytes());

    protected HttpURLConnection conn;
    protected String requestProperty1 = "Accept";
    protected String requestProperty2 = "Content-Type";
    protected String requestProperty3 = "application/json";

    public String getAuthorization() {
        return authorization;
    }

    public void setAuthorization(String userName) {
        if (userName != null && !userName.equals("")) {
            String userpass = userName + ":" + UtilProperty.userPwd;
            authorization = "Basic " + javax.xml.bind.DatatypeConverter.printBase64Binary(userpass.getBytes());
        }
    }

    public void setCookies() {
        Set<Cookie> seleniumCookies = Hooks.getDriver().manage().getCookies();
        for (Object itemCookie : seleniumCookies) {
            if (((org.openqa.selenium.Cookie) itemCookie).getName().equals("JSESSIONID")) {
                cookies = ((org.openqa.selenium.Cookie) itemCookie).getName() + "=" + ((org.openqa.selenium.Cookie) itemCookie).getValue();
                break;
            }
        }
    }

    public RequestResponse() {
    }

    private void makeConnection() {
        try {
            url = new URL(getUrlName());
            conn = (HttpURLConnection) url.openConnection();
            conn.setRequestProperty("Cookie", cookies);

            if (getRequestType().equals("PATCH")) {
                conn.setRequestProperty("X-HTTP-Method-Override", "PATCH");
                setRequestType("POST");
            }
//            else if (getRequestType().equals("PUT")){
//                setRequestType("PUT");
//            }
//            else if (getRequestType().equals("POST")){
//                setRequestType("POST");
//            }

            conn.setRequestMethod(getRequestType());
        } catch (IOException e) {
            e.printStackTrace();
            UtilFunctions.log("Connection Exception: " + e.getMessage());
        }
    }


    protected String getRequest(){
        makeConnection();
        conn.setRequestProperty(requestProperty1, requestProperty3);
        conn.setRequestProperty("authorization", authorization);
        String response = getResponse();
        UtilFunctions.log("Response: " + response);
        return response;
    }


    protected String putRequest(APICommon... apiCommon){
        return postRequest(apiCommon);
    }


    protected String postRequest(APICommon... apiCommon) {
        makeConnection();
        String msg = null;
        try {
            byte[] postData = new byte[0];
            if (getUrlParameters() == null) {
                if (apiCommon.length > 0) {
                    try {
                        msg = apiCommon[0].getJsonObject().toJSONString();
                    }
                    catch(Exception e){
                        msg = apiCommon[0].getJsonArr().toJSONString();
                    }
                }
                else
                    msg = api.utils.UtilFunctions.convertJSONFileToString(getJsonFile());
                msg = msg.replace("[[","[");
                msg = msg.replace("]]","]");
                if (msg == null) {
                    UtilFunctions.log("JSON File's: " + getJsonFile() + " Object is null. Returning null.");
                    return null;
                } else {
                    conn.setRequestProperty(requestProperty2, requestProperty3);
                    conn.setRequestProperty(requestProperty1, requestProperty3);
                    conn.setRequestProperty("authorization", authorization);
                }
            } else {
                postData = getUrlParameters().getBytes(StandardCharsets.UTF_8);
                int postDataLength = postData.length;
                conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
                conn.setRequestProperty("charset", "utf-8");
                conn.setRequestProperty("Content-Length", Integer.toString(postDataLength));
                conn.setUseCaches(false);
            }
            conn.setDoOutput(true);
            conn.connect();
            if (msg == null) {
                DataOutputStream wr = new DataOutputStream( conn.getOutputStream());
                wr.write(postData);
                wr.flush();
                wr.close();
            }
            else {
                OutputStream os = conn.getOutputStream();
                OutputStreamWriter osw = new OutputStreamWriter(os);
                osw.write(msg);
                osw.flush();
                osw.close();
            }

            String response = getResponse();
            UtilFunctions.log("Response: " + response);
            return response;
        }
        catch (IOException e) {
            e.printStackTrace();
            UtilFunctions.log("Exception: " + e.getMessage());
            return null;
        }
    }

    private String getResponse() {
        String retResponse = "";
        try {
            if (conn.getResponseCode() != 200 && conn.getResponseCode() != 201){
                UtilFunctions.log("HTTP error code: " + conn.getResponseCode());
                Assert.assertTrue("HTTP error code", false);
                return null;
            }
            else {
                String line;
                BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                while ((line = reader.readLine()) != null) {
                    System.out.println(line);
                    retResponse = retResponse + line;
                }
                reader.close();
            }

        } catch (IOException e) {
            e.printStackTrace();
            UtilFunctions.log("Connection Exception: " + e.getMessage());
            return null;
        }
        return retResponse;
    }
}
