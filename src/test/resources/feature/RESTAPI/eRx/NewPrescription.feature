@eRxAPI @eRxV2API
Feature: New Prescription eRx API

  Background:
    Given API: The auth token is set to "surescript123"

  @NewPrescriptionAPI
  Scenario: 1. Validate /api/new_pescription
    Given API: I perform actions on "new_pescription" api
    When API: I set the following as payload and check for status code "202"
      | Type                  | Value                                                                  |
      | id                    | 10906                                                                  |
      | ndc                   | 00065027225                                                            |
      | medId                 | 549088                                                                 |
      | strength              | amoxicillin 200 mg-potassium clavulanate 28.5 mg/5 mL oral suspension  |
      | prescriberSpi         | 6660942728001                                                          |
      | prescriberAgentSpi    | null                                                                   |
      | supervisorSpi         | null                                                                   |
      | pharmacyId            | 3105551                                                                |
      | drugDescription       | 200MG/5ML or 40 MG/ML VIAL DrugStrengthDrugStrengthDrugStrengthDrugStr |
      | quantity              | 50                                                                     |
      | potencyUnitCode       | C48551                                                                 |
      | directions            | Use as directed during patient visit                                   |
      | note                  | Patient will also need the correct testing meter.                      |
      | refills               | 0                                                                      |
      | daysSupply            | 0                                                                      |
      | substitutions         | true                                                                   |
      | writtenDate           | Current time stamp                                                     |
      | payerId               | null                                                                   |
      | lastName              | CROSS                                                                  |
      | firstName             | DAVID                                                                  |
      | middleName            | null                                                                   |
      | suffix                | null                                                                   |
      | prefix                | null                                                                   |
      | address1              | 123 Main St                                                            |
      | address2              | null                                                                   |
      | city                  | Boston                                                                 |
      | state                 | MA                                                                     |
      | postalCode            | 02010                                                                  |
      | country               | null                                                                   |
      | dob                   | -1110950553000                                                         |
      | gender                | MALE                                                                   |
      | phone_newPrescription | null                                                                   |
      | planNetworkId         | null                                                                   |
      | includeRxNorm         | false                                                                  |
    And API: I validate the medID "549088" response with pre-saved response at "/eRx/NewPrescription/"


  @NewPrescriptionAPI
  Scenario: 2. Validate /api/new_pescription with null directions
    Given API: I perform actions on "new_pescription" api
    When API: I set the following as payload and check for status code "400"
      | Type                  | Value                                                                  |
      | id                    | 10458                                                                  |
      | ndc                   | 00065027225                                                            |
      | medId                 | 549088                                                                 |
      | strength              | amoxicillin 200 mg-potassium clavulanate 28.5 mg/5 mL oral suspension  |
      | prescriberSpi         | 6660942728001                                                          |
      | prescriberAgentSpi    | null                                                                   |
      | supervisorSpi         | null                                                                   |
      | pharmacyId            | 3105551                                                                |
      | drugDescription       | 200MG/5ML or 40 MG/ML VIAL DrugStrengthDrugStrengthDrugStrengthDrugStr |
      | quantity              | 50                                                                     |
      | potencyUnitCode       | C48551                                                                 |
      | directions            | null                                                                   |
      | note                  | Patient will also need the correct testing meter.                      |
      | refills               | 0                                                                      |
      | daysSupply            | 0                                                                      |
      | substitutions         | true                                                                   |
      | writtenDate           | Current time stamp                                                     |
      | payerId               | null                                                                   |
      | lastName              | CROSS                                                                  |
      | firstName             | DAVID                                                                  |
      | middleName            | null                                                                   |
      | suffix                | null                                                                   |
      | prefix                | null                                                                   |
      | address1              | 123 Main St                                                            |
      | address2              | null                                                                   |
      | city                  | Boston                                                                 |
      | state                 | MA                                                                     |
      | postalCode            | 02010                                                                  |
      | country               | null                                                                   |
      | dob                   | -1110950553000                                                         |
      | gender                | MALE                                                                   |
      | phone_newPrescription | null                                                                   |
      | planNetworkId         | null                                                                   |
      | includeRxNorm         | false                                                                  |
    And API: I validate the message "Directions is null"


  @NewPrescriptionAPI
  Scenario: 3. Validate /api/new_pescription with negative id
    Given API: I perform actions on "new_pescription" api
    When API: I set the following as payload and check for status code "400"
      | Type                  | Value                                                                  |
      | id                    | -10428                                                                 |
      | ndc                   | 00065027225                                                            |
      | medId                 | 549088                                                                 |
      | strength              | amoxicillin 200 mg-potassium clavulanate 28.5 mg/5 mL oral suspension  |
      | prescriberSpi         | 6660942728001                                                          |
      | prescriberAgentSpi    | null                                                                   |
      | supervisorSpi         | null                                                                   |
      | pharmacyId            | 3105551                                                                |
      | drugDescription       | 200MG/5ML or 40 MG/ML VIAL DrugStrengthDrugStrengthDrugStrengthDrugStr |
      | quantity              | 50                                                                     |
      | potencyUnitCode       | C48551                                                                 |
      | directions            | Use as directed during patient visit                                   |
      | note                  | Patient will also need the correct testing meter.                      |
      | refills               | 0                                                                      |
      | daysSupply            | 0                                                                      |
      | substitutions         | true                                                                   |
      | writtenDate           | Current time stamp                                                     |
      | payerId               | null                                                                   |
      | lastName              | CROSS                                                                  |
      | firstName             | DAVID                                                                  |
      | middleName            | null                                                                   |
      | suffix                | null                                                                   |
      | prefix                | null                                                                   |
      | address1              | 123 Main St                                                            |
      | address2              | null                                                                   |
      | city                  | Boston                                                                 |
      | state                 | MA                                                                     |
      | postalCode            | 02010                                                                  |
      | country               | null                                                                   |
      | dob                   | -1110950553000                                                         |
      | gender                | MALE                                                                   |
      | phone_newPrescription | null                                                                   |
      | planNetworkId         | null                                                                   |
      | includeRxNorm         | false                                                                  |
    And API: I validate the message "ID snould be positive long"


  @NewPrescriptionAPI
  Scenario: 4. Validate /api/new_pescription with null drug description
    Given API: I perform actions on "new_pescription" api
    When API: I set the following as payload and check for status code "400"
      | Type                  | Value                                                                 |
      | id                    | 10458                                                                 |
      | ndc                   | 00065027225                                                           |
      | medId                 | 549088                                                                |
      | strength              | amoxicillin 200 mg-potassium clavulanate 28.5 mg/5 mL oral suspension |
      | prescriberSpi         | 6660942728001                                                         |
      | prescriberAgentSpi    | null                                                                  |
      | supervisorSpi         | null                                                                  |
      | pharmacyId            | 3105551                                                               |
      | drugDescription       | null                                                                  |
      | quantity              | 50                                                                    |
      | potencyUnitCode       | C48551                                                                |
      | directions            | Use as directed during patient visit                                  |
      | note                  | Patient will also need the correct testing meter.                     |
      | refills               | 0                                                                     |
      | daysSupply            | 0                                                                     |
      | substitutions         | true                                                                  |
      | writtenDate           | Current time stamp                                                    |
      | payerId               | null                                                                  |
      | lastName              | CROSS                                                                 |
      | firstName             | DAVID                                                                 |
      | middleName            | null                                                                  |
      | suffix                | null                                                                  |
      | prefix                | null                                                                  |
      | address1              | 123 Main St                                                           |
      | address2              | null                                                                  |
      | city                  | Boston                                                                |
      | state                 | MA                                                                    |
      | postalCode            | 02010                                                                 |
      | country               | null                                                                  |
      | dob                   | -1110950553000                                                        |
      | gender                | MALE                                                                  |
      | phone_newPrescription | null                                                                  |
      | planNetworkId         | null                                                                  |
      | includeRxNorm         | false                                                                 |
    And API: I validate the message "Drug description is null"


  @NewPrescriptionAPI
  Scenario: 5. Validate /api/new_pescription with null quantity
    Given API: I perform actions on "new_pescription" api
    When API: I set the following as payload and check for status code "400"
      | Type                  | Value                                                                  |
      | id                    | 10458                                                                  |
      | ndc                   | 00065027225                                                            |
      | medId                 | 549088                                                                 |
      | strength              | amoxicillin 200 mg-potassium clavulanate 28.5 mg/5 mL oral suspension  |
      | prescriberSpi         | 6660942728001                                                          |
      | prescriberAgentSpi    | null                                                                   |
      | supervisorSpi         | null                                                                   |
      | pharmacyId            | 3105551                                                                |
      | drugDescription       | 200MG/5ML or 40 MG/ML VIAL DrugStrengthDrugStrengthDrugStrengthDrugStr |
      | quantity              | null                                                                   |
      | potencyUnitCode       | C48551                                                                 |
      | directions            | Use as directed during patient visit                                   |
      | note                  | Patient will also need the correct testing meter.                      |
      | refills               | 0                                                                      |
      | daysSupply            | 0                                                                      |
      | substitutions         | true                                                                   |
      | writtenDate           | Current time stamp                                                     |
      | payerId               | null                                                                   |
      | lastName              | CROSS                                                                  |
      | firstName             | DAVID                                                                  |
      | middleName            | null                                                                   |
      | suffix                | null                                                                   |
      | prefix                | null                                                                   |
      | address1              | 123 Main St                                                            |
      | address2              | null                                                                   |
      | city                  | Boston                                                                 |
      | state                 | MA                                                                     |
      | postalCode            | 02010                                                                  |
      | country               | null                                                                   |
      | dob                   | -1110950553000                                                         |
      | gender                | MALE                                                                   |
      | phone_newPrescription | null                                                                   |
      | planNetworkId         | null                                                                   |
      | includeRxNorm         | false                                                                  |
    And API: I validate the message "Quantity is null"


  @NewPrescriptionAPI
  Scenario: 6. Validate /api/new_pescription with quantity greater than 11 digits
    Given API: I perform actions on "new_pescription" api
    When API: I set the following as payload and check for status code "400"
      | Type                  | Value                                                                  |
      | id                    | 10458                                                                  |
      | ndc                   | 00065027225                                                            |
      | medId                 | 549088                                                                 |
      | strength              | amoxicillin 200 mg-potassium clavulanate 28.5 mg/5 mL oral suspension  |
      | prescriberSpi         | 6660942728001                                                          |
      | prescriberAgentSpi    | null                                                                   |
      | supervisorSpi         | null                                                                   |
      | pharmacyId            | 3105551                                                                |
      | drugDescription       | 200MG/5ML or 40 MG/ML VIAL DrugStrengthDrugStrengthDrugStrengthDrugStr |
      | quantity              | 5050505050505050505050                                                 |
      | potencyUnitCode       | C48551                                                                 |
      | directions            | Use as directed during patient visit                                   |
      | note                  | Patient will also need the correct testing meter.                      |
      | refills               | 0                                                                      |
      | daysSupply            | 0                                                                      |
      | substitutions         | true                                                                   |
      | writtenDate           | Current time stamp                                                     |
      | payerId               | null                                                                   |
      | lastName              | CROSS                                                                  |
      | firstName             | DAVID                                                                  |
      | middleName            | null                                                                   |
      | suffix                | null                                                                   |
      | prefix                | null                                                                   |
      | address1              | 123 Main St                                                            |
      | address2              | null                                                                   |
      | city                  | Boston                                                                 |
      | state                 | MA                                                                     |
      | postalCode            | 02010                                                                  |
      | country               | null                                                                   |
      | dob                   | -1110950553000                                                         |
      | gender                | MALE                                                                   |
      | phone_newPrescription | null                                                                   |
      | planNetworkId         | null                                                                   |
      | includeRxNorm         | false                                                                  |
    And API: I validate the message "Quantity size should be max 11 characters long, actual value is:'5050505050505050505050'"


  @NewPrescriptionAPI
  Scenario: 7. Validate /api/new_pescription with null potency unit code
    Given API: I perform actions on "new_pescription" api
    When API: I set the following as payload and check for status code "400"
      | Type                  | Value                                                                  |
      | id                    | 10458                                                                  |
      | ndc                   | 00065027225                                                            |
      | medId                 | 549088                                                                 |
      | strength              | amoxicillin 200 mg-potassium clavulanate 28.5 mg/5 mL oral suspension  |
      | prescriberSpi         | 6660942728001                                                          |
      | prescriberAgentSpi    | null                                                                   |
      | supervisorSpi         | null                                                                   |
      | pharmacyId            | 3105551                                                                |
      | drugDescription       | 200MG/5ML or 40 MG/ML VIAL DrugStrengthDrugStrengthDrugStrengthDrugStr |
      | quantity              | 50                                                                     |
      | potencyUnitCode       | null                                                                   |
      | directions            | Use as directed during patient visit                                   |
      | note                  | Patient will also need the correct testing meter.                      |
      | refills               | 0                                                                      |
      | daysSupply            | 0                                                                      |
      | substitutions         | true                                                                   |
      | writtenDate           | Current time stamp                                                     |
      | payerId               | null                                                                   |
      | lastName              | CROSS                                                                  |
      | firstName             | DAVID                                                                  |
      | middleName            | null                                                                   |
      | suffix                | null                                                                   |
      | prefix                | null                                                                   |
      | address1              | 123 Main St                                                            |
      | address2              | null                                                                   |
      | city                  | Boston                                                                 |
      | state                 | MA                                                                     |
      | postalCode            | 02010                                                                  |
      | country               | null                                                                   |
      | dob                   | -1110950553000                                                         |
      | gender                | MALE                                                                   |
      | phone_newPrescription | null                                                                   |
      | planNetworkId         | null                                                                   |
      | includeRxNorm         | false                                                                  |
    And API: I validate the message "Potency unit code is null"


  @NewPrescriptionAPI
  Scenario: 8. Validate /api/new_pescription with negative refills
    Given API: I perform actions on "new_pescription" api
    When API: I set the following as payload and check for status code "400"
      | Type                  | Value                                                                  |
      | id                    | 10458                                                                  |
      | ndc                   | 00065027225                                                            |
      | medId                 | 549088                                                                 |
      | strength              | amoxicillin 200 mg-potassium clavulanate 28.5 mg/5 mL oral suspension  |
      | prescriberSpi         | 6660942728001                                                          |
      | prescriberAgentSpi    | null                                                                   |
      | supervisorSpi         | null                                                                   |
      | pharmacyId            | 3105551                                                                |
      | drugDescription       | 200MG/5ML or 40 MG/ML VIAL DrugStrengthDrugStrengthDrugStrengthDrugStr |
      | quantity              | 50                                                                     |
      | potencyUnitCode       | C48551                                                                 |
      | directions            | Use as directed during patient visit                                   |
      | note                  | Patient will also need the correct testing meter.                      |
      | refills               | -10                                                                    |
      | daysSupply            | 0                                                                      |
      | substitutions         | true                                                                   |
      | writtenDate           | Current time stamp                                                     |
      | payerId               | null                                                                   |
      | lastName              | CROSS                                                                  |
      | firstName             | DAVID                                                                  |
      | middleName            | null                                                                   |
      | suffix                | null                                                                   |
      | prefix                | null                                                                   |
      | address1              | 123 Main St                                                            |
      | address2              | null                                                                   |
      | city                  | Boston                                                                 |
      | state                 | MA                                                                     |
      | postalCode            | 02010                                                                  |
      | country               | null                                                                   |
      | dob                   | -1110950553000                                                         |
      | gender                | MALE                                                                   |
      | phone_newPrescription | null                                                                   |
      | planNetworkId         | null                                                                   |
      | includeRxNorm         | false                                                                  |
    And API: I validate the message "Number of refills can't be negative"


  @NewPrescriptionAPI
  Scenario: 9. Validate /api/new_pescription with null Written Date
    Given API: I perform actions on "new_pescription" api
    When API: I set the following as payload and check for status code "400"
      | Type                  | Value                                                                  |
      | id                    | 10458                                                                  |
      | ndc                   | 00065027225                                                            |
      | medId                 | 549088                                                                 |
      | strength              | amoxicillin 200 mg-potassium clavulanate 28.5 mg/5 mL oral suspension  |
      | prescriberSpi         | 6660942728001                                                          |
      | prescriberAgentSpi    | null                                                                   |
      | supervisorSpi         | null                                                                   |
      | pharmacyId            | 3105551                                                                |
      | drugDescription       | 200MG/5ML or 40 MG/ML VIAL DrugStrengthDrugStrengthDrugStrengthDrugStr |
      | quantity              | 50                                                                     |
      | potencyUnitCode       | C48551                                                                 |
      | directions            | Use as directed during patient visit                                   |
      | note                  | Patient will also need the correct testing meter.                      |
      | refills               | 0                                                                      |
      | daysSupply            | 0                                                                      |
      | substitutions         | true                                                                   |
      | writtenDate           | null                                                                   |
      | payerId               | null                                                                   |
      | lastName              | CROSS                                                                  |
      | firstName             | DAVID                                                                  |
      | middleName            | null                                                                   |
      | suffix                | null                                                                   |
      | prefix                | null                                                                   |
      | address1              | 123 Main St                                                            |
      | address2              | null                                                                   |
      | city                  | Boston                                                                 |
      | state                 | MA                                                                     |
      | postalCode            | 02010                                                                  |
      | country               | null                                                                   |
      | dob                   | -1110950553000                                                         |
      | gender                | MALE                                                                   |
      | phone_newPrescription | null                                                                   |
      | planNetworkId         | null                                                                   |
      | includeRxNorm         | false                                                                  |
    And API: I validate the message "Written date ID is null"


  @NewPrescriptionAPI
  Scenario: 10. Validate /api/new_pescription with null Pharmacy ID
    Given API: I perform actions on "new_pescription" api
    When API: I set the following as payload and check for status code "400"
      | Type                  | Value                                                                  |
      | id                    | 10458                                                                  |
      | ndc                   | 00065027225                                                            |
      | medId                 | 549088                                                                 |
      | strength              | amoxicillin 200 mg-potassium clavulanate 28.5 mg/5 mL oral suspension  |
      | prescriberSpi         | 6660942728001                                                          |
      | prescriberAgentSpi    | null                                                                   |
      | supervisorSpi         | null                                                                   |
      | pharmacyId            | null                                                                   |
      | drugDescription       | 200MG/5ML or 40 MG/ML VIAL DrugStrengthDrugStrengthDrugStrengthDrugStr |
      | quantity              | 50                                                                     |
      | potencyUnitCode       | C48551                                                                 |
      | directions            | Use as directed during patient visit                                   |
      | note                  | Patient will also need the correct testing meter.                      |
      | refills               | 0                                                                      |
      | daysSupply            | 0                                                                      |
      | substitutions         | true                                                                   |
      | writtenDate           | Current time stamp                                                     |
      | payerId               | null                                                                   |
      | lastName              | CROSS                                                                  |
      | firstName             | DAVID                                                                  |
      | middleName            | null                                                                   |
      | suffix                | null                                                                   |
      | prefix                | null                                                                   |
      | address1              | 123 Main St                                                            |
      | address2              | null                                                                   |
      | city                  | Boston                                                                 |
      | state                 | MA                                                                     |
      | postalCode            | 02010                                                                  |
      | country               | null                                                                   |
      | dob                   | -1110950553000                                                         |
      | gender                | MALE                                                                   |
      | phone_newPrescription | null                                                                   |
      | planNetworkId         | null                                                                   |
      | includeRxNorm         | false                                                                  |
    And API: I validate the message "Pharmacy ID is null"


  @NewPrescriptionAPI
  Scenario: 11. Validate /api/new_pescription with Prescriber SPI less than 13 digits
    Given API: I perform actions on "new_pescription" api
    When API: I set the following as payload and check for status code "400"
      | Type                  | Value                                                                  |
      | id                    | 10458                                                                  |
      | ndc                   | 00065027225                                                            |
      | medId                 | 549088                                                                 |
      | strength              | amoxicillin 200 mg-potassium clavulanate 28.5 mg/5 mL oral suspension  |
      | prescriberSpi         | 666094272800                                                           |
      | prescriberAgentSpi    | null                                                                   |
      | supervisorSpi         | null                                                                   |
      | pharmacyId            | 3105551                                                                |
      | drugDescription       | 200MG/5ML or 40 MG/ML VIAL DrugStrengthDrugStrengthDrugStrengthDrugStr |
      | quantity              | 50                                                                     |
      | potencyUnitCode       | C48551                                                                 |
      | directions            | Use as directed during patient visit                                   |
      | note                  | Patient will also need the correct testing meter.                      |
      | refills               | 0                                                                      |
      | daysSupply            | 0                                                                      |
      | substitutions         | true                                                                   |
      | writtenDate           | Current time stamp                                                     |
      | payerId               | null                                                                   |
      | lastName              | CROSS                                                                  |
      | firstName             | DAVID                                                                  |
      | middleName            | null                                                                   |
      | suffix                | null                                                                   |
      | prefix                | null                                                                   |
      | address1              | 123 Main St                                                            |
      | address2              | null                                                                   |
      | city                  | Boston                                                                 |
      | state                 | MA                                                                     |
      | postalCode            | 02010                                                                  |
      | country               | null                                                                   |
      | dob                   | -1110950553000                                                         |
      | gender                | MALE                                                                   |
      | phone_newPrescription | null                                                                   |
      | planNetworkId         | null                                                                   |
      | includeRxNorm         | false                                                                  |
    And API: I validate the message "Prescriber SPI size should be 13 characters long, actual value is:'666094272800'"


  @NewPrescriptionAPI
  Scenario: 12. Validate /api/new_pescription with negative no of days supply
    Given API: I perform actions on "new_pescription" api
    When API: I set the following as payload and check for status code "400"
      | Type                  | Value                                                                  |
      | id                    | 10458                                                                  |
      | ndc                   | 00065027225                                                            |
      | medId                 | 549088                                                                 |
      | strength              | amoxicillin 200 mg-potassium clavulanate 28.5 mg/5 mL oral suspension  |
      | prescriberSpi         | 6660942728001                                                          |
      | prescriberAgentSpi    | null                                                                   |
      | supervisorSpi         | null                                                                   |
      | pharmacyId            | 3105551                                                                |
      | drugDescription       | 200MG/5ML or 40 MG/ML VIAL DrugStrengthDrugStrengthDrugStrengthDrugStr |
      | quantity              | 50                                                                     |
      | potencyUnitCode       | C48551                                                                 |
      | directions            | Use as directed during patient visit                                   |
      | note                  | Patient will also need the correct testing meter.                      |
      | refills               | 0                                                                      |
      | daysSupply            | -10                                                                    |
      | substitutions         | true                                                                   |
      | writtenDate           | Current time stamp                                                     |
      | payerId               | null                                                                   |
      | lastName              | CROSS                                                                  |
      | firstName             | DAVID                                                                  |
      | middleName            | null                                                                   |
      | suffix                | null                                                                   |
      | prefix                | null                                                                   |
      | address1              | 123 Main St                                                            |
      | address2              | null                                                                   |
      | city                  | Boston                                                                 |
      | state                 | MA                                                                     |
      | postalCode            | 02010                                                                  |
      | country               | null                                                                   |
      | dob                   | -1110950553000                                                         |
      | gender                | MALE                                                                   |
      | phone_newPrescription | null                                                                   |
      | planNetworkId         | null                                                                   |
      | includeRxNorm         | false                                                                  |
    And API: I validate the message "Number of days supply can't be negative"