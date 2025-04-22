package frames;

import java.util.HashMap;

/**
 * Created by PatientKeeper on 6/24/2016.
 */

/******************************************************************************
 Class Name: Global_Frames
 Contains hash map to map and store frame name and value
 ******************************************************************************/

public class Global_Frames {

    //Hash Map to store frame values and names related to global frames
    public static HashMap<String, String> globalFramesMap = new HashMap<>();


    /**************************************************************************
     * name: setGlobalFramesMap()
     * functionality: Set frame name and value
     * return: void
     *************************************************************************/
    public static void setGlobalFramesMap(){
        //main parent login frame
        globalFramesMap.put("PARENT_FRAME", "workspace");

        //parent frame - all frames in portal are children of this
        globalFramesMap.put("FRAME_BASE", "paneLayoutFrame");
        globalFramesMap.put("OLD_UI_TOPFRAME", globalFramesMap.get("FRAME_BASE") + ".APPHEADER");
        globalFramesMap.put("NEW_UI_TOPFRAME", globalFramesMap.get("FRAME_BASE") + ".CUSTOMERBRANDING");

        //parent frame for main iframe
        globalFramesMap.put("FRAME_GLOBAL_MAIN", globalFramesMap.get("FRAME_BASE") + ".VIEW__MAIN");

        //navigation frames
        globalFramesMap.put("FRAME_MAIN_NAV", globalFramesMap.get("FRAME_BASE") + ".MAINNAV");

        //dialog boxes
        globalFramesMap.put("FRAME_DIALOG", "dialogFrame");
        globalFramesMap.put("FRAME_POPUP", "windowFrame1");
        globalFramesMap.put("FRAME_POPUP_CONTENTS", globalFramesMap.get("FRAME_POPUP") + ".contentIFRAME");
        globalFramesMap.put("FRAME_POPUP_CLINNAV",globalFramesMap.get("FRAME_POPUP_CONTENTS") + ".CLINNAV");
        globalFramesMap.put("FRAME_SECONDARY_POPUP", "windowFrame2");
        globalFramesMap.put("FRAME_SECONDARY_POPUP_CONTENTS", globalFramesMap.get("FRAME_SECONDARY_POPUP") + ".contentIFRAME");
        globalFramesMap.put("FRAME_TERTIARY_POPUP", "windowFrame3");
        globalFramesMap.put("FRAME_TERTIARY_POPUP_CONTENTS", globalFramesMap.get("FRAME_TERTIARY_POPUP") + ".contentIFRAME");
        globalFramesMap.put("FRAME_REPORT_POPUP", "nm_windowFrame1");

        //dojo dialog
        globalFramesMap.put("FRAME_TABLEDROPDOWN", "customDropdownFrame");
        globalFramesMap.put("FRAME_DOJO_DIALOG", "DojoDialogFrame_1");
        globalFramesMap.put("FRAME_SECONDARY_DOJO_DIALOG", "DojoDialogFrame_2");

        globalFramesMap.put("FRAME_EDITDEPT_PICKERS_CODE", "dynamicLookupIframe");

        globalFramesMap.put("FRAME_MESSAGE_AREA", globalFramesMap.get("FRAME_BASE") + ".MSGBOARD");

        globalFramesMap.put("NO_FRAME", "NO_FRAME");

        globalFramesMap.put("LOGIN_FRAME", "workspace");

        globalFramesMap.put("FRAME_LOGOUT", globalFramesMap.get("FRAME_BASE") + ".CUSTOMERBRANDING");
    }

}
