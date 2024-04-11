// Import statements
import 'dart:convert';

import 'package:flutter/material.dart';
import '../../../data_classes/vehicle.dart';
import '../../../data_classes/vehicle_dummy_data.dart';
import '../../../data_from_server/initData.dart';
import '../../../global/api_caller.dart';
import '../../../global/global_settings.dart';
import '../../../utils/error_handling.dart';
import '../../../utils/user_credentials.dart';
import '../forgot_password/forgot_password_page.dart';
import 'package:http/http.dart' as http;


// LoginPage class
class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

// _LoginPageState class
class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false; // Flag to track loading state


  Map<String, String> errorMessages = {}; // Error messages


// Function to send a POST request to fetch vehicle data from the backend
  Future<void> test_post() async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:3500/test_post'), // Endpoint to fetch vehicle data
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{}), // No body required for this request
      );

      if (response.statusCode == 200) {
        // Decode the response body
        final jsonData = jsonDecode(response.body);

        // Check if the "data" key exists in the response
        if (jsonData.containsKey('data')) {
          // Initialize the list to store Vehicle objects


          // Iterate through the "data" property and create Vehicle objects
          for (var item in jsonData['data']) {
            Vehicle vehicle = Vehicle.fromJson(item);
            vehicleList.addVehicle(vehicle);
          }

          // Print the initialized data
          // print('Initialized Data: ${vehicleList.arrayLength()}');
          // vehicleList.printAllVehicleDetails();
          // vehicleList.filterByBrandAndType("Nissan", "Car").printAllVehicleDetails();
          // vehicleList.filterByBrand("BMW").printAllVehicleDetails();

          // Optionally, you can assign the initialized data to a global variable for later use
          // globalData.initializedData = initializedData;
        } else {
          print('No "data" key found in the response');
        }
      } else {
        print('Failed to fetch vehicle data: ${response.statusCode}');
      }
    } catch (error) {
      print('Error occurred while fetching vehicle data: $error');
    }
  }





  Future<void> test_post_rended() async {


    // TODO: API call to signup
    try {
      var response = await http.post(
        Uri.parse('${globalData.baseUrlRoute}/test_post_rended'),
        body: jsonEncode({
          'vehicle':  jsonEncode(<String, dynamic>{}),
          'username': globalData.isCustomer ? globalData.username:"",
          'password': globalData.isCustomer ? globalData.password:"",
          // 'username': globalData.isCustomer ? "":"",
          // 'password': globalData.isCustomer ? "":"",
        }),
        headers: {'Content-Type': 'application/json'},
      );

      // Check response status code
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        // Check if the "data" key exists in the response
        if (jsonData.containsKey('data')) {
          // Initialize the list to store Vehicle objects


          // Iterate through the "data" property and create Vehicle objects
          for (var item in jsonData['data']) {
            Vehicle vehicle = Vehicle.fromJson(item);
            RentedvehicleList.addVehicle(vehicle);
          }

          // Print the initialized data
          print('Initialized Data: ${RentedvehicleList.arrayLength()}');
          RentedvehicleList.printAllVehicleDetails();
          // vehicleList.filterByBrandAndType("Nissan", "Car").printAllVehicleDetails();
          // vehicleList.filterByBrand("BMW").printAllVehicleDetails();

          // Optionally, you can assign the initialized data to a global variable for later use
          // globalData.initializedData = initializedData;
        } else {
          print('No "data" key found in the response');
        }
        // Navigate to home page
        // Navigator.pushReplacementNamed(context, '/login');
      } else {
        print('Error occurred: ');
      }
    } catch (e) {
      print('Error occurred: $e');

    }
  }


  // Function to handle login
  Future<void> handleLogin() async {



    // await Future.delayed(Duration(seconds: 2));
    //
    // // Upon successful login, call the test_post method
    // await test_post();
    // await test_post_rended();
    //
    // // Navigate to home page
    // Navigator.pushReplacementNamed(context, '/home');
    // // Set loading state to false
    // setState(() {
    //   isLoading = false;
    // });

    //
    String username = usernameController.text;
    String password = passwordController.text;

    // Validate input fields
    if (!_validateInputFields()) {
      return;
    }

    // Create a map containing the user's credentials
    Map<String, dynamic> body = {
      'username': username,
      'password': password,
    };

    try {
      // Make the API call using the ApiCaller object
      Map<String, dynamic>? response = await apiCaller.callApi('login', body);

      if (response != null && response['success']) {
        setState(() {
          isLoading = true;
        });
        // Login successful
        print('Login successful. User data: ${response['user']}');

        // Save credentials in SharedPreferences
        await userCredentials.saveCredentials(username, password);

        // Update GlobalData with the latest credentials
        await globalData.updateData();

        // Print updated credentials
        globalData.printData();

        await Future.delayed(Duration(seconds: 2));

        // Upon successful login, call the test_post method
        await test_post();
        await test_post_rended();

        // Navigate to home page
        Navigator.pushReplacementNamed(context, '/home');
        // Set loading state to false
        setState(() {
          isLoading = false;
        });
      } else {
        // Login failed
        setState(() {
          errorMessages['general'] =
          ErrorHandling.loginErrors['general']['invalidCredentials']!;
        });
      }
    } catch (e) {
      // Handle errors
      print('Error occurred: $e');
      setState(() {
        errorMessages['general'] =
        ErrorHandling.loginErrors['general']['serverError']!;
      });
    }
  }

  // Function to validate input fields
  bool _validateInputFields() {
    bool isValid = true;
    errorMessages.clear();

    // Username validation
    if (usernameController.text.isEmpty) {
      errorMessages['username'] =
      ErrorHandling.loginErrors['username']['required']!;
      isValid = false;
    }

    // Password validation
    if (passwordController.text.isEmpty) {
      errorMessages['password'] =
      ErrorHandling.loginErrors['password']['required']!;
      isValid = false;
    }

    setState(() {});
    return isValid;
  }

  // Function to handle "Forgot Password" button tap
  void handleForgotPassword() {
    if (globalData.forgotPass) {
      // Show the Forgot Password model bottom sheet
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return ForgotPasswordModelBottomSheet();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(), // Circular loading indicator
      )
          : Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Login',
              style: TextStyle(
                fontSize: 36.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            SizedBox(height: 24.0),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                errorText: errorMessages['username'],
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8.0), // Adjust border radius as needed
                ),
                filled: true,
                fillColor: Colors.white, // Specify background color
                contentPadding: EdgeInsets.all(16.0), // Adjust padding as needed
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8.0), // Adjust border radius as needed
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8.0), // Adjust border radius as needed
                  // Optionally, you can specify elevation for focused state
                  // elevation: 2.0,
                ),
              ),
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                errorText: errorMessages['password'],
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8.0), // Adjust border radius as needed
                ),
                filled: true,
                fillColor: Colors.white, // Specify background color
                contentPadding: EdgeInsets.all(16.0), // Adjust padding as needed
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8.0), // Adjust border radius as needed
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8.0), // Adjust border radius as needed
                  // Optionally, you can specify elevation for focused state
                  // elevation: 2.0,
                ),
              ),
              obscureText: true,
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            if (errorMessages
                .containsKey('general')) // Show general error message
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  errorMessages['general']!,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: handleLogin,
              child: Text('Login'),
            ),
            SizedBox(height: 16),
            if (globalData
                .forgotPass) // Show "Forgot Password" button conditionally
              TextButton(
                onPressed: handleForgotPassword,
                child: Text(
                  'Forgot Password',
                  // style: AppTheme.forgotPasswordTextStyle, // Apply custom text style
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'New user? ',
                  style: Theme.of(context).textTheme.button!.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: Text(
                    'Sign Up',
                    style: Theme.of(context).textTheme.button!.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}




















