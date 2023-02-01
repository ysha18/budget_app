import 'accountType.dart';
import 'currency.dart';

class Account {

  int id;
  String name;
  AccountType accountType;
  Currency currency;

  Account({required this.id, required this.name, required this.accountType, required this.currency});

  @override
  String toString() {
    return 'Account{id: $id, name: $name, accountType: $accountType, currency: $currency}';
  }

}