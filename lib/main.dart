import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter_dart/layout/news_app/cubit/cubit.dart';
import 'package:udemy_flutter_dart/layout/shop_app/cubit/cubit.dart';
import 'package:udemy_flutter_dart/layout/social_app/cubit/cubit.dart';
import 'package:udemy_flutter_dart/layout/social_app/social_layout.dart';
import 'package:udemy_flutter_dart/modules/native_code.dart';
import 'package:udemy_flutter_dart/modules/social_app/social_login/social_login_screen.dart';
import 'package:udemy_flutter_dart/shared/bloc_observer.dart';
import 'package:udemy_flutter_dart/shared/components/components.dart';
import 'package:udemy_flutter_dart/shared/components/constants.dart';
import 'package:udemy_flutter_dart/shared/cubit/cubit.dart';
import 'package:udemy_flutter_dart/shared/cubit/states.dart';
import 'package:udemy_flutter_dart/shared/network/local/cache_helper.dart';
import 'package:udemy_flutter_dart/shared/network/remote/dio_helper.dart';
import 'package:udemy_flutter_dart/shared/styles/themes.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async
{
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");

  print('on background message');
  print(message.data.toString());

  showToast(
    text: 'on background message',
    state: ToastStates.success,
  );
}

void main() async {
  // بيتأكد ان كل حاجه هنا في الميثود خلصت و بعدين يتفح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  var token = await FirebaseMessaging.instance.getToken();

  print('My Device Token : $token');

  // foreground fcm
  FirebaseMessaging.onMessage.listen((event) {
    print('on message');
    print(event.data.toString());

    showToast(
      text: 'on message',
      state: ToastStates.success,
    );
  });

  // when click on notification to open app
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('on message opened app');
    print(event.data.toString());

    showToast(
      text: 'on message opened app',
      state: ToastStates.success,
    );
  });

  // background fcm
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getData(key: 'isDark');

  Widget? widget;

  // bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  //
  // token = CacheHelper.getData(key: 'token');

  uId = CacheHelper.getData(key: 'uId');

  if (uId != null) {
    widget = const SocialLayout();
  } else {
    widget = SocialLoginScreen();
  }

  // if (kDebugMode)
  // {
  //   print(token);
  // }
  //
  // if(onBoarding != null)
  // {
  //   if(token != null)
  //   {
  //     widget =  const ShopLayout();
  //   }else
  //   {
  //     widget = ShopLoginScreen();
  //   }
  // }else
  // {
  //   widget = const OnBoardingScreen();
  // }

  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));

  MyApp app = MyApp(
    isDark: isDark,
    startWidget: widget,
  );
  Widget a = MyApp(
    isDark: isDark,
    startWidget: widget,
  );
}

//stateless Widget
//stateful Widget

//class MyApp
class MyApp extends StatelessWidget {
  bool? isDark;
  Widget? startWidget;

  MyApp({
    super.key,
    this.isDark,
    this.startWidget,
  });

  // MyApp(this.isDark, {super.key});
  //constructor
  //build

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit()
            ..getBusiness()
            ..getSports()
            ..getScience(),
        ),
        BlocProvider(
          create: (BuildContext context) => AppCubit()
            ..changeAppMode(
              fromShared: isDark,
            ),
        ),
        BlocProvider(
          create: (BuildContext context) => ShopCubit()
            ..getHomeData()
            ..getCategories()
            ..getFavorites()
            ..getUserData(),
        ),
        BlocProvider(
          create: (BuildContext context) => SocialCubit()
            ..getUserData()
            ..getPosts(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            //themeMode: ThemeMode.light,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: const Directionality(
              textDirection: TextDirection.ltr,
              //child: false ? ShopLoginScreen() : const OnBoardingScreen(),
              // child: startWidget!,
              // child: NewsLayout(),
              child: NativeCodeScreen(),
            ),
          );
        },
      ),
    );
  }
}
