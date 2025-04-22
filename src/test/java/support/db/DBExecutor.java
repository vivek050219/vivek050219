package support.db;

import constants.GlobalConstants;
import features.step_definitions.GlobalStepdefs;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.junit.Assert;
import support.Page;
import utils.UtilFunctions;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * Created by PatientKeeper on 10/14/2016.
 */

/******************************************************************************
 Class Name: DBExecutor
 Class to create database queries
 ******************************************************************************/

public class DBExecutor extends HashMap<String, DBExecutor> {

    public String className = getClass().getSimpleName();
    public Connection conn = null;
    public Statement stmt =null;
    public String strSeparator = ";;";
    public int MAX_ROWS = GlobalConstants.TEN;
    public String table;
    public String set;
    public String alias = "";
    public String columns;
    public String join;
    public String where;
    public String with;
    public String union;
    public String order;
    public String group;
    public String helpers;
    public String query;
    private boolean isSQLite;
    private boolean isSQLServer;

    public boolean isSQLite() {
        return isSQLite;
    }

    public void setSQLite(boolean SQLite) {
        isSQLite = SQLite;
    }

    public boolean isSQLServer() {
        return isSQLServer;
    }

    public void setSQLServer(boolean SQLServer) {
        isSQLServer = SQLServer;
    }

    /**************************************************************************
     * name: DBExecutor(String table, String columns, boolean limit,
     * String option, String helpers, String queryName)
     * functionality: Constructor
     *************************************************************************/
    public DBExecutor(String table, String columns, boolean limit, String option, String helpers, String queryName) throws SQLException, ParseException {
        UtilFunctions.log("Class: " + className + "; Method: Constructor() : Start");

        if (table != null) {
            if (table.contains(",")) {
                Assert.assertTrue("Invalid character ',' found in table name", false);
            }
            else if (table.equals("nested_table")){
                JSONObject fileObj = UtilFunctions.getJSONFileObjForQueriesBasedOnTabName(GlobalStepdefs.curTabName);
                JSONArray tableObjArr = (JSONArray) UtilFunctions.getNestedElementObjectFromJSONFile(fileObj, "QUERIES." + queryName, "nested_table");
                for (int index = 0; index < tableObjArr.size(); index++){
                    JSONObject tableObj = (JSONObject) new JSONParser().parse(tableObjArr.get(index).toString());
                    DBExecutor nestedObj = Page.prepareQuery((String) tableObj.get("table"), false);
                    nestedObj.setQuery();
                    this.table = nestedObj.query;
                    this.alias = (String) tableObj.get("alias");
                }
            }
            else
                this.table = table;
        }
        this.columns = columns;
        this.set = "";
        this.join = "";
        this.where = "";
        this.union = "";
        this.order = "";
        this.group = "";
        this.with = "";
        if (limit)
            addWhere("rownum <= " + MAX_ROWS);
        if (option != null)
            this.columns = option + " " + this.columns;
        if (helpers != null)
            this.helpers = helpers;
    }


    public DBExecutor(){
        System.out.println("Default Constructor!");
    }


    /**************************************************************************
     * name: addWhere(String clause)
     * functionality: Function to add where clause in query
     * param: String clause - Where clause
     * return: void
     *************************************************************************/
    public void addWhere(String clause){
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        if (this.where.equals(""))
            this.where = this.where + clause;
        else
            this.where = this.where + strSeparator + clause;
    }


    public void addWhereTimeFrame(String filterVal){
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        String clause = "";
        int hours;
        int days;
        if (filterVal.matches("Last (\\d+) Hours")) {
            hours = Integer.parseInt(filterVal.split(" ")[1]);
            days = hours / 24;
            clause = getHelperValue("datetimecolumn") + " > sysdate-" + days;
        }
        else if (filterVal.matches("Last (\\d+) Days")) {
            days = Integer.parseInt(filterVal.split(" ")[1]);
            clause = getHelperValue("datetimecolumn") + " > sysdate-" + days;
        }
        addWhere(clause);
    }


    /**************************************************************************
     * name: addColumn(String clause, String... alias)
     * functionality: Function to add column clause in query
     * param: String clause - String clause to be added
     * param: String... alias - Optional alias parameter
     * return: void
     *************************************************************************/
    public void addColumn(String clause, String... alias){
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        if (this.columns.equals(""))
            this.columns = this.columns + clause;
        else
            this.columns = this.columns + ", " + clause;

        if (alias.length > 0)
            this.columns = this.columns + " AS " + alias[0];
    }


    /**************************************************************************
     * name: addWith(String clause)
     * functionality: Function to add with clause in query
     * param: String clause - String with clause to be added
     * return: void
     *************************************************************************/
    public void addWith(String clause){
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        if (this.with.equals(""))
            this.with = this.with + clause;
        else
            this.with = this.with + strSeparator + clause;
    }


    /**************************************************************************
     * name: addGroup(String clause)
     * functionality: Function to add group clause in query
     * param: String clause - String group clause to be added
     * return: void
     *************************************************************************/
    public void addGroup(String clause){
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        if (this.group.equals(""))
            this.group = this.group + clause;
        else
            this.group = this.group + strSeparator + clause;
    }


    /**************************************************************************
     * name: addOrder(String clause)
     * functionality: Function to add order clause in query
     * param: String clause - String order clause to be added
     * return: void
     *************************************************************************/
    public void addOrder(String clause) {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        if (this.order.equals(""))
            this.order = this.order + clause;
        else
            this.order = this.order + strSeparator + clause;
    }


    public void addUnion(String clause) {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        if (this.union.equals(""))
            this.union = this.union + clause;
        else
            this.union = clause + strSeparator + this.union;
            //this.union = this.union + strSeparator + clause;
    }


    /**************************************************************************
     * name: addJoin(String clause, String joinType)
     * functionality: Function to add join clause in query
     * param: String clause - String join clause to be added
     * param: String joinType - Join type (inner, outer, etc.)
     * return: void
     *************************************************************************/
    public void addJoin(String clause, String joinType){
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        if (clause.contains(strSeparator)){
            for (String text : clause.split(strSeparator)){
                if (this.join.equals(""))
                    this.join = this.join + joinType + " JOIN " + text;
                else
                    this.join = this.join + strSeparator + joinType + " JOIN " + text;
            }
        }
        else {
            if (this.join.equals(""))
                this.join = this.join + joinType + " JOIN " + clause;
            else
                this.join = this.join + strSeparator + joinType + " JOIN " + clause;
        }
    }


    /**
     * Add set clause to query
     *
     * @param clause set clause to add to query
     */
    public void addSet(String clause){
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");
                this.set = this.set + " SET " + clause;
                System.out.println("");
    }


    public String getHelperValue(String helperKey){
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        if (this.helpers != null && !this.helpers.equals("")) {
            String[] helperArr = this.helpers.split(strSeparator);
            for (String helper : helperArr){
                String[] helperChildArr = helper.split("=");
                if (helperChildArr[0].equals(helperKey))
                    return helperChildArr[1];
            }
        }
        return null;
    }


    /**************************************************************************
     * name: executeQuery(String functionToCall, String clause)
     * functionality: Function to modify and execute query
     * param: String functionToCall - Function to be called
     * param: String clause - String clause to be added
     * return: query execution result in list form
     *************************************************************************/
    public List<HashMap> executeQuery(String functionToCall, String clause) throws SQLException {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        for (int index = 0; index < Page.dbExecutorMap.size() - 1; index++){
            switch (functionToCall){
                case "addWhere":
                    Page.dbExecutorMap.get(index).addWhere(clause);
                    break;
                case "addColumn":
                    Page.dbExecutorMap.get(index).addColumn(clause);
                    break;
                default:
                    break;
            }
            Page.dbExecutorMap.get(index).setQuery();
            Page.dbExecutorMap.get(Page.dbExecutorMap.size() - 1 - index).table = Page.dbExecutorMap.get(index).query;
        }

        return executeQuery();
    }


    /**************************************************************************
     * name: executeQuery()
     * functionality: Function to execute query
     * return: query execution result in list form
     *************************************************************************/
    public List<HashMap> executeQuery(String... mainQuery) throws SQLException {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        DBConnection dbConnection = DBConnection.getDbConnection();
        if (mainQuery.length == 0)
            setQuery();
        else
            query = mainQuery[0];

        ResultSet rs;
        List ret = null;
        final ArrayList<String> resultList = new ArrayList<String>();
        try {
            if (isSQLite())
                conn = dbConnection.getSQLiteConnection();
            else if (isSQLServer())
                conn = dbConnection.getSQLServerConnection();
            else
                conn = dbConnection.getConnection();
            stmt = conn.createStatement();
            rs = stmt.executeQuery(query);
            ret = convertResultSetToList(rs);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if(stmt!=null) stmt.close();
            if(conn!=null) conn.close();
            Page.dbExecutorMap.clear();
        }
        return ret;
    }


    /**************************************************************************
     * name: setQuery()
     * functionality: Function to finalize query before execution
     * return: void
     *************************************************************************/
    public void setQuery() {
        UtilFunctions.log("Class: " + className + "; Method: " + new Object() {
        }.getClass().getEnclosingMethod().getName() + " : Start");

        query = "";

        if (!this.with.equals("")){
            String[] strArr = this.with.split(strSeparator);
            //Do something
        }

        //Assume query is a SELECT statement if set clause is empty
        if (this.set.isEmpty()) {
            query = query + "SELECT " + this.columns + " FROM ";
        } else {
            query = query + "UPDATE ";
        }

        if (!this.alias.equals("")) {
            query += "(" + this.table + ") " + this.alias;
        }
        else if (!this.table.equals(""))
            query += this.table;

        if (!this.set.isEmpty()) {
            query = query + this.set + " ";
        }

        if (this.join.contains(strSeparator))
            query = makeStr(query, this.join, " ", " ");
        else if (!this.join.equals(""))
            query += " " + this.join;

        query = makeStr(query, this.where, " WHERE ", " AND ");
        query = makeStr(query, this.group, " GROUP BY ", " ");
        query = makeStr(query, this.order, " ORDER BY ", " ");
        query = makeStr(query, this.union, " UNION ", " ");
        UtilFunctions.log("Query: " + query);
    }


    /**************************************************************************
     * name: makeStr(String query, String str, String firstStr,
     * String remainingStr)
     * functionality: Function to make query string
     * param: String query
     * param: String str
     * param: String firstStr
     * param: String remainingStr
     * return: complete query in string format
     *************************************************************************/
    public String makeStr(String query, String str, String firstStr, String remainingStr){
        if (!str.equals("")){
            String[] strArr = str.split(strSeparator);
            boolean first = true;
            for (String s : strArr){
                if (first) {
                    if (firstStr.contains("UNION"))
                        query = s + firstStr + query;
                    else
                        query += firstStr + s;
                    first  = false;
                }
                else
                    query += remainingStr + s;
            }
        }
        return query;
    }


    /**************************************************************************
     * name: convertResultSetToList(ResultSet rs)
     * functionality: Function to convert ResultSet to list of hash maps
     * param: ResultSet rs - output from query execution
     * return: returns list of hash maps
     *************************************************************************/
    public List<HashMap<String,Object>> convertResultSetToList(ResultSet rs) throws SQLException {
        ResultSetMetaData md = rs.getMetaData();
        int columns = md.getColumnCount();
        List<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();

        //Some queries, such as 'delete', return 0 rows/columns
        if (columns > 0) {
            while (rs.next()) {
                HashMap<String, Object> row = new HashMap<String, Object>(columns);
                for (int i = 1; i <= columns; ++i) {
                    row.put(md.getColumnName(i), rs.getObject(i));
                }
                list.add(row);
            }
        }

        return list;
    }
}