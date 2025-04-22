@eRxV2API
Feature: Med History eRx API

  Background:
    Given API: The auth token is set to "68c6883732a0"

  @MedHistoryAPI
  Scenario: 1. Validate /api/medhistory
    Given API: I perform actions on "medHistory" api
    When API: I set the following as payload
      | Type                            | Value                      |
      | lastName                        | Rodgersson                 |
      | firstName                       | Teague                     |
      | middleName                      | null                       |
      | suffix                          | null                       |
      | prefix                          | null                       |
      | address1                        | 191 SCREAMING VILLAGE BLVD |
      | address2                        | null                       |
      | city                            | Yonkers                    |
      | state                           | NY                         |
      | postalCode                      | 10705                      |
      | country                         | null                       |
      | dob                             | 1272686400000              |
      | gender                          | MALE                       |
      | phone                           | 9146445721                 |
      | diagnosisNomenList              | null                       |
      | prescriberSpi                   | 6660942728001              |
      | benefitsCoordinationRequestList | null                       |
      | effectiveDate                   | 2016-03-20                 |
      | expirationDate                  | ${now}                     |
      | consent                         | Y                          |
    And API: I validate the medID "H1-Response" response with pre-saved response at "/eRxV2/MedHistory/"

  @MedHistoryAPI
  Scenario: 2. Validate /api/medhistory
    Given API: I perform actions on "medHistory" api
    When API: I set the following as payload
      | Type                            | Value         |
      | lastName                        | KYLE          |
      | firstName                       | SELENA        |
      | middleName                      | R             |
      | suffix                          | null          |
      | prefix                          | null          |
      | address1                        | 23230 PORT    |
      | address2                        | null          |
      | city                            | AKRON         |
      | state                           | OH            |
      | postalCode                      | 44306         |
      | country                         | null          |
      | dob                             | -101764800000 |
      | gender                          | FEMALE        |
      | phone                           | 3306557741    |
      | diagnosisNomenList              | null          |
      | prescriberSpi                   | 6660942728001 |
      | benefitsCoordinationRequestList | null          |
      | effectiveDate                   | 2016-03-20    |
      | expirationDate                  | ${now}        |
      | consent                         | Y             |
    And API: I validate the medID "H2-Response" response with pre-saved response at "/eRxV2/MedHistory/"

  @MedHistoryAPI
  Scenario: 3. Validate /api/medhistory
    Given API: I perform actions on "medHistory" api
    When API: I set the following as payload
      | Type                            | Value         |
      | lastName                        | KYLE          |
      | firstName                       | SELENA        |
      | middleName                      | R             |
      | suffix                          | null          |
      | prefix                          | null          |
      | address1                        | 23230 PORT    |
      | address2                        | null          |
      | city                            | AKRON         |
      | state                           | OH            |
      | postalCode                      | 44306         |
      | country                         | null          |
      | dob                             | -101764800000 |
      | gender                          | FEMALE        |
      | phone                           | 3306557741    |
      | diagnosisNomenList              | null          |
      | prescriberSpi                   | 6660942728001 |
      | benefitsCoordinationRequestList | null          |
      | effectiveDate                   | 2016-03-20    |
      | expirationDate                  | 2018-01-01    |
      | consent                         | Y             |
    And API: I validate the medID "H2-Additional-Response" response with pre-saved response at "/eRxV2/MedHistory/"

  @MedHistoryAPI
  Scenario: 4. Validate /api/medhistory
    Given API: I perform actions on "medHistory" api
    When API: I set the following as payload and check for status code "200"
      | Type                            | Value            |
      | lastName                        | STEINBERG        |
      | firstName                       | TIMOTHY          |
      | middleName                      | R                |
      | suffix                          | null             |
      | prefix                          | null             |
      | address1                        | 614 ZACHARY LANE |
      | address2                        | null             |
      | city                            | ATLANTA          |
      | state                           | GA               |
      | postalCode                      | 30303            |
      | country                         | null             |
      | dob                             | -190839600000    |
      | gender                          | MALE             |
      | phone                           | 4048553055       |
      | diagnosisNomenList              | null             |
      | prescriberSpi                   | 6660942728001    |
      | benefitsCoordinationRequestList | null             |
      | effectiveDate                   | 2016-03-20       |
      | expirationDate                  | ${now}           |
      | consent                         | Y                |
    And API: I validate the message "Eligible benefits coordination with sufficient coverage was not found"

  @MedHistoryAPI
  Scenario: 5. Validate /api/medhistory
    Given API: I perform actions on "medHistory" api
    When API: I set the following as payload
      | Type                            | Value               |
      | lastName                        | CROSS               |
      | firstName                       | DAVID               |
      | middleName                      | M                   |
      | suffix                          | null                |
      | prefix                          | null                |
      | address1                        | 6785 LAUGHALOT LANE |
      | address2                        | null                |
      | city                            | TRENTON             |
      | state                           | NJ                  |
      | postalCode                      | 08608               |
      | country                         | null                |
      | dob                             | 84945600000         |
      | gender                          | MALE                |
      | diagnosisNomenList              | null                |
      | prescriberSpi                   | 6660942728001       |
      | benefitsCoordinationRequestList | null                |
      | effectiveDate                   | 2016-03-20          |
      | expirationDate                  | ${now}              |
      | consent                         | Y                   |
    And API: I validate the medID "H5-Response" response with pre-saved response at "/eRxV2/MedHistory/"

  @MedHistoryAPI
  Scenario: 6. Validate /api/medhistory
    Given API: I perform actions on "medHistory" api
    When API: I set the following as payload
      | Type                            | Value              |
      | lastName                        | SWIFT              |
      | firstName                       | JOHNATHAN          |
      | middleName                      | null               |
      | suffix                          | null               |
      | prefix                          | null               |
      | address1                        | 99238 VERTIGO LANE |
      | address2                        | null               |
      | city                            | MINNEAPOLIS        |
      | state                           | MN                 |
      | postalCode                      | 55427              |
      | country                         | null               |
      | dob                             | 309585600000       |
      | gender                          | MALE               |
      | phone                           | 9524475477         |
      | diagnosisNomenList              | null               |
      | prescriberSpi                   | 6660942728001      |
      | benefitsCoordinationRequestList | null               |
      | effectiveDate                   | 2016-03-20         |
      | expirationDate                  | ${now}             |
      | consent                         | Y                  |
    And API: I validate the medID "H6-Response" response with pre-saved response at "/eRxV2/MedHistory/"

  @MedHistoryAPI
  Scenario: 7. Validate /api/medhistory
    Given API: I perform actions on "medHistory" api
    When API: I set the following as payload
      | Type                            | Value         |
      | lastName                        | WHITESIDE     |
      | firstName                       | KARA          |
      | middleName                      | null          |
      | suffix                          | null          |
      | prefix                          | null          |
      | address1                        | 23230 SEAPORT |
      | address2                        | null          |
      | city                            | AKRON         |
      | state                           | OH            |
      | postalCode                      | 44306         |
      | country                         | null          |
      | dob                             | -543524400000 |
      | gender                          | FEMALE        |
      | phone                           | 3305547754    |
      | diagnosisNomenList              | null          |
      | prescriberSpi                   | 6660942728001 |
      | benefitsCoordinationRequestList | null          |
      | effectiveDate                   | 2016-03-20    |
      | expirationDate                  | ${now}        |
      | consent                         | Y             |
    And API: I validate the medID "H8-Response" response with pre-saved response at "/eRxV2/MedHistory/"

  @MedHistoryAPI
  Scenario: 8. Validate /api/medhistory
    Given API: I perform actions on "medHistory" api
    When API: I set the following as payload
      | Type                            | Value                       |
      | lastName                        | JOCKEY                      |
      | firstName                       | FRED                        |
      | middleName                      | A                           |
      | suffix                          | null                        |
      | prefix                          | null                        |
      | address1                        | 245 KENTUCKY BLUEGRASS LANE |
      | address2                        | null                        |
      | city                            | OKLAHOMA CITY               |
      | state                           | OK                          |
      | postalCode                      | 73102                       |
      | country                         | null                        |
      | dob                             | -1610910000000              |
      | gender                          | MALE                        |
      | phone                           | 4058553055                  |
      | diagnosisNomenList              | null                        |
      | prescriberSpi                   | 6660942728001               |
      | benefitsCoordinationRequestList | null                        |
      | effectiveDate                   | 2016-03-20                  |
      | expirationDate                  | ${now}                      |
      | consent                         | Y                           |
    And API: I validate the medID "H10-Response" response with pre-saved response at "/eRxV2/MedHistory/"

  @MedHistoryAPI
  Scenario: 9. Validate /api/medhistory
    Given API: I perform actions on "medHistory" api
    When API: I set the following as payload
      | Type                            | Value         |
      | lastName                        | DOCKENDORF    |
      | firstName                       | TAD           |
      | middleName                      | A             |
      | suffix                          | null          |
      | prefix                          | null          |
      | address1                        | 32 RANCH PASS |
      | address2                        | null          |
      | city                            | CHEYENNE      |
      | state                           | WY            |
      | postalCode                      | 82001         |
      | country                         | null          |
      | dob                             | 173764800000  |
      | gender                          | MALE          |
      | phone                           | 3078553055    |
      | diagnosisNomenList              | null          |
      | prescriberSpi                   | 6660942728001 |
      | benefitsCoordinationRequestList | null          |
      | effectiveDate                   | 2016-03-20    |
      | expirationDate                  | ${now}        |
      | consent                         | Y             |
    And API: I validate the medID "H11-Response" response with pre-saved response at "/eRxV2/MedHistory/"

  @MedHistoryAPI
  Scenario: 10. Validate /api/medhistory
    Given API: I perform actions on "medHistory" api
    When API: I set the following as payload
      | Type                            | Value                 |
      | lastName                        | WILSON                |
      | firstName                       | JOSEF                 |
      | middleName                      | null                  |
      | suffix                          | null                  |
      | prefix                          | null                  |
      | address1                        | 124 PORT TASTING LANE |
      | address2                        | null                  |
      | city                            | MINNEAPOLIS           |
      | state                           | MN                    |
      | postalCode                      | 55427                 |
      | country                         | null                  |
      | dob                             | 337492800000          |
      | gender                          | MALE                  |
      | phone                           | 9523354587            |
      | diagnosisNomenList              | null                  |
      | prescriberSpi                   | 6660942728001         |
      | benefitsCoordinationRequestList | null                  |
      | effectiveDate                   | 2016-03-20            |
      | expirationDate                  | ${now}                |
      | consent                         | Y                     |
    And API: I validate the medID "H15-Response" response with pre-saved response at "/eRxV2/MedHistory/"

  @MedHistoryAPI
  Scenario: 11. Validate /api/medhistory
    Given API: I perform actions on "medHistory" api
    When API: I set the following as payload
      | Type                            | Value                  |
      | lastName                        | WAYNE                  |
      | firstName                       | BRUCE                  |
      | middleName                      | null                   |
      | suffix                          | null                   |
      | prefix                          | null                   |
      | address1                        | 1174 BACON STREET BLVD |
      | address2                        | null                   |
      | city                            | MINNEAPOLIS            |
      | state                           | MN                     |
      | postalCode                      | 55419                  |
      | country                         | null                   |
      | dob                             | -754254000000          |
      | gender                          | MALE                   |
      | phone                           | 7634475544             |
      | diagnosisNomenList              | null                   |
      | prescriberSpi                   | 6660942728001          |
      | benefitsCoordinationRequestList | null                   |
      | effectiveDate                   | 2016-03-20             |
      | expirationDate                  | ${now}                 |
      | consent                         | Y                      |
    And API: I validate the medID "H17-Response" response with pre-saved response at "/eRxV2/MedHistory/"

  @MedHistoryAPI
  Scenario: 12. Validate /api/medhistory
    Given API: I perform actions on "medHistory" api
    When API: I set the following as payload
      | Type                            | Value              |
      | lastName                        | THROWER            |
      | firstName                       | DAVID              |
      | middleName                      | M                  |
      | suffix                          | null               |
      | prefix                          | null               |
      | address1                        | 64 VIOLET LANE     |
      | address2                        | null               |
      | city                            | HOWEY IN THE HILLS |
      | state                           | FL                 |
      | postalCode                      | 34737              |
      | country                         | null               |
      | dob                             | -1163098800000     |
      | gender                          | MALE               |
      | phone                           | 3526685547         |
      | diagnosisNomenList              | null               |
      | prescriberSpi                   | 6660942728001      |
      | benefitsCoordinationRequestList | null               |
      | effectiveDate                   | 2016-03-20         |
      | expirationDate                  | ${now}             |
      | consent                         | Y                  |
    And API: I validate the medID "H18-Response" response with pre-saved response at "/eRxV2/MedHistory/"

  @MedHistoryAPI
  Scenario: 13. Validate /api/medhistory
    Given API: I perform actions on "medHistory" api
    When API: I set the following as payload
      | Type                            | Value                |
      | lastName                        | AUBAINE              |
      | firstName                       | CHENIN BLANC         |
      | middleName                      | null                 |
      | suffix                          | null                 |
      | prefix                          | null                 |
      | address1                        | 927 OFFICIONADO BLVD |
      | address2                        | null                 |
      | city                            | MINNEAPOLIS          |
      | state                           | MN                   |
      | postalCode                      | 55419                |
      | country                         | null                 |
      | dob                             | -483912000000        |
      | gender                          | FEMALE               |
      | phone                           | 7639986654           |
      | diagnosisNomenList              | null                 |
      | prescriberSpi                   | 6660942728001        |
      | benefitsCoordinationRequestList | null                 |
      | effectiveDate                   | 2016-03-20           |
      | expirationDate                  | ${now}               |
      | consent                         | Y                    |
    And API: I validate the medID "H19-Response" response with pre-saved response at "/eRxV2/MedHistory/"

  @MedHistoryAPI
  Scenario: 14. Validate /api/medhistory
    Given API: I perform actions on "medHistory" api
    When API: I set the following as payload
      | Type                            | Value                               |
      | lastName                        | MYLONGLASTNAMEISCRAZYATFORTYCHARSY  |
      | firstName                       | BOBZIMBABWAYALPHAPAINUBERDOOBERNAME |
      | middleName                      | ZACHARYTYPOGALORE                   |
      | suffix                          | null                                |
      | prefix                          | null                                |
      | address1                        | 27732 WEST ALAMEDA POTHOLELADEN ST  |
      | address2                        | null                                |
      | city                            | RANCHO CUCAMONGA                    |
      | state                           | CA                                  |
      | postalCode                      | 917011515                           |
      | country                         | null                                |
      | dob                             | 1017637200000                       |
      | gender                          | MALE                                |
      | phone                           | 9094457745                          |
      | diagnosisNomenList              | null                                |
      | prescriberSpi                   | 6660942728001                       |
      | benefitsCoordinationRequestList | null                                |
      | effectiveDate                   | 2016-03-20                          |
      | expirationDate                  | ${now}                              |
      | consent                         | Y                                   |
    And API: I validate the medID "H21-Response" response with pre-saved response at "/eRxV2/MedHistory/"
