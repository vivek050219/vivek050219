package frames;

import java.util.HashMap;

/**
 * Created by PatientKeeper on 6/24/2016.
 */

/******************************************************************************
 Class Name: Global_Frames
 Contains hash map to map and store frame name and value
 ******************************************************************************/

public class Charges_Frames {

    //Hash Map to store frame values and names related to global frames
    public static HashMap<String, String> chargesFramesMap = new HashMap<>();


    /**************************************************************************
     * name: setGlobalFramesMap()
     * functionality: Set frame name and value
     * return: void
     *************************************************************************/
    public static void setChargesFramesMap(){
        //charges frames
        chargesFramesMap.put("FRAME_PARENT", Global_Frames.globalFramesMap.get("FRAME_GLOBAL_MAIN") + ".CHARGEDESKTOPNAV.VIEW__CHARGEDESKTOP");

        //summary frames
        chargesFramesMap.put("FRAME_SUMMARY", chargesFramesMap.get("FRAME_PARENT") + ".SUMMARY");

        //holding bin frames
        chargesFramesMap.put("FRAME_HOLDINGBIN", chargesFramesMap.get("FRAME_PARENT") + ".HOLDINGBIN");
        chargesFramesMap.put("FRAME_HOLDINGBIN_RESULTS", chargesFramesMap.get("FRAME_HOLDINGBIN") + ".resultsFrame");

        chargesFramesMap.put("FRAME_HOLDINGBIN_REASONS","lookupIframe");

        //batch charge entry frames
        chargesFramesMap.put("FRAME_BATCHCHARGEENTRY", chargesFramesMap.get("FRAME_PARENT") + ".BATCHENTRY");
        chargesFramesMap.put("FRAME_BATCHCHARGEENTRY_MAIN", chargesFramesMap.get("FRAME_BATCHCHARGEENTRY") + ".BATCHCHARGEENTRY");
        chargesFramesMap.put("FRAME_BATCHCHARGEENTRY_VISITS", chargesFramesMap.get("FRAME_BATCHCHARGEENTRY") + ".BATCHCHARGEENTRYVISITS");

        //patient charge status frames
        chargesFramesMap.put("FRAME_PATIENTCHARGESTATUS", chargesFramesMap.get("FRAME_PARENT") + ".PTCHARGEVIEW");

        //worklist frames
        chargesFramesMap.put("FRAME_WORKLIST", chargesFramesMap.get("FRAME_PARENT") + ".WORKLIST");
        chargesFramesMap.put("FRAME_WORKLIST_RESULTS", chargesFramesMap.get("FRAME_WORKLIST") + ".resultsFrame");

        //search frames
        chargesFramesMap.put("FRAME_SEARCH", chargesFramesMap.get("FRAME_PARENT") + ".CHARGES");
        chargesFramesMap.put("FRAME_SEARCH_RESULTS", chargesFramesMap.get("FRAME_SEARCH") + ".resultsFrame");

        //outbox frames
        chargesFramesMap.put("FRAME_OUTBOX", chargesFramesMap.get("FRAME_PARENT") + ".OUTBOX");
        chargesFramesMap.put("FRAME_OUTBOX_PARENT", chargesFramesMap.get("FRAME_OUTBOX") + ".workspaceFrame");
        chargesFramesMap.put("FRAME_OUTBOX_TOP", chargesFramesMap.get("FRAME_OUTBOX_PARENT") + ".table_top");
        chargesFramesMap.put("FRAME_OUTBOX_MAIN", chargesFramesMap.get("FRAME_OUTBOX_PARENT") + ".targeted");
        chargesFramesMap.put("FRAME_OUTBOX_QUICK_DETAILS", chargesFramesMap.get("FRAME_OUTBOX_PARENT") + ".quick_details");

        //patient detail frames
        chargesFramesMap.put("FRAME_PATIENTDETAIL_CLINICALNAV", Global_Frames.globalFramesMap.get("FRAME_POPUP_CONTENTS") + ".CLINNAV");
        chargesFramesMap.put("FRAME_PATIENTDETAIL_CLINICALDETAIL", chargesFramesMap.get("FRAME_PATIENTDETAIL_CLINICALNAV") + ".VIEW__CLINICALDETAIL");
        chargesFramesMap.put("FRAME_PATIENTDETAIL_INTERACTIONLIST", chargesFramesMap.get("FRAME_PATIENTDETAIL_CLINICALDETAIL") + ".PATIENTINTERACTIONLIST");
        chargesFramesMap.put("FRAME_PATIENTDETAIL_CHARGES", Global_Frames.globalFramesMap.get("FRAME_POPUP_CONTENTS") + ".VIEW__CLINICALDETAIL.PATIENTINTERACTIONLIST");
        chargesFramesMap.put("FRAME_PATIENTDETAIL_CHARGEDETAIL", Global_Frames.globalFramesMap.get("FRAME_POPUP_CONTENTS") + ".VIEW__CLINICALDETAIL.DETAIL.contentIFRAME");
    }

}
