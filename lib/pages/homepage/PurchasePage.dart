import 'package:flutter/material.dart';
import 'package:goal_setting/pages/homepage/paymentGateway.dart';
import '../../data_classes/vehicle.dart';
import '../../utils/image_convert.dart';
import 'completionPage.dart';
class PurchasePage extends StatefulWidget {
  final Vehicle vehicle;

  PurchasePage({required this.vehicle});

  @override
  _PurchasePageState createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  bool driverRequired = false;
  int numberOfKilometers = 0;
  int numberOfVehicles = 1;
  int numberOfDays = 1;

  double finalPrice = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      body: Stack(
        children: [
          Opacity(
            opacity:0.3,
            child: Container(
              height:300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0),
                image: DecorationImage(
                  image: NetworkImage(convertToDirectLink(widget.vehicle.imageUrl)),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Stack(
              children: [
                Container(
                  height:MediaQuery.of(context).size.height - 32,
                  width:MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(height:84,),
                      _buildVehicleDetails(),
                      SizedBox(height: 24),
                      _buildPurchaseConfiguration(),
                      SizedBox(height: 24),
                      _buildFinalPrice(),
                      SizedBox(height: 24),
                      _buildPurchaseButton(),
                    ],
                  ),
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
        ],
      ),
    );
  }

  Widget _buildVehicleDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Vehicle Details',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Text('Model: ${widget.vehicle.model}', style: TextStyle(fontSize: 16)),
        Text('Type: ${widget.vehicle.type}', style: TextStyle(fontSize: 16)),
        Text('Brand: ${widget.vehicle.brand}', style: TextStyle(fontSize: 16)),
        Text('Power: ${widget.vehicle.power}', style: TextStyle(fontSize: 16)),
        Text('Number of People: ${widget.vehicle.numberOfPeople}', style: TextStyle(fontSize: 16)),
        Text('Capacity for Bags: ${widget.vehicle.capacityForBags}', style: TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _buildPurchaseConfiguration() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Purchase Configuration',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        SwitchListTile(
          title: Text('Driver Required'),
          value: driverRequired,
          onChanged: (value) {
            setState(() {
              driverRequired = value;
              _calculateFinalPrice();
            });
          },
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Number of Kilometers'),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            setState(() {
              numberOfKilometers = int.tryParse(value) ?? 0;
              _calculateFinalPrice();
            });
          },
        ),
        Row(
          children: [
            Text('Number of Vehicles: $numberOfVehicles'),
            Expanded(
              child: Slider(
                value: numberOfVehicles.toDouble(),
                min: 1,
                max: widget.vehicle.numberOfVehiclesAvailable.toDouble(),
                onChanged: (double value) {
                  setState(() {
                    numberOfVehicles = value.toInt();
                    _calculateFinalPrice();
                  });
                },
              ),
            ),
          ],
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Number of Days'),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            setState(() {
              numberOfDays = int.tryParse(value) ?? 1;
              _calculateFinalPrice();
            });
          },
        ),
      ],
    );
  }

  Widget _buildFinalPrice() {
    return Text(
      'Final Price: \$${finalPrice.toStringAsFixed(2)}',
      style: TextStyle(fontSize: 18, color: Colors.indigo),
    );
  }

  Widget _buildPurchaseButton() {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: () {
          _navigateToPaymentGateway();
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>( Colors.indigo,),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        child: Text(
          'Purchase',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  void _calculateFinalPrice() {
    double price = widget.vehicle.priceInDollars;

    if (driverRequired) {
      price += widget.vehicle.priceForDriverPerDay * numberOfDays*numberOfVehicles;
    }

    price += widget.vehicle.pricePerKilometer * numberOfKilometers * numberOfVehicles;

    setState(() {
      finalPrice = price;
    });
  }

  void _navigateToPaymentGateway() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentGateway(
          vehicle: widget.vehicle,
          finalPrice: finalPrice,
          numberOfKilometers: numberOfKilometers,
          numberOfVehicles: numberOfVehicles,
          numberOfDays: numberOfDays,
        ),
        // builder: (context) => CompletionScreen(
        //   vehicle: widget.vehicle,
        //   finalPrice: finalPrice,
        //   numberOfKilometers: numberOfKilometers,
        //   numberOfVehicles: numberOfVehicles,
        //   numberOfDays: numberOfDays,
        // ),
      ),
    );
  }
}
