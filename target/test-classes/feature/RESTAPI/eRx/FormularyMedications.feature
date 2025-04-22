@FormularyMedicationsAPI
Feature: Formulary Medications eRx API

  Background:
    Given API: The auth token is set to "surescript123"

  @eRxAPI
  Scenario: 1. Validate /api/formulary_medications
    Given API: I perform actions on "formulary_medications" api
    When API: I set the following as payload
      | Type          | Value                      |
      | lastName      | RODGERSSON                 |
      | firstName     | TEAGUE                     |
      | middleName    | null                       |
      | address1      | 191 SCREAMING VILLAGE BLVD |
      | city          | YONKERS                    |
      | state         | NY                         |
      | postalCode    | 10705                      |
      | country       | US                         |
      | dob           | 1272686400000              |
      | gender        | MALE                       |
      | phone         | 9146445721                 |
      | medId         | 257616                     |
      | prescriberSpi | 6660942728001              |
    And API: I validate the medID "257616" response with pre-saved response at "/eRx/FormularyMedications/"

  @eRxV2API
  Scenario: 1. FOR ERXV2: Validate /api/formulary_medications
    Given API: I perform actions on "formulary_medications" api
    When API: I set the following as payload
      | Type          | Value                      |
      | lastName      | RODGERSSON                 |
      | firstName     | TEAGUE                     |
      | middleName    | null                       |
      | address1      | 191 SCREAMING VILLAGE BLVD |
      | city          | YONKERS                    |
      | state         | NY                         |
      | postalCode    | 10705                      |
      | country       | US                         |
      | dob           | 1272686400000              |
      | gender        | MALE                       |
      | phone         | 9146445721                 |
      | medId         | 257616                     |
      | prescriberSpi | 6660942728001              |
    And API: I validate the medID "257616V2" response with pre-saved response at "/eRxV2/FormularyMedications/"

  @eRxAPI @eRxV2API
  Scenario: 2. Validate /api/formulary_medications
    Given API: I perform actions on "formulary_medications" api
    When API: I set the following as payload
      | Type          | Value         |
      | lastName      | KYLE          |
      | firstName     | SELENA        |
      | middleName    | R             |
      | address1      | 23230 PORT    |
      | city          | AKRON         |
      | state         | OH            |
      | postalCode    | 44306         |
      | country       | US            |
      | dob           | -101764800000 |
      | gender        | FEMALE        |
      | phone         | 3306557741    |
      | medId         | 580334        |
      | prescriberSpi | 6660942728001 |
    And API: I validate the medID "580334" response with pre-saved response at "/eRx/FormularyMedications/"


  @eRxAPI @eRxV2API
  Scenario: 3. Validate /api/formulary_medications
    Given API: I perform actions on "formulary_medications" api
    When API: I set the following as payload
      | Type          | Value            |
      | lastName      | STEINBERG        |
      | firstName     | TIMOTHY          |
      | middleName    | R                |
      | address1      | 614 ZACHARY LANE |
      | city          | ATLANTA          |
      | state         | GA               |
      | postalCode    | 30303            |
      | country       | US               |
      | dob           | -190839600000    |
      | gender        | MALE             |
      | phone         | 4048553055       |
      | medId         | 258889           |
      | prescriberSpi | 6660942728001    |
    And API: I validate the medID "258889" response with pre-saved response at "/eRx/FormularyMedications/"


  @eRxAPI
  Scenario Outline: 4. Validate /api/formulary_medications
    Given API: I perform actions on "formulary_medications" api
    When API: I set the following as payload
      | Type          | Value               |
      | lastName      | CROSS               |
      | firstName     | DAVID               |
      | middleName    | M                   |
      | address1      | 6785 LAUGHALOT LANE |
      | city          | TRENTON             |
      | state         | NJ                  |
      | postalCode    | 08608               |
      | country       | US                  |
      | dob           | 84945600000         |
      | gender        | MALE                |
      | phone         | null                |
      | medId         | <MedID>             |
      | prescriberSpi | 6660942728001       |
    And API: I validate the medID "<MedID>" response with pre-saved response at "/eRx/FormularyMedications/"

    Examples:
      | MedID  |
      | 288522 |
      | 268801 |
      | 244899 |
      | 275733 |
      | 261128 |
      | 551031 |
      | 560863 |
      | 429324 |
      | 576314 |


  @eRxV2API
  Scenario Outline: 4. FOR ERXV2: Validate /api/formulary_medications
    Given API: I perform actions on "formulary_medications" api
    When API: I set the following as payload
      | Type          | Value               |
      | lastName      | CROSS               |
      | firstName     | DAVID               |
      | middleName    | M                   |
      | address1      | 6785 LAUGHALOT LANE |
      | city          | TRENTON             |
      | state         | NJ                  |
      | postalCode    | 08608               |
      | country       | US                  |
      | dob           | 84945600000         |
      | gender        | MALE                |
      | phone         | null                |
      | medId         | <MedID>             |
      | prescriberSpi | 6660942728001       |
    And API: I validate the medID "<MedID>V2" response with pre-saved response at "/eRxV2/FormularyMedications/"

    Examples:
      | MedID  |
      | 288522 |
      | 268801 |
      | 244899 |
      | 275733 |
      | 261128 |
      | 551031 |
      | 560863 |
      | 429324 |
      | 576314 |


  @eRxAPI @eRxV2API
  Scenario Outline: 5. Validate /api/formulary_medications
    Given API: I perform actions on "formulary_medications" api
    When API: I set the following as payload
      | Type          | Value              |
      | lastName      | SWIFT              |
      | firstName     | JONATHAN           |
      | middleName    | null               |
      | address1      | 99238 VERTIGO LANE |
      | city          | MINNEAPOLIS        |
      | state         | MN                 |
      | postalCode    | 55427              |
      | country       | US                 |
      | dob           | 309585600000       |
      | gender        | MALE               |
      | phone         | 9524475477         |
      | medId         | <MedID>            |
      | prescriberSpi | 6660942728001      |
    And API: I validate the medID "<MedID>" response with pre-saved response at "/eRx/FormularyMedications/"

    Examples:
      | MedID    |
      | 270211   |
      | 551031_2 |


  @eRxAPI
  Scenario Outline: 6. Validate /api/formulary_medications
    Given API: I perform actions on "formulary_medications" api
    When API: I set the following as payload
      | Type          | Value         |
      | lastName      | WHITESIDE     |
      | firstName     | KARA          |
      | middleName    | null          |
      | address1      | 23230 SEAPORT |
      | city          | AKRON         |
      | state         | OH            |
      | postalCode    | 44306         |
      | country       | US            |
      | dob           | -543524400000 |
      | gender        | FEMALE        |
      | phone         | 3305547754    |
      | medId         | <MedID>       |
      | prescriberSpi | 6660942728001 |
    And API: I validate the medID "<MedID>" response with pre-saved response at "/eRx/FormularyMedications/"

    Examples:
      | MedID  |
      | 262620 |
      | 582956 |


  @eRxV2API
  Scenario Outline: 6. FOR ERXV2: Validate /api/formulary_medications
    Given API: I perform actions on "formulary_medications" api
    When API: I set the following as payload
      | Type          | Value         |
      | lastName      | WHITESIDE     |
      | firstName     | KARA          |
      | middleName    | null          |
      | address1      | 23230 SEAPORT |
      | city          | AKRON         |
      | state         | OH            |
      | postalCode    | 44306         |
      | country       | US            |
      | dob           | -543524400000 |
      | gender        | FEMALE        |
      | phone         | 3305547754    |
      | medId         | <MedID>       |
      | prescriberSpi | 6660942728001 |
    And API: I validate the medID "<MedID>V2" response with pre-saved response at "/eRxV2/FormularyMedications/"

    Examples:
      | MedID  |
      | 262620 |
      | 582956 |


  @eRxAPI
  Scenario Outline: 7. Validate /api/formulary_medications
    Given API: I perform actions on "formulary_medications" api
    When API: I set the following as payload
      | Type          | Value         |
      | lastName      | DOCKENDORF    |
      | firstName     | TAD           |
      | middleName    | A             |
      | address1      | 32 RANCH PASS |
      | city          | CHEYENNE      |
      | state         | WY            |
      | postalCode    | 82001         |
      | country       | US            |
      | dob           | 173764800000  |
      | gender        | MALE          |
      | phone         | 3078553055    |
      | medId         | <MedID>       |
      | prescriberSpi | 6660942728001 |
    And API: I validate the medID "<MedID>" response with pre-saved response at "/eRx/FormularyMedications/"

    Examples:
      | MedID  |
      | 174836 |
      | 165435 |
      | 256217 |
      | 567731 |
      | 192407 |


  @eRxV2API
  Scenario Outline: 7. FOR ERXV2: Validate /api/formulary_medications
    Given API: I perform actions on "formulary_medications" api
    When API: I set the following as payload
      | Type          | Value         |
      | lastName      | DOCKENDORF    |
      | firstName     | TAD           |
      | middleName    | A             |
      | address1      | 32 RANCH PASS |
      | city          | CHEYENNE      |
      | state         | WY            |
      | postalCode    | 82001         |
      | country       | US            |
      | dob           | 173764800000  |
      | gender        | MALE          |
      | phone         | 3078553055    |
      | medId         | <MedID>       |
      | prescriberSpi | 6660942728001 |
    And API: I validate the medID "<MedID>V2" response with pre-saved response at "/eRxV2/FormularyMedications/"

    Examples:
      | MedID  |
      | 174836 |
      | 165435 |
      | 256217 |
      | 567731 |
      | 192407 |


  @eRxAPI @eRxV2API
  Scenario: 8. Validate /api/formulary_medications
    Given API: I perform actions on "formulary_medications" api
    When API: I set the following as payload
      | Type          | Value                       |
      | lastName      | JOCKEY                      |
      | firstName     | FRED                        |
      | middleName    | A                           |
      | address1      | 245 KENTUCKY BLUEGRASS LANE |
      | city          | OKLAHOMA CITY               |
      | state         | OK                          |
      | postalCode    | 73102                       |
      | country       | US                          |
      | dob           | -1610910000000              |
      | gender        | MALE                        |
      | phone         | 4058553055                  |
      | medId         | 451300                      |
      | prescriberSpi | 6660942728001               |
    And API: I validate the medID "451300" response with pre-saved response at "/eRx/FormularyMedications/"


  @eRxAPI @eRxV2API
  Scenario: 9. Validate /api/formulary_medications
    Given API: I perform actions on "formulary_medications" api
    When API: I set the following as payload
      | Type          | Value                 |
      | lastName      | WILSON                |
      | firstName     | JOSEF                 |
      | middleName    | null                  |
      | address1      | 124 PORT TASTING LANE |
      | city          | MINNEAPOLIS           |
      | state         | MN                    |
      | postalCode    | 55427                 |
      | country       | US                    |
      | dob           | 337492800000          |
      | gender        | MALE                  |
      | phone         | 9523354587            |
      | medId         | 576314_2              |
      | prescriberSpi | 6660942728001         |
    And API: I validate the medID "576314_2" response with pre-saved response at "/eRx/FormularyMedications/"


  @eRxAPI @eRxV2API
  Scenario: 10. Validate /api/formulary_medications
    Given API: I perform actions on "formulary_medications" api
    When API: I set the following as payload
      | Type          | Value                  |
      | lastName      | WAYNE                  |
      | firstName     | BRUCE                  |
      | middleName    | null                   |
      | address1      | 1174 BACON STREET BLVD |
      | city          | MINNEAPOLIS            |
      | state         | MN                     |
      | postalCode    | 55419                  |
      | country       | US                     |
      | dob           | -754254000000          |
      | gender        | MALE                   |
      | phone         | 7634475544             |
      | medId         | 164059                 |
      | prescriberSpi | 6660942728001          |
    And API: I validate the medID "164059" response with pre-saved response at "/eRx/FormularyMedications/"


  @eRxAPI
  Scenario: 11. Validate /api/formulary_medications
    Given API: I perform actions on "formulary_medications" api
    When API: I set the following as payload
      | Type          | Value              |
      | lastName      | THROWER            |
      | firstName     | DAVID              |
      | middleName    | M                  |
      | address1      | 64 VIOLET LANE     |
      | city          | HOWEY IN THE HILLS |
      | state         | FL                 |
      | postalCode    | 34737              |
      | country       | US                 |
      | dob           | -1163098800000     |
      | gender        | MALE               |
      | phone         | 3526685547         |
      | medId         | 274766             |
      | prescriberSpi | 6660942728001      |
    And API: I validate the medID "274766" response with pre-saved response at "/eRx/FormularyMedications/"


  @eRxV2API
  Scenario: 11. FOR ERXV2: Validate /api/formulary_medications
    Given API: I perform actions on "formulary_medications" api
    When API: I set the following as payload
      | Type          | Value              |
      | lastName      | THROWER            |
      | firstName     | DAVID              |
      | middleName    | M                  |
      | address1      | 64 VIOLET LANE     |
      | city          | HOWEY IN THE HILLS |
      | state         | FL                 |
      | postalCode    | 34737              |
      | country       | US                 |
      | dob           | -1163098800000     |
      | gender        | MALE               |
      | phone         | 3526685547         |
      | medId         | 274766             |
      | prescriberSpi | 6660942728001      |
    And API: I validate the medID "274766V2" response with pre-saved response at "/eRxV2/FormularyMedications/"


  @eRxAPI
  Scenario: 12. Validate /api/formulary_medications
    Given API: I perform actions on "formulary_medications" api
    When API: I set the following as payload
      | Type          | Value                |
      | lastName      | AUBAINE              |
      | firstName     | CHENIN BLANC         |
      | middleName    | null                 |
      | address1      | 927 OFFICIONADO BLVD |
      | city          | MINNEAPOLIS          |
      | state         | MN                   |
      | postalCode    | 55419                |
      | country       | US                   |
      | dob           | -483912000000        |
      | gender        | FEMALE               |
      | phone         | 7639986654           |
      | medId         | 558647               |
      | prescriberSpi | 6660942728001        |
    And API: I validate the medID "558647" response with pre-saved response at "/eRx/FormularyMedications/"


  @eRxV2API
  Scenario: 12. FOR ERXV2: Validate /api/formulary_medications
    Given API: I perform actions on "formulary_medications" api
    When API: I set the following as payload
      | Type          | Value                |
      | lastName      | AUBAINE              |
      | firstName     | CHENIN BLANC         |
      | middleName    | null                 |
      | address1      | 927 OFFICIONADO BLVD |
      | city          | MINNEAPOLIS          |
      | state         | MN                   |
      | postalCode    | 55419                |
      | country       | US                   |
      | dob           | -483912000000        |
      | gender        | FEMALE               |
      | phone         | 7639986654           |
      | medId         | 558647               |
      | prescriberSpi | 6660942728001        |
    And API: I validate the medID "558647" response with pre-saved response at "/eRxV2/FormularyMedications/"


  @eRxAPI @eRxV2API
  Scenario: 13. Validate /api/formulary_medications
    Given API: I perform actions on "formulary_medications" api
    When API: I set the following as payload
      | Type          | Value                                           |
      | lastName      | MYLONGLASTNAMEISCRAZYATFORTYCHARSYUKIKNO        |
      | firstName     | BOBZIMBABWAYALPHAPAINUBERDOOBERNAME             |
      | middleName    | ZACHARYTYPOGALORE                               |
      | address1      | 27732 WEST ALAMEDA POTHOLELADEN STREET UNIT 22A |
      | city          | RANCHO CUCAMONGA                                |
      | state         | CA                                              |
      | postalCode    | 917011515                                       |
      | country       | US                                              |
      | dob           | 1017637200000                                   |
      | gender        | MALE                                            |
      | phone         | 9094457745                                      |
      | medId         | 165337                                          |
      | prescriberSpi | 6660942728001                                   |
    And API: I validate the medID "165337" response with pre-saved response at "/eRx/FormularyMedications/"

