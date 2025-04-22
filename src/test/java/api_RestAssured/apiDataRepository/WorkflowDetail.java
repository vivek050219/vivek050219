package api_RestAssured.apiDataRepository;

/**
 * Created by atripathi on 6/9/2017.
 */
public class WorkflowDetail {
    public String benefitsCoordinationRequestList;
    public String effectiveDate;
    public String expirationDate;
    public String consent;

    public String getBenefitsCoordinationRequestList() {
        return benefitsCoordinationRequestList;
    }

    public void setBenefitsCoordinationRequestList(String benefitsCoordinationRequestList) {
        this.benefitsCoordinationRequestList = benefitsCoordinationRequestList;
    }

    public String getEffectiveDate() {
        return effectiveDate;
    }

    public void setEffectiveDate(String effectiveDate) {
        this.effectiveDate = effectiveDate;
    }

    public String getExpirationDate() {
        return expirationDate;
    }

    public void setExpirationDate(String expirationDate) {
        this.expirationDate = expirationDate;
    }

    public String getConsent() {
        return consent;
    }

    public void setConsent(String consent) {
        this.consent = consent;
    }
}
