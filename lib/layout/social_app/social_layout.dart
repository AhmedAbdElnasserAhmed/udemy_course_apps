import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter_dart/layout/social_app/cubit/cubit.dart';
import 'package:udemy_flutter_dart/layout/social_app/cubit/states.dart';
import 'package:udemy_flutter_dart/modules/social_app/new_post/new_post_screen.dart';
import 'package:udemy_flutter_dart/shared/components/components.dart';
import 'package:udemy_flutter_dart/shared/styles/icon_broken.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialNewPostState)
        {
          navigateTo(
            context,
            const NewPostScreen(),
          );
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex],
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  IconBroken.Notification,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  IconBroken.Search,
                ),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Home,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Chat,
                ),
                label: 'Chats',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Paper_Upload,
                ),
                label: 'Post',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Location,
                ),
                label: 'Users',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Setting,
                ),
                label: 'Settings',
              ),
            ],
          ),
          // body: ConditionalBuilder(
          //   condition: cubit.model != null,
          //   builder: (context) {
          //     //var model = cubit.model;
          //     // var model = FirebaseAuth.instance.currentUser!.emailVerified;
          //     // print(model);
          //
          //     return const Column(
          //       children: [
          //         //if(!model!.isEmailVerified!)
          //         // if (!FirebaseAuth.instance.currentUser!.emailVerified)
          //         //   Container(
          //         //     color: Colors.amber.withOpacity(0.6),
          //         //     child: Padding(
          //         //       padding: const EdgeInsets.symmetric(
          //         //         horizontal: 20.0,
          //         //       ),
          //         //       child: Row(
          //         //         children: [
          //         //           const Icon(
          //         //             Icons.info_outline,
          //         //           ),
          //         //           const SizedBox(
          //         //             width: 15.0,
          //         //           ),
          //         //           const Expanded(
          //         //             child: Text(
          //         //               'please verify your email',
          //         //             ),
          //         //           ),
          //         //           const SizedBox(
          //         //             width: 20.0,
          //         //           ),
          //         //           defaultTextBottom(
          //         //             function: () {
          //         //               FirebaseAuth.instance.currentUser!
          //         //                   .sendEmailVerification()
          //         //                   .then((value) {
          //         //                 showToast(
          //         //                   text: 'check your mail',
          //         //                   state: ToastStates.success,
          //         //                 );
          //         //               }).catchError((error) {});
          //         //             },
          //         //             text: 'send',
          //         //           ),
          //         //         ],
          //         //       ),
          //         //     ),
          //         //   ),
          //       ],
          //     );
          //   },
          //   fallback: (context) =>
          //       const Center(child: CircularProgressIndicator()),
          // ),
        );
      },
    );
  }
}
