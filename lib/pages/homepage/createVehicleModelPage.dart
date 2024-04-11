import 'package:flutter/material.dart';
import '../../data_classes/vehicle.dart';
import '../../data_classes/vehicle_dummy_data.dart';
import '../../data_from_server/initData.dart';

class NewVehiclePage extends StatefulWidget {
  @override
  _NewVehiclePageState createState() => _NewVehiclePageState();
}

class _NewVehiclePageState extends State<NewVehiclePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _powerController = TextEditingController();
  final TextEditingController _numberOfPeopleController = TextEditingController();
  final TextEditingController _capacityForBagsController = TextEditingController();
  final TextEditingController _priceInDollarsController = TextEditingController();
  final TextEditingController _pricePerKilometerController = TextEditingController();
  final TextEditingController _priceForDriverPerDayController = TextEditingController();
  final TextEditingController _numberOfVehiclesAvailableController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  String _selectedBrand = 'Volkswagen'; // Default value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      // appBar: AppBar(
      //   title: Text('New Vehicle'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Container(
            height:MediaQuery.of(context).size.height-96,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Create new',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF40279D).withOpacity(0.7),
                    ),
                  ),
                  SizedBox(height: 24),
                  _buildDropdownButtonFormField(),
                  SizedBox(height: 16),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildTextField(controller: _typeController, labelText: 'Type')),
                      SizedBox(width: 16),
                      Expanded(child: _buildTextField(controller: _modelController, labelText: 'Model')),
                    ],
                  ),
                  SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(child: _buildNumberField(controller: _powerController, labelText: 'Power')),
                      SizedBox(width: 16),
                      Expanded(child: _buildNumberField(controller: _numberOfPeopleController, labelText: 'Number of People')),
                    ],
                  ),
                  SizedBox(height: 24),
                  _buildNumberField(controller: _capacityForBagsController, labelText: 'Capacity for Bags'),
                  SizedBox(height: 24),
                  _buildTextField(controller: _descriptionController, labelText: 'Description', maxLines: 3),
                  SizedBox(height: 8),
                  _buildTextField(controller: _imageUrlController, labelText: 'Image URL'),
                  SizedBox(height: 24),
                  _buildSubmitButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownButtonFormField() {
    return DropdownButtonFormField<String>(
      value: _selectedBrand,
      items: <String>['Volkswagen', 'Hyundai', 'Nissan', 'Toyota', 'BMW']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          _selectedBrand = newValue!;
        });
      },
      decoration: InputDecoration(
        labelText: 'Brand',
        border: OutlineInputBorder(),
        filled: true,
      ),
    );
  }

  // Widget _buildInlineFields() {
  //   return Row(
  //     children: [
  //       Expanded(child: _buildTextField(controller: _typeController, labelText: 'Type')),
  //       SizedBox(width: 16),
  //       Expanded(child: _buildTextField(controller: _modelController, labelText: 'Model')),
  //       SizedBox(width: 16),
  //       Expanded(child: _buildNumberField(controller: _powerController, labelText: 'Power')),
  //       SizedBox(width: 16),
  //       Expanded(child: _buildNumberField(controller: _numberOfPeopleController, labelText: 'Number of People')),
  //       SizedBox(width: 16),
  //       Expanded(child: _buildNumberField(controller: _capacityForBagsController, labelText: 'Capacity for Bags')),
  //     ],
  //   );
  // }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
        filled: true,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
    );
  }

  Widget _buildNumberField({
    required TextEditingController controller,
    required String labelText,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
        filled: true,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      height: 60,
      width: double.infinity,
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
          _submitForm();
        },
        child: Text('Submit'),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Create Vehicle object
      Vehicle newVehicle = Vehicle(
        brand: _selectedBrand,
        type: _typeController.text,
        model: _modelController.text,
        imageUrl: _imageUrlController.text,
        power: int.tryParse(_powerController.text) ?? 0,
        numberOfPeople: int.tryParse(_numberOfPeopleController.text) ?? 0,
        capacityForBags: int.tryParse(_capacityForBagsController.text) ?? 0,
        priceInDollars: double.tryParse(_priceInDollarsController.text) ?? 0.0,
        pricePerKilometer: double.tryParse(_pricePerKilometerController.text) ?? 0.0,
        priceForDriverPerDay: double.tryParse(_priceForDriverPerDayController.text) ?? 0.0,
        numberOfVehiclesAvailable: int.tryParse(_numberOfVehiclesAvailableController.text) ?? 0,
        description: _descriptionController.text,
      );


      // Print the new Vehicle object
      newVehicle.printVehicleDetails();

      vehicleList.addVehicle(newVehicle);

      sendDataToBackend([newVehicle]);

      // Show Snackbar
      final snackBar = SnackBar(
        content: Text('The new car model created', style: TextStyle(color: Colors.black, fontSize:20)),
        backgroundColor: Colors.grey[50],
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(bottom: 0.0),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // sendDataToBackend(DummyData);
      // You can perform further actions here, like saving the Vehicle object to a database
    }
  }
}
