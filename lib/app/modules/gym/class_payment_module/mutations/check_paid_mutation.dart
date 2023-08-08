import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';

const paidCheck = """
  mutation PaidCheck(\$method: String \$id: Int){
    paidCheck(method: \$method classPaymentMasterId: \$id){
      success
    }
  }
""";

class PaidCheck extends StatelessWidget {
  const PaidCheck({Key? key, required this.builder}) : super(key: key);
  final Widget Function(RunMutation runMutation, QueryResult<Object?>? result)
      builder;

  @override
  Widget build(BuildContext context) {
    return Mutation(
      options: MutationOptions(
          document: gql(paidCheck),
          onCompleted: (result) {
            if (result == null) {
              showSnackBar('에러');
              return;
            }
            if (result['paidCheck']['success']) {
              Get.back();
              showSnackBar('입금이 확인되었습니다.');
            }
          }),
      builder: builder,
    );
  }
}
