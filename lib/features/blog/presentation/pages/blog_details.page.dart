import 'package:blog/core/constants/border_radius.constants.dart';
import 'package:blog/core/constants/edge_insets.constants.dart';
import 'package:blog/features/blog/domain/entities/blog.entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BlogDetailsPage extends StatelessWidget {
  static route({required BlogEntity blog}) => MaterialPageRoute(
        builder: (_) => BlogDetailsPage(
          blog: blog,
        ),
      );

  final BlogEntity _blog;

  const BlogDetailsPage({
    super.key,
    required BlogEntity blog,
  }) : _blog = blog;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Scrollbar(
          child: SingleChildScrollView(
            padding: EdgeInsetsConstants.ALL12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsConstants.B12,
                  child: Text(
                    _blog.title,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
                Text(
                  'By ${_blog.userName}',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  DateFormat('yyyy MMMM dd').format(DateTime.now()),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Padding(
                  padding: EdgeInsetsConstants.V24,
                  child: _buildImage(),
                ),
                Text(
                  _blog.content,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadiusConstants.ALL12,
      child: SizedBox(
        width: double.infinity,
        child: Image.network(
          _blog.imageUrl,
          frameBuilder: (BuildContext context, Widget child, int? frame, bool? wasSynchronouslyLoaded) {
            return child;
          },
          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }

            double progress = loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1);

            return Padding(
              padding: EdgeInsetsConstants.ALL12,
              child: Center(
                child: CircularProgressIndicator(
                  value: progress,
                  strokeCap: StrokeCap.round,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
