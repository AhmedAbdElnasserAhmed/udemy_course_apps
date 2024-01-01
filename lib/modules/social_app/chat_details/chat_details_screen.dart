import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter_dart/layout/social_app/cubit/cubit.dart';
import 'package:udemy_flutter_dart/layout/social_app/cubit/states.dart';
import 'package:udemy_flutter_dart/models/social_app/message_model.dart';
import 'package:udemy_flutter_dart/models/social_app/social_user_model.dart';
import 'package:udemy_flutter_dart/shared/styles/colors.dart';
import 'package:udemy_flutter_dart/shared/styles/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget
{
  SocialUserModel? userModel;

  ChatDetailsScreen({super.key, this.userModel});

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    return Builder(
      builder: (BuildContext context)
      {
        var cubit = SocialCubit.get(context);

        cubit.getMessages(
          receiverId: userModel?.uId,
        );

        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(
                        '${userModel?.image}',
                      ),
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      '${userModel?.name}',
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: cubit.messages.isNotEmpty,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context , index)
                          {
                            var message = cubit.messages[index];
                            if(cubit.userModel!.uId == message.senderId)
                            {
                              return buildMyMessage(message);
                            }else
                            {
                              return buildMessage(message);
                            }
                          },
                          separatorBuilder: (context , index) => const SizedBox(
                            height: 15.0,
                          ),
                          itemCount: cubit.messages.length,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: messageController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    15.0,
                                  ),
                                ),
                                hintText: 'type your message here ...',
                              ),
                            ),
                          ),
                          // ElevatedButton(
                          //   onPressed: () {},
                          //   style: const ButtonStyle(
                          //     fixedSize: MaterialStatePropertyAll(
                          //       Size(
                          //         40.0,
                          //         50.0,
                          //       ),
                          //     ),
                          //   ),
                          //   child: const Icon(
                          //     IconBroken.Send,
                          //   ),
                          // ),
                          // Container(
                          //   height: 50.0,
                          //   color: Colors.grey[300],
                          //   // decoration: BoxDecoration(
                          //   //   borderRadius: BorderRadius.circular(15.0),
                          //   // ),
                          //   child: IconButton(
                          //     onPressed: (){},
                          //     style: ButtonStyle(),
                          //     icon: const Icon(
                          //         IconBroken.Send,
                          //       color: defaultColor,
                          //       size: 25.0,
                          //     ),
                          //   ),
                          // ),
                          const SizedBox(
                            width: 15.0,
                          ),
                          MaterialButton(
                            onPressed: ()
                            {
                              cubit.sendMessage(
                                receiverId: userModel!.uId.toString(),
                                dataTime: Timestamp.now().toDate().toString(),
                                text: messageController.text,
                              );
                              messageController.clear();
                            },
                            minWidth: 1.0,
                            height: 57.0,
                            color: defaultColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                15.0,
                              ),
                            ),
                            child: const Icon(
                              IconBroken.Send,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10.0,
          ),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadiusDirectional.only(
              topStart: Radius.circular(
                10.0,
              ),
              topEnd: Radius.circular(
                10.0,
              ),
              bottomEnd: Radius.circular(
                10.0,
              ),
            ),
          ),
          child: Text(
            '${model.text}',
          ),
        ),
      );

  Widget buildMyMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10.0,
          ),
          decoration: BoxDecoration(
            color: defaultColor.withOpacity(0.2),
            borderRadius: const BorderRadiusDirectional.only(
              topStart: Radius.circular(
                10.0,
              ),
              topEnd: Radius.circular(
                10.0,
              ),
              bottomStart: Radius.circular(
                10.0,
              ),
            ),
          ),
          child: Text(
            '${model.text}',
          ),
        ),
      );
}
