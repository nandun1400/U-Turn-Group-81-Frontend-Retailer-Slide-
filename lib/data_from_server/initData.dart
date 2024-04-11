import '../data_classes/vehicle.dart';

class VehicleList {
  List<Vehicle> _vehicles = [];



  // Method to add a vehicle to the list
  void addVehicle(Vehicle vehicle) {
    _vehicles.add(vehicle);
  }

  // Method to remove a vehicle from the list
  void removeVehicle(Vehicle vehicle) {
    _vehicles.remove(vehicle);
  }

  // Method to get the total number of vehicles in the list
  int getTotalVehicles() {
    return _vehicles.length;
  }

  // Method to get a specific vehicle from the list by index
  Vehicle getVehicle(int index) {
    if (index >= 0 && index < _vehicles.length) {
      return _vehicles[index];
    } else {
      throw Exception('Index out of bounds');
    }
  }

  int arrayLength() {
    return _vehicles.length;
  }

  // Method to print details of all vehicles in the list
  void printAllVehicleDetails() {
    print('Details of all vehicles:');
    for (var vehicle in _vehicles) {
      vehicle.printVehicleDetails();
    }
  }

  // Getter to retrieve the internal list of vehicles
  List<Vehicle> get vehicles => _vehicles;



  // TODO: Add method for filtering vehicles by brand only
  // Method to filter vehicles by brand
  VehicleList filterByBrand(String brandName) {
    VehicleList filteredList = VehicleList();
    for (var vehicle in _vehicles) {
      if (vehicle.brand == brandName) {
        filteredList.addVehicle(vehicle);
      }
    }
    return filteredList;
  }
  // TODO: method for filtering vehicles by brand and type combination
  // Method to filter vehicles by brand and type combination
  VehicleList filterByBrandAndType(String brandName, String typeName) {
    VehicleList filteredList = VehicleList();
    for (var vehicle in _vehicles) {
      if (vehicle.brand == brandName && vehicle.type == typeName) {
        filteredList.addVehicle(vehicle);
      }
    }
    return filteredList;
  }

  // TODO:Method to get a set of all unique vehicle types
  List<String> getAllVehicleTypes() {
    Set<String> types = Set(); // Initialize an empty set to store types
    for (var vehicle in _vehicles) {
      types.add(vehicle.type); // Add the type of each vehicle to the set
    }
    return types.toList(); // Convert the set to a list and return
  }


  // TODO: Method to split the vehicle list into two lists based on a ratio (rounded up)
  List<VehicleList> splitByRatio(double ratio) {
    if (ratio < 0 || ratio > 1) {
      throw ArgumentError('Ratio must be between 0.0 and 1.0');
    }

    int splitIndex = (ratio * _vehicles.length).ceil(); // Round up for first list

    VehicleList firstList = VehicleList();
    VehicleList secondList = VehicleList();

    for (int i = 0; i < splitIndex; i++) {
      firstList.addVehicle(_vehicles[i]);
    }

    for (int i = splitIndex; i < _vehicles.length; i++) {
      secondList.addVehicle(_vehicles[i]);
    }

    return [firstList, secondList]; // Return a list containing both sub-lists
  }
}





VehicleList vehicleList = VehicleList();


VehicleList RentedvehicleList = VehicleList();