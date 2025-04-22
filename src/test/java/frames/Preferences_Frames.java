package frames;

import java.util.HashMap;

/**
 * Created by PatientKeeper on 6/24/2016.
 */

/******************************************************************************
 Class Name: Forms_Frames
 Contains hash map to map and store frame name and value
 ******************************************************************************/

public class Preferences_Frames {

    //Hash Map to store frame values and names related to forms page
    public static HashMap<String, String> preferencesFramesMap = new HashMap<>();


    /**************************************************************************
     * name: setFormsFramesMap()
     * functionality: Set frame name and value
     * return: void
     *************************************************************************/
    public static void setPreferencesFramesMap(){
        //Preference frames
        preferencesFramesMap.put("FRAME_PARENT", Global_Frames.globalFramesMap.get("FRAME_GLOBAL_MAIN") + ".PREFNAV.ADMIN");
        preferencesFramesMap.put("FRAME_MAIN", preferencesFramesMap.get("FRAME_PARENT") + ".contentIFRAME");
        preferencesFramesMap.put("FRAME_PREFERENCE_TOP", preferencesFramesMap.get("FRAME_MAIN") + ".select_top");
        preferencesFramesMap.put("FRAME_PREFERENCE_MAIN", preferencesFramesMap.get("FRAME_MAIN") + ".targeted");
        preferencesFramesMap.put("FRAME_PREFRENCE_PROBLEMLIST",preferencesFramesMap.get("FRAME_MAIN") + ".mainContentFrame");
        preferencesFramesMap.put("FRAME_PREFERENCE_BOTTOM", preferencesFramesMap.get("FRAME_MAIN") + ".submitFrame");
        preferencesFramesMap.put("FRAME_USER_PREFERENCE", Global_Frames.globalFramesMap.get("FRAME_GLOBAL_MAIN") + ".PREFNAV" + ".ADMIN");
    }
}
