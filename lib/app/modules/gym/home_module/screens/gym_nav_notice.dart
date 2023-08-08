import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/gym/gym_notification_module/quries/gym_notifications_query.dart';
import 'package:smarter/app/modules/gym/gym_notification_module/widgets/gym_notification_list_item.dart';
import 'package:smarter/app/modules/gym/home_module/controllers/gym_nav_notice_controller.dart';
import 'package:smarter/app/routes/routes.dart';

class GymNavNotice extends StatelessWidget {
  const GymNavNotice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GymNotificationsQuery(
        builder: (notifications, refetch, fetchMore, hasNextPage, endCursor,
            totalCount) {
          GymNavNoticeController.to.fetchMoreNotification = fetchMore;

          return NotificationListener<ScrollEndNotification>(
            onNotification: (t) {
              final metrics = t.metrics;
              if (metrics.atEdge) {
                bool isTop = metrics.pixels == 0;
                if (!isTop && hasNextPage) {
                  FetchMoreOptions opts = FetchMoreOptions(
                      variables: {
                        'after': endCursor,
                        'titleIcontains':
                            GymNavNoticeController.to.searchWord.value
                      },
                      updateQuery: (previous, result) {
                        List? previousAttendances =
                            List<Map<String, dynamic>>.from(
                                previous!['myGymNotifications']['edges']);
                        List? newAttendances = List<Map<String, dynamic>>.from(
                            result!['myGymNotifications']['edges']);
                        final List<Map<String, dynamic>> notifications = [
                          ...previousAttendances,
                          ...newAttendances
                        ];
                        result['myGymNotifications']['edges'] = notifications;
                        return result;
                      });
                  fetchMore!(opts);
                }
              }
              return true;
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                                minWidth: 80, maxHeight: 40),
                            child: TextFormField(
                              controller: GymNavNoticeController
                                  .to.textEditingController,
                              style: Get.textTheme.labelLarge,
                              textAlign: TextAlign.start,
                              onChanged: (value) {
                                GymNavNoticeController.to.searchWord.value =
                                    value;
                              },
                              decoration: const InputDecoration(
                                alignLabelWithHint: true,
                                errorStyle: TextStyle(fontSize: 12),
                                counterText: '',
                                hintText: '검색',
                                hintStyle:
                                    TextStyle(fontSize: 15, color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                ),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: () async {
                            final result =
                                await Get.toNamed(Routes.createNotification);
                            if (result == 'created') {
                              GymNavNoticeController
                                  .to.textEditingController.text = '';
                              GymNavNoticeController.to.searchWord.value = '';
                              refetch();
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Get.theme.primaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Row(
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.solidPlus,
                                  size: 13,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                DefaultText(
                                  '알림 작성',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) {
                          if (index < notifications.length) {
                            final notification = notifications[index];
                            return GestureDetector(
                              onTap: () async {
                                final result = await Get.toNamed(
                                  Routes.modifyNotification,
                                  arguments: {
                                    'isCreate': false,
                                    'notification': notification
                                  },
                                );
                                if (result == 'modified') {
                                  GymNavNoticeController
                                      .to.textEditingController.text = '';
                                  GymNavNoticeController.to.searchWord.value =
                                      '';
                                  refetch();
                                }
                              },
                              child: GymNotificationListItem(
                                notification: notification,
                              ),
                            );
                          }
                          if (hasNextPage) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SpinKitChasingDots(
                                color: Get.theme.primaryColorDark,
                              ),
                            );
                          }
                          return Container();
                        },
                        separatorBuilder: (_, __) => const SizedBox(
                              height: 10,
                            ),
                        itemCount: notifications.length + 1),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
