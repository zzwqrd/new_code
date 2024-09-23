import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kiwi/kiwi.dart';

import 'features/add_address/presentation/viewmodel/controller.dart';
import 'features/splash/presentation/viewmodel/controller.dart';

void initKiwi() {
  KiwiContainer container = KiwiContainer();

  container.registerFactory(
    (container) => SplashController()..initialState(),
  );
  container
      .registerFactory((c) => LocationBloc(Completer<GoogleMapController>()));
  // container.registerFactory<RegisterBloc>(
  //       (container) => RegisterBloc(
  //     productUseCaseImp: container.resolve<ProductUseCaseImp>(),
  //   ),
  // );

  // container.registerFactory((c) => ProductController());
  // container.registerFactory((c) => DeleteController());
  // container.registerFactory((c) => DataCubitFreezedEnum());
  // container.registerFactory((c) => GetDataTestCubit());
  // container.registerFactory((c) => DropdownCubit());
  //
  // /// this test provider not bloc
  // container.registerFactory((c) => DataNotifier());
  // container.registerFactory((c) => DataCubit());
}
