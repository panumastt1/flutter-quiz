import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/restaurant.dart';

class FirebaseService {
  final CollectionReference restaurantsCollection = 
      FirebaseFirestore.instance.collection('Restaurants');

  // เพิ่มร้านอาหารใหม่
  Future<void> addRestaurant(Restaurant restaurant) async {
    await restaurantsCollection.add(restaurant.toMap());
  }

  // ดึงข้อมูลร้านอาหารทั้งหมด
  Stream<List<Restaurant>> getRestaurants() {
    return restaurantsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Restaurant.fromMap(
          doc.data() as Map<String, dynamic>,
          doc.id,
        );
      }).toList();
    });
  }

  // อัพเดทข้อมูลร้านอาหาร
  Future<void> updateRestaurant(Restaurant restaurant) async {
    await restaurantsCollection.doc(restaurant.id).update(restaurant.toMap());
  }

  // ลบร้านอาหาร
  Future<void> deleteRestaurant(String restaurantId) async {
    await restaurantsCollection.doc(restaurantId).delete();
  }
}