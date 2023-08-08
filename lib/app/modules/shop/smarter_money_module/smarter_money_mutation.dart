class SmarterMoneyMutation {
  static const String charge = '''
    mutation ChargeSmarterMoney(\$orderId: String!){
      chargeSmarterMoney(orderId: \$orderId){
        wallet {
          balance
        }
      }
    }
  ''';

  static const String request = '''
    mutation CreateChargeRequest(\$amount: Int!, \$method: String!){
      createChargeRequest(amount: \$amount, method: \$method){
        success
      }
    }
  ''';

  static const String createChargeRequest = '''
    mutation CreateChargeOrder(\$amount: Int!, \$method: String){
      createChargeOrder(amount: \$amount, method: \$method){
        chargeOrder{
          orderId
          orderName
          amount
        }
      }
    }
  ''';
}
