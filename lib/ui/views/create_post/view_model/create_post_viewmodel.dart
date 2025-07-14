import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:music_app/app/app.locator.dart';
import 'package:music_app/app/app.router.dart';
import 'package:music_app/core/api/api_constants.dart';
import 'package:music_app/core/api/api_endpoints.dart';
import 'package:music_app/core/api/api_services.dart';
import 'package:music_app/shared_preferences/shared_preferences.dart';
import 'package:music_app/ui/common/app_colors.dart';
import 'package:music_app/ui/common/app_common_button.dart';
import 'package:music_app/ui/common/app_common_textfield.dart';
import 'package:music_app/ui/common/app_dropdown.dart';
import 'package:music_app/ui/common/app_image.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/views/bottom_bar/bottom_bar_view.dart';
import 'package:music_app/ui/views/create_post/model/create_audio_post_model.dart';
import 'package:music_app/ui/views/home/model/post/create_post_model.dart';
import 'package:music_app/ui/views/home/model/post/post_download_media_model.dart';
import 'package:music_app/ui/views/home/model/post/post_update_model.dart'
    show PostUpdateModel;
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:path/path.dart' as p;

class CreatePostViewmodel extends BaseViewModel {
  bool isChecked = false;
  final navigationService = locator<NavigationService>();
  String? selectedResourceType;
  final List<String> resourceTypes = ['Image', 'Video', 'Audio'];

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController mediaTitleController = TextEditingController();

  bool isPrivate = false;
  String? selectedMode = 'public';
  FilePickerResult? audioResult;
  PostUpdateModel? updatePostModel;
  bool _isPickingAudio = false;

  PostDownloadMediaModel? downloadMedia;
  List<PostDownloadMediaModel> downloadMediaList = [];
  CreatePostModel? createPostModel;
  List<String> selectedFiles = [];
  List<File> selectedImages = [];
  List<Map<String, dynamic>> selectedImageItems = [];

  CreateAudioPostModel? createAudioPostModel;

  void navigationToBottomBar() {
    navigationService.navigateToBottomBarView();
  }

  void checkBoxSelected(bool value) {
    isChecked = value;
    rebuildUi();
  }

  Future<void> pickAndUploadAudio(Function setState) async {
    if (_isPickingAudio) return; // prevent double trigger
    _isPickingAudio = true;

    FilePickerResult? result1 = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'wav', 'aac', 'ogg'],
    );
    debugPrint("result1: ${result1?.files.single.name}");
    if (result1 != null && result1.files.single.path != null) {
      String filePath = result1.files.single.path!;
      File _ = File(filePath);
      audioResult = result1;
    } else {
      print('No file selected');
    }
  }

  Future<void> createAudiPostMethod(BuildContext context) async {
    notifyListeners();
    try {
      String endpoint =
          "${ApiConstants.baseURL}${ApiEndpoints.createPostAPIAudio}";
      safePrint(endpoint);
      final getUserId =
          await SharedPreferencesHelper.getLoginUserId(ksLoggedinUserId);
      final CreateAudioPostModel? createPost =
          await ApiService().createAudioPostAPI(endpoint: endpoint, data: {
        "userId": getUserId,
        "posttitle": titleController.text.trim(),
        "mediaTitlename": mediaTitleController.text.trim(),
        "content": descController.text.trim(),
        "resourceType": selectedResourceType?.toLowerCase(),
        "audioMeta": {
          "fileName": audioResult?.files.single.name,
          "mimeType": "audio/mpeg"
        },
        "coverImageMeta": {
          "fileName": selectedImages.isNotEmpty
              ? selectedImages.first.path.split('/').last
              : null,
          "mimeType": "image/jpeg"
        }
      });
      debugPrint("image path: ${selectedImages.first.path}");
      if (createPost?.success == true) {
        createAudioPostModel = createPost;
        debugPrint(
            "Create post api response : ${createAudioPostModel!.uploadUrls?.audio?.uploadUrl}");
        await uploadAudioViaPut(
            audioResult?.files.single.path,
            createAudioPostModel!.uploadUrls!.audio!.uploadUrl,
            createAudioPostModel!.postId!);

        rebuildUi();
      } else {}
    } catch (e) {
      print('Create post api failed: $e');
    }
    notifyListeners();
  }

  Future<void> uploadAudioViaPut(
      String? audioPath, String? uploadUrl, String? postId) async {
    final dio = Dio();
    final audioFile = File(audioPath!);

    final mimeType = lookupMimeType(audioPath) ?? 'audio/mpeg';

    try {
      final audioBytes = await audioFile.readAsBytes();

      final response = await dio.put(
        uploadUrl!, // Replace with your actual upload URL
        data: audioBytes,
        options: Options(
          headers: {
            'Content-Type': mimeType,
          },
        ),
      );
      print('Audio Upload status code: ${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Audio uploaded successfully.');
        notifyListeners();
        try {
          String endpoint =
              "${ApiConstants.baseURL}${ApiEndpoints.updatePostAPI}${"/$postId"}";
          safePrint(endpoint);

          final getUserId =
              await SharedPreferencesHelper.getLoginUserId(ksLoggedinUserId);
          final PostUpdateModel? updatePost = await ApiService().updatePostAPI(
              endpoint: endpoint,
              data: {"userId": getUserId, "status": "uploaded"});
          if (updatePost?.success == true) {
            updatePostModel = updatePost;
            debugPrint(
                "Update post api response : ${updatePostModel?.message}");
            // WidgetsBinding.instance.addPostFrameCallback((_) {
            //   navigationService.clearStackAndShowView(const BottomBarView());
            // });
            if (selectedImages.isNotEmpty &&
                createAudioPostModel?.uploadUrls?.coverImage?.uploadUrl !=
                    null) {
              await uploadImageToAPI(
                  createAudioPostModel?.uploadUrls?.coverImage!.uploadUrl ?? '',
                  selectedImages.first.path,
                  createAudioPostModel!.postId!,
                  "0");
            }
            rebuildUi();
          } else {}
        } catch (e) {
          print('Update post api failed: $e');
        }
        notifyListeners();
      } else {
        print('Upload failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Upload error: $e');
    }
  }

  Future<void> pickMultipleImages(Function setState) async {
    try {
      // FilePickerResult? result =
      //     await FilePicker.platform.pickFiles(type: FileType.video);
      // if (result != null && result.files.single.path != null) {
      //   videoFile = File(result.files.single.path!);
      //   debugPrint("Selected video file: ${videoFile!.path}");
      //   uploadVideo(videoFile!);
      //   debugPrint("Selected video file: ${videoFile}");
      // }
      // selectedImages =
      //     result!.files.map((file) => File(file.path!)).toList(growable: false);
      // debugPrint("selectedImages: ${selectedImages}");

      // for (var xfile in result!.files) {
      //   final _ = p.extension(xfile.path ?? '');
      //   if (xfile.path != null) {
      //     selectedFiles.add(p.basename(xfile.path!));
      //   }
      // }
      // debugPrint("selectedFiles: ${selectedFiles}");

      final List<XFile>? files =
          await ImagePicker().pickMultipleMedia(imageQuality: 100);
      if (files == null || files.isEmpty) return;
      selectedImages = files.map((xfile) => File(xfile.path)).toList();
      debugPrint("selectedImages: ${selectedImages}");

      for (var xfile in files) {
        final _ = p.extension(xfile.path);
        selectedFiles.add(p.basename(xfile.path));
      }

      setState(() {});
      notifyListeners();
    } catch (e) {
      debugPrint('Error picking images: $e');
    }
  }

  Future<void> createPostMethod(BuildContext context) async {
    if (titleController.text.isEmpty || titleController.text.trim().isEmpty) {
      Fluttertoast.showToast(msg: ksPostTitle);
      return;
    }
    if (descController.text.isEmpty || descController.text.trim().isEmpty) {
      Fluttertoast.showToast(msg: ksPostDescription);
      return;
    }
    if (selectedResourceType!.isEmpty || selectedResourceType!.trim().isEmpty) {
      Fluttertoast.showToast(msg: ksResourceType);
      return;
    }
    if (selectedFiles.isEmpty) {
      Fluttertoast.showToast(
          msg: "Post creation $selectedResourceType is required");
      return;
    }
    if (selectedFiles.isNotEmpty) {
      if (selectedResourceType == "image" || selectedResourceType == "Image") {
        List<Map<String, dynamic>> fileList = createFileList(selectedFiles);
        debugPrint('Error picking images: $fileList');
        selectedImageItems.addAll(fileList);
        debugPrint('Error picking images 123 : \n $selectedImageItems');
      } else {
        // pickVideo();
        // List<Map<String, dynamic>> fileList = createFileList(selectedFiles);
        // debugPrint('Error picking images: $fileList');
      }
    }

    notifyListeners();
    try {
      String endpoint =
          "${ApiConstants.baseURL}${ApiEndpoints.createPostAPIImage}";
      safePrint(endpoint);
      final getUserId =
          await SharedPreferencesHelper.getLoginUserId(ksLoggedinUserId);
      final CreatePostModel? createPost =
          await ApiService().createPostAPI(endpoint: endpoint, data: {
        "userId": getUserId,
        "posttitle": titleController.text.trim(),
        "content": descController.text.trim(),
        "privacy": selectedMode ?? 'public',
        "resourceType": selectedResourceType?.toLowerCase(),
        "files": selectedImageItems
      });

      if (createPost?.success == true) {
        createPostModel = createPost;
        debugPrint("Create post api response : ${createPostModel?.message}");

        for (int i = 0; i < createPostModel!.mediaUploadUrls!.length; i++) {
          final uploadUrl = createPostModel!.mediaUploadUrls![i].uploadUrl;
          final imagePath = selectedImages[i].path;
          final index =
              createPostModel!.postData!.mediaItems![i].index.toString();
          await uploadImageToAPI(
              uploadUrl!, imagePath, createPostModel!.postId!, index);
        }
        // rebuildUi();
      } else {}
    } catch (e) {
      print('Create post api failed: $e');
    }
    notifyListeners();
  }

  //ImageUrl upload
  Future<void> uploadImageToAPI(String imageUploadUrl, String selectedImagePath,
      String postId, String index) async {
    final dio = Dio();
    try {
      final imageBytes = await File(selectedImagePath).readAsBytes();
      final mimeType =
          lookupMimeType(selectedImagePath) ?? 'application/octet-stream';
      Response response = await dio.put(
        imageUploadUrl,
        data: imageBytes,
        options: Options(
          headers: {
            'Content-Type': mimeType,
          },
        ),
      );
      print('Upload success image : ${response.statusCode}');
      if (response.statusCode == 200) {
        imageUploadUpdateStatusAPI(postId, index, selectedResourceType!);
      }
    } catch (e) {
      print('Upload failed: $e');
    }
  }

//Update Image upload status
  Future<void> imageUploadUpdateStatusAPI(
      String postId, String index, String fromResourceType) async {
    notifyListeners();
    try {
      final getUserId =
          await SharedPreferencesHelper.getLoginUserId(ksLoggedinUserId);
      String endpoint =
          "${ApiConstants.baseURL}${ApiEndpoints.updatePostAPI}${"/$postId"}";
      safePrint(endpoint);
      safePrint("imageUploadUpdateStatusAPI $index");
      safePrint("fromResourceType $fromResourceType");

      Map<String, dynamic> data = {};
      if (fromResourceType == "image" || fromResourceType == "Image") {
        data = {"userId": getUserId, "index": index, "status": "uploaded"};
      } else if (fromResourceType == "video" || fromResourceType == "Video") {
        // data = {"status": "uploaded", "index": index, "resourceType": "video"};
      } else if (fromResourceType == "audio" || fromResourceType == "Audio") {
        data = {"status": "uploaded", "userId": getUserId};
      }

      final PostUpdateModel? updatePost =
          await ApiService().updatePostAPI(endpoint: endpoint, data: data);
      if (updatePost?.success == true) {
        updatePostModel = updatePost;
        debugPrint("Update post api response : ${updatePostModel?.message}");
        WidgetsBinding.instance.addPostFrameCallback((_) {
          navigationService.clearStackAndShowView(const BottomBarView());
        });
        rebuildUi();
      } else {}
    } catch (e) {
      print('Update post api failed: $e');
    }
    notifyListeners();
  }

  List<Map<String, dynamic>> createFileList(List<String> fileNames) {
    return List.generate(fileNames.length, (index) {
      final fileName = fileNames[index];
      final mimeType = getMimeType(fileName);
      return {
        "fileName": fileName,
        "mimeType": mimeType,
        "index": index,
      };
    });
  }

// Helper function to get MIME type from file extension
  String getMimeType(String fileName) {
    if (fileName.endsWith(".png")) return "image/png";
    if (fileName.endsWith(".jpg") || fileName.endsWith(".jpeg")) {
      return "image/jpeg";
    }
    if (fileName.endsWith(".gif")) return "image/gif";
    if (fileName.endsWith(".mp4")) return "video/mp4";

    return "application/octet-stream"; // default fallback
  }
}
