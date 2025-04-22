@eRxV2API
Feature: Cancel Rx API

  Background:
    Given API: The auth token is set to "68c6883732a0"

  @CancelRxAPI
  Scenario: 1. Validate CancelRx API
    Given API: I perform actions on "new_pescription" api
    When API: I set the following as payload and check for status code "202"
      | Type                  | Value                                          |
      | id                    | 10906                                          |
      | refId                 | null                                           |
      | ndc                   | 67434509                                       |
      | medId                 | 273718                                         |
      | strength              | 1.5mg                                          |
      | prescriberSpi         | 1970797155001                                  |
      | prescriberAgentSpi    | null                                           |
      | supervisorSpi         | null                                           |
      | pharmacyId            | 7723703                                        |
      | drugDescription       | Transderm-Scop 1.5 mg transdermal 72 hourpatch |
      | quantity              | 30                                             |
      | potencyUnitCode       | C48524                                         |
      | directions            | Take 1.5 MG apply to skin D for 4days.         |
      | note                  | null                                           |
      | refills               | 3                                              |
      | daysSupply            | 4                                              |
      | substitutions         | true                                           |
      | writtenDate           | Current time stamp                             |
      | payerId               | null                                           |
      | lastName              | LI                                             |
      | firstName             | CI                                             |
      | middleName            | null                                           |
      | suffix                | null                                           |
      | prefix                | null                                           |
      | address1              | null                                           |
      | address2              | null                                           |
      | city                  | null                                           |
      | state                 | null                                           |
      | postalCode            | 22202                                          |
      | country               | US                                             |
      | dob                   | -1458068402000                                 |
      | gender                | MALE                                           |
      | phone_newPrescription | null                                           |
      | diagnosisNomenList    | null                                           |
      | planNetworkId         | null                                           |
      | includeRxNorm         | true                                           |
      | workflowDetail        | null                                           |
    Then API: I validate the "NewRx" xml response sent to SS by ERX for medID "273718" with pre-saved response at "/eRxV2/Cancel/NewRx/"

    Then API: I perform actions on "cancel" api
    And API: I set the following as payload and check for status code "201"
      | Type                  | Value                                          |
      | id                    | 10906                                          |
      | refId                 | previous set id                                |
      | ndc                   | 67434509                                       |
      | medId                 | 273718                                         |
      | strength              | 1.5mg                                          |
      | prescriberSpi         | 1970797155001                                  |
      | prescriberAgentSpi    | null                                           |
      | supervisorSpi         | null                                           |
      | pharmacyId            | 7723703                                        |
      | drugDescription       | Transderm-Scop 1.5 mg transdermal 72 hourpatch |
      | quantity              | 30                                             |
      | potencyUnitCode       | C48524                                         |
      | directions            | Take 1.5 MG apply to skin D for 4days.         |
      | note                  | null                                           |
      | refills               | 3                                              |
      | daysSupply            | 4                                              |
      | substitutions         | true                                           |
      | writtenDate           | Current time stamp                             |
      | payerId               | null                                           |
      | lastName              | LI                                             |
      | firstName             | CI                                             |
      | middleName            | null                                           |
      | suffix                | null                                           |
      | prefix                | null                                           |
      | address1              | null                                           |
      | address2              | null                                           |
      | city                  | null                                           |
      | state                 | null                                           |
      | postalCode            | 22202                                          |
      | country               | US                                             |
      | dob                   | -1458068402000                                 |
      | gender                | UNDEFINED                                      |
      | phone_newPrescription | null                                           |
      | diagnosisNomenList    | null                                           |
      | planNetworkId         | null                                           |
      | includeRxNorm         | true                                           |
      | workflowDetail        | null                                           |
    Then API: I validate the "CancelRx" xml response sent to SS by ERX for medID "273718" with pre-saved response at "/eRxV2/Cancel/CancelRx/"

    Then API: I perform actions on "ss/process" api
    And API: I set file "273718" present at location "/eRxV2/CancelRxBody/" as payload and update the following
      | Message.Header.MessageID             |
      | Message.Header.RelatesToMessageID    |
      | Message.Header.SentTime              |
      | Message.Header.PrescriberOrderNumber |
    Then I wait "10" seconds

    Then API: I perform actions on "checkCancelRxResponse" api
    And API: I add reference id in URL
    And API: I validate the medID "273718" response with pre-saved response at "/eRxV2/Cancel/CancelRxFinalResponse/"


  @CancelRxAPI
  Scenario: 2. Validate CancelRx API
    Given API: I perform actions on "new_pescription" api
    When API: I set the following as payload and check for status code "201"
      | Type                                            | Value                                                                       |
      | id                                              | 10906                                                                       |
      | refId                                           | null                                                                        |
      | ndc                                             | 17478017412                                                                 |
      | medId                                           | 250196                                                                      |
      | strength                                        | 1.25 mg/3 mL                                                                |
      | prescriberSpi                                   | 1970797155001                                                               |
      | prescriberAgentSpi                              | null                                                                        |
      | supervisorSpi                                   | null                                                                        |
      | pharmacyId                                      | 0001060                                                                     |
      | drugDescription                                 | Xopenex 1.25 mg/3 mL solution fornebulization                               |
      | quantity                                        | 226.665                                                                     |
      | potencyUnitCode                                 | C28254                                                                      |
      | directions                                      | Inhale one unit every 4-6 hours via nebulizer or as necessary for wheezing. |
      | note                                            | Patient has discontinued use of other inhalers.                             |
      | refills                                         | 2                                                                           |
      | daysSupply                                      | 0                                                                           |
      | substitutions                                   | true                                                                        |
      | writtenDate                                     | Current time stamp                                                          |
      | payerId                                         | null                                                                        |
      | lastName                                        | TUCKER                                                                      |
      | firstName                                       | DEBRA                                                                       |
      | middleName                                      | null                                                                        |
      | suffix                                          | null                                                                        |
      | prefix                                          | null                                                                        |
      | address1                                        | 8383 N 46TH ST APT 500                                                      |
      | address2                                        | null                                                                        |
      | city                                            | Cleveland                                                                   |
      | state                                           | OH                                                                          |
      | postalCode                                      | 44101                                                                       |
      | country                                         | US                                                                          |
      | dob                                             | 311835600000                                                                |
      | gender                                          | FEMALE                                                                      |
      | phone_newPrescription                           | 4408450398                                                                  |
      | diagnosisNomenList_clinicalInformationQualifier | PRESCRIBER                                                                  |
      | diagnosisSubelement_qualifier                   | ABF                                                                         |
      | diagnosisSubelement_value                       | J45.990                                                                     |
      | planNetworkId                                   | null                                                                        |
      | includeRxNorm                                   | true                                                                        |
      | workflowDetail                                  | null                                                                        |
    Then API: I validate the "NewRx" xml response sent to SS by ERX for medID "250196" with pre-saved response at "/eRxV2/Cancel/NewRx/"

    Then API: I perform actions on "cancel" api
    And API: I set the following as payload and check for status code "201"
      | Type                                            | Value                                                                       |
      | id                                              | 10906                                                                       |
      | refId                                           | previous set id                                                                        |
      | ndc                                             | 17478017412                                                                 |
      | medId                                           | 250196                                                                      |
      | strength                                        | 1.25 mg/3 mL                                                                |
      | prescriberSpi                                   | 1970797155001                                                               |
      | prescriberAgentSpi                              | null                                                                        |
      | supervisorSpi                                   | null                                                                        |
      | pharmacyId                                      | 0001060                                                                     |
      | drugDescription                                 | Xopenex 1.25 mg/3 mL solution fornebulization                               |
      | quantity                                        | 226.665                                                                     |
      | potencyUnitCode                                 | C28254                                                                      |
      | directions                                      | Inhale one unit every 4-6 hours via nebulizer or as necessary for wheezing. |
      | note                                            | Patient has discontinued use of other inhalers.                             |
      | refills                                         | 2                                                                           |
      | daysSupply                                      | 0                                                                           |
      | substitutions                                   | true                                                                        |
      | writtenDate                                     | Current time stamp                                                          |
      | payerId                                         | null                                                                        |
      | lastName                                        | TUCKER                                                                      |
      | firstName                                       | DEBRA                                                                       |
      | middleName                                      | null                                                                        |
      | suffix                                          | null                                                                        |
      | prefix                                          | null                                                                        |
      | address1                                        | 8383 N 46TH ST APT 500                                                      |
      | address2                                        | null                                                                        |
      | city                                            | Cleveland                                                                   |
      | state                                           | OH                                                                          |
      | postalCode                                      | 44101                                                                       |
      | country                                         | US                                                                          |
      | dob                                             | 311835600000                                                                |
      | gender                                          | FEMALE                                                                      |
      | phone_newPrescription                           | 4408450398                                                                  |
      | diagnosisNomenList_clinicalInformationQualifier | PRESCRIBER                                                                  |
      | diagnosisSubelement_qualifier                   | ABF                                                                         |
      | diagnosisSubelement_value                       | J45.990                                                                     |
      | planNetworkId                                   | null                                                                        |
      | includeRxNorm                                   | true                                                                        |
      | workflowDetail                                  | null                                                                        |
    Then API: I validate the "CancelRx" xml response sent to SS by ERX for medID "250196" with pre-saved response at "/eRxV2/Cancel/CancelRx/"

    Then API: I perform actions on "ss/process" api
    And API: I set file "250196" present at location "/eRxV2/CancelRxBody/" as payload and update the following
      | Message.Header.MessageID             |
      | Message.Header.RelatesToMessageID    |
      | Message.Header.SentTime              |
      | Message.Header.PrescriberOrderNumber |
    Then I wait "10" seconds

    Then API: I perform actions on "checkCancelRxResponse" api
    And API: I add reference id in URL
    And API: I validate the medID "250196" response with pre-saved response at "/eRxV2/Cancel/CancelRxFinalResponse/"


  @CancelRxAPI
  Scenario: 3. Validate CancelRx API
    Given API: I perform actions on "new_pescription" api
    When API: I set the following as payload and check for status code "202"
      | Type                                            | Value                                                                                                     |
      | id                                              | 10906                                                                                                     |
      | refId                                           | null                                                                                                      |
      | ndc                                             | 65027225                                                                                                  |
      | medId                                           | 549088                                                                                                    |
      | strength                                        | 0.2%                                                                                                      |
      | prescriberSpi                                   | 1970797155001                                                                                             |
      | prescriberAgentSpi                              | null                                                                                                      |
      | supervisorSpi                                   | null                                                                                                      |
      | pharmacyId                                      | 1367084                                                                                                   |
      | drugDescription                                 | Pataday 0.2 % eye drops                                                                                   |
      | quantity                                        | 2.5                                                                                                       |
      | potencyUnitCode                                 | C28254                                                                                                    |
      | directions                                      | 1 drop in both eyes once a day for 4 weeks, wait 10-15 minutes before contact lens insertion. Shake well. |
      | note                                            | null                                                                                                      |
      | refills                                         | 0                                                                                                         |
      | daysSupply                                      | 0                                                                                                         |
      | substitutions                                   | true                                                                                                      |
      | writtenDate                                     | Current time stamp                                                                                        |
      | payerId                                         | null                                                                                                      |
      | lastName                                        | FLOUNDERS                                                                                                 |
      | firstName                                       | FELICIA                                                                                                   |
      | middleName                                      | ANN                                                                                                       |
      | suffix                                          | null                                                                                                      |
      | prefix                                          | null                                                                                                      |
      | address1                                        | 6715 SWANSON AVE APT102                                                                                   |
      | address2                                        | null                                                                                                      |
      | city                                            | BETHESDA                                                                                                  |
      | state                                           | MD                                                                                                        |
      | postalCode                                      | 20187                                                                                                     |
      | country                                         | US                                                                                                        |
      | dob                                             | 341902800000                                                                                              |
      | gender                                          | FEMALE                                                                                                    |
      | phone_newPrescription                           | 3018620035x2345                                                                                           |
      | diagnosisNomenList_clinicalInformationQualifier | PRESCRIBER                                                                                                |
      | diagnosisSubelement_qualifier                   | ABF                                                                                                       |
      | diagnosisSubelement_value                       | H57.8                                                                                                     |
      | planNetworkId                                   | null                                                                                                      |
      | includeRxNorm                                   | true                                                                                                      |
      | workflowDetail                                  | null                                                                                                      |
    Then API: I validate the "NewRx" xml response sent to SS by ERX for medID "549088" with pre-saved response at "/eRxV2/Cancel/NewRx/"

    Then API: I perform actions on "cancel" api
    And API: I set the following as payload and check for status code "201"
      | Type                                            | Value                                                                                                     |
      | id                                              | 10906                                                                                                     |
      | refId                                           | previous set id                                                                                           |
      | ndc                                             | 65027225                                                                                                  |
      | medId                                           | 549088                                                                                                    |
      | strength                                        | 0.2%                                                                                                      |
      | prescriberSpi                                   | 1970797155001                                                                                             |
      | prescriberAgentSpi                              | null                                                                                                      |
      | supervisorSpi                                   | null                                                                                                      |
      | pharmacyId                                      | 1367084                                                                                                   |
      | drugDescription                                 | Pataday 0.2 % eye drops                                                                                   |
      | quantity                                        | 2.5                                                                                                       |
      | potencyUnitCode                                 | C28254                                                                                                    |
      | directions                                      | 1 drop in both eyes once a day for 4 weeks, wait 10-15 minutes before contact lens insertion. Shake well. |
      | note                                            | null                                                                                                      |
      | refills                                         | 0                                                                                                         |
      | daysSupply                                      | 0                                                                                                         |
      | substitutions                                   | true                                                                                                      |
      | writtenDate                                     | Current time stamp                                                                                        |
      | payerId                                         | null                                                                                                      |
      | lastName                                        | FLOUNDERS                                                                                                 |
      | firstName                                       | FELICIA                                                                                                   |
      | middleName                                      | ANN                                                                                                       |
      | suffix                                          | null                                                                                                      |
      | prefix                                          | null                                                                                                      |
      | address1                                        | 6715 SWANSON AVE APT102                                                                                   |
      | address2                                        | null                                                                                                      |
      | city                                            | BETHESDA                                                                                                  |
      | state                                           | MD                                                                                                        |
      | postalCode                                      | 20187                                                                                                     |
      | country                                         | US                                                                                                        |
      | dob                                             | 341902800000                                                                                              |
      | gender                                          | FEMALE                                                                                                    |
      | phone_newPrescription                           | 3018620035x2345                                                                                           |
      | diagnosisNomenList_clinicalInformationQualifier | PRESCRIBER                                                                                                |
      | diagnosisSubelement_qualifier                   | ABF                                                                                                       |
      | diagnosisSubelement_value                       | H57.8                                                                                                     |
      | planNetworkId                                   | null                                                                                                      |
      | includeRxNorm                                   | true                                                                                                      |
      | workflowDetail                                  | null                                                                                                      |
    Then API: I validate the "CancelRx" xml response sent to SS by ERX for medID "549088" with pre-saved response at "/eRxV2/Cancel/CancelRx/"

    Then API: I perform actions on "ss/process" api
    And API: I set file "549088" present at location "/eRxV2/CancelRxBody/" as payload and update the following
      | Message.Header.MessageID             |
      | Message.Header.RelatesToMessageID    |
      | Message.Header.SentTime              |
      | Message.Header.PrescriberOrderNumber |
    Then I wait "10" seconds

    Then API: I perform actions on "checkCancelRxResponse" api
    And API: I add reference id in URL
    And API: I validate the medID "549088" response with pre-saved response at "/eRxV2/Cancel/CancelRxFinalResponse/"



  @CancelRxAPI
  Scenario: 4. Validate CancelRx API
    Given API: I perform actions on "new_pescription" api
    When API: I set the following as payload and check for status code "202"
      | Type                                            | Value                                                                                                                                        |
      | id                                              | 10906                                                                                                                                        |
      | refId                                           | null                                                                                                                                         |
      | ndc                                             | 3029305                                                                                                                                      |
      | medId                                           | 214163                                                                                                                                       |
      | strength                                        | 40 mg/mL                                                                                                                                     |
      | prescriberSpi                                   | 1970797155001                                                                                                                                |
      | prescriberAgentSpi                              | null                                                                                                                                         |
      | supervisorSpi                                   | null                                                                                                                                         |
      | pharmacyId                                      | 3105551                                                                                                                                      |
      | drugDescription                                 | Kenalog 40 mg/mL suspension for injection                                                                                                    |
      | quantity                                        | 12345.1234                                                                                                                                   |
      | potencyUnitCode                                 | C28254                                                                                                                                       |
      | directions                                      | !"#$%'()*+,-/:;=?@[\\]^_`{}~0000 Inject 0.5 ML of Kenalog-40 injection intramuscular, daily for 1 wk, then every alternate for 999 days. |
      | note                                            | null                                                                                                                                         |
      | refills                                         | 11                                                                                                                                           |
      | daysSupply                                      | 999                                                                                                                                          |
      | substitutions                                   | true                                                                                                                                         |
      | writtenDate                                     | Current time stamp                                                                                                                           |
      | payerId                                         | null                                                                                                                                         |
      | lastName                                        | #$%'()*+,-/:;=?@[\\]^_`{}~0000ABCDE                                                                                                       |
      | firstName                                       | #$%'()*+,-/:;=?@[\\]^_`{}~0000ABCDE                                                                                                       |
      | middleName                                      | #$%'()*+,-/:;=?@[\\]^_`{}~0000ABCDE                                                                                                       |
      | suffix                                          | null                                                                                                                                         |
      | prefix                                          | null                                                                                                                                         |
      | address1                                        | #$%'()*+,-/:;=?@[\\]^_`{}~0000 12345 EASY STREET                                                                                          |
      | address2                                        | null                                                                                                                                         |
      | city                                            | #$%'()*+,-/:;=?@[\\]^_`{}~0000CITY                                                                                                        |
      | state                                           | CO                                                                                                                                           |
      | postalCode                                      | 803615977                                                                                                                                    |
      | country                                         | US                                                                                                                                           |
      | dob                                             | -694292400000                                                                                                                                |
      | gender                                          | MALE                                                                                                                                         |
      | phone_newPrescription                           | 5719212122x12345678904444                                                                                                                    |
      | diagnosisNomenList_clinicalInformationQualifier | PRESCRIBER                                                                                                                                   |
      | diagnosisSubelement_qualifier                   | ABF                                                                                                                                          |
      | diagnosisSubelement_value                       | I48.91                                                                                                                                       |
      | planNetworkId                                   | null                                                                                                                                         |
      | includeRxNorm                                   | true                                                                                                                                         |
      | workflowDetail                                  | null                                                                                                                                         |
    Then API: I validate the "NewRx" xml response sent to SS by ERX for medID "214163" with pre-saved response at "/eRxV2/Cancel/NewRx/"

    Then API: I perform actions on "cancel" api
    And API: I set the following as payload and check for status code "201"
      | Type                                            | Value                                                                                                                                        |
      | id                                              | 10906                                                                                                                                        |
      | refId                                           | previous set id                                                                                                                                         |
      | ndc                                             | 3029305                                                                                                                                      |
      | medId                                           | 214163                                                                                                                                       |
      | strength                                        | 40 mg/mL                                                                                                                                     |
      | prescriberSpi                                   | 1970797155001                                                                                                                                |
      | prescriberAgentSpi                              | null                                                                                                                                         |
      | supervisorSpi                                   | null                                                                                                                                         |
      | pharmacyId                                      | 3105551                                                                                                                                      |
      | drugDescription                                 | Kenalog 40 mg/mL suspension for injection                                                                                                    |
      | quantity                                        | 12345.1234                                                                                                                                   |
      | potencyUnitCode                                 | C28254                                                                                                                                       |
      | directions                                      | !"#$%'()*+,-/:;=?@[\\]^_`{}~0000 Inject 0.5 ML of Kenalog-40 injection intramuscular, daily for 1 wk, then every alternate for 999 days. |
      | note                                            | null                                                                                                                                         |
      | refills                                         | 11                                                                                                                                           |
      | daysSupply                                      | 999                                                                                                                                          |
      | substitutions                                   | true                                                                                                                                         |
      | writtenDate                                     | Current time stamp                                                                                                                           |
      | payerId                                         | null                                                                                                                                         |
      | lastName                                        | #$%'()*+,-/:;=?@[\\]^_`{}~0000ABCDE                                                                                                       |
      | firstName                                       | #$%'()*+,-/:;=?@[\\]^_`{}~0000ABCDE                                                                                                       |
      | middleName                                      | #$%'()*+,-/:;=?@[\\]^_`{}~0000ABCDE                                                                                                       |
      | suffix                                          | null                                                                                                                                         |
      | prefix                                          | null                                                                                                                                         |
      | address1                                        | #$%'()*+,-/:;=?@[\\]^_`{}~0000 12345 EASY STREET                                                                                          |
      | address2                                        | null                                                                                                                                         |
      | city                                            | #$%'()*+,-/:;=?@[\\]^_`{}~0000CITY                                                                                                        |
      | state                                           | CO                                                                                                                                           |
      | postalCode                                      | 803615977                                                                                                                                    |
      | country                                         | US                                                                                                                                           |
      | dob                                             | -694292400000                                                                                                                                |
      | gender                                          | MALE                                                                                                                                         |
      | phone_newPrescription                           | 5719212122x12345678904444                                                                                                                    |
      | diagnosisNomenList_clinicalInformationQualifier | PRESCRIBER                                                                                                                                   |
      | diagnosisSubelement_qualifier                   | ABF                                                                                                                                          |
      | diagnosisSubelement_value                       | I48.91                                                                                                                                       |
      | planNetworkId                                   | null                                                                                                                                         |
      | includeRxNorm                                   | true                                                                                                                                         |
      | workflowDetail                                  | null                                                                                                                                         |
    Then API: I validate the "CancelRx" xml response sent to SS by ERX for medID "214163" with pre-saved response at "/eRxV2/Cancel/CancelRx/"

    Then API: I perform actions on "ss/process" api
    And API: I set file "214163" present at location "/eRxV2/CancelRxBody/" as payload and update the following
      | Message.Header.MessageID             |
      | Message.Header.RelatesToMessageID    |
      | Message.Header.SentTime              |
      | Message.Header.PrescriberOrderNumber |
    Then I wait "10" seconds

    Then API: I perform actions on "checkCancelRxResponse" api
    And API: I add reference id in URL
    And API: I validate the medID "214163" response with pre-saved response at "/eRxV2/Cancel/CancelRxFinalResponse/"
