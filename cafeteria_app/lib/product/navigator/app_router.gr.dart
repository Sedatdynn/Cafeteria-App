// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:cafeteria_app/product/widget/connection/no_connection.dart'
    as _i1;
import 'package:cafeteria_app/product/widget/loading/widget_loading.dart'
    as _i2;
import 'package:cafeteria_app/product/widget/noData/widget_no_data.dart' as _i3;
import 'package:cafeteria_app/views/home/view/home_view.dart' as _i4;
import 'package:cafeteria_app/views/order/order_page.dart' as _i5;
import 'package:cafeteria_app/views/payment/payment.dart' as _i6;
import 'package:flutter/material.dart' as _i8;

abstract class $AppRouter extends _i7.RootStackRouter {
  $AppRouter([_i8.GlobalKey<_i8.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    NoConnectionRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.NoConnectionView(),
      );
    },
    LoadingRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.LoadingView(),
      );
    },
    NoDataRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.NoDataView(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.HomeView(),
      );
    },
    OrderRoute.name: (routeData) {
      final args = routeData.argsAs<OrderRouteArgs>();
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.OrderView(
          key: args.key,
          totalMoney: args.totalMoney,
          isSelectedFood: args.isSelectedFood,
          eachFoodPrice: args.eachFoodPrice,
        ),
      );
    },
    PaymentPageRoute.name: (routeData) {
      final args = routeData.argsAs<PaymentPageRouteArgs>();
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.PaymentPageView(
          key: args.key,
          totalFee: args.totalFee,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.NoConnectionView]
class NoConnectionRoute extends _i7.PageRouteInfo<void> {
  const NoConnectionRoute({List<_i7.PageRouteInfo>? children})
      : super(
          NoConnectionRoute.name,
          initialChildren: children,
        );

  static const String name = 'NoConnectionRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i2.LoadingView]
class LoadingRoute extends _i7.PageRouteInfo<void> {
  const LoadingRoute({List<_i7.PageRouteInfo>? children})
      : super(
          LoadingRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoadingRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i3.NoDataView]
class NoDataRoute extends _i7.PageRouteInfo<void> {
  const NoDataRoute({List<_i7.PageRouteInfo>? children})
      : super(
          NoDataRoute.name,
          initialChildren: children,
        );

  static const String name = 'NoDataRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i4.HomeView]
class HomeRoute extends _i7.PageRouteInfo<void> {
  const HomeRoute({List<_i7.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i5.OrderView]
class OrderRoute extends _i7.PageRouteInfo<OrderRouteArgs> {
  OrderRoute({
    _i8.Key? key,
    required int totalMoney,
    required List<dynamic> isSelectedFood,
    required List<dynamic> eachFoodPrice,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          OrderRoute.name,
          args: OrderRouteArgs(
            key: key,
            totalMoney: totalMoney,
            isSelectedFood: isSelectedFood,
            eachFoodPrice: eachFoodPrice,
          ),
          initialChildren: children,
        );

  static const String name = 'OrderRoute';

  static const _i7.PageInfo<OrderRouteArgs> page =
      _i7.PageInfo<OrderRouteArgs>(name);
}

class OrderRouteArgs {
  const OrderRouteArgs({
    this.key,
    required this.totalMoney,
    required this.isSelectedFood,
    required this.eachFoodPrice,
  });

  final _i8.Key? key;

  final int totalMoney;

  final List<dynamic> isSelectedFood;

  final List<dynamic> eachFoodPrice;

  @override
  String toString() {
    return 'OrderRouteArgs{key: $key, totalMoney: $totalMoney, isSelectedFood: $isSelectedFood, eachFoodPrice: $eachFoodPrice}';
  }
}

/// generated route for
/// [_i6.PaymentPageView]
class PaymentPageRoute extends _i7.PageRouteInfo<PaymentPageRouteArgs> {
  PaymentPageRoute({
    _i8.Key? key,
    required int totalFee,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          PaymentPageRoute.name,
          args: PaymentPageRouteArgs(
            key: key,
            totalFee: totalFee,
          ),
          initialChildren: children,
        );

  static const String name = 'PaymentPageRoute';

  static const _i7.PageInfo<PaymentPageRouteArgs> page =
      _i7.PageInfo<PaymentPageRouteArgs>(name);
}

class PaymentPageRouteArgs {
  const PaymentPageRouteArgs({
    this.key,
    required this.totalFee,
  });

  final _i8.Key? key;

  final int totalFee;

  @override
  String toString() {
    return 'PaymentPageRouteArgs{key: $key, totalFee: $totalFee}';
  }
}
