import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'paylist_popup_viewmodel.dart';

class PaylistPopupView extends StackedView<PaylistPopupViewModel> {
  const PaylistPopupView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PaylistPopupViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      ),
    );
  }

  @override
  PaylistPopupViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      PaylistPopupViewModel();
}
