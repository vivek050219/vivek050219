package support;

import utils.UtilFunctions;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

public class ExportedTextFile {

    public String className = getClass().getSimpleName();

    public List openReadWholeFile(String filepath, String cellValue, String columnHeading) throws IOException {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        try {
            List<String> lines = Files.readAllLines(Paths.get(filepath), StandardCharsets.UTF_8);
            UtilFunctions.log("File " + filepath + " successfully opened and read into a List.");
            return lines;
        } catch (IOException e) {
            e.printStackTrace();
            UtilFunctions.log("File " + filepath + " not successfully opened and read into a List.");
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
        return null;
    }//end openAndReadFile


    public String[] getColumnHeadings(List lines) {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String colHeadings = (String) lines.get(0);
        String[] colHeadingsArray = colHeadings.split("\\t");
        //testing
        /*System.out.println();
        System.out.println("Column Headings:");
        System.out.println("-----------------");
        for (int i = 0; i < colHeadingsArray.length; ++i)
            System.out.println(i + ".  " + colHeadingsArray[i]);
        System.out.println();*/

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
        return colHeadingsArray;
    }//end getColumnHeadings


    //Get the first line from the file that has actual patient data in it, not column headings
    public String[] getFirstLineOfData(List lines) {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String firstLine = (String) lines.get(1);
        String[] firstLineArray = firstLine.split("\\t");
        //testing
        /*System.out.println();
        System.out.println("First Line of Data:");
        System.out.println("--------------------");
        for (int i = 0; i < firstLineArray.length; ++i)
            System.out.println(i + ".  " + firstLineArray[i]);
        System.out.println();*/

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
        return firstLineArray;
    }//end getFirstLineOfData


    public Map createDictionary(List lines) {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String[] colHeadingsArray = getColumnHeadings(lines);
        String[] firstLineArray = getFirstLineOfData(lines);

        Map<String, String> dictionary = new HashMap();
        for (int i = 0; i < colHeadingsArray.length; ++i) {
            dictionary.put(colHeadingsArray[i], firstLineArray[i]);
        }

        //testing
        /*System.out.println();
        System.out.println("Dictionary:");
        System.out.println("-------------");
        for(Map.Entry<String, String> entry : dictionary.entrySet()){
            String key = entry.getKey(), value = entry.getValue();
            System.out.println("key = " + key + ",   value = " + value);
        }
        System.out.println();*/

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
        return dictionary;
    }//end createDictionary


    public boolean compareDataToDictionary(String cellValue, String columnHeading, Map dictionary) {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        //This 'dictionary.get(columnHeading)' should return the value that goes with the key columnHeading,
        //which should match the cellValue passed in.  Or, the test should fail.
        String dictionaryVal = dictionary.get(columnHeading).toString();

        //testing
//        cellValue = UtilFunctions.convertThruRegEx("");
       //cellValue = UtilFunctions.convertThruRegEx("01/23/19");

        //cellValue = cellValue.replace(" ", "");
        //dictionaryVal = dictionaryVal.replace(" ", "");
        if(dictionaryVal.equals("")){
            UtilFunctions.log("For key, \"" + columnHeading + ",\" the actual value is blank when it should be: " +
                    cellValue + ".");
            return false;
        }
        else if (dictionaryVal.contains(cellValue)) {
            UtilFunctions.log("For key, \"" + columnHeading + ",\" the expected value, " + cellValue +
                    ", matches the actual value, " + dictionaryVal);
            return true;
        }

        UtilFunctions.log("For key, \"" + columnHeading + ",\" the expected value is " + cellValue +
                ", but the actual value is " + dictionaryVal);
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
        return false;
    }
}//end class ExportedTextFile
