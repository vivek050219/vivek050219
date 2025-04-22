package frames;

import java.util.HashMap;

/**
 * Created by PatientKeeper on 6/24/2016.
 */

/******************************************************************************
 Class Name: Forms_Frames
 Contains hash map to map and store frame name and value
 ******************************************************************************/

public class Forms_Frames {

    //Hash Map to store frame values and names related to forms page
    public static HashMap<String, String> formsFramesMap = new HashMap<>();


    /**************************************************************************
     * name: setFormsFramesMap()
     * functionality: Set frame name and value
     * return: void
     *************************************************************************/
    public static void setFormsFramesMap(){
        //main
        formsFramesMap.put("FRAME_PARENT", Global_Frames.globalFramesMap.get("FRAME_GLOBAL_MAIN") + ".FORMDESKTOPTABS.VIEW__FORMDESKTOPNAV");

        //measures frames
        formsFramesMap.put("FRAME_MEASURES", formsFramesMap.get("FRAME_PARENT") + ".MEASURESEARCHNAV");
        formsFramesMap.put("FRAME_MEASURES_RESULTS", formsFramesMap.get("FRAME_MEASURES") + ".measureResultsFrame");
    }
}
