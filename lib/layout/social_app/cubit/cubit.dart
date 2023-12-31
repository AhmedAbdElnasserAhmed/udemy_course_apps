import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:udemy_flutter_dart/layout/social_app/cubit/states.dart';
import 'package:udemy_flutter_dart/models/social_app/message_model.dart';
import 'package:udemy_flutter_dart/models/social_app/post_model.dart';
import 'package:udemy_flutter_dart/models/social_app/social_user_model.dart';
import 'package:udemy_flutter_dart/modules/social_app/chats/chats_screen.dart';
import 'package:udemy_flutter_dart/modules/social_app/feeds/feeds_screen.dart';
import 'package:udemy_flutter_dart/modules/social_app/new_post/new_post_screen.dart';
import 'package:udemy_flutter_dart/modules/social_app/settings/settings_screen.dart';
import 'package:udemy_flutter_dart/modules/social_app/users/users_screen.dart';
import 'package:udemy_flutter_dart/shared/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates>
{
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? userModel;

  void getUserData()
  {
    emit(SocialGetUserLoadingState());

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value)
    {
      if(value.id == uId)
      {
        userModel = SocialUserModel.fromJson(value.data()!);
      }
      emit(SocialGetUserSuccessState());
    }).catchError((error)
    {
      if (kDebugMode)
      {
        print(error.toString());
      }
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;

  List<Widget> screens = [
    const FeedsScreen(),
    const ChatsScreen(),
    NewPostScreen(),
    const UsersScreen(),
    const SettingsScreen(),
  ];

  List<String> titles = [
    'Home',
    'Chats',
    'Post',
    'Users',
    'Settings',
  ];

  void changeBottomNav(int index) {
    if (index == 1) getAllUsersData();

    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  File? profileImage;

  //var picker = ImagePicker();
  final ImagePicker picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      if (kDebugMode) {
        print(pickedFile.path);
      }
      emit(SocialProfileImagePickedSuccessState());
    } else {
      if (kDebugMode) {
        print('No image selected.');
      }
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      if (kDebugMode) {
        print(pickedFile.path);
      }
      emit(SocialCoverImagePickedSuccessState());
    } else {
      if (kDebugMode) {
        print('No image selected.');
      }
      emit(SocialCoverImagePickedErrorState());
    }
  }

  // /data/user/0/com.example.udemy_flutter_dart/cache/968efdfc-bf93-4e0f-8aaf-729adaf884a4/Screenshot_2023-11-22-04-57-02-601_com.linkedin.android.jpg
  // IMG_20231114_134049.jpg

  void upLoadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //emit(SocialUploadProfileImageSuccessState());
        if (kDebugMode) {
          print(value);
        }
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          image: value,
        );
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void upLoadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //emit(SocialUploadCoverImageSuccessState());
        if (kDebugMode) {
          print(value);
        }
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          cover: value,
        );
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
    });
  }

  // void updateUserImages({
  //   required String name,
  //   required String phone,
  //   required String bio,
  // })
  // {
  //   emit(SocialUserUpdateLoadingState());
  //
  //   if(coverImage != null)
  //   {
  //     upLoadCoverImage();
  //   } else if(profileImage != null)
  //   {
  //     upLoadProfileImage();
  //   } else if(coverImage != null && profileImage != null)
  //   {
  //
  //   } else
  //   {
  //     updateUser(
  //       name: name,
  //       phone: phone,
  //       bio: bio,
  //     );
  //   }
  // }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      email: userModel!.email,
      phone: phone,
      uId: userModel!.uId,
      bio: bio,
      image: image ?? userModel!.image,
      cover: cover ?? userModel!.cover,
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialUserUpdateErrorState());
    });
  }

  File? postImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      if (kDebugMode) {
        print(pickedFile.path);
      }
      emit(SocialPostImagePickedSuccessState());
    } else {
      if (kDebugMode) {
        print('No image selected.');
      }
      emit(SocialPostImagePickedErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  void uploadPostImage({
    required String dataTime,
    required String text,
  }) {
    emit(SocialCreatePostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        if (kDebugMode) {
          print(value);
        }
        createPost(
          dataTime: dataTime,
          text: text,
          postImage: value,
        );
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void createPost({
    required String dataTime,
    required String text,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingState());

    PostModel model = PostModel(
      name: userModel!.name,
      uId: userModel!.uId,
      image: userModel!.image,
      dataTime: dataTime,
      text: text,
      postImage: postImage,
      // postImage: postImage ?? '', wrong given you an error ''.
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  // void getPost()
  // {
  //   FirebaseFirestore.instance.collection('posts').get().then((value) {
  //     emit(SocialGetPostLoadingstate());
  //
  //     for (var element in value.docs) {
  //       element.reference.collection('likes').get().then((likesValue) {
  //         likesnum.add(likesValue.docs.length);
  //
  //         // Retrieve comments for each post
  //         element.reference.collection('comments').get().then((commentsValue) {
  //           commentnum.add(commentsValue.docs.length);
  //
  //           commentsValue.docs.map((commentDoc) {
  //             return CommentModel2.fromjason(commentDoc.data());
  //           }).toList();
  //
  //           // Add the post to the list
  //           posts.add(Postmodel.fromjason(element.data()));
  //           postId.add(element.id);
  //
  //           // Check if this is the last post to update the UI or emit an event
  //           if (posts.length == value.docs.length) {
  //             emit(SocialGetPostSuccesststate());
  //
  //           }
  //         }).catchError((e) {
  //           emit(SocialGetPostErrorstate(e.toString()));
  //
  //         });
  //       }).catchError((e) {
  //         emit(SocialGetPostErrorstate(e.toString()));
  //
  //       });
  //     }
  //   }).catchError((e) {
  //     emit(SocialGetPostErrorstate(e.toString()));
  //   });
  // }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];

  void getPosts()
  {
    //emit(SocialGetPostsLoadingState());
    if (posts.isEmpty)
    {
      FirebaseFirestore.instance
          .collection('posts')
          .get()
          .then((value)
      {
        for (var element in value.docs)
        {
          element.reference
              .collection('likes')
              .get()
              .then((value)
          {
            likes.add(value.docs.length);
            postsId.add(element.id);
            posts.add(PostModel.fromJson(element.data()));
            // print(posts.isNotEmpty);
          }).catchError((error) {
            throw (error.toString());
          });
        }
        emit(SocialGetPostsSuccessState());
      }).catchError((error) {
        emit(SocialGetPostsErrorState(error.toString()));
      });
    }
  }

  // void getLikes() {
  //   if (likes.isEmpty) {
  //     FirebaseFirestore.instance
  //         .collection('posts')
  //         .doc()
  //         .collection('likes')
  //         .get()
  //         .then((value) {})
  //         .catchError((error) {});
  //   }
  // }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostErrorState(error.toString()));
    });
  }

  List<SocialUserModel> allUsers = [];

  void getAllUsersData() {
    emit(SocialGetAllUsersLoadingState());

    if (allUsers.isEmpty) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        for (var element in value.docs) {
          if (element.data()['uId'] != userModel?.uId) {
            allUsers.add(SocialUserModel.fromJson(element.data()));
          }
        }

        emit(SocialGetAllUsersSuccessState());
      }).catchError((error) {
        // throw(error.toString());
        emit(SocialGetAllUsersErrorState(error.toString()));
      });
    }
  }

  void sendMessage({
    required String receiverId,
    required String dataTime,
    required String text,
  })
  {
    MessageModel model = MessageModel(
      senderId: userModel!.uId,
      receiverId: receiverId,
      dataTime: dataTime,
      text: text,
    );

    // set my chats

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value)
    {
      emit(SocialSendMessageSuccessState());
    })
        .catchError((error)
    {
      emit(SocialSendMessageErrorState());
    });

    //set receiver chats

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value)
    {
      emit(SocialSendMessageSuccessState());
    })
        .catchError((error)
    {
      emit(SocialSendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessages({
    required String? receiverId,
})
  {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dataTime')
        .snapshots()
        .listen((event)
    {
      messages = [];

      for (var element in event.docs)
      {
        messages.add(MessageModel.fromJson(element.data()));
      }

      emit(SocialGetMessagesSuccessState());
    });
  }
}
