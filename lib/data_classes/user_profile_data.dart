import 'package:flutter/material.dart';

class UserData {
  final String name;
  final int age;
  final String username;
  final String email;
  final String mobile;
  final String password;

  UserData({
    required this.name,
    required this.age,
    required this.username,
    required this.email,
    required this.mobile,
    required this.password,
  });

  void printData() {
    print('Name: $name');
    print('Age: $age');
    print('Username: $username');
    print('Email: $email');
    print('Email: $mobile');
    print('Password: $password');
  }
}
