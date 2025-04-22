package features.step_definitions;

import common.SeleniumFunctions;
import constants.GlobalConstants;
import cucumber.api.DataTable;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import features.Hooks;
import org.json.simple.JSONObject;
import org.junit.Assert;
import org.openqa.selenium.*;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import support.Page;
import support.db.DBExecutor;
import utils.UtilFunctions;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.awt.Robot;
import static java.awt.event.KeyEvent.*;


/**
 * Created by PatientKeeper on 4/30/2018.
 */
public class MessageStepdefs {

    public Robot robot;
    public String className = getClass().getSimpleName();
    public static String curTabName = "";
    public int resultCount = 0;

    /**
     * 1. Checks if you are already in the correct conversation window
     * If YES the correct conversation window is already open (End Method)
     * If NO the correct conversation must be opened
     * <p>
     * 2. Checks if the chat window is maximized
     * If YES move to next step
     * If NO then maximize the window and move to next step
     * <p>
     * 3. Check if the correct conversation is listed in active conversations
     * If YES move to next step
     * If NO (Start a Conversation window is covering the chat) click though the "start a Conversation" window
     * <p>
     * 3.5 Check if the user is sending or reading
     * If SENDING search for the target user in the search bar
     * If READING move to next step
     * <p>
     * 4. Active conversation should be clickable --> Click on it
     * <p>
     * Now you will have a chat window open with the given user
     *
     * @param actionType - Weather you are sending or receiving a message
     * @param firstName  - The target users first name
     * @param lastName   - The target users last name
     * @throws Throwable - An error
     */
    @And("^I can (send|read)? messages (?:to|from)? the (?:user: \"(.*?)\" \"(.*?)\"|group \"(.*?)\" with \"(.*?)\" people)?$")
    public void openChatConversation(String actionType, String firstName, String lastName, String groupName, String groupSize) throws Throwable {

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        SeleniumFunctions.selectFrame(Hooks.getDriver(), "NO_FRAME", "id");

        String xpath;
        String formattedName;
        WebElement chatConversation;

        if(groupName == null && firstName.equals("New") && lastName.equals("Results")){

            formattedName = String.format("%s %s", firstName, lastName);
        }
        else if(groupName != null){

            formattedName = groupName;
        }
        else{

            formattedName = String.format("%s. %s", firstName.charAt(0), lastName);
        }

        xpath = String.format("//span[contains(text(), '%s') and ancestor::div[contains(@id, 'recent-conversation-list')]];xpath",
                (groupName != null ? String.format("%s", groupName) : formattedName));

        SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.TWO, xpath);
        chatConversation = SeleniumFunctions.findElement(Hooks.getDriver(),
                SeleniumFunctions.setByValues(xpath));

        if (chatConversation == null) {

            // A method to click the message tab then Start a Conversation if it is present
            openMessageWindow();

            if (groupName == null) {
                // If the conversation with the target user is listed in recent conversations then open it
                xpath = String.format("//ul[contains(@class, 'chatlist')]/descendant::span[text()='%s %s'];xpath",
                        firstName, lastName);
            }
            else{

                // This xpath selects a group chat conversation. It makes sure the group chat icon and the correct number of
                // people are displayed next to the name
                xpath = String.format("//ul[contains(@class, 'chatlist')]/li/i[@class='statusIndicator groupIndicator fa fa-users']/following-sibling::h4/span[text()='%s']/following-sibling::span[text()='(%s)'];xpath",
                        groupName, groupSize);
            }

            SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.ONE, xpath);
            WebElement correctConversation = SeleniumFunctions.findElement(Hooks.getDriver(),
                    SeleniumFunctions.setByValues(xpath));


            if (actionType.equals("send") && correctConversation == null) {

                Assert.assertTrue("The element: User Search Box failed to set the text\n", Page.setTextBox(Hooks.getDriver(),
                        "", firstName + " " + lastName, "User Search Bar"));
            }

            // Open the target user chat conversation
            SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.ONE, xpath);
            correctConversation = SeleniumFunctions.findElement(Hooks.getDriver(),
                    SeleniumFunctions.setByValues(xpath));

            // If the correct conversation does not appear then there is an error
            Assert.assertNotNull(String.format("The conversation with the %s could not be opened\n",
                    (groupName == null ? String.format("user: %s %s", firstName, lastName) : String.format("group: %s", groupName))), correctConversation);

            correctConversation.click();
            Assert.assertNotNull("Conversation was not opened",Page.findPane(Hooks.getDriver(),GlobalStepdefs.curTabName,"MessageArea"));
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }


    @Then("^make sure the \"(.*?)\" group with \"(.*?)\" people (?:(is|is not)? shown on the \"(.*?)\" card|(does|does not)? have a new message)?$")
    public void verifyGroupName(String groupName, String groupSize, String isVisible, String currentCard, String hasNewMessage){

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String xpath = null;
        String singleOrDouble = "'";
        WebElement groupNameElement;

        // If the group name contains a single quote ' then double quotes " must be used in the xpath or the xpath will
        // be invalid. Default is single quote
        if(groupName.contains("'")){
            singleOrDouble = "\"";
        }

        if(isVisible != null){
            if(currentCard.equals("Recent Conversations")){

            // If hasNewMessage is not null then the xpath will include a check for a new message notification with the
            // group name
            xpath = String.format("//div[@id='recent-conversation-list'%s]/ul/li[@data-groupid]/h4[@class='displayName']/span[text()=%s%s%s]/following-sibling::span[text()='(%s)'];xpath",
                    (hasNewMessage != null ? " and class='newMessage'" : ""), singleOrDouble, groupName, singleOrDouble, groupSize);

            }else if(currentCard.equals("In Conversation")){

            xpath = String.format("//div[@class='tab-title text-ellipsis']/a[@class='group-name']/span[text()=%s%s%s]/following-sibling::span[text()=' (%s)'];xpath",
                    singleOrDouble, groupName, singleOrDouble, groupSize);
            }
            SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.FIVE, xpath);
            groupNameElement = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues(xpath));

            if (isVisible.equals("is")) {
                Assert.assertNotNull("The group:\"" + groupName + "\" with " + groupSize + " were not found", groupNameElement);
                Assert.assertTrue(String.format("The group '%s' with %s people on the %s was not found\n", groupName, groupSize,
                        currentCard), groupNameElement.isDisplayed());
            } else {
                if (groupNameElement == null) {
                    Assert.assertNull(String.format("The group '%s' with %s people on the %s was not found\n", groupName, groupSize,
                            currentCard), groupNameElement);
                } else{
                    Assert.assertFalse(String.format("The group '%s' with %s people on the %s was not found\n", groupName, groupSize,
                            currentCard), groupNameElement.isDisplayed());
                }
            }
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    /**
     *
     * This method click on the messaging tab and opens the window to either recent conversations or "Start a Conversation"
     */
    @And("^I open the messaging window?")
    public void openMessageWindow(){

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        SeleniumFunctions.selectFrame(Hooks.getDriver(), "NO_FRAME", "id");

        String messageTabXpath= "//div[@id='chat1' and contains(@class,'chat') and contains(@class,'minimized')]/div[@class='header flex-shrink']/h4[@class='statusHeader']/span[@class='status'];xpath";
        WebElement chatTab;

        // If the message tab is minimized then you must first maximize the chat window
        chatTab = waitToFindXpath(messageTabXpath, GlobalConstants.TWO);

        if(chatTab != null) {

            chatTab.click();
        }

        if((chatTab = waitToFindXpath(messageTabXpath, GlobalConstants.ONE)) != null){

            for (int i = 0; i < 5 && chatTab != null; i++) {

                chatTab.click();
                chatTab = waitToFindXpath(messageTabXpath, GlobalConstants.ONE);
            }
        }

        // If the message tab is clicked the message tab minimized will no longer exist
        Assert.assertNull("The message tab was not opened\n", chatTab);

        String startConversationXpath = "//div[@id='chat1' and not(contains(@class, 'chatAreaCovered'))];xpath";
        WebElement startConversation = waitToFindXpath(startConversationXpath, GlobalConstants.ONE);

        if(startConversation != null){

            startConversation.click();
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    /**
     *  This method queries the database to see if the given message exists. Since HTML tags are capitalized in the query
     *  both strings are converted to uppercase.
     *
     *  1. The id's of the two users is found
     *  2. The query is built with the correct template
     *  3. Query is executed
     *
     * @param messageExists - null = the message should be in the database | not = message should not be in database
     * @param queryType - The format for the where query
     * @param messageStart - The first half the message or the whole message if messageEnd is null
     * @param messageEnd - The second half of the message (optional)
     * @param userA - One of the users in the conversation
     * @param userB - Another user in the conversation
     * @throws Throwable - An error
     */
    @Then("^I check there is( not)? a message that contains (?:the|a) \"(.*?)\" \"(.*?)\"(?: \"(.*?)\")? between the users \"(.*?)\" and \"(.*?)\"$")
    public void checkMessages(String messageExists, String queryType, String messageStart, String messageEnd, String userA, String userB) throws Throwable {

        //TODO: Keep track of result set size. If no message should be there then the size of the rs should be the same on the next query
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        int userAId = -2;
        int userBId = -2;
        String whereClause = null;
        DBExecutor dbObj = Page.prepareQuery("CheckMessages");
        List<HashMap> rs;
        boolean result = true;

        // If looking for a group message in the database one user is the system with an id of -1. getUserId() does not
        // work for system because they are not a user listed on the table
        if(userA.equals("system")) {

            userAId = -1;
        }
        else{

            userAId = getUserId(userA);
        }

        userBId = getUserId(userB);

        if(queryType.equals("text")){

            whereClause = String.format("MESSAGE LIKE '%s' AND ((TO_USER = %d AND FROM_USER = %d) OR "  +
                    "(TO_USER = %d AND FROM_USER = %d))", messageStart, userAId, userBId, userBId, userAId);
        }
        else if(queryType.equals("tag")){

            whereClause = String.format("UPPER(MESSAGE) LIKE UPPER('%s') AND ((TO_USER = %d AND FROM_USER = %d) OR "  +
                    "(TO_USER = %d AND FROM_USER = %d))", messageStart, userAId, userBId, userBId, userAId);
        }
        else if(queryType.equals("NEWLINE")){

            whereClause = String.format("MESSAGE = '%s' || chr(13) || chr(10) || '%s' AND ((TO_USER = %d AND FROM_USER = %d) OR " +
                    "(TO_USER = %d AND FROM_USER = %d))", messageStart, messageEnd, userAId, userBId, userBId, userAId);
        }
        else if(queryType.equals("TAB")){

            whereClause = String.format("MESSAGE = '%s' || chr(9) || '%s' AND ((TO_USER = %d AND FROM_USER = %d) OR " +
                    "(TO_USER = %d AND FROM_USER = %d))", messageStart, messageEnd, userAId, userBId, userBId, userAId);
        }

        Assert.assertNotNull("The query was not built properly\n", whereClause);

        dbObj.addWhere(whereClause);
        rs = dbObj.executeQuery();

        /*
            If messageExists != null this means that the message should NOT exists therefore if the result set of the
            query is greater than 0 the message does exists meaning then case failed.
            If messageExists == null this means the message SHOULD exists therefore if the result set is 0 then the message
            does not exists and the case fails.
         */
        if((messageExists != null && rs.size() > 0) || (messageExists == null && rs.size() == 0)){

            result = false;
        }

        Assert.assertTrue(String.format("There %sare messages in the database with the format: %s%s\n",
                (messageExists == null ? "not " : ""), messageStart, (messageEnd == null ? "" : messageEnd)), result);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    /**
     * Deletes any messages between userA and userB. If deleting group messages leave off the last half.
     *
     * @param userA - One user in the conversation
     * @param userB - The other user in the conversation
     * @throws Throwable
     */
    @Given("^I delete (all|group)? messages(?: between the users \"(.*?)\" and \"(.*?)\")?$")
    public void deleteUserMessages(String deleteAll, String userA, String userB) throws Throwable {

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        int userAId, userBId, rowsDeleted;
        List<HashMap> rs;

        ArrayList<String> updates = new ArrayList<>();
        DBExecutor dbExecutorObj = new DBExecutor();

        // Deletes all external messages
        updates.add("DELETE FROM PK_EXTERNAL_MSG");

        if(deleteAll.equals("all")){

            updates.add("DELETE FROM pk_chatgroupmessage");
            updates.add("DELETE FROM PK_CHATMESSAGE");
            updates.add("DELETE FROM pk_chatgroupuser");
            updates.add("DELETE FROM pk_chatgroup");
        }

        // Deletes messages between two users
        else {
            userAId = getUserId(userA);
            userBId = getUserId(userB);

            updates.add(String.format("delete from PK_CHATMESSAGE where FROM_USER = %d AND TO_USER = %d",
                    userAId, userBId));
            updates.add(String.format("delete from PK_CHATMESSAGE where FROM_USER = %d AND TO_USER = %d",
                    userBId, userAId));
        }

        for(String update: updates){

            dbExecutorObj.executeQuery(update);
        }

        dbExecutorObj = null;

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    /**
     * Gets the id of the supplied username
     *
     * @param username
     * @return The id of the specified username
     * @throws Throwable
     */
    public int getUserId(String username) throws Throwable{

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        DBExecutor dbObj = Page.prepareQuery("GetUserId");

        dbObj.addWhere(String.format("USER_NM LIKE '%s'", username));
        List<HashMap> rs = dbObj.executeQuery();

        Assert.assertTrue(String.format("The user: %s was not found\n", username), rs.size() > 0);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");

        return Integer.parseInt(rs.get(0).get("USER_ID").toString());
    }

    /**
     * Assumes the very first message is the timestamp that you want. First the timestamp in the conversation is found.
     * Then it is used to create a LocalDateTime object. The systemDate object's time will always have slightly later time
     * since it is created after the timestamp is shown. Therefore 5 minutes is subtracted before the times are compared.
     *
     * If currentDate - 5 minutes is before the time in chat the numbers are very close
     * If currentDate - 5 minutes is after the time in the chat then the numbers should be checked
     *
     * @throws Throwable
     */
    @And("^I confirm the message timestamp(?:\"(.*?)\")?$")
    public void confirmTimestamp(String timestampString) throws Throwable {

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        WebElement chatTimestampElement;
        LocalDateTime timestampObj;
        StringBuilder timestamp;
        int split1, split2, split3;
        int month, day, hour, minute;

        LocalDateTime systemDate = LocalDateTime.now();

        // If a timestampString is null that assume the the first timestamp is the target
        if (timestampString == null) {

            String timestampXpath = "//ul[@class='messages flex-fill']/li[1];xpath";
            SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.ONE, timestampXpath);
            chatTimestampElement = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues(timestampXpath));

            timestamp = new StringBuilder(chatTimestampElement.getAttribute("innerHTML"));
            Assert.assertNotNull("The timestamp element was not found\n", timestamp);

            split1 = timestamp.indexOf(" ");
            split2 = timestamp.indexOf(",");
            split3 = timestamp.indexOf(":");

            // The year used is just the year from the system since it is not included in the timestamp
            month = monthStringToNum(timestamp.substring(0, split1));
            day = Integer.parseInt(timestamp.substring((split1 + 1), split2));
            hour = Integer.parseInt(timestamp.substring(split2 + 2, split3));
            minute = Integer.parseInt(timestamp.substring(split3 + 1, timestamp.length()));

            timestampObj = LocalDateTime.of(systemDate.getYear(), month, day, hour, minute);
        }
        else{

            timestamp = new StringBuilder(timestampString);
            LocalDateTime test = LocalDateTime.now();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("LL/dd/yy kk:mm");
            timestampObj = LocalDateTime.parse(timestampString, formatter);
        }

        Assert.assertTrue(String.format("The timestamp from the chat: %s is more than 5 minutes off the system time\n", timestamp),
                systemDate.minusMinutes(5).isBefore(timestampObj));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    /**
     * This method converts the month in string form to an integer.
     *
     * @param month - As a string
     * @return month - As an integer
     * @throws Throwable
     */
    public int monthStringToNum(String month) throws Throwable{

        HashMap<String, Integer> months = new HashMap<>();

        months.put("Jan", 1);
        months.put("Feb", 2);
        months.put("Mar", 3);
        months.put("Apr", 4);
        months.put("May", 5);
        months.put("Jun", 6);
        months.put("Jul", 7);
        months.put("Aug", 8);
        months.put("Sep", 9);
        months.put("Oct", 10);
        months.put("Nov", 11);
        months.put("Dec", 12);

        return months.get(month);
    }

    /**
     * This methods takes a patients first and last name. It then searches for the patient context link element. This does
     * not handle the cases where there are multiple patient context links for the same patient. It will look for and click
     * the first one.
     *
     * If actionType = 'Confirm'
     * Then move to the next step if the patient link appears
     *
     * If actionType = 'Click'
     * Then click the patient link if it appears
     *
     * @param actionType - Confirm the patient context link appears in the chat or click on the link
     * @param firstName - Patients first name
     * @param lastName - Patients last name
     */
    @Then("^I (confirm|click) the patient link for the patient \"(.*?)\" \"(.*?)\"(?: appears)? in my current( group)? conversation$")
    public void confirmPatientLink(String actionType, String firstName, String lastName, String isGroupConversation){

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        WebElement patientContextLinkElement = null;
        String patientLinkXpath;

        if(isGroupConversation == null){

            patientLinkXpath = String.format("//ul[@class='messages flex-fill']/li[contains(@class, 'message-item message-patient message-contextItem') and @data-patientid]/div/a/span[@class='message-patient-fullname' and text()='%s  %s ']/ancestor::li;xpath", firstName, lastName);
        }

        else{

            patientLinkXpath = String.format("//ul[@class='messages flex-fill']/li[contains(@class, 'message-item message-patient message-contextItem') and @data-patientid]/div/a/span[text()='%s  %s ']/ancestor::li;xpath");
        }

        patientContextLinkElement = waitToFindXpath(patientLinkXpath, GlobalConstants.FIVE);

        Assert.assertTrue(String.format("A patient link for %s  %s did not appear in the chat window", firstName, lastName),
                patientContextLinkElement != null);

        if(actionType.equals("click")){

            patientContextLinkElement.click();
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    /**
     * This method uses the Robot class to simulate keyboard entry. This will work on any window that is currently
     * focused on even those outside of the browser ie the File Explorer window. Make sure you are focused on the correct
     * text field because it will type the text then hit enter in the where ever your machine is focused. If you are not
     * properly focused you may get unexpected behavior. Currently only opens an image from the images folder.
     *
     * Wrap \n and \t in % signs (%\n% and %\t%)
     *
     * 1. The file path is built using buildFilePath
     * 2. Then each character in the path is looped through
     * 3. getCharCode is called to convert the character to the proper char code (ascii value)
     * 4. The overloaded method pressKey is called to enter the given key
     *
     * @param pathTo - Used to select any functions needed like building a path
     * @param text - A string of text to be typed can also be a file name
     * @throws Throwable
     */
    @Then("^I type the(?: string| path to \"(.*?)\") \"(.*?)\" where the caret is currently focused$")
    public void enterString(String pathTo, String text) throws Throwable{

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        char currentChar;
        boolean pressEnter = false;
        robot = new Robot();

        if(pathTo != null){

            text = buildPathTo(pathTo, text);
            pressEnter = true;
        }

        for (int charPos = 0; charPos < text.length(); charPos++) {

            currentChar = text.charAt(charPos);

            if (currentChar == '%') {

                if (text.charAt(charPos + 1) == '\\' && text.charAt(charPos + 2) == 'n' && text.charAt(charPos + 3) == '%') {

                    currentChar = '\n';
                    charPos += 3;

                } else if (text.charAt(charPos + 1) == '\\' && text.charAt(charPos + 2) == 't' && text.charAt(charPos + 3) == '%') {

                    currentChar = '\t';
                    charPos += 3;
                }
            }

            // Gets the correct character code then calls pressKey for the required keys
            getCharCode(currentChar);
        }

        if(pressEnter){

            getCharCode('\n');
        }

        robot = null;

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    /**
     * A helper method to build the file path to the image.
     *
     * @param pathTo - Used to indicate the path to build
     * @param fileName - The name of the desired image
     * @return
     */
    public static String buildPathTo(String pathTo, String fileName) throws Throwable{

        String path = null;

        if (pathTo.equals("Images")){
            path = String.format("%s\\src\\test\\java\\testData\\Images\\%s", System.getProperty("user.dir"), fileName);
        }

        Assert.assertNotNull(String.format("Failed to build the path to the folder %s and file %s\n", pathTo, fileName), path);

        return path;
    }

    /**
     * A helper method to convert the given character to the correct value/values.
     *
     * Note: There is an edge case when trying to press the ` key. For some reason when you pass the value of the ` key
     * to the Robot.keyPress method the value of the ` character is divided by two. This also applies to ~ since inorder
     * to press this key you must hold shift and press `.
     *
     * @param character - The character to be converted
     * @throws Throwable
     */
    public void getCharCode(char character) throws Throwable{

        // The character code for letters must be the uppercase ASCII value. character - 32 convers from lower to uppercase
        if(character >= 'a' && character <= 'z'){

            pressKey(character - 32);
        }

        // Even though the character code must be the uppercase value when typed the character is lowercase. Therefore
        // if you want to enter an uppercase character you must press the shift key first.
        else if(character >= 'A' && character <= 'Z'){

            pressKey(VK_SHIFT, character);
        }

        else if(character >= '0' && character <= '9'){

            pressKey(character);
        }

        else{

            // Same thing here if you need to hold shift to enter a key you must press shift before entering the key.
            switch (character) {
                case ':':
                    pressKey(VK_SHIFT, ';'); break;
                case ';':
                    pressKey(character); break;
                case '.':
                    pressKey(character); break;
                case '\\':
                    pressKey(character); break;
                case '/':
                    pressKey(character); break;
                case '@':
                    pressKey(VK_SHIFT, '2'); break;
                case '$':
                    pressKey(VK_SHIFT, '4'); break;
                case '%':
                    pressKey(VK_SHIFT, '5'); break;
                case '|':
                    pressKey(VK_SHIFT, '\\'); break;
                case '!':
                    pressKey(VK_SHIFT, '1'); break;
                case '#':
                    pressKey(VK_SHIFT, '3'); break;
                case '^':
                    pressKey(VK_SHIFT, '6'); break;
                case '&':
                    pressKey(VK_SHIFT, '7'); break;
                case '*':
                    pressKey(VK_SHIFT, '8'); break;
                case '(':
                    pressKey(VK_SHIFT, '9'); break;
                case ')':
                    pressKey(VK_SHIFT, '0'); break;
                case '-':
                    pressKey(character); break;
                case '_':
                    pressKey(VK_SHIFT, '-'); break;
                case '+':
                    pressKey(VK_SHIFT, '='); break;
                case '=':
                    pressKey(character); break;
                case '[':
                    pressKey(character); break;
                case ']':
                    pressKey(character); break;
                case '{':
                    pressKey(VK_SHIFT, '['); break;
                case '}':
                    pressKey(VK_SHIFT, ']'); break;
                // VK_QUOTE == '
                case '\'':
                    pressKey(VK_QUOTE); break;
                case '"':
                    pressKey(VK_SHIFT, VK_QUOTE); break;
                case ',':
                    pressKey(character); break;
                case '<':
                    pressKey(VK_SHIFT, ','); break;
                case '>':
                    pressKey(VK_SHIFT, '.'); break;
                case '?':
                    pressKey(VK_SHIFT, '/'); break;
                // The value of this char is multiplied by 2 to get the correct character. Otherwise it will enter 0 (zero).
                case '`':
                    pressKey('`' * 2); break;
                case '~':
                    pressKey(VK_SHIFT, '`'*2); break;
                case '\n':
                    pressKey(VK_SHIFT, VK_ENTER); break;
                //Space key
                case ' ':
                    pressKey(' '); break;
                case '\t':
                    pressKey(VK_TAB); break;
                default:
                    Assert.assertTrue(String.format("The character %s was not found. Check the getCharCode method.", character), false);
            }
        }
    }

    /**
     * This method takes in one or two keys as an input. If there is only one key then the first key should be any character
     * on the keyboard. If there are two keys the first key should always be shift or enter the second should be the other
     * character in the combination
     *
     * @param key - The key or keys to be pressed
     * @throws Throwable
     */
    public void pressKey(int... key) throws Throwable{

        if(key.length == 1){

            robot.keyPress(key[0]);
            Thread.sleep(10);
            robot.keyRelease(key[0]);
            Thread.sleep(10);
        }

        else if(key.length == 2){

            robot.keyPress(key[0]);
            Thread.sleep(10);
            robot.keyPress(key[1]);
            Thread.sleep(10);
            robot.keyRelease(key[1]);
            Thread.sleep(10);
            robot.keyRelease(key[0]);
            Thread.sleep(10);
        }

        else{

            Assert.assertTrue("You can only enter 1 or 2 keys\n", false);
        }
    }

    /**
     * This method checks the order of recent conversations against the given list.
     *
     * 1. Finds the element of the recent chat conversation
     * 2. Gets the user id attached to the element and the user id of the first user in the list
     * 3. Compares the ids
     *
     * @param conversationsOrder - The order the conversations should appear in
     * @throws Throwable
     */
    @Then("^The current conversations for the user should appear in the following order$")
    public void checkConversationsOrder(DataTable conversationsOrder) throws Throwable{

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        WebElement chatConversation;
        // actualUserId is the id that is on the chat conversation
        String xpath, expectedUserId, actualUserId;
        boolean result = true;
        List<String> correctOrder = conversationsOrder.asList(String.class);

        for(int i = 0; i < correctOrder.size(); i++){

            xpath = String.format("//div[@id='recent-conversation-list']/div[@class='wrapper-list-content']/ul[@class='chatlist']/li[%d]/h4/span[text()='%s'];xpath", i + 1, correctOrder.get(i));
            SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.FIVE, xpath);
            chatConversation = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues(xpath));

            if(chatConversation == null){

                result = false;
                break;
            }
        }

        Assert.assertTrue("The conversations do not appear in the correct order.\n", result);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    /**
     * The below method changes the timestamp on a chat message in the PK_CHATMESSAGE table.
     *
     * 1. Build the query based on operation, offset and searchKey
     * 2. Check to make sure the query was successfully built
     * 3. Execute query
     *
     * @param operation - Add or subtract time
     * @param offset - The amount of time to offset
     * @param searchFor - Any search value ex. id, message etc.
     * @throws Throwable
     */
    @Then("^I (add|subtract)? \"(.*?)\" days from the timestamp with the text \"(.*?)\"$")
    public void changeMessageDate(String operation, String offset, String searchFor) throws Throwable{

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        DBExecutor dbObj = Page.prepareQuery("UpdateMessage");

        dbObj.addSet(String.format("CRTE_DTTM = CRTE_DTTM %s interval '%s' day", (operation.equals("add") ? "+" : "-"), offset));
        dbObj.addWhere(String.format("MESSAGE LIKE '%s'", searchFor));

        Assert.assertNotNull("The query was not built correctly. Check testMessagePurging\n", dbObj);

        dbObj.executeQuery();

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    /**
     * This method is like an explicitWait for database queries. It repeatedly tries to execute the query until the expected
     * results are achieved or the max number of attempts have been tried.
     *
     * 1. Build the query based on queryName and searchFor (Note this should match the name in the JSON file ignoring spaces)
     * 2. Execute the query
     * 3. Compare the size of the result set to expectedSize -> If the results are expected or attemptCount is less than 0
     *      end
     * 4. If the results are not as expected wait, subtract 1 from attempt count and continue
     *
     * @param queryName - The name of the query to use
     * @param attemptCount - How many times to attempt to execute the query
     * @param waitTime - How many seconds to wait in between executions
     * @param operator - How the size of the result set should compare to the numOfResults to be successful
     * @param expectedSize - The number of expected results
     * @param searchFor - The identifier to select specific rows
     * @throws Throwable
     */
    @Then("^I execute the query \"(.*?)\" \"(.*?)\" times with \"(.*?)\" seconds? in between each call for a result set that has (>|<|=)? \"(.*?)\" results? using the search key \"(.*?)\"$")
    public void waitForQueryComplete(String queryName, int attemptCount, int waitTime, char operator, int expectedSize, String searchFor) throws Throwable{

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String whereClause = null;
        boolean result = false;
        List<HashMap> rs;
        DBExecutor dbObj;

        queryName = queryName.replace(" ", "");
        dbObj = Page.prepareQuery(queryName);

        if(queryName.equals("CheckMessages")){

            dbObj.addWhere(String.format("MESSAGE LIKE '%s'", searchFor));
        }
        else if(queryName.equals("CheckResultNotificationStatus")){

            dbObj.addWhere(String.format("STATUS LIKE '%s'", searchFor));
            dbObj.addWhere("to_char(CRTE_DTTM,'YYYY-MM-DD') = to_char(sysdate,'YYYY-MM-DD')");
        }

        while(!result){

            rs = dbObj.executeQuery();

            if(attemptCount < 0){

                break;
            }

            if(operator == '>'){

                if(rs.size() > expectedSize){

                    result = true;
                    break;
                }
            }

            else if(operator == '<'){

                if(rs.size() < expectedSize){

                    result = true;
                    break;
                }
            }

            else{

                if(rs.size() == expectedSize){

                    result = true;
                    break;
                }
            }

            attemptCount--;
            Thread.sleep(waitTime * 1000);
        }

        Assert.assertTrue(String.format("The query \"%s\" was not successful after trying for %d seconds\n", dbObj.query, waitTime), result);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    /**
     *
     * This method is used to hover over an element on the page
     *
     * @param elementName - The name of the element in the JSON file (or the xpath string)
     * @param inputType - Specifies if the input string is a element name or xpath
     * @param JSONType - The JSON element type (ie MISC_ELEMENTS, BUTTONS, FIELDS, etc...)
     * @param tabName - The name of the tab the element is located
     * @param paneName - The name of the pane the element is on
     */
    @And("^I hover over( and click)? the \"(.*?)\" (element|xpath)? of type \"(.*?)\" on the \"(.*?)\" tab(?: on the \"(.*?)\" pane)?$")
    public void hoverOverElement(String shouldClick, String elementName, String inputType, String JSONType, String tabName, String paneName){

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        WebElement targetElement;
        String xpath;
        String method;
        String[] elementType;
        Actions action = new Actions(Hooks.getDriver());

        // Another method passes the xpath when it calls hover-over element
        if(inputType.equals("element")) {

            JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
            HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
            String paneFrames = "";
            elementName = elementName.replace(" ", "");
            elementType = UtilFunctions.getElementStringAndType(fileObj, String.format("%s.%s", JSONType, elementName));
            xpath = elementType[0];
            method = elementType[1];

            if (paneName == null)
                paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, String.format("%s.%s", JSONType, elementName), "frame"));
            else
                paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName.replace(" ", ""), "frame"));

            SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");
            xpath += String.format(";%s", method);
        }
        else{

            xpath = elementName;
        }

        SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.TWO, xpath);
        targetElement = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues(xpath));

        Assert.assertNotNull(String.format("The element: %s was not found\n", elementName), targetElement);

        action.moveToElement(targetElement).perform();

        if(shouldClick != null){

            action.click().perform();
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    /**
     * Used to select or look for users from the create group search bar and
     * on the group members list.
     *
     * @param actionType - What to do with the found element
     * @param onlineStatus - The user can be online, offline or none (none is used for members list)
     * @param listType - What list or card the user will appear on
     * @param targetUser - The displayed name of the user you are looking for (format:"FirstName LastName")
     */
    @Then("^I (look for|select)? the( online| offline)? user using the info \"(.*?)\" and \"(.*?)\"(?: who specializes in \"(.*?)\")?$")
    public void findUser(String actionType, String onlineStatus, String listType, String targetUser, String specialtiesString)throws Throwable{

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        WebElement targetElement;
        String xpath = null;

        // This is used if searching for a user when creating a group
        if(listType.equals("Group User") && onlineStatus != null){

            xpath = String.format("//span[text()='%s' and preceding::i[@class='chat-text-color-offline icon-circle1%s'] and ancestor::ul[@class='chat-list new-member-list']]",
                    targetUser, (onlineStatus.equals(" offline") ? "" : "status-online"));
        }
        // Use this when looking at the members list on the Group Details card
        else if(listType.equals("Members List") || listType.equals("Remove From Group")){

            xpath = String.format("//ul[@id='group-member-list']/descendant::span[contains(text(), '%s')]", targetUser);
        }
        else if(listType.equals("User Search Bar Results")){

            xpath = "//ul[@class='chatlist allUsers']/li/div[@data-userid and @class='" + (onlineStatus.equals(" online") ? "statusIndicator online" : "statusIndicator ") + "']/following-sibling::h4/span[text()='" + targetUser + "']";
        }
        else if(listType.equals("Recent Conversations")){

            xpath = String.format("//ul[@class='chatlist']/li/div[@class='statusIndicator %s']/following-sibling::h4/span[text()='%s']/following-sibling::span[text()='(%s)']",
                    (onlineStatus.equals(" offline") ? "" : "status-online"), targetUser, specialtiesString);
        }
        // Use to check that a conversation with an on call user appears correctly. There needs to be at least 1 specialty
        // or the xpath will be invalid because one of the spans will not appear in the HTML
        else if(listType.equals("Recent Conversations-On Call") && specialtiesString != null){

            xpath = String.format("//ul[@class='chatlist']/li/div[@class='right-info-box']/i[@class='fa fa-info-circle provider-details']/parent::div/following-sibling::div[@class='statusIndicator ']/following-sibling::h4/span[text()='%s']/following-sibling::span[text()='(%s)']/parent::h4/following-sibling::span[text()='ON CALL NOW']",
                    targetUser, specialtiesString);
        }
        else if(listType.equals("User Search-On Call") && specialtiesString != null){

            xpath = String.format("//ul[@class='chatlist allUsers']/li/div[@class='right-info-box']/i[@class='fa fa-info-circle provider-details']/parent::div/following-sibling::div[contains(@class,'statusIndicator')]/following-sibling::h4/span[text()='Daniel Dobbs']/following::div[text()='Neurological Surgery']/following::span[text()='ON CALL NOW']",
                    targetUser, specialtiesString);
        }

        Assert.assertNotNull(String.format("The %s %s user %s option not found", onlineStatus, listType, targetUser), xpath);

        // If removing a user from a group you must first hover over their name so the trashcan icon will appear
        if(listType.equals("Remove From Group")){

            // First hover over the member in the members list
            hoverOverElement(null, xpath, "xpath", "", "", null);
            Thread.sleep(1000);
            // Change xpath to the trashcan icon so it gets clicked
            xpath = String.format("//ul[@id='group-member-list']/li/div[@class='list-content-wrapper']/h4/span[text()='%s']/parent::h4/parent::div/preceding-sibling::*/i[contains(@class, 'fa-trash')]",
                    targetUser);
        }

        targetElement = waitToFindXpath(xpath + ";xpath", GlobalConstants.FIVE);
        Assert.assertNotNull(String.format("The user %s was not found\n", targetUser), targetElement);

        Assert.assertTrue("The element is not visible\n", targetElement.isDisplayed());

        if(actionType.equals("select")){
            try{
                targetElement.click();
            }catch (Exception e){
                Assert.assertFalse("User is not selected due to exception: "+e.getMessage(),true);
            }

        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    /**
     * A method to look for different messages in the chat area.
     *
     * @param messageType - The format of the message you are looking for
     * @param isVisible - Weather or not the user should be able to see that message
     * @param senderName - The name of the sender
     * @param messageText - What that message says
     * @throws Throwable - An error
     */
    @Then("^I look for a \"(.*?)\" message( that should not appear)?(?: from the user \"(.*?)\")? that says \"(.*?)\"$")
    public void findMessageOnPortal(String messageType, String isVisible, String senderName, String messageText) throws Throwable{

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String xpath = "//ul[@class='messages flex-fill']";
        WebElement messageElement = null;

        // Add on rest of xpath
        if(messageType.equals("Individual")){

            char correctQuote = messageText.contains("\'") ? '"' : '\'';
            xpath += String.format("/li/div/div[text()=%s%s%s and @class='message-text']", correctQuote, messageText, correctQuote);
        }
        else if(messageType.equals("Group")){

            // This xpath checks the name of the sender as well as the message (Note: this makes sure the name corresponds
            // to the message but not that the name appears above the message text)
            xpath += String.format("/li/div[@class='from-user' and text()='%s']/following-sibling::div/div[@class='message-text' and text()='%s']",
                    senderName, messageText);
        }
        else if(messageType.equals("System")){

            // This is used to look for system messages since they are identical expect for the text. This method finds
            // the element and gets the text then calls a method below to verify the message is correct
            xpath += "/li[last()]/span";
        }

        // If the xpath did not change then the message type was not found
        Assert.assertFalse(String.format("The %s message type was not found\n", messageType), xpath.equals("//ul[@class='messages flex-fill']"));

        messageElement = waitToFindXpath(xpath + ";xpath", GlobalConstants.FIVE);

        // The validation of the text from the element happens in validateSystemMessage because of the timestamp for one
        // of the messages
        if(messageType.equals("System")){

            validateSystemMessage(messageElement, messageText);
            return;
        }

        if(isVisible == null){

            Assert.assertNotNull(String.format("The %s message%s containing the text %s was not found\n", messageType,
                    (senderName == null ? "" : String.format(" %s", senderName)), messageText), messageElement);
        }
        else{

            Assert.assertNull(String.format("The %s message%s containing the text %s was not found\n", messageType,
                    (senderName == null ? "" : String.format(" %s", senderName)), messageText), messageElement);
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    /**
     * Validates the messages sent to the group chat by the system. This is separate because as of now one of the system
     * messages has a timestamp that needs to be validated therefore
     *
     * Checking the timestamp is made obsolete by DEV-75416
     * ... This now just looks at everything after the timestamp from the message if a user is removed because messaging
     *  is disabled for them
     *
     * @param messageElement - The element of the message
     * @param expectedText - The message the system is expected to send
     * @throws Throwable - An error is thrown if the actual and expected string do not match
     */
    public void validateSystemMessage(WebElement messageElement, String expectedText) throws Throwable{

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String dateAndTime;
        String elementText;

        elementText = messageElement.getText();

        Assert.assertFalse("The text from the element was not correctly found\n", elementText.isEmpty());

        dateAndTime = elementText.substring(0, elementText.lastIndexOf(":"));
        Assert.assertNotNull(String.format("The timestamp '%s' was not properly parsed\n", dateAndTime), dateAndTime);

        // The split on the second : to separate timestamp from message
        // This will fail when this issue: DEV-75416 is closed
        //confirmTimestamp(dateAndTime);
        elementText = elementText.substring(elementText.lastIndexOf(":"), elementText.length());

        Assert.assertTrue(String.format("The system message: %s was not correct\n", elementText),
                elementText.equals(expectedText));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    /**
     * This method checks for the visibility of an element by trying to click on it. If another element is blocking the
     * element an error will be thrown saying the element cannot be clicked at that location. If an error is thrown the
     * method will return false otherwise it will return true.
     *
     * @param elementName - Name of the element in the JSON file
     * @param JSONType - The type of element (ie. MISC_ELEMENTS, BUTTONS, TEXT_FIELDS etc...)
     * @param tabName - The tab the element is located on
     * @param paneName - The name of the pane the element is on (optional)
     * @param isVisible - If the element should appear on the screen or not
     */
    @Then("^try to click the \"(.*?)\" \"(.*?)\" element on the \"(.*?)\" tab(?: on the \"(.*?)\" pane)? to see if it (is|is not)? visible$")
    public void clickForVisibility(String elementName, String JSONType, String tabName, String paneName, String isVisible){

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        boolean result = true;
        WebElement targetElement;

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        String paneFrames = "";
        elementName = elementName.replace(" ", "");
        String[] elementType = UtilFunctions.getElementStringAndType(fileObj, String.format("%s.%s", JSONType, elementName));
        String xpath = elementType[0];
        String method = elementType[1];

        if (paneName == null)
            paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, String.format("%s.%s", JSONType, elementName), "frame"));
        else
            paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName.replace(" ", ""), "frame"));

        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");

        xpath += String.format(";%s", method);
        SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.FIVE, "", SeleniumFunctions.setByValues(xpath));
        targetElement = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues(xpath));
        Assert.assertNotNull(String.format("An element matching the xpath: %s was not found\n", xpath + method), targetElement);

        // If element is not clickable an error will be thrown and the method will return false
        try{

            targetElement.click();

        } catch(WebDriverException elementNotVisible){

            // If an exception is thrown the there was another element blocking the target from being click ie the element
            // is not visible
            result = false;
        }

        Assert.assertTrue(String.format("The %s element was%s visible", elementName, (isVisible.equals("is") ? " not" : "")),
                (isVisible.equals("is") ? result : !result));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    /**
     * This method scrolls up or down until the given element is found.
     *
     * @param scrollDirection - the direction of the scroll up or down
     * @param parentName - name of the parent element in the JSON file Note: this xpath should just point to the parent element the method adds "/*" to get all children
     * @param parentType - the type of JSON element for the parent element
     * @param childName - the name of the target child element
     * @param childType - type of JSON element in the JSON file
     * @param tabName - name of tab the element is located on
     * @param paneName - name of pane the element is located on
     * @throws Throwable
     */
    @Then("^I scroll (up|down)? on the \"(.*?)\" \"(.*?)\" element until the \"(.*?)\"(?: \"(.*?)\" element)? appears? on the \"(.*?)\" tab(?: on the \"(.*?)\" pane)?$")
    public void scrollUntilElementVisible(String scrollDirection, String parentName, String parentType, String childName, String childType, String tabName, String paneName) throws Throwable{

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String parentXpath;
        String parentMethod;
        String[] elementInfo;
        List<WebElement> webElements;
        String paneFrames = "";
        boolean result = false;
        String childXpath = null;
        String childMethod = null;

        JavascriptExecutor jsEx = (JavascriptExecutor) Hooks.getDriver();
        WebDriverWait wait = new WebDriverWait(Hooks.getDriver(), 1);

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);

        // Format parent and child xpath
        parentName = parentName.replace(" ", "");
        // Get parent from JSON
        elementInfo = UtilFunctions.getElementStringAndType(fileObj, String.format("%s.%s", parentType, parentName));
        parentXpath = elementInfo[0];
        parentMethod = elementInfo[1];
        parentXpath += "/*";

        // This is to catch messaging specific cases, in this case childName is used as the message text
        if(parentName.equals("MessageArea") && childType == null) {

            // When testing the single quote (') character for messaging you cannot wrap the string in single quotes.
            // You must wrap the string in double quotes (") since you cannot escape the single quotes in xpath
            char correctQuotes = (childName.contains("'")) ? '"' : '\'';
            childXpath = parentXpath + String.format("/div[last()]/div[text()=%s%s%s]", correctQuotes, childName, correctQuotes);
            childMethod = ";xpath";
        }
        else{

            childName = childName.replace(" ", "");
            // Get child from JSON
            elementInfo = UtilFunctions.getElementStringAndType(fileObj, String.format("%s.%s", childType, childName));
            childXpath = elementInfo[0];
            childMethod = String.format(";%s", elementInfo[1]);
        }

        if (paneName == null)
            paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, String.format("%s.%s", parentType, parentName), "frame"));
        else
            paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName.replace(" ", ""), "frame"));

        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");
        webElements = waitToFindXpaths(parentXpath + ";" + parentMethod, GlobalConstants.ONE);

        Assert.assertTrue("Elements using the xpath: " + parentName + parentType + " was not found", webElements.size() > 0);

        while(true){

            // If the target xpath appears
            if(waitToFindXpath(childXpath + childMethod, GlobalConstants.TWO) != null){

                result = true;
                break;
            }

            // Sometimes code runs to fast and the reference JS uses becomes stale. If this happens and an error is thrown
            // then wait and try again
            try {

                // Scroll either up or down the top or bottom element that appears on the in the HTML
                jsEx.executeScript("arguments[0].scrollIntoView(true)", (scrollDirection.equals("up") ? webElements.get(0) : webElements.get(webElements.size() - 1)));

            } catch(StaleElementReferenceException ex){

                webElements = waitToFindXpaths(parentXpath + ";" + parentMethod, GlobalConstants.ONE);
                jsEx.executeScript("arguments[0].scrollIntoView(true)", (scrollDirection.equals("up") ? webElements.get(0) : webElements.get(webElements.size() - 1)));
            }

            try{

                /*
                    Check to see if there is any more room to scroll. Compares the number of elements returned by looking
                    for the given element and comparing it to the number of elements found on the previous iteration

                    WebDriverWait.until() - swallows errors thrown by ExpectedConditions.numberOfElementsToBeMoreThan()
                 */
                wait.until(ExpectedConditions.numberOfElementsToBeMoreThan(SeleniumFunctions.setByValues(parentXpath + ";" + parentMethod), webElements.size()));

            } catch(TimeoutException timeout){

                break;
            }

            webElements = waitToFindXpaths(parentXpath + ";" + parentMethod, GlobalConstants.TWO);
        }

        if(childMethod != null && childName != null) {

            Assert.assertTrue(String.format("After scrolling on the %s element the %s was not found\n", parentName, childName), result);
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    /**
     * Wrapper method to find elements and return a list
     *
     * @param xpath - target xpath
     * @param timeout - time to wait for xpath to appear
     * @return
     */
    public List<WebElement> waitToFindXpaths(String xpath, int timeout){

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        List<WebElement> tempElements;

        SeleniumFunctions.explicitWait(Hooks.getDriver(), timeout, xpath);
        tempElements = SeleniumFunctions.findElements(Hooks.getDriver(), SeleniumFunctions.setByValues(xpath));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");

        return tempElements;
    }

    /**
     * Wrapper method to find an element and return it
     *
     * @param xpath - target xpath
     * @param timeout - time to wait for xpath to appear
     * @return
     */
    public WebElement waitToFindXpath(String xpath, int timeout){

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        WebElement tempElement = null;

        SeleniumFunctions.explicitWait(Hooks.getDriver(), timeout, xpath);
        tempElement = SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues(xpath));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");

        return tempElement;
    }

    /**
     * This method is used for working with users on the On-Call tab of the messaging window
     *
     * @param actionType - the action to perform
     * @param userStatus - is the user a local user in the system or not
     * @param scheduleType - the type of schedule the user has
     * @param targetUser - name of the target user
     * @param serviceOffered
     * @param userFacility
     */
    @Then("^(look for|view information of|start chat with)? the (pk messaging|non-pk messaging)? user \"(.*?)\" \"(.*?)\" who is offering \"(.*?)\" (?:at the \"(.*?)\" facility)?$")
    public void selectUserFromOnCall(String actionType, String userStatus, String scheduleType, String targetUser, String serviceOffered,  String userFacility) throws Throwable {

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String infoIconXpath;
        String userXpath = String.format("//h4[contains(@title,'%s - %s | %s | %s') and descendant::span[text()='%s - %s' and following-sibling::span[text()='%s']]]",
                scheduleType, userFacility, serviceOffered, userFacility, scheduleType, userFacility, targetUser);
        if (userStatus.equals("non-pk messaging"))
            infoIconXpath = userXpath + "/parent::div/preceding-sibling::div/i[@class='fa fa-exclamation-triangle out-provider-indicator']";
        else
            infoIconXpath = userXpath + "/parent::div/preceding-sibling::div/i[@class='fa fa-info-circle provider-details']";

        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        if (Page.findPane(Hooks.getDriver(), curTabName, "ChatRoom", GlobalConstants.ONE) != null) {
            if(!(waitToFindXpath("//div[contains(@class, 'tab active')and contains(@title, '" + targetUser + "')];xpath", GlobalConstants.ONE) != null && actionType.contains("chat"))) {
                // globalStepdefs.clickMiscElement("CloseConversation", null, null, null);
                // globalStepdefs.clickMiscElement("StartConversation", null, null, null);
                globalStepdefs.clickMiscElement("MessagingOnCallTab", null, null, null);
            }
        } else if(waitToFindXpath("//span[@class='status' and ancestor::div[@id='chat1' and contains(@class,'minimized')]]" + ";xpath", GlobalConstants.ONE) != null) {
            openMessageWindow();
            globalStepdefs.clickMiscElement("MessagingOnCallTab", null, null, null);
        } else if(waitToFindXpath("//div[@id='chat1' and not(contains(@class, 'chatAreaCovered'))]" + ";xpath", GlobalConstants.ONE) != null){
            globalStepdefs.clickMiscElement("StartConversation", null, null, null);
            globalStepdefs.clickMiscElement("MessagingOnCallTab", null, null, null);
        }else
            globalStepdefs.clickMiscElement("MessagingOnCallTab", null, null, null);

        switch (actionType) {
                case "view information of":
                    try {
                        waitToFindXpath(infoIconXpath + ";xpath", GlobalConstants.ONE).click();
                    } catch (Exception e) {
                        Assert.assertNotNull(String.format("The information pane for %s - %s at %s is not displayed due to exception: " + e.getMessage(), scheduleType, targetUser, userFacility), null);
                    }
                    break;
                case "start chat with":
                    if (waitToFindXpath("//div[contains(@class, 'tab active')and contains(@title, '"+targetUser+"')];xpath", GlobalConstants.ONE) == null) {
                        WebElement expectedPane;
                        try {
                            WebElement user= waitToFindXpath(userXpath + ";xpath", GlobalConstants.ONE);
                            JavascriptExecutor jsExecutor = (JavascriptExecutor) Hooks.getDriver();
                            jsExecutor.executeScript("arguments[0].scrollIntoView(true)", user);
                            Thread.sleep(1000);
                            user.click();
                            if(userStatus.equals("pk messaging"))
                                expectedPane= Page.findPane(Hooks.getDriver(), curTabName, "ChatRoom", 5);
                            else
                                expectedPane= Page.findPane(Hooks.getDriver(), curTabName, "PkModalBody", 5);
                            if(expectedPane == null) {
                                UtilFunctions.log("Chat not loaded, reclicking the user");
                                waitToFindXpath(userXpath + ";xpath", GlobalConstants.ONE).click();
                            }
                        } catch (Exception e) {
                            Assert.assertNotNull(String.format("Chat for %s - %s at %s is not started due to exception: " + e.getMessage(), scheduleType, targetUser, userFacility), null);
                        }
                    }
                    break;
                default:
                    Assert.assertNotNull(String.format("The user information matching %s - %s at %s was not found", scheduleType, targetUser, userFacility), waitToFindXpath(infoIconXpath + ";xpath", 3));
                    break;
            }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    /**
     * This method verifies the user's On-Call schedule in the information window. You must first open the window by
     * clicking the information icon next the users name on the On-Call tab. The schedule does not appear if selecting the
     * information icon on the "Recent Conversations" card.
     *
     * Example input data table:
     *       | Last Name  | Kadmin       |
     *       | First Name | Perry        |
     *       | Specialty  |              |
     *       | Facilities | GHDOHospital |
     *
     * @param isMsgUser - specify if the user is a messaging user or not
     * @param user - specify if the user
     * @param scheduleType - the type of schedule
     * @param physicianInfoTable - a table of the users information (format above)
     * @throws Throwable
     */
    @Then("^verify the following information on the provider details popup(?: for a( non)? messaging user \"(.*?)\" with schedule type \"(.*?)\")?$")
    public void confirmUserInfoOnPopup(String isMsgUser, String user, String scheduleType, DataTable physicianInfoTable) throws Throwable{
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        GlobalStepdefs globalStepdefs = new GlobalStepdefs();
        if (scheduleType != null){
            if (isMsgUser != null)
                globalStepdefs.textAppearInPane("This user is NOT a PatientKeeper Messaging user.",null,null,"ProviderDetailsContent");
            else
                globalStepdefs.textAppearInPane("This user is NOT a PatientKeeper Messaging user.","not",null,"ProviderDetailsContent");
            String scheduleXpath = String.format("//div[@class='provider-name' and descendant::span[contains(text(), '%s')] and following-sibling::div[@class='schedule-time'"+
                    " and following-sibling::div[@class='schedule-type' and descendant::span[contains(text(),'%s')]]]]",user, scheduleType);
            Assert.assertNotNull("On call schedule details are not displayed on the provider detials pane", waitToFindXpath(scheduleXpath+";xpath",GlobalConstants.TWO));
        }else
            Assert.assertNull("On call schedule details are displayed on the provider detials pane", waitToFindXpath("//div[@class='schedule-type']"+";xpath",GlobalConstants.TWO));

        WebElement table= Page.findTable(Hooks.getDriver(),"//table[parent::div[@class='physician-contact']]");
        WebElement tableBody= Page.findTableBody(table,"tbody");
        List<List<String>> physicianInfoList = physicianInfoTable.asLists(String.class);
        for (List physicianInfo : physicianInfoList) {
            String header= physicianInfo.get(0).toString();
            String value= physicianInfo.get(1).toString();
            String rowXpath="//tr[descendant::td[contains(text(),'"+header+"') and following-sibling::td[contains(text(),'"+value+"')]]]";
            WebElement tableRow = SeleniumFunctions.findElementByWebElement(tableBody, SeleniumFunctions.setByValues(rowXpath + ";xpath"));
            Assert.assertNotNull("Physician info "+header+" "+value+" is not visible", tableRow);
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    /**
     * This method checks the log table for the entry when clicking on a user to send a message on the On-Call screen.
     *
     * "Administrator On Call - PKOnCall", "Administrator", "PKOnCall", "chatuser1", "Perry Kadmin", "true" and "false"
     *
     * @param serviceName - the service the user is offer plus the facility they are at
     * @param scheduleName - the schedule type of the user
     * @param facilityName - the name of the facility where the user is located
     * @param username - the login username for the provider who is currently signed into the portal
     * @param providerName - the name of the provider that the user tried to start a chat conversation with(format:"firstName lastName")
     * @param isPkUser - is the provider a local pk user or not?
     * @param isMessagingEnabled - does the provider have messaging enabled?
     * @throws Throwable
     */
    @Then("^verify the on call chat request log using the info: \"(.*?)\", \"(.*?)\", \"(.*?)\", \"(.*?)\", \"(.*?)\", \"(.*?)\" and \"(.*?)\"$")
    public void verifyPKOnCallAuditLog(String serviceName, String scheduleName, String facilityName, String username, String providerName, String isPkUser, String isMessagingEnabled) throws Throwable{

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        // I apologize for the horrible variable names but this is formatting hell
        StringBuilder pkLog;
        StringBuilder logDateString;
        String checkString;
        LocalDateTime systemDate;
        LocalDateTime logDate;

        systemDate = LocalDateTime.now();

        DBExecutor dbObj = Page.prepareQuery("GetOnCallChatRequestLogs", true);
        List<HashMap> rs = dbObj.executeQuery();

        checkString = String.format("serviceName = %s,scheduleName = %s,facilityName = %s,userName = %s,providerName = %s,isPkUser = %s,isMessagingEnabled = %s",
                serviceName, scheduleName, facilityName, username, providerName, isPkUser, isMessagingEnabled);

        pkLog = new StringBuilder(rs.get(0).get("VALUE").toString());
        logDateString = new StringBuilder(pkLog.substring(pkLog.lastIndexOf("startDT"), pkLog.length() - 1));
        pkLog = new StringBuilder(pkLog.substring(pkLog.lastIndexOf("{") + 1, pkLog.lastIndexOf("startDT") - 1));

        Assert.assertTrue(String.format("The information in the log was not correct: %s", checkString), checkString.equals(pkLog.toString()));

        logDateString = new StringBuilder(logDateString.substring(logDateString.lastIndexOf("= ") + 2, logDateString.lastIndexOf("(") - 1));

        padDateWith0s(logDateString);

        // The string should be exactly 18 characters long ex 01/23/2018 01:24:52
        Assert.assertTrue("The date from the log was parsed incorrectly\n", logDateString.length() == 19);

        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("LL-dd-yyyy kk:mm:ss");
        logDate = LocalDateTime.parse(logDateString.toString(), dateFormatter);

        // Before comparing systemDate and log date 1 minute is subtracted to account for the time it takes for the code
        // in between clicking the UI and getting the current time to finish
        Assert.assertTrue("The timestamp for the log is more than a minute away from the system time.\n", systemDate.minusMinutes(1).isBefore(logDate));

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    /**
     * A helper method to pad the date string with 0s so it is the same format each time.
     *
     * @param dateTimeString - should be in the format date time:(mm/dd/yyyy 00:00:00)
     */
    public void padDateWith0s(StringBuilder dateTimeString){

        int start = 0;
        int end = 0;
        for(int i = 0; i < 2; i++){

            end = dateTimeString.indexOf("-", start);

            if(i == 2){

                end = dateTimeString.indexOf(" ");
            }

            if(end - start == 1){

                dateTimeString.insert(start, '0');
                end ++;
            }

            start = end + 1;
        }

        start = dateTimeString.indexOf(" ") + 1;
        for(int i = 0; i < 3; i++){

            end = dateTimeString.indexOf(":", start);

            if(i == 2){

                end = dateTimeString.length();
            }

            if(end - start == 1){

                dateTimeString.insert(start, '0');
                end++;
            }

            start = end + 1;

        }

    }

    /**
     * If "verify and toggle" is chosen then the checkbox is toggled and so is the expected status. If not then the method
     * just verifies the state of the checkbox using .isSelected(). The checkbox is toggled by sending the space key to it
     *
     * @param actionType - verify the checkbox state or toggle then verify the state
     * @param elementName - the name of the element in the JSON
     * @param currentStatus - this should be the current or starting status of the checkbox
     * @param paneName - the name of the pane the checkbox is on
     * @param tabName - the name of the tab the checkbox is on
     */
    @Then("^(verify|verify and toggle)? the \"(.*?)\" checkbox is (checked|unchecked)?(?: on the \"(.*?)\" pane )? on the \"(.*?)\" tab$")
    public void verifyCheckBox(String actionType, String elementName, String currentStatus, String paneName, String tabName) {

        boolean result = false;
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        String paneFrames = "";
        elementName = elementName.replace(" ", "");
        String[] elementType = UtilFunctions.getElementStringAndType(fileObj, String.format("CHECKBOXES.%s", elementName));
        String xpath = elementType[0];
        String method = elementType[1];

        if (paneName == null)
            paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, String.format("CHECKBOXES.%s", elementName), "frame"));
        else
            paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName.replace(" ", ""), "frame"));

        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");

        WebElement checkbox = waitToFindXpath(xpath + ";" + method, GlobalConstants.TWO);
        Assert.assertNotNull(String.format("The %s element was not found\n", elementName), checkbox);

        if(actionType.equals("verify and toggle")){

            checkbox.sendKeys(Keys.SPACE);
            // If the code toggles the checkbox then the expected status should be flipped as well
            currentStatus = currentStatus.equals("checked") ? "unchecked" : "checked";
        }

        if ((currentStatus.equals("checked") && checkbox.isSelected()) || (currentStatus.equals("unchecked") && !checkbox.isSelected())) {

            result = true;
        }

        Assert.assertTrue(String.format("The %s checkbox was not correctly toggled\n", elementName), result);
    }

    /**
     *  Selects the given option for a pk dropdown.
     *
     * @param dropdownName - the name of the pk dropdown element in the JSON file
     * @param paneName - the name of the pane
     * @param targetItem - the text displayed for the option you want to select
     * @param options
     */
    @Then("^the \"(.*?)\" pkdropdown(?: in the \"(.*?)\" pane)? should have exactly the following items(?: and I select the \"(.*?)\" option)?$")
    public void checkDropdownExactMatch(String dropdownName, String paneName, String targetItem, DataTable options){

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        boolean result = true;
        dropdownName = dropdownName.replace(" ", "");
        String paneFrames;
        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(curTabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(curTabName);
        HashMap<String, WebElement> itemsInDropdown = new HashMap<>();
        List<String> expectedOptions;

        String dropDown = UtilFunctions.getElementFromJSONFile(fileObj, "PKDROPDOWNS." + dropdownName, "path");
        String dropDownList = UtilFunctions.getElementFromJSONFile(fileObj, "PKDROPDOWNS." + dropdownName, "listPath");

        if (paneName == null)
            paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, String.format("PKDROPDOWNS.%s", dropdownName), "frame"));
        else
            paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName.replace(" ", ""), "frame"));

        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");
        SeleniumFunctions.explicitWait(Hooks.getDriver(), GlobalConstants.FIVE, dropDown + ";xpath");
        WebElement dropDownObj= SeleniumFunctions.findElement(Hooks.getDriver(), SeleniumFunctions.setByValues(dropDown + ";xpath"));
        Assert.assertNotNull("Dropdown is not found",dropDownObj);
        dropDownObj.click();
        dropDownList = dropDownList + "//span";
        expectedOptions = options.asList(String.class);

        for(WebElement test: waitToFindXpaths(dropDownList, GlobalConstants.ONE)){

            itemsInDropdown.put(test.getText(), test);
        }

        Assert.assertTrue("The number of options are different\n", expectedOptions.size() == itemsInDropdown.size());

        for(String expectedOption: expectedOptions){

            if(!itemsInDropdown.containsKey(expectedOption)){

                result = false;
                break;
            }
        }

        if(targetItem != null){

            itemsInDropdown.get(targetItem).click();
            dropDown += String.format("[@title='%s']", targetItem);

            Assert.assertNotNull(String.format("The %s option was not selected\n", targetItem),
                    waitToFindXpath(dropDown, GlobalConstants.ONE));
        }
        else{

            Assert.assertTrue(String.format("The options in the dropdown do not match the options given in the datatable"), result);
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    /**
     * This method checks the the values shown on the UI against those in the database for the given result messages. This
     * method looks at the active context link. The format of the message is checked for that block of result
     * messages. The format should be from top to bottom a timestamp>a patient context link>a block of result messages.
     * It does not actually verify the timestamp of when the message is sent.
     *
     * @param firstName - the first name of the patient you are looking for
     * @param lastName - the last name of the patient you are looking for
     * @param testsWithResults - a single column table with one lab name per row
     * @throws Throwable
     */
    @Then("^check the data in the result messages? against the database for the user \"(.*)\" \"(.*)\" for the following tests$")
    public void verifyResultMessages(String firstName, String lastName, DataTable testsWithResults) throws Throwable {

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        List<String> tests = testsWithResults.asList(String.class);
        String resultMessagePath;
        int numOfMessages;

        for(String test: tests){
            
            // This xpath looks at the active context link ie the last one
            resultMessagePath = "//ul[@class='messages flex-fill']/li[contains(@class,'message-item message-patient message-contextItem activeContext')]/following-sibling::*/div/div[contains(text(),'" + test + "')]";
            numOfMessages = waitToFindXpaths(resultMessagePath + ";xpath", GlobalConstants.TWO).size();

            // If more than 2 elements are returned then there are two orders with the same name in the same active patient context link
            if(numOfMessages > 1){

                verifyResultMessageData(resultMessagePath, numOfMessages, getResultMessageDataMapping(test));
            }
            else if(numOfMessages == 1){

                verifyResultMessageData(resultMessagePath, getResultMessageDataMapping(test));
            }
            else{

                Assert.assertTrue("The messages were not found\n", false);
            }
        }

        Assert.assertNotNull("The messages were not found\n");

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    /**
     * This method pulls the data from the database based on the result and order id from the order in the HTML. It finds
     * the order by searching for the result message on the UI by name. The reason why this method only looks at the active
     * patient context link is to prevent looking at orders from the user below.
     *
     * @param messageXpath
     * @param dataMapping
     * @throws Throwable
     */
    public void verifyResultMessageData(String messageXpath, String[] dataMapping) throws Throwable{

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        DBExecutor dbObj;
        List<HashMap> rs;
        String searchKey = null;
        String labName = null;
        HashMap<String, String> expectedValues = new HashMap<>();
        boolean result = true;
        int rowsUsed = 0;
        WebElement headerInfo = waitToFindXpath(messageXpath + ";xpath", GlobalConstants.TWO);
        List<WebElement> messageData = waitToFindXpaths(messageXpath + "/*[@class='extra-parts ' or @width]/descendant::*;xpath", GlobalConstants.FIVE);

        Assert.assertTrue("The data was not found for that result\n", messageData.size() > 0);

        // Get the data from the database using the result id and order id from the HTML
        dbObj = Page.prepareQuery("GetTestResultData", false);
        dbObj.addWhere(" sm.resultid = " + headerInfo.getAttribute("data-resultid") + " and sm.orderid = " + headerInfo.getAttribute("data-orderid"));
        dbObj.addJoin("pk_subscription_message sm on sm.resultid = lab.obs_id", "LEFT");
        dbObj.addJoin("m_code component on component.cd_cd = lab.comp_typ_cd", "LEFT");
        dbObj.addJoin("m_code normalcy on normalcy.cd_cd = lab.nrm_sts_cd", "LEFT");
        rs = dbObj.executeQuery();

        // If the first element after the info element is a tbody the data is not mapped to a fish bone
        if(dataMapping == null && messageData.get(0).getTagName().equals("span")){

            String tempString;
            int targetRow;
            String dbValue;

            for(int i = 0; i < messageData.size() && result; i ++){

                // The first value in the unmapped list is from the info element not the list of elements
                if(i == 0){

                    searchKey = headerInfo.getText();
                    searchKey = searchKey.substring(0, searchKey.indexOf("(") - 2);
                    labName = searchKey;
                }
                else{

                    searchKey = "";
                    tempString = messageData.get(i).getText();
                    for(int j = 0; j < tempString.length(); j++){

                        if(!Character.isDigit(tempString.charAt(j))){

                            searchKey += tempString.charAt(j);
                        }
                        else{

                            break;
                        }
                    }

                    searchKey = searchKey.substring(0, searchKey.length() - 1);
                }

                targetRow = -1;
                for(int j = 0; j < rs.size(); j++){

                    // Loop through all the rows in the result set looking for the name of the value
                    if(rs.get(j).get("LAB").equals(searchKey)){

                        targetRow = j;
                        rowsUsed++;
                        break;
                    }
                }

                // If target row does not change then a row matching that value type was not found
                if(targetRow == -1){

                    result =  false;
                }

                Assert.assertTrue("The value for the " + searchKey + " was not found", result);
                // Build a string using the same format as it appears on the UI and check that with the text from the element
                dbValue = searchKey + " " + rs.get(targetRow).get("VALUE_TXT") + " " + rs.get(targetRow).get("NORMALCY");
                result = dbValue.equals(messageData.get(i).getText());
            }

            Assert.assertTrue("The number of values in the database (" + rs.size() + ") does not match the number found in the UI (" + messageData.size() + ")", rowsUsed == messageData.size());
        }
        // If the first element after the info element is a tbody the data is mapped to a fish bone
        else if(dataMapping != null && messageData.get(0).getTagName().equals("tbody")){

            labName = headerInfo.getText();
            labName = labName.substring(0, labName.indexOf("(") - 2);

            // Build HashMap using the value type and a string in the format:"valueType value normalcy"
            for(String valueName: dataMapping){

                for(int i = 0; i < rs.size(); i++){

                    if(rs.get(i).get("LAB").equals(valueName)){

                        expectedValues.put(valueName, rs.get(i).get("VALUE_TXT").toString() + " " + rs.get(i).get("NORMALCY").toString());
                        break;
                    }
                }
            }

            // Since the fish bone is setup the same each time the row it will be in is always the same
            if(dataMapping.length == 4){

                        // Left
                        Assert.assertTrue("The value " + dataMapping[0] + messageData.get(3).getText() + " does not match the value in the database",
                                messageData.get(3).getText().equals(expectedValues.get(dataMapping[0])));
                        // Top
                        Assert.assertTrue("The value " + dataMapping[1] + messageData.get(5).getText() + " does not match the value in the database",
                                messageData.get(5).getText().equals(expectedValues.get(dataMapping[1])));
                        // Bottom
                        Assert.assertTrue("The value " + dataMapping[2] + messageData.get(12).getText() + " does not match the value in the database",
                                messageData.get(12).getText().equals(expectedValues.get(dataMapping[2])));
                        // Right
                        Assert.assertTrue("The value " + dataMapping[3] + messageData.get(8).getText() + " does not match the value in the database",
                                messageData.get(8).getText().equals(expectedValues.get(dataMapping[3])));

                // Only the fish bone should appear no other elements
                Assert.assertTrue(waitToFindXpaths(messageXpath + "/descendant::*", GlobalConstants.ONE).size() == 18);
            }
            else if(dataMapping.length == 7){

                // Need to get example of 7 value fish bone
            }
        }

        // Click on the result message and make sure the "Patient Detail" window with "Lab Results" selected is visible.
        headerInfo.click();
        GlobalStepdefs globalObj = new GlobalStepdefs();
        globalObj.checkPaneLoad("PatientDetailsNavigationBar","load",null);
        globalObj.checkIfElementVisible("LabResultsNavTab", "MISC_ELEMENT", null);
        Assert.assertNotNull("After clicking the result message for the: " + labName + " the wrong lab results page was opened");
        globalObj.clickMiscElement("CloseButton", null, "ClinNavPopup", null);
        SeleniumFunctions.selectFrame(Hooks.getDriver(), "NO_FRAME", "id");

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    /**
     * If for whatever reason there is there are two orders with the same name under the same patient context link. This
     * calls the method to verify a single lab so they are done one at a time.
     *
     * @param messageXpath
     * @param numOfMessages
     * @param resultMapping
     * @return
     * @throws Throwable
     */
    public boolean verifyResultMessageData(String messageXpath, int numOfMessages, String[] resultMapping) throws Throwable{

        for(;numOfMessages > 0; numOfMessages--){

            verifyResultMessageData("(" + messageXpath + ")" + "[" + numOfMessages + "]", resultMapping);
        }

        return true;
    }

    /**
     * This method returns the mapping for the given order. If there is no mapping for that lab this should return null.
     * Clearly this is hard coded but it could be found in the db.
     *
     * @param orderName - the name of the order should be all caps since that is how they appear in the HTML
     * @return - a string array containing the fish bone mapping for that lab or null if there is no mapping
     */
    public String[] getResultMessageDataMapping(String orderName){

        String[] dataMapping = null;

        if(orderName.equals("CBC")){

            dataMapping = new String[4];
            //index in array = position on fish bone: 0 = left, 1 = top, 2 = bottom, 3 = right
            dataMapping[0] = "WBC";
            dataMapping[1] = "Hb";
            dataMapping[2] = "Hct";
            dataMapping[3] = "Plt";
        }

        return dataMapping;
    }

    /**
     * Checks the number of elements returned by a given xpath.
     *
     * @param elementName - the name of the element in the in the JSON file
     * @param tabName - name of the tab the elements is on
     * @param paneName - name of the pane the elements is on
     * @param numberOfElements - the exact number of elements the xpath should return
     */
    @Then("^the \"(.*?)\" xpath on the \"(.*?)\" tab(?: on the \"(.*?)\" pane?)? should return \"(.*?)\" elements?$")
    public void countElements(String elementName, String tabName, String paneName, int numberOfElements) {

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        JSONObject fileObj = UtilFunctions.getJSONFileObjBasedOnTabName(tabName);
        HashMap frameMap = UtilFunctions.getFrameMapBasedOnTabName(tabName);
        String paneFrames = "";
        elementName = elementName.replace(" ", "");
        String[] elementType = UtilFunctions.getElementStringAndType(fileObj, String.format("MISC_ELEMENTS.%s", elementName));
        String xpath = elementType[0];
        String method = elementType[1];

        if (paneName == null)
            paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, String.format("MISC_ELEMENTS.%s", elementName), "frame"));
        else
            paneFrames = UtilFunctions.getFrameValue(frameMap, UtilFunctions.getElementFromJSONFile(fileObj, "PANES." + paneName.replace(" ", ""), "frame"));

        SeleniumFunctions.selectFrame(Hooks.getDriver(), paneFrames, "id");

        Assert.assertTrue("", waitToFindXpaths(xpath + ";" + method, GlobalConstants.TWO).size() == numberOfElements);

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

    @And("^I close the (conversation|group details|phone settings)$")
    public void closeConversation(String pane){
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        SeleniumFunctions.selectFrame(Hooks.getDriver(), "NO_FRAME", "id");
        String closeXpath="";
        switch (pane){
            case"conversation":
                closeXpath= "//div[@class='tab-area ui-sortable']/div/div[@class='close']/i[@class='fa fa-times'];xpath";
                break;
            case"group details":
                closeXpath= "//div[@class='card-title-wrapper']/div[@class='close']/i[@class='fa fa-times'];xpath";
                break;
            case"phone settings":
                closeXpath= "//div[@class='phone-wrapper']/div[@class='close']/i[@class='fa fa-times'];xpath";
                break;
            default:
                break;
        }

//        String closeXpath= "//div[@class='tab-area ui-sortable']/div/div[@class='close']/i[@class='fa fa-times'];xpath";
        WebElement closeObj = waitToFindXpath(closeXpath, GlobalConstants.TWO);
        try{
            closeObj.click();
            Thread.sleep(1000);
        }catch(Exception e){
            Assert.assertFalse("Conversation is not closed due to exception: "+e.getMessage(), true);
        }

        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Complete");
    }

}