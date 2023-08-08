// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/gym/student_module/quries/auditions_query.dart';
import 'package:smarter/app/modules/gym/student_module/widgets/audition_item.dart';
import 'package:smarter/app/routes/routes.dart';

class AuditionScreen extends StatelessWidget {
  const AuditionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuditionsQuery(builder: (
      List<Map<String, dynamic>> auditions,
      bool hasNextPage,
      String? endCursor,
      int totalCount,
      fetchMore,
      refetch,
    ) {
      final fetchMoreOptions = FetchMoreOptions(
          variables: {
            'after': endCursor,
            'first': 10,
          },
          updateQuery: (previous, result) {
            List? previousAuditions = List<Map<String, dynamic>>.from(
                previous!['myAuditions']['edges']);
            List? newAuditions = List<Map<String, dynamic>>.from(
                result!['myAuditions']['edges']);
            final List<Map<String, dynamic>> auditions = [
              ...previousAuditions,
              ...newAuditions
            ];
            result['myAuditions']['edges'] = auditions;
            return result;
          });

      return NotificationListener<ScrollEndNotification>(
        onNotification: (t) {
          final metrics = t.metrics;
          if (metrics.atEdge) {
            bool isTop = metrics.pixels == 0;
            if (!isTop) {
              fetchMore!(fetchMoreOptions);
            }
          }
          return true;
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () async {
                    final result = await Get.toNamed(Routes.createAudition);
                    if (result != null) {
                      refetch!();
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Get.theme.primaryColorDark,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.solidPlus,
                          size: 15,
                          color: Get.theme.colorScheme.background,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const DefaultText(
                          '승급 생성',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (_, index) {
                    if (index < auditions.length) {
                      final audition = auditions[index];
                      return GestureDetector(
                        onTap: () async {
                          await Get.toNamed(
                              '${Routes.auditionDetail}/${audition['id']}');
                          refetch!();
                        },
                        child: AuditionItem(audition: audition),
                      );
                    }
                    return hasNextPage
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SpinKitChasingDots(
                              color: Get.theme.primaryColorDark,
                            ),
                          )
                        : Container();
                  },
                  separatorBuilder: (_, __) => const SizedBox(
                    height: 8,
                  ),
                  itemCount: auditions.length + 1,
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
