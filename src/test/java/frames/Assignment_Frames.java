package frames;

import java.util.HashMap;


public class Assignment_Frames {
    //Hash Map to store frame values and names related to assignment page
    public static HashMap<String, String> assignmentFramesMap = new HashMap<>();

    public static void setAssignmentFramesMap() {
//        assignmentFramesMap.put("FRAME_PARENT", Global_Frames.globalFramesMap.get("FRAME_GLOBAL_MAIN") + ".PLASSIGNMENT.PLASSIGNMENT");
        assignmentFramesMap.put("FRAME_PARENT", Global_Frames.globalFramesMap.get("FRAME_GLOBAL_MAIN") + ".PLASSIGNMENT.PLASSIGNMENT");
        assignmentFramesMap.put("FRAME_PATIENTLIST_ASSIGNMENT", Assignment_Frames.assignmentFramesMap.get("FRAME_PARENT") + ".PATIENTLIST_ASSIGNMENT_FRAME");

    }
}