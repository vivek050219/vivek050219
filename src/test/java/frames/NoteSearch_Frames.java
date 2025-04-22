package frames;

import java.util.HashMap;

/**
 * Created by Offshore team on 4/27/2017.
 */

/******************************************************************************
 Class Name: Forms_Frames
 Contains hash map to map and store frame name and value
 ******************************************************************************/

public class NoteSearch_Frames {

    //Hash Map to store frame values and names related to forms page
    public static HashMap<String, String> noteSearchFramesMap = new HashMap<>();


    /**************************************************************************
     * name: setFormsFramesMap()
     * functionality: Set frame name and value
     * return: void
     *************************************************************************/
    public static void setNoteSearchFramesMap(){
        //NoteSearch frames
        noteSearchFramesMap.put("FRAME_PARENT", Global_Frames.globalFramesMap.get("FRAME_GLOBAL_MAIN") + ".NWSEARCH.NWSEARCHNAV");
        noteSearchFramesMap.put("FRAME_SEARCH_RESULTS", noteSearchFramesMap.get("FRAME_PARENT") + ".resultsFrame");
        noteSearchFramesMap.put("FRAME_PATIENT_DETAIL_CLINICALNAV", Global_Frames.globalFramesMap.get("FRAME_POPUP_CONTENTS") + ".CLINNAV");
        noteSearchFramesMap.put("FRAME_SEARCH_CRITERIA", noteSearchFramesMap.get("FRAME_PARENT") + ".activityFrame");//never used yet

        noteSearchFramesMap.put("FRAME_PATIENT_DETAIL", Global_Frames.globalFramesMap.get("FRAME_POPUP_CONTENTS") + ".PTHEADER");
        noteSearchFramesMap.put("FRAME_PATIENT_DETAIL_CLINICALNAV", Global_Frames.globalFramesMap.get("FRAME_POPUP_CONTENTS") + ".CLINNAV");
        noteSearchFramesMap.put("FRAME_PATIENTLIST_ADD_PATIENTS_FRAME", "PATIENTLIST_ADD_PATIENTS_FRAME");
        //charges
        noteSearchFramesMap.put("FRAME_CHARGELIST", Global_Frames.globalFramesMap.get("FRAME_POPUP_CONTENTS") + ".VIEW__CLINICALDETAIL.PATIENTINTERACTIONLIST");
        noteSearchFramesMap.put("PATIENTLIST_DEBUG_FRAME", "PATIENTLIST_DEBUG_FRAME");
        noteSearchFramesMap.put("FRAME_CPOEEDIT", Global_Frames.globalFramesMap.get("FRAME_POPUP_CONTENTS") + ".CPOEEdit");
    }
}
