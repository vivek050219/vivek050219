package features.step_definitions;

import common.SeleniumFunctions;
import cucumber.api.java.en.And;
import features.Hooks;
import org.json.simple.JSONObject;
import org.junit.Assert;
import org.openqa.selenium.WebElement;
import utils.UtilFunctions;

import java.util.HashMap;

/**
 * Created by PatientKeeper on 8/14/2017.
 */
public class PhotoViewerStepdefs {
    public String className = getClass().getSimpleName();
    public static HashMap<String, String> persistent_state = new HashMap<>();

    @And("^I store the photoID of the image \"(.*?)\"$")
    public void StorePhotoID(String imageName) throws Throwable{
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
        String[] elementType = UtilFunctions.getElementStringAndType(fileObj, "MISC_ELEMENTS." + "CurrentImage");
        String buttonPath = elementType[0];
        String buttonMethod = elementType[1];

        WebElement imgObj = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues(buttonPath + ";" + buttonMethod));
        String className =  imgObj.getAttribute("class");
        String id = imgObj.getAttribute("id");
        persistent_state.put(imageName, id);
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");

    }

    @And("^I check the photoID of the image \"(.*?)\"$")
    public Boolean CheckPhotoID(String imageName) throws Throwable{
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
        String[] elementType = UtilFunctions.getElementStringAndType(fileObj, "MISC_ELEMENTS." + "CurrentImage");
        String buttonPath = elementType[0];
        String buttonMethod = elementType[1];

        WebElement imgObj = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues(buttonPath + ";" + buttonMethod));
        String className =  imgObj.getAttribute("class");
        String id = imgObj.getAttribute("id");
        String checkID = persistent_state.get(imageName);
        if(!(id.equals(checkID)))
            return false;
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
        return true;
    }

    @And("^I zoom (in|out) the photo$")
    public void purgeOption(String zoomType) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String button;
        if (zoomType.equals("in")){
            button = "ZoomIn";
        } else {
            button = "ZoomOut";
        }

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
        String[] elementType = UtilFunctions.getElementStringAndType(fileObj, "MISC_ELEMENTS." + "CurrentImage");
        String imagePath = elementType[0];
        String imageMethod = elementType[1];

        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        //Image doesn't have "style" attribute until a resize action is performed.  Click Zoom in/out and store height/width.
        globalStepdefs.clickButton(button, null, null);
        WebElement imgObj = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues(imagePath + ";" + imageMethod));
        String[] styleParts = imgObj.getAttribute("style").split(";");
        int heightIndex = UtilFunctions.getArrayIndexOfString(styleParts, "height");
        int widthIndex = UtilFunctions.getArrayIndexOfString(styleParts, "width");
        Assert.assertTrue("Index of height or weight not found in styleParts array.", (heightIndex >=0) && (widthIndex >= 0));
        float previousHeight = Float.valueOf(styleParts[heightIndex].replaceAll("[^\\d.]+|\\.(?!\\d)", ""));
        float previousWidth = Float.valueOf(styleParts[widthIndex].replaceAll("[^\\d.]+|\\.(?!\\d)", ""));

        //Click Zoom in/out again. Store new height/width.
        globalStepdefs.clickButton(button, null, null);
        styleParts = imgObj.getAttribute("style").split(";");
        heightIndex = UtilFunctions.getArrayIndexOfString(styleParts, "height");
        widthIndex = UtilFunctions.getArrayIndexOfString(styleParts, "width");
        Assert.assertTrue("Index of height or weight not found in styleParts array.", (heightIndex >=0) && (widthIndex >= 0));
        float height = Float.valueOf(styleParts[heightIndex].replaceAll("[^\\d.]+|\\.(?!\\d)", ""));
        float width = Float.valueOf(styleParts[widthIndex].replaceAll("[^\\d.]+|\\.(?!\\d)", ""));

        if (zoomType.equals("in")){
            Assert.assertTrue("Zoom In failed.", (height > previousHeight) && (width > previousWidth));
        } else {
            Assert.assertTrue("Zoom Out failed.", (height < previousHeight) && (width < previousWidth));
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }
}
