import 'package:blog/core/constants/edge_insets.constants.dart';
import 'package:blog/features/blog/presentation/widgets/chips/topic.chip.dart';
import 'package:flutter/material.dart';

class TopicSelectionList extends StatefulWidget {
  final Function(List<String> topics)? onChanged;

  const TopicSelectionList({
    super.key,
    this.onChanged,
  });

  @override
  State<TopicSelectionList> createState() => _TopicSelectionListState();
}

class _TopicSelectionListState extends State<TopicSelectionList> {
  final List<Map<String, dynamic>> _topics = [
    {
      'id': '1',
      'name': 'Technology',
    },
    {
      'id': '2',
      'name': 'Business',
    },
    {
      'id': '3',
      'name': 'Programming',
    },
    {
      'id': '4',
      'name': 'Entertaiment',
    },
  ];

  final List<String> _selectedTopics = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _topics.map(
          (topic) {
            return Padding(
              padding: EdgeInsetsConstants.R18,
              child: TopicChip(
                onPressed: () {
                  if (_selectedTopics.contains(topic['id'])) {
                    setState(() {
                      _selectedTopics.remove(topic['id']);
                    });
                  } else {
                    setState(() {
                      _selectedTopics.add(topic['id']);
                    });
                  }

                  if (widget.onChanged != null) {
                    widget.onChanged!(_selectedTopics);
                  }
                },
                isActive: _selectedTopics.contains(topic['id']),
                label: topic['name'],
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
