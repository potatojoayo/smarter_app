class OrderMutation {
  static const String completePayment = """
    mutation CompletePayment(\$orderNumber: String,
                              \$receiver: String!, 
                              \$phone: String!, 
                              \$zipCode: String!, 
                              \$address: String!, 
                              \$detailAddress: String, 
                              \$deliveryRequest: String,
                              \$smarterMoney: Int ){
      completePayment(orderNumber: \$orderNumber,
                                  receiver: \$receiver,
                                  phone: \$phone,
                                  zipCode: \$zipCode,
                                  address: \$address,
                                  detailAddress: \$detailAddress,
                                  smarterMoney: \$smarterMoney,
                                  deliveryRequest: \$deliveryRequest,
      ){
        success
        orderMaster{
          orderMasterId
        }
      }
    }
  """;

  static const String easyOrder = """
  mutation CreateEasyOrder(\$contents: String, \$files: [Upload], \$isVisit: Boolean, \$isOrderMore: Boolean){
      createEasyOrder(contents: \$contents, files: \$files, isVisit: \$isVisit, isOrderMore: \$isOrderMore){
        success
      }
    }
  """;

  static const String placeOrder = """
    mutation PlaceOrder( \$orderedProducts: [OrderedProductInputType], \$isPickUp: Boolean){
      placeOrder(orderedProducts: \$orderedProducts, isPickUp: \$isPickUp){
        success
        orderMaster{
          id
        }
      }
    }
  """;

  static const String cancelOrder = """
    mutation CancelOrder(\$orderMasterId: Int!){
      cancelOrder(orderMasterId: \$orderMasterId){
        success
      }
    }
  """;

  static const String depositWithoutAccount = """
    mutation DepositWithoutAccount(
    \$orderMasterId: Int!, 
    \$receiver: String!, 
    \$phone: String!, 
    \$zipCode: String!, 
    \$address: String!, 
    \$detailAddress: String, 
    \$deliveryRequest: String,
    \$smarterMoney: Int
    \$couponId: Int
    ){
      depositWithoutAccount(
        orderMasterId: \$orderMasterId,
        receiver: \$receiver,
        phone: \$phone,
        zipCode: \$zipCode,
        address: \$address,
        detailAddress: \$detailAddress,
        smarterMoney: \$smarterMoney,
        deliveryRequest: \$deliveryRequest,
        couponId: \$couponId
        ) {
          success
          orderMaster{
            id
          }
        }
     }
  """;
}
