import 'dart:convert';

import 'package:flutter/material.dart';

import '../../data_classes/vehicle.dart';
import '../../global/api_caller.dart';
import '../../global/global_settings.dart';
import 'package:http/http.dart' as http;






// Function to handle signup
Future<void> handle_Save_vehicle_rental(Vehicle dummyData, String route) async {


  // TODO: API call to signup
  try {
    var response = await http.post(
      Uri.parse('${globalData.baseUrlRoute}/${route}'),
      body: jsonEncode({
        'vehicle':  dummyData.toJson(),
        'username': globalData.username,
        'password': globalData.password,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    // Check response status code
    if (response.statusCode == 200) {
      var userData = jsonDecode(response.body)['user'];
      print('Signup successful. User data: $userData');

      // Navigate to home page
      // Navigator.pushReplacementNamed(context, '/login');
    } else {
      print('Error occurred: ');
    }
  } catch (e) {
    print('Error occurred: $e');

  }
}










class CompletionScreen extends StatelessWidget {
  final Vehicle vehicle;
  final double finalPrice;
  final int numberOfKilometers;
  final int numberOfVehicles;
  final int numberOfDays;

  CompletionScreen({
    required this.vehicle,
    required this.finalPrice,
    required this.numberOfKilometers,
    required this.numberOfVehicles,
    required this.numberOfDays,
  });

  @override
  Widget build(BuildContext context) {
    Vehicle rentIncrement = vehicle;
    rentIncrement.priceInDollars = finalPrice;
    rentIncrement.numberOfVehiclesAvailable = numberOfVehicles;
    handle_Save_vehicle_rental(rentIncrement,"save_vehicle_rental"); //TODO: API call to save rent side increment

    Vehicle AvailabilityDecrement = vehicle;
    AvailabilityDecrement.numberOfVehiclesAvailable -= numberOfVehicles;

    handle_Save_vehicle_rental(AvailabilityDecrement,"save_vehicle_availability"); //TODO: API call to save availability side decrement

    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 273),
          Center(
            child: Image.asset(
              'assets/images/home/complete.png',
              width: 128,
              height: 128,
              color:Colors.indigo,
            ),
          ),
          SizedBox(height: 48),
          Center(
            child: Text(
              "Order Successful",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontFamily: "SF Pro",
              ),
            ),
          ),
          SizedBox(height: 24),
          Center(
            child: Text(
              "Renting confirmed",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontFamily: "SF Pro",
              ),
            ),
          ),
          SizedBox(height: 16),
          Center(
            child: Text(
              "\$$finalPrice",
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w700,
                color: Colors.black,
                fontFamily: "SF Pro",
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: 60,
                  width: double.maxFinite,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>( Colors.indigo,),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      _navigateToHome(context);
                    },
                    child: Text(
                      "Done",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        fontFamily: "SF Pro",
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  void _navigateToHome(BuildContext context) {
    Navigator.popUntil(context, ModalRoute.withName('/home'));
  }
}
