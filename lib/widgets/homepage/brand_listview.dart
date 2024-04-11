import 'dart:math';

import 'package:flutter/material.dart';

import '../../data_from_server/initData.dart';

class ButtonListView extends StatelessWidget {
  final Function(String) onBrandSelected;

  ButtonListView({required this.onBrandSelected});

  final List<Map<String, dynamic>> items=[
    {
      'id': 1,
      'brand': "Hyundai",
      'url': 'assets/images/home/1.png',
    },
    {
      'id': 2,
      'brand': "Volkswagen",
      'url': 'assets/images/home/2.png',
    },
    {
      'id': 3,
      'brand': "Toyota",
      'url': 'assets/images/home/3.png',
    },
    {
      'id': 4,
      'brand': 'BMW',
      'url': 'assets/images/home/4.png',
    },
    {
      'id': 5,
      'brand': "Nissan",
      'url': 'assets/images/home/5.png',
    },
  ];

  // ButtonListView({required this.items});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final item in items)
            Padding(
              padding: const EdgeInsets.only(right: 36.0),
              child: _buildItem(item),
            ),
        ],
      ),
    );
  }

  Widget _buildItem(Map<String, dynamic> item) {
    final brand = item['brand'];

    final assetPath = item['url'];

    return GestureDetector(
      onTap: () {
        onBrandSelected(brand); // Call the callback function with the selected brand
      },
      child: Container(
        height: 64,
        width: 64,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Image.asset(
            assetPath,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }

}
