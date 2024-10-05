import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:paradise_sri_lanka/Services/LocationService.dart';

class MapMarkerWidget extends StatelessWidget {
  final List<dynamic> expandedLoc;

  const MapMarkerWidget({super.key, required this.expandedLoc});

  @override
  Widget build(BuildContext context) {
    // Ensure that each location is correctly passed as a String
    List<Marker> markers = expandedLoc
        .map((location) {
      // Get LatLng for each location string
      LatLng latLng = LocationService.getCityLatLng(location.toString());

      if (latLng == const LatLng(0,0)) {
        // Skip if LatLng is not valid (i.e., location not found)
        return null;
      }

      return Marker(
        point: latLng,
        width: 80.0,
        height: 80.0,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Text(
                location.toString(), // Convert location to string
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 8,
                ),
              ),
            ),
            const Icon(
              Icons.location_on,
              color: Colors.red,
              size: 30.0,
            ),
          ],
        ),
      );
    })
        .whereType<Marker>() // Automatically remove null markers
        .toList();

    return FlutterMap(
      options: const MapOptions(
        initialCenter: LatLng(7.8731, 80.7718), // Center of Sri Lanka
        initialZoom: 7.0,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: const ['a', 'b', 'c'],
        ),
        MarkerLayer(
          markers: markers,
        ),
      ],
    );
  }
}
