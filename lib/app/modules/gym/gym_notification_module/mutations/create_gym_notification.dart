import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:smarter/app/modules/gym/gym_notification_module/controllers/create_notification_controller.dart';

const createGymNotification = """
  mutation CreateGymNotification(\$classMasterName: String \$title: String \$contents: String \$images: [Upload] \$sendType:String \$sendDatetime:String \$eventDate:String){
    createGymNotification(classMasterName: \$classMasterName title: \$title contents: \$contents images: \$images sendType: \$sendType sendDatetime:\$sendDatetime eventDate:\$eventDate){
      success
    }
  }
""";

class CreateGymNotification extends StatelessWidget {
  const CreateGymNotification({Key? key, required this.builder})
      : super(key: key);
  final Widget Function(RunMutation runMutation, QueryResult<Object?>? result)
      builder;

  @override
  Widget build(BuildContext context) {
    return Mutation(
      options: MutationOptions(
          document: gql(createGymNotification),
          onCompleted: (result) {
            if (result == null) {
              CreateNotificationController.to.overlayLoadingProgress.stop();
              showSnackBar('에러');
              return;
            }
            if (result['createGymNotification']['success']) {
              Get.back(result: 'created');
              CreateNotificationController.to.overlayLoadingProgress.stop();
              showSnackBar('알림장이 생성되었습니다.');
            }
          }),
      builder: builder,
    );
  }
}
