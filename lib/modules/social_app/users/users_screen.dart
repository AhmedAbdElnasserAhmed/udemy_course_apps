import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter_dart/layout/social_app/cubit/cubit.dart';
import 'package:udemy_flutter_dart/layout/social_app/cubit/states.dart';
import 'package:udemy_flutter_dart/modules/social_app/chat_details/chat_details_screen.dart';
import 'package:udemy_flutter_dart/shared/components/components.dart';
import 'package:udemy_flutter_dart/shared/styles/icon_broken.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);

        return ConditionalBuilder(
          condition: cubit.allUsers.isNotEmpty,
          builder: (context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                buildUsersItem(cubit.allUsers[index], context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: cubit.allUsers.length,
          ),
          fallback: (context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildUserShimmerItem(),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: 5,
          ),
        );
      },
    );
  }

  Widget buildUsersItem(model, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage(
                '${model.image}',
                // 'https://image.freepik.com/free-photo/skeptical-woman-has-unsure-questioned-expression-points-fingers-sideways_273609-40770.jpg',
              ),
            ),
            const SizedBox(
              width: 15.0,
            ),
            Text(
              '${model.name}',
              style: const TextStyle(
                height: 1.4,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                navigateTo(
                  context,
                  ChatDetailsScreen(
                    userModel: model,
                  ),
                );
              },
              icon: const Icon(
                IconBroken.Chat,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                IconBroken.Add_User,
              ),
            ),
          ],
        ),
      );

  Widget buildUserShimmerItem() => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 25.0,
          backgroundColor: Colors.grey[200],
        ),
        const SizedBox(
          width: 15.0,
        ),
        Container(
          height: 25.0,
          width: 200.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              15.0,
            ),
            color: Colors.grey[200],
          ),
        ),
        const SizedBox(
          width: 15.0,
        ),
        CircleAvatar(
          radius: 15.0,
          backgroundColor: Colors.grey[200],
        ),
        const SizedBox(
          width: 10.0,
        ),
        CircleAvatar(
          radius: 15.0,
          backgroundColor: Colors.grey[200],
        ),
        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     Container(
        //       height: 30.0,
        //       width: 287,
        //       color: Colors.grey[200],
        //       // decoration: BoxDecoration(
        //       //   borderRadius: BorderRadiusDirectional.circular(
        //       //     15.0,
        //       //   ),
        //       // ),
        //     ),
        //     const SizedBox(
        //       height: 10.0,
        //     ),
        //     Container(
        //       height: 30.0,
        //       width: 287,
        //       color: Colors.grey[200],
        //     ),
        //   ],
        // ),
      ],
    ),
  );
}
