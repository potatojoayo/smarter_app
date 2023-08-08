import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:smarter/app/modules/gym/gym_notification_module/controllers/modify_notification_controller.dart';

const updateGymNotification = """
  mutation UpdateGymNotification(\$gymNotificationId: Int  \$classMasterName: String \$title: String \$contents: String \$images: [Upload] \$sendType:String \$sendDatetime:String \$eventDate:String){
    updateGymNotification(gymNotificationId: \$gymNotificationId  classMasterName: \$classMasterName title: \$title contents: \$contents images: \$images sendType: \$sendType sendDatetime:\$sendDatetime eventDate:\$eventDate){
      success
    }
  }
""";

class ModifyGymNotification extends StatelessWidget {
  const ModifyGymNotification({Key? key, required this.builder})
      : super(key: key);
  final Widget Function(RunMutation runMutation, QueryResult<Object?>? result)
      builder;

  @override
  Widget build(BuildContext context) {
    return Mutation(
      options: MutationOptions(
          document: gql(updateGymNotification),
          onCompleted: (result) {
            if (result == null) {
              ModifyNotificationController.to.overlayLoadingProgress.stop();
              showSnackBar('에러');
              return;
            }
            if (result['updateGymNotification']['success']) {
              ModifyNotificationController.to.overlayLoadingProgress.stop();
              Get.back(result: 'modified');
              showSnackBar('알림장이 수정되었습니다.');
            }
          }),
      builder: builder,
    );
  }
}
