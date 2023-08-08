class SmarterMoneyQuery {
  static const String walletAndHistory = '''
    query MyWalletAndHistories(){
      myWallet{
        balance
      }
      mySmarterMoneyHistories{
        edges{
          node{
            amount
            transactionType
            description
            dateCreated
            orderNumber
          }
        }
      }
    }
  ''';
  static const String myWallet = '''
    query MyWallet{
      myWallet{
        balance
      }
    }
  ''';
  static const String history = '''
    query SmarterMoneyHistory(\$walletId:Int){
      smarterMoneyHistory(walletId: \$walletId){
        amount
        transactionType
        description
        dateCreated
        orderNumber
      }
    }
  ''';
}
