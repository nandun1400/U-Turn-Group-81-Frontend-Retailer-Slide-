import 'package:flutter/material.dart';
import '../../data_classes/vehicle.dart';
import '../../global/global_settings.dart';
import '../../utils/image_convert.dart';
import 'PurchasePage.dart';

class VehicleDetailsPage extends StatelessWidget {
  final Vehicle vehicle;

  VehicleDetailsPage({required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: Icon(
      //       Icons.close,
      //       color: Colors.grey,
      //     ),
      //     onPressed: () {
      //       Navigator.of(context).pop();
      //     },
      //   ),
      // ),
      backgroundColor: Color(0xFFF7F7F7),
      body: Container(
        margin: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: NetworkImage(
                              convertToDirectLink(vehicle.imageUrl)),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Icon(
                          Icons.close,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      vehicle.model,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF40279D),
                      ),
                    ),
                    Text(
                      '4.8',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 21.0,
                        fontWeight: FontWeight.w800,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildAttributeContainer(
                        Icons.speed, vehicle.power.toString(), "Power"),
                    _buildAttributeContainer(Icons.account_circle, "People",
                        vehicle.numberOfPeople.toString()),
                    _buildAttributeContainer(Icons.card_travel, "Bags",
                        vehicle.capacityForBags.toString()),
                  ],
                ),
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    vehicle.description,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            Expanded(child: SizedBox(height: 16)),
            if(globalData.isCustomer) SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.indigo,
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                onPressed: () {
                  // Navigate to PurchasePage and pass the selected vehicle
                   Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PurchasePage(vehicle: vehicle),
                    ),
                  );
                },
                child: Text('Select'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttributeContainer(
      IconData iconData, String value, String value2) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Icon(
                iconData,
                color: Color(0xFF40279D),
                size: 36,
              ),
            ),
            SizedBox(height: 4),
            Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 4),
            Text(
              value2,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 19.0,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
