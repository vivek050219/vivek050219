package infra.setUp;

import constants.GlobalConstants;
import utils.UtilFunctions;

/**
 * Created by PatientKeeper on 11/21/2016.
 */
public class Performance {

    public String className = getClass().getSimpleName();
    private static Performance performance = new Performance();

    public static void initialize() {
        UtilFunctions.log("Class: " + performance.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        GlobalConstants.LONG_TIMEOUT = GlobalConstants.SIXTY;
    }
    public static void deInitialize() {
        UtilFunctions.log("Class: " + performance.className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName());
        GlobalConstants.LONG_TIMEOUT = GlobalConstants.TEN;
    }
}
