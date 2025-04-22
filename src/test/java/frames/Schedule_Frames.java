package frames;

import java.util.HashMap;
import static frames.Global_Frames.globalFramesMap;

/**
 * Created by Offshore on 5/1/2017.
 */

/******************************************************************************
 Class Name: Schedule_Frames
 Contains hash map to map and store frame name and value
 ******************************************************************************/

public class Schedule_Frames {

    //Hash Map to store frame values and names related to forms page
    public static HashMap<String, String> scheduleFramesMap = new HashMap<>();


    /**************************************************************************
     * name: setScheduleFramesMap()
     * functionality: Set frame name and value
     * return: void
     *************************************************************************/
    public static void setScheduleFramesMap(){
  
         //Schedule frames
        scheduleFramesMap.put("FRAME_PARENT", globalFramesMap.get("FRAME_GLOBAL_MAIN") + ".SCHEDULE");
        scheduleFramesMap.put("FRAME_MAIN", scheduleFramesMap.get("FRAME_PARENT") + ".contentIFRAME");
        scheduleFramesMap.put("FRAME_SEARCH_CRITERIA", scheduleFramesMap.get("FRAME_PARENT") + ".SCHEDULECRITERIA");
        scheduleFramesMap.put("FRAME_SCHEDULE_TABLE", scheduleFramesMap.get("FRAME_PARENT") + ".SCHEDULE");
        scheduleFramesMap.put("FRAME_SEARCH_RESULTS", globalFramesMap.get("FRAME_POPUP_CONTENTS") + ".SearchResults");

        //Print Schedule Frame
        scheduleFramesMap.put("FRAME_PRINT_SCHEDULE", globalFramesMap.get("FRAME_GLOBAL_MAIN") + ".windowFrame1");

        //Charges
        scheduleFramesMap.put("FRAME_CLINDETAIL", scheduleFramesMap.get("FRAME_PARENT") + ".VIEW__PTINFO.VIEW__CLINICALNAVDETAIL.VIEW__CLINICALDETAIL");
        scheduleFramesMap.put("FRAME_CHARGELIST", globalFramesMap.get("FRAME_POPUP_CONTENTS") + ".VIEW__CLINICALDETAIL.PATIENTINTERACTIONLIST");
        scheduleFramesMap.put("FRAME_PATIENT_DETAIL_CLINICALNAV", globalFramesMap.get("FRAME_POPUP_CONTENTS") + ".CLINNAV");
        scheduleFramesMap.put("FRAME_PATDETAIL", globalFramesMap.get("FRAME_POPUP_CONTENTS") + ".VIEW__CLINICALDETAIL.PTDETAIL");
        
    }
}
