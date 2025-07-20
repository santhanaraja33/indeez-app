import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/ui/common/app_colors.dart';
import 'package:music_app/ui/common/app_image.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/views/account_settings/presentation/account_settings_view.dart';
import 'package:music_app/ui/views/following/view_model/following_list_viewmodel.dart';
import 'package:stacked/stacked.dart';

class FollowingListView extends StackedView<FollowingListModel> {
  const FollowingListView({Key? key}) : super(key: key);

  @override
  void onViewModelReady(FollowingListModel viewModel) {
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget builder(
    BuildContext context,
    FollowingListModel viewModel,
    Widget? child,
  ) {
    // Replace with your actual widget tree
    return Scaffold(
      backgroundColor: kcBlack,
      appBar: AppBar(
        title: Text(ksFollowingUsers,
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(
              fontSize: size_16,
              fontWeight: FontWeight.bold,
              color: kcWhite,
            )),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              viewModel.navigationService
                  .clearStackAndShowView(const AccountSettingsView());
            });
          },
        ),
      ),
      body: viewModel.followersList.isEmpty
          ? const Center(
              child: Text(
                ksFollowersNotFound,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: viewModel.followersList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            borderRadius_100,
                          ),
                          child: Image.asset(
                            viewModel.followersList[index].dimage ??
                                AppImage.appBGImage,
                            height: height_100,
                            width: width_100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              viewModel.followersList[index].dtitel ?? '',
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: kcWhite),
                            ),
                          ],
                        ),
                      ),

                      /// Follow Button
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(ksFOLLOWING),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  @override
  FollowingListModel viewModelBuilder(BuildContext context) =>
      FollowingListModel();
}
