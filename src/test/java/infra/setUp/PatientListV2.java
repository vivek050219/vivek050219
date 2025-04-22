package infra.setUp;

import support.db.DBExecutor;
import utils.UtilFunctions;


/**
 * Created by offshore on 7/19/2017.
 */
public class PatientListV2 {

    public String className = getClass().getSimpleName();
    private static PatientListV2 patientListV2 = new PatientListV2();

    public static void initialize() {
        UtilFunctions.log("Class: " + patientListV2.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
        DBExecutor dbExecutor = new DBExecutor();
        try {
            dbExecutor.executeQuery("delete from PL_PATIENTLIST " +
                    "where ID in (select HIER.ID from PL_PATIENTLIST PARENT, PL_HIERARCHY HIER " +
                    "where PARENT.NAME like 'VerveDel%' " +
                    "and PARENT.ID = HIER.PARENT)");
            dbExecutor.executeQuery("commit");
            dbExecutor.executeQuery("delete from PL_PATIENTLIST where NAME like 'VerveDel%'");
            dbExecutor.executeQuery("commit");
            UtilFunctions.log("Patient Lists deleted successfully");
        } catch (Exception e) {
            UtilFunctions.log("Patient Lists delete is not successful. Skipping setUp. Reason for exception: "
                    + e.getMessage());
        }
        UtilFunctions.log("Class: " + patientListV2.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

}
