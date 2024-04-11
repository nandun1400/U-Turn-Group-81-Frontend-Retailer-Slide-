import 'package:flutter/material.dart';
import '../../data_classes/vehicle.dart';
import '../../data_from_server/initData.dart';
import '../../pages/homepage/VehicleDetailsPage.dart';
import '../../utils/image_convert.dart';

class VehicleRentalListView extends StatelessWidget {
  final VehicleList vehicleList;

  VehicleRentalListView({required this.vehicleList});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          vehicleList.arrayLength(),
              (index) {
            final vehicle = vehicleList.getVehicle(index);
            return GestureDetector(
              onTap: () {
                // Navigate to VehicleDetailsPage and pass the selected vehicle
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => VehicleDetailsPage(vehicle: vehicle),
                //   ),
                // );
              },
              child: _buildVehicleItem(vehicle),
            );
          },
        ),
      ),
    );
  }

  Widget _buildVehicleItem(Vehicle vehicle) {
    return Container(
      width: 275,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border.all(color: Colors.transparent),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 100,

            width: double.infinity,
            child: Image.network(
              convertToDirectLink(vehicle.imageUrl),
              fit: BoxFit.fitWidth,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    vehicle.brand + " " + vehicle.model,
                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,),
                  ),
                  // Text(
                  //   "\$" + vehicle.priceInDollars.toString(),
                  //   style: TextStyle(fontSize: 12),
                  // ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Sold count : " + vehicle.numberOfVehiclesAvailable.toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "\$" + vehicle.priceInDollars.toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                  // Text(
                  //   "\$" + vehicle.priceInDollars.toString(),
                  //   style: TextStyle(fontSize: 12),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
