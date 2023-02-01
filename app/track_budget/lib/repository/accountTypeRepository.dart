import 'package:sqflite/sqflite.dart';
import '../model/accountType.dart';
import 'commonRepository.dart';

class AccountTypeRepository extends CommonRepository{

  Future<void> create(AccountType accountType) async {
    // Insert some records in a transaction
    await database.transaction((txn) async {
      int id1 = await txn.rawInsert(
          'INSERT INTO ACCOUNT_TYPE (name, description) VALUES ("some name", "some description")');
      print('inserted1: $id1');
    });
  }

}