import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  bool? isLoading;
  Widget child;
  LoadingWidget({
    Key? key,
    this.isLoading,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading == null) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.orange,
        ),
      );
    } else if (isLoading == false) {
      return const Center(
        child: Text("Bir Sorun oluştu"),
      );
    } else {
      return child;
    }
  }
}
