import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter_dart/layout/social_app/cubit/cubit.dart';
import 'package:udemy_flutter_dart/layout/social_app/cubit/states.dart';
import 'package:udemy_flutter_dart/shared/components/components.dart';
import 'package:udemy_flutter_dart/shared/styles/icon_broken.dart';

class NewPostScreen extends StatelessWidget
{
  NewPostScreen({super.key});

  var textController = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);

        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Create Post',
            actions: [
              defaultTextBottom(
                function: ()
                {
                  var now = DateTime.now();

                  if (cubit.postImage == null)
                  {
                    cubit.createPost(
                      dataTime: now.toString(),
                      text: textController.text,
                    );
                  } else {
                    cubit.uploadPostImage(
                      dataTime: now.toString(),
                      text: textController.text,
                    );
                  }

                  textController.clear();
                },
                text: 'post',
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is SocialCreatePostLoadingState)
                  const LinearProgressIndicator(),
                if(state is SocialCreatePostLoadingState)
                  const SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                        '${cubit.userModel!.image}',
                      ),
                      // backgroundImage: NetworkImage(
                      //   'https://image.freepik.com/free-photo/skeptical-woman-has-unsure-questioned-expression-points-fingers-sideways_273609-40770.jpg',
                      // ),
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: Text(
                        '${cubit.userModel!.name}',
                        style: const TextStyle(
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: const InputDecoration(
                      hintText: 'what is on your mind ...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                if(cubit.postImage != null)
                  Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height: 140.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          4.0,
                        ),
                        image: DecorationImage(
                          image: FileImage(cubit.postImage!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: ()
                      {
                        cubit.removePostImage();
                      },
                      icon: const CircleAvatar(
                        radius: 13.0,
                        //radius: 20.0,
                        child: Icon(
                          Icons.close,
                          size: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          cubit.getPostImage();
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              IconBroken.Image,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              'add photos',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          '# tags',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
