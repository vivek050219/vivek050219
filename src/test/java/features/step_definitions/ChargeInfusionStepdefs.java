package features.step_definitions;

import common.SeleniumFunctions;
import cucumber.api.DataTable;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import features.Hooks;
import org.json.simple.JSONObject;
import org.junit.Assert;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import support.Page;
import utils.UtilFunctions;
import java.util.*;

public class ChargeInfusionStepdefs {

    public String className = getClass().getSimpleName();

    @When("^I add the infusion input \"(.*?)\"$")
    public void inputInfusion(String inputSet) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String inputSets[] = inputSet.split(";");
        WebElement tr;
        for(int i=0; i<inputSets.length; i++){
            String input[] = inputSets[i].split(",");

            for(String s : input){
                s.trim();
                if(s.equals("null")){
                    for (int index =0; index < input.length; index++){
                        input[index] = input[index].replace("null", "");
                    }
                }
            }
            if(i==0){
                tr = SeleniumFunctions.findElement(Hooks.getDriver(), By.xpath("//div[@sectiontype='INFUSION']//tr[@class='serviceFieldGroup' and position()="+(1)+"]"));
            }
            else {
                tr = SeleniumFunctions.findElement(Hooks.getDriver(), By.xpath("//div[@sectiontype='INFUSION']//tr[@class='serviceFieldGroup' and position()="+(i + 1)+"]"));
            }
            WebElement serviceField = SeleniumFunctions.findElementByWebElement(tr, By.xpath(".//td[contains(@class, 'drugServiceCol')]//input[@type='text']"));
            if(!serviceField.getAttribute("value").trim().equals(input[0].trim())){
                serviceField.clear();
                serviceField.sendKeys(input[0].trim());
            }
            //method
            WebElement cell = SeleniumFunctions.findElementByWebElement(tr, By.xpath(".//td[contains(@class, 'deliveryCol')]/div[contains(@class, 'dropdownOptionsContainer')]"));
            SeleniumFunctions.findElementByWebElement(cell, By.xpath(".//select")).click();
            String path;
            if(input[1].equals("")){
                path = "@defaultoption='true'";
            }
            else {
                path = "text()='"+input[1]+"'";
            }
            System.out.println(path);
            SeleniumFunctions.findElementByWebElement(cell, By.xpath(".//option["+path+"]")).click();
            //site
            cell = SeleniumFunctions.findElementByWebElement(tr, By.xpath(".//td[contains(@class, 'siteCol')]/div[contains(@class, 'dropdownOptionsContainer')]"));
            SeleniumFunctions.findElementByWebElement(cell, By.xpath(".//select")).click();
            if(input[2].equals("")){
                path = "@defaultoption='true'";
            }
            else {
                path = "text()='"+input[2]+"'";
            }
            System.out.println(path);
            SeleniumFunctions.findElementByWebElement(cell, By.xpath(".//option["+path+"]")).click();
            //start time
            SeleniumFunctions.findElementByWebElement(tr, By.xpath(".//td[contains(@class, 'startCol')]//input[@type='text' and @class='timeInput']")).sendKeys(input[3]);
            //stop time
            SeleniumFunctions.findElementByWebElement(tr, By.xpath(".//td[contains(@class, 'stopCol')]//input[@type='text' and @class='timeInput']")).sendKeys(input[4]);
            //add
            SeleniumFunctions.findElementByWebElement(tr, By.xpath(".//td[@class='addServiceCol']/img")).click();
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @When("^I close the infusion screen$")
    public void closeInfusionScreen() throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        GlobalStepdefs globalStepdefs = new GlobalStepdefs();

        globalStepdefs.clickButton("InfusionOK", null, null);
        globalStepdefs.clickButton("NoInfusion", "System Generated Prompt", "exists");

        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(GlobalStepdefs.curTabName);
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(GlobalStepdefs.curTabName);
        String section = UtilFunctions.getElementFromJSONFile(fileObj, "PANE_SECTIONS." + "ChargeList","path");
        String paneFrames = UtilFunctions.getFrameValue(frameMap, "FRAME_POPUP_CONTENTS");
        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");

        Thread.sleep(3000);
        Page.textExists(Hooks.getDriver(),"Mod", section, false);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @Then("^the codes \"(.*?)\" should appear in the charges table$")
    public void checkGeneratedCodes(String codeList) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        PatientListClinicalsStepdefs patientListClinicalsStepdefs = new PatientListClinicalsStepdefs();

        List<String> raw;
        List<List<String>> itemList = new ArrayList<>();

        raw = Arrays.asList("Charges", "Mod", "Qty");
        itemList.add(raw);

        for(String code : codeList.split(";")){
            code = code.trim();

            boolean hasQty = code.contains(":");
            boolean hasMod = code.contains("-");
            //Passing the qty and mod values as String, these values may not always be present
            //and we cannot pass '0', because if qty and mod are not present it will be blank in the application
            String qty;
            String mod="";

            if(hasQty){
                String[] temp = code.split(":");
                qty = temp[1];
                code = temp[0];
            }
            else {
                qty = "1";
            }

            if(hasMod){
                String[] temp = code.split("-");
                mod = temp[1];
                code = temp[0];
            }

            code.matches("\"^(\\d+)\"");
            int cpt = Integer.valueOf(code);
            //assign the variables to raw ArrayList and then add it to "itemList", as the format List<String,String,String> is not
            //allowed for List "add" method
            raw = Arrays.asList(""+cpt+"", ""+mod+"", ""+qty+"");
            itemList.add(raw);

        }

        //Create cucumber DataTable to pass the same to the method "checkDataInTable"
        DataTable dataTable = DataTable.create(itemList);
        for(int iterator= 0; iterator<=1; iterator++ ){
            try {
                globalStepdefs.selectFromTheTable("the first item", "Charges");
                globalStepdefs.checkDataInTable("rows starting with the following", null, "Charge Detail Charge List", null, dataTable);
                break;
            }
            catch (Exception e){
                UtilFunctions.log("Table Data is not verified due to exception: "+e.getMessage());
                Assert.assertFalse("Table Data is not verified due to exception: "+e.getMessage(),iterator == 1);
                patientListClinicalsStepdefs.refreshClinicalDisplay();
                Thread.sleep(5000);
            }
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }
}


