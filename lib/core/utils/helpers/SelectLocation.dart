// import 'dart:async';
//
// import 'package:new_code/core/utils/helpers/extintions.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart' as location;
// import 'package:map_picker/map_picker.dart';
//
// import '../../../../core/utils/helpers/custom_btn.dart';
// import '../../../../generated/assets.dart';
//
// class SelectLocationView extends StatefulWidget {
//   const SelectLocationView({super.key});
//
//   @override
//   State<SelectLocationView> createState() => _SelectLocationViewState();
// }
//
// class _SelectLocationViewState extends State<SelectLocationView> {
//   final _controller = Completer<GoogleMapController>();
//   MapPickerController mapPickerController = MapPickerController();
//
//   CameraPosition cameraPosition = const CameraPosition(
//     target: LatLng(30.033333, 31.233334), // Default location: Cairo, Egypt
//     zoom: 13.4746,
//   );
//
//   var textController = TextEditingController();
//   String selectedAddress = "22 شارع جامعة الدول العربية";
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   Future<void> _getCurrentLocation() async {
//     location.Location locationService = location.Location();
//
//     // Check if location services are enabled
//     bool serviceEnabled = await locationService.serviceEnabled();
//     if (!serviceEnabled) {
//       serviceEnabled = await locationService.requestService();
//       if (!serviceEnabled) {
//         return; // If service is not enabled, exit
//       }
//     }
//
//     // Check if location permissions are granted
//     location.PermissionStatus permissionGranted =
//     await locationService.hasPermission();
//     if (permissionGranted == location.PermissionStatus.denied) {
//       permissionGranted = await locationService.requestPermission();
//       if (permissionGranted != location.PermissionStatus.granted) {
//         return; // If permission is not granted, exit
//       }
//     }
//
//     // Get the current location
//     var currentLocation = await locationService.getLocation();
//
//     // Ensure that we have valid coordinates
//     if (currentLocation.latitude != null && currentLocation.longitude != null) {
//       GoogleMapController googleMapController = await _controller.future;
//
//       // Move the camera to the current location
//       googleMapController.animateCamera(
//         CameraUpdate.newCameraPosition(
//           CameraPosition(
//             target:
//             LatLng(currentLocation.latitude!, currentLocation.longitude!),
//             zoom: 15,
//           ),
//         ),
//       );
//
//       setState(() {
//         cameraPosition = CameraPosition(
//           target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
//           zoom: 15,
//         );
//       });
//
//       // Get the address from the coordinates
//       List<Placemark> placemarks = await placemarkFromCoordinates(
//         currentLocation.latitude!,
//         currentLocation.longitude!,
//       );
//
//       setState(() {
//         selectedAddress =
//         '${placemarks.first.name}, ${placemarks.first.administrativeArea}, ${placemarks.first.country}';
//         textController.text = selectedAddress;
//       });
//     } else {
//       // Handle the case where the location data is not available
//       print("Location data is not available");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         alignment: Alignment.topCenter,
//         children: [
//           MapPicker(
//             iconWidget: Image.asset(
//               Assets.iconsLocationOn,
//               height: 60,
//             ),
//             mapPickerController: mapPickerController,
//             child: GoogleMap(
//               myLocationEnabled: true,
//               zoomControlsEnabled: false,
//               myLocationButtonEnabled: false,
//               mapType: MapType.normal,
//               initialCameraPosition: cameraPosition,
//               onMapCreated: (GoogleMapController controller) {
//                 _controller.complete(controller);
//               },
//               onCameraMoveStarted: () {
//                 mapPickerController.mapMoving!();
//                 textController.text = "جارٍ التحقق...";
//               },
//               onCameraMove: (cameraPosition) {
//                 this.cameraPosition = cameraPosition;
//               },
//               onCameraIdle: () async {
//                 mapPickerController.mapFinishedMoving!();
//                 List<Placemark> placemarks = await placemarkFromCoordinates(
//                   cameraPosition.target.latitude,
//                   cameraPosition.target.longitude,
//                 );
//
//                 setState(() {
//                   selectedAddress =
//                   '${placemarks.first.name}, ${placemarks.first.administrativeArea}, ${placemarks.first.country}';
//                   textController.text = selectedAddress;
//                 });
//               },
//             ),
//           ),
//           Positioned(
//             top: MediaQuery.of(context).viewPadding.top + 20,
//             width: MediaQuery.of(context).size.width - 50,
//             height: 50,
//             child: TextFormField(
//               textAlign: TextAlign.center,
//               readOnly: true,
//               decoration: InputDecoration(
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: const BorderRadius.all(
//                     Radius.circular(15),
//                   ),
//                   borderSide: BorderSide(
//                     width: 0.5,
//                     style: BorderStyle.solid,
//                     color: "#0E1116".toColor,
//                   ),
//                 ),
//                 errorStyle: const TextStyle(
//                   color: Color(0xFFC1C1C1),
//                   fontSize: 13,
//                 ),
//                 prefixIcon: Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Icon(
//                     Icons.search,
//                     size: 18,
//                     color: "#74F5B2".toColor,
//                   ),
//                 ),
//                 contentPadding: const EdgeInsets.only(
//                     left: 15, top: 20, bottom: 20, right: 15),
//                 border: OutlineInputBorder(
//                   borderRadius: const BorderRadius.all(
//                     Radius.circular(15),
//                   ),
//                   borderSide: BorderSide(
//                     width: 0.5,
//                     style: BorderStyle.solid,
//                     color: "#74F5B2".toColor,
//                   ),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: const BorderRadius.all(
//                     Radius.circular(15),
//                   ),
//                   borderSide: BorderSide(
//                     width: 0.5,
//                     style: BorderStyle.solid,
//                     color: "#74F5B2".toColor,
//                   ),
//                 ),
//                 focusedErrorBorder: OutlineInputBorder(
//                   borderRadius: const BorderRadius.all(
//                     Radius.circular(15),
//                   ),
//                   borderSide: BorderSide(
//                     width: 0.5,
//                     style: BorderStyle.solid,
//                     color: "#74F5B2".toColor,
//                   ),
//                 ),
//                 filled: true,
//                 fillColor: "#74F5B2".toColor,
//                 enabled: true,
//                 labelStyle: const TextStyle(
//                   color: Color(0xFFC1C1C1),
//                   fontSize: 12,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               controller: textController,
//             ),
//           ),
//           Positioned(
//             bottom: 220,
//             left: 60.w,
//             right: 60.w,
//             child: SizedBox(
//               height: 60.h,
//               child: TextButton(
//                 onPressed: () async {
//                   await _getCurrentLocation(); // This will fetch and move to the current location
//                 },
//                 style: ButtonStyle(
//                   backgroundColor:
//                   MaterialStateProperty.all<Color>("#375CF2".toColor),
//                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                     RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15.0),
//                     ),
//                   ),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     const Icon(
//                       Icons.my_location,
//                       color: Colors.white,
//                       size: 18,
//                     ),
//                     const SizedBox(
//                       width: 8,
//                     ),
//                     Text(
//                       "استخدم الموقع الحالي",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: "#FFFFFF".toColor,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//       bottomSheet: Container(
//         decoration: BoxDecoration(
//           color: "#0E1116".toColor,
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(10),
//             topRight: Radius.circular(10),
//           ),
//         ),
//         height: 180,
//         padding:
//         const EdgeInsets.only(top: 20, bottom: 20, left: 25, right: 25),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 const Icon(
//                   Icons.location_on,
//                   size: 25,
//                   color: Colors.white,
//                 ),
//                 const SizedBox(
//                   width: 9,
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "موقعك الحالي",
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                         color: "#74F5B2".toColor,
//                       ),
//                     ),
//                     Text(
//                       selectedAddress,
//                       style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w600,
//                         color: "#8D8D8D".toColor,
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             CustomElevatedButton(
//               height: 60.h,
//               text: "تأكيد الموقع",
//               onPressed: () {
//                 // Add your action here
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // class SelectLocationView extends StatefulWidget {
// //   const SelectLocationView({super.key});
// //
// //   @override
// //   State<SelectLocationView> createState() => _SelectLocationViewState();
// // }
// //
// // class _SelectLocationViewState extends State<SelectLocationView> {
// //   final _controller = Completer<GoogleMapController>();
// //   MapPickerController mapPickerController = MapPickerController();
// //
// //   CameraPosition cameraPosition = const CameraPosition(
// //     target: LatLng(30.033333, 31.233334), // Default to Cairo, Egypt
// //     zoom: 13.4746,
// //   );
// //
// //   var textController = TextEditingController();
// //   String selectedAddress = "22 شارع جامعة الدول العربية";
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _getCurrentLocation();
// //   }
// //
// //   Future<void> _getCurrentLocation() async {
// //     location.Location locationService = location.Location();
// //
// //     // Ensure service is enabled
// //     bool serviceEnabled = await locationService.serviceEnabled();
// //     if (!serviceEnabled) {
// //       serviceEnabled = await locationService.requestService();
// //       if (!serviceEnabled) {
// //         return; // Exit if the service is not enabled
// //       }
// //     }
// //
// //     // Ensure permissions are granted
// //     location.PermissionStatus permissionGranted =
// //         await locationService.hasPermission();
// //     if (permissionGranted == location.PermissionStatus.denied) {
// //       permissionGranted = await locationService.requestPermission();
// //       if (permissionGranted != location.PermissionStatus.granted) {
// //         return; // Exit if permissions are not granted
// //       }
// //     }
// //
// //     // Get the current location
// //     var currentLocation = await locationService.getLocation();
// //     GoogleMapController googleMapController = await _controller.future;
// //
// //     // Animate camera to the current location
// //     googleMapController.animateCamera(
// //       CameraUpdate.newCameraPosition(
// //         CameraPosition(
// //           target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
// //           zoom: 15,
// //         ),
// //       ),
// //     );
// //
// //     setState(() {
// //       cameraPosition = CameraPosition(
// //         target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
// //         zoom: 15,
// //       );
// //     });
// //
// //     List<Placemark> placemarks = await placemarkFromCoordinates(
// //       currentLocation.latitude!,
// //       currentLocation.longitude!,
// //     );
// //
// //     setState(() {
// //       selectedAddress =
// //           '${placemarks.first.name}, ${placemarks.first.administrativeArea}, ${placemarks.first.country}';
// //       textController.text = selectedAddress;
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Stack(
// //         alignment: Alignment.topCenter,
// //         children: [
// //           MapPicker(
// //             iconWidget: Image.asset(
// //               Assets.iconsLocationOn,
// //               height: 60,
// //             ),
// //             mapPickerController: mapPickerController,
// //             child: GoogleMap(
// //               myLocationEnabled: true,
// //               zoomControlsEnabled: false,
// //               myLocationButtonEnabled: false,
// //               mapType: MapType.normal,
// //               initialCameraPosition: cameraPosition,
// //               onMapCreated: (GoogleMapController controller) {
// //                 _controller.complete(controller);
// //               },
// //               onCameraMoveStarted: () {
// //                 mapPickerController.mapMoving!();
// //                 textController.text = "جارٍ التحقق...";
// //               },
// //               onCameraMove: (cameraPosition) {
// //                 this.cameraPosition = cameraPosition;
// //               },
// //               onCameraIdle: () async {
// //                 mapPickerController.mapFinishedMoving!();
// //                 List<Placemark> placemarks = await placemarkFromCoordinates(
// //                   cameraPosition.target.latitude,
// //                   cameraPosition.target.longitude,
// //                 );
// //
// //                 setState(() {
// //                   selectedAddress =
// //                       '${placemarks.first.name}, ${placemarks.first.administrativeArea}, ${placemarks.first.country}';
// //                   textController.text = selectedAddress;
// //                 });
// //               },
// //             ),
// //           ),
// //           Positioned(
// //             top: MediaQuery.of(context).viewPadding.top + 20,
// //             width: MediaQuery.of(context).size.width - 50,
// //             height: 50,
// //             child: TextFormField(
// //               textAlign: TextAlign.center,
// //               readOnly: true,
// //               decoration: InputDecoration(
// //                 enabledBorder: OutlineInputBorder(
// //                   borderRadius: const BorderRadius.all(
// //                     Radius.circular(15),
// //                   ),
// //                   borderSide: BorderSide(
// //                     width: 0.5,
// //                     style: BorderStyle.solid,
// //                     color: "#0E1116".toColor,
// //                   ),
// //                 ),
// //                 errorStyle: const TextStyle(
// //                   color: Color(0xFFC1C1C1),
// //                   fontSize: 13,
// //                 ),
// //                 prefixIcon: Padding(
// //                   padding: const EdgeInsets.all(12.0),
// //                   child: Icon(
// //                     Icons.search,
// //                     size: 18,
// //                     color: "#74F5B2".toColor,
// //                   ),
// //                 ),
// //                 contentPadding: const EdgeInsets.only(
// //                     left: 15, top: 20, bottom: 20, right: 15),
// //                 border: OutlineInputBorder(
// //                   borderRadius: const BorderRadius.all(
// //                     Radius.circular(15),
// //                   ),
// //                   borderSide: BorderSide(
// //                     width: 0.5,
// //                     style: BorderStyle.solid,
// //                     color: "#74F5B2".toColor,
// //                   ),
// //                 ),
// //                 focusedBorder: OutlineInputBorder(
// //                   borderRadius: const BorderRadius.all(
// //                     Radius.circular(15),
// //                   ),
// //                   borderSide: BorderSide(
// //                     width: 0.5,
// //                     style: BorderStyle.solid,
// //                     color: "#74F5B2".toColor,
// //                   ),
// //                 ),
// //                 focusedErrorBorder: OutlineInputBorder(
// //                   borderRadius: const BorderRadius.all(
// //                     Radius.circular(15),
// //                   ),
// //                   borderSide: BorderSide(
// //                     width: 0.5,
// //                     style: BorderStyle.solid,
// //                     color: "#74F5B2".toColor,
// //                   ),
// //                 ),
// //                 filled: true,
// //                 fillColor: "#74F5B2".toColor,
// //                 enabled: true,
// //                 labelStyle: const TextStyle(
// //                   color: Color(0xFFC1C1C1),
// //                   fontSize: 12,
// //                   fontWeight: FontWeight.w600,
// //                 ),
// //               ),
// //               controller: textController,
// //             ),
// //           ),
// //           Positioned(
// //             bottom: 220,
// //             left: 60.w,
// //             right: 60.w,
// //             child: SizedBox(
// //               height: 60.h,
// //               child: TextButton(
// //                 onPressed: () async {
// //                   await _getCurrentLocation();
// //                 },
// //                 style: ButtonStyle(
// //                   backgroundColor:
// //                       MaterialStateProperty.all<Color>("#375CF2".toColor),
// //                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
// //                     RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(15.0),
// //                     ),
// //                   ),
// //                 ),
// //                 child: Row(
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   crossAxisAlignment: CrossAxisAlignment.center,
// //                   children: [
// //                     const Icon(
// //                       Icons.my_location,
// //                       color: Colors.white,
// //                       size: 18,
// //                     ),
// //                     const SizedBox(
// //                       width: 8,
// //                     ),
// //                     Text(
// //                       "استخدم الموقع الحالي",
// //                       style: TextStyle(
// //                         fontWeight: FontWeight.bold,
// //                         color: "#FFFFFF".toColor,
// //                         fontSize: 14,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           )
// //         ],
// //       ),
// //       bottomSheet: Container(
// //         decoration: BoxDecoration(
// //           color: "#0E1116".toColor,
// //           borderRadius: const BorderRadius.only(
// //             topLeft: Radius.circular(10),
// //             topRight: Radius.circular(10),
// //           ),
// //         ),
// //         height: 180,
// //         padding:
// //             const EdgeInsets.only(top: 20, bottom: 20, left: 25, right: 25),
// //         child: Column(
// //           children: [
// //             Row(
// //               children: [
// //                 const Icon(
// //                   Icons.location_on,
// //                   size: 25,
// //                   color: Colors.white,
// //                 ),
// //                 const SizedBox(
// //                   width: 9,
// //                 ),
// //                 Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Text(
// //                       "موقعك الحالي",
// //                       style: TextStyle(
// //                         fontSize: 14,
// //                         fontWeight: FontWeight.bold,
// //                         color: "#74F5B2".toColor,
// //                       ),
// //                     ),
// //                     Text(
// //                       selectedAddress,
// //                       style: TextStyle(
// //                         fontSize: 12,
// //                         fontWeight: FontWeight.w600,
// //                         color: "#8D8D8D".toColor,
// //                       ),
// //                     ),
// //                   ],
// //                 )
// //               ],
// //             ),
// //             const SizedBox(
// //               height: 20,
// //             ),
// //             CustomElevatedButton(
// //               height: 60.h,
// //               text: "تأكيد الموقع",
// //               onPressed: () {
// //                 // Add your action here
// //               },
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// class SelectLocationView extends StatefulWidget {
//   const SelectLocationView({super.key});
//
//   @override
//   State<SelectLocationView> createState() => _SelectLocationViewState();
// }
//
// class _SelectLocationViewState extends State<SelectLocationView> {
//   final _controller = Completer<GoogleMapController>();
//   MapPickerController mapPickerController = MapPickerController();
//
//   CameraPosition cameraPosition = const CameraPosition(
//     target: LatLng(30.033333, 31.233334), // Default location: Cairo, Egypt
//     zoom: 13.4746,
//   );
//
//   var textController = TextEditingController();
//   String selectedAddress = "حدد عنوانك بسهولة من الخريطة";
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _getCurrentLocation();
//     });
//   }
//
//   Future<void> _getCurrentLocation() async {
//     location.Location locationService = location.Location();
//
//     // Check if location services are enabled
//     bool serviceEnabled = await locationService.serviceEnabled();
//     if (!serviceEnabled) {
//       serviceEnabled = await locationService.requestService();
//       if (!serviceEnabled) {
//         return; // If service is not enabled, exit
//       }
//     }
//
//     // Check if location permissions are granted
//     location.PermissionStatus permissionGranted =
//         await locationService.hasPermission();
//     if (permissionGranted == location.PermissionStatus.denied) {
//       permissionGranted = await locationService.requestPermission();
//       if (permissionGranted != location.PermissionStatus.granted) {
//         return; // If permission is not granted, exit
//       }
//     }
//
//     // Get the current location
//     var currentLocation = await locationService.getLocation();
//
//     // Ensure that we have valid coordinates
//     if (currentLocation.latitude != null && currentLocation.longitude != null) {
//       GoogleMapController googleMapController = await _controller.future;
//
//       // Move the camera to the current location
//       googleMapController.animateCamera(
//         CameraUpdate.newCameraPosition(
//           CameraPosition(
//             target:
//                 LatLng(currentLocation.latitude!, currentLocation.longitude!),
//             zoom: 15,
//           ),
//         ),
//       );
//
//       setState(() {
//         cameraPosition = CameraPosition(
//           target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
//           zoom: 15,
//         );
//       });
//
//       // Get the address from the coordinates
//       List<Placemark> placemarks = await placemarkFromCoordinates(
//         currentLocation.latitude!,
//         currentLocation.longitude!,
//       );
//
//       setState(() {
//         selectedAddress =
//             '${placemarks.first.name}, ${placemarks.first.administrativeArea}, ${placemarks.first.country}';
//         textController.text = selectedAddress;
//       });
//     } else {
//       // Handle the case where the location data is not available
//       print("Location data is not available");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         alignment: Alignment.topCenter,
//         children: [
//           MapPicker(
//             iconWidget: Image.asset(
//               Assets.iconsLocationOn,
//               height: 60,
//             ),
//             mapPickerController: mapPickerController,
//             child: GoogleMap(
//               myLocationEnabled: true,
//               zoomControlsEnabled: false,
//               myLocationButtonEnabled: false,
//               mapType: MapType.normal,
//               initialCameraPosition: cameraPosition,
//               onMapCreated: (GoogleMapController controller) {
//                 _controller.complete(controller);
//               },
//               onCameraMoveStarted: () {
//                 mapPickerController.mapMoving!();
//                 textController.text = "جارٍ التحقق...";
//               },
//               onCameraMove: (cameraPosition) {
//                 this.cameraPosition = cameraPosition;
//               },
//               onCameraIdle: () async {
//                 mapPickerController.mapFinishedMoving!();
//                 List<Placemark> placemarks = await placemarkFromCoordinates(
//                   cameraPosition.target.latitude,
//                   cameraPosition.target.longitude,
//                 );
//
//                 setState(() {
//                   selectedAddress =
//                       '${placemarks.first.name}, ${placemarks.first.administrativeArea}, ${placemarks.first.country}';
//                   textController.text = selectedAddress;
//                 });
//               },
//             ),
//           ),
//           Positioned(
//             top: MediaQuery.of(context).viewPadding.top + 20,
//             width: MediaQuery.of(context).size.width - 50,
//             height: 50,
//             child: TextFormField(
//               textAlign: TextAlign.center,
//               readOnly: true,
//               decoration: InputDecoration(
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: const BorderRadius.all(
//                     Radius.circular(15),
//                   ),
//                   borderSide: BorderSide(
//                     width: 0.5,
//                     style: BorderStyle.solid,
//                     color: "##E6F1F7".toColor,
//                   ),
//                 ),
//                 errorStyle: const TextStyle(
//                   color: Color(0xFFC1C1C1),
//                   fontSize: 13,
//                 ),
//                 prefixIcon: Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Icon(
//                     Icons.search,
//                     size: 18,
//                     color: "#74F5B2".toColor,
//                   ),
//                 ),
//                 contentPadding: const EdgeInsets.only(
//                     left: 15, top: 20, bottom: 20, right: 15),
//                 border: OutlineInputBorder(
//                   borderRadius: const BorderRadius.all(
//                     Radius.circular(15),
//                   ),
//                   borderSide: BorderSide(
//                     width: 0.5,
//                     style: BorderStyle.solid,
//                     color: "#74F5B2".toColor,
//                   ),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: const BorderRadius.all(
//                     Radius.circular(15),
//                   ),
//                   borderSide: BorderSide(
//                     width: 0.5,
//                     style: BorderStyle.solid,
//                     color: "#74F5B2".toColor,
//                   ),
//                 ),
//                 focusedErrorBorder: OutlineInputBorder(
//                   borderRadius: const BorderRadius.all(
//                     Radius.circular(15),
//                   ),
//                   borderSide: BorderSide(
//                     width: 0.5,
//                     style: BorderStyle.solid,
//                     color: "#E6F1F7".toColor,
//                   ),
//                 ),
//                 filled: true,
//                 fillColor: "#E6F1F7".toColor.withOpacity(0.8),
//                 enabled: true,
//                 labelStyle: const TextStyle(
//                   color: Color(0xFFC1C1C1),
//                   fontSize: 12,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               controller: textController,
//             ),
//           ),
//         ],
//       ),
//       bottomSheet: Container(
//         decoration: BoxDecoration(
//           color: "#FAFAFA".toColor,
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(10),
//             topRight: Radius.circular(10),
//           ),
//         ),
//         height: 100,
//         padding:
//             const EdgeInsets.only(top: 20, bottom: 20, left: 25, right: 25),
//         child: Column(
//           children: [
//             CustomElevatedButton(
//               height: 60.h,
//               text: "تم",
//               onPressed: () {
//                 // Add your action here
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
