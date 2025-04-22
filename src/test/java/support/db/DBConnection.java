package support.db;

import utils.UtilFunctions;
import utils.UtilProperty;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Created by PatientKeeper on 10/17/2016.
 */

/******************************************************************************
 Class Name: DBConnection
 Provides DB connection
 ******************************************************************************/

public class DBConnection {
    public static DBConnection dbConnection;
    public String server;
    public String port;
    public String sid;
    public String url;
    public String user;
    public String pwd;
    public String sqliteServer;
    public String sqliteURL;
    public String sqlServerURL;
    private Connection connection;


    /**************************************************************************
     * name: DBConnection()
     * functionality: Constructor
     *************************************************************************/
    public DBConnection(){
        this.sqliteServer = UtilFunctions.getValueFromIniFile("HUBSQLITE", "dbserver");
        this.server = UtilFunctions.getValueFromIniFile(UtilProperty.sectionName, "dbserver");
        this.port = UtilFunctions.getValueFromIniFile(UtilProperty.sectionName, "dbport");
        this.sid = UtilFunctions.getValueFromIniFile(UtilProperty.sectionName, "dbsid");
        this.user = UtilFunctions.getValueFromIniFile(UtilProperty.sectionName, "dbschema");
        this.pwd = UtilFunctions.getValueFromIniFile(UtilProperty.sectionName, "dbpass");
        this.url = "jdbc:oracle:thin:@" + this.server + ":" + this.port + "/" + this.sid;
        this.sqliteURL = "jdbc:sqlite:" + this.sqliteServer;
        this.sqlServerURL = "jdbc:sqlserver://" + this.server + ":" + this.port + ";databaseName=" + this.sid + ";user=" + this.user + ";password=" + this.pwd;
    }


    /**************************************************************************
     * name: getConnection()
     * functionality: Provides connection to the database
     * return: Connection object
     *************************************************************************/
    public Connection getConnection()
            throws ClassNotFoundException, SQLException {
        try {
            this.connection = DriverManager.getConnection(this.url, this.user, this.pwd);

        } catch (SQLException e) {
            System.out.println("Connection failed! Check output console");
            e.printStackTrace();
        }
        if (connection != null) {
            System.out.println("You have connected with the database");
        } else {
            System.out.println("Failed to make the database connection");
        }
        return connection;
    }


    /**************************************************************************
     * name: getSQLiteConnection()
     * functionality: Provides connection to the SQLite database at HUB
     * return: Connection object
     *************************************************************************/
    public Connection getSQLiteConnection()
            throws ClassNotFoundException, SQLException {
        try {
            this.connection = DriverManager.getConnection(sqliteURL);

        } catch (SQLException e) {
            System.out.println("Connection failed! Check output console");
            e.printStackTrace();
        }
        if (connection != null) {
            System.out.println("You have connected with the database");
        } else {
            System.out.println("Failed to make the database connection");
        }
        return connection;
    }


    /**************************************************************************
     * name: getSQLServerConnection()
     * functionality: Provides connection to the SQLite database at HUB
     * return: Connection object
     *************************************************************************/
    public Connection getSQLServerConnection()
            throws ClassNotFoundException, SQLException {
        try {
            //Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            this.connection = DriverManager.getConnection(sqlServerURL);

        } catch (SQLException e) {
            System.out.println("Connection failed! Check output console");
            e.printStackTrace();
        }
        if (connection != null) {
            System.out.println("You have connected with the database");
        } else {
            System.out.println("Failed to make the database connection");
        }
        return connection;
    }


    /**************************************************************************
     * name: getDbConnection()
     * functionality: Provides current class object
     * return: DBConnection object
     *************************************************************************/
    public static DBConnection getDbConnection(){
        if (dbConnection == null)
            dbConnection = new DBConnection();
        return dbConnection;
    }


}

