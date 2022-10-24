import 'package:device_guru/src/app.dart';
import 'package:device_guru/src/presentation/screens/login/bloc/bloc.dart';
import 'package:device_guru/src/presentation/screens/login/login_screen.dart';
import 'package:device_guru/src/utils/constants/route_path.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    // case RoutePath.BASE:
    //   break;
//     case RoutePath.LOGIN:
//       return MaterialPageRoute(builder: (context) => LoginSignUpScreen());
// //      return MaterialPageRoute(builder: (context) => MyHomePage());
//     case RoutePath.PRODUCT_DETAILS_SCREEN:
//       Product productDetailArgument = routeSettings.arguments;
//       if(productDetailArgument == null) {
//         return MaterialPageRoute(builder: (context)=> ErrorScreen());
//       }
//       return MaterialPageRoute(builder: (context) => ProductDetailScreen(product: productDetailArgument,),);
    case RoutePath.MAIN_SCREEN:
      return MaterialPageRoute(
          builder: (context) => const MyHomePage(title: 'ServApp'));
    case RoutePath.LOGIN:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
//     case RoutePath.ADD_DEVICES_PAGE:
//       return MaterialPageRoute(builder: (context) => AddDevicesScreen());
//     case RoutePath.SEARCHABLE_DROP_DOWN_MENU_PAGE:
//       return MaterialPageRoute(builder: (context) => MyApp());
//     case RoutePath.CART_SCREEN:
//       return MaterialPageRoute(builder: (context) => CartScreen());
//     case RoutePath.NOTIFICATION_SCREEN:
//       return MaterialPageRoute(builder: (context) => NotificationScreen());
//     case RoutePath.REVIEWS_SCREEN:
//       String productId = routeSettings.arguments;
//       if(!Helper.checkIfStringIsNotEmpty(productId)){
//         return MaterialPageRoute(builder: (context)=> ErrorScreen());
//       }
//       return MaterialPageRoute(builder: (context) => ReviewScreen(productId: productId));
//     case RoutePath.DEVICE_DETAILS_PAGE:
//       UserProductResponse userProductResponse = routeSettings.arguments;
//       if(userProductResponse == null){
//         return MaterialPageRoute(builder: (context) => ErrorScreen());
//       }
//       return MaterialPageRoute(builder: (context) => DeviceDetailsScreen(userProductResponse: userProductResponse,),);
//     case RoutePath.SELECT_ADDRESS_SCREEN:
//       List<Address> addressList = routeSettings.arguments;
//       if(addressList == null)
//         return MaterialPageRoute(builder: (context) => ErrorScreen());
//       return MaterialPageRoute(builder: (context) => AddressScreen(addressList: addressList,));
    case RoutePath.ERROR_SCREEN:
    default:
    return MaterialPageRoute(
        builder: (context) => MyHomePage(title: 'ServApp'));  }
}