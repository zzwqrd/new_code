// location_bloc.dart
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as location;

import 'event.dart';
import 'state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final Completer<GoogleMapController> mapController;

  LocationBloc(this.mapController) : super(LocationInitial()) {
    on<FetchCurrentLocation>(_onFetchCurrentLocation);
    on<UpdateCameraPosition>(_onUpdateCameraPosition);
    on<UpdateAddressFromCameraPosition>(_onUpdateAddressFromCameraPosition);
    add(FetchCurrentLocation());
  }

  Future<void> _onFetchCurrentLocation(
    FetchCurrentLocation event,
    Emitter<LocationState> emit,
  ) async {
    emit(LocationLoading());

    try {
      location.Location locationService = location.Location();

      bool serviceEnabled = await locationService.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await locationService.requestService();
        if (!serviceEnabled) {
          emit(LocationError("Location services are disabled."));
          return;
        }
      }

      location.PermissionStatus permissionGranted =
          await locationService.hasPermission();
      if (permissionGranted == location.PermissionStatus.denied) {
        permissionGranted = await locationService.requestPermission();
        if (permissionGranted != location.PermissionStatus.granted) {
          emit(LocationError("Location permission not granted."));
          return;
        }
      }

      var currentLocation = await locationService.getLocation();

      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        GoogleMapController googleMapController = await mapController.future;

        CameraPosition newCameraPosition = CameraPosition(
          target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
          zoom: 15,
        );

        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(newCameraPosition),
        );

        List<Placemark> placemarks = await placemarkFromCoordinates(
          currentLocation.latitude!,
          currentLocation.longitude!,
        );

        String selectedAddress =
            '${placemarks.first.name}, ${placemarks.first.administrativeArea}, ${placemarks.first.country}';

        emit(LocationLoaded(
          cameraPosition: newCameraPosition,
          selectedAddress: selectedAddress,
        ));
      } else {
        emit(LocationError("Location data is not available."));
      }
    } catch (e) {
      emit(LocationError("An error occurred while fetching the location."));
    }
  }

  Future<void> _onUpdateCameraPosition(
    UpdateCameraPosition event,
    Emitter<LocationState> emit,
  ) async {
    final currentState = state;
    if (currentState is LocationLoaded) {
      // Trigger address update based on new camera position
      add(UpdateAddressFromCameraPosition());
    }
  }

  Future<void> _onUpdateAddressFromCameraPosition(
    UpdateAddressFromCameraPosition event,
    Emitter<LocationState> emit,
  ) async {
    final currentState = state;
    if (currentState is LocationLoaded) {
      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(
          currentState.cameraPosition.target.latitude,
          currentState.cameraPosition.target.longitude,
        );

        String newSelectedAddress =
            '${placemarks.first.name}, ${placemarks.first.administrativeArea}, ${placemarks.first.country}';

        emit(LocationLoaded(
          cameraPosition: currentState.cameraPosition,
          selectedAddress: newSelectedAddress,
        ));
      } catch (e) {
        emit(LocationError("Failed to update the address."));
      }
    }
  }
}
