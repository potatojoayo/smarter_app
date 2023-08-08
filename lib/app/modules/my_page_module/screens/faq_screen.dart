import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/global/widgets/default_app_bar.dart';
import 'package:smarter/app/global/widgets/default_screen_padding.dart';
import 'package:smarter/app/global/widgets/my_query.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/my_page_module/faq_query.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: DefaultScreenPadding(
        vertical: 20,
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              DefaultText(
                '상호명 : 주식회사 스마터',
                style: Get.textTheme.labelMedium,
              ),
              DefaultText(
                '대표자 : 이 용 우',
                style: Get.textTheme.labelMedium,
              ),
              DefaultText(
                '사업자 등록번호 : 708 - 88 - 02401',
                style: Get.textTheme.labelMedium,
              ),
              DefaultText(
                '주소 : 광주광역시 광산구 용아로 667 가동 2층(오선동)',
                style: Get.textTheme.labelMedium,
              ),
              DefaultText(
                '대표자전화번호 : 1533 - 4147',
                style: Get.textTheme.labelMedium,
              ),
              DefaultText(
                '통신판매업 신고번호 : ',
                style: Get.textTheme.labelMedium,
              ),
            ],
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          defaultAppBar(title: '자주묻는 질문', showActions: false),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
                child: MyQuery(
              fetchPolicy: FetchPolicy.cacheAndNetwork,
              query: FaqQuery.faqs,
              builder: (result) {
                List<Map<String, dynamic>>? faqs =
                    List<Map<String, dynamic>>.from(
                        result.data!['faqs']['edges'].map((e) => e['node']));

                return Padding(
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 150),
                  child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final faq = faqs[index];
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[100],
                          ),
                          child: Theme(
                            data: ThemeData()
                                .copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              expandedAlignment: Alignment.topLeft,
                              childrenPadding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 20),
                              title: DefaultText(
                                faq['title'],
                                style: Get.textTheme.labelLarge,
                                overflow: TextOverflow.visible,
                              ),
                              children: [
                                DefaultText(
                                  faq['contents'],
                                  style: Get.textTheme.labelMedium,
                                  overflow: TextOverflow.visible,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                      itemCount: faqs.length),
                );
              },
            )),
          ),
        ],
      ),
    );
  }
}

/*

 */
