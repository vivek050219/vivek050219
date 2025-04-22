package utils;

/**
 * Created by PatientKeeper on 6/21/2016.
 */

/******************************************************************************
 Class Name: UtilProperty
 Contains util properties
 ******************************************************************************/

public class UtilProperty {

    //public static String browserType = "ie11";
    //public static String browserType = "chrome";

    //public static String url = "http://chrisb-nuc6:10000/index.jsp";
    //public static String url = "http://qa-vm-aut-app05:10000/index.jsp";

    //public static String url = "http://qa-vm-aut-app02/index.jsp";

    public static String sMainDir = System.getProperty("user.dir");
    public static String setUpFile = sMainDir + "\\setUp.txt";
    public static String setUpIni = sMainDir + "\\src\\test\\java\\support\\setUp.ini";

    public static String browserType = UtilFunctions.getValueFromTextFile("APP");
    public static String sectionName = UtilFunctions.getValueFromTextFile("SECTION");
    public static String tagName = UtilFunctions.getValueFromTextFile("TAG_NAME");

    public static String url = UtilFunctions.getValueFromIniFile(sectionName, "url");

    public static String apiURL = UtilProperty.url.split("index.jsp")[0];
    //public static String apiURL = UtilProperty.url;

    public static String userName = UtilFunctions.getValueFromIniFile(sectionName, "username");
    public static String userPwd = UtilFunctions.getValueFromIniFile(sectionName, "password");
    public static String solrUrl = UtilFunctions.getValueFromIniFile(sectionName, "solrurl");
    public static String solrSearchUrl = UtilFunctions.getValueFromIniFile(sectionName, "SolrSearchURL");

    //Create NEW JSON Files for REST ERX automation
    public static String erxCreateJSON = UtilFunctions.getValueFromTextFile("CREATE_JSON");
}