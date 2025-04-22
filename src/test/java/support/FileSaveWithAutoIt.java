package support;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import utils.UtilFunctions;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class FileSaveWithAutoIt {
    public String className = getClass().getSimpleName();

    /*
    * Wrote this class, but not using it.  -- HIC 01/17/19*/

    public void saveFile(WebDriver driver){
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        try{
            //String homeUser = System.getProperty("user.home");
            //String filepath = homeUser + "\\Downloads\\DLFile.exe";
            //Runtime.getRuntime().exec("C:\\Users\\hcunningham\\Downloads\\DLFile.exe");

            //ProcessBuilder pb = new ProcessBuilder("Runtime.getRuntime().exec(\"C:\\Users\\hcunningham\\Downloads\\DLFile.exe\");");
            ProcessBuilder pb = new ProcessBuilder("C:\\Users\\hcunningham\\Downloads\\DLFile.exe");
            pb.redirectOutput(ProcessBuilder.Redirect.INHERIT);
            pb.redirectError(ProcessBuilder.Redirect.INHERIT);
            Process p = pb.start();
            //pb.start();

           /* String line;
            Process process = Runtime.getRuntime().exec("C:\\Users\\hcunningham\\Downloads\\DLFile.exe");
            BufferedReader input = new BufferedReader(new InputStreamReader(process.getInputStream()));
            while ((line = input.readLine()) != null) {
                System.out.println(line);
            }
            input.close();*/

            //UtilFunctions.log(className + " saveFile method ran properly.");
        }
        catch (IOException e){
            UtilFunctions.log(className + " saveFile method did not run properly.  You might not be user IE " +
                    "as a browser.  Exception: " +
                    e.getMessage());
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }
}//end class FileSaveWithAutoIt
