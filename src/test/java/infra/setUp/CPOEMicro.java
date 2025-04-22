package infra.setUp;

import support.db.DBExecutor;
import utils.UtilFunctions;


/**
 * Created by offshore on 7/19/2017.
 */
public class CPOEMicro {

    public String className = getClass().getSimpleName();
    private static CPOEMicro CPOEMicro = new CPOEMicro();

    public static void initialize() {
        UtilFunctions.log("Class: " + CPOEMicro.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        DBExecutor dbExecutor = new DBExecutor();
        try {
            dbExecutor.executeQuery("update PK_HPICKER p set p.SYNCDELETED = p.SYNCREPOSITORYID where p.SYNCUSERID = (select u.USER_ID from U_USER u where u.USER_NM = 'pkadminv2') and p.SYNCDELETED = 0 and p.DESCRIPTION like 'Test Micro Lab%'");
            dbExecutor.executeQuery("commit");
            UtilFunctions.log("Order favorites from CPOEMicro task deleted successfully");
        }
        catch (Exception e){
            UtilFunctions.log("Order favorites from CPOEMicro task did not delete successfully.  Reason for exception: " + e.getMessage());
        }
        try {
            dbExecutor.executeQuery("update CPOE_INTERACTION_DISPLAY_PREF set CPOE_INTERACTION_DISPLAY_PREF.DISPLAY_CLASS_NAME = 'Disabled' where CPOE_INTERACTION_DISPLAY_PREF.FACILITY_GROUP_ID in (select M_FACILITY_GROUP.FACILITY_GROUP_ID from M_FACILITY_GROUP where M_FACILITY_GROUP.NAME ='DefaultFacilityGroup')");
            dbExecutor.executeQuery("commit");
            UtilFunctions.log("'Non-Medication Interactions' and 'Medication Interactions' disabled successfully");
        }
        catch (Exception e){
            UtilFunctions.log("'Non-Medication Interactions' and 'Medication Interactions' did not disable successfully.  Reason for exception: " + e.getMessage());
        }
        try {
            dbExecutor.executeQuery("update CPOE_ORDERSET set DEL_IND = ORDERSET_ID where NAME like 'VerveDel%'");
            dbExecutor.executeQuery("commit");
            UtilFunctions.log("Micro Order Sets deleted successfully");
        }
        catch (Exception e){
            UtilFunctions.log("Failed to delete Micro Order Sets.  Reason for exception: " + e.getMessage());
        }

        UtilFunctions.log("Class: " + CPOEMicro.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    public static void deInitialize() {
        UtilFunctions.log("Class: " + CPOEMicro.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());

        DBExecutor dbExecutor = new DBExecutor();
        try {
            dbExecutor.executeQuery("update CPOE_INTERACTION_DISPLAY_PREF set CPOE_INTERACTION_DISPLAY_PREF.DISPLAY_CLASS_NAME = 'Disabled' where CPOE_INTERACTION_DISPLAY_PREF.FACILITY_GROUP_ID in (select M_FACILITY_GROUP.FACILITY_GROUP_ID from M_FACILITY_GROUP where M_FACILITY_GROUP.NAME ='DefaultFacilityGroup')");
            dbExecutor.executeQuery("commit");
            UtilFunctions.log("'Non-Medication Interactions' and 'Medication Interactions' disabled successfully");
        }
        catch (Exception e){
            UtilFunctions.log("'Non-Medication Interactions' and 'Medication Interactions' did not disable successfully.  Reason for exception: " + e.getMessage());
        }

        UtilFunctions.log("Class: " + CPOEMicro.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

}