package testData;

import utils.UtilFunctions;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

/**
 * Created by atripathi on 9/22/2017.
 */
public class CreateERXTestData {
    public static boolean createERXJSONData(StringBuilder finalJSON, String jsonLocation) {
        return deleteCurrentFile(jsonLocation) && createNewFile(finalJSON, jsonLocation);
    }

    private static boolean deleteCurrentFile(String file){
        try{

            File fileObj = new File(file);

            if (!fileObj.isFile()){
                System.out.println(fileObj.getName() + " is NOT Present! Returning TRUE!");
                UtilFunctions.log(fileObj.getName() + " is NOT Present! Returning TRUE!");
                return true;
            }

            if(fileObj.delete()){
                System.out.println(fileObj.getName() + " is deleted!");
                UtilFunctions.log(fileObj.getName() + " is deleted!");
                return true;
            }else{
                System.out.println("Delete operation is failed.");
                UtilFunctions.log(fileObj.getName() + " is NOT deleted!");
                return false;
            }

        }catch(Exception e){
            e.printStackTrace();
            UtilFunctions.log("File is NOT deleted!");
            UtilFunctions.log("Exception: " + e.getMessage());
            return false;
        }

    }

    private static boolean createNewFile(StringBuilder fileStr, String fileLocation){
        try {

            FileWriter file = new FileWriter(fileLocation);
            file.write(fileStr.toString());
            file.flush();

            System.out.println(fileLocation + " is created!");
            UtilFunctions.log(fileLocation + " is created!");
            return true;

        } catch (IOException e) {
            e.printStackTrace();
            System.out.println(fileLocation + " is NOT created!");
            UtilFunctions.log(fileLocation + " is NOT created!");
            UtilFunctions.log("Exception: " + e.getMessage());
            return false;
        }
    }
}
