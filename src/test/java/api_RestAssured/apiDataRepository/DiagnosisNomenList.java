package api_RestAssured.apiDataRepository;

/**
 * Created by atripathi on 6/9/2017.
 */
public class DiagnosisNomenList {
    public String clinicalInformationQualifier;
    public DiagnosisSubelement diagnosisSubelement;

    public String getClinicalInformationQualifier() {
        return clinicalInformationQualifier;
    }

    public void setClinicalInformationQualifier(String clinicalInformationQualifier) {
        this.clinicalInformationQualifier = clinicalInformationQualifier;
    }

    public DiagnosisSubelement getDiagnosisSubelement() {
        return diagnosisSubelement;
    }

    public void setDiagnosisSubelement(DiagnosisSubelement diagnosisSubelement) {
        this.diagnosisSubelement = diagnosisSubelement;
    }
}
