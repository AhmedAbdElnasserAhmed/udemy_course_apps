import 'package:flutter/material.dart';
import 'package:udemy_flutter_dart/shared/components/components.dart';

class NewPostScreen extends StatelessWidget
{
  const NewPostScreen({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: defaultAppBar(
        context: context,
        title: 'Add Post',
      ),
    );
  }
}
