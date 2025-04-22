package frames;

/**
 * Created by cbrachmann on 2/1/2017.
 */

import java.util.HashMap;

import static frames.Global_Frames.globalFramesMap;

/******************************************************************************
 Class Name: PatientListV2_Frames
 Contains hash map to map and store frame name and value
 ******************************************************************************/

public class PatientListV2_Frames extends PatientList_Frames{

    public static HashMap<String, String> patientListV2FramesMap = patientListFramesMap;

    /**************************************************************************
     * name: setPatientListFramesMap()
     * functionality: Set frame name and value
     * return: void
     *************************************************************************/
    public static void setPatientListV2FramesMap() {
        patientListFramesMap.put("FRAME_CREATEMODIFY_PATIENTLIST", "PATIENTLIST_CREATEMODIFY_FRAME");
        patientListFramesMap.put("PATIENTLIST_SEARCH_FRAME", "PATIENTLIST_SEARCH_FRAME");
        patientListFramesMap.put("PATIENTLIST_VISITS_FRAME", patientListFramesMap.get("FRAME_LIST") + ".PATIENTLIST_VISITS_FRAME");
        patientListFramesMap.put("PATIENTLIST_DEBUG_FRAME", "PATIENTLIST_DEBUG_FRAME");
        patientListFramesMap.put("FRAME_PATIENTLIST_REVERT_FRAME", "PATIENTLIST_REVERT_FRAME");
        patientListFramesMap.put("FRAME_PATIENTLIST_DETAILS", "PATIENTLIST_DETAILS_FRAME");
        patientListFramesMap.put("FRAME_REASSIGN_PATIENTLIST", "PATIENTLIST_REASSIGN_FRAME");
//        patientListFramesMap.put("FRAME_REASSIGN_PATIENTLIST", "PATIENTLIST_REASSIGN_FRAME");

        patientListFramesMap.put("FRAME_PARENT", globalFramesMap.get("FRAME_GLOBAL_MAIN") + ".PT");
        patientListFramesMap.put("FRAME_CLINDETAIL", patientListFramesMap.get("FRAME_PARENT") +
                ".VIEW__PTINFO.VIEW__CLINICALNAVDETAIL.VIEW__CLINICALDETAIL");
        patientListFramesMap.put("FRAME_VISITDETAIL", patientListFramesMap.get("FRAME_CLINDETAIL") + ".DETAIL.contentIFRAME");
        patientListFramesMap.put("FRAME_PATIENTLIST_ADD_PATIENTS_FRAME", "PATIENTLIST_ADD_PATIENTS_FRAME");

        //Clinicals patient list frames
        patientListFramesMap.put("FRAME_EDITORDER", patientListFramesMap.get("FRAME_CPOEMAIN") + ".CPOEEdit");
        patientListFramesMap.put("FRAME_ALLERGYDETAIL", patientListFramesMap.get("FRAME_CLINDETAIL") + ".DETAIL.contentIFRAME");
        patientListFramesMap.put("FRAME_NEW_RESULTS", patientListFramesMap.get("FRAME_CLINDETAIL") + ".PTSUMMARY.PTSUMMARY");
        patientListFramesMap.put("FRAME_NEW_RESULTS_DETAIL", patientListFramesMap.get("FRAME_CLINDETAIL") + ".GENERICDETAIL.contentIFRAME");
        patientListFramesMap.put("FRAME_OVERVIEW_VISITS", patientListFramesMap.get("FRAME_CLINDETAIL") + ".OVERVIEWVISITLIST");
        patientListFramesMap.put("FRAME_OVERVIEW_CHARGES", patientListFramesMap.get("FRAME_CLINDETAIL") + ".OVERVIEWPATIENTINTERACTIONLIST");
        patientListFramesMap.put("FRAME_OVERVIEW_NOTES", patientListFramesMap.get("FRAME_CLINDETAIL") + ".OVERVIEWNOTELIST");
        patientListFramesMap.put("FRAME_OVERVIEW_CHARGEDETAIL", patientListFramesMap.get("FRAME_CLINDETAIL") + ".DETAIL.contentIFRAME");
        patientListFramesMap.put("FRAME_SIGNOUT", patientListFramesMap.get("FRAME_CLINDETAIL") + ".SIGNOUT");
        patientListFramesMap.put("FRAME_FORMS", patientListFramesMap.get("FRAME_CLINDETAIL") + ".FORMLIST");
        patientListFramesMap.put("FRAME_CHARGES_TABLE", patientListFramesMap.get("FRAME_CLINDETAIL") + ".PATIENTINTERACTIONLIST");
        patientListFramesMap.put("FRAME_ORDER_EDITORDER", patientListFramesMap.get("FRAME_PARENT") + ".TASK_FRAME__" + ".CPOEEdit");
        patientListFramesMap.put("FRAME_ADDNOTE_NOTEWRITER", patientListFramesMap.get("FRAME_PARENT") + ".TASK_FRAME__");

        // Patient Detail Popup
        patientListFramesMap.put("FRAME_ADD_PATIENTS", "PATIENTLIST_ADD_PATIENTS_FRAME");
        patientListFramesMap.put("FRAME_PATIENTDETAIL_POPUP", "windowFrame1");
        patientListFramesMap.put("FRAME_PATIENTDETAIL_SIDEBAR", patientListFramesMap.get("FRAME_PATIENTDETAIL_POPUP") +
                ".contentIFRAME.CLINNAV");
        patientListFramesMap.put("FRAME_PATIENTDETAIL_VISTS", patientListFramesMap.get("FRAME_PATIENTDETAIL_POPUP") +
                ".contentIFRAME.VIEW__CLINICALDETAIL.VISITHIST");
        patientListFramesMap.put("FRAME_ADD_PATIENT_TO_LIST", "PATIENTLIST_ADD_PATIENTS_FRAME");

        //Photo viewer patient list frames
        patientListFramesMap.put("FRAME_PHOTO_ADD", patientListV2FramesMap.get("FRAME_CLINDETAIL") + ".PHOTOADD");
        patientListFramesMap.put("FRAME_PHOTO_VIEW", patientListV2FramesMap.get("FRAME_CLINDETAIL") + ".PHOTOLIST");
        patientListFramesMap.put("FRAME_PHOTO_LIST", patientListV2FramesMap.get("FRAME_PHOTO_VIEW") + ".PATIENT_PHOTOS_FRAME");
        patientListFramesMap.put("FRAME_PHOTO_POP_UP", globalFramesMap.get("FRAME_POPUP_CONTENTS") + ".PatientPhotos");
        patientListFramesMap.put("FRAME_PHOTO_LIST_POP_UP", patientListV2FramesMap.get("FRAME_PHOTO_POP_UP") + ".PATIENT_PHOTOS_FRAME");
        patientListFramesMap.put("FRAME_EDIT_PATIENT", patientListFramesMap.get("FRAME_CLINDETAIL") + ".PTDETAIL");

        //NoteWriter patient list frames
        patientListFramesMap.put("FRAME_NOTEWRITER", patientListFramesMap.get("FRAME_NOTEWRITER_MAIN") + ".NoteWriter");
        patientListFramesMap.put("FRAME_NWPOPOUT", "**TASK_FRAME__");
        patientListFramesMap.put("FRAME_NWPOPOUTDETAIL", patientListV2FramesMap.get("FRAME_NWPOPOUT") + ".NoteWriter");
        patientListFramesMap.put("FRAME_NWPOPOUTINSERTPREV", patientListV2FramesMap.get("FRAME_NWPOPOUTDETAIL") + ".InsertPreviousFrame");
        patientListFramesMap.put("FRAME_NOTEWRITERPOPOUT_HISTORYDXSEARCH", patientListV2FramesMap.get("FRAME_NWPOPOUTDETAIL")
                + ".DXSearchContainerIframe_0");
        patientListFramesMap.put("FRAME_WIZARD", "wizard-frame");
        patientListFramesMap.put("FRAME_NOTE_WIZARD", patientListFramesMap.get("FRAME_WIZARD") + ".NoteWriter");
        patientListFramesMap.put("FRAME_NOTE_WIZARD_HISTORY_Dx_SEARCH", patientListFramesMap.get("FRAME_NOTE_WIZARD") + ".DXSearchContainerIframe_0");
        patientListFramesMap.put("FRAME_NOTE_WIZARD_AP_Dx_SEARCH", patientListFramesMap.get("FRAME_NOTE_WIZARD") + ".DXSearchContainerIframe_1");
        patientListFramesMap.put("FRAME_NOTE_WIZARD_INSERTPREVIOUS", patientListFramesMap.get("FRAME_NOTE_WIZARD") + ".InsertPreviousFrame");
//        patientListFramesMap.put("FRAME_NOTEWRITER_CPOE",".CPOE.NoteWriter");

        //Other
        patientListFramesMap.put("FRAME_CALL_PHARMACY_POPUP", Global_Frames.globalFramesMap.get("FRAME_POPUP"));
        patientListFramesMap.put("FRAME_CALL_PHARMACY", Global_Frames.globalFramesMap.get("FRAME_POPUP_CONTENTS"));
        patientListFramesMap.put("FRAME_CALENDAR", "calendarFrame");

        //Labs
        patientListFramesMap.put("FRAME_LABRESULTS", patientListFramesMap.get("FRAME_CLINDETAIL_POPUP") + ".LABDETAIL");
        patientListFramesMap.put("FRAME_LABRESULTS_PANEL", patientListV2FramesMap.get("FRAME_LABRESULTS") + ".panelTableFrame");
        patientListFramesMap.put("FRAME_LABRESULTS_PANEL_RIGHT", patientListFramesMap.get("FRAME_LABRESULTS_PANEL") + ".panelDetailFrame");

        //EPCS Prescriber Report
        patientListFramesMap.put("FRAME_EPCSREPORT", globalFramesMap.get("FRAME_GLOBAL_MAIN") + ".EPCSREPORT");
        patientListFramesMap.put("FRAME_EPCSREPORT_9X", patientListFramesMap.get("FRAME_EPCSREPORT") + ".EPCS_REPORT_9X_FRAME");

        //No Frame
        patientListFramesMap.put("NO_FRAME", "NO_FRAME");
    }
}
