import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/ui/common/app_colors.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/views/account_settings/presentation/account_settings_view.dart';
import 'package:music_app/ui/views/following/view_model/following_list_viewmodel.dart';
import 'package:stacked/stacked.dart';

class FollowingListView extends StackedView<FollowingListViewmodel> {
  const FollowingListView({Key? key}) : super(key: key);

  @override
  void onViewModelReady(FollowingListViewmodel viewModel) {
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    viewModel.getFollowingListAPI();
  }

  @override
  Widget builder(
    BuildContext context,
    FollowingListViewmodel viewModel,
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
      body: viewModel.followUsersList!.isEmpty
          ? const Center(
              child: Text(
                ksFollowersNotFound,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: viewModel.followUsersList?.length,
              itemBuilder: (context, index) {
                final imageUrl = viewModel.followUsersList?[index].avatarUrl;
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
                          color: kcWhite,
                          placeholder: (context, url) => const SizedBox(
                            width: 70,
                            height: 70,
                            child: Center(child: CircularProgressIndicator()),
                          ),
                          errorWidget: (context, url, error) => const SizedBox(
                            width: 70,
                            height: 70,
                            child: Center(
                                child: Icon(Icons.person_2_rounded,
                                    color: kcWhite)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${viewModel.followUsersList?[index].firstName ?? ''} ${viewModel.followUsersList?[index].lastName ?? ''}',
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
                        onPressed: () {
                          viewModel.toFollowAUserAPI(
                              viewModel.followUsersList![index].userId ?? '',
                              context);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(ksFollowing),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  @override
  FollowingListViewmodel viewModelBuilder(BuildContext context) =>
      FollowingListViewmodel();
}
