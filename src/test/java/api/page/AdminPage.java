package api.page;

import api.APICommon;
import org.json.simple.parser.ParseException;
import utils.UtilFunctions;
import utils.UtilProperty;

import java.io.IOException;

/**
 * Created by Atripathi on 10/7/2016.
 */
public class AdminPage {


    public boolean openCloseTabs(String checkType, String tabName){
        String restURL;
        APICommon apiCommon;
        String response;
        try {
            switch (checkType) {
                case "close":
                    restURL = "mcp/portaluxf/api/v9x/screens/?1=1&summary=true&sort=true&sortType=ORDER&screenState=OPEN&tabEnabledOnly=true&_=*";
                    apiCommon = new APICommon("GET", null, restURL);
                    response = apiCommon.getResponse(null);
                    return closeTabs(apiCommon, tabName, response);

                case "open":
                    restURL = "mcp/portaluxf/api/v9x/screens/?1=1&summary=true&sort=true&sortType=NAME&screenState=CLOSED&tabEnabledOnly=true&_=*";
                    apiCommon = new APICommon("GET", null, restURL);
                    response = apiCommon.getResponse(null);
                    return openTabs(apiCommon, tabName, response);

                default:
                    return false;
            }
        } catch (IOException e) {
            e.printStackTrace();
            UtilFunctions.log("Error in retrieving response. Exception: " + e.getMessage());
            return false;
        }
    }


    public boolean closeTabs(APICommon apiCommon, String tabName, String response) {
        try {
            String tabID = api.utils.UtilFunctions.getIDFromTabName(response, "screenSummaries", "name", tabName, "id");
            if (tabID == null) {
                UtilFunctions.log("TabName: " + tabName + " is already closed. Returning true.");
                return true;
            }
            UtilFunctions.log("TabName: " + tabName + ", TabID: " + tabID);
            String closeURL = "mcp/portaluxf/api/v9x/screens/" + tabID + "/?1=1&summary=true";

            apiCommon.setRequestType("PATCH");
            apiCommon.setJsonFile("closeTab");
            apiCommon.setUrlName(UtilProperty.apiURL + closeURL);

            String closeResponse = apiCommon.getResponse(null);
            if (closeResponse == null) {
                UtilFunctions.log("Not able to close tab: " + tabName);
                return false;
            } else {
                UtilFunctions.log("Closed tab: " + tabName);
                return true;
            }
        } catch (IOException e) {
            e.printStackTrace();
            UtilFunctions.log("Error in retrieving response. Exception: " + e.getMessage());
            return false;
        } catch (ParseException e) {
            e.printStackTrace();
            UtilFunctions.log("Parse Error in retrieving response. Parse Exception: " + e.getMessage());
            return false;
        }
    }


    public boolean openTabs(APICommon apiCommon, String tabName, String response) {
        try {
            String tabID = api.utils.UtilFunctions.getIDFromTabName(response, "screenSummaries", "name", tabName, "id");
            String orderID = api.utils.UtilFunctions.getIDFromTabName(response, "screenSummaries", "name", tabName, "order");
            if (tabID == null) {
                UtilFunctions.log("TabName: " + tabName + " is not present. Creating a new tab now.");
                return true;
            }
            UtilFunctions.log("TabName: " + tabName + ", TabID: " + tabID);
            String openURL = "mcp/portaluxf/api/v9x/screens/" + tabID + "/?1=1&summary=true";

            apiCommon.setRequestType("PATCH");
            apiCommon.setJsonFile("openTab");
            apiCommon.setUrlName(UtilProperty.apiURL + openURL);
            api.utils.UtilFunctions.updateJSONFileValue(apiCommon.getJsonFile(), "order", orderID);

            String openResponse = apiCommon.getResponse(null);
            if (openResponse == null) {
                UtilFunctions.log("Not able to open tab: " + tabName);
                return false;
            } else {
                UtilFunctions.log("Tab opened: " + tabName);
                return true;
            }
        } catch (IOException e) {
            e.printStackTrace();
            UtilFunctions.log("Error in retrieving response. Exception: " + e.getMessage());
            return false;
        } catch (ParseException e) {
            e.printStackTrace();
            UtilFunctions.log("Parse Error in retrieving response. Parse Exception: " + e.getMessage());
            return false;
        }
    }
}
