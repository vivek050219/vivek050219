package frames;

import java.util.HashMap;

/**
 * Created by Offshore on 4/27/2017.
 */

/******************************************************************************
 Class Name: ProviderDirectory_Frames
 Contains hash map to map and store frame name and value
 ******************************************************************************/

public class ProviderDirectory_Frames {

    //Hash Map to store frame values and names related to forms page
    public static HashMap<String, String> providerDirectoryFramesMap = new HashMap<>();


    /**************************************************************************
     * name: setProviderDirectoryFramesMap()
     * functionality: Set frame name and value
     * return: void
     *************************************************************************/
    public static void setProviderDirectoryFramesMap(){
  
         //ProviderDirectory frames

        providerDirectoryFramesMap.put("FRAME_PARENT", Global_Frames.globalFramesMap.get("FRAME_GLOBAL_MAIN") + ".PROVIDERDIRECTORY");
        providerDirectoryFramesMap.put("PROVIDER_DIRECTORY_SEARCH", providerDirectoryFramesMap.get("FRAME_PARENT") + ".ProviderDirectorySearchFrame");
        providerDirectoryFramesMap.put("PROVIDER_DIRECTORY_SEARCH_RESULTS", providerDirectoryFramesMap.get("PROVIDER_DIRECTORY_SEARCH") + ".providerDirectorySearchResults");
        providerDirectoryFramesMap.put("FRAME_DIALOG", Global_Frames.globalFramesMap.get("FRAME_DIALOG"));


    }
}
