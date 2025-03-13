import 'package:flutter/material.dart';
import '../models/restaurant.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantDetailScreen({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ข้อมูลร้านอาหาร'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: const Color(0xFFF57C00).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Icon(
                  Icons.restaurant,
                  size: 50,
                  color: Color(0xFFF57C00),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Text(
                restaurant.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF424242),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF57C00).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  restaurant.category,
                  style: const TextStyle(
                    color: Color(0xFFF57C00),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            const DetailSectionTitle(title: 'สถานที่ตั้ง'),
            const SizedBox(height: 8),
            DetailCard(
              icon: Icons.location_on,
              content: restaurant.location,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class DetailSectionTitle extends StatelessWidget {
  final String title;

  const DetailSectionTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: const Color(0xFFF57C00),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF424242),
          ),
        ),
      ],
    );
  }
}

class DetailCard extends StatelessWidget {
  final IconData icon;
  final String content;

  const DetailCard({
    Key? key,
    required this.icon,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: const Color(0xFFF57C00),
            size: 20,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              content,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF424242),
              ),
            ),
          ),
        ],
      ),
    );
  }
}