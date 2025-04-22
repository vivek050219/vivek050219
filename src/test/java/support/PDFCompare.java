package support;

//import runners.cucumber.Hooks;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.text.PDFTextStripper;
import utils.UtilFunctions;

import java.io.File;
import java.io.FilenameFilter;

/**
 * Created by PatientKeeper on 11/17/2016.
 */

/******************************************************************************
 Class Name: PDFCompare
 Contains operations related to PDF files
 ******************************************************************************/

public class PDFCompare {

    public String className = getClass().getSimpleName();

    public String findFileBySubmissionID(final int submissionID, String mainDir) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        File fileDir = new File(mainDir);
        String[] matchingFiles = fileDir.list(new FilenameFilter() {
            public boolean accept(File fileDir, String name) {
                return name.endsWith(String.valueOf(submissionID) + ".pdf");
            }
        });

        if (matchingFiles.length > 0){
            UtilFunctions.log("File present. Returning fileName: " + matchingFiles[0]);
            return matchingFiles[0];
        }
        else{
            UtilFunctions.log("File not present. Returning null.");
            return null;
        }
    }


    public String[] readPDFFileToStrArray(String dirName, String fileName) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        try {
            File fileObj = new File(dirName + fileName);

            if (fileObj == null){
                UtilFunctions.log("PDF not present. PDF name: " + dirName + fileName + ". Returning null.");
                return null;
            }

            PDDocument doc = PDDocument.load(fileObj);
            PDFTextStripper Tstripper = new PDFTextStripper();
            String st = Tstripper.getText(doc);
            UtilFunctions.log("PDF name: " + dirName + fileName + ". PDf Text: " + st + ". Returning text array.");
            return st.split("\n");
        }
        catch (Exception e){
            UtilFunctions.log("Problem in PDF parsing. PDF name: " + dirName + fileName + ". Returning null.");
            return null;
        }
    }


    public boolean comparePDFStrArrays(String[] outputArr, String[] expectedArr) throws Throwable {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        try {
            for (int index = 0; index < outputArr.length; index++) {
                UtilFunctions.log("Matching PDF line.");
                UtilFunctions.log("Actual String: " + outputArr[index]);
                UtilFunctions.log("Expected String: " + expectedArr[index]);
                boolean skip = false;

                //skip comparison if date is found on a line, checks format of MM/DD/YY
                if (outputArr[index].trim().matches("^.*[0-1]\\d/[0-3]?\\d/\\d{2}.*$"))
                    skip = true;
                    //skip comparison if line is a time
                else if (outputArr[index].trim().matches("\\d\\d:\\d\\d\\w\\w"))
                    skip = true;
                    //skip comparison if line contains Account Number and MRN and NO OTHER INFORMATION
                else if (outputArr[index].trim().matches("\\A\\d+\\W\\d+$"))
                    skip = true;

                if (!skip) {
                    if (outputArr[index].equalsIgnoreCase(expectedArr[index])) {
                        UtilFunctions.log("Actual String: " + outputArr[index] + "Expected String: " +
                                expectedArr[index] + " are EQUAL.");
                        System.out.println("Actual String: " + outputArr[index] + "Expected String: " +
                                expectedArr[index] + " are EQUAL.");
                    } else {
                        UtilFunctions.log("Actual String: " + outputArr[index] + "Expected String: " +
                                expectedArr[index] + " are NOT equal. Returning false...");
                        System.out.println("Actual String: " + outputArr[index] + "Expected String: " +
                                expectedArr[index] + " are NOT equal. Returning false...");
                        return false;
                    }
                }
            }
            return true;
        }
        catch (Exception e){
            UtilFunctions.log("Actual array and Expected array length does not matches. Actual array length: "
                    + outputArr.length + "; Expected array length: " + expectedArr.length + ". Returning false.");
            return false;
        }
    }
}

