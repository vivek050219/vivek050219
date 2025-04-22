@PharmacyAPI
Feature: Pharmacy eRx API

  Background:
    Given API: The auth token is set to "surescript123"

  @eRxAPI @eRxV2API
  Scenario: 1. Validate /api/pharmacy_search_by_phone
    Given API: I perform actions on "pharmacy_search_by_phone" api
    When API: I set the following as params
      | Type        | Value      |
      | phoneNumber | 7818998787 |
    And API: I validate the pharmacy no "7818998787" response with pre-saved response at "/eRx/Pharmacy/"


   @eRxAPI @eRxV2API
  Scenario: 2. Validate /api/pharmacy_get
    Given API: I perform actions on "pharmacy_get" api
    When API: I set the following as params
      | Type | Value   |
      | id   | 2070438 |
    And API: I validate the pharmacy no "2070438" response with pre-saved response at "/eRx/Pharmacy/"


  @eRxAPI @eRxV2API
  Scenario: 3. Validate /api/pharmacy_directory_search
    Given API: I perform actions on "pharmacy_directory_search" api
    When API: I set the following as payload
      | Type               | Value                |
      | targetLatitude     | 42.415787            |
      | targetLongitude    | -71.251937           |
      | maxDistanceInMiles | 50                   |
      | cityList           | Waltham              |
      | orgNamesList       | Test Update Pharmacy |
    And API: I validate the pharmacy "Waltham_TestUpdatePharmacy" response with pre-saved response at "/eRx/Pharmacy/"


  @eRxAPI
  Scenario: 4. Validate /api/pharmacy_directory_search for multiple pharmacies in waltham
    Given API: I perform actions on "pharmacy_directory_search" api
    When API: I set the following as payload
      | Type               | Value                |
      | targetLatitude     | 42.415787            |
      | targetLongitude    | -71.251937           |
      | maxDistanceInMiles | 50                   |
      | cityList           | Waltham              |
    And API: I validate the pharmacy "Waltham" response with pre-saved response at "/eRx/Pharmacy/"


  @eRxV2API
  Scenario: 4. FOR ERXV2: Validate /api/pharmacy_directory_search for multiple pharmacies in waltham
    Given API: I perform actions on "pharmacy_directory_search" api
    When API: I set the following as payload
      | Type               | Value                |
      | targetLatitude     | 42.415787            |
      | targetLongitude    | -71.251937           |
      | maxDistanceInMiles | 50                   |
      | cityList           | Waltham              |
    And API: I validate the pharmacy "WalthamV2" response with pre-saved response at "/eRxV2/Pharmacy/"