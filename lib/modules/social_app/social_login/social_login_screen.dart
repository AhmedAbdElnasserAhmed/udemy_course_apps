import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter_dart/layout/social_app/cubit/cubit.dart';
import 'package:udemy_flutter_dart/layout/social_app/social_layout.dart';
import 'package:udemy_flutter_dart/modules/social_app/social_login/cubit/cubit.dart';
import 'package:udemy_flutter_dart/modules/social_app/social_login/cubit/states.dart';
import 'package:udemy_flutter_dart/modules/social_app/social_register/social_register_screen.dart';
import 'package:udemy_flutter_dart/shared/components/components.dart';
import 'package:udemy_flutter_dart/shared/components/constants.dart';
import 'package:udemy_flutter_dart/shared/network/local/cache_helper.dart';

class SocialLoginScreen extends StatelessWidget
{
  SocialLoginScreen({super.key});

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state)
        {
          if (state is SocialLoginErrorState)
          {
            showToast(
              text: state.error,
              state: ToastStates.error,
            );
          }
          if (state is SocialLoginSuccessState)
          {
            CacheHelper.saveData(
              key: 'uId',
              value: state.uId,
            ).then((value)
            {
              navigateAndFinish(
                context,
                const SocialLayout(),
              );
            });
          }
        },
        builder: (context, state)
        {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                color: Colors.black,
                              ),
                        ),
                        Text(
                          'Login now to communicate with friends',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        circularDefaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'pleas enter your email address';
                            }
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        circularDefaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          isPassword: SocialLoginCubit.get(context).isPassword,
                          validate: (String value)
                          {
                            if (value.isEmpty)
                            {
                              return 'password is too short';
                            }
                          },
                          onSubmit: (value)
                          {
                            // if (formKey.currentState!.validate()) {
                            //   SocialLoginCubit.get(context).userLogin(
                            //     email: emailController.text,
                            //     password: passwordController.text,
                            //   );
                            // }
                          },
                          label: 'Password',
                          prefix: Icons.lock_outline,
                          suffix: SocialLoginCubit.get(context).suffix,
                          suffixPressed: ()
                          {
                            SocialLoginCubit.get(context)
                                .changePasswordVisibility();
                          },
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialLoginLoadingState,
                          builder: (context) => circularDefaultButton(
                            function: ()
                            {
                              if (formKey.currentState!.validate())
                              {
                                SocialLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            text: 'login',
                            isUpperCase: true,
                          ),
                          // builder: (context) => defaultButton(
                          //   function: () {
                          //     if (formKey.currentState!.validate()) {
                          //       SocialLoginCubit.get(context).userLogin(
                          //         email: emailController.text,
                          //         password: passwordController.text,
                          //       );
                          //     }
                          //   },
                          //   text: 'login',
                          //   isUpperCase: true,
                          // ),
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account?',
                            ),
                            defaultTextBottom(
                              text: 'register',
                              function: () {
                                navigateTo(
                                  context,
                                  SocialRegisterScreen(),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// MaterialButton(
//                   minWidth: 350,
//                   height: 50,
//                   color: Colors.blue[900],
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12)),
//                   onPressed: () {
//                     Navigator.pushNamed(context, Navigationbar.screenRoute);
//                   },
//                   child: const Text(
//                     'Login',
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
