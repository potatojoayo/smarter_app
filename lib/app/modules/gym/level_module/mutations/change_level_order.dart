import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

const changeLevelOrder = """
  mutation changeLevelOrder(\$id: Int \$increase: Boolean ){
    changeLevelOrder(id: \$id increase: \$increase){
      success
    }
  }
""";

class ChangeLevelOrder extends StatelessWidget {
  const ChangeLevelOrder(
      {Key? key, required this.builder, required this.onComplete})
      : super(key: key);
  final Widget Function(RunMutation runMutation, QueryResult<Object?>? result)
      builder;
  final Function onComplete;

  @override
  Widget build(BuildContext context) {
    return Mutation(
      options: MutationOptions(
          document: gql(changeLevelOrder),
          onCompleted: (result) {
            if (result != null && result['changeLevelOrder']['success']) {
              onComplete(result['changeLevelOrder']['levels']);
            }
          }),
      builder: builder,
    );
  }
}
