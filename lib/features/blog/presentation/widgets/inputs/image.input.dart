import 'dart:io';

import 'package:blog/core/constants/border_radius.constants.dart';
import 'package:blog/core/constants/double.constants.dart';
import 'package:blog/core/constants/edge_insets.constants.dart';
import 'package:blog/core/constants/text_style.constants.dart';
import 'package:blog/core/utils/pick_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class ImageInput extends StatefulWidget {
  final Function(File? value)? onChanged;

  const ImageInput({
    super.key,
    this.onChanged,
  });

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _image;

  @override
  Widget build(BuildContext context) {
    if (_image != null) {
      return Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadiusConstants.ALL12,
            child: Image.file(_image!),
          ),
        ],
      );
    }

    return InkWell(
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadiusConstants.ALL12,
      onTap: _onPressed,
      child: DottedBorder(
        color: Theme.of(context).colorScheme.outline,
        borderType: BorderType.RRect,
        radius: const Radius.circular(12.0),
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsetsConstants.ALL12.add(
              EdgeInsetsConstants.V24,
            ),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsetsConstants.B18,
                  child: Icon(
                    Icons.folder,
                    size: DoubleConstants.X48,
                  ),
                ),
                Text(
                  'Select your image',
                  style: TextStyleConstants.REGULAR16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onPressed() async {
    File? image = await pickImage();
    if (widget.onChanged != null) {
      setState(() {
        _image = image;
        widget.onChanged!(image);
      });
    }
  }
}
