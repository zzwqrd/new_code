// location_state.dart
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class LocationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final CameraPosition cameraPosition;
  final String selectedAddress;

  LocationLoaded({
    required this.cameraPosition,
    required this.selectedAddress,
  });

  @override
  List<Object?> get props => [cameraPosition, selectedAddress];
}

class LocationError extends LocationState {
  final String message;

  LocationError(this.message);

  @override
  List<Object?> get props => [message];
}
