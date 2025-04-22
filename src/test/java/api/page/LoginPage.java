package api.page;

import api.APICommon;
import utils.UtilProperty;

import java.io.IOException;

/**
 * Created by Atripathi on 10/6/2016.
 */
public class LoginPage {


    public void getLoginResponse(String userName) throws IOException {
        APICommon apiCommon = new APICommon("POST", null, "form_page_loading.jsp");
        String urlParameters  = "servlet=/servlet/WebAuthenticationServlet" +
                "&logoutOnUnload=true" +
                "&servlet=/servlet/WebAuthenticationServlet" +
                "&runServlet=true" +
                "&nextPage=login/form_login.jsp" +
                "&token=*" +
                "&browserType=NN" +
                "&platformType=pc" +
                "&appVersion=5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.116 Safari/537.36" +
                "&cpuType=undefined" +
                "&javaEnabled=false" +
                "&screenHeight=1080" +
                "&screenWidth=1920" +
                "&availScreenHeight=undefined" +
                "&availScreenWidth=undefined" +
                "&isTimeout=false" +
                "&absoluteurl=false" +
                "&BackendLoginOK=N" +
                "&WindowsUsername=X" +
                "&UserName=" + userName +
                "&PassWord=" + UtilProperty.userPwd;
        apiCommon.getResponse(urlParameters);

        String authString = "servlet/WebAuthenticationServlet";
        apiCommon.setUrlName(UtilProperty.apiURL + authString);
        urlParameters  = "nextPage=login/form_login.jsp" +
                "&logoutOnUnload=true" +
                "&servlet=/servlet/WebAuthenticationServlet" +
                "&servlet=/servlet/WebAuthenticationServlet" +
                "&logoutOnUnload=true" +
                "&runServlet=true" +
                "&nextPage=login/form_login.jsp" +
                "&token=*" +
                "&browserType=NN" +
                "&platformType=pc" +
                "&appVersion=5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.116 Safari/537.36" +
                "&cpuType=undefined" +
                "&javaEnabled=false" +
                "&screenHeight=1080" +
                "&screenWidth=1920" +
                "&availScreenHeight=undefined" +
                "&availScreenWidth=undefined" +
                "&isTimeout=false" +
                "&absoluteurl=" + UtilProperty.apiURL + "login/form_login.jsp" +
                "&BackendLoginOK=N" +
                "&WindowsUsername=X" +
                "&UserName=" + userName +
                "&PassWord=" + UtilProperty.userPwd;
        apiCommon.getResponse(urlParameters);
    }
}
