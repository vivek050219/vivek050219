package frames;

import java.util.HashMap;

import static frames.PatientList_Frames.patientListFramesMap;

/**
 * Created by Offshore on 4/26/2017.
 */

/******************************************************************************
 Class Name: Inbox_Frames
 Contains hash map to map and store frame name and value
 ******************************************************************************/

public class Inbox_Frames {

    //Hash Map to store frame values and names related to forms page
    public static HashMap<String, String> inboxFramesMap = new HashMap<>();


    /**************************************************************************
     * name: setInboxFramesMap()
     * functionality: Set frame name and value
     * return: void
     *************************************************************************/
    public static void setInboxFramesMap(){
  
         //Inbox frames
        inboxFramesMap.put("FRAME_PARENT", Global_Frames.globalFramesMap.get("FRAME_GLOBAL_MAIN") + ".INBOX.VIEW__INBOXTAB");
        inboxFramesMap.put("FRAME_DIALOG", Global_Frames.globalFramesMap.get("FRAME_DIALOG"));

		// eSig and PK Mail frames
		inboxFramesMap.put("FRAME_ESIGANDPKMAIL", inboxFramesMap.get("FRAME_PARENT") + ".MESSAGELISTINBOX");
		inboxFramesMap.put("FRAME_ESIGANDPKMAIL_LIST", inboxFramesMap.get("FRAME_ESIGANDPKMAIL") + ".INBOXMESSAGELIST");
		inboxFramesMap.put("FRAME_ESIGANDPKMAIL_INBOX", inboxFramesMap.get("FRAME_ESIGANDPKMAIL_LIST") + ".INBOX_FRAME");
		inboxFramesMap.put("FRAME_ESIGANDPKMAIL_DETAIL", inboxFramesMap.get("FRAME_ESIGANDPKMAIL") + ".INBOXMESSAGEDETAIL.contentIFRAME");
		inboxFramesMap.put("FRAME_NOTEWRITER", Global_Frames.globalFramesMap.get("FRAME_POPUP_CONTENTS") + ".NoteWriter");
		inboxFramesMap.put("FRAME_PROVIDERLOOKUP", "lookupIframe");

		inboxFramesMap.put("FRAME_POPUP_CONTENTS_USERSEARCH", Global_Frames.globalFramesMap.get("FRAME_POPUP_CONTENTS") + ".usersearch");
		inboxFramesMap.put("FRAME_POPUP_CONTENTS_USERSEARCHRESULT", inboxFramesMap.get("FRAME_POPUP_CONTENTS_USERSEARCH") + ".userSearchResults");
		inboxFramesMap.put("FRAME_POPUP_CONTENTS_USERSEARCH_RECIPIENTS", inboxFramesMap.get("FRAME_POPUP_CONTENTS_USERSEARCH") + ".recipients");

		inboxFramesMap.put("FRAME_ESIG_LABLIST", Global_Frames.globalFramesMap.get("FRAME_SECONDARY_POPUP_CONTENTS") + ".VIEW__CLINICALDETAIL.LABLIST");
		inboxFramesMap.put("FRAME_ESIG_TESTRESULT", Global_Frames.globalFramesMap.get("FRAME_SECONDARY_POPUP_CONTENTS") + ".VIEW__CLINICALDETAIL.RESULTLIST");
		inboxFramesMap.put("FRAME_ESIG_APDXSEARCHQTV2", inboxFramesMap.get("FRAME_NOTEWRITER") + ".DXSearchContainerIframe_2");

		// Send PK Mail frames
		inboxFramesMap.put("FRAME_SENDPKMAIL", inboxFramesMap.get("FRAME_PARENT") + ".SENDMESSAGE");
		inboxFramesMap.put("FRAME_SENDPKMAIL_USERSEARCH", inboxFramesMap.get("FRAME_SENDPKMAIL") + ".usersearch");
		inboxFramesMap.put("FRAME_SENDPKMAIL_USERSEARCHRESULTS", inboxFramesMap.get("FRAME_SENDPKMAIL_USERSEARCH") + ".userSearchResults");
		inboxFramesMap.put("FRAME_SENDPKMAIL_RECIPIENTS", inboxFramesMap.get("FRAME_SENDPKMAIL") + ".recipients");
		inboxFramesMap.put("FRAME_NOTEWRITER_INSERT_PREVIOUS", inboxFramesMap.get("FRAME_NOTEWRITER") + ".InsertPreviousFrame");
    }
}
