// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const HomeView(),
      );
    },
    OrderRoute.name: (routeData) {
      final args = routeData.argsAs<OrderRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: OrderView(
          key: args.key,
          totalMoney: args.totalMoney,
          isSelectedFood: args.isSelectedFood,
          eachFoodPrice: args.eachFoodPrice,
        ),
      );
    },
    PaymentPageRoute.name: (routeData) {
      final args = routeData.argsAs<PaymentPageRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: PaymentPageView(
          key: args.key,
          totalFee: args.totalFee,
        ),
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/home',
          fullMatch: true,
        ),
        RouteConfig(
          HomeRoute.name,
          path: '/home',
        ),
        RouteConfig(
          OrderRoute.name,
          path: '/order',
        ),
        RouteConfig(
          PaymentPageRoute.name,
          path: '/payment',
        ),
      ];
}

/// generated route for
/// [HomeView]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '/home',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [OrderView]
class OrderRoute extends PageRouteInfo<OrderRouteArgs> {
  OrderRoute({
    Key? key,
    required int totalMoney,
    required List<dynamic> isSelectedFood,
    required List<dynamic> eachFoodPrice,
  }) : super(
          OrderRoute.name,
          path: '/order',
          args: OrderRouteArgs(
            key: key,
            totalMoney: totalMoney,
            isSelectedFood: isSelectedFood,
            eachFoodPrice: eachFoodPrice,
          ),
        );

  static const String name = 'OrderRoute';
}

class OrderRouteArgs {
  const OrderRouteArgs({
    this.key,
    required this.totalMoney,
    required this.isSelectedFood,
    required this.eachFoodPrice,
  });

  final Key? key;

  final int totalMoney;

  final List<dynamic> isSelectedFood;

  final List<dynamic> eachFoodPrice;

  @override
  String toString() {
    return 'OrderRouteArgs{key: $key, totalMoney: $totalMoney, isSelectedFood: $isSelectedFood, eachFoodPrice: $eachFoodPrice}';
  }
}

/// generated route for
/// [PaymentPageView]
class PaymentPageRoute extends PageRouteInfo<PaymentPageRouteArgs> {
  PaymentPageRoute({
    Key? key,
    required int totalFee,
  }) : super(
          PaymentPageRoute.name,
          path: '/payment',
          args: PaymentPageRouteArgs(
            key: key,
            totalFee: totalFee,
          ),
        );

  static const String name = 'PaymentPageRoute';
}

class PaymentPageRouteArgs {
  const PaymentPageRouteArgs({
    this.key,
    required this.totalFee,
  });

  final Key? key;

  final int totalFee;

  @override
  String toString() {
    return 'PaymentPageRouteArgs{key: $key, totalFee: $totalFee}';
  }
}
