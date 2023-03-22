import '../repository/accountTypeRepository.dart';

class AccountTypeService {

  AccountTypeRepository accountTypeRepository = AccountTypeRepository();

  void create(){

  }
  void update(){}
  void delete(){}
  Future<List<Map>> listAll(){
    print("service list all");
    return accountTypeRepository.getRecords();
  }
}