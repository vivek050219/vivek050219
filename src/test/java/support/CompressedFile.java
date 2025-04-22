package support;

import utils.UtilFunctions;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.DirectoryNotEmptyException;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Paths;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

public class CompressedFile{

    public String className = getClass().getSimpleName();

    public void unzipFile(String zippedFile, String destinationFolder) throws IOException{
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        File destinationDir = new File(destinationFolder);
        if (!destinationDir.exists())
            destinationDir.mkdir();

        byte[] buffer = new byte[1024];
        ZipInputStream zipInputStream = new ZipInputStream(new FileInputStream(zippedFile));
        ZipEntry zipEntry = zipInputStream.getNextEntry();

        while (zipEntry != null){
            File newFile = createNewFile(destinationDir, zipEntry);
            FileOutputStream fileOutputStream = new FileOutputStream(newFile);

            int len;
            while ((len = zipInputStream.read(buffer)) > 0)
                fileOutputStream.write(buffer, 0, len);

            fileOutputStream.close();
            zipEntry = zipInputStream.getNextEntry();
        }

        zipInputStream.closeEntry();
        zipInputStream.close();

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }//end unzipFile


    public File createNewFile(File destinationDir, ZipEntry zipEntry) throws IOException{
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        File outputFile = new File(destinationDir, zipEntry.getName());
        String destinationDirPath = destinationDir.getCanonicalPath();
        String outputFilePath = outputFile.getCanonicalPath();

        if (!outputFilePath.startsWith(destinationDirPath + File.separator)) {
            throw new IOException("Entry is outside of the target dir: " + zipEntry.getName());
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");

        return outputFile;
    }//end createNewFile

    public void deleteDLdFile(String fileName, String filePath){
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        try {
            Files.deleteIfExists(Paths.get(filePath));
            UtilFunctions.log("File deleted successfully: " + fileName);
        } catch (NoSuchFileException noSuchFileException) {
            UtilFunctions.log("No such file: '" + fileName + "': " + noSuchFileException.getMessage());
            System.out.println("No such file: '" + fileName + "'");
            System.err.format("%s: no such" + " file or directory%n", fileName);
        } catch (DirectoryNotEmptyException dirNotEmptyException) {
            UtilFunctions.log("File NOT deleted successfully: '" + fileName + "' due to: " +
                    dirNotEmptyException.getMessage());
            System.out.println("File NOT deleted successfully: '" + fileName + "' due to: " +
                    dirNotEmptyException.getMessage());
            System.err.format("%s not empty%n", fileName);
        } catch (IOException ioException) {
            // File permission problems are caught here.
            UtilFunctions.log("File NOT deleted successfully: '" + fileName + "' due to: " +
                    ioException.getMessage());
            System.out.println("File NOT deleted successfully: '" + fileName + "' due to: " +
                    ioException.getMessage());
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

}
