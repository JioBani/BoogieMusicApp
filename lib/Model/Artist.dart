class Artist{
  final int id;
  final String name;

  Artist({required this.id , required this.name});

  factory Artist.fromMap(Map<String , dynamic> map){
    return Artist(id: map['artist_id'], name: map['artist_name']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}