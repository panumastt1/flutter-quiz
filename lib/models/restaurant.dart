class Restaurant {
  final String? id;
  final String name;
  final String category;
  final String location;

  Restaurant({
    this.id,
    required this.name,
    required this.category,
    required this.location,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'category': category,
      'location': location,
    };
  }

  factory Restaurant.fromMap(Map<String, dynamic> map, String documentId) {
    return Restaurant(
      id: documentId,
      name: map['name'] ?? '',
      category: map['category'] ?? '',
      location: map['location'] ?? '',
    );
  }
}