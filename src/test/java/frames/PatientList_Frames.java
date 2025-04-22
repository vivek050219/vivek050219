package frames;

import java.util.HashMap;

/**
 * Created by PatientKeeper on 6/30/2016.
 */

/******************************************************************************
 Class Name: PatientList_Frames
 Contains hash map to map and store frame name and value
 ******************************************************************************/

public class PatientList_Frames {

    //Hash Map to store frame values and names related to global frames
    public static HashMap<String, String> patientListFramesMap = new HashMap<>();


    /**************************************************************************
     * name: setPatientListFramesMap()
     * functionality: Set frame name and value
     * return: void
     *************************************************************************/
    public static void setPatientListFramesMap(){
        //patient list frames
        patientListFramesMap.put("FRAME_PARENT", Global_Frames.globalFramesMap.get("FRAME_GLOBAL_MAIN") + ".PT");
        patientListFramesMap.put("FRAME_LIST", patientListFramesMap.get("FRAME_PARENT") + ".PTLIST");
        patientListFramesMap.put("FRAME_LISTV2", patientListFramesMap.get("FRAME_LIST") + ".PATIENTLIST_VISITS_FRAME");
        patientListFramesMap.put("FRAME_CLINNAV", patientListFramesMap.get("FRAME_PARENT") + ".VIEW__PTINFO.VIEW__CLINICALNAVDETAIL.CLINNAV");
        patientListFramesMap.put("FRAME_CLINDETAIL", patientListFramesMap.get("FRAME_PARENT") + ".VIEW__PTINFO.VIEW__CLINICALNAVDETAIL.VIEW__CLINICALDETAIL");
        patientListFramesMap.put("FRAME_PATINFO", patientListFramesMap.get("FRAME_PARENT") + ".VIEW__PTINFO.VIEW__CLINICALNAVDETAIL.PTHEADER");
        patientListFramesMap.put("FRAME_REMOVE_PATIENTS_ACCOUNT_LIST",Global_Frames.globalFramesMap.get("FRAME_POPUP_CONTENTS") + ".accountListFrame");

        //Charges
        patientListFramesMap.put("FRAME_CHARGELIST", patientListFramesMap.get("FRAME_CLINDETAIL") + ".PATIENTINTERACTIONLIST");
        patientListFramesMap.put("FRAME_CHARGEDETAIL", patientListFramesMap.get("FRAME_CLINDETAIL") + ".DETAIL.contentIFRAME");
        patientListFramesMap.put("FRAME_DIAGNOSESLOOKUP", "dynamicLookupIframe");
        patientListFramesMap.put("FRAME_INFUSION", Global_Frames.globalFramesMap.get("FRAME_POPUP_CONTENTS") + ".tbillFormsIframe");

        patientListFramesMap.put("FRAME_VISITLIST", patientListFramesMap.get("FRAME_CLINDETAIL") + ".VISITHIST");
        patientListFramesMap.put("FRAME_VISITDETAIL", patientListFramesMap.get("FRAME_CLINDETAIL") + ".DETAIL.contentIFRAME");

        patientListFramesMap.put("FRAME_ALLERGYLIST", patientListFramesMap.get("FRAME_CLINDETAIL") + ".ALLERGYLIST");

        patientListFramesMap.put("FRAME_SEARCH_PATIENT", Global_Frames.globalFramesMap.get("FRAME_POPUP_CONTENTS") + ".patientSearch");
        patientListFramesMap.put("FRAME_SEARCH_PATIENT_RESULTS", patientListFramesMap.get("FRAME_SEARCH_PATIENT") + ".SearchResults");
        patientListFramesMap.put("FRAME_REMOVE_PATIENT", Global_Frames.globalFramesMap.get("FRAME_POPUP_CONTENTS") + ".accountListFrame");
        patientListFramesMap.put("FRAME_PATIENT_SUMMARY", patientListFramesMap.get("FRAME_CLINDETAIL") + ".PTSUMMARY.PTSUMMARY");
        patientListFramesMap.put("FRAME_CLINICALNOTES_OVERVIEW", patientListFramesMap.get("FRAME_CLINDETAIL") + ".OVERVIEWNOTELIST");
        patientListFramesMap.put("FRAME_VISTS_OVERVIEW", patientListFramesMap.get("FRAME_CLINDETAIL") + ".OVERVIEWVISITLIST");
        patientListFramesMap.put("FRAME_CHARGES_OVERVIEW", patientListFramesMap.get("FRAME_CLINDETAIL") + ".OVERVIEWPATIENTINTERACTIONLIST");
        patientListFramesMap.put("FRAME_CLINDETAIL_POPUP", Global_Frames.globalFramesMap.get("FRAME_POPUP_CONTENTS") + ".VIEW__CLINICALDETAIL");
        patientListFramesMap.put("FRAME_TESTDETAIL_POPUP", patientListFramesMap.get("FRAME_CLINDETAIL_POPUP") + ".DETAIL.contentIFRAME");
        patientListFramesMap.put("FRAME_CLINNAV_POPUP", Global_Frames.globalFramesMap.get("FRAME_POPUP_CONTENTS") + ".CLINNAV");

        //patient detail
        patientListFramesMap.put("FRAME_PATDETAIL", patientListFramesMap.get("FRAME_CLINDETAIL") + ".PTDETAIL");

        //send patient frames
        patientListFramesMap.put("FRAME_SEND_PATIENT_SEARCH", Global_Frames.globalFramesMap.get("FRAME_POPUP_CONTENTS") + ".userSearch");
        patientListFramesMap.put("FRAME_SEND_PATIENT_SEARCH_RESULTS", Global_Frames.globalFramesMap.get("FRAME_SEND_PATIENT_SEARCH") + ".userSearchResults");
        patientListFramesMap.put("FRAME_SEND_PATIENT_TABLE", Global_Frames.globalFramesMap.get("FRAME_POPUP_CONTENTS") + ".patientList");

        //get patient
        patientListFramesMap.put("FRAME_GET_PATIENT_SEARCH", Global_Frames.globalFramesMap.get("FRAME_POPUP_CONTENTS") + ".UserSearchFrame");
        patientListFramesMap.put("FRAME_GET_PATIENT_SEARCH_RESULTS", Global_Frames.globalFramesMap.get("FRAME_GET_PATIENT_SEARCH") + ".userSearchResults");
        patientListFramesMap.put("FRAME_GET_PATIENT_TABLE", Global_Frames.globalFramesMap.get("FRAME_POPUP_CONTENTS") + ".patientlistframe");

        //problems
        patientListFramesMap.put("FRAME_PROBLEMLIST", patientListFramesMap.get("FRAME_CLINDETAIL") + ".PROBLIST");
        patientListFramesMap.put("FRAME_PROBLEMDETAIL", patientListFramesMap.get("FRAME_CLINDETAIL") + ".DETAIL.contentIFRAME");
        patientListFramesMap.put("FRAME_EDITPROBLEM", "DojoDialog_1");

        //text selection frame - used by multiple modules
        patientListFramesMap.put("FRAME_TEXTSELECTION", patientListFramesMap.get("FRAME_CLINDETAIL") + ".CLINICALDATATEXTSELECTION");

        //orders
        patientListFramesMap.put("FRAME_ORDERLIST", patientListFramesMap.get("FRAME_CLINDETAIL") + ".CPOEOrderList");
        patientListFramesMap.put("FRAME_ORDERDETAIL", patientListFramesMap.get("FRAME_CLINDETAIL") + ".DETAIL.contentIFRAME");
        patientListFramesMap.put("FRAME_CPOEMAIN", patientListFramesMap.get("FRAME_PARENT") + ".**TASK_FRAME__");
        patientListFramesMap.put("FRAME_EDITORDER", patientListFramesMap.get("FRAME_CPOEMAIN") + ".CPOEEdit");
        patientListFramesMap.put("FRAME_ADDNONMED_ORDER", Global_Frames.globalFramesMap.get("FRAME_POPUP_CONTENTS") + ".CPOEEdit");
        patientListFramesMap.put("FRAME_PROVIDERLOOKUP", "lookupIframe");
        patientListFramesMap.put("FRAME_CLINICAL_DECISION", "DojoDialogFrame_1");
        patientListFramesMap.put("FRAME_ENTER_OTHER_CHOICE_TEXT", "windowFrame1.contentIFRAME");

        //Note Writer
        patientListFramesMap.put("FRAME_NOTEWRITER_MAIN", patientListFramesMap.get("FRAME_PARENT") + ".**TASK_FRAME__");
        patientListFramesMap.put("FRAME_NOTEWRITER_DETAIL", patientListFramesMap.get("FRAME_CLINDETAIL") + ".DETAIL.contentIFRAME");
        patientListFramesMap.put("FRAME_NOTEWRITER", patientListFramesMap.get("FRAME_NOTEWRITER_MAIN") + ".NoteWriter");
        patientListFramesMap.put("FRAME_NOTEWRITER_CHARGE_CAPTURE", patientListFramesMap.get("FRAME_NOTEWRITER_MAIN") + ".ChargeCapture");
        patientListFramesMap.put("FRAME_NOTEWRITER_INSERT_PREVIOUS", patientListFramesMap.get("FRAME_NOTEWRITER") + ".InsertPreviousFrame");
        patientListFramesMap.put("FRAME_NOTEWRITER_CPOE", patientListFramesMap.get("FRAME_NOTEWRITER_MAIN") + ".CPOE");
//        patientListFramesMap.put("FRAME_NWWIZARD_POPUP", Global_Frames.globalFramesMap.get("FRAME_POPUP_CONTENTS") + ".NoteWriter");
//        patientListFramesMap.put("FRAME_NWWIZARD_DXSEARCH", patientListFramesMap.get("FRAME_NWWIZARD_POPUP") + ".DXSearchContainerIframe_0");

        //notes
        patientListFramesMap.put("FRAME_NOTELIST", patientListFramesMap.get("FRAME_CLINDETAIL") + ".NOTELIST");
        patientListFramesMap.put("FRAME_NOTEDETAIL", patientListFramesMap.get("FRAME_CLINDETAIL") + ".DETAIL.contentIFRAME");
        patientListFramesMap.put("FRAME_NOTELIST_POPUP", patientListFramesMap.get("FRAME_CLINDETAIL_POPUP") + ".NOTELIST");

        //labs
        patientListFramesMap.put("FRAME_LABLIST", patientListFramesMap.get("FRAME_CLINDETAIL") + ".LABLIST");
        patientListFramesMap.put("FRAME_LABDETAIL", patientListFramesMap.get("FRAME_CLINDETAIL") + ".LABDETAIL");
        patientListFramesMap.put("FRAME_PANELTABLE", patientListFramesMap.get("FRAME_LABDETAIL") + ".panelTableFrame");
        patientListFramesMap.put("FRAME_PANELDETAIL", patientListFramesMap.get("FRAME_LABDETAIL") + ".panelDetailFrame");
        patientListFramesMap.put("FRAME_COMPDETAIL", patientListFramesMap.get("FRAME_LABDETAIL") + ".componentDetailFrame");
        patientListFramesMap.put("FRAME_LABMULTIGRAPH",  Global_Frames.globalFramesMap.get("FRAME_POPUP_CONTENTS") + ".**GraphFrame");


        //tests
        patientListFramesMap.put("FRAME_TESTLIST", patientListFramesMap.get("FRAME_CLINDETAIL") + ".RESULTLIST");
        patientListFramesMap.put("FRAME_TESTDETAIL", patientListFramesMap.get("FRAME_CLINDETAIL") + ".DETAIL.contentIFRAME");
        patientListFramesMap.put("FRAME_TESTLIST_POPUP", patientListFramesMap.get("FRAME_CLINDETAIL_POPUP") + ".RESULTLIST");
        patientListFramesMap.put("FRAME_TESTSELECTION_POPUP", patientListFramesMap.get("FRAME_CLINDETAIL_POPUP") + ".CLINICALDATATEXTSELECTION");


        //vitals
        patientListFramesMap.put("FRAME_VITALLIST", patientListFramesMap.get("FRAME_CLINDETAIL") + ".VITALLIST");
        patientListFramesMap.put("FRAME_VITALDETAIL", patientListFramesMap.get("FRAME_CLINDETAIL") + ".VITALDETAIL");
        patientListFramesMap.put("FRAME_VITALGRAPH", patientListFramesMap.get("FRAME_CLINDETAIL") + ".VITALGRAPH");
        patientListFramesMap.put("FRAME_VITALLIST_POPUP", patientListFramesMap.get("FRAME_CLINDETAIL_POPUP") + ".VITALLIST");

        //I/Os
        patientListFramesMap.put("FRAME_IOLIST", patientListFramesMap.get("FRAME_CLINDETAIL") + ".IOLIST");

        //Medications
        patientListFramesMap.put("FRAME_MEDICATIONLIST", patientListFramesMap.get("FRAME_CLINDETAIL") + ".MEDLIST");
        patientListFramesMap.put("FRAME_MEDREC_CLINICAL", patientListFramesMap.get("FRAME_CLINICAL_DECISION") + ".ClinicalDataToggleButton__dataiframe");
        patientListFramesMap.put("FRAME_MEDREC_CLINNAV", patientListFramesMap.get("FRAME_MEDREC_CLINICAL") + ".CLINNAV");
        patientListFramesMap.put("FRAME_MEDREC_CLINDETAIL", patientListFramesMap.get("FRAME_MEDREC_CLINICAL") + ".VIEW__CLINICALDETAIL");
        patientListFramesMap.put("FRAME_MEDREC_LAB", patientListFramesMap.get("FRAME_MEDREC_CLINDETAIL") + ".LABLIST");
        patientListFramesMap.put("FRAME_MEDREC_LAB_Detail", patientListFramesMap.get("FRAME_MEDREC_CLINDETAIL") + ".LABDETAIL");
        patientListFramesMap.put("FRAME_MEDREC_LAB_Panel", patientListFramesMap.get("FRAME_MEDREC_LAB_Detail") + ".panelTableFrame");
        patientListFramesMap.put("FRAME_MEDREC_TESTRESULTS", patientListFramesMap.get("FRAME_MEDREC_CLINDETAIL") + ".RESULTLIST");
        patientListFramesMap.put("FRAME_MEDREC_TEST_DETAIL", patientListFramesMap.get("FRAME_MEDREC_CLINDETAIL") + ".DETAIL");
        patientListFramesMap.put("FRAME_MEDREC_TESTDETAIL_CONTENT", patientListFramesMap.get("FRAME_MEDREC_TEST_DETAIL") + ".contentIFRAME");
        patientListFramesMap.put("FRAME_MEDICATIONLIST_POPUP", patientListFramesMap.get("FRAME_CLINDETAIL_POPUP") + ".MEDLIST");
        patientListFramesMap.put("FRAME_MEDICATIONDETAIL", patientListFramesMap.get("FRAME_CLINDETAIL") + ".DETAIL.contentIFRAME");


        //Home Medications
        patientListFramesMap.put("FRAME_HOME_MEDICATIONS", patientListFramesMap.get("FRAME_CLINDETAIL") + ".HOMEMEDICATIONLIST");
        patientListFramesMap.put("FRAME_DISCHARGE_ORDERS", patientListFramesMap.get("FRAME_CLINDETAIL") + ".DISCHARGEORDERLIST");

        //allergies
        patientListFramesMap.put("FRAME_ALLERGYLIST_POPUP", patientListFramesMap.get("FRAME_CLINDETAIL_POPUP") + ".ALLERGYLIST");
        patientListFramesMap.put("FRAME_ALLERGYDETAIL", patientListFramesMap.get("FRAME_CLINDETAIL") + ".DETAIL.contentIFRAME");

        //labs
        patientListFramesMap.put("FRAME_LABLIST_POPUP", patientListFramesMap.get("FRAME_CLINDETAIL_POPUP") + ".LABLIST");
        //to handle the History and A/P tab DX search as per 8x change
        patientListFramesMap.put("FRAME_NOTEWRITER_HISTORYDXSEARCH", patientListFramesMap.get("FRAME_NOTEWRITER") + ".DXSearchContainerIframe_0");
        patientListFramesMap.put("FRAME_NOTEWRITER_APDXSEARCH", patientListFramesMap.get("FRAME_NOTEWRITER") + ".DXSearchContainerIframe_1");
        patientListFramesMap.put("FRAME_NOTEWRITER_APDXSEARCHQTV2", patientListFramesMap.get("FRAME_NOTEWRITER") + ".DXSearchContainerIframe_2");
        //prints
        patientListFramesMap.put("FRAME_CLIN_ROUNDING_OPTIONS", Global_Frames.globalFramesMap.get("FRAME_POPUP_CONTENTS") + ".criteriaframe");
        patientListFramesMap.put("FRAME_CLIN_ROUNDING_LIST", Global_Frames.globalFramesMap.get("FRAME_POPUP_CONTENTS") + ".patientlistframe");

        //new results
        patientListFramesMap.put("FRAME_NEW_RESULTS", patientListFramesMap.get("FRAME_CLINDETAIL") + ".PTSUMMARY.PTSUMMARY");
        patientListFramesMap.put("FRAME_NEW_RESULTS_DETAIL", patientListFramesMap.get("FRAME_NEW_RESULTS") + ".GENERICDETAIL.contentIFRAME");

        //sign-out
        patientListFramesMap.put("FRAME_SIGNOUT", patientListFramesMap.get("FRAME_CLINDETAIL") + ".SIGNOUT");
    }

}
