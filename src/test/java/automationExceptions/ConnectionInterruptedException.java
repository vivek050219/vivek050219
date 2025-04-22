package automationExceptions;

import utils.UtilFunctions;

/**
 * Created by apverma on 11/3/2016.
 */
public class ConnectionInterruptedException extends InterruptedException {

    public ConnectionInterruptedException(String s) {
        super(s);
        UtilFunctions.log("Exception occurred. Returning true.");
    }
}
