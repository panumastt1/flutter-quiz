import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../services/firebase_service.dart';

class EditRestaurantScreen extends StatefulWidget {
  final Restaurant restaurant;

  const EditRestaurantScreen({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  State<EditRestaurantScreen> createState() => _EditRestaurantScreenState();
}

class _EditRestaurantScreenState extends State<EditRestaurantScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _categoryController;
  late TextEditingController _locationController;
  final FirebaseService _firebaseService = FirebaseService();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.restaurant.name);
    _categoryController = TextEditingController(text: widget.restaurant.category);
    _locationController = TextEditingController(text: widget.restaurant.location);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _updateRestaurant() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final updatedRestaurant = Restaurant(
          id: widget.restaurant.id,
          name: _nameController.text.trim(),
          category: _categoryController.text.trim(),
          location: _locationController.text.trim(),
        );

        await _firebaseService.updateRestaurant(updatedRestaurant);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('อัพเดทข้อมูลร้านอาหารเรียบร้อยแล้ว'),
              backgroundColor: Color(0xFFF57C00),
            ),
          );
          Navigator.pop(context);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('เกิดข้อผิดพลาด: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final categories = [
      'อาหารตามสั่ง',
      'ก๋วยเตี๋ยว',
      'อาหารญี่ปุ่น',
      'อาหารเกาหลี',
      'อาหารอีสาน',
      'อาหารใต้',
      'อาหารเหนือ',
      'อาหารทะเล',
      'ฟาสต์ฟู้ด',
      'ของหวาน',
      'เครื่องดื่ม',
      'อื่นๆ',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('แก้ไขข้อมูลร้านอาหาร'),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'แก้ไขข้อมูลร้านอาหาร',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'ชื่อร้านอาหาร',
                        prefixIcon: Icon(Icons.restaurant),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอกชื่อร้านอาหาร';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'ประเภทอาหาร',
                        prefixIcon: Icon(Icons.category),
                      ),
                      value: categories.contains(widget.restaurant.category)
                          ? widget.restaurant.category
                          : null,
                      hint: const Text('เลือกประเภทอาหาร'),
                      items: categories.map((category) {
                        return DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                      onChanged: (value) {
                        _categoryController.text = value ?? '';
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณาเลือกประเภทอาหาร';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _locationController,
                      decoration: const InputDecoration(
                        labelText: 'ที่ตั้ง',
                        prefixIcon: Icon(Icons.location_on),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอกที่ตั้งร้านอาหาร';
                        }
                        return null;
                      },
                      maxLines: 2,
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _updateRestaurant,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'บันทึกการแก้ไข',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}