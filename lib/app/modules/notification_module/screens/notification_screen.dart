import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/notification_module/controllers/notification_controller.dart';
import 'package:smarter/app/modules/notification_module/notification_query.dart';
import 'package:smarter/app/modules/notification_module/widgets/notification_item.dart';

class NotificationScreen extends GetView<NotificationController> {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: DefaultText(
            '알림',
            style: Get.textTheme.bodySmall,
          ),
        ),
        body: SingleChildScrollView(
            child: Query(
          options: QueryOptions(
            document: gql(NotificationQuery.myNotifications),
          ),
          builder: (QueryResult<Object?> result,
              {Future<QueryResult<Object?>> Function(FetchMoreOptions)?
                  fetchMore,
              Future<QueryResult<Object?>?> Function()? refetch}) {
            if (result.isLoading) {
              return SpinKitChasingDots(
                color: Get.theme.primaryColorDark,
              );
            }
            List? notifications = result.data != null
                ? List.from(result.data!['myNotifications']['edges']
                    .map((e) => e['node']))
                : null;

            if (notifications == null) {
              return const Text('None');
            }

            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return NotificationItem(notification: notification);
              },
              itemCount: notifications.length,
            );
          },
        )),
        // floatingActionButton: const KakaoFloatingActionButton(),
      ),
    );
  }
}
