import 'package:blog/core/common/widgets/animations/loading.animation.dart';
import 'package:blog/core/constants/double.constants.dart';
import 'package:blog/core/constants/edge_insets.constants.dart';
import 'package:blog/core/theme/app_palette.dart';
import 'package:blog/core/utils/show_loading.dart';
import 'package:blog/core/utils/show_snackbar.dart';
import 'package:blog/features/blog/presentation/blocs/blog/blog_bloc.dart';
import 'package:blog/features/blog/presentation/pages/blog_add.page.dart';
import 'package:blog/features/blog/presentation/widgets/cards/blog.card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogsPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (_) => const BlogsPage(),
      );

  const BlogsPage({super.key});

  @override
  State<BlogsPage> createState() => _BlogsPageState();
}

class _BlogsPageState extends State<BlogsPage> {
  @override
  void initState() {
    super.initState();

    context.read<BlogBloc>().add(BlogReadAllBlogs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {},
        listenWhen: (prevState, currentState) {
          if (currentState is BlogFailure) {
            showSnackBar(context, currentState.error);
            return false;
          }

          return true;
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Center(
              child: LoadingAnimation(),
            );
          }

          if (state is BlogReadAllBlogsSuccess) {
            return ListView.separated(
              padding: EdgeInsetsConstants.ALL12,
              itemBuilder: (BuildContext context, int index) {
                return BlogCard(state.blogs[index]);
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: DoubleConstants.X12,
                );
              },
              itemCount: state.blogs.length,
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(
        'DailAI',
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).push(BlogAddPage.route());
          },
          icon: const Icon(
            CupertinoIcons.add_circled,
          ),
        ),
      ],
    );
  }
}
