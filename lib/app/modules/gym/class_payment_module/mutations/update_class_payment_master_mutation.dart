import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';

const update = """
  mutation UpdateClassPaymentMaster(\$id: Int \$price: Int \$memo: String){
    updateClassPaymentMaster(classPaymentId: \$id price: \$price memo: \$memo){
      success
    }
  }
""";

class UpdateClassPaymentMasterMutation extends StatelessWidget {
  const UpdateClassPaymentMasterMutation({Key? key, required this.builder})
      : super(key: key);
  final Widget Function(RunMutation runMutation, QueryResult<Object?>? result)
      builder;

  @override
  Widget build(BuildContext context) {
    return Mutation(
      options: MutationOptions(
          document: gql(update),
          onCompleted: (result) {
            if (result == null) {
              showSnackBar('에러');
              return;
            }
            if (result['updateClassPaymentMaster']['success']) {
              Get.back();
              showSnackBar('저장되었습니다.');
            }
          }),
      builder: builder,
    );
  }
}
