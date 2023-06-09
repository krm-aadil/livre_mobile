import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartAddress extends StatefulWidget {
  @override
  _CartAddressState createState() => _CartAddressState();
}

class _CartAddressState extends State<CartAddress> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);
  LatLng _selectedLocation = const LatLng(45.521563, -122.677433);
  final Set<Marker> _markers = {};

  SharedPreferences? _prefs;

  String? streetNumber;
  String? streetAddress;
  String? city;
  String? country;

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
    _loadMarkerPosition();
  }

  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> _loadMarkerPosition() async {
    final double? latitude = _prefs?.getDouble('markerLatitude');
    final double? longitude = _prefs?.getDouble('markerLongitude');
    if (latitude != null && longitude != null) {
      setState(() {
        _selectedLocation = LatLng(latitude, longitude);
        _addMarker();
      });
    }
  }

  Future<void> _saveMarkerPosition() async {
    await _prefs?.setDouble('markerLatitude', _selectedLocation.latitude);
    await _prefs?.setDouble('markerLongitude', _selectedLocation.longitude);
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _addMarker();
  }

  void _addMarker() {
    setState(() {
      _markers.add(
        Marker(
          markerId: const MarkerId('marker_1'),
          position: _selectedLocation,
          draggable: true,
          onDragEnd: (LatLng newPosition) {
            setState(() {
              _selectedLocation = newPosition;
            });
          },
          infoWindow: const InfoWindow(
            title: 'Location',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );
    });
  }

  Future<String> _getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks != null && placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        String address = placemark.street ?? '';
        address +=
            placemark.subLocality != null ? ', ${placemark.subLocality}' : '';
        address += placemark.locality != null ? ', ${placemark.locality}' : '';
        address += placemark.subAdministrativeArea != null
            ? ', ${placemark.subAdministrativeArea}'
            : '';
        address += placemark.administrativeArea != null
            ? ', ${placemark.administrativeArea}'
            : '';
        address +=
            placemark.postalCode != null ? ', ${placemark.postalCode}' : '';
        address += placemark.country != null ? ', ${placemark.country}' : '';

        // Splitting the address to get street address and street number
        List<String> addressParts = address.split(',');
        if (addressParts.length >= 2) {
          streetAddress = addressParts[0].trim();
          streetNumber = addressParts[addressParts.length - 2].trim();
        }

        // Setting the city and country
        city = placemark.locality ?? '';
        country = placemark.country ?? '';

        return address;
      }
    } catch (e) {
      print(e);
    }

    return '';
  }

  Future<void> _saveAddressDetails() async {
    await _prefs?.setString('streetNumber', streetNumber ?? '');
    await _prefs?.setString('streetAddress', streetAddress ?? '');
    await _prefs?.setString('city', city ?? '');
    await _prefs?.setString('country', country ?? '');
  }

  Future<void> _submitLocation() async {
    await _saveMarkerPosition();
    await _saveAddressDetails();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Location saved')),
    );

    String savedLocation = await _getAddressFromLatLng(_selectedLocation);

    Navigator.pop(context, savedLocation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose your Location'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.teal,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 11.0,
                  ),
                  markers: _markers,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.teal,
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Location Details:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          FutureBuilder<String>(
                            future: _getAddressFromLatLng(_selectedLocation),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextFormField(
                                      initialValue: streetAddress,
                                      decoration: InputDecoration(
                                        labelText: 'Street Address',
                                      ),
                                      onChanged: (value) {
                                        streetAddress = value;
                                      },
                                    ),
                                    TextFormField(
                                      initialValue: streetNumber,
                                      decoration: InputDecoration(
                                        labelText: 'Street Number',
                                      ),
                                      onChanged: (value) {
                                        streetNumber = value;
                                      },
                                    ),
                                    TextFormField(
                                      initialValue: city,
                                      decoration: InputDecoration(
                                        labelText: 'City',
                                      ),
                                      onChanged: (value) {
                                        city = value;
                                      },
                                    ),
                                    TextFormField(
                                      initialValue: country,
                                      decoration: InputDecoration(
                                        labelText: 'Country',
                                      ),
                                      onChanged: (value) {
                                        country = value;
                                      },
                                    ),
                                    const SizedBox(height: 16),
                                    ElevatedButton(
                                      onPressed: _submitLocation,
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        primary: Colors.teal,
                                      ),
                                      child: Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16.0),
                                        alignment: Alignment.center,
                                        child: const Text(
                                          'Proceed to Checkout',
                                          style: TextStyle(fontSize: 16.0),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              } else if (snapshot.hasError) {
                                return const Text('Failed to get address');
                              } else {
                                return const CircularProgressIndicator();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
