package api_RestAssured.apiDataRepository;

import java.util.HashMap;
import java.util.List;

/**
 * Created by atripathi on 6/9/2017.
 */
public class PatientDetail {
    public Name name;
    public Address address;
    public long dob;
    public String gender;
    public List<HashMap> phone;
    //public String diagnosisNomenList;
    public List<DiagnosisNomenList> diagnosisNomenList;

    public List<DiagnosisNomenList> getDiagnosisNomenList() {
        return diagnosisNomenList;
    }

    public void setDiagnosisNomenLists(List<DiagnosisNomenList> diagnosisNomenList) {
        this.diagnosisNomenList = diagnosisNomenList;
    }

    public Name getName() {
        return name;
    }

    public void setName(Name name) {
        this.name = name;
    }

    public Address getAddress() {
        return address;
    }

    public void setAddress(Address address) {
        this.address = address;
    }

    public long getDob() {
        return dob;
    }

    public void setDob(long dob) {
        this.dob = dob;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public List<HashMap> getPhone() {
        return phone;
    }

    public void setPhone(List<HashMap> phone) {
        this.phone = phone;
    }

//    public String getDiagnosisNomenList() {
//        return diagnosisNomenList;
//    }
//
//    public void setDiagnosisNomenList(String diagnosisNomenList) {
//        this.diagnosisNomenList = diagnosisNomenList;
//    }
}
