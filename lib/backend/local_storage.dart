import 'package:engineering_hub/model/student.dart';
import 'package:hive/hive.dart';

late Box<dynamic> localStorage;

class LocalStorage {
  // Local storage reference
  final _studentData = Hive.box('studentData');

  //? Write method
  //* It can also be used for update method
  //! The reason of using .put method and not the .add method is to assign our own key value so that while retrieving data we can simply pass it to Student.fromJson method which expects unique key pairs
  void writeStudentData(Student studentData) {
    _studentData.put('userId', studentData.userId);
    _studentData.put('collegeName', studentData.collegeName);
    _studentData.put('branchName', studentData.branchName);
    _studentData.put('semester', studentData.semester);
    _studentData.put('name', studentData.userName);
    _studentData.put('email', studentData.email);
    _studentData.put('phone', studentData.phoneNumber);
    _studentData.put('password', studentData.password);
  }

  //* Read method
  Student readStudentData() {
    Map<String, dynamic> studentData = {
      'id': _studentData.get('userId'),
      'college_name': _studentData.get('collegeName'),
      'branch': _studentData.get('branchName'),
      'semester': _studentData.get('semester'),
      'name': _studentData.get('name'),
      'email': _studentData.get('email'),
      'phone_no': _studentData.get('phone'),
      'password': _studentData.get('password'),
    };
    return Student.fromJson(studentData);
  }

  //! Delete method
  void deleteStudentData() {
    _studentData.clear();
  }
}
