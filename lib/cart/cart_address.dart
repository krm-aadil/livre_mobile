import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartAddress extends StatefulWidget {
  @override
  _CartAddressState createState() => _CartAddressState();
}

class _CartAddressState extends State<CartAddress> {
  LatLng? _selectedLocation;
  LocationData? _currentLocation;
  GoogleMapController? _mapController;
  SharedPreferences? _prefs;

  @override
  void initState() {
    super.initState();
    _getLocation();
    _initSharedPreferences();
    _loadSavedLocation();
  }

  Future<void> _getLocation() async {
    // ... (same as before)
  }

  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> _loadSavedLocation() async {
    final double? savedLatitude = _prefs?.getDouble('latitude');
    final double? savedLongitude = _prefs?.getDouble('longitude');
    if (savedLatitude != null && savedLongitude != null) {
      setState(() {
        _selectedLocation = LatLng(savedLatitude, savedLongitude);
      });
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _updateSelectedLocation(LatLng location) {
    setState(() {
      _selectedLocation = location;
    });
  }

  void _saveAndProceedToCheckout() async {
    if (_selectedLocation != null) {
      // Save the selected location to SharedPreferences
      await _prefs?.setDouble('latitude', _selectedLocation!.latitude);
      await _prefs?.setDouble('longitude', _selectedLocation!.longitude);
    }

    // Navigate back to cart_page.dart
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Delivery Address',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Please select your delivery location:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Stack(
                children: [
                  Container(
                    height: 200,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: _selectedLocation ?? LatLng(7.8731, 80.7718),
                        zoom: 24,
                      ),
                      onMapCreated: _onMapCreated,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      onTap: _updateSelectedLocation,
                      markers: Set<Marker>.from([
                        Marker(
                          markerId: MarkerId('selectedLocation'),
                          position:
                              _selectedLocation ?? LatLng(7.8731, 80.7718),
                          icon: BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueAzure,
                          ),
                        ),
                      ]),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.location_pin,
                      size: 40,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Selected Location:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (_selectedLocation != null) ...[
                Text(
                  'Latitude: ${_selectedLocation!.latitude}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Longitude: ${_selectedLocation!.longitude}',
                  style: TextStyle(fontSize: 16),
                ),
              ],
              SizedBox(height: 16),
              Text(
                'Delivery Address Details:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Street Number',
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Street Address',
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'City',
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveAndProceedToCheckout,
                child: Text('Save and Proceed to Checkout'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.teal,
                  onPrimary: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
