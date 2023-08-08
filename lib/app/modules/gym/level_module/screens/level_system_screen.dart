import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/gym/level_module/mutations/change_level_order.dart';
import 'package:smarter/app/modules/gym/level_module/quries/levels.dart';
import 'package:smarter/app/routes/routes.dart';

class LevelSystemScreen extends StatefulWidget {
  const LevelSystemScreen({Key? key}) : super(key: key);

  @override
  State<LevelSystemScreen> createState() => _LevelSystemScreenState();
}

class _LevelSystemScreenState extends State<LevelSystemScreen> {
  @override
  Widget build(BuildContext context) {
    return Levels(
      builder: (QueryResult<Object?> result,
          {Future<QueryResult<Object?>> Function(FetchMoreOptions)? fetchMore,
          Future<QueryResult<Object?>?> Function()? refetch}) {
        if (result.hasException) {
          return Container();
        }
        if (result.data == null) {
          return Container();
        }
        List<Map<String, dynamic>> levels =
            List<Map<String, dynamic>>.from(result.data!['myLevels']);

        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            title: DefaultText(
              '승급체계',
              style: Get.textTheme.bodySmall,
            ),
            centerTitle: false,
            actions: [
              IconButton(
                  onPressed: () async {
                    await Get.toNamed('${Routes.levelSystem}/-1');
                    refetch!();
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.plus,
                  ))
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
              child: ChangeLevelOrder(
                builder: (MultiSourceResult<dynamic> Function(
                            Map<String, dynamic>,
                            {Object? optimisticResult})
                        changeOrder,
                    QueryResult<Object?>? result) {
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final level = levels[index];
                      return GestureDetector(
                        onTap: () async {
                          await Get.toNamed(
                              '${Routes.levelSystem}/${level['id']}');
                          refetch!();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[100]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 4,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex:3,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              DefaultText(
                                                '급수',
                                                style: TextStyle(
                                                    fontSize: 10, color: Colors.grey[500]),
                                              ),
                                              DefaultText(
                                                level['name'],
                                                style: Get.textTheme.labelLarge,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              DefaultText(
                                                '띠',
                                                style: TextStyle(
                                                    fontSize: 10, color: Colors.grey[500]),
                                              ),
                                              DefaultText(
                                                level['belt'],
                                                style: Get.textTheme.labelLarge,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10,),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex:3,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              DefaultText(
                                                '색상',
                                                style: TextStyle(
                                                    fontSize: 10, color: Colors.grey[500]),
                                              ),
                                              DefaultText(
                                                level['beltColor']??'',
                                                style: Get.textTheme.labelLarge,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              DefaultText(
                                                '브랜드',
                                                style: TextStyle(
                                                    fontSize: 10, color: Colors.grey[500]),
                                              ),
                                              DefaultText(
                                                level['beltBrand']??'',
                                                style: Get.textTheme.labelLarge,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // Expanded(flex: 1, child: Container()),
                              Expanded(
                                flex: 3,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    index > 0
                                        ? IconButton(
                                            onPressed: () => changeOrder({
                                              'id': level['id'],
                                              'increase': false,
                                            }),
                                            icon: const FaIcon(
                                              FontAwesomeIcons.solidCircleArrowUp,
                                              size: 25,
                                            ),
                                          )
                                        : Container(),
                                    index != levels.length - 1
                                        ? IconButton(
                                            onPressed: () => changeOrder({
                                              'id': level['id'],
                                              'increase': true,
                                            }),
                                            icon: const FaIcon(
                                              FontAwesomeIcons
                                                  .solidCircleArrowDown,
                                              size: 25,
                                            ),
                                          )
                                        : Container()
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                    itemCount: levels.length,
                  );
                },
                onComplete: (result) {
                  refetch!();
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
