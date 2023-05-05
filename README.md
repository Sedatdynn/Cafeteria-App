# Cafeteria-App

Cafeteria Menu Application created in flutter using Cubit.


## Cafeteria-App Features:

* Drawer
* Home
* Order
* Payment
* Dio
* Shared Preferences
* Fluttertoast
* Cubit (State Management)

### Libraries & Tools Used

* Dio (^4.0.6)
* Shared Preferences (^2.0.15)
* Fluttertoast (^8.1.2)
* Bloc (^8.1.0)
* Flutter Bloc (^8.1.1)

### Folder Structure
Here is the core folder structure.

```
flutter-app/
|- android
|- assets
|- build
|- ios
|- lib
|- test
```

Here is the folder structure I have been using in this project

```
lib/
|- core/
|- product/
|- views/
|- main.dart
```

Now, lets dive into the lib folder which has the main code for the application.

```
1- core - Contains the business independent structures of the project.
2- product - Contains the business-dependent structures of the project..
3- views - Contains all the ui of my project, contains sub directory for each screen.. 
4- main.dart - This is the starting point of the application. All the application level configurations are defined in this file.
```

### Core

This directory contains the business independent structures of the project. A separate file is created for each type as shown in example below:

```
core/
|- constants/
  |- border/
  |- responsive/
|- theme/
  |- color/
```

### Product

Contains the business-dependent structures of the project. A separate file is created for each type as shown in example below:

```
product/
|- constants/
  |- texts/
  |- duration/
  |- warningMessage/  
```

### Views

This directory contains all the ui of my application. Each screen is located in a separate folder making it easy to combine group of files related to that particular screen. A separate file is created for each ui as shown in example below:

```
views/
|- drawer/
|- home/
|- order/
|- payment/  
```
### Home

This directory contains home screen of my application.This file contains Flutter MVVM Architecture to communicate between the UI & business logic so MVVM is providing this in an easy way as you can hold my all business logic inside the ViewModel class and UI separately. Files are as shown in example below:

```
home/
|- cubit/
|- model/
|- service/
|- view/  
```

### Main

This is the starting point of the application. All the application level configurations are defined in this file.

```dart
import 'dart:io';

import 'core/init/cache/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/init/provider/bloc_provider_list.dart';
import 'product/navigator/app_router.dart';
import 'product/widget/materialApp/materialLoaded/material_loaded.dart';
import 'product/widget/materialApp/loadingMaterial/loading_material.dart';
import 'product/widget/widgets_shelf.dart';
import 'views/home/cubit/localeCubit/locale_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocaleManager.preferencesInit();
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: ProviderList.instance.providers,
        child: BlocBuilder<LocaleCubit, LocaleState>(
          builder: (context, state) {
            if (state is LocaleInitial) {
              return const LoadingMaterial();
            } else if (state is ChangeLocaleState) {
              return MaterialLoaded(state: state, appRouter: _appRouter);
            }
            return const NoDataView();
          },
        ));
  }
}


```
  
 ## Cafeteria-App Screenshots
 
 ### Home Pages
 
 <img src="https://i.ibb.co/HpmyWmf/Screenshot-1.png" width="180" height="380" />
 
 <img src="https://i.ibb.co/GRL5zs6/Screenshot-2.png" width="180" height="380" />
 
 <img src="https://i.ibb.co/JkNGWCZ/Screenshot-3.png" width="180" height="380" />
 

 <br />
 
 ### Order Page
 <img src="https://i.ibb.co/hgmCd1c/Screenshot-4.png" width="180" height="380" />
 
 <br />
 
 ### Payment Page
 <img src="https://i.ibb.co/h1bKSrP/Screenshot-5.png" width="180" height="380" />
 
 <br /> 
 ## Conclusion

I will be happy to answer any questions that you may have on this approach, and if you want to lend a hand with the boilerplate then please feel free to submit an issue and/or pull request 🙂
 
 
