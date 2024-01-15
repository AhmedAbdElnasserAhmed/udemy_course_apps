import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter_dart/layout/social_app/cubit/cubit.dart';
import 'package:udemy_flutter_dart/layout/social_app/social_layout.dart';
import 'package:udemy_flutter_dart/modules/social_app/social_register/cubit/cubit.dart';
import 'package:udemy_flutter_dart/modules/social_app/social_register/cubit/states.dart';
import 'package:udemy_flutter_dart/shared/components/components.dart';

class SocialRegisterScreen extends StatelessWidget {
  SocialRegisterScreen({super.key});

  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state)
        {
          if (state is SocialRegisterErrorState)
          {
            showToast(
              text: state.error,
              state: ToastStates.error,
            );
          }

          if (state is SocialCreateUserSuccessState)
          {
            showToast(
              text: 'Register Successfully',
              state: ToastStates.success,
            );

            SocialCubit.get(context).getUserData();

            navigateAndFinish(
              context,
              const SocialLayout(),
            );
          }
          // if (state is SocialRegisterSuccessState)
          // {
          //   if (state.loginModel.status)
          //   {
          //     if (kDebugMode)
          //     {
          //       print(state.loginModel.message);
          //     }
          //     if (kDebugMode)
          //     {
          //       print(state.loginModel.data?.token);
          //     }
          //
          //     CacheHelper.saveData(
          //       key: 'token',
          //       value: state.loginModel.data?.token,
          //     ).then((value)
          //     {
          //       token = state.loginModel.data!.token;
          //
          //       navigateAndFinish(
          //         context,
          //         const SocialLayout(),
          //       );
          //     });
          //
          //     // Fluttertoast.showToast(
          //     //   msg: state.loginModel.message,
          //     //   toastLength: Toast.LENGTH_LONG,
          //     //   gravity: ToastGravity.BOTTOM,
          //     //   timeInSecForIosWeb: 5,
          //     //   backgroundColor: Colors.green,
          //     //   textColor: Colors.white,
          //     //   fontSize: 16.0,
          //     // );
          //   } else {
          //
          //     if (kDebugMode)
          //     {
          //       print(state.loginModel.message);
          //     }
          //
          //     showToast(
          //       text: state.loginModel.message!,
          //       state: ToastStates.warning,
          //     );
          //     // Fluttertoast.showToast(
          //     //     msg: state.loginModel.message,
          //     //     toastLength: Toast.LENGTH_LONG,
          //     //     gravity: ToastGravity.BOTTOM,
          //     //     timeInSecForIosWeb: 5,
          //     //     backgroundColor: Colors.red,
          //     //     textColor: Colors.white,
          //     //     fontSize: 16.0,
          //     // );
          //   }
          // }
        },
        builder: (context, state) {
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
                          'REGISTER',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                color: Colors.black,
                              ),
                        ),
                        Text(
                          'Register now to communicate with friends',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        circularDefaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'pleas enter your name';
                            }
                          },
                          label: 'User Name',
                          prefix: Icons.person,
                        ),
                        const SizedBox(
                          height: 15.0,
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
                          isPassword:
                              SocialRegisterCubit.get(context).isPassword,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'password is too short';
                            }
                          },
                          // onSubmit: (value) {
                          //   if (formKey.currentState!.validate()) {
                          //     SocialLoginCubit.get(context).userLogin(
                          //       email: emailController.text,
                          //       password: passwordController.text,
                          //     );
                          //   }
                          // },
                          label: 'Password',
                          prefix: Icons.lock_outline,
                          suffix: SocialRegisterCubit.get(context).suffix,
                          suffixPressed: () {
                            SocialRegisterCubit.get(context)
                                .changePasswordVisibility();
                          },
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        circularDefaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'pleas enter your phone number';
                            }
                          },
                          label: 'Phone',
                          prefix: Icons.phone,
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialRegisterLoadingState,
                          builder: (context) => circularDefaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                SocialRegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            text: 'register',
                            isUpperCase: true,
                          ),
                          // builder: (context) => defaultButton(
                          //   function: ()
                          //   {
                          //     if (formKey.currentState!.validate())
                          //     {
                          //       SocialRegisterCubit.get(context).userRegister(
                          //         name: nameController.text,
                          //         email: emailController.text,
                          //         password: passwordController.text,
                          //         phone: phoneController.text,
                          //       );
                          //     }
                          //   },
                          //   text: 'register',
                          //   isUpperCase: true,
                          // ),
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
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
