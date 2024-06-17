import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart'; // Для получения адреса по координатам

class AddressPicker extends StatefulWidget {
  final String initialAddress;
  final Function(String) onAddressSelected;

  const AddressPicker({
    super.key,
    required this.initialAddress,
    required this.onAddressSelected,
  });

  @override
  AddressPickerState createState() => AddressPickerState();
}

class AddressPickerState extends State<AddressPicker> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  static const CameraPosition _kUlyanovsk = CameraPosition(
    target: LatLng(54.3143, 48.3764),
    zoom: 18,
  );

  String _selectedAddress = '';

  @override
  void initState() {
    super.initState();
    _selectedAddress = widget.initialAddress;
  }

  Future<void> _getAddressFromLatLng(LatLng position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks[0];
      setState(() {
        _selectedAddress = '${placemark.subThoroughfare}, ${placemark.street}, ${placemark.locality}';
      });
      widget.onAddressSelected(_selectedAddress);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 300,
          child: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kUlyanovsk,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            onTap: (LatLng position) {
              _getAddressFromLatLng(position);
            },
            gestureRecognizers: {
              Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer())
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Выбранный адрес: $_selectedAddress',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}