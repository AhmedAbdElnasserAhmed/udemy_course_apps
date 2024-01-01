import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter_dart/layout/social_app/cubit/cubit.dart';
import 'package:udemy_flutter_dart/layout/social_app/cubit/states.dart';
import 'package:udemy_flutter_dart/modules/social_app/edit_profile/edit_profile_screen.dart';
import 'package:udemy_flutter_dart/shared/components/components.dart';
import 'package:udemy_flutter_dart/shared/components/constants.dart';
import 'package:udemy_flutter_dart/shared/styles/icon_broken.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;

        return userModel == null
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 190.0,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Container(
                              height: 140.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(
                                    4.0,
                                  ),
                                  topRight: Radius.circular(
                                    4.0,
                                  ),
                                  bottomLeft: Radius.circular(
                                    4.0,
                                  ),
                                  bottomRight: Radius.circular(
                                    4.0,
                                  ),
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    '${userModel.cover}',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          CircleAvatar(
                            radius: 64.0,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            child: CircleAvatar(
                              radius: 60.0,
                              backgroundImage: NetworkImage(
                                '${userModel.image}',
                                //'https://image.freepik.com/free-photo/photo-attractive-bearded-young- man-with-cherful-expression-makes-okay-gesture-with-both-hands-likes-something-dressed-red-casual-t-shirt-poses-against-white-wall-gestures- indoor_273609-16239.jpg',
                                //'https://image.freepik.com/free-photo/skeptical-woman-has-unsure-questioned-expression-points-fingers-sideways_273609-40770.jpg',
                                //'https://image.freepik.com/free-photo/top-view-delicious-fried-chicken- with-seasonings-vegetables-dark-space_140725-75663.jpg',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      '${userModel.name}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      '${userModel.bio}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              child: Column(
                                children: [
                                  Text(
                                    '100',
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  Text(
                                    'Posts',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                              onTap: () {},
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              child: Column(
                                children: [
                                  Text(
                                    '265',
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  Text(
                                    'Photos',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                              onTap: () {},
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              child: Column(
                                children: [
                                  Text(
                                    '10k',
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  Text(
                                    'Followers',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                              onTap: () {},
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              child: Column(
                                children: [
                                  Text(
                                    '64',
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  Text(
                                    'Followings',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                              onTap: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        // Expanded(
                        //   child: OutlinedButton(
                        //     onPressed: () {},
                        //     child: const Text(
                        //       'Add Photos',
                        //     ),
                        //   ),
                        // ),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              socialSignOut(context);
                            },
                            child: const Text(
                              'Sign Out',
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        OutlinedButton(
                          onPressed: () {
                            navigateTo(
                              context,
                              EditProfileScreen(),
                            );
                          },
                          child: const Icon(
                            IconBroken.Edit,
                            size: 16.0,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: ()
                            {
                              FirebaseMessaging.instance.subscribeToTopic('announcements');
                            },
                            child: const Text(
                              'subscribe',
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: ()
                            {
                              FirebaseMessaging.instance.unsubscribeFromTopic('announcements');
                            },
                            child: const Text(
                              'unsubscribe',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
      },
    );
  }
}
