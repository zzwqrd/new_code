import 'package:bloc/bloc.dart';
import 'package:new_code/core/routes/routes.dart';
import 'package:new_code/core/utils/helpers/route.dart';

part 'state.dart';

class SplashController extends Cubit<SplashState> {
  SplashController() : super(SplashStateInitial());

  Future<void> initialState() async {
    await Future.delayed(const Duration(seconds: 3), () {
      replacement(NamedRoutes.i.welcome_view);
    });
  }
}
