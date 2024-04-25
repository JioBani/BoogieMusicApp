class User{
  String id;
  String name;
  String role;

  User({required this.id , required this.name , required this.role});

  factory User.fromMap(Map<String , dynamic> map){
    return User(
        id: map['user_id'],
        name: map['user_name'],
        role: map['role']
    );
  }
}