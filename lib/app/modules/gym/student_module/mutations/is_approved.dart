import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:smarter/app/modules/gym/class_payment_module/controllers/class_payment_controller.dart';
import 'package:smarter/app/modules/gym/class_payment_module/controllers/class_payment_controller2.dart';

const isApproved = """
  mutation IsApproved(\$classPaymentMasterIds : [Int] \$date: String){
    isApproved(classPaymentMasterIds: \$classPaymentMasterIds date: \$date){
      success
    }
  }
""";

class IsApprovedMutation extends StatelessWidget {
  const IsApprovedMutation(
      {Key? key, required this.builder, required this.onComplete})
      : super(key: key);
  final Widget Function(RunMutation runMutation, QueryResult<Object?>? result)
      builder;
  final Function onComplete;

  @override
  Widget build(BuildContext context) {
    return Mutation(
      options: MutationOptions(
        document: gql(isApproved),
        onCompleted: (result) async {
          if (result == null) {
            ClassPaymentController.to.loadingButtonController.stop();
            showSnackBar('에러');
            return;
          }
          if (result['isApproved']['success']) {
            ClassPaymentController.to.selectedUnapprovedPayments.clear();
            ClassPaymentController2.to.selectedUnapprovedPayments.clear();
            onComplete();
            Get.back();
            // showSnackBar('고지서가 발송되었습니다.');
          }
        },
      ),
      builder: builder,
    );
  }
}
