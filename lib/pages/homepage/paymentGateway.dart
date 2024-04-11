import 'package:flutter/material.dart';
import '../../data_classes/vehicle.dart';
import 'completionPage.dart';

class PaymentGateway extends StatefulWidget {
  final Vehicle vehicle;
  final double finalPrice;
  final int numberOfKilometers;
  final int numberOfVehicles;
  final int numberOfDays;

  PaymentGateway({
    required this.vehicle,
    required this.finalPrice,
    required this.numberOfKilometers,
    required this.numberOfVehicles,
    required this.numberOfDays,
  });

  @override
  _PaymentGatewayState createState() => _PaymentGatewayState();
}

class _PaymentGatewayState extends State<PaymentGateway> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _cardNumberController = TextEditingController();
  TextEditingController _expiryDateController = TextEditingController();
  TextEditingController _cvvController = TextEditingController();
  bool _isValid = false;

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: SizedBox(height: 32)),
                Text(
                  'Enter Card Details',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 32),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CardInputField(
                        controller: _cardNumberController,
                        labelText: 'Card Number',
                        hintText: 'XXXX XXXX XXXX XXXX',
                        validator: (value) {
                          if (value == null || value.isEmpty || !RegExp(r'^[0-9]{16}$').hasMatch(value)) {
                            return 'Please enter a valid 16-digit card number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: CardInputField(
                              controller: _expiryDateController,
                              labelText: 'Expiry Date',
                              hintText: 'MM/YY',
                              validator: (value) {
                                if (value == null || value.isEmpty || !RegExp(r'^\d{2}\/\d{2}$').hasMatch(value)) {
                                  return 'Please enter a valid expiry date in MM/YY format';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: CardInputField(
                              controller: _cvvController,
                              labelText: 'CVV',
                              hintText: 'XXX',
                              validator: (value) {
                                if (value == null || value.isEmpty || !RegExp(r'^[0-9]{3}$').hasMatch(value)) {
                                  return 'Please enter a valid 3-digit CVV';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _isValid = true;
                        });
                        _navigateToCompletionScreen();
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo,),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    child: Text(
                      'Proceed to Completion',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(height: 0),
                // if (!_isValid && _formKey.currentState != null && !_formKey.currentState!.validate())
                //   Text(
                //     'Please correct the errors above',
                //     style: TextStyle(color: Colors.red, fontSize: 16),
                //   ),
              ],
            ),
            IconButton(
              icon: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Icon(
                  Icons.close,
                  color: Colors.grey,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToCompletionScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => CompletionScreen(
          vehicle: widget.vehicle,
          finalPrice: widget.finalPrice,
          numberOfKilometers: widget.numberOfKilometers,
          numberOfVehicles: widget.numberOfVehicles,
          numberOfDays: widget.numberOfDays,
        ),
      ),
    );
  }
}

class CardInputField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final String? Function(String?) validator;

  const CardInputField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      keyboardType: TextInputType.number,
      validator: validator,
    );
  }
}
