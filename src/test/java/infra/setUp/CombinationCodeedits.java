package infra.setUp;

import support.db.DBExecutor;
import utils.UtilFunctions;

/**
 * Created by offshore on 04/25/2018.
 */
public class CombinationCodeedits {

    public String className = getClass().getSimpleName();
    private static CombinationCodeedits codeEdits = new CombinationCodeedits();

    public static void initialize() {
        UtilFunctions.log("Class: " + codeEdits.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        DBExecutor dbExecutor = new DBExecutor();
        try {
            UtilFunctions.log("Enabling all code edits on server.");
            dbExecutor.executeQuery("update PK_CODEEDIT set ACTIVE = '1'");
            dbExecutor.executeQuery("commit");
            UtilFunctions.log("All Code Edits successfully enabled");
        } catch (Exception e) {
            UtilFunctions.log("Enable All Code Edits failed.  Reason for exception: " + e.getMessage());
        }
    }

    public static void deInitialize() {
        UtilFunctions.log("Class: " + codeEdits.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        DBExecutor dbExecutor = new DBExecutor();
        try {
            UtilFunctions.log("Disabling all code edits on server.");
            dbExecutor.executeQuery("update PK_CODEEDIT set ACTIVE = '0'");
            dbExecutor.executeQuery("commit");
            UtilFunctions.log("All Code Edits successfully disabled");
        }
        catch (Exception e){
            UtilFunctions.log("Disable All Code Edits failed.  Reason for exception: " + e.getMessage());
        }
    }
}
