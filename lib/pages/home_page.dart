import 'dart:math';

import 'package:flutter/material.dart';
import '../data_from_server/initData.dart';
import '../global/global_settings.dart';
import '../page_viewer.dart';
import '../utils/theme.dart';
import '../widgets/homepage/ReusableContainerWidget.dart';
import '../widgets/homepage/VehicleListView.dart';
import '../widgets/homepage/brand_listview.dart';
import '../widgets/homepage/typeListView.dart';
import 'app_drawer.dart';
import 'homepage/VehicleRentalListView.dart';
import 'homepage/createVehicleModelPage.dart';




class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedBrand = "Hyundai"; // Track the selected brand
  String selectedType = "Car"; // Track the selected brand

  int _selectedIndex = 0;
  PageController _pageController = PageController();

  bool _isAnimating = false;

  void updateSelectedType(String type) {
    setState(() {
      selectedType = type;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false; // Prevent going back
      },
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          children: [
            Page1(
              onBrandSelected: (brand) {
                setState(() {
                  selectedBrand = brand;

                });
              },
              selectedBrand: selectedBrand,
              onTypeSelected: (type) {
                updateSelectedType(type);
              }, selectedType: 'Car',
            ),
            Page2(),
            NewVehiclePage(),
            // Page4(),
          ],
        ),
        drawer: globalData.enableDrawer ? AppDrawer() : null,
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: AppTheme.themeData.primaryColor,
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Add car',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.arrow_back_ios_outlined),
            //   label: 'Settings',
            // ),
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int pageIndex) {
    int currentPageIndex = _pageController.page!.round();
    int difference = (pageIndex - currentPageIndex).abs();
    int transitionTimeInMilisec = difference * globalData.homePageViewTransTime;
    if (!_isAnimating) {
      _isAnimating = true;
      Future.delayed(Duration(milliseconds: transitionTimeInMilisec), () {
        setState(() {
          _selectedIndex = pageIndex;
        });
      });
      _animateToPage(pageIndex, transitionTimeInMilisec);
    }
  }

  void _animateToPage(int pageIndex, int transitionTimeInMilisec) {
    _pageController
        .animateToPage(
      pageIndex,
      duration: Duration(
          milliseconds:
          transitionTimeInMilisec), // Adjust duration for smoother animation
      curve: Curves.easeInOut,
    )
        .then((value) {
      setState(() {
        _isAnimating = false;
      });
    });
  }
}

class Page1 extends StatefulWidget {
  final Function(String) onBrandSelected;
  final Function(String) onTypeSelected; // Add this line
  final String selectedBrand;
  final String selectedType;


  Page1({required this.onBrandSelected, required this.onTypeSelected, required this.selectedBrand, required this.selectedType});


  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  String selectedBrand = "Hyundai"; // Track the selected brand
  String selectedType = "Car"; // Track the selected type
  late VehicleList filteredVehicleList; // Variable to hold filtered vehicle list

  @override
  void initState() {
    super.initState();
    // Initialize filteredVehicleList with initial values
    _updateFilteredVehicleList(widget.selectedBrand, widget.selectedType);
  }

  // Method to filter VehicleList based on selected brand and type
  void _updateFilteredVehicleList(String selectedBrand, String selectedType) {
    setState(() {
      filteredVehicleList = vehicleList.filterByBrandAndType(selectedBrand, selectedType);
    });
  }

  @override
  Widget build(BuildContext context) {
    VehicleList selectedVehicleList = vehicleList.filterByBrand(widget.selectedBrand);
    List<String> selectedTypes = selectedVehicleList.getAllVehicleTypes();

    VehicleList selectedTypedVehicleList = selectedVehicleList.filterByBrandAndType(widget.selectedBrand, widget.selectedType);
    List<String> selectedModels = selectedTypedVehicleList.getAllVehicleTypes(); //TODO


    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
          
                children: [
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Icon(
                      Icons.menu, // Icon for drawer
                      color: Color(0xFF40279D), // Customize icon color
                      size:24,
                    ),
                  ),
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Icon(
                      Icons.search, // Icon for search
                      color: Color(0xFF40279D), // Customize icon color
                      size:24,
                    ),
                  ),
                ],
              ),
              SizedBox(height:24),
              ReusableContainerWidget(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 20.0),
                      Text(
                        'With Corporate Difference',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF40279D),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'Enjoyed Firm, Fund, or Driving Enterprise',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12.0),
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Container(
                              height: 48, // Adjust the height as needed
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Search a car',
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Expanded(
                            flex: 1,
                            child: Container(
          
                              height: 48, // Adjust the height as needed
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Icon(Icons.equalizer),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF40279D)),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
          
                            ),
                          ),
                        ],
                      )
          
                    ],
                  ),
                ),
              ),
              Column(
                  children: [
          
                  ]
              ),
              SizedBox(height:24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
          
                children: [
                  Text(
                    'Top Brands',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF40279D),
                    ),
                  ),
                  Text(
                    'View All',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
          // TODO: Implementation of the listitem click
              Container(
                height: 115,
                child: ButtonListView(
                  onBrandSelected: (brand) {
                    setState(() {
                      widget.onBrandSelected(brand);
                      print(brand);
                      print(selectedType);
                      selectedBrand = brand;
                      _updateFilteredVehicleList(brand, selectedType);
                    });
                  },
                ),
              ),
          
              SizedBox(height:24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
          
                children: [
                  Text(
                    'Most Rated',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF40279D),
                    ),
                  ),
                  Text(
                    'View All',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              SizedBox(height:24),
              //TODO Add the listview here when ever the function is executed. the listview should be updated with the passed array to the function
              TypeListView(
                types: selectedTypes,
                onTypeSelected: (type) {
                  setState(() {
                    print(type);
                    print(selectedBrand);
                    selectedType = type;
                    _updateFilteredVehicleList(selectedBrand, type);
                  });
                },
              ),
          
              SizedBox(height:24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
          
                children: [
                  Text(
                    'Most Rated',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF40279D),
                    ),
                  ),
                  Text(
                    'View All',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              Container(
                height: 184,
                child: VehicleListView(vehicleList: filteredVehicleList),
              ),
          
              // TODO: ADD this new listview to this level;
            ],
          ),
        ),
      ),
    );
  }
}

class Page2 extends StatefulWidget {
  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {

  @override
  void initState() {
    super.initState();

  }


  List<VehicleList> tempVehicleList = RentedvehicleList.splitByRatio(0.5);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Icon(
                      Icons.menu, // Icon for drawer
                      color: Color(0xFF40279D), // Customize icon color
                      size:24,
                    ),
                  ),
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Icon(
                      Icons.search, // Icon for search
                      color: Color(0xFF40279D), // Customize icon color
                      size:24,
                    ),
                  ),
                ],
              ),
              SizedBox(height:24),
              ReusableContainerWidget(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 20.0),
                      Text(
                        globalData.isCustomer ? 'Customer view' : 'Retailer view' ,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF40279D),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        globalData.isCustomer ? 'Stay safe, happy drive' : 'All the rented vehicles realted details are listed' ,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12.0),
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Container(
                              height: 48, // Adjust the height as needed
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Search a car',
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Expanded(
                            flex: 1,
                            child: Container(

                              height: 48, // Adjust the height as needed
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Icon(Icons.equalizer),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF40279D)),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),

                            ),
                          ),
                        ],
                      )

                    ],
                  ),
                ),
              ),
              Column(
                  children: [

                  ]
              ),
              SizedBox(height:24),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text(
                    globalData.isCustomer ? 'Your Rented Vehicles' : 'All on hired state' ,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF40279D),
                    ),
                  ),
                  Text(
                    'View All',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              SizedBox(height:24),
              Container(
                height: 200,
                child: VehicleRentalListView(
                    vehicleList: tempVehicleList[0],
                ),
              ),
              SizedBox(height:24),
              Container(
                height: 200,
                child: VehicleRentalListView(vehicleList: tempVehicleList[1]),
              ),
              // TODO: ADD this new listview to this level;
            ],
          ),
        ),
      ),
    );
  }
}

// class Page3 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Page 3'),
//     );
//   }
// }

class Page4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Page 4'),
    );
  }
}
