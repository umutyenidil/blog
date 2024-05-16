import 'dart:io';

import 'package:blog/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog/core/constants/edge_insets.constants.dart';
import 'package:blog/core/utils/show_loading.dart';
import 'package:blog/core/utils/show_snackbar.dart';
import 'package:blog/features/blog/presentation/widgets/lists/topic_selection.list.dart';
import 'package:blog/features/blog/presentation/blocs/blog/blog_bloc.dart';
import 'package:blog/features/blog/presentation/pages/blogs.page.dart';
import 'package:blog/features/blog/presentation/widgets/inputs/image.input.dart';
import 'package:blog/features/blog/presentation/widgets/inputs/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogAddPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (_) => const BlogAddPage(),
      );

  const BlogAddPage({super.key});

  @override
  State<BlogAddPage> createState() => _BlogAddPageState();
}

class _BlogAddPageState extends State<BlogAddPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  File? _image;
  List<String> _topics = [];

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackBar(context, state.error);
          } else if (state is BlogCreateSuccess) {
            Navigator.of(context).pushAndRemoveUntil(
              BlogsPage.route(),
              (route) => false,
            );
          }
        },
        listenWhen: (prevState, currentState) {
          if (currentState is BlogLoading) {
            showLoading(context);
          } else if (prevState is BlogLoading && currentState is BlogFailure) {
            Navigator.of(context).pop();
          }

          return true;
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsetsConstants.ALL18,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    ImageInput(
                      onChanged: (value) => _image = value,
                    ),
                    Padding(
                      padding: EdgeInsetsConstants.V18,
                      child: TopicSelectionList(
                        onChanged: (topics) => _topics = topics,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsConstants.B12,
                      child: Input(
                        controller: _titleController,
                        hint: 'Title',
                      ),
                    ),
                    Input(
                      controller: _contentController,
                      isExpandable: true,
                      hint: 'Content',
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(
        'BlogAddPage',
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: _onDonePressed,
          icon: const Icon(
            Icons.done_rounded,
          ),
        ),
      ],
    );
  }

  void _onDonePressed() {
    if (_formKey.currentState!.validate() &&
        _topics.isNotEmpty &&
        _image != null) {
      String userId =
          (context.read<AppUserCubit>().state as AppUserLoggedIn).user.id;

      context.read<BlogBloc>().add(
            BlogCreate(
              userId: userId,
              image: _image!,
              topics: _topics,
              title: _titleController.text.trim(),
              content: _contentController.text.trim(),
            ),
          );
    }
  }
}
