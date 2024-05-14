import 'package:blog/core/common/widgets/animations/loading.animation.dart';
import 'package:flutter/material.dart';

void showLoading(BuildContext context) {
  if (_isThereCurrentDialogShowing(context)) Navigator.of(context).pop();

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => const Center(
      child: LoadingAnimation(),
    ),
  );
}

_isThereCurrentDialogShowing(BuildContext context) => ModalRoute.of(context)?.isCurrent != true;
