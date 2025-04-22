package api_RestAssured.support;

import api_RestAssured.RequestResponseCommon;

import java.util.HashMap;

/**
 * Created by PatientKeeper on 6/24/2016.
 */

/******************************************************************************
 Class Name: NavBar
 Contains functions related to navigation bar
 ******************************************************************************/

public class TabBar extends RequestResponseCommon{

    public String className = getClass().getSimpleName();
    protected HashMap<String, String> tabSet = new HashMap<>();
    {
        tabSet.put("formulary_medications", "formulary_medications/");
        tabSet.put("request_benefits", "request_benefits/");
        tabSet.put("new_pescription", "new_pescription/");
        tabSet.put("pharmacy_search_by_phone", "pharmacy_search_by_phone/");
        tabSet.put("pharmacy_get", "pharmacy_get/");
        tabSet.put("pharmacy_directory_search", "pharmacy_directory_search/");


        //erxV2
        tabSet.put("medHistory", "medhistory/");
        tabSet.put("cancel", "cancel/");
        tabSet.put("ss/process", "ss/process/");
        tabSet.put("checkCancelRxResponse", "checkCancelRxResponse/");
    }
}
