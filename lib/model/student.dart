class Student {
  var userId;
  String collegeName;
  String branchName;
  String semester;
  String userName;
  String email;
  String phoneNumber;
  String password;
  Student(
    this.userId,
    this.collegeName,
    this.branchName,
    this.semester,
    this.userName,
    this.email,
    this.phoneNumber,
    this.password,
  );

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        json['id'],
        json['college_name'],
        json['branch'],
        json['semester'],
        json['name'],
        json['email'],
        json['phone_no'],
        json['password'],
      );

  Map<String, dynamic> toJson() => {
        'id': userId.toString(),
        'college_name': collegeName,
        'branch': branchName,
        'semester': semester,
        'name': userName,
        "email": email,
        "phone_no": phoneNumber,
        "password": password,
      };
}
