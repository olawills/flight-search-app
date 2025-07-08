import 'package:flutter/material.dart';

extension ShowOrNot on Widget {
  Widget? showOrNull(bool isShow) => isShow ? this : null;

  Widget showOrHide(bool isShow) => isShow ? this : const SizedBox();
  Widget showOrHideSliver(bool isShow) =>
      isShow ? this : SliverToBoxAdapter(child: const SizedBox());
  Widget showThisOrThat(bool showThis, {required Widget that}) =>
      showThis ? this : that;
}
