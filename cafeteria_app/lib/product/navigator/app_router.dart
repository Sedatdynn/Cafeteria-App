import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: HomeRoute.page, path: "/"),
    AutoRoute(page: OrderRoute.page, path: "/order"),
    AutoRoute(page: PaymentPageRoute.page, path: "/detail"),
    AutoRoute(page: NoConnectionRoute.page, path: "/noConnection"),
    AutoRoute(page: LoadingRoute.page, path: "/loading"),
    AutoRoute(page: NoDataRoute.page, path: "/noData"),
  ];
}
