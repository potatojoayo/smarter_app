import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/data/provider/client.dart';
import 'package:smarter/app/modules/shop/smarter_money_module/smarter_money_query.dart';

class SmarterMoneyController extends GetxController {
  static SmarterMoneyController get to => Get.find();

  final _balance = 0.obs;
  int get balance => _balance.value;
  set balance(value) => _balance.value = value;

  final _wallet = Rx<Map<String, dynamic>?>(null);
  Map<String, dynamic>? get wallet => _wallet.value;
  set wallet(value) => _wallet.value = value;

  @override
  void onInit() async {
    super.onInit();
    await getSmarterMoney();
  }

  Future<void> getSmarterMoney() async {
    final result = await Client().client.value.query(
          QueryOptions(
            document: gql(
              SmarterMoneyQuery.myWallet,
            ),
          ),
        );
    balance = result.data!['myWallet']['balance'];
  }
}
