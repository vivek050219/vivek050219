package frames;

import java.util.HashMap;

/**
 * Created by Offshore team on 4/27/2017.
 */

/******************************************************************************
 Class Name: Forms_Frames
 Contains hash map to map and store frame name and value
 ******************************************************************************/

public class PatientSearch_Frames {

    //Hash Map to store frame values and names related to forms page
    public static HashMap<String, String> patientSearchFramesMap = new HashMap<>();


    /**************************************************************************
     * name: setFormsFramesMap()
     * functionality: Set frame name and value
     * return: void
     *************************************************************************/
    public static void setPatientSearchFramesMap(){
        //PatientSearch frames
        patientSearchFramesMap.put("FRAME_PARENT", Global_Frames.globalFramesMap.get("FRAME_GLOBAL_MAIN") + ".PTSEARCH");
        patientSearchFramesMap.put("FRAME_SEARCH_CRITERIA", patientSearchFramesMap.get("FRAME_PARENT") + ".activityFrame");
        patientSearchFramesMap.put("FRAME_SEARCH_RESULTS", patientSearchFramesMap.get("FRAME_SEARCH_CRITERIA") + ".SearchResults");
        patientSearchFramesMap.put("FRAME_PATIENT_DETAIL", Global_Frames.globalFramesMap.get("FRAME_POPUP_CONTENTS") + ".PTHEADER");
        patientSearchFramesMap.put("FRAME_PATIENT_DETAIL_CLINICALNAV", Global_Frames.globalFramesMap.get("FRAME_POPUP_CONTENTS") + ".CLINNAV");
        patientSearchFramesMap.put("FRAME_PATIENTLIST_ADD_PATIENTS_FRAME", "PATIENTLIST_ADD_PATIENTS_FRAME");
        //charges
        patientSearchFramesMap.put("FRAME_CHARGELIST", Global_Frames.globalFramesMap.get("FRAME_POPUP_CONTENTS") + ".VIEW__CLINICALDETAIL.PATIENTINTERACTIONLIST");
        patientSearchFramesMap.put("PATIENTLIST_DEBUG_FRAME", "PATIENTLIST_DEBUG_FRAME");
        patientSearchFramesMap.put("FRAME_CPOEEDIT", Global_Frames.globalFramesMap.get("FRAME_POPUP_CONTENTS") + ".CPOEEdit");

        //NoteWriter Popup from PatientSearch frames
        patientSearchFramesMap.put("FRAME_NWWIZARD_POPUP", Global_Frames.globalFramesMap.get("FRAME_POPUP_CONTENTS") + ".NoteWriter");
        patientSearchFramesMap.put("FRAME_NWWIZARD_DXSEARCH", patientSearchFramesMap.get("FRAME_NWWIZARD_POPUP") + ".DXSearchContainerIframe_0");

        //Patient Detail Frames from Patient Search popup
        patientSearchFramesMap.put("FRAME_PATIENTDETAIL_POPUP", Global_Frames.globalFramesMap.get("FRAME_POPUP_CONTENTS") + ".VIEW__CLINICALDETAIL");
        patientSearchFramesMap.put("FRAME_PATIENTDETAIL_CLINICALNOTES", patientSearchFramesMap.get("FRAME_PATIENTDETAIL_POPUP") + ".NOTELIST");
        patientSearchFramesMap.put("FRAME_PATIENTDETAIL_PROGRESSNOTE", patientSearchFramesMap.get("FRAME_PATIENTDETAIL_POPUP") + ".DETAIL.contentIFRAME");

        //Merge Pane Frames
        patientSearchFramesMap.put("FRAME_MERGE", Global_Frames.globalFramesMap.get("FRAME_POPUP_CONTENTS") + ".patientSearchFrame");
        patientSearchFramesMap.put("FRAME_MERGE_SEARCHRESULTS", patientSearchFramesMap.get("FRAME_MERGE") + ".SearchResults");
    }
}
