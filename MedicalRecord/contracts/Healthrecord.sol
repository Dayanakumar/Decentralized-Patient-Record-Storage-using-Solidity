// SPDX-License-Identifier:UNLICENSED 
pragma solidity^0.8.0;

contract Healthrecord{
    
    struct Doctor {
        uint256 id;
        string name;
        string qualification;
        string workPlace;
    }
    struct Patient {
        uint256 id;
        string name;
        uint256 age;
        string disease;
        uint[] medicineids;
    }
    struct MedicineDetails {
        uint id;
        string name;
        uint expiryDate;
        uint dose;
        uint price;
    }
    struct Prescription {
        uint medicineId;
        address patient;
    }
    mapping(uint => Doctor) doctors;
    mapping(address => Patient)patient;
    mapping(uint => MedicineDetails)medicines;
    Prescription[] prescriptions;
    
   /* Register a new doctor
   This function is used to register a new doctor to the ledger. It takes the below parameters:
        @param _name Name of the doctor
        @param _qualification Which degree he/she holds as a doctor
        @param _workPlace Address of his/her hospital/clinic    */

    uint Doctors;
    function registerDoctor(uint _id, string memory _name, string memory _qualification, string memory _workPlace) public {
        // Doctors++;
        doctors[_id] = Doctor(Doctors, _name, _qualification, _workPlace);
    }
        
   /*  Register a new patient
   This function is used to register a new patient to the ledger. It takes the below parameters:
        @param _name Name of the user
        @param _age Age of user   */

     function registerPatient(string memory _name, uint _age) public {
        patient[msg.sender].name = _name;
        patient[msg.sender].age = _age;
    }

   /* Add a patient's disease
   This function is used to add a patient's disease. It takes the below parameters:    
        @param _disease Name of the disease */

     event PatientDiseaseAdded(address indexed patientAddress, string disease);    
     function addNewDisease(string memory _disease) public {
        patient[msg.sender].disease = _disease;
        emit PatientDiseaseAdded(msg.sender, _disease);
    }

   /*	Add medicine
   This function is used to add medicines. It takes the below parameters:
        @param _id Id of the medicine
        @param _name name of the medicine
        @param _expiryDate ExpiryDate of the medicine
        @param _dose Dose prescribed to the patient
        @param _price Price of the medicine    */

     function addMedicine(uint _id, string memory _name, uint _expiryDate, uint _dose, uint _price) public {
        MedicineDetails memory newMedicine = MedicineDetails(_id, _name, _expiryDate, _dose, _price);
        medicines[_id] = newMedicine;
    }
   
   /*	Prescribe medicine 
   This function is used by doctors to prescribe medicine to a patient. It takes the below parameters:
        @param _id Medicine Id
        @param _patient address of the patient    */

     function prescribeMedicine(uint _medicineId, address _patient) public {
        prescriptions.push(Prescription(_medicineId, _patient));
    }

    
	/*  Update patient details by patient
    This function helps patients to update their age. It takes the below parameters:    
        @param _age New age of the patient    */

     event updateAge(address indexed patientAddress, uint256 age);
     function updatePatientAge(uint256 _age) public {
         patient[msg.sender].age = _age;
         emit updateAge(msg.sender, _age);
    }

    /*	View doctor details
    This function helps to view doctor details. It takes the below parameters:  
        @param _id ID of the doctor
        @return id ID of the doctor
        @return name Name of the doctor
        @return qualification Name of degree he/she holds as a doctor
        @return add Address of his/her hospital/clinic   */

     function viewDoctorById(uint _Doctorid) public view returns (uint, string memory, string memory, string memory) {
        Doctor storage doctor = doctors[_Doctorid];
        return (doctor.id, doctor.name, doctor.qualification, doctor.workPlace);
    }  

    /*	View patient data   
    This function helps to view patient data stored in Blockchain. It takes the below parameters:       
        @return id Id of the patient
        @return age Age of the patient
        @return name Name of the patient
        @return disease All the diseases of the patient    */
    
    function viewPatientByDoctor(address _PatientId) public view returns (uint, string memory, uint, string memory) {
        Patient memory patients = patient[_PatientId];
        return (patients.id, patients.name, patients.age, patients.disease);
    }


    /*	View medicine details    
    This function helps to fetch medicine details. This function below input parameters and return the details about the medicine.
        @param id Id of the medicine
        @return name Name of the medicine
        @return expiryDate Expiry date of the medicine
        @return dose Dose prescribed for the medicine
        @return price Price of the medicine   */

    function viewMedicine(uint _id) public view returns (string memory, uint, uint, uint) {
        MedicineDetails memory medDetails = medicines[_id];
        return (medDetails.name, medDetails.expiryDate, medDetails.dose, medDetails.price);
    }

     /* View prescribed medicine to the patient 
     This function helps the doctor to view patient data. It takes the below parameters:
        @dev View prescribed medicines to the patient 
        @param _patient address of the patient
        @return ids list of medicine id's    */

    function viewPrescribedMedicines(address _patient) public view returns (uint[] memory ids) {
        uint count = 0;
          for (uint i = 0; i < prescriptions.length; i++) {
            if (prescriptions[i].patient == _patient) {
              count++;
            }
         }
        ids = new uint[](count);
          uint index = 0;
         for (uint i = 0; i < prescriptions.length; i++) {
            if (prescriptions[i].patient == _patient) {
            ids[index] = prescriptions[i].medicineId;
            index++;
            }
         }
    }
   
     /*	View patient data by a doctor 
     This function helps a doctor to view patient data. It takes the below parameters:    
        @param _id ID of the patient
        @return id ID of the patient
        @return age Age of the patient
        @return name Name of the patient
        @return disease All the diseases of the patient    */ 

     function viewRecord() public view returns (uint, string memory, uint, string memory) {
        // Doctor memory Doctors = doctors[_doctorId];
        Patient memory patients = patient[msg.sender];
        return (patients.id, patients.name, patients.age, patients.disease);
    }

}
    
