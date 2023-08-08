import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:smarter/app/modules/gym/gym_notification_module/controllers/modify_notification_controller.dart';

const deleteGymNotification = """
  mutation DeleteGymNotification(\$gymNotificationId: Int){
    deleteGymNotification(gymNotificationId: \$gymNotificationId){
      success
    }
  }
""";

class DeleteGymNotification extends StatelessWidget {
  const DeleteGymNotification({Key? key, required this.builder})
      : super(key: key);
  final Widget Function(RunMutation runMutation, QueryResult<Object?>? result)
      builder;

  @override
  Widget build(BuildContext context) {
    return Mutation(
      options: MutationOptions(
          document: gql(deleteGymNotification),
          onCompleted: (result) {
            if (result == null) {
              ModifyNotificationController.to.loadingButtonController.stop();
              Get.back();
              showSnackBar('에러');
              return;
            }
            if (result['deleteGymNotification']['success']) {
              Get.back();
              Get.back(result: 'modified');
              showSnackBar('알림장이 삭제되었습니다.');
            }
          }),
      builder: builder,
    );
  }
}
