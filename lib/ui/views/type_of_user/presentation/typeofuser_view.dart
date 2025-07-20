import 'package:flutter/material.dart';
import 'package:music_app/ui/common/app_common_bg_image.dart';
import 'package:music_app/ui/common/app_image.dart';

import 'package:music_app/ui/views/type_of_user/view_model/typeofuser_viewmodel.dart';
import 'package:stacked/stacked.dart';

class TypeofuserView extends StackedView<TypeofuserViewmodel> {
  const TypeofuserView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    TypeofuserViewmodel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            const AppCommonBGImage(),

            // whoruImage BEHIND the tvImage
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.asset(
                AppImage.whoruImage,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 0.8,
              ),
            ),

            // tvImage on top of whoruImage
            Container(
              width:
                  MediaQuery.of(context).size.width * 0.9, // match image width
              decoration: BoxDecoration(
                color: Colors.transparent, // or any background color
                borderRadius: BorderRadius.circular(12), // optional
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Image.asset(
                viewModel.tvImage,
                fit: BoxFit.contain,
              ),
            ),

            // Popup message
            if (viewModel.showPopup)
              Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'You tapped the TV!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

            // GestureDetector over the TV
            GestureDetector(
              onTap: () => viewModel.onTVTap(context),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height:
                    MediaQuery.of(context).size.width * 0.6, // Adjust height
                color: Colors.transparent, // Transparent tappable area
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  TypeofuserViewmodel viewModelBuilder(
    BuildContext context,
  ) =>
      TypeofuserViewmodel();
}
