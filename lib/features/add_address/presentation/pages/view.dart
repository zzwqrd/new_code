import 'dart:async';

import 'package:new_code/core/routes/routes.dart';
import 'package:new_code/core/utils/helpers/extintions.dart';
import 'package:new_code/core/utils/helpers/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kiwi/kiwi.dart';
import 'package:map_picker/map_picker.dart';

import '../../../../core/utils/helpers/custom_btn.dart';
import '../viewmodel/controller.dart';
import '../viewmodel/event.dart';
import '../viewmodel/state.dart';

class SelectLocationView extends StatelessWidget {
  const SelectLocationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocationBloc(Completer<GoogleMapController>()),
      child: _SelectLocationViewBody(),
    );
  }
}

class _SelectLocationViewBody extends StatefulWidget {
  @override
  State<_SelectLocationViewBody> createState() =>
      _SelectLocationViewBodyState();
}

class _SelectLocationViewBodyState extends State<_SelectLocationViewBody> {
  late final LocationBloc _locationBloc;
  final MapPickerController mapPickerController = MapPickerController();
  final TextEditingController _addressController = TextEditingController();
  final bloc = KiwiContainer().resolve<LocationBloc>();
  @override
  void initState() {
    super.initState();
    _locationBloc = context.read<LocationBloc>();
    bloc.add(FetchCurrentLocation());
    // Fetch the current location after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _locationBloc.add(FetchCurrentLocation());
    });
  }

  void _animateToPosition(LatLng targetPosition) async {
    final controller = await _locationBloc.mapController.future;
    controller.animateCamera(CameraUpdate.newLatLng(targetPosition));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          BlocListener<LocationBloc, LocationState>(
            bloc: bloc,
            listener: (context, state) {
              if (state is LocationLoaded) {
                // Update the address text when the location is loaded
                _addressController.text = state.selectedAddress;
                print(state.selectedAddress); // Debugging: print the address
              }
            },
            child: BlocBuilder<LocationBloc, LocationState>(
              bloc: bloc,
              builder: (context, state) {
                CameraPosition initialPosition = const CameraPosition(
                  target:
                      LatLng(30.033333, 31.233334), // Default to Cairo, Egypt
                  zoom: 13.4746,
                );

                if (state is LocationLoaded) {
                  initialPosition = state.cameraPosition;
                }

                return MapPicker(
                  iconWidget: Image.asset(
                    'assets/icons/location_on.png',
                    height: 60,
                  ),
                  mapPickerController: mapPickerController,
                  child: GoogleMap(
                    myLocationEnabled: true,
                    zoomControlsEnabled: false,
                    myLocationButtonEnabled: false,
                    mapType: MapType.normal,
                    initialCameraPosition: initialPosition,
                    onMapCreated: (GoogleMapController controller) {
                      _locationBloc.mapController.complete(controller);
                    },
                    onCameraMoveStarted: () {
                      mapPickerController.mapMoving!();
                    },
                    onCameraMove: (cameraPosition) {
                      // Update the camera position in the bloc
                      _locationBloc.add(UpdateCameraPosition(cameraPosition));
                    },
                    onCameraIdle: () async {
                      mapPickerController.mapFinishedMoving!();
                      // Fetch the address based on the new camera position
                      _locationBloc.add(UpdateAddressFromCameraPosition());
                    },
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).viewPadding.top + 20,
            width: MediaQuery.of(context).size.width - 50,
            height: 50,
            child: BlocBuilder<LocationBloc, LocationState>(
              bloc: bloc,
              builder: (context, state) {
                return TextFormField(
                  textAlign: TextAlign.center,
                  readOnly: true,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      borderSide: BorderSide(
                        width: 0.5,
                        style: BorderStyle.solid,
                        color: "##E6F1F7".toColor,
                      ),
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Icon(
                        Icons.search,
                        size: 18,
                        color: "#74F5B2".toColor,
                      ),
                    ),
                    contentPadding: const EdgeInsets.only(
                        left: 15, top: 20, bottom: 20, right: 15),
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      borderSide: BorderSide(
                        width: 0.5,
                        style: BorderStyle.solid,
                        color: "#74F5B2".toColor,
                      ),
                    ),
                    filled: true,
                    fillColor: "#E6F1F7".toColor.withOpacity(0.8),
                    enabled: true,
                    labelStyle: const TextStyle(
                      color: Color(0xFFC1C1C1),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.black, // Set the text color to black
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  controller: _addressController, // Use the controller here
                );
              },
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
          color: "#FAFAFA".toColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        height: 100,
        padding:
            const EdgeInsets.only(top: 20, bottom: 20, left: 25, right: 25),
        child: Column(
          children: [
            CustomElevatedButton(
              height: 60.h,
              text: "تم",
              onPressed: () {
                push(NamedRoutes.i.layout_view);
                // _animateToPosition(
                //     LatLng(40.7128, -74.0060));
              },
            ),
          ],
        ),
      ),
    );
  }
}
