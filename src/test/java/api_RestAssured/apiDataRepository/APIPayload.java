package api_RestAssured.apiDataRepository;

import java.util.List;

/**
 * Created by atripathi on 3/23/2017.
 */
public class APIPayload {

    public PatientDetail patient;
    public WorkflowDetail workflowDetail;

    public int medId;
    public String prescriberSpi;

    public long id;
    public long refId;
    public String ndc = null;
    public String strength = null;
    public String prescriberAgentSpi = null;
    public String supervisorSpi = null;
    public String pharmacyId = null;
    public String drugDescription = null;
    public String quantity = null;
    public String potencyUnitCode = null;
    public String directions = null;
    public String note = null;
    public int refills;
    public int daysSupply;
    public boolean substitutions;
    public String writtenDate;
    public String payerId;
    public String planNetworkId;
    public boolean includeRxNorm;

    public String targetLatitude = null;
    public String targetLongitude = null;
    public String maxDistanceInMiles = null;
    public List<String> cityList = null;
    public List<String> orgNamesList = null;

    public PatientDetail getPatient() {
        return patient;
    }

    public void setPatient(PatientDetail patient) {
        this.patient = patient;
    }

    public WorkflowDetail getWorkflowDetail() {
        return workflowDetail;
    }

    public void setWorkflowDetail(WorkflowDetail workflowDetail) {
        this.workflowDetail = workflowDetail;
    }

    public int getMedId() {
        return medId;
    }

    public void setMedId(int medId) {
        this.medId = medId;
    }

    public String getPrescriberSpi() {
        return prescriberSpi;
    }

    public void setPrescriberSpi(String prescriberSpi) {
        this.prescriberSpi = prescriberSpi;
    }

    public long getRefId() {
        return refId;
    }

    public void setRefId(long refId) {
        this.refId = refId;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getNdc() {
        return ndc;
    }

    public void setNdc(String ndc) {
        this.ndc = ndc;
    }

    public String getStrength() {
        return strength;
    }

    public void setStrength(String strength) {
        this.strength = strength;
    }

    public String getPrescriberAgentSpi() {
        return prescriberAgentSpi;
    }

    public void setPrescriberAgentSpi(String prescriberAgentSpi) {
        this.prescriberAgentSpi = prescriberAgentSpi;
    }

    public String getSupervisorSpi() {
        return supervisorSpi;
    }

    public void setSupervisorSpi(String supervisorSpi) {
        this.supervisorSpi = supervisorSpi;
    }

    public String getPharmacyId() {
        return pharmacyId;
    }

    public void setPharmacyId(String pharmacyId) {
        this.pharmacyId = pharmacyId;
    }

    public String getDrugDescription() {
        return drugDescription;
    }

    public void setDrugDescription(String drugDescription) {
        this.drugDescription = drugDescription;
    }

    public String getQuantity() {
        return quantity;
    }

    public void setQuantity(String quantity) {
        this.quantity = quantity;
    }

    public String getPotencyUnitCode() {
        return potencyUnitCode;
    }

    public void setPotencyUnitCode(String potencyUnitCode) {
        this.potencyUnitCode = potencyUnitCode;
    }

    public String getDirections() {
        return directions;
    }

    public void setDirections(String directions) {
        this.directions = directions;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public int getRefills() {
        return refills;
    }

    public void setRefills(int refills) {
        this.refills = refills;
    }

    public int getDaysSupply() {
        return daysSupply;
    }

    public void setDaysSupply(int daysSupply) {
        this.daysSupply = daysSupply;
    }

    public boolean isSubstitutions() {
        return substitutions;
    }

    public void setSubstitutions(boolean substitutions) {
        this.substitutions = substitutions;
    }

    public String getWrittenDate() {
        return writtenDate;
    }

    public void setWrittenDate(String writtenDate) {
        this.writtenDate = writtenDate;
    }

    public String getPayerId() {
        return payerId;
    }

    public void setPayerId(String payerId) {
        this.payerId = payerId;
    }

    public String getPlanNetworkId() {
        return planNetworkId;
    }

    public void setPlanNetworkId(String planNetworkId) {
        this.planNetworkId = planNetworkId;
    }

    public boolean isIncludeRxNorm() {
        return includeRxNorm;
    }

    public void setIncludeRxNorm(boolean includeRxNorm) {
        this.includeRxNorm = includeRxNorm;
    }

    public String getTargetLatitude() {
        return targetLatitude;
    }

    public void setTargetLatitude(String targetLatitude) {
        this.targetLatitude = targetLatitude;
    }

    public String getTargetLongitude() {
        return targetLongitude;
    }

    public void setTargetLongitude(String targetLongitude) {
        this.targetLongitude = targetLongitude;
    }

    public String getMaxDistanceInMiles() {
        return maxDistanceInMiles;
    }

    public void setMaxDistanceInMiles(String maxDistanceInMiles) {
        this.maxDistanceInMiles = maxDistanceInMiles;
    }

    public List<String> getCityList() {
        return cityList;
    }

    public void setCityList(List<String> cityList) {
        this.cityList = cityList;
    }

    public List<String> getOrgNamesList() {
        return orgNamesList;
    }

    public void setOrgNamesList(List<String> orgNamesList) {
        this.orgNamesList = orgNamesList;
    }
}
