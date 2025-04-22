package api_RestAssured;

import io.restassured.response.Response;
import io.restassured.response.ValidatableResponse;
import io.restassured.specification.RequestSpecification;

/**
* Created by PatientKeeper on 03/20/2017.
*/
public class RequestResponseCommon {

    protected Response response;
    protected ValidatableResponse json;
    protected static RequestSpecification request;

}
