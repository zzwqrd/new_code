import 'package:flutter/material.dart';

import '../../features/add_address/presentation/pages/view.dart';
import '../../features/authe/sign_in/presentation/pages/view.dart';
import '../../features/feature_name/presentation/pages/view.dart';
import '../../features/splash/presentation/pages/view.dart';
import '../../features/welcome/presentation/pages/view.dart';
import 'routes.dart';

class AppRoutes {
  static AppRoutes get init => AppRoutes._internal();
  String initial = NamedRoutes.i.splash;

  AppRoutes._internal();
  Map<String, Widget Function(BuildContext context)> appRoutes = {
    NamedRoutes.i.splash: (context) => const SplashView(),
    NamedRoutes.i.welcome_view: (context) => const WelcomeView(),
    NamedRoutes.i.sign_in: (context) => const SignInView(),
    NamedRoutes.i.select_location: (context) => SelectLocationView(),
    NamedRoutes.i.layout_view: (context) => LayoutView(),
    // NamedRoutes.i.nav_bar_view: (context) => const NavigationView(),
    // NamedRoutes.i.video_view: (context) => const VideoView(),

    // NamedRoutes.i.mu_droop: (context) => CustomMultiselectDropDown(),
    // NamedRoutes.i.home: (context) => const HomeView(),
    // NamedRoutes.i.tasks: (context) => TasksView(title: context.arg["title"]),
    // NamedRoutes.i.allProjects: (context) => const AllProjectsView(),
    // NamedRoutes.i.navbar: (context) => NavbarView(index: context.arg["index"]),
    // NamedRoutes.i.allFavKitchen: (context) => AllFavKitchenView(
    //     bloc: context.arg["bloc"], roomsBloc: context.arg["roomBloc"]),
    // NamedRoutes.i.projectDetails: (context) =>
    //     ProjectDetailsView(data: context.arg["data"]),
    // NamedRoutes.i.myRequests: (context) => const MyRequestsView(),
    // NamedRoutes.i.myReports: (context) => const MyReportsView(),
    // NamedRoutes.i.myAccount: (context) => const MyAccountView(),
    // NamedRoutes.i.myVaccations: (context) => const MyVaccationsView(),
    // NamedRoutes.i.myFines: (context) => const MyFinesView(),
    // NamedRoutes.i.myOvertime: (context) => const MyOvertimeView(),
    // NamedRoutes.i.allProducts: (context) => AllProducts(
    //     bloc: context.arg["bloc"],
    //     roomsBloc: context.arg["roomBloc"],
    //     kitchensBloc: context.arg["kitchensBloc"]),
    // NamedRoutes.i.success: (context) => SuccessView(
    //     title: context.arg["title"], subtitle: context.arg["subtitle"]),
  };
}
