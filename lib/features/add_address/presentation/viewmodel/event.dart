// location_event.dart
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class LocationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchCurrentLocation extends LocationEvent {}

class UpdateCameraPosition extends LocationEvent {
  final CameraPosition cameraPosition;

  UpdateCameraPosition(this.cameraPosition);

  @override
  List<Object?> get props => [cameraPosition];
}

class UpdateAddressFromCameraPosition extends LocationEvent {}
