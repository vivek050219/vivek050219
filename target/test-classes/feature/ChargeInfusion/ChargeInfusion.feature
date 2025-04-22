@ChargeInfusion
Feature: Charge Infusion

    Background:
        Given I am logged into the portal with user "pkadminv2" using the default password
        And I am on the "Patient List V2" tab
        And I refresh the patient list
#        When I use the API to create a patient list named "ChargeInfusion" owned by "pkadminv2" with the following parameters
#            | Type   | Name            | Value      |
#            | Filter | Medical Service | Card Group |
#        And I use the API to favorite patient list "ChargeInfusion" for user "pkadminv2" owned by "pkadminv2"
#        And I click the "Refresh Patient List" button
#        And I select "Add Patient(s)" from the "Actions" menu
#        When I click the "Clear Criteria" button
#        And I uncheck the "Include Cancelled Visits" checkbox
#        And I uncheck the "Include Past Visits" checkbox
#        And I enter "5" in the "Admit in last N days" field
#        And I search for patient "Roy Blazer"
#        And I click the "Select All" button in the "Add Patient Search" pane
#        And I click the "Add" button in the "Add patient(s) to your patient list" pane
#        And I click the "Close" button in the "Add patient(s) to your patient list" pane
#        And I select patient "Roy Blazer" from the patient list


    Scenario: Create Patient List and Add Patient
        When I use the API to create a patient list named "ChargeInfusion" owned by "pkadminv2" with the following parameters
            | Type   | Name            | Value        |
            | Filter | Medical Service | Diab Service |
#        And I use the API to favorite patient list "ChargeInfusion" for user "pkadminv2" owned by "pkadminv2"
        And I click the "Refresh Patient List" button
        And I select "ChargeInfusion" from the "Patient List" menu
#        And I select "Add Patient(s)" from the "Actions" menu
#        And I click the "Clear Criteria" button
#        And I uncheck the "Include Cancelled Visits" checkbox
#        And I uncheck the "Include Past Visits" checkbox
#        And I enter "5" in the "Admit in last N days" field
#        And I search for patient "Roy Blazer"
#        And I click the "Select All" button in the "Add Patient Search" pane
#        And I click the "Add" button in the "Add patient(s) to your patient list" pane
#        Then I click the "Close" button in the "Add patient(s) to your patient list" pane

    @infusion
    Scenario Outline: Separate Hydration Order
        When I select "ChargeInfusion" from the "Patient List" menu
        And patient "Roy Blazer" has no charges
        And I select patient "Roy Blazer" from the patient list
        And I select "Charges" from clinical navigation
        And I select "Most Recent Visit" from the "Clinical Timeframe" menu
        And I select "Add Charge" from the "Patient Header Actions" menu
        And I set the following charge headers
            |Name         |Value            |
            |Bill Area    |Verve            |
            |Svc Site     |Inpatient        |
        And I click the "Infusion" button in the "Charge Entry" pane
        And I select "<Infusion Type>" from the "Infusion Type" pkdropdown
        And I select "<Access Type>" from the "Access Type" pkdropdown
        And I check the "Separate Hydration Order on File" checkbox
        And I add the infusion input "<Input>"
        And I close the infusion screen
        Then the "Charge Entry" pane should load within "2" second
        And I click the "Submit" button
        And the "Charge Entry" pane should close within "10" second
        When I uncheck the "Show Visits" checkbox
        And I sort the "Charges" table chronologically by the "Date/Time" column in "Descending" order
        Then the codes "<Codes>" should appear in the charges table

        Examples:
            | Test Name             | Infusion Type    | Access Type | Input                                                                                                                                                                                                                                                                                      | Codes                                          |
            | Billing for Hydration | Sequential       | Single Site | Hydration Services,Infusion,1st,08:00,11:00; Ondansetron HCL,Oral,null,null,null; Dexamethasone,IV Push,1st,09:45,10:00; Doxorubicin,IV Push,1st,10:00,10:00; Doxorubicin,IV Push,1st,10:45,10:45; Cisplatin,Infusion,1st,11:05,14:05; Hydration Services,Infusion,1st,14:05,20:05         | 96413; 96415:2; 96411; 96411; 96375; 96361:9   |
            | Hydration only        | Single           | Single Site | Hydration Services,Infusion,1st,08:00,17:00                                                                                                                                                                                                                                                | 96360; 96361:8                                 |
            | DDCA                  | Sequential       | Single Site | Oprelvekin,Infusion,1st,10:00,10:31; Hydration Services,Infusion,1st,10:32,11:32; Doxorubicin,IV Push,1st,11:33,11:43; Cyclophosphamide,Infusion,1st,11:44,12:44                                                                                                                           | 96413; 96411; 96367; 96361                     |
            #system generated
            | Billing for Hydration | System Generated | Single Site | Hydration Services,Infusion,1st,08:00,11:00; Ondansetron HCL,Oral,null,null,null; Dexamethasone,IV Push,1st,09:45,10:00; Doxorubicin,IV Push,1st,10:00,10:00; Doxorubicin,IV Push,1st,10:45,10:45; Cisplatin,Infusion,1st,11:05,14:05; Hydration Services,Infusion,1st,14:05,20:05         | 96413; 96415:2; 96411; 96411; 96375; 96361:9   |
            | Hydration only        | System Generated | Single Site | Hydration Services,Infusion,1st,08:00,17:00                                                                                                                                                                                                                                                | 96360; 96361:8                                 |
            | DDCA                  | System Generated | Single Site | Oprelvekin,Infusion,1st,10:00,10:31; Hydration Services,Infusion,1st,10:32,11:32; Doxorubicin,IV Push,1st,11:33,11:43; Cyclophosphamide,Infusion,1st,11:44,12:44                                                                                                                           | 96413; 96411; 96367; 96361                     |

    @infusion
    Scenario Outline: Non-separate Hydration Order
        When I select "ChargeInfusion" from the "Patient List" menu
        And patient "Roy Blazer" has no charges
        And I select patient "Roy Blazer" from the patient list
        And I select "Charges" from clinical navigation
        And I select "Most Recent Visit" from the "Clinical Timeframe" menu
        And I select "Add Charge" from the "Patient Header Actions" menu
        And I set the following charge headers
            |Name         |Value            |
            |Bill Area    |Verve            |
            |Svc Site     |Inpatient        |
        And I click the "Infusion" button in the "Charge Entry" pane
        And I select "<Infusion Type>" from the "Infusion Type" pkdropdown
        And I select "<Access Type>" from the "Access Type" pkdropdown
        And I uncheck the "Separate Hydration Order on File" checkbox
        And I add the infusion input "<Input>"
        And I close the infusion screen
        Then the "Charge Entry" pane should load within "1" second
        And I click the "Submit" button
        And the "Charge Entry" pane should close within "10" second
        When I uncheck the "Show Visits" checkbox
        And I sort the "Charges" table chronologically by the "Date/Time" column in "Descending" order
        Then the codes "<Codes>" should appear in the charges table

        Examples:
            | Test Name                             | Infusion Type    | Access Type    | Input                                                                                                                                                                                                                                                                  | Codes                      |
            | Billing Sequential Infusions          | Sequential       | Single Site    | Dexamethasone,IV Push,1st,09:45,09:47; Hydration Services,Infusion,1st,09:50,11:00; Mesna,Infusion,1st,10:30,11:00; Cyclophosphamide,Infusion,1st,11:10,12:05; Hydration Services,Infusion,1st,11:00,12:35                                                             | 96413; 96367; 96375        |
            | Billing Additional Hours              | Single           | Single Site    | Infliximab,Infusion,1st,13:20,15:35                                                                                                                                                                                                                                    | 96413; 96415               |
            | Concurrent infusions, same site       | Concurrent       | Single Site    | Filgrastim,Infusion,1st,10:00,14:00; Cidofovir,Infusion,1st,11:00,14:00                                                                                                                                                                                                | 96365; 96366:3; 96368      |
            | Concurrent infusions, different sites | Sequential       | Multiple Sites | Filgrastim,Infusion,1st,10:00,14:00; Cidofovir,Infusion,2nd,10:00,14:00                                                                                                                                                                                                | 96365; 96365-59; 96366:6   |
            | Complicated drug regimen              | Sequential       | Single Site    | Hydration Services,Infusion,1st,16:50,21:15; Ondansetron HCL,Oral,null,null,null; Vinblastine,IV Push,1st,17:40,17:40; Doxorubicin,IV Push,1st,17:45,17:50; Bleomycin,IV Push,1st,17:50,17:56; Dacarbazine,Infusion,1st,18:00,19:15; Dexamethasone,Oral,null,null,null | 96413; 96411:3             |
            | FOLFOX                                | Concurrent       | Single Site    | Oxaliplatin,Infusion,1st,10:00,12:00; Leucovorin,Infusion,1st,10:00,12:00; Fluorouracil,IV Push,1st,12:01,12:04                                                                                                                                                        | 96413; 96415; 96368; 96411 |
            | FOLFIRI                               | Concurrent       | Single Site    | Irinotecan,Infusion,1st,10:00,11:30; Leucovorin,Infusion,1st,10:00,12:00; Fluorouracil,IV Push,1st,12:01,12:06                                                                                                                                                         | 96413; 96368; 96411        |
            | Gemzar                                | Single           | Single Site    | Gemcitabine,Infusion,1st,10:00,10:31                                                                                                                                                                                                                                   | 96413                      |
            | Weekly Taxol                          | Sequential       | Single Site    | Cyanoject,IV Push,1st,09:55,09:57; Diphenhydramine,IV Push,1st,09:58,10:08; Paclitaxel,Infusion,1st,10:09,11:09                                                                                                                                                        | 96413; 96375:2             |
            #system generated
            | Billing Sequential Infusions          | System Generated | Single Site    | Dexamethasone,IV Push,1st,09:45,09:47; Hydration Services,Infusion,1st,09:50,11:00; Mesna,Infusion,1st,10:30,11:00; Cyclophosphamide,Infusion,1st,11:10,12:05; Hydration Services,Infusion,1st,11:00,12:35                                                             | 96413; 96367; 96375        |
            | Billing Additional Hours              | System Generated | Single Site    | Infliximab,Infusion,1st,13:20,15:35                                                                                                                                                                                                                                    | 96413; 96415               |
            | Concurrent infusions, same site       | System Generated | Single Site    | Filgrastim,Infusion,1st,10:00,14:00; Cidofovir,Infusion,1st,11:00,14:00                                                                                                                                                                                                | 96365; 96366:3; 96368      |
            | Concurrent infusions, different sites | System Generated | Multiple Sites | Filgrastim,Infusion,1st,10:00,14:00; Cidofovir,Infusion,2nd,10:00,14:00                                                                                                                                                                                                | 96365; 96365-59; 96366:6   |
            | Complicated drug regimen              | System Generated | Single Site    | Hydration Services,Infusion,1st,16:50,21:15; Ondansetron HCL,Oral,null,null,null; Vinblastine,IV Push,1st,17:40,17:40; Doxorubicin,IV Push,1st,17:45,17:50; Bleomycin,IV Push,1st,17:50,17:56; Dacarbazine,Infusion,1st,18:00,19:15; Dexamethasone,Oral,null,null,null | 96413; 96411:3             |
            | FOLFOX                                | System Generated | Single Site    | Oxaliplatin,Infusion,1st,10:00,12:00; Leucovorin,Infusion,1st,10:00,12:00; Fluorouracil,IV Push,1st,12:01,12:04                                                                                                                                                        | 96413; 96415; 96368; 96411 |
            | FOLFIRI                               | System Generated | Single Site    | Irinotecan,Infusion,1st,10:00,11:30; Leucovorin,Infusion,1st,10:00,12:00; Fluorouracil,IV Push,1st,12:01,12:06                                                                                                                                                         | 96413; 96368; 96411        |
            | Gemzar                                | System Generated | Single Site    | Gemcitabine,Infusion,1st,10:00,10:31                                                                                                                                                                                                                                   | 96413                      |
            | Weekly Taxol                          | System Generated | Single Site    | Cyanoject,IV Push,1st,09:55,09:57; Diphenhydramine,IV Push,1st,09:58,10:08; Paclitaxel,Infusion,1st,10:09,11:09                                                                                                                                                        | 96413; 96375:2             |

    @infusion
    Scenario Outline: DEV-50452: Subsequent infusion for Concurrent and regression tests
        When I select "ChargeInfusion" from the "Patient List" menu
        And patient "Roy Blazer" has no charges
        And I select patient "Roy Blazer" from the patient list
        And I select "Charges" from clinical navigation
        And I select "Most Recent Visit" from the "Clinical Timeframe" menu
        And I select "Add Charge" from the "Patient Header Actions" menu
        And I set the following charge headers
            |Name         |Value            |
            |Bill Area    |Verve            |
            |Svc Site     |Inpatient        |
        And I click the "Infusion" button in the "Charge Entry" pane
        And I select "<Infusion Type>" from the "Infusion Type" pkdropdown
        And I select "<Access Type>" from the "Access Type" pkdropdown
        And I uncheck the "Separate Hydration Order on File" checkbox
        And I add the infusion input "<Input>"
        And I close the infusion screen
        Then the "Charge Entry" pane should load within "1" second
        And I click the "Submit" button
        And the "Charge Entry" pane should close within "10" second
        When I uncheck the "Show Visits" checkbox
        And I sort the "Charges" table chronologically by the "Date/Time" column in "Descending" order
        Then the codes "<Codes>" should appear in the charges table

        Examples:
            | Test Name                                          | Infusion Type    | Access Type    | Input                                                                                                                                                                                                                                   | Codes                                |
            | Chemo <= 1 hour                                    | Concurrent       | Single Site    | Bevacizub,Infusion,1st,16:30,16:50; Oxaliplatin,Infusion,1st,16:55,18:50; Leucovorin,Infusion,1st,16:55,18:45                                                                                                                           | 96417; 96413; 96415; 96368           |
            | Chemo <= 1 hour                                    | System Generated | Single Site    | Bevacizub,Infusion,1st,16:30,16:50; Oxaliplatin,Infusion,1st,16:55,18:50; Leucovorin,Infusion,1st,16:55,18:45                                                                                                                           | 96417; 96413; 96415; 96368           |
            | Non-chemo <= 1 hour                                | Concurrent       | Single Site    | Diphenhydramine,Infusion,1st,13:20,13:40; Atropine Sulfate,Injection,null,null,null; Leucovorin,Infusion,1st,16:15,18:10; Fluorouracil,IV Push,1st,18:10,18:12; Irinotecan,Infusion,1st,16:25,17:55; Bevacizub,IV Push,1st,13:50,14:00; | 96367; 96372; 96368; 96411:2; 96413; |
            | Non-chemo <= 1 hour                                | System Generated | Single Site    | Diphenhydramine,Infusion,1st,13:20,13:40; Atropine Sulfate,Injection,null,null,null; Leucovorin,Infusion,1st,16:15,18:10; Fluorouracil,IV Push,1st,18:10,18:12; Irinotecan,Infusion,1st,16:25,17:55; Bevacizub,IV Push,1st,13:50,14:00; | 96367; 96372; 96368; 96411:2; 96413; |
            | Chemo > 1 hour                                     | Concurrent       | Single Site    | Bevacizub,Infusion,1st,19:00,21:00; Oxaliplatin,Infusion,1st,16:55,18:50; Leucovorin,Infusion,1st,16:55,18:45                                                                                                                           | 96417; 96415:2; 96413; 96368         |
            | Chemo > 1 hour                                     | System Generated | Single Site    | Bevacizub,Infusion,1st,19:00,21:00; Oxaliplatin,Infusion,1st,16:55,18:50; Leucovorin,Infusion,1st,16:55,18:45                                                                                                                           | 96417; 96415:2; 96413; 96368         |
            | Chemo less <= 1 hour                               | Concurrent       | Single Site    | Diphenhydramine,Infusion,1st,11:30,13:40; Leucovorin,Infusion,1st,16:15,18:10; Irinotecan,Infusion,1st,16:25,17:55                                                                                                                      | 96367; 96366; 96368; 96413           |
            | Chemo less <= 1 hour                               | System Generated | Single Site    | Diphenhydramine,Infusion,1st,11:30,13:40; Leucovorin,Infusion,1st,16:15,18:10; Irinotecan,Infusion,1st,16:25,17:55                                                                                                                      | 96367; 96366; 96368; 96413           |
            | Concurrent for same site                           | Concurrent       | Single Site    | Oxaliplatin,Infusion,1st,16:55,18:50; Irinotecan,Infusion,1st,16:55,18:45                                                                                                                                                               | 96413; 96415:2; 96417;               |
            | Concurrent for same site                           | System Generated | Single Site    | Oxaliplatin,Infusion,1st,16:55,18:50; Irinotecan,Infusion,1st,16:55,18:45                                                                                                                                                               | 96413; 96415:2; 96417;               |
            #Regression tests
            | Sequential Infusion Type                           | Sequential       | Single Site    | Oxaliplatin,Infusion,1st,16:55,18:50; Irinotecan,Infusion,1st,18:51,19:45                                                                                                                                                               | 96413; 96415; 96417;                 |
            | Sequential Infusion Type                           | System Generated | Single Site    | Oxaliplatin,Infusion,1st,16:55,18:50; Irinotecan,Infusion,1st,18:51,19:45                                                                                                                                                               | 96413; 96415; 96417;                 |
            | Chemo concurrently diff sites                      | Sequential       | Multiple Sites | Oxaliplatin,Infusion,1st,16:55,17:50; Irinotecan,Infusion,2nd,16:55,17:45                                                                                                                                                               | 96413; 96413-59                      |
            | Chemo concurrently diff sites                      | System Generated | Multiple Sites | Oxaliplatin,Infusion,1st,16:55,17:50; Irinotecan,Infusion,2nd,16:55,17:45                                                                                                                                                               | 96413; 96413-59                      |
            | Non-chemo concurrently same site as chemo infusion | Concurrent       | Single Site    | Oxaliplatin,Infusion,1st,16:55,17:50; Leucovorin,Infusion,1st,16:55,17:45                                                                                                                                                               | 96413; 96368                         |
            | Non-chemo concurrently same site as chemo infusion | System Generated | Single Site    | Oxaliplatin,Infusion,1st,16:55,17:50; Leucovorin,Infusion,1st,16:55,17:45                                                                                                                                                               | 96413; 96368                         |

    @infusion
    Scenario Outline: DEV-51159: Hydration Unchecked - Non-separate Hydration Order - Primary service should not consider drugs whose class OR delivery method is not specified in hierarchy
        When I select "ChargeInfusion" from the "Patient List" menu
        And patient "Roy Blazer" has no charges
        And I select patient "Roy Blazer" from the patient list
        And I select "Charges" from clinical navigation
        And I select "Most Recent Visit" from the "Clinical Timeframe" menu
        And I select "Add Charge" from the "Patient Header Actions" menu
        And I set the following charge headers
            |Name         |Value            |
            |Bill Area    |Verve            |
            |Svc Site     |Inpatient        |
        And I click the "Infusion" button in the "Charge Entry" pane
        And I select "<Infusion Type>" from the "Infusion Type" pkdropdown
        And I select "<Access Type>" from the "Access Type" pkdropdown
        And I uncheck the "Separate Hydration Order on File" checkbox
        And I add the infusion input "<Input>"
        And I close the infusion screen
        Then the "Charge Entry" pane should load within "1" second
        And I click the "Submit" button
        And the "Charge Entry" pane should close within "10" second
        When I uncheck the "Show Visits" checkbox
        And I sort the "Charges" table chronologically by the "Date/Time" column in "Descending" order
        Then the codes "<Codes>" should appear in the charges table

        Examples:
            | Test Name | Infusion Type    | Access Type | Input                                                                     | Codes        |
            | Case 1    | System Generated | Single Site | Leucovorin,Infusion,1st,12:30,13:30; Carfilzomib,Injection,null,null,null | 96365; 96401 |
            | Case 1    | Single           | Single Site | Leucovorin,Infusion,1st,12:30,13:30; Carfilzomib,Injection,null,null,null | 96365; 96401 |
            | Case 2    | System Generated | Single Site | Leucovorin,IV Push,1st,12:30,12:35; Carfilzomib,Injection,null,null,null  | 96374; 96401 |
            | Case 2    | Single           | Single Site | Leucovorin,IV Push,1st,12:30,12:35; Carfilzomib,Injection,null,null,null  | 96374; 96401 |

    @infusion
    Scenario Outline: DEV-51159: Hydration Checked - Separate Hydration Order - Primary service should not consider drugs whose class OR delivery method is not specified in hierarchy
        When I select "ChargeInfusion" from the "Patient List" menu
        And patient "Roy Blazer" has no charges
        And I select patient "Roy Blazer" from the patient list
        And I select "Charges" from clinical navigation
        And I select "Most Recent Visit" from the "Clinical Timeframe" menu
        And I select "Add Charge" from the "Patient Header Actions" menu
        And I set the following charge headers
            |Name         |Value            |
            |Bill Area    |Verve            |
            |Svc Site     |Inpatient        |
        And I click the "Infusion" button in the "Charge Entry" pane
        And I select "<Infusion Type>" from the "Infusion Type" pkdropdown
        And I select "<Access Type>" from the "Access Type" pkdropdown
        And I check the "Separate Hydration Order on File" checkbox
        And I add the infusion input "<Input>"
        And I close the infusion screen
        Then the "Charge Entry" pane should load within "1" second
        And I click the "Submit" button
        And the "Charge Entry" pane should close within "10" second
        When I uncheck the "Show Visits" checkbox
        And I sort the "Charges" table chronologically by the "Date/Time" column in "Descending" order
        Then the codes "<Codes>" should appear in the charges table

        Examples:
            | Test Name | Infusion Type    | Access Type | Input                                                                             | Codes        |
            | Case 3    | System Generated | Single Site | Hydration Services,Infusion,1st,12:30,13:30; Carfilzomib,Injection,null,null,null | 96360; 96401 |
            | Case 3    | Single           | Single Site | Hydration Services,Infusion,1st,12:30,13:30; Carfilzomib,Injection,null,null,null | 96360; 96401 |
            | Case 4    | System Generated | Single Site | Leucovorin,IV Push,1st,12:20,12:30; Hydration Services,Infusion,1st,12:30,13:30   | 96374; 96361 |
            | Case 4    | Single           | Single Site | Leucovorin,IV Push,1st,12:20,12:30; Hydration Services,Infusion,1st,12:30,13:30   | 96374; 96361 |
            | Case 5    | System Generated | Single Site | Leucovorin,Infusion,1st,13:30,14:30; Hydration Services,Infusion,1st,12:30,13:30  | 96365; 96361 |
            | Case 5    | Single           | Single Site | Leucovorin,Infusion,1st,13:30,14:30; Hydration Services,Infusion,1st,12:30,13:30  | 96365; 96361 |

    @infusion
    Scenario Outline: DEV-51164: Do not apply charge codes to additional administrations of a drug where rule 6 was applied
        When I select "ChargeInfusion" from the "Patient List" menu
        And patient "Roy Blazer" has no charges
        And I select patient "Roy Blazer" from the patient list
        And I select "Charges" from clinical navigation
        And I select "Most Recent Visit" from the "Clinical Timeframe" menu
        And I select "Add Charge" from the "Patient Header Actions" menu
        And I set the following charge headers
            |Name         |Value            |
            |Bill Area    |Verve            |
            |Svc Site     |Inpatient        |
        And I click the "Infusion" button in the "Charge Entry" pane
        And I select "<Infusion Type>" from the "Infusion Type" pkdropdown
        And I select "<Access Type>" from the "Access Type" pkdropdown
        And I uncheck the "Separate Hydration Order on File" checkbox
        And I add the infusion input "<Input>"
        And I close the infusion screen
        Then the "Charge Entry" pane should load within "1" second
        And I click the "Submit" button
        And the "Charge Entry" pane should close within "10" second
        When I uncheck the "Show Visits" checkbox
        And I sort the "Charges" table chronologically by the "Date/Time" column in "Descending" order
        Then the codes "<Codes>" should appear in the charges table

        Examples:
            | Test Name                             | Infusion Type    | Access Type | Input                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | Codes                          |
            | Subsequent infusion of same drug      | Concurrent       | Single Site | Hydration Services,Infusion,1st,09:15,13:17; Dexamethasone,Oral,null,null,null; Palonestron,Infusion,1st,11:25,11:35; Bevacizub,Infusion,1st,09:40,09:50; Leucovorin,Infusion,1st,10:00,11:20; Oxaliplatin,Infusion,1st,10:00,11:20; Diphenhydramine,Infusion,1st,11:25,11:35; Methylprednisolone,Infusion,1st,11:35,11:45; Famotodine,Infusion,1st,11:45,11:55; Diphenhydramine,Infusion,1st,11:55,12:05; Leucovorin,Infusion,1st,12:30,13:10; Fluorouracil,IV Push,1st,13:15,13:17 | 96375:4; 96411:2; 96368; 96413 |
            | Subsequent infusion of same drug      | System Generated | Single Site | Hydration Services,Infusion,1st,09:15,13:17; Dexamethasone,Oral,null,null,null; Palonestron,Infusion,1st,11:25,11:35; Bevacizub,Infusion,1st,09:40,09:50; Leucovorin,Infusion,1st,10:00,11:20; Oxaliplatin,Infusion,1st,10:00,11:20; Diphenhydramine,Infusion,1st,11:25,11:35; Methylprednisolone,Infusion,1st,11:35,11:45; Famotodine,Infusion,1st,11:45,11:55; Diphenhydramine,Infusion,1st,11:55,12:05; Leucovorin,Infusion,1st,12:30,13:10; Fluorouracil,IV Push,1st,13:15,13:17 | 96375:4; 96411:2; 96368; 96413 |
            | Subsequent infusion of different drug | Concurrent       | Single Site | Bevacizub,Infusion,1st,19:00,21:00; Oxaliplatin,Infusion,1st,16:55,18:50; Leucovorin,Infusion,1st,16:55,18:45                                                                                                                                                                                                                                                                                                                                                                        | 96417; 96415:2; 96413; 96368   |
            | Subsequent infusion of different drug | System Generated | Single Site | Bevacizub,Infusion,1st,19:00,21:00; Oxaliplatin,Infusion,1st,16:55,18:50; Leucovorin,Infusion,1st,16:55,18:45                                                                                                                                                                                                                                                                                                                                                                        | 96417; 96415:2; 96413; 96368   |
            | No subsequent infusions               | Concurrent       | Single Site | Oxaliplatin,Infusion,1st,11:30,13:40; Leucovorin,Infusion,1st,11:30,13:40                                                                                                                                                                                                                                                                                                                                                                                                            | 96413; 96415; 96368            |
            | No subsequent infusions               | System Generated | Single Site | Oxaliplatin,Infusion,1st,11:30,13:40; Leucovorin,Infusion,1st,11:30,13:40                                                                                                                                                                                                                                                                                                                                                                                                            | 96413; 96415; 96368            |

    @infusion
    Scenario Outline: DEV-51550 and DEV-51543: Hydration checked - Hydration administered through different sites
        When I select "ChargeInfusion" from the "Patient List" menu
        And patient "Roy Blazer" has no charges
        And I select patient "Roy Blazer" from the patient list
        And I select "Charges" from clinical navigation
        And I select "Most Recent Visit" from the "Clinical Timeframe" menu
        And I select "Add Charge" from the "Patient Header Actions" menu
        And I set the following charge headers
            |Name         |Value            |
            |Bill Area    |Verve            |
            |Svc Site     |Inpatient        |
        And I click the "Infusion" button in the "Charge Entry" pane
        And I select "<Infusion Type>" from the "Infusion Type" pkdropdown
        And I select "<Access Type>" from the "Access Type" pkdropdown
        And I check the "Separate Hydration Order on File" checkbox
        And I add the infusion input "<Input>"
        And I close the infusion screen
        Then the "Charge Entry" pane should load within "1" second
        And I click the "Submit" button
        And the "Charge Entry" pane should close within "10" second
        When I uncheck the "Show Visits" checkbox
        And I sort the "Charges" table chronologically by the "Date/Time" column in "Descending" order
        Then the codes "<Codes>" should appear in the charges table

        Examples:
            | Test Name                                    | Infusion Type    | Access Type    | Input                                                                             | Codes                           |
            | 1: Non-chemo, different sites same time      | System Generated | Multiple Sites | Cidofovir,Infusion,1st,12:30,15:30; Hydration Services,Infusion,2nd,12:00,14:00   | 96365; 96366:2; 96360-59; 96361 |
            | 1: Non-chemo, different sites same time      | Sequential       | Multiple Sites | Cidofovir,Infusion,1st,12:30,15:30; Hydration Services,Infusion,2nd,12:00,14:00   | 96365; 96366:2; 96360-59; 96361 |
            | 2: Chemo, different sites same time          | System Generated | Multiple Sites | Oxaliplatin,Infusion,1st,12:30,13:30; Hydration Services,Infusion,2nd,12:00,14:00 | 96413; 96360-59; 96361          |
            | 2: Chemo, different sites same time          | Sequential       | Multiple Sites | Oxaliplatin,Infusion,1st,12:30,13:30; Hydration Services,Infusion,2nd,12:00,14:00 | 96413; 96360-59; 96361          |
            | 3: Non-chemo, different sites different time | System Generated | Multiple Sites | Cidofovir,Infusion,1st,12:30,15:30; Hydration Services,Infusion,2nd,11:30,12:30   | 96365; 96366:2; 96360-59        |
            | 3: Non-chemo, different sites different time | Sequential       | Multiple Sites | Cidofovir,Infusion,1st,12:30,15:30; Hydration Services,Infusion,2nd,11:30,12:30   | 96365; 96366:2; 96360-59        |
            | 4: Chemo, different sites different time     | System Generated | Multiple Sites | Oxaliplatin,Infusion,1st,12:30,15:30; Hydration Services,Infusion,2nd,10:00,12:30 | 96413; 96415:2; 96360-59; 96361 |
            | 4: Chemo, different sites different time     | Sequential       | Multiple Sites | Oxaliplatin,Infusion,1st,12:30,15:30; Hydration Services,Infusion,2nd,10:00,12:30 | 96413; 96415:2; 96360-59; 96361 |

    @infusion
    Scenario Outline: DEV-51550 and DEV-51543: Hydration unchecked - Hydration administered through different sites
        When I select "ChargeInfusion" from the "Patient List" menu
        And patient "Roy Blazer" has no charges
        And I select patient "Roy Blazer" from the patient list
        And I select "Charges" from clinical navigation
        And I select "Most Recent Visit" from the "Clinical Timeframe" menu
        And I select "Add Charge" from the "Patient Header Actions" menu
        And I set the following charge headers
            |Name         |Value            |
            |Bill Area    |Verve            |
            |Svc Site     |Inpatient        |
        And I click the "Infusion" button in the "Charge Entry" pane
        And I select "<Infusion Type>" from the "Infusion Type" pkdropdown
        And I select "<Access Type>" from the "Access Type" pkdropdown
        And I uncheck the "Separate Hydration Order on File" checkbox
        And I add the infusion input "<Input>"
        And I close the infusion screen
        Then the "Charge Entry" pane should load within "1" second
        And I click the "Submit" button
        And the "Charge Entry" pane should close within "10" second
        When I uncheck the "Show Visits" checkbox
        And I sort the "Charges" table chronologically by the "Date/Time" column in "Descending" order
        Then the codes "<Codes>" should appear in the charges table

        Examples:
            | Test Name                                           | Infusion Type    | Access Type    | Input                                                                             | Codes          |
            | 5: Chemo, same site same time                       | System Generated | Single Site    | Oxaliplatin,Infusion,1st,12:30,15:30; Hydration Services,Infusion,1st,12:00,15:30 | 96413; 96415:2 |
            | 5: Chemo, same site same time                       | Concurrent       | Single Site    | Oxaliplatin,Infusion,1st,12:30,15:30; Hydration Services,Infusion,1st,12:00,15:30 | 96413; 96415:2 |
            | Regression 1: Non-chemo, different sites same time  | System Generated | Multiple Sites | Cidofovir,Infusion,1st,12:30,15:30; Hydration Services,Infusion,2nd,12:00,14:00   | 96365; 96366:2 |
            | Regression 1: Non-chemo, different sites same time  | Sequential       | Multiple Sites | Cidofovir,Infusion,1st,12:30,15:30; Hydration Services,Infusion,2nd,12:00,14:00   | 96365; 96366:2 |
            | Regression 2: Chemo, different sites different time | System Generated | Multiple Sites | Oxaliplatin,Infusion,1st,12:30,15:30; Hydration Services,Infusion,2nd,10:30,12:30 | 96413; 96415:2 |
            | Regression 2: Chemo, different sites different time | Sequential       | Multiple Sites | Oxaliplatin,Infusion,1st,12:30,15:30; Hydration Services,Infusion,2nd,10:30,12:30 | 96413; 96415:2 |

    @infusion
    Scenario Outline: DEV-51541: Hydration Unchecked - Multiple primary services
        When I select "ChargeInfusion" from the "Patient List" menu
        And patient "Roy Blazer" has no charges
        And I select patient "Roy Blazer" from the patient list
        And I select "Charges" from clinical navigation
        And I select "Most Recent Visit" from the "Clinical Timeframe" menu
        And I select "Add Charge" from the "Patient Header Actions" menu
        And I set the following charge headers
            |Name         |Value            |
            |Bill Area    |Verve            |
            |Svc Site     |Inpatient        |
        And I click the "Infusion" button in the "Charge Entry" pane
        And I select "<Infusion Type>" from the "Infusion Type" pkdropdown
        And I select "<Access Type>" from the "Access Type" pkdropdown
        And I uncheck the "Separate Hydration Order on File" checkbox
        And I add the infusion input "<Input>"
        And I close the infusion screen
        Then the "Charge Entry" pane should load within "1" second
        And I click the "Submit" button
        And the "Charge Entry" pane should close within "10" second
        When I uncheck the "Show Visits" checkbox
        And I sort the "Charges" table chronologically by the "Date/Time" column in "Descending" order
        Then the codes "<Codes>" should appear in the charges table

        Examples:
            | Test Name                                                             | Infusion Type    | Access Type    | Input                                                                                                      | Codes                        |
            | 1: Chemo Inf site 1, chemo IV site 2                                  | System Generated | Multiple Sites | Oxaliplatin,Infusion,1st,12:30,15:30; Carfilzomib,IV Push,2nd,15:30,15:35                                  | 96413; 96415:2; 96409-59     |
            | 1: Chemo Inf site 1, chemo IV site 2                                  | Single           | Multiple Sites | Oxaliplatin,Infusion,1st,12:30,15:30; Carfilzomib,IV Push,2nd,15:30,15:35                                  | 96413; 96415:2; 96409-59     |
            | 2: Chemo Inf site 1, non-chemo IV site 2                              | System Generated | Multiple Sites | Oxaliplatin,Infusion,1st,12:30,15:30; Cidofovir,IV Push,2nd,15:30,15:35                                    | 96413; 96415:2; 96374-59     |
            | 2: Chemo Inf site 1, non-chemo IV site 2                              | Single           | Multiple Sites | Oxaliplatin,Infusion,1st,12:30,15:30; Cidofovir,IV Push,2nd,15:30,15:35                                    | 96413; 96415:2; 96374-59     |
            | 3: Non-chemo Inf site 1, non-chemo IV site 2                          | System Generated | Multiple Sites | Leucovorin,Infusion,1st,12:30,13:30; Cidofovir,IV Push,2nd,13:30,13:35                                     | 96365; 96374-59              |
            | 3: Non-chemo Inf site 1, non-chemo IV site 2                          | Single           | Multiple Sites | Leucovorin,Infusion,1st,12:30,13:30; Cidofovir,IV Push,2nd,13:30,13:35                                     | 96365; 96374-59              |
            | 4A: Chemo IV site 1, chemo IV site 2                                  | System Generated | Multiple Sites | Oxaliplatin,IV Push,1st,13:20,13:30; Carfilzomib,IV Push,2nd,13:30,13:35                                   | 96409; 96409-59              |
            | 4A: Chemo IV site 1, chemo IV site 2                                  | Single           | Multiple Sites | Oxaliplatin,IV Push,1st,13:20,13:30; Carfilzomib,IV Push,2nd,13:30,13:35                                   | 96409; 96409-59              |
            | 4B: Non-chemo IV site 1, chemo IV site 2                              | System Generated | Multiple Sites | Leucovorin,IV Push,1st,13:20,13:30; Cidofovir,IV Push,2nd,13:30,13:35                                      | 96374; 96374-59              |
            | 4B: Non-chemo IV site 1, chemo IV site 2                              | Single           | Multiple Sites | Leucovorin,IV Push,1st,13:20,13:30; Cidofovir,IV Push,2nd,13:30,13:35                                      | 96374; 96374-59              |
            | 4C: Non-chemo IV site 1, non-chemo IV site 2                          | System Generated | Multiple Sites | Leucovorin,IV Push,1st,13:20,13:30; Oxaliplatin,IV Push,2nd,13:30,13:35                                    | 96409-59; 96374              |
            | 4C: Non-chemo IV site 1, non-chemo IV site 2                          | Single           | Multiple Sites | Leucovorin,IV Push,1st,13:20,13:30; Oxaliplatin,IV Push,2nd,13:30,13:35                                    | 96409-59; 96374              |
            | 5: Chemo Inf site 1, chemo IV site 1                                  | System Generated | Single Site    | Oxaliplatin,Infusion,1st,12:30,15:30; Carfilzomib,IV Push,1st,15:30,15:35                                  | 96413; 96415:2; 96411        |
            | 5: Chemo Inf site 1, chemo IV site 1                                  | Single           | Single Site    | Oxaliplatin,Infusion,1st,12:30,15:30; Carfilzomib,IV Push,1st,15:30,15:35                                  | 96413; 96415:2; 96411        |
            | 6: Chemo Inf site 1, non-chemo IV site 1                              | System Generated | Single Site    | Oxaliplatin,Infusion,1st,12:30,13:30; Cidofovir,IV Push,1st,13:30,13:35                                    | 96413; 96375                 |
            | 6: Chemo Inf site 1, non-chemo IV site 1                              | Single           | Single Site    | Oxaliplatin,Infusion,1st,12:30,13:30; Cidofovir,IV Push,1st,13:30,13:35                                    | 96413; 96375                 |
            | 9: Non-chemo Inf, non-chemo IV, non-chemo IV of new drug all site 1   | System Generated | Single Site    | Cidofovir,Infusion,1st,12:30,15:30; Leucovorin,IV Push,1st,15:30,15:40; Albumin,IV Push,1st,15:40,15:50    | 96365; 96366:2; 96375:2      |
            | 9: Non-chemo Inf, non-chemo IV, non-chemo IV of new drug all site 1   | Single           | Single Site    | Cidofovir,Infusion,1st,12:30,15:30; Leucovorin,IV Push,1st,15:30,15:40; Albumin,IV Push,1st,15:40,15:50    | 96365; 96366:2; 96375:2      |
            | 10: Non-chemo Inf, non-chemo IV, non-chemo IV of same drug all site 1 | System Generated | Single Site    | Cidofovir,Infusion,1st,12:30,15:30; Leucovorin,IV Push,1st,15:30,15:40; Leucovorin,IV Push,1st,16:20,16:30 | 96365; 96366:2; 96375; 96376 |
            | 10: Non-chemo Inf, non-chemo IV, non-chemo IV of same drug all site 1 | Single           | Single Site    | Cidofovir,Infusion,1st,12:30,15:30; Leucovorin,IV Push,1st,15:30,15:40; Leucovorin,IV Push,1st,16:20,16:30 | 96365; 96366:2; 96375; 96376 |

    @infusion
    Scenario Outline: DEV-51541: Hydration checked - Multiple primary services
        When I select "ChargeInfusion" from the "Patient List" menu
        And patient "Roy Blazer" has no charges
        And I select patient "Roy Blazer" from the patient list
        And I select "Charges" from clinical navigation
        And I select "Most Recent Visit" from the "Clinical Timeframe" menu
        And I select "Add Charge" from the "Patient Header Actions" menu
        And I set the following charge headers
            |Name         |Value            |
            |Bill Area    |Verve            |
            |Svc Site     |Inpatient        |
        And I click the "Infusion" button in the "Charge Entry" pane
        And I select "<Infusion Type>" from the "Infusion Type" pkdropdown
        And I select "<Access Type>" from the "Access Type" pkdropdown
        And I check the "Separate Hydration Order on File" checkbox
        And I add the infusion input "<Input>"
        And I close the infusion screen
        Then the "Charge Entry" pane should load within "1" second
        And I click the "Submit" button
        And the "Charge Entry" pane should close within "10" second
        When I uncheck the "Show Visits" checkbox
        And I sort the "Charges" table chronologically by the "Date/Time" column in "Descending" order
        Then the codes "<Codes>" should appear in the charges table

        Examples:
            | Test Name                                               | Infusion Type    | Access Type    | Input                                                                                                                 | Codes                          |
          #		| 7: Chemo IV, Non-chemo infusion and hydration in site 1 | System Generated | Single Site    | Leucovorin,Infusion,1st,12:30,15:30; Oxaliplatin,IV Push,1st,12:20,12:30; Hydration Services,Infusion,1st,10:30,12:20 | 96366:2; 96409; 96361:2; 96367 |
            | 7: Chemo IV, Non-chemo infusion and hydration in site 1 | Sequential       | Single Site    | Leucovorin,Infusion,1st,12:30,15:30; Oxaliplatin,IV Push,1st,12:20,12:30; Hydration Services,Infusion,1st,10:30,12:20 | 96366:2; 96409; 96361:2; 96367 |
            | 8: Non-chemo IV site 1, hydration in site 2             | System Generated | Multiple Sites | Leucovorin,IV Push,1st,12:30,12:40; Hydration Services,Infusion,2nd,11:40,12:30                                       | 96374; 96360-59                |
            | 8: Non-chemo IV site 1, hydration in site 2             | Single           | Multiple Sites | Leucovorin,IV Push,1st,12:30,12:40; Hydration Services,Infusion,2nd,11:40,12:30                                       | 96374; 96360-59                |

    @infusion
    Scenario Outline: DEV-51945 and DEV-51926: Expand logic for subsequent push of same drug
        When I select "ChargeInfusion" from the "Patient List" menu
        And patient "Roy Blazer" has no charges
        And I select patient "Roy Blazer" from the patient list
        And I select "Charges" from clinical navigation
        And I select "Most Recent Visit" from the "Clinical Timeframe" menu
        And I select "Add Charge" from the "Patient Header Actions" menu
        And I set the following charge headers
            |Name         |Value            |
            |Bill Area    |Verve            |
            |Svc Site     |Inpatient        |
        And I click the "Infusion" button in the "Charge Entry" pane
        And I select "<Infusion Type>" from the "Infusion Type" pkdropdown
        And I select "<Access Type>" from the "Access Type" pkdropdown
        And I uncheck the "Separate Hydration Order on File" checkbox
        And I add the infusion input "<Input>"
        And I close the infusion screen
        Then the "Charge Entry" pane should load within "1" second
        And I click the "Submit" button
        And the "Charge Entry" pane should close within "10" second
        When I uncheck the "Show Visits" checkbox
        And I sort the "Charges" table chronologically by the "Date/Time" column in "Descending" order
        Then the codes "<Codes>" should appear in the charges table

        Examples:
            | Test Name                                                                   | Infusion Type    | Access Type | Input                                                                                                                                                               | Codes                      |
            | 1: Non-chemo Inf followed by IV of same drug > 30 min later                 | System Generated | Single Site | Diphenhydramine,Infusion,1st,10:00,11:20; Diphenhydramine,IV Push,1st,12:00,12:05                                                                                   | 96365; 96376               |
            | 1: Non-chemo Inf followed by IV of same drug > 30 min later                 | Single           | Single Site | Diphenhydramine,Infusion,1st,10:00,11:20; Diphenhydramine,IV Push,1st,12:00,12:05                                                                                   | 96365; 96376               |
            | 2: Non-chemo Inf followed by IV of same drug < 30 min later                 | System Generated | Single Site | Diphenhydramine,Infusion,1st,10:00,11:20; Diphenhydramine,IV Push,1st,11:30,11:35                                                                                   | 96365                      |
            | 2: Non-chemo Inf followed by IV of same drug < 30 min later                 | Single           | Single Site | Diphenhydramine,Infusion,1st,10:00,11:20; Diphenhydramine,IV Push,1st,11:30,11:35                                                                                   | 96365                      |
            | 3: Non-chemo IV followed by Inf of same drug < 30 min later                 | System Generated | Single Site | Diphenhydramine,IV Push,1st,10:00,10:15; Diphenhydramine,Infusion,1st,11:00,11:35                                                                                   | 96376; 96365               |
            | 3: Non-chemo IV followed by Inf of same drug < 30 min later                 | Single           | Single Site | Diphenhydramine,IV Push,1st,10:00,10:15; Diphenhydramine,Infusion,1st,11:00,11:35                                                                                   | 96376; 96365               |
            | 3A: 3 IV of same drug, 2 < 30 min apart                                     | System Generated | Single Site | Diphenhydramine,IV Push,1st,08:45,08:50; Diphenhydramine,IV Push,1st,10:15,10:20; Diphenhydramine,IV Push,1st,10:30,10:35                                           | 96374; 96376               |
            | 3A: 3 IV of same drug, 2 < 30 min apart                                     | Single           | Single Site | Diphenhydramine,IV Push,1st,08:45,08:50; Diphenhydramine,IV Push,1st,10:15,10:20; Diphenhydramine,IV Push,1st,10:30,10:35                                           | 96374; 96376               |
            | 7: IV, Inf, IV of same drug, all > 30 min apart                             | System Generated | Single Site | Diphenhydramine,IV Push,1st,08:45,08:50; Diphenhydramine,Infusion,1st,10:15,11:00; Diphenhydramine,IV Push,1st,12:00,12:10                                          | 96365; 96376:2             |
            | 7: IV, Inf, IV of same drug, all > 30 min apart                             | Single           | Single Site | Diphenhydramine,IV Push,1st,08:45,08:50; Diphenhydramine,Infusion,1st,10:15,11:00; Diphenhydramine,IV Push,1st,12:00,12:10                                          | 96365; 96376:2             |
            | 8: IV, Inf, IV of same drug, all < 30 min apart                             | System Generated | Single Site | Diphenhydramine,IV Push,1st,10:00,10:05; Diphenhydramine,Infusion,1st,10:15,11:00; Diphenhydramine,IV Push,1st,11:01,11:05                                          | 96365                      |
            | 8: IV, Inf, IV of same drug, all < 30 min apart                             | Single           | Single Site | Diphenhydramine,IV Push,1st,10:00,10:05; Diphenhydramine,Infusion,1st,10:15,11:00; Diphenhydramine,IV Push,1st,11:01,11:05                                          | 96365                      |
            | 9: IV, IV, Inf, IV of same drug, all > 30 min apart                         | System Generated | Single Site | Diphenhydramine,IV Push,1st,10:00,10:05; Diphenhydramine,IV Push,1st,10:45,10:50; Diphenhydramine,Infusion,1st,11:30,13:15; Diphenhydramine,IV Push,1st,13:50,13:55 | 96365; 96366; 96376:3      |
            | 9: IV, IV, Inf, IV of same drug, all > 30 min apart                         | Single           | Single Site | Diphenhydramine,IV Push,1st,10:00,10:05; Diphenhydramine,IV Push,1st,10:45,10:50; Diphenhydramine,Infusion,1st,11:30,13:15; Diphenhydramine,IV Push,1st,13:50,13:55 | 96365; 96366; 96376:3      |
            | 10: IV, IV, Inf, IV of same drug, all < 30 min apart                        | System Generated | Single Site | Diphenhydramine,IV Push,1st,10:00,10:05; Diphenhydramine,IV Push,1st,10:06,10:11; Diphenhydramine,Infusion,1st,10:15,11:00; Diphenhydramine,IV Push,1st,11:01,11:05 | 96365                      |
            | 10: IV, IV, Inf, IV of same drug, all < 30 min apart                        | Single           | Single Site | Diphenhydramine,IV Push,1st,10:00,10:05; Diphenhydramine,IV Push,1st,10:06,10:11; Diphenhydramine,Infusion,1st,10:15,11:00; Diphenhydramine,IV Push,1st,11:01,11:05 | 96365                      |
            | 11: IV, IV, Inf, IV of same drug, mixed times                               | System Generated | Single Site | Diphenhydramine,IV Push,1st,09:25,09:30; Diphenhydramine,IV Push,1st,09:40,09:50; Diphenhydramine,Infusion,1st,10:15,11:00; Diphenhydramine,IV Push,1st,11:35,11:40 | 96365; 96376:2             |
            | 11: IV, IV, Inf, IV of same drug, mixed times                               | Single           | Single Site | Diphenhydramine,IV Push,1st,09:25,09:30; Diphenhydramine,IV Push,1st,09:40,09:50; Diphenhydramine,Infusion,1st,10:15,11:00; Diphenhydramine,IV Push,1st,11:35,11:40 | 96365; 96376:2             |
            | 12: Inf, IV of same drug with Inf of different drug in between              | System Generated | Single Site | Oxaliplatin,Infusion,1st,09:00,10:50; Diphenhydramine,Infusion,1st,11:00,12:00; Oxaliplatin,IV Push,1st,12:01,12:05                                                 | 96413; 96415; 96367; 96411 |
            | 12: Inf, IV of same drug with Inf of different drug in between              | Sequential       | Single Site | Oxaliplatin,Infusion,1st,09:00,10:50; Diphenhydramine,Infusion,1st,11:00,12:00; Oxaliplatin,IV Push,1st,12:01,12:05                                                 | 96413; 96415; 96367; 96411 |
            | 13: IV, Inf of same drug with Inf of different drug in between              | System Generated | Single Site | Cidofovir,IV Push,1st,09:00,09:05; Diphenhydramine,Infusion,1st,09:10,11:00; Cidofovir,Infusion,1st,11:01,12:00                                                     | 96376; 96365; 96366; 96367 |
            | 13: IV, Inf of same drug with Inf of different drug in between              | Single           | Single Site | Cidofovir,IV Push,1st,09:00,09:05; Diphenhydramine,Infusion,1st,09:10,11:00; Cidofovir,Infusion,1st,11:01,12:00                                                     | 96376; 96365; 96366; 96367 |
            #Regression tests
            | 4: Chemo Inf followed by non-chemo IV A and 2 non-chemo IV B > 30 min apart | System Generated | Single Site | Oxaliplatin,Infusion,1st,10:00,11:20; Cidofovir,IV Push,1st,11:30,11:35; Diphenhydramine,IV Push,1st,11:35,11:40; Diphenhydramine,IV Push,1st,12:30,12:40           | 96413; 96375:2; 96376      |
            | 4: Chemo Inf followed by non-chemo IV A and 2 non-chemo IV B > 30 min apart | Single           | Single Site | Oxaliplatin,Infusion,1st,10:00,11:20; Cidofovir,IV Push,1st,11:30,11:35; Diphenhydramine,IV Push,1st,11:35,11:40; Diphenhydramine,IV Push,1st,12:30,12:40           | 96413; 96375:2; 96376      |
            | 5: Chemo Inf followed by non-chemo IV A and 2 non-chemo IV B < 30 min apart | System Generated | Single Site | Oxaliplatin,Infusion,1st,10:00,11:20; Cidofovir,IV Push,1st,11:30,11:35; Diphenhydramine,IV Push,1st,11:35,11:40; Diphenhydramine,IV Push,1st,11:40,11:50           | 96413; 96375:2             |
            | 5: Chemo Inf followed by non-chemo IV A and 2 non-chemo IV B < 30 min apart | Single           | Single Site | Oxaliplatin,Infusion,1st,10:00,11:20; Cidofovir,IV Push,1st,11:30,11:35; Diphenhydramine,IV Push,1st,11:35,11:40; Diphenhydramine,IV Push,1st,11:40,11:50           | 96413; 96375:2             |
            | 6: Non-chemo Inf followed by non-chemo IV of different drug                 | System Generated | Single Site | Cidofovir,Infusion,1st,10:00,11:20; Diphenhydramine,IV Push,1st,11:30,11:35                                                                                         | 96365; 96375               |
            | 6: Non-chemo Inf followed by non-chemo IV of different drug                 | Single           | Single Site | Cidofovir,Infusion,1st,10:00,11:20; Diphenhydramine,IV Push,1st,11:30,11:35                                                                                         | 96365; 96375               |

    @infusion
    Scenario Outline: DEV-53184: Combine split infusions
        When I select "ChargeInfusion" from the "Patient List" menu
        And patient "Roy Blazer" has no charges
        And I select patient "Roy Blazer" from the patient list
        And I select "Charges" from clinical navigation
        And I select "Most Recent Visit" from the "Clinical Timeframe" menu
        And I select "Add Charge" from the "Patient Header Actions" menu
        And I set the following charge headers
            |Name         |Value            |
            |Bill Area    |Verve            |
            |Svc Site     |Inpatient        |
        And I click the "Infusion" button in the "Charge Entry" pane
        And I select "<Infusion Type>" from the "Infusion Type" pkdropdown
        And I select "<Access Type>" from the "Access Type" pkdropdown
        And I uncheck the "Separate Hydration Order on File" checkbox
        And I add the infusion input "<Input>"
        And I close the infusion screen
        Then the "Charge Entry" pane should load within "1" second
        And I click the "Submit" button
        And the "Charge Entry" pane should close within "10" second
        When I uncheck the "Show Visits" checkbox
        And I sort the "Charges" table chronologically by the "Date/Time" column in "Descending" order
        Then the codes "<Codes>" should appear in the charges table

        Examples:
            | Test Name                                                                | Infusion Type    | Access Type    | Input                                                                                                                   | Codes               |
            | 1: Split infusion of the same drug (1 short and 1 long)                  | System Generated | Single Site    | Oxaliplatin,Infusion,1st,09:40,09:50; Oxaliplatin,Infusion,1st,09:50,10:20                                              | 96413               |
            | 1: Split infusion of the same drug (1 short and 1 long)                  | Single           | Single Site    | Oxaliplatin,Infusion,1st,09:40,09:50; Oxaliplatin,Infusion,1st,09:50,10:20                                              | 96413               |
            | 2: Split infusion of the same drug (2 short)                             | System Generated | Single Site    | Leucovorin,Infusion,1st,09:40,09:50; Leucovorin,Infusion,1st,09:50,10:00                                                | 96365               |
            | 2: Split infusion of the same drug (2 short)                             | Single           | Single Site    | Leucovorin,Infusion,1st,09:40,09:50; Leucovorin,Infusion,1st,09:50,10:00                                                | 96365               |
            | 3: Split infusion of the same drug (2 long)                              | System Generated | Single Site    | Oxaliplatin,Infusion,1st,09:40,10:25; Oxaliplatin,Infusion,1st,10:25,11:15                                              | 96413; 96415        |
            | 3: Split infusion of the same drug (2 long)                              | Single           | Single Site    | Oxaliplatin,Infusion,1st,09:40,10:25; Oxaliplatin,Infusion,1st,10:25,11:15                                              | 96413; 96415        |
            | 4: Split infusion of the same drug (3 parts)                             | System Generated | Single Site    | Oxaliplatin,Infusion,1st,09:40,09:45; Oxaliplatin,Infusion,1st,09:45,11:15; Oxaliplatin,Infusion,1st,11:15,13:25        | 96413; 96415:3      |
            | 4: Split infusion of the same drug (3 parts)                             | Single           | Single Site    | Oxaliplatin,Infusion,1st,09:40,09:45; Oxaliplatin,Infusion,1st,09:45,11:15; Oxaliplatin,Infusion,1st,11:15,13:25        | 96413; 96415:3      |
            | 5: Split infusion of the same drug, infusion of a new drug               | System Generated | Single Site    | Oxaliplatin,Infusion,1st,09:40,09:55; Oxaliplatin,Infusion,1st,09:55,10:05; Bevacizub,Infusion,1st,10:10,12:15          | 96413; 96417; 96415 |
            | 5: Split infusion of the same drug, infusion of a new drug               | Sequential       | Single Site    | Oxaliplatin,Infusion,1st,09:40,09:55; Oxaliplatin,Infusion,1st,09:55,10:05; Bevacizub,Infusion,1st,10:10,12:15          | 96413; 96417; 96415 |
            | 6: Infusion of a drug, split infusion of a different drug                | System Generated | Single Site    | Leucovorin,Infusion,1st,09:40,10:30; Diphenhydramine,Infusion,1st,10:40,10:50; Diphenhydramine,Infusion,1st,10:50,12:35 | 96365; 96367; 96366 |
            | 6: Infusion of a drug, split infusion of a different drug                | Sequential       | Single Site    | Leucovorin,Infusion,1st,09:40,10:30; Diphenhydramine,Infusion,1st,10:40,10:50; Diphenhydramine,Infusion,1st,10:50,12:35 | 96365; 96367; 96366 |
            | 7: Concurrent infusion of two drugs in same site, one split              | System Generated | Single Site    | Leucovorin,Infusion,1st,09:40,10:40; Diphenhydramine,Infusion,1st,09:40,10:25; Diphenhydramine,Infusion,1st,10:25,10:45 | 96365; 96368        |
            | 7: Concurrent infusion of two drugs in same site, one split              | Concurrent       | Single Site    | Leucovorin,Infusion,1st,09:40,10:40; Diphenhydramine,Infusion,1st,09:40,10:25; Diphenhydramine,Infusion,1st,10:25,10:45 | 96365; 96368        |
            | 8: Concurrent infusion of two drugs in different site, one split         | System Generated | Multiple Sites | Leucovorin,Infusion,1st,09:40,10:40; Diphenhydramine,Infusion,2nd,09:40,10:25; Diphenhydramine,Infusion,2nd,10:25,10:45 | 96365; 96365-59     |
            | 8: Concurrent infusion of two drugs in different site, one split         | Sequential       | Multiple Sites | Leucovorin,Infusion,1st,09:40,10:40; Diphenhydramine,Infusion,2nd,09:40,10:25; Diphenhydramine,Infusion,2nd,10:25,10:45 | 96365; 96365-59     |
            | 9: Infusion of same drug that previously had rule 6 applied              | System Generated | Single Site    | Leucovorin,Infusion,1st,09:40,10:40; Diphenhydramine,Infusion,1st,09:40,10:45; Diphenhydramine,Infusion,1st,11:30,12:15 | 96365; 96368        |
            | 9: Infusion of same drug that previously had rule 6 applied              | Concurrent       | Single Site    | Leucovorin,Infusion,1st,09:40,10:40; Diphenhydramine,Infusion,1st,09:40,10:45; Diphenhydramine,Infusion,1st,11:30,12:15 | 96365; 96368        |
            | 10: Split IA infusion                                                    | System Generated | Single Site    | Oxaliplatin,IA Infusion,1st,09:40,09:50; Oxaliplatin,IA Infusion,1st,09:50,11:20                                        | 96422; 96423        |
            | 10: Split IA infusion                                                    | Single           | Single Site    | Oxaliplatin,IA Infusion,1st,09:40,09:50; Oxaliplatin,IA Infusion,1st,09:50,11:20                                        | 96422; 96423        |
            | 11: Two short infusions of the same drug >0 minute apart                 | System Generated | Single Site    | Oxaliplatin,Infusion,1st,09:40,09:50; Oxaliplatin,Infusion,1st,09:51,10:05                                              | 96409               |
            | 11: Two short infusions of the same drug >0 minute apart                 | Single           | Single Site    | Oxaliplatin,Infusion,1st,09:40,09:50; Oxaliplatin,Infusion,1st,09:51,10:05                                              | 96409               |
            | 12: Two long infusions of the same drug >0 minute apart                  | System Generated | Single Site    | Oxaliplatin,Infusion,1st,09:40,10:30; Oxaliplatin,Infusion,1st,10:33,12:00                                              | 96413; 96415        |
            | 12: Two long infusions of the same drug >0 minute apart                  | Sequential       | Single Site    | Oxaliplatin,Infusion,1st,09:40,10:30; Oxaliplatin,Infusion,1st,10:33,12:00                                              | 96413; 96415        |
            | 13: Two infusions (1 long and 1 short) of the same drug >0 minutes apart | System Generated | Single Site    | Oxaliplatin,Infusion,1st,09:40,10:30; Oxaliplatin,Infusion,1st,11:05,11:15                                              | 96413; 96411        |
            | 13: Two infusions (1 long and 1 short) of the same drug >0 minutes apart | Single           | Single Site    | Oxaliplatin,Infusion,1st,09:40,10:30; Oxaliplatin,Infusion,1st,11:05,11:15                                              | 96413; 96411        |
            | 14: Two infusions of a different drug 0 minutes apart                    | System Generated | Single Site    | Oxaliplatin,Infusion,1st,09:10,09:50; Bevacizub,Infusion,1st,09:50,10:20                                                | 96413; 96417        |
            | 14: Two infusions of a different drug 0 minutes apart                    | Sequential       | Single Site    | Oxaliplatin,Infusion,1st,09:10,09:50; Bevacizub,Infusion,1st,09:50,10:20                                                | 96413; 96417        |
            | 15: Split infusion of the same drug in different sites                   | System Generated | Multiple Sites | Oxaliplatin,Infusion,1st,09:10,09:50; Oxaliplatin,Infusion,2nd,09:50,10:20                                              | 96413-59; 96413     |
            | 15: Split infusion of the same drug in different sites                   | Sequential       | Multiple Sites | Oxaliplatin,Infusion,1st,09:10,09:50; Oxaliplatin,Infusion,2nd,09:50,10:20                                              | 96413-59; 96413     |

    @infusion
    Scenario Outline: DEV-53163: Do not bill for hydration that overlaps with other hydration.  Hydration checked.
        When I select "ChargeInfusion" from the "Patient List" menu
        And patient "Roy Blazer" has no charges
        And I select patient "Roy Blazer" from the patient list
        And I select "Charges" from clinical navigation
        And I select "Most Recent Visit" from the "Clinical Timeframe" menu
        And I select "Add Charge" from the "Patient Header Actions" menu
        And I set the following charge headers
            |Name         |Value            |
            |Bill Area    |Verve            |
            |Svc Site     |Inpatient        |
        And I click the "Infusion" button in the "Charge Entry" pane
        And I select "<Infusion Type>" from the "Infusion Type" pkdropdown
        And I select "<Access Type>" from the "Access Type" pkdropdown
        And I check the "Separate Hydration Order on File" checkbox
        And I add the infusion input "<Input>"
        And I close the infusion screen
        Then the "Charge Entry" pane should load within "1" second
        And I click the "Submit" button
        And the "Charge Entry" pane should close within "10" second
        When I uncheck the "Show Visits" checkbox
        And I sort the "Charges" table chronologically by the "Date/Time" column in "Descending" order
        Then the codes "<Codes>" should appear in the charges table

        Examples:
            | Test Name                                                                | Infusion Type    | Access Type    | Input                                                                                                                                                                                                                                                                                                                        | Codes                                 |
            | 1: Hydration overlaps with hydration in same site                        | System Generated | Single Site    | Hydration Services,Infusion,1st,09:40,11:00; Hydration Services,Infusion,1st,09:45,10:50                                                                                                                                                                                                                                     | 96360                                 |
            | 1: Hydration overlaps with hydration in same site                        | Single           | Single Site    | Hydration Services,Infusion,1st,09:40,11:00; Hydration Services,Infusion,1st,09:45,10:50                                                                                                                                                                                                                                     | 96360                                 |
            | 2: Hydration overlaps with hydration in different site                   | System Generated | Multiple Sites | Hydration Services,Infusion,1st,09:40,11:00; Hydration Services,Infusion,2nd,09:45,10:50                                                                                                                                                                                                                                     | 96360; 96360-59                       |
            | 2: Hydration overlaps with hydration in different site                   | Single           | Multiple Sites | Hydration Services,Infusion,1st,09:40,11:00; Hydration Services,Infusion,2nd,09:45,10:50                                                                                                                                                                                                                                     | 96360; 96360-59                       |
            | 5: Hydration overlaps with hydration in different site, checkbox checked | System Generated | Multiple Sites | Hydration Services,Infusion,1st,09:00,11:15; Oxaliplatin,Infusion,1st,09:45,10:30; Hydration Services,Infusion,2nd,10:15,11:20                                                                                                                                                                                               | 96361:2; 96413; 96360-59              |
            | 5: Hydration overlaps with hydration in different site, checkbox checked | Single           | Multiple Sites | Hydration Services,Infusion,1st,09:00,11:15; Oxaliplatin,Infusion,1st,09:45,10:30; Hydration Services,Infusion,2nd,10:15,11:20                                                                                                                                                                                               | 96361:2; 96413; 96360-59              |
            | 6: Hydration overlaps with hydration and chemo infusion in same site     | System Generated | Single Site    | Hydration Services,Infusion,1st,09:40,11:00; Hydration Services,Infusion,1st,09:45,10:50; Oxaliplatin,Infusion,1st,09:45,10:30                                                                                                                                                                                               | 96361; 96413                          |
            | 6: Hydration overlaps with hydration and chemo infusion in same site     | Single           | Single Site    | Hydration Services,Infusion,1st,09:40,11:00; Hydration Services,Infusion,1st,09:45,10:50; Oxaliplatin,Infusion,1st,09:45,10:30                                                                                                                                                                                               | 96361; 96413                          |
            | 7: Failed test case from client                                          | System Generated | Single Site    | Normal Saline Solution,Infusion,1st,09:43,14:15; Hydration Services,Infusion,1st,09:44,14:10; Heparin IV,IV Push,1st,14:45,14:46                                                                                                                                                                                             | 96361:5; 96374                        |
            | 7: Failed test case from client                                          | Single           | Single Site    | Normal Saline Solution,Infusion,1st,09:43,14:15; Hydration Services,Infusion,1st,09:44,14:10; Heparin IV,IV Push,1st,14:45,14:46                                                                                                                                                                                             | 96361:5; 96374                        |
            | 8: DEV-54796 Stop time of first Hyd is start time of second Hyd          | System Generated | Single Site    | Normal Saline Solution,Infusion,1st,07:58,09:58; Diphenhydramine,IV Push,1st,10:58,11:00; Mesna,Infusion,1st,10:33,10:48; Mesna,Infusion,1st,13:44,14:00; Mesna,Infusion,1st,16:34,16:50; Cyclophosphamide,Infusion,1st,11:14,12:40; Fosaprepitant,Infusion,1st,09:18,09:48; Normal Saline Solution,Infusion,1st,09:58,16:50 | 96361:6; 96375; 96367:2; 96376; 96413 |
            | 8: DEV-54796 Stop time of first Hyd is start time of second Hyd          | Sequential       | Single Site    | Normal Saline Solution,Infusion,1st,07:58,09:58; Diphenhydramine,IV Push,1st,10:58,11:00; Mesna,Infusion,1st,10:33,10:48; Mesna,Infusion,1st,13:44,14:00; Mesna,Infusion,1st,16:34,16:50; Cyclophosphamide,Infusion,1st,11:14,12:40; Fosaprepitant,Infusion,1st,09:18,09:48; Normal Saline Solution,Infusion,1st,09:58,16:50 | 96361:6; 96375; 96367:2; 96376; 96413 |


    @infusion
    Scenario Outline: DEV-53163: Do not bill for hydration that overlaps with other hydration.  Hydration unchecked.
        When I select "ChargeInfusion" from the "Patient List" menu
        And patient "Roy Blazer" has no charges
        And I select patient "Roy Blazer" from the patient list
        And I select "Charges" from clinical navigation
        And I select "Most Recent Visit" from the "Clinical Timeframe" menu
        And I select "Add Charge" from the "Patient Header Actions" menu
        And I set the following charge headers
            | Name      | Value     |
            | Bill Area | Verve     |
            | Svc Site  | Inpatient |
        And I click the "Infusion" button in the "Charge Entry" pane
        And I select "<Infusion Type>" from the "Infusion Type" pkdropdown
        And I select "<Access Type>" from the "Access Type" pkdropdown
        And I uncheck the "Separate Hydration Order on File" checkbox
        And I add the infusion input "<Input>"
        And I close the infusion screen
        Then the "Charge Entry" pane should load within "1" second
        And I click the "Submit" button
        And the "Charge Entry" pane should close within "10" second
        When I uncheck the "Show Visits" checkbox
        And I sort the "Charges" table chronologically by the "Date/Time" column in "Descending" order
        Then the codes "<Codes>" should appear in the charges table

        Examples:
            | Test Name                                                                    | Infusion Type    | Access Type    | Input                                                                                                                          | Codes        |
            | 3: Hydration overlaps with hydration in same site, checkbox not checked      | System Generated | Single Site    | Hydration Services,Infusion,1st,09:40,11:00; Hydration Services,Infusion,1st,09:45,10:50; Bevacizub,Infusion,1st,11:01,12:01   | 96413        |
            | 3: Hydration overlaps with hydration in same site, checkbox not checked      | Single           | Single Site    | Hydration Services,Infusion,1st,09:40,11:00; Hydration Services,Infusion,1st,09:45,10:50; Bevacizub,Infusion,1st,11:01,12:01   | 96413        |
            | 4: Hydration overlaps with hydration in different site, checkbox not checked | System Generated | Multiple Sites | Hydration Services,Infusion,1st,09:00,11:00; Oxaliplatin,Infusion,1st,09:45,11:20; Hydration Services,Infusion,2nd,10:15,11:30 | 96413; 96415 |
            | 4: Hydration overlaps with hydration in different site, checkbox not checked | Single           | Multiple Sites | Hydration Services,Infusion,1st,09:00,11:00; Oxaliplatin,Infusion,1st,09:45,11:20; Hydration Services,Infusion,2nd,10:15,11:30 | 96413; 96415 |

    @infusion
    Scenario Outline: DEV-53004 - Bill pushes >15 minutes as a single push code
        When I select "ChargeInfusion" from the "Patient List" menu
        And patient "Roy Blazer" has no charges
        And I select patient "Roy Blazer" from the patient list
        And I select "Charges" from clinical navigation
        And I select "Most Recent Visit" from the "Clinical Timeframe" menu
        And I select "Add Charge" from the "Patient Header Actions" menu
        And I set the following charge headers
            | Name      | Value     |
            | Bill Area | Verve     |
            | Svc Site  | Inpatient |
        And I click the "Infusion" button in the "Charge Entry" pane
        And I select "<Infusion Type>" from the "Infusion Type" pkdropdown
        And I select "<Access Type>" from the "Access Type" pkdropdown
        And I uncheck the "Separate Hydration Order on File" checkbox
        And I add the infusion input "<Input>"
        And I close the infusion screen
        Then the "Charge Entry" pane should load within "1" second
        And I click the "Submit" button
        And the "Charge Entry" pane should close within "10" second
        When I uncheck the "Show Visits" checkbox
        And I sort the "Charges" table chronologically by the "Date/Time" column in "Descending" order
        Then the codes "<Codes>" should appear in the charges table

        Examples:
            | Test Name                                                                               | Infusion Type    | Access Type    | Input                                                                         | Codes                    |
            | 1: Long chemo IV push                                                                   | System Generated | Single Site    | Paclitaxel,IV Push,1st,09:40,10:20                                            | 96409                    |
            | 1: Long chemo IV push                                                                   | Single           | Single Site    | Paclitaxel,IV Push,1st,09:40,10:20                                            | 96409                    |
            | 2: Long non-chemo IV push                                                               | System Generated | Single Site    | Dexamethasone,IV Push,1st,09:40,10:20                                         | 96374                    |
            | 2: Long non-chemo IV push                                                               | Single           | Single Site    | Dexamethasone,IV Push,1st,09:40,10:20                                         | 96374                    |
            | 3: Long chemo IA push                                                                   | System Generated | Single Site    | Paclitaxel,IA Push,1st,09:40,10:20                                            | 96420                    |
            | 3: Long chemo IA push                                                                   | Single           | Single Site    | Paclitaxel,IA Push,1st,09:40,10:20                                            | 96420                    |
            | 6: Chemo IV push followed by long chemo IV push of same drug >30 minutes later          | System Generated | Single Site    | Paclitaxel,IV Push,1st,09:40,09:50; Paclitaxel,IV Push,1st,10:30,10:55        | 96409; 96411             |
            | 6: Chemo IV push followed by long chemo IV push of same drug >30 minutes later          | Single           | Single Site    | Paclitaxel,IV Push,1st,09:40,09:50; Paclitaxel,IV Push,1st,10:30,10:55        | 96409; 96411             |
            | 7: Non-chemo IV push followed by long non-chemo IV push of same drug <30 minutes later  | System Generated | Single Site    | Dexamethasone,IV Push,1st,09:40,09:50; Dexamethasone,IV Push,1st,10:15,10:40  | 96374                    |
            | 7: Non-chemo IV push followed by long non-chemo IV push of same drug <30 minutes later  | Single           | Single Site    | Dexamethasone,IV Push,1st,09:40,09:50; Dexamethasone,IV Push,1st,10:15,10:40  | 96374                    |
            | 8: Chemo infusion followed by long chemo IV push of same drug <30 minutes later         | System Generated | Single Site    | Paclitaxel,Infusion,1st,09:00,09:50; Paclitaxel,IV Push,1st,10:15,10:40       | 96413                    |
            | 8: Chemo infusion followed by long chemo IV push of same drug <30 minutes later         | Single           | Single Site    | Paclitaxel,Infusion,1st,09:00,09:50; Paclitaxel,IV Push,1st,10:15,10:40       | 96413                    |
            | 9: Non-chemo infusion followed by long non-chemo IV push of same drug >30 minutes later | System Generated | Single Site    | Dexamethasone,Infusion,1st,09:00,09:50; Dexamethasone,IV Push,1st,10:30,10:55 | 96365; 96376             |
            | 9: Non-chemo infusion followed by long non-chemo IV push of same drug >30 minutes later | Single           | Single Site    | Dexamethasone,Infusion,1st,09:00,09:50; Dexamethasone,IV Push,1st,10:30,10:55 | 96365; 96376             |
            | 10: Multiple primary services                                                           | System Generated | Multiple Sites | Oxaliplatin,Infusion,1st,12:30,15:30; Carfilzomib,IV Push,2nd,15:30,15:50     | 96413; 96415:2; 96409-59 |
            | 10: Multiple primary services                                                           | Single           | Multiple Sites | Oxaliplatin,Infusion,1st,12:30,15:30; Carfilzomib,IV Push,2nd,15:30,15:50     | 96413; 96415:2; 96409-59 |
            | 11: Long chemo IV push and chemo infusion                                               | System Generated | Single Site    | Paclitaxel,Infusion,1st,09:00,09:50; Oxaliplatin,IV Push,1st,08:30,08:55      | 96413; 96411             |
            | 11: Long chemo IV push and chemo infusion                                               | Single           | Single Site    | Paclitaxel,Infusion,1st,09:00,09:50; Oxaliplatin,IV Push,1st,08:30,08:55      | 96413; 96411             |
            | 12: Short chemo infusion                                                                | System Generated | Single Site    | Paclitaxel,Infusion,1st,09:40,09:50                                           | 96409                    |
            | 12: Short chemo infusion                                                                | Single           | Single Site    | Paclitaxel,Infusion,1st,09:40,09:50                                           | 96409                    |

    @infusion
    Scenario Outline: DEV-53162 - Remove Infusion Type check for rule 5 (infusion of a new drug)
        When I select "ChargeInfusion" from the "Patient List" menu
        And patient "Roy Blazer" has no charges
        And I select patient "Roy Blazer" from the patient list
        And I select "Charges" from clinical navigation
        And I select "Most Recent Visit" from the "Clinical Timeframe" menu
        And I select "Add Charge" from the "Patient Header Actions" menu
        And I set the following charge headers
            | Name      | Value     |
            | Bill Area | Verve     |
            | Svc Site  | Inpatient |
        And I click the "Infusion" button in the "Charge Entry" pane
        And I select "<Infusion Type>" from the "Infusion Type" pkdropdown
        And I select "<Access Type>" from the "Access Type" pkdropdown
        And I uncheck the "Separate Hydration Order on File" checkbox
        And I add the infusion input "<Input>"
        And I close the infusion screen
        Then the "Charge Entry" pane should load within "1" second
        And I click the "Submit" button
        And the "Charge Entry" pane should close within "10" second
        When I uncheck the "Show Visits" checkbox
        And I sort the "Charges" table chronologically by the "Date/Time" column in "Descending" order
        Then the codes "<Codes>" should appear in the charges table

        Examples:
            | Test Name                                 | Infusion Type    | Access Type | Input                                                                                                                                                                                   | Codes                 |
            | 1: Chemo IV pushes and non-chemo infusion | System Generated | Single Site | Granisteron HCL,IV Push,1st,09:20,09:30; Dexamethasone,IV Push,1st,09:05,09:20; Zinecard,IV Push,1st,09:45,10:00; Doxorubicin,IV Push,1st,10:00,10:05; Reglan,Infusion,1st,10:05,10:25; | 96375:3; 96409; 96367 |
            | 1: Chemo IV pushes and non-chemo infusion | Single           | Single Site | Granisteron HCL,IV Push,1st,09:20,09:30; Dexamethasone,IV Push,1st,09:05,09:20; Zinecard,IV Push,1st,09:45,10:00; Doxorubicin,IV Push,1st,10:00,10:05; Reglan,Infusion,1st,10:05,10:25; | 96375:3; 96409; 96367 |

    @infusion
    Scenario Outline: DEV-52353 - Do not combine remaining time beyond first hour for IV Infusions and IA infusions
        When I select "ChargeInfusion" from the "Patient List" menu
        And patient "Roy Blazer" has no charges
        And I select patient "Roy Blazer" from the patient list
        And I select "Charges" from clinical navigation
        And I select "Most Recent Visit" from the "Clinical Timeframe" menu
        And I select "Add Charge" from the "Patient Header Actions" menu
        And I set the following charge headers
            | Name      | Value     |
            | Bill Area | Verve     |
            | Svc Site  | Inpatient |
        And I click the "Infusion" button in the "Charge Entry" pane
        And I select "<Infusion Type>" from the "Infusion Type" pkdropdown
        And I select "<Access Type>" from the "Access Type" pkdropdown
        And I uncheck the "Separate Hydration Order on File" checkbox
        And I add the infusion input "<Input>"
        And I close the infusion screen
        Then the "Charge Entry" pane should load within "1" second
        And I click the "Submit" button
        And the "Charge Entry" pane should close within "10" second
        When I uncheck the "Show Visits" checkbox
        And I sort the "Charges" table chronologically by the "Date/Time" column in "Descending" order
        Then the codes "<Codes>" should appear in the charges table

        Examples:
            | Test Name                                                                  | Infusion Type    | Access Type    | Input                                                                                                              | Codes                          |
            | 1: Chemo IV push and non-chemo infusion                                    | System Generated | Single Site    | Bevacizub,IV Push,1st,09:40,10:20                                                                                  | 96409                          |
            | 1: Chemo IV push and non-chemo infusion                                    | Single           | Single Site    | Bevacizub,IV Push,1st,09:40,10:20                                                                                  | 96409                          |
            | 1: Chemo IV infusion and chemo IA infusion in same site, sequentially      | System Generated | Single Site    | Bevacizub,Infusion,1st,09:00,11:00; Oxaliplatin,IA Infusion,1st,11:01,14:01                                        | 96413; 96415; 96423:3          |
            | 1: Chemo IV infusion and chemo IA infusion in same site, sequentially      | Sequential       | Single Site    | Bevacizub,Infusion,1st,09:00,11:00; Oxaliplatin,IA Infusion,1st,11:01,14:01                                        | 96413; 96415; 96423:3          |
            | 2: Chemo IV infusion and chemo IA infusion in multiple sites, concurrently | System Generated | Multiple Sites | Bevacizub,Infusion,1st,09:00,11:00; Oxaliplatin,IA Infusion,2nd,09:00,10:31                                        | 96413; 96415; 96422; 96423     |
            | 2: Chemo IV infusion and chemo IA infusion in multiple sites, concurrently | Concurrent       | Multiple Sites | Bevacizub,Infusion,1st,09:00,11:00; Oxaliplatin,IA Infusion,2nd,09:00,10:31                                        | 96413; 96415; 96422; 96423     |
            | 3: 2 chemo IV infusions of 2 drugs and 1 chemo IA infusion                 | System Generated | Single Site    | Bleomycin,Infusion,1st,09:00,11:00; Bevacizub,Infusion,1st,11:01,13:00; Oxaliplatin,IA Infusion,1st,13:00,15:45    | 96413; 96415:2; 96417; 96423:3 |
            | 3: 2 chemo IV infusions of 2 drugs and 1 chemo IA infusion                 | Sequential       | Single Site    | Bleomycin,Infusion,1st,09:00,11:00; Bevacizub,Infusion,1st,11:01,13:00; Oxaliplatin,IA Infusion,1st,13:00,15:45    | 96413; 96415:2; 96417; 96423:3 |
            | 4: 2 chemo IA infusions of 2 drugs and 1 chemo IV infusion                 | System Generated | Multiple Sites | Bevacizub,Infusion,1st,11:00,13:00; Oxaliplatin,IA Infusion,2nd,11:00,13:00; Bleomycin,IA Infusion,2nd,13:01,15:00 | 96413; 96415; 96422; 96423:3   |
            | 4: 2 chemo IA infusions of 2 drugs and 1 chemo IV infusion                 | Sequential       | Multiple Sites | Bevacizub,Infusion,1st,11:00,13:00; Oxaliplatin,IA Infusion,2nd,11:00,13:00; Bleomycin,IA Infusion,2nd,13:01,15:00 | 96413; 96415; 96422; 96423:3   |

    @infusion
    Scenario Outline: DEV-54561 - Combine multiple >15 minute administrations of the same drug into a single administration, applying time from multiple infusions to a first hour code if necessary
        When I select "ChargeInfusion" from the "Patient List" menu
        And patient "Roy Blazer" has no charges
        And I select patient "Roy Blazer" from the patient list
        And I select "Charges" from clinical navigation
        And I select "Most Recent Visit" from the "Clinical Timeframe" menu
        And I select "Add Charge" from the "Patient Header Actions" menu
        And I set the following charge headers
            | Name      | Value     |
            | Bill Area | Verve     |
            | Svc Site  | Inpatient |
        And I click the "Infusion" button in the "Charge Entry" pane
        And I select "<Infusion Type>" from the "Infusion Type" pkdropdown
        And I select "<Access Type>" from the "Access Type" pkdropdown
        And I uncheck the "Separate Hydration Order on File" checkbox
        And I add the infusion input "<Input>"
        And I close the infusion screen
        Then the "Charge Entry" pane should load within "1" second
        And I click the "Submit" button
        And the "Charge Entry" pane should close within "10" second
        When I uncheck the "Show Visits" checkbox
        And I sort the "Charges" table chronologically by the "Date/Time" column in "Descending" order
        Then the codes "<Codes>" should appear in the charges table

        Examples:
            | Test Name                                                           | Infusion Type    | Access Type    | Input                                                                                                                                                                                                                               | Codes                           |
            | 1: General example                                                  | System Generated | Single Site    | Leucovorin,Infusion,1st,09:00,09:30; Dexamethasone,Infusion,1st,09:31,10:15; Leucovorin,Infusion,1st,10:20,13:15                                                                                                                    | 96365; 96367; 96366:2           |
            | 1: General example                                                  | Sequential       | Single Site    | Leucovorin,Infusion,1st,09:00,09:30; Dexamethasone,Infusion,1st,09:31,10:15; Leucovorin,Infusion,1st,10:20,13:15                                                                                                                    | 96365; 96367; 96366:2           |
            | 2: Example from DFCI production                                     | System Generated | Single Site    | Diphenhydramine,IV Push,1st,11:56,11:58; Famotodine,Infusion,1st,11:56,12:06; Fosaprepitant,Infusion,1st,12:16,12:46; Paclitaxel,Infusion,1st,12:49,13:11; Paclitaxel,Infusion,1st,13:55,16:57; Palonestron,IV Push,1st,11:56,11:57 | 96375:3; 96367; 96413; 96415:2; |
            | 2: Example from DFCI production                                     | Sequential       | Single Site    | Diphenhydramine,IV Push,1st,11:56,11:58; Famotodine,Infusion,1st,11:56,12:06; Fosaprepitant,Infusion,1st,12:16,12:46; Paclitaxel,Infusion,1st,12:49,13:11; Paclitaxel,Infusion,1st,13:55,16:57; Palonestron,IV Push,1st,11:56,11:57 | 96375:3; 96367; 96413; 96415:2; |
            | 3: Example with first hour of new drug                              | System Generated | Single Site    | Infliximab,Infusion,1st,12:16,12:46; Paclitaxel,Infusion,1st,12:49,13:11; Paclitaxel,Infusion,1st,13:55,16:57                                                                                                                       | 96413; 96417; 96415:2           |
            | 3: Example with first hour of new drug                              | Sequential       | Single Site    | Infliximab,Infusion,1st,12:16,12:46; Paclitaxel,Infusion,1st,12:49,13:11; Paclitaxel,Infusion,1st,13:55,16:57                                                                                                                       | 96413; 96417; 96415:2           |
            | 4: IV Push is not combined, 2 pushes of same drug >30 minutes apart | System Generated | Single Site    | Leucovorin,Infusion,1st,09:00,09:30; Leucovorin,Infusion,1st,10:20,10:30                                                                                                                                                            | 96365; 96376                    |
            | 4: IV Push is not combined, 2 pushes of same drug >30 minutes apart | Sequential       | Single Site    | Leucovorin,Infusion,1st,09:00,09:30; Leucovorin,Infusion,1st,10:20,10:30                                                                                                                                                            | 96365; 96376                    |
            | 5: IV Push is not combined, 2 pushes of same drug <30 minutes apart | System Generated | Single Site    | Leucovorin,Infusion,1st,09:00,09:30; Leucovorin,Infusion,1st,09:45,09:50                                                                                                                                                            | 96365                           |
            | 5: IV Push is not combined, 2 pushes of same drug <30 minutes apart | Sequential       | Single Site    | Leucovorin,Infusion,1st,09:00,09:30; Leucovorin,Infusion,1st,09:45,09:50                                                                                                                                                            | 96365                           |
            | 6: Infusion and push of same chemo drug                             | System Generated | Single Site    | Paclitaxel,Infusion,1st,09:00,09:45; Paclitaxel,Infusion,1st,11:00,11:10                                                                                                                                                            | 96413; 96411                    |
            | 6: Infusion and push of same chemo drug                             | Sequential       | Single Site    | Paclitaxel,Infusion,1st,09:00,09:45; Paclitaxel,Infusion,1st,11:00,11:10                                                                                                                                                            | 96413; 96411                    |
            | 7: Two pushes of same chemo drug                                    | System Generated | Single Site    | Paclitaxel,Infusion,1st,09:00,09:15; Paclitaxel,Infusion,1st,11:00,11:10                                                                                                                                                            | 96409; 96411                    |
            | 7: Two pushes of same chemo drug                                    | Sequential       | Single Site    | Paclitaxel,Infusion,1st,09:00,09:15; Paclitaxel,Infusion,1st,11:00,11:10                                                                                                                                                            | 96409; 96411                    |
            | 8: Infusion of same drug through multiple sites                     | System Generated | Multiple Sites | Leucovorin,Infusion,1st,09:00,09:30; Dexamethasone,Infusion,1st,09:31,10:15; Leucovorin,Infusion,2nd,10:20,13:15                                                                                                                    | 96365; 96367; 96365-59; 96366:2 |
            | 8: Infusion of same drug through multiple sites                     | Sequential       | Multiple Sites | Leucovorin,Infusion,1st,09:00,09:30; Dexamethasone,Infusion,1st,09:31,10:15; Leucovorin,Infusion,2nd,10:20,13:15                                                                                                                    | 96365; 96367; 96365-59; 96366:2 |
            | 9: Infusion of different drug through multiple sites                | System Generated | Multiple Sites | Infliximab,Infusion,1st,12:16,12:46; Paclitaxel,Infusion,2nd,12:49,13:11; Paclitaxel,Infusion,2nd,13:55,16:57                                                                                                                       | 96413; 96413-59; 96415:2        |
            | 9: Infusion of different drug through multiple sites                | Sequential       | Multiple Sites | Infliximab,Infusion,1st,12:16,12:46; Paclitaxel,Infusion,2nd,12:49,13:11; Paclitaxel,Infusion,2nd,13:55,16:57                                                                                                                       | 96413; 96413-59; 96415:2        |

    @infusion
    Scenario Outline: DEV-56139 - only bill for a concurrent charge if the majority of the infusion's administration time is overlapping with another infusion
        When I select "ChargeInfusion" from the "Patient List" menu
        And patient "Roy Blazer" has no charges
        And I select patient "Roy Blazer" from the patient list
        And I select "Charges" from clinical navigation
        And I select "Most Recent Visit" from the "Clinical Timeframe" menu
        And I select "Add Charge" from the "Patient Header Actions" menu
        And I set the following charge headers
            | Name      | Value     |
            | Bill Area | Verve     |
            | Svc Site  | Inpatient |
        And I click the "Infusion" button in the "Charge Entry" pane
        And I select "<Infusion Type>" from the "Infusion Type" pkdropdown
        And I select "<Access Type>" from the "Access Type" pkdropdown
        And I uncheck the "Separate Hydration Order on File" checkbox
        And I add the infusion input "<Input>"
        And I close the infusion screen
        Then the "Charge Entry" pane should load within "1" second
        And I click the "Submit" button
        And the "Charge Entry" pane should close within "10" second
        When I uncheck the "Show Visits" checkbox
        And I sort the "Charges" table chronologically by the "Date/Time" column in "Descending" order
        Then the codes "<Codes>" should appear in the charges table

        Examples:
            | Test Name                                                                  | Infusion Type    | Access Type | Input                                                                                                             | Codes                        |
            | 1: Majority of time non-overlapping                                        | System Generated | Single Site | Leucovorin,Infusion,1st,16:30,17:30; Dexamethasone,Infusion,1st,17:00,18:35                                       | 96365; 96367                 |
            | 1: Majority of time non-overlapping                                        | Concurrent       | Single Site | Leucovorin,Infusion,1st,16:30,17:30; Dexamethasone,Infusion,1st,17:00,18:35                                       | 96365; 96367                 |
            | 2: Majority of time non-overlapping, subsequent code billed                | System Generated | Single Site | Leucovorin,Infusion,1st,16:30,17:30; Dexamethasone,Infusion,1st,17:00,19:35                                       | 96365; 96367; 96366:2        |
            | 2: Majority of time non-overlapping, subsequent code billed                | Concurrent       | Single Site | Leucovorin,Infusion,1st,16:30,17:30; Dexamethasone,Infusion,1st,17:00,19:35                                       | 96365; 96367; 96366:2        |
            | 3: Majority of time non-overlapping, subsequent code billed for both drugs | System Generated | Single Site | Leucovorin,Infusion,1st,15:30,17:30; Dexamethasone,Infusion,1st,17:00,19:35                                       | 96365; 96367; 96366:2        |
            | 3: Majority of time non-overlapping, subsequent code billed for both drugs | Concurrent       | Single Site | Leucovorin,Infusion,1st,15:30,17:30; Dexamethasone,Infusion,1st,17:00,19:35                                       | 96365; 96367; 96366:2        |
            | 4: Equal overlapping and non-overlapping time                              | System Generated | Single Site | Leucovorin,Infusion,1st,16:30,17:30; Dexamethasone,Infusion,1st,17:00,18:00                                       | 96365; 96367                 |
            | 4: Equal overlapping and non-overlapping time                              | Concurrent       | Single Site | Leucovorin,Infusion,1st,16:30,17:30; Dexamethasone,Infusion,1st,17:00,18:00                                       | 96365; 96367                 |
            | 5: Greater overlapping time (by 1 minute)                                  | System Generated | Single Site | Leucovorin,Infusion,1st,16:30,17:30; Dexamethasone,Infusion,1st,17:00,17:59                                       | 96365; 96368                 |
            | 5: Greater overlapping time (by 1 minute)                                  | Concurrent       | Single Site | Leucovorin,Infusion,1st,16:30,17:30; Dexamethasone,Infusion,1st,17:00,17:59                                       | 96365; 96368                 |
            | 6: Greater overlapping time (total time >60 minutes)                       | System Generated | Single Site | Leucovorin,Infusion,1st,16:30,19:30; Dexamethasone,Infusion,1st,17:00,21:30                                       | 96365; 96366:3; 96368        |
            | 6: Greater overlapping time (total time >60 minutes)                       | Concurrent       | Single Site | Leucovorin,Infusion,1st,16:30,19:30; Dexamethasone,Infusion,1st,17:00,21:30                                       | 96365; 96366:3; 96368        |
            | 7: Greater non-overlapping time, non-overlapping time <=15 minutes         | System Generated | Single Site | Leucovorin,Infusion,1st,16:30,17:30; Dexamethasone,Infusion,1st,17:18,17:44                                       | 96365; 96367                 |
            | 7: Greater non-overlapping time, non-overlapping time <=15 minutes         | Concurrent       | Single Site | Leucovorin,Infusion,1st,16:30,17:30; Dexamethasone,Infusion,1st,17:18,17:44                                       | 96365; 96367                 |
#            | 8: 3 overlapping drugs, 2 drugs qualify for rule 6                         | System Generated | Single Site | Leucovorin,Infusion,1st,11:00,14:00; Oxaliplatin,Infusion,1st,11:30,14:00; Dexamethasone,Infusion,1st,12:00,14:30 | 96365; 96366:2; 96368        |
#            | 8: 3 overlapping drugs, 2 drugs qualify for rule 6                         | Concurrent       | Single Site | Leucovorin,Infusion,1st,11:00,14:00; Oxaliplatin,Infusion,1st,11:30,14:00; Dexamethasone,Infusion,1st,12:00,14:30 | 96365; 96366:2; 96368        |
            | 9: 3 overlapping drugs, 1 drug qualifies for rule 6                        | System Generated | Single Site | Leucovorin,Infusion,1st,09:45,11:30; Magnesium,Infusion,1st,11:00,14:15; Dexamethasone,Infusion,1st,11:00,11:45   | 96365; 96366:2; 96367; 96368 |
            | 9: 3 overlapping drugs, 1 drug qualifies for rule 6                        | Concurrent       | Single Site | Leucovorin,Infusion,1st,09:45,11:30; Magnesium,Infusion,1st,11:00,14:15; Dexamethasone,Infusion,1st,11:00,11:45   | 96365; 96366:2; 96367; 96368 |
            | 10: 3 overlapping drugs, none qualify for rule 6                           | System Generated | Single Site | Leucovorin,Infusion,1st,09:29,11:30; Magnesium,Infusion,1st,11:00,14:15; Dexamethasone,Infusion,1st,13:30,16:00   | 96365; 96366:3; 96367:2      |
            | 10: 3 overlapping drugs, none qualify for rule 6                           | Concurrent       | Single Site | Leucovorin,Infusion,1st,09:29,11:30; Magnesium,Infusion,1st,11:00,14:15; Dexamethasone,Infusion,1st,13:30,16:00   | 96365; 96366:3; 96367:2      |
