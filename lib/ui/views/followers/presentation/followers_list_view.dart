import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/ui/common/app_colors.dart';
import 'package:music_app/ui/common/app_image.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/views/account_settings/presentation/account_settings_view.dart';
import 'package:music_app/ui/views/followers/view_model/followers_list_viewmodel.dart';
import 'package:stacked/stacked.dart';

class FollowersListView extends StackedView<FollowersListViewmodel> {
  const FollowersListView({Key? key}) : super(key: key);

  @override
  void onViewModelReady(FollowersListViewmodel viewModel) {}

  @override
  Widget builder(
    BuildContext context,
    FollowersListViewmodel viewModel,
    Widget? child,
  ) {
    // Replace with your actual UI
    return Scaffold(
      backgroundColor: kcBlack,
      // endDrawer: const RightmenuView(),
      appBar: AppBar(
        title: Text(ksUserFollowers,
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
                'No Followups Found',
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
                    ],
                  ),
                );
              },
            ),
    );
  }

  @override
  FollowersListViewmodel viewModelBuilder(BuildContext context) =>
      FollowersListViewmodel();
}
