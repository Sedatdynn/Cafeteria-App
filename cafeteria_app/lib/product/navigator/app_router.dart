import 'package:auto_route/auto_route.dart';
import 'package:cafeteria_app/views/home/home_shelf.dart';
import 'package:cafeteria_app/views/order/order_page.dart';
import 'package:cafeteria_app/views/payment/payment.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'View,Route',
  routes: <AutoRoute>[
    AutoRoute(page: HomeView, path: "/home", initial: true),
    AutoRoute(page: OrderView, path: "/order"),
    AutoRoute(page: PaymentPageView, path: "/payment"),
  ],
)
class AppRouter extends _$AppRouter {}
