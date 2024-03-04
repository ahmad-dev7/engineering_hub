import 'dart:convert';
import 'package:engineering_hub/backend/local_storage.dart';
import 'package:engineering_hub/constants/ksnackbar.dart';
import 'package:engineering_hub/model/message_model.dart';
import 'package:engineering_hub/model/student.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api {
  String baseUrl = "http://engineeringhub.mooo.com/api";

  //* Validate Email or Phone number
  Future<bool> checkDatabase({
    required String name,
    required String value,
  }) async {
    String url = '$baseUrl/validate-$name.php/?$name=$value';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  //* getStudentRecord
  Future<bool> getData({
    required String email,
    required String password,
  }) async {
    var getStudentUrl = "$baseUrl/login.php/?email=$email&password=$password";

    try {
      var response = await http.get(Uri.parse(getStudentUrl));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        Student studentData = Student.fromJson(jsonData[0]);
        LocalStorage().writeStudentData(studentData);
        return true;
      } else {
        debugPrint("Credential is wrong");
        return false;
      }
    } catch (e) {
      KSnackBar("Failed to connect with server").failed();
      debugPrint(e.toString());
      throw "Unable to fetch data";
    }
  }

  //* addStudentRecord
  Future<bool> postData({
    required String collegeName,
    required String branch,
    required String semester,
    required String name,
    required String email,
    required String phoneNo,
    required String password,
  }) async {
    var postStudentUrl = '$baseUrl/signup.php';

    try {
      var response = await http.post(Uri.parse(postStudentUrl), body: {
        'collegeName': collegeName,
        'branch': branch,
        'semester': semester,
        'name': name,
        'email': email,
        'phoneNo': phoneNo,
        'password': password
      });
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 201) {
        await getData(email: email, password: password);
        return true;
      } else {
        return false;
      }
    } catch (exception) {
      debugPrint(exception.toString());
      throw false;
    }
  }

  //*  writeMessage
  void writeMessage({required message}) async {
    Student student = LocalStorage().readStudentData();
    var writeMessageUrl = '$baseUrl/message.php';
    var response = await http.post(
      Uri.parse(writeMessageUrl),
      body: {
        'senderId': student.userId,
        'collegeName': student.collegeName,
        'branchName': student.branchName,
        'semester': student.semester,
        'message': message,
        'senderName': student.userName,
        'timeStamp': DateTime.now().toString(),
      },
    );
    try {
      if (response.statusCode == 201) {
        debugPrint('Message posted successfully');
      } else {
        debugPrint(response.statusCode.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //* getMessage
  Future<List<Message>> getMessage({
    String? clg,
    String? brn,
    String? sem,
  }) async {
    Student student = LocalStorage().readStudentData();
    String college = clg ?? student.collegeName;
    String branch = brn ?? student.branchName;
    String semester = sem ?? student.semester;
    var getMessageUrl =
        '$baseUrl/message.php?collegeName=$college&branchName=$branch&semester=$semester';
    List<Message> messagesList = [];
    try {
      var response = await http.get(Uri.parse(getMessageUrl));
      if (response.statusCode == 200) {
        var jsonData = await jsonDecode(response.body);
        for (var data in jsonData) {
          Message message = Message.fromJson(data);
          messagesList.add(message);
        }
      } else if (response.statusCode == 401) {
        messagesList.clear();
        debugPrint('No message found here');
      }
    } catch (e) {
      debugPrint('Exception occurred');
      debugPrint(e.toString());
    }

    return messagesList;
  }

  //* UpdateMessage
  void updateMessage({required newMessage, required messageId}) async {
    String updateMEssageUrl = '$baseUrl/message.php';
    var response = await http.put(Uri.parse(updateMEssageUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(
          <String, String>{
            'messageId': messageId,
            'newMessage': newMessage,
          },
        ));
    debugPrint(response.body);
    debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      debugPrint('Message Updated successfully');
    } else {
      debugPrint('Failed to update message');
    }
  }

  //* DeleteMessage
  void deleteMessage({required messageId}) {
    String deleteMessageUrl = "$baseUrl/message.php?messageId=$messageId";
    http.delete(
      Uri.parse(deleteMessageUrl),
    );
  }
}
