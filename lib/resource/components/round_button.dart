import 'package:flutter/material.dart';
import 'package:mvvm_provider_example/resource/components/color.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onPress;
  const RoundButton({Key? key, required this.title, this.loading=false, required this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return loading ? CircularProgressIndicator() :
      InkWell(
        child: Container(
          height: 40,
          width: 200,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: AppColors.buttonColor,
              borderRadius: BorderRadius.circular(10)
          ),
          child: Text(title, style: TextStyle(color: AppColors.whiteColor)),
        ),
        onTap: onPress,
      );
  }
}
