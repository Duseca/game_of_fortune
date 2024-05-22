// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:custom_map_markers/custom_map_markers.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'dart:io';
// import 'dart:math' as math;
// import 'package:bike_gps/core/utils/snackbars.dart';
// import 'package:url_launcher/url_launcher.dart';

// class FlutterGoogleMapsUtils {
//   //private constructor
//   FlutterGoogleMapsUtils._privateConstructor();

//   //singleton instance variable
//   static FlutterGoogleMapsUtils? _instance;

//   //This code ensures that the singleton instance is created only when it's accessed for the first time.
//   //Subsequent calls to FlutterGoogleMapsUtils.instance will return the same instance that was created before.

//   //getter to access the singleton instance
//   static FlutterGoogleMapsUtils get instance {
//     _instance ??= FlutterGoogleMapsUtils._privateConstructor();
//     return _instance!;
//   }

//   //initial camera position for google map
//   final CameraPosition kGooglePlex = CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     zoom: 14.4746,
//   );

//   //method to animate camera on google map
//   void animateCamera({
//     required GoogleMapController googleMapController,
//     required LatLng latLng,
//   }) {
//     // animate map to current user location
//     googleMapController.animateCamera(
//       CameraUpdate.newCameraPosition(
//         CameraPosition(
//           target: LatLng(latLng.latitude, latLng.longitude),
//           zoom: 10,
//         ),
//       ),
//     );
//   }

//   //method to add marker on google map
//   MarkerData addMarker({
//     required LatLng markerLatLng,
//     required String markerId,
//     required String placeName,
//     required String icon,
//     VoidCallback? onTap,
//   }) {
//     ///initializing marker for the place
//     MarkerData markerData = MarkerData(
//       marker: Marker(
//         markerId: MarkerId(markerId),
//         position: LatLng(markerLatLng.latitude, markerLatLng.longitude),
//         onTap: onTap,
//         infoWindow: InfoWindow(title: placeName),
//       ),
//       child: Image.asset(
//         icon,
//         height: 40,
//       ),
//     );

//     return markerData;
//   }

//   //method to get LatLng from geohash
//   LatLng getLatLngFromGeohash({required Map geoHash}) {
//     //getting geoPoint from geoHash map
//     GeoPoint geoPoint = geoHash['geopoint'];

//     //creating latLng
//     LatLng latLng = LatLng(geoPoint.latitude, geoPoint.longitude);

//     return latLng;
//   }

//   //method to get photo url from a photo reference
//   //when you get place details from google maps API, it returns photo reference of the photo instead of photo url
//   //so you have to get photo url of that photo by sending the photo reference and your google maps API key
//   String getPhotoUrlFromPhotoRef(
//       {required String photoRef, required String mapsApiKey}) {
//     //creating imgUrl
//     String _imgUrl =
//         "https://maps.googleapis.com/maps/api/place/photo?maxwidth=480&photoreference=$photoRef&key=$mapsApiKey";

//     return _imgUrl;
//   }

//   //method to convert degrees to radians
//   double _radians(double degrees) {
//     return degrees * (math.pi / 180);
//   }

//   //method to calculate distance between two LatLng points using the Haversine formula
//   double calculateDistance(LatLng latLng1, LatLng latLng2) {
//     const double earthRadius = 6371; // Earth's radius in kilometers

//     // Convert latitude and longitude from degrees to radians
//     double lat1 = _radians(latLng1.latitude);
//     double lon1 = _radians(latLng1.longitude);
//     double lat2 = _radians(latLng2.latitude);
//     double lon2 = _radians(latLng2.longitude);

//     // Haversine formula
//     double dLat = lat2 - lat1;
//     double dLon = lon2 - lon1;

//     double a = math.sin(dLat / 2) * math.sin(dLat / 2) +
//         math.cos(lat1) *
//             math.cos(lat2) *
//             math.sin(dLon / 2) *
//             math.sin(dLon / 2);
//     double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
//     double distance = earthRadius * c;

//     return distance;
//   }

//   //calculating travel time based on average speed (in kilometers per hour)
//   Duration calculateTravelTime(LatLng origin, LatLng destination,
//       {double averageSpeedKmph = 50}) {
//     //calculating the distance between 2 points
//     double distance = calculateDistance(origin, destination);

//     //calculating travel time based on distance and average speed
//     double hours = distance / averageSpeedKmph;

//     //converting hours into seconds
//     int totalSeconds = (hours * 3600).round();
//     Duration duration = Duration(seconds: totalSeconds);

//     return duration;
//   }

//   //method to open google map
//   Future<void> openGoogleMap({
//     required LatLng sourceLatLng,
//     required LatLng destLatLng,
//   }) async {
//     //checking if the device is android or ios
//     if (Platform.isAndroid) {
//       final url =
//           'geo:${sourceLatLng.latitude},${sourceLatLng.longitude}?q=${destLatLng.latitude},${destLatLng.longitude}';

//       if (await canLaunchUrl(Uri.parse(url))) {
//         await launchUrl(Uri.parse(url));
//       } else {
//         CustomSnackBars.instance.showFailureSnackbar(
//             title: "Failure", message: "Could not open Map");
//       }
//     } else if (Platform.isIOS) {
//       //open ios maps app
//       final url =
//           'http://maps.apple.com/?saddr=${sourceLatLng.latitude},${sourceLatLng.longitude}&daddr=${destLatLng.latitude},${destLatLng.longitude}&dirflg=d';

//       if (await canLaunchUrl(Uri.parse(url))) {
//         await launchUrl(Uri.parse(url));
//       } else {
//         CustomSnackBars.instance.showFailureSnackbar(
//             title: "Failure", message: "Could not open Map");
//       }
//     }
//   }
// }
