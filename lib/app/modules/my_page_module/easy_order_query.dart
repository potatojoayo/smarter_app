class EasyOrderQuery {
  static const String myEasyOrders = '''
  query MyEasyOrders(\$after: String) {
    myEasyOrders(first:10, after: \$after){
        totalCount
        pageInfo {
          endCursor
          hasNextPage
        }
      edges{
        node{
            contents
            state
            order{
              id
              orderMasterId
              states
            }
            dateCreated
            dateCompleted
          }
      }
    }
  }
 ''';
}
