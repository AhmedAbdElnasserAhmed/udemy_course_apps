
// POST
// UPDATE
// DELETE

// GET

// base url : https://newsapi.org/
// method (url) : v2/top-headlines?
// queries : country=eg&category=business&apiKey=65f7f556ec76449fa7dc7c0069f040ca

// https://newsapi.org/v2/everything?q=tesla&apiKey=65f7f556ec76449fa7dc7c0069f040ca

//https://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=65f7f556ec76449fa7dc7c0069f040ca


import 'package:udemy_flutter_dart/modules/shop_app/login/shop_login_screen.dart';
import 'package:udemy_flutter_dart/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:udemy_flutter_dart/modules/social_app/social_login/social_login_screen.dart';
import 'package:udemy_flutter_dart/shared/components/components.dart';
import 'package:udemy_flutter_dart/shared/network/local/cache_helper.dart';

void signOnBoardingOut(context)
{
  CacheHelper.removeData(key: 'onBoarding').then((value)
  {
    if(value)
    {
      navigateAndFinish(context, const OnBoardingScreen());
    }
  });
}

void signOut(context)
{
  CacheHelper.removeData(key: 'token').then((value)
  {
    if(value)
    {
      navigateAndFinish(context, ShopLoginScreen());
    }
  });
}

void socialSignOut(context)
{
  CacheHelper.removeData(key: 'uId').then((value)
  {
    if(value)
    {
      navigateAndFinish(context, SocialLoginScreen());
    }
  });
}


void printFullText(String text)
{
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}


String? token = '';

String? uId = '';


// Widget defaultFormField({
//   required TextEditingController controller,
//   required TextInputType type,
//   Function? onSubmit,
//   Function? onChange,
//   Function? onTap,
//   bool isPassword = false,
//   required Function validate,
//   required String label,
//   required IconData prefix,
//   IconData? suffix,
//   Function? suffixPressed,
//   bool isClickable = true,
// }) =>
//     TextFormField(
//       controller: controller,
//       keyboardType: type,
//       obscureText: isPassword,
//       enabled: isClickable,
//       onFieldSubmitted: onSubmit != null ? (value)
//       {
//         onSubmit(value);
//       } : null ,
//       onChanged: onChange != null ? (value)
//       {
//         onChange(value);
//       } : null,
//       onTap: onTap != null ? ()
//       {
//         onTap();
//       } : null,
//       validator: (value)
//       {
//         return validate(value);
//       },
//       decoration: InputDecoration(
//         labelText: label,
//         border: const OutlineInputBorder(),
//         prefixIcon: Icon(
//           prefix,
//         ),
//         suffixIcon: suffix != null
//             ? IconButton(
//           onPressed: ()
//           {
//             suffixPressed!();
//           },
//           icon: Icon(
//             suffix,
//           ),
//         )
//             : null,
//       ),
//     );