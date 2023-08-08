import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/data/provider/client.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:smarter/app/global/widgets/default_screen_padding.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/shop/product_module/product_mutation.dart';
import 'package:smarter/app/routes/routes.dart';
import 'package:smarter/graphql_api.dart';

class MyDraftsScreen extends StatelessWidget {
  const MyDraftsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DefaultText(
          '내 로고시안',
          style: Get.textTheme.bodyLarge,
        ),
        actions: [
          TextButton(
            onPressed: () async {
              final result = await Client().client.value.mutate(MutationOptions(
                    document: gql(ProductMutation.createDraftRequest),
                  ));
              final created = result.data!['createDraftRequest']['created'];
              if (!created) {
                showSnackBar('이미 시안을 요청하셨습니다. 관리자의 연락을 기다려주세요.');
              } else {
                showSnackBar('로고시안을 요청하셨습니다. 확인 후 연락 드리겠습니다.');
              }
            },
            child: const DefaultText(
              '로고시안 요청',
              style: TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(
            width: 24,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: DefaultScreenPadding(
          vertical: 16,
          child: Query(
            options: QueryOptions(
              document: MyDraftsQuery(variables: MyDraftsArguments()).document,
            ),
            builder: (result, {fetchMore, refetch}) {
              if (result.isLoading) {
                return Container();
              }
              if (result.hasException) {
                return Container();
              }

              final drafts = List<MyDrafts$Query$NewDraftType>.from(result
                  .data!['myDrafts']
                  .map((d) => MyDrafts$Query$NewDraftType.fromJson(d)));
              return ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final draft = drafts[index];
                  return Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(2, 2),
                            blurRadius: 16)
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            DefaultText(
                              draft.categoryName!,
                              style: TextStyle(
                                  color: Colors.grey[700], fontSize: 16),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            DefaultText(
                              '>',
                              style: TextStyle(
                                  color: Colors.grey[700], fontSize: 16),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            DefaultText(
                              draft.subCategoryName!,
                              style: TextStyle(
                                  color: Colors.grey[700], fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.fullScreenImage,
                                arguments: {'url': draft.image!});
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              draft.image!,
                              height: 160,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Wrap(
                          spacing: 24,
                          alignment: WrapAlignment.start,
                          direction: Axis.horizontal,
                          children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 DefaultText(
//                                   '작업비',
//                                   style: TextStyle(color: Colors.grey[600]),
//                                 ),
//                                 DefaultText(
//                                   formatMoney(draft.priceWork!),
//                                   style: const TextStyle(
//                                     fontSize: 24,
//                                   ),
//                                 ),
//                               ],
//                             ),

                            if (draft.font != null)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DefaultText(
                                    '폰트',
                                    style: TextStyle(
                                        color: Colors.grey[600], fontSize: 16),
                                  ),
                                  DefaultText(
                                    draft.font!,
                                    style: TextStyle(
                                        fontSize: 24, color: Colors.grey[700]),
                                  )
                                ],
                              ),
                            if (draft.threadColor != null)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DefaultText(
                                    '실색깔',
                                    style: TextStyle(
                                        color: Colors.grey[600], fontSize: 16),
                                  ),
                                  DefaultText(
                                    draft.threadColor!,
                                    style: TextStyle(
                                        fontSize: 24, color: Colors.grey[700]),
                                  )
                                ],
                              ),
                            if (draft.printing != null)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DefaultText(
                                    '프린팅',
                                    style: TextStyle(
                                        color: Colors.grey[600], fontSize: 16),
                                  ),
                                  DefaultText(
                                    draft.printing!,
                                    style: TextStyle(
                                        fontSize: 24, color: Colors.grey[700]),
                                  )
                                ],
                              ),
                          ],
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(
                  height: 16,
                ),
                itemCount: drafts.length,
              );
            },
          ),
        ),
      ),
    );
  }
}

/*

 */
