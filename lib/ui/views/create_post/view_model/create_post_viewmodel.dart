import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:music_app/app/app.locator.dart';
import 'package:music_app/core/api/api_constants.dart';
import 'package:music_app/core/api/api_endpoints.dart';
import 'package:music_app/core/api/api_services.dart';
import 'package:music_app/shared_preferences/shared_preferences.dart';
import 'package:music_app/ui/common/app_strings.dart';
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
  bool isPrivate = false;
  String? selectedMode = 'public';

  PostUpdateModel? updatePostModel;

  PostDownloadMediaModel? downloadMedia;
  List<PostDownloadMediaModel> downloadMediaList = [];
  CreatePostModel? createPostModel;
  List<String> selectedFiles = [];
  List<File> selectedImages = [];
  List<Map<String, dynamic>> selectedImageItems = [];
  // void navigationToBottomBar() {
  //   navigationService.back();
  // }

  void checkBoxSelected(bool value) {
    isChecked = value;
    rebuildUi();
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
      if (selectedResourceType == "image") {
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
      String endpoint = "${ApiConstants.baseURL}${ApiEndpoints.createPostAPI}";
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
        Navigator.of(context).pop();
        for (int i = 0; i < createPostModel!.mediaUploadUrls!.length; i++) {
          final uploadUrl = createPostModel!.mediaUploadUrls![i].uploadUrl;
          final imagePath = selectedImages[i].path;
          final index =
              createPostModel!.postData!.mediaItems![i].index.toString();
          await uploadImageToAPI(
              uploadUrl!, imagePath, createPostModel!.postId!, index);
        }
        rebuildUi();
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
      print('Upload success: ${response.statusCode}');
      if (response.statusCode == 200) {
        imageUploadUpdateStatusAPI(postId, index);
      }
    } catch (e) {
      print('Upload failed: $e');
    }
  }

//Update Image upload status
  Future<void> imageUploadUpdateStatusAPI(String postId, String index) async {
    notifyListeners();
    try {
      String endpoint =
          "${ApiConstants.baseURL}${ApiEndpoints.updatePostAPI}${"/$postId"}";
      safePrint(endpoint);
      safePrint("imageUploadUpdateStatusAPI $index");

      final getUserId =
          await SharedPreferencesHelper.getLoginUserId(ksLoggedinUserId);
      final PostUpdateModel? updatePost = await ApiService().updatePostAPI(
          endpoint: endpoint,
          data: {"userId": getUserId, "index": index, "status": "uplpaded"});
      if (updatePost?.success == true) {
        updatePostModel = updatePost;
        debugPrint("Update post api response : ${updatePostModel?.message}");
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
