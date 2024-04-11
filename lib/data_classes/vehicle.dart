class Vehicle {
  String brand;
  String type;
  String model;

  String imageUrl;
  int power;
  int numberOfPeople;
  int capacityForBags;
  double priceInDollars;
  double pricePerKilometer;
  double priceForDriverPerDay;
  int numberOfVehiclesAvailable;
  String description;

  Vehicle({
    required this.brand,
    required this.type,
    required this.model,
    required this.imageUrl,
    required this.power,
    required this.numberOfPeople,
    required this.capacityForBags,
    required this.priceInDollars,
    required this.pricePerKilometer,
    required this.priceForDriverPerDay,
    required this.numberOfVehiclesAvailable,
    required this.description,
  });

  // Getters
  String getBrand() => brand;
  String getType() => type;
  String getModel() => model;
  String getImageUrl() => imageUrl;
  int getPower() => power;
  int getNumberOfPeople() => numberOfPeople;
  int getCapacityForBags() => capacityForBags;
  double getPriceInDollars() => priceInDollars;
  double getPricePerKilometer() => pricePerKilometer;
  double getPriceForDriverPerDay() => priceForDriverPerDay;
  int getNumberOfVehiclesAvailable() => numberOfVehiclesAvailable;
  String getDescription() => description;

  // Setters
  void setBrand(String newBrand) {
    brand = newBrand;
  }

  void setType(String newType) {
    type = newType;
  }

  void setModel(String newModel) {
    model = newModel;
  }

  void setImageUrl(String newImageUrl) {
    imageUrl = newImageUrl;
  }

  void setPower(int newPower) {
    power = newPower;
  }

  void setNumberOfPeople(int newNumberOfPeople) {
    numberOfPeople = newNumberOfPeople;
  }

  void setCapacityForBags(int newCapacityForBags) {
    capacityForBags = newCapacityForBags;
  }

  void setPriceInDollars(double newPriceInDollars) {
    priceInDollars = newPriceInDollars;
  }

  void setPricePerKilometer(double newPricePerKilometer) {
    pricePerKilometer = newPricePerKilometer;
  }

  void setPriceForDriverPerDay(double newPriceForDriverPerDay) {
    priceForDriverPerDay = newPriceForDriverPerDay;
  }

  void setNumberOfVehiclesAvailable(int newNumberOfVehiclesAvailable) {
    numberOfVehiclesAvailable = newNumberOfVehiclesAvailable;
  }

  void setDescription(String newDescription) {
    description = newDescription;
  }

  // Print method
  void printVehicleDetails() {
    print('Vehicle Details:');
    print('Brand: $brand');
    print('Type: $type');
    print('Model: $model');
    print('Image URL: $imageUrl');
    print('Power: $power');
    print('Number of People: $numberOfPeople');
    print('Capacity for Bags: $capacityForBags');
    print('Price in Dollars: $priceInDollars');
    print('Price per Kilometer: $pricePerKilometer');
    print('Price for Driver per Day: $priceForDriverPerDay');
    print('Number of Vehicles Available: $numberOfVehiclesAvailable');
    print('Description: $description');
  }

  // toJSON method
  Map<String, dynamic> toJson() {
    return {
      'brand': brand,
      'type': type,
      'model': model,
      'imageUrl': imageUrl,
      'power': power,
      'numberOfPeople': numberOfPeople,
      'capacityForBags': capacityForBags,
      'priceInDollars': priceInDollars,
      'pricePerKilometer': pricePerKilometer,
      'priceForDriverPerDay': priceForDriverPerDay,
      'numberOfVehiclesAvailable': numberOfVehiclesAvailable,
      'description': description,
    };
  }

  // fromJSON method
  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      brand: json['brand'],
      type: json['type'],
      model: json['model'],
      imageUrl: json['imageurl'], // Corrected key here
      power: json['power'],
      numberOfPeople: json['numberofpeople'], // Corrected key here
      capacityForBags: json['capacityforbags'], // Corrected key here
      priceInDollars: (json['priceindollars'] as num).toDouble(),
      pricePerKilometer: (json['priceperkilometer'] as num).toDouble(),
      priceForDriverPerDay: (json['pricefordriverperday'] as num).toDouble(),

      numberOfVehiclesAvailable: json['numberofvehiclesavailable'], // Corrected key here
      description: json['description'],
    );
  }
}
