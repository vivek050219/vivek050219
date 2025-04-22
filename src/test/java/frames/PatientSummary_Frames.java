package frames;

import java.util.HashMap;

/**
 * Created by Offshore on 4/24/2017.
 */

/******************************************************************************
 Class Name: PatientSummary_Frames
 Contains hash map to map and store frame name and value
 ******************************************************************************/

public class PatientSummary_Frames {

    //Hash Map to store frame values and names related to PatientSummary page
    public static HashMap<String, String> patientSummaryFramesMap = new HashMap<>();


    /**************************************************************************
     * name: setPatientSummaryFramesMap()
     * functionality: Set frame name and value
     * return: void
     *************************************************************************/
    public static void setPatientSummaryFramesMap(){
        //PatientSummary frames
        //charges frames
        patientSummaryFramesMap.put("FRAME_PARENT", Global_Frames.globalFramesMap.get("FRAME_GLOBAL_MAIN") + ".PTSUMMARYTABS" + ".VIEW__PTSUMMARYTAB");

        //patient summary frames
        patientSummaryFramesMap.put("FRAME_PATSUMMARY", patientSummaryFramesMap.get("FRAME_PARENT") + ".PTSUMMARY");
        patientSummaryFramesMap.put("FRAME_PATSUMMARYLIST", patientSummaryFramesMap.get("FRAME_PATSUMMARY") + ".PTSUMMARY");

        //sign-out frames
        patientSummaryFramesMap.put("FRAME_SIGNOUT", patientSummaryFramesMap.get("FRAME_PARENT") + ".SIGNOUT");


    }
}
