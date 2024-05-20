class UserModel {
  final String id;
  final String fullName;
  final String? email;

  UserModel( { required this.id, required this.fullName, required this.email} );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      fullName: json['fullName'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'fullName': fullName,
      'email': email,
    };
  }
}