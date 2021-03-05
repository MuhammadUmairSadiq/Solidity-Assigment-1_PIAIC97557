pragma solidity ^0.8.0;

contract EnrollStudent {
    address  payable private AccAddress = payable(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4);
    
    enum Gender {
        Male,
        Female
    }
    enum ClassType {
        Onsite, 
        Online
    }
    
    struct Student{
        string studentName;
        uint age;
        bool hasBSdegree;
        Gender gender;
        ClassType class;
        uint rollNumber;
    }
    uint public TotalStudents;
    
    mapping(uint => Student) studentData;
    
    function enrollStudent(string memory _name,uint _age,bool _haveDegree,Gender _gender,ClassType _class,uint _rollNumber) public payable {
         
        require(msg.value >= 2 ether);
       
        Student memory myStudent = Student(_name,_age,_haveDegree,_gender,_class,_rollNumber);
        
        AccAddress.transfer(msg.value);
        
        studentData[_rollNumber] = myStudent;
        TotalStudents++;
    }
    
    function getStudentData(uint _rollNumber)public view returns(string memory,uint,bool,Gender,ClassType,uint){
        return (
            studentData[_rollNumber].studentName,studentData[_rollNumber].age,studentData[_rollNumber].hasBSdegree,
            studentData[_rollNumber].gender,studentData[_rollNumber].class,studentData[_rollNumber].rollNumber
                );
    }
    
    function balance() public view returns(uint){
        return AccAddress.balance;
    }

    function hasDegree(uint _rollNumber)public view returns(bool){
        return studentData[_rollNumber].hasBSdegree;
    }
}