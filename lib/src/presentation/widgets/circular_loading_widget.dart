import 'package:device_guru/src/utils/config/size_config.dart';
import 'package:device_guru/src/utils/theme/color_constants.dart';
import 'package:flutter/material.dart';

class CircularLoadingWidget extends StatelessWidget {
  const CircularLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
      height: SizeConfig.blockSizeVertical * 100,
      child: const Center(
        //TODO: Find out why it is not spinning
        child: CircularProgressIndicator(strokeWidth: 5,backgroundColor: ColorConstants.lightGrey,),
      ),
    );
  }
}