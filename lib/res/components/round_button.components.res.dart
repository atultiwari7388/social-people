import 'package:flutter/material.dart';
import '../color.dart';

class RoundedButtonComponent extends StatelessWidget {
  const RoundedButtonComponent({
    Key? key,
    required this.title,
    required this.onPress,
    this.color = AppColors.primaryColor,
    this.textColor = AppColors.whiteColor,
    this.loading = false,
  }) : super(key: key);
  final String title;
  final VoidCallback onPress;
  final Color color, textColor;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loading ? null : onPress,
      child: Container(
        height: 50,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(50),
        ),
        child: loading
            ? const Center(
                child: CircularProgressIndicator(color: Colors.white))
            : Center(
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(fontSize: 16, color: color),
                ),
              ),
      ),
    );
  }
}
