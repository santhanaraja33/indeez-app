import 'package:flutter/material.dart';
import 'package:music_app/ui/views/create_post/view_model/create_post_viewmodel.dart';
import 'package:music_app/ui/views/create_post/widgets/create_post_form.dart';
import 'package:stacked/stacked.dart';

class CreatePostView extends StackedView<CreatePostViewmodel> {
  const CreatePostView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CreatePostViewmodel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: buildCheckbox(viewModel, context),
    );
  }

  @override
  CreatePostViewmodel viewModelBuilder(
    BuildContext context,
  ) =>
      CreatePostViewmodel();
}
