import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:get/get.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import 'package:smarter/app/modules/auth_module/controllers/auth_controller.dart';
import 'package:smarter/app/routes/routes.dart';
import 'package:smarter/check_new_version.dart';
import 'package:smarter/show_event_bottom_sheet.dart';

class MainWrapperWidget extends StatefulWidget {
  const MainWrapperWidget({super.key, required this.child});

  final Widget child;

  @override
  State<MainWrapperWidget> createState() => _MainWrapperWidgetState();
}

class _MainWrapperWidgetState extends State<MainWrapperWidget>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed && mounted) {
      FlutterAppBadger.removeBadge();
      await checkNewVersion();
      AuthController.to.mixpanel = await Mixpanel.init(
          "9e4c51e4e73c2498c8e34dd278a6ec8c",
          trackAutomaticEvents: true);
      if (AuthController.to.user != null &&
          !AuthController.to.user!['isParticipatedEvent'] &&
          Get.routing.current != Routes.editMyInfo &&
          Get.routing.current != Routes.register) {
        showEventBottomSheet();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
