import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/app/app.router.dart';
import 'package:music_app/ui/common/app_colors.dart';
import 'package:music_app/ui/common/app_common_button.dart';
import 'package:music_app/ui/common/app_common_textfield.dart';
import 'package:music_app/ui/common/app_dropdown.dart';
import 'package:music_app/ui/common/app_image.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/views/bottom_bar/bottom_bar_view.dart';
import 'package:music_app/ui/views/create_post/view_model/create_post_viewmodel.dart';

Widget buildCheckbox(CreatePostViewmodel viewModel, BuildContext context) {
  return StatefulBuilder(builder: (context, setState) {
    return Dialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImage.appBGImage),
                fit: BoxFit.cover,
              ),
            ),
            child: Scaffold(
                backgroundColor: Colors.black.withOpacity(0.6),
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }

                      //  => Navigator.of(context).pop(),
                      ),
                  title: const Text('Create Post',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
                body: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AppDropDown(
                        title: 'Resource Type',
                        dropDownHint: 'Select a resource',
                        value: viewModel.resourceTypes
                                .contains(viewModel.selectedResourceType)
                            ? viewModel.selectedResourceType
                            : null,
                        onChanged: (val) {
                          setState(() {
                            viewModel.selectedResourceType = val;
                          });
                        },
                        items: viewModel.resourceTypes.map((type) {
                          return DropdownMenuItem<String>(
                            value: type,
                            child: Text(
                              type,
                              style: GoogleFonts.lato(
                                  color: Colors.blueGrey, fontSize: 16),
                            ),
                          );
                        }).toList(),
                        titleTextColor: Colors.grey,
                        // bgColor: Colors.black87,
                      ),
                      const SizedBox(height: 20),
                      // Post Title
                      AppCommonTextfield(
                        controller: viewModel.titleController,
                        keyboardType: TextInputType.text,
                        label: Text(
                          ksTitle,
                          style: GoogleFonts.lato(color: kcTextGrey),
                        ),
                        onSubmitted: (p0) {},
                      ),

                      AppCommonTextfield(
                        controller: viewModel.titleController,
                        keyboardType: TextInputType.name,
                        readOnly: !viewModel.isChecked,
                        label: Text(
                          ksLastName,
                          style: GoogleFonts.lato(color: kcTextGrey),
                        ),
                        onSubmitted: (p0) {},
                      ),

                      const SizedBox(height: 15),

                      if (viewModel.selectedResourceType == "audio" ||
                          viewModel.selectedResourceType == "Audio")
                        AppCommonTextfield(
                          controller: viewModel.mediaTitleController,
                          height: height_80,
                          keyboardType: TextInputType.text,
                          minLines: 3,
                          maxLines: null,
                          label: Text(
                            ksAudioTrackTitle,
                            style: GoogleFonts.lato(color: kcTextGrey),
                          ),
                          onSubmitted: (p0) {},
                        ),

                      // Description
                      AppCommonTextfield(
                        controller: viewModel.descController,
                        height: height_100,
                        keyboardType: TextInputType.text,
                        minLines: 3,
                        maxLines: null,
                        label: Text(
                          ksDesc,
                          style: GoogleFonts.lato(color: kcTextGrey),
                        ),
                        onSubmitted: (p0) {},
                      ),

                      const SizedBox(height: 15),

                      if (viewModel.selectedResourceType == "video" ||
                          viewModel.selectedResourceType == "Video" ||
                          viewModel.selectedResourceType == "Image" ||
                          viewModel.selectedResourceType == "image")
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ksPrivatePostTitle,
                              style: GoogleFonts.lato(
                                  color: Colors.white, fontSize: 15),
                            ),
                            Switch(
                              value: viewModel.isPrivate,
                              onChanged: (val) {
                                setState(() {
                                  viewModel.isPrivate = val;
                                  if (viewModel.isPrivate == true) {
                                    viewModel.selectedMode = "private";
                                  } else {
                                    viewModel.selectedMode = "public";
                                  }
                                });
                              },
                              activeColor: Colors.white,
                            ),
                          ],
                        ),
                      const SizedBox(height: 20),
                      if (viewModel.selectedFiles.isEmpty)
                        GestureDetector(
                          onTap: () {
                            viewModel.pickMultipleImages(setState);
                          },
                          child: Container(
                            height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.white30),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.add_a_photo,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                      const SizedBox(height: 20),

                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: viewModel.selectedFiles.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  viewModel.selectedImages[index],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),
                              // Positioned close button in top-right
                              Positioned(
                                top: 6,
                                right: 6,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      viewModel.selectedFiles.removeAt(index);
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: const BoxDecoration(
                                      color: Colors.black54,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.close,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),

                      if (viewModel.selectedResourceType == "audio" ||
                          viewModel.selectedResourceType == "Audio")
                        GestureDetector(
                          onTap: () {
                            viewModel.pickAndUploadAudio(setState);
                          },
                          child: Container(
                            height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.white30),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.music_note,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      const SizedBox(height: 20),

                      // Submit Button
                      SizedBox(
                        width: double.infinity,
                        child: AppCommonButton(
                          onPressed: () {
                            if (viewModel.selectedFiles.isEmpty &&
                                viewModel.selectedResourceType != "audio" &&
                                viewModel.selectedResourceType != "Audio") {
                              viewModel.createPostMethod(context);
                              return;
                            } else {
                              viewModel.createAudiPostMethod(context);
                            }
                          },
                          buttonName: ksCreatePost,
                        ),
                      ),
                    ],
                  ),
                ))));
  });
}
