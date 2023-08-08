import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';

const auditionMasterPass = """
  mutation AuditionMasterPass(\$auditionMasterId: Int \$estimatedAlarmDate: String){
    auditionMasterPass(auditionMasterId: \$auditionMasterId estimatedAlarmDate: \$estimatedAlarmDate){
      success
    }
  }
""";

class AuditionMasterPassMutation extends StatelessWidget {
  const AuditionMasterPassMutation({Key? key, required this.builder, required this.onComplete}) : super(key: key);

  final Widget Function(RunMutation runMutation, QueryResult<Object?>? result) builder;
  final Function() onComplete;

  @override
  Widget build(BuildContext context) {
    return Mutation(
      options: MutationOptions(
        document: gql(auditionMasterPass),
        onCompleted: (result){
          if(result == null){
            showSnackBar('에러');
            return;
          }else{
            onComplete();
            Get.back();
          }
        }
      ),
      builder: builder,

    );
  }
}
