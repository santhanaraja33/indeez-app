import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/ui/common/app_colors.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/views/account_settings/presentation/account_settings_view.dart';
import 'package:music_app/ui/views/followers/view_model/followers_list_viewmodel.dart';
import 'package:stacked/stacked.dart';

class FollowersListView extends StackedView<FollowersListViewmodel> {
  const FollowersListView({Key? key}) : super(key: key);

  @override
  void onViewModelReady(FollowersListViewmodel viewModel) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.followingUsersList!.clear();
      viewModel.initializeEvents(); // ✅ This replaces initState
      viewModel.getFollowersListAPI();
    });
  }

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
      body: viewModel.followingUsersList!.isEmpty
          ? const Center(
              child: Text(
                'No Followups Found',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: viewModel.followingUsersList?.length,
              itemBuilder: (context, index) {
                debugPrint(
                    'followingList : ${viewModel.followingUsersList?.length}');
                final imageUrl = viewModel.followingUsersList?[index].avatarUrl;
                final validUrl = (imageUrl != null && imageUrl.isNotEmpty)
                    ? imageUrl
                    : 'https://via.placeholder.com/150'; // fallback

                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: validUrl,
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const SizedBox(
                            width: 70,
                            height: 70,
                            child: Center(child: CircularProgressIndicator()),
                          ),
                          errorWidget: (context, url, error) => const SizedBox(
                            width: 70,
                            height: 70,
                            child: Center(
                                child: Icon(
                              Icons.error,
                              color: kcWhite,
                            )),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${viewModel.followingUsersList?[index].firstName ?? ''} ${viewModel.followingUsersList?[index].lastName ?? ''}',
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
