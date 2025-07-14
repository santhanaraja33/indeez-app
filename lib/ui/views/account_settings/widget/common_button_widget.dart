import 'package:flutter/material.dart';
import 'package:music_app/ui/common/app_colors.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/views/followers/presentation/followers_list_view.dart';
import 'package:music_app/ui/views/following/presentation/following_list_view.dart';

Widget accountSettingsWidget(
    dynamic viewModel, BuildContext context, String selectedStr, int index) {
  return TextButton(
    style: TextButton.styleFrom(
      backgroundColor: kcBlack, // 🔵 Background color
      minimumSize: const Size(double.infinity, 50), // 🔁 Full width
      padding: const EdgeInsets.symmetric(horizontal: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // 🔄 Rounded corners
      ),
    ),
    onPressed: () {
      viewModel.selectedStr = viewModel.menuItems[index];
      debugPrint("Tapped index: $index, value: ${viewModel.selectedStr}");
      viewModel.selectedStr == ksFollowers
          ? viewModel.navigationService
              .clearStackAndShowView(const FollowersListView())
          : viewModel.selectedStr == ksFollowingUsers
              ? viewModel.navigationService
                  .clearStackAndShowView(const FollowingListView())
              : null; // Your onTap logic here
    },
    child: Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween, // Text left, icon right
      children: [
        Text(
          selectedStr,
          style: const TextStyle(
            color: Colors.white, // ⚪ Text color
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.left,
        ),
        const Icon(
          Icons.arrow_forward_ios,
          color: Colors.white,
          size: 16,
        )
      ],
    ),
  );
}
