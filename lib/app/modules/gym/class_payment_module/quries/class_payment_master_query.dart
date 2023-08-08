import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

const classPaymentMaster = """
  query classPaymentMaster(\$id: ID!){
    classPaymentMaster(id: \$id){
      isApproved
      classPaymentMasterId
      memo
      className
      student{
        name
        birthday
        phone
        parent{
          relationship{
            name
          }
          user{
            phone
            name
          }
        }
      }
      dateFrom
      dateTo
      dateToPay
      datePaid
      paymentMethod
      daysDeduct
      price
      priceToPay
      paymentStatus
    }
  }
""";

class ClassPaymentMasterQuery extends StatelessWidget {
  const ClassPaymentMasterQuery(
      {Key? key, required this.builder, required this.id})
      : super(key: key);
  final Widget Function(
    Map<String, dynamic> payment,
  ) builder;
  final String? id;

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
          document: gql(classPaymentMaster), variables: {'id': id}),
      builder: (QueryResult<Object?> result,
          {Future<QueryResult<Object?>> Function(FetchMoreOptions)? fetchMore,
          Future<QueryResult<Object?>?> Function()? refetch}) {
        if (result.hasException) {
          if (kDebugMode) {
            print(result.exception);
          }
          return Container();
        }
        if (result.data == null) {
          return Container();
        }
        final payments = result.data!['classPaymentMaster'];
        return builder(payments);
      },
    );
  }
}
