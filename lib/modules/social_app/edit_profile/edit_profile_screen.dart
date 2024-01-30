import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter_dart/layout/social_app/cubit/cubit.dart';
import 'package:udemy_flutter_dart/layout/social_app/cubit/states.dart';
import 'package:udemy_flutter_dart/shared/components/components.dart';
import 'package:udemy_flutter_dart/shared/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget
{
  EditProfileScreen({super.key});

  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;

        nameController.text = userModel.name!;
        phoneController.text = userModel.phone!;
        bioController.text = userModel.bio!;

        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Edit Profile',
            actions: [
              defaultTextBottom(
                function: () {
                  cubit.updateUser(
                    name: nameController.text,
                    phone: phoneController.text,
                    bio: bioController.text,
                  );
                },
                text: 'update',
              ),
              const SizedBox(
                width: 15.0,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                if (state is SocialUserUpdateLoadingState)
                  const LinearProgressIndicator(),
                if (state is SocialUserUpdateLoadingState)
                  const SizedBox(
                    height: 10.0,
                  ),
                SizedBox(
                  height: 190.0,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
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
                                  image: coverImage == null
                                      ? NetworkImage(
                                          '${userModel.cover}',
                                        )
                                      : FileImage(coverImage) as ImageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                cubit.getCoverImage();
                              },
                              icon: const CircleAvatar(
                                //backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                radius: 20.0,
                                child: Icon(
                                  IconBroken.Camera,
                                  size: 16.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 64.0,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            child: CircleAvatar(
                              radius: 60.0,
                              backgroundImage: profileImage == null
                                  ? NetworkImage(
                                      '${userModel.image}',
                                      //'https://image.freepik.com/free-photo/photo-attractive-bearded-young- man-with-cherful-expression-makes-okay-gesture-with-both-hands-likes-something-dressed-red-casual-t-shirt-poses-against-white-wall-gestures- indoor_273609-16239.jpg',
                                      //'https://image.freepik.com/free-photo/skeptical-woman-has-unsure-questioned-expression-points-fingers-sideways_273609-40770.jpg',
                                      //'https://image.freepik.com/free-photo/top-view-delicious-fried-chicken- with-seasonings-vegetables-dark-space_140725-75663.jpg',
                                    )
                                  : FileImage(profileImage) as ImageProvider,
                              // backgroundImage: profileImage == null ? NetworkImage(
                              //   '${userModel.image}',
                              //   //'https://image.freepik.com/free-photo/photo-attractive-bearded-young- man-with-cherful-expression-makes-okay-gesture-with-both-hands-likes-something-dressed-red-casual-t-shirt-poses-against-white-wall-gestures- indoor_273609-16239.jpg',
                              //   //'https://image.freepik.com/free-photo/skeptical-woman-has-unsure-questioned-expression-points-fingers-sideways_273609-40770.jpg',
                              //   //'https://image.freepik.com/free-photo/top-view-delicious-fried-chicken- with-seasonings-vegetables-dark-space_140725-75663.jpg',
                              // ) : FileImage(
                              //   profileImage,
                              // ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              cubit.getProfileImage();
                            },
                            icon: const CircleAvatar(
                              //backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              radius: 20.0,
                              child: Icon(
                                IconBroken.Camera,
                                size: 16.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                if (cubit.profileImage != null || cubit.coverImage != null)
                  Row(
                    children: [
                      if (cubit.profileImage != null)
                        Expanded(
                          child: Column(
                            children: [
                              circularDefaultButton(
                                function: ()
                                {
                                  cubit.upLoadProfileImage(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    bio: bioController.text,
                                  );
                                },
                                text: 'upload profile',
                              ),
                              // if (state is SocialUserUpdateLoadingState)
                              //   const SizedBox(
                              //   height: 5.0,
                              // ),
                              // if (state is SocialUserUpdateLoadingState)
                              //   const LinearProgressIndicator(),
                            ],
                          ),
                        ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      if (cubit.coverImage != null)
                        Expanded(
                          child: Column(
                            children: [
                              circularDefaultButton(
                                function: ()
                                {
                                  cubit.upLoadCoverImage(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    bio: bioController.text,
                                  );
                                },
                                text: 'upload cover',
                              ),
                              // if (state is SocialUserUpdateLoadingState)
                              //   const SizedBox(
                              //   height: 5.0,
                              // ),
                              // if (state is SocialUserUpdateLoadingState)
                              //   const LinearProgressIndicator(),
                            ],
                          ),
                        ),
                    ],
                  ),
                if (cubit.profileImage != null || cubit.coverImage != null)
                  const SizedBox(
                    height: 20.0,
                  ),
                circularDefaultFormField(
                  controller: nameController,
                  type: TextInputType.name,
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'name must not be empty';
                    }
                    return null;
                  },
                  label: 'Name',
                  prefix: IconBroken.User,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                circularDefaultFormField(
                  controller: bioController,
                  type: TextInputType.text,
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'bio must not be empty';
                    }
                    return null;
                  },
                  label: 'Bio',
                  prefix: IconBroken.Info_Circle,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                circularDefaultFormField(
                  controller: phoneController,
                  type: TextInputType.text,
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'phone number must not be empty';
                    }
                    return null;
                  },
                  label: 'Phone',
                  prefix: IconBroken.Call,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
