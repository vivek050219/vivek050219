package frames;

import java.util.HashMap;

import static frames.Global_Frames.globalFramesMap;

/**
 * Created by PatientKeeper on 6/24/2016.
 */

/******************************************************************************
 Class Name: Admin_Frames
 Contains hash map to map and store frame name and value
 ******************************************************************************/

public class Admin_Frames {

    //Hash Map to store frame values and names related to admin page
    public static HashMap<String, String> adminFramesMap = new HashMap<>();


    /**************************************************************************
     * name: setAdminFramesMap()
     * functionality: Set frame name and value
     * return: void
     *************************************************************************/
    public static void setAdminFramesMap(){
        //admin frames
        adminFramesMap.put("FRAME_PARENT", globalFramesMap.get("FRAME_GLOBAL_MAIN") + ".ADMINNAV.ADMIN");
        adminFramesMap.put("FRAME_MAIN", adminFramesMap.get("FRAME_PARENT") + ".contentIFRAME");
        adminFramesMap.put("FRAME_CONTENT", adminFramesMap.get("FRAME_MAIN") + ".mainContentFrame");
        adminFramesMap.put("FRAME_QUICK_DETAILS", adminFramesMap.get("FRAME_MAIN") + ".quick_details");
        adminFramesMap.put("FRAME_BOTTOM", adminFramesMap.get("FRAME_MAIN") + ".select_bottom");
        adminFramesMap.put("FRAME_TOP", adminFramesMap.get("FRAME_MAIN") + ".select_top");
        adminFramesMap.put("FRAME_INST_MAIN", adminFramesMap.get("FRAME_MAIN") + ".targeted");
        adminFramesMap.put("FRAME_PREFERENCES_HACKS", adminFramesMap.get("FRAME_PARENT") + ".preferenceHacks");

        //institution
        adminFramesMap.put("FRAME_INST_BUTTONS", adminFramesMap.get("FRAME_PARENT") + ".buttonBarIFRAME");
        adminFramesMap.put("FRAME_INST_TABLE_TOP", adminFramesMap.get("FRAME_MAIN") + ".table_top");
        adminFramesMap.put("FRAME_CPOE_PREFERENCES_General", adminFramesMap.get("FRAME_MAIN") + ".VIEW__CPOECONFIGDETAIL.CPOEPREFERENCENEW.activityFrame");
        adminFramesMap.put("FRAME_CPOE_PREFERENCES_PANE", adminFramesMap.get("FRAME_MAIN") + ".VIEW__CPOECONFIGDETAIL.CPOEPREFERENCENEW");
        adminFramesMap.put("FRAME_CPOEORDERDEFINITION", adminFramesMap.get("FRAME_MAIN") + ".VIEW__CPOECONFIGDETAIL.ORDERDEFLIST.activityFrame.searchIFRAME");
        adminFramesMap.put("FRAME_CPOEORDERDEFINITION_RESULTS", adminFramesMap.get("FRAME_CPOEORDERDEFINITION") + ".searchResults");
        adminFramesMap.put("FRAME_CPOEORDERDEFINITIONDETAIL", adminFramesMap.get("FRAME_MAIN") + ".VIEW__CPOECONFIGDETAIL.ORDERDEFLIST.activityFrame.detailIFRAME");
        adminFramesMap.put("FRAME_CPOE_ORDER_SET", adminFramesMap.get("FRAME_MAIN") + ".VIEW__CPOECONFIGDETAIL.ORDERSETLISTNEW.activityFrame");
        adminFramesMap.put("FRAME_CPOE_ORDER_SET_SECTIONS", adminFramesMap.get("FRAME_MAIN") + ".VIEW__CPOECONFIGDETAIL.ORDERSETSECTIONLISTNEW.activityFrame");
        adminFramesMap.put("FRAME_CPOEORDERPROTOTYPE", globalFramesMap.get("FRAME_POPUP_CONTENTS") + ".orderPrototypeIframe");
        adminFramesMap.put("FRAME_MESSAGING_SETTINGS", adminFramesMap.get("FRAME_MAIN") + ".ADMINNAV__CONTENTTD" + ".ADMINNAV" + ".ADMIN" + ".contentIFRAME" + ".targeted");

        //department
        adminFramesMap.put("FRAME_DEPT_BUTTONS", adminFramesMap.get("FRAME_PARENT") + ".buttonBarIFRAME");
        adminFramesMap.put("FRAME_DEPT_TOP", adminFramesMap.get("FRAME_MAIN") + ".table_top");
        adminFramesMap.put("FRAME_DEPT_MAIN", adminFramesMap.get("FRAME_MAIN") + ".targeted");
        adminFramesMap.put("FRAME_DEPT_EDIT", adminFramesMap.get("FRAME_MAIN") + ".select_top");
        adminFramesMap.put("FRAME_ADDQUICKTEXT", globalFramesMap.get("FRAME_TERTIARY_POPUP_CONTENTS") + ".Name_IF");
        adminFramesMap.put("FRAME_TEXTTOINSERT", globalFramesMap.get("FRAME_TERTIARY_POPUP_CONTENTS") + ".DisplayText_IF");
        adminFramesMap.put("FRAME_KEYBOARDSHORTCUT", globalFramesMap.get("FRAME_TERTIARY_POPUP_CONTENTS") + ".Shortcut_IF");

        //bulk user edit
        adminFramesMap.put("FRAME_BULKUSER_SEARCH", adminFramesMap.get("FRAME_MAIN") + ".bulkUserEditSearchIFRAME");
        adminFramesMap.put("FRAME_BULKUSER_EDIT", adminFramesMap.get("FRAME_MAIN") + ".userBucketIFRAME");
        adminFramesMap.put("FRAME_BULKUSER_PREFERENCES", adminFramesMap.get("FRAME_MAIN") + ".preferenceListIFRAME");
        adminFramesMap.put("FRAME_AUTO_CREATE_FAVORITES_SEARCH", globalFramesMap.get("FRAME_POPUP_CONTENTS") + ".autoCreateFavSearchIFRAME");
        adminFramesMap.put("FRAME_AUTO_CREATE_FAVORITES_USER_SEARCHRESULTS", adminFramesMap.get("FRAME_AUTO_CREATE_FAVORITES_SEARCH") + ".userSearchResults");
        adminFramesMap.put("FRAME_AUTO_CREATE_FAVORITES_USER_BUCKET", globalFramesMap.get("FRAME_POPUP_CONTENTS") + ".userBucketIFRAME");
        adminFramesMap.put("FRAME_AUTO_CREATE_FAVORITES_PREFERENCE_LIST", globalFramesMap.get("FRAME_POPUP_CONTENTS") + ".preferenceListIFRAME");
        adminFramesMap.put("FRAME_MANAGE_FAVORITES", "DojoDialogFrame_1");
        adminFramesMap.put("FRAME_BULKUSER_SEARCHRESULTS", adminFramesMap.get("FRAME_BULKUSER_SEARCH") + ".userSearchResults");

        //system management
        adminFramesMap.put("FRAME_SYSMANAGE_NAV", adminFramesMap.get("FRAME_MAIN") + ".SYSMANAGENAV");
        adminFramesMap.put("FRAME_SYSMANAGE_CONTENT", adminFramesMap.get("FRAME_MAIN") + ".VIEW__SYSMANAGEDETAIL");
        adminFramesMap.put("FRAME_MISC", adminFramesMap.get("FRAME_SYSMANAGE_CONTENT") + ".WEBCONTROL.activityFrame");
        adminFramesMap.put("FRAME_REFERENCELISTS", adminFramesMap.get("FRAME_SYSMANAGE_CONTENT") + ".REFLIST");
        adminFramesMap.put("FRAME_PROVIDERS", adminFramesMap.get("FRAME_SYSMANAGE_CONTENT") + ".PROVMAINT");
        adminFramesMap.put("FRAME_ADTVISITTYPE", adminFramesMap.get("FRAME_SYSMANAGE_CONTENT") + ".ADTVISITTYPEMAINT");
        adminFramesMap.put("FRAME_PKVISITTYPE", adminFramesMap.get("FRAME_SYSMANAGE_CONTENT") + ".PKVISITTYPEMAINT");
        adminFramesMap.put("FRAME_PROVIDERGROUP", adminFramesMap.get("FRAME_SYSMANAGE_CONTENT") + ".PGMAINT");
        adminFramesMap.put("FRAME_PROVIDERGROUP_MAIN", adminFramesMap.get("FRAME_PROVIDERGROUP") + ".activityFrame");
        adminFramesMap.put("FRAME_PROVIDERGROUP_SEARCH", adminFramesMap.get("FRAME_PROVIDERGROUP_MAIN") + ".providerGroupSearch");
        adminFramesMap.put("FRAME_PROVIDERGROUP_SEARCHRESULTS", adminFramesMap.get("FRAME_PROVIDERGROUP_SEARCH") + ".providerGroupSearchResults");
        adminFramesMap.put("FRAME_PROVIDERS_MAIN", adminFramesMap.get("FRAME_PROVIDERS") + ".activityFrame");
        adminFramesMap.put("FRAME_PROVIDERS_SEARCH", adminFramesMap.get("FRAME_PROVIDERS_MAIN") + ".searchIFRAME");
        adminFramesMap.put("FRAME_PROVIDERSMAIN_SEARCHRESULTS", adminFramesMap.get("FRAME_PROVIDERS_SEARCH") + ".providerSearchResults");
        adminFramesMap.put("FRAME_PROVIDER_SEARCHRESULTS", adminFramesMap.get("FRAME_POPUP_CONTENTS") + ".providerSearchResults");
        adminFramesMap.put("FRAME_SELF_ASSIGN_REPORT", adminFramesMap.get("FRAME_SYSMANAGE_CONTENT") + ".SELFASSIGNREP");
        adminFramesMap.put("FRAME_SELF_ASSIGN_REPORT_RESULT", adminFramesMap.get("FRAME_SELF_ASSIGN_REPORT") + ".selfAssignResults");
        adminFramesMap.put("FRAME_AUDIT_REPORT", adminFramesMap.get("FRAME_SYSMANAGE_CONTENT") + ".AUDIT");
        adminFramesMap.put("FRAME_AUDIT_REPORT_RESULT", adminFramesMap.get("FRAME_AUDIT_REPORT") + ".resultsIFRAME");
        adminFramesMap.put("FRAME_QUICK_SEARCH", "lookupIframe");


        //Edit Short List Charge Transaction Header
        adminFramesMap.put("FRAME_SHORTLIST_PROVIDERSEARCH", globalFramesMap.get("FRAME_TERTIARY_POPUP_CONTENTS") + ".ProviderSearchFrame");
        adminFramesMap.put("FRAME_SHORTLIST_PROVIDERSEARCHRESULT", adminFramesMap.get("FRAME_SHORTLIST_PROVIDERSEARCH") + ".providerSearchResults");


        //user
        adminFramesMap.put("FRAME_USER_PREFS", adminFramesMap.get("FRAME_MAIN") + ".select_top");
        adminFramesMap.put("FRAME_USER_MAIN", adminFramesMap.get("FRAME_MAIN") + ".targeted");
        adminFramesMap.put("FRAME_USER_BUTTONS", adminFramesMap.get("FRAME_PARENT") + ".buttonBarIFRAME");


        //create user from provider
        adminFramesMap.put("FRAME_USERFROMPROVIDER_MAIN", globalFramesMap.get("FRAME_POPUP_CONTENTS") + ".ProviderSearchIFrameId");
        adminFramesMap.put("FRAME_USERFROMPROVIDER_SEARCHRESULTS", adminFramesMap.get("FRAME_USERFROMPROVIDER_MAIN") + ".providerSearchResults");
        adminFramesMap.put("FRAME_USERFROMPROVIDER_DETAILS", globalFramesMap.get("FRAME_POPUP_CONTENTS") + ".userFromPersonnelIFRAME");
        adminFramesMap.put("FRAME_USERFROMPROVIDER_CREATEUSER", globalFramesMap.get("FRAME_POPUP") + ".userFromPersonnelIFRAME");


        //facility group
        adminFramesMap.put("FRAME_CPOEPREFERENCE", adminFramesMap.get("FRAME_MAIN") + ".CPOECONFIGNAV");
        adminFramesMap.put("FRAME_CPOE_UTILITY", adminFramesMap.get("FRAME_MAIN") + ".VIEW__CPOECONFIGDETAIL.CPOEUTIILITY");
        adminFramesMap.put("FRAME_CPOE_UTILITIES", adminFramesMap.get("FRAME_MAIN") + ".VIEW__CPOECONFIGDETAIL.CPOEUTIILITY.activityFrame");
        adminFramesMap.put("FRAME_CPOE_ORDERGROUPS", adminFramesMap.get("FRAME_MAIN") + ".VIEW__CPOECONFIGDETAIL.ORDERGROUPLIST.activityFrame");
        adminFramesMap.put("FRAME_CPOE_ORDERGROUPS_SEARCH", adminFramesMap.get("FRAME_CPOE_ORDERGROUPS") + ".searchIFRAME");
        adminFramesMap.put("FRAME_CPOE_ORDERGROUPS_SEARCHRESULTS", adminFramesMap.get("FRAME_CPOE_ORDERGROUPS_SEARCH") + ".searchResults");
        adminFramesMap.put("FRAME_CPOE_ORDERGROUPS_DETAILS", adminFramesMap.get("FRAME_CPOE_ORDERGROUPS") + ".detailIFRAME");
        adminFramesMap.put("FRAME_CPOEFIELDSET", adminFramesMap.get("FRAME_MAIN") + ".VIEW__CPOECONFIGDETAIL.FIELDSETLIST.activityFrame.searchIFRAME");
        adminFramesMap.put("FRAME_CPOEFIELDS", globalFramesMap.get("FRAME_SECONDARY_POPUP") + ".contentIFRAME"+ ".searchIFRAME");
        adminFramesMap.put("FRAME_CPOESEARCHRESULTS", adminFramesMap.get("FRAME_CPOEFIELDS") + ".searchResults");
        adminFramesMap.put("FRAME_MEDFREQUENCYDEFINITION", adminFramesMap.get("FRAME_MAIN") + ".VIEW__CPOECONFIGDETAIL.MEDFREQUENCYDEFINITION.activityFrame");
        adminFramesMap.put("FRAME_MEDFREQUENCYDEFINITION_SEARCH", adminFramesMap.get("FRAME_MEDFREQUENCYDEFINITION") + ".searchIFRAME");
        adminFramesMap.put("FRAME_MEDFREQUENCYDEFINITION_SEARCH_RESULTS", adminFramesMap.get("FRAME_MEDFREQUENCYDEFINITION_SEARCH") + ".searchResults");
        adminFramesMap.put("FRAME_MEDFREQUENCYDEFINITION_SEARCH_DETAIL", adminFramesMap.get("FRAME_MEDFREQUENCYDEFINITION") + ".detailIFRAME");

        //Order Set Builder
        adminFramesMap.put("PREVIEW_TAB_DETAIL",globalFramesMap.get("FRAME_POPUP_CONTENTS") + ".previewIframe");
       //NoteWriter
        adminFramesMap.put("FRAME_QUICK_TEXT_EDITOR_DETAIL",  Global_Frames.globalFramesMap.get("FRAME_POPUP_CONTENTS") + ".PickerIFrame");
        //Location
        adminFramesMap.put("FRAME_CPOE_ORDER_DEFINATIONS", globalFramesMap.get("FRAME_SECONDARY_POPUP_CONTENTS") + ".searchIFRAME");
        adminFramesMap.put("FRAME_CPOE_ORDER_ENTRY_SEARCH", adminFramesMap.get("FRAME_CPOE_ORDER_DEFINATIONS") + ".searchResults");
        adminFramesMap.put("FRAME_NOTEWRITER", Global_Frames.globalFramesMap.get("FRAME_POPUP_CONTENTS") + ".NoteWriter");
        //Tracking/Reporting
        adminFramesMap.put("FRAME_TRACKING_REPORTING_TOP", adminFramesMap.get("FRAME_MAIN") + ".DRNAV");
        adminFramesMap.put("FRAME_TRACKING_REPORTING_MAIN", adminFramesMap.get("FRAME_MAIN") + ".VIEW__DEVICEREPORTS");
        adminFramesMap.put("FRAME_TRACKING_REPORTING_DEVICE_SESSIONS", adminFramesMap.get("FRAME_TRACKING_REPORTING_MAIN") + ".DEVICESESSIONS");
        adminFramesMap.put("FRAME_TRACKING_REPORTING_SUBMISSION_RECORDS", adminFramesMap.get("FRAME_TRACKING_REPORTING_MAIN") + ".SUBMISSIONRECORDS");
        adminFramesMap.put("FRAME_TRACKING_REPORTING_GLOBAL_TASKS", adminFramesMap.get("FRAME_TRACKING_REPORTING_MAIN") + ".GLOBALTASKS");
        adminFramesMap.put("FRAME_TRACKING_REPORTING_SUBMISSION_RECORDS_SUMMARY", adminFramesMap.get("FRAME_TRACKING_REPORTING_SUBMISSION_RECORDS") + ".dashboardFrame");
    }
}
