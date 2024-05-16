import 'package:blog/core/constants/border_radius.constants.dart';
import 'package:blog/core/constants/color.constants.dart';
import 'package:blog/core/constants/edge_insets.constants.dart';
import 'package:blog/core/theme/app_palette.dart';
import 'package:blog/core/utils/get_color_from_string.dart';
import 'package:blog/core/utils/get_reading_time.dart';
import 'package:blog/features/blog/domain/entities/blog.entity.dart';
import 'package:blog/features/blog/presentation/pages/blog_details.page.dart';
import 'package:blog/features/blog/presentation/widgets/chips/topic.chip.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  final BlogEntity blog;

  const BlogCard(
    this.blog, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          BlogDetailsPage.route(
            blog: blog,
          ),
        );
      },
      child: Container(
        decoration: ShapeDecoration(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadiusConstants.ALL12,
          ),
          color: getColorFromString(blog.content),
        ),
        padding: EdgeInsetsConstants.ALL12,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsConstants.B12,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: blog.topics.map((topic) => TopicChip(label: topic)).toList(),
                ),
              ),
            ),
            Text(
              blog.title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              '${getReadingTime(blog.content).inMinutes.toString()} min',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
      ),
    );
  }
}
