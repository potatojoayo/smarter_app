import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:smarter/app/modules/gym/student_module/controllers/audition_detail_controller.dart';

const auditionDetailPass = """
  mutation AuditionDetailPass(\$auditionDetailId: Int \$didPass: Boolean \$memo: String){
    auditionDetailPass(auditionDetailId: \$auditionDetailId didPass: \$didPass memo: \$memo){
      success
      detail{
        id
        student{
          classMaster{
            name
          }
          name
          birthday
          gender
        }
        didPass
        memo
      }
    }
  }
""";

class AuditionDetailPassMutation extends StatelessWidget {
  const AuditionDetailPassMutation(
      {Key? key, required this.builder, required this.onComplete})
      : super(key: key);
  final Widget Function(RunMutation runMutation, QueryResult<Object?>? result)
      builder;
  final Function() onComplete;

  @override
  Widget build(BuildContext context) {
    return Mutation(
      options: MutationOptions(
          document: gql(auditionDetailPass),
          onCompleted: (result) async{
            if (result == null) {
              AuditionDetailController.to.loadingButtonController.stop();
              showSnackBar('에러');
              return;
            } else {
              await onComplete();
              Get.back();
            }
          }),
      builder: builder,
    );
  }
}
