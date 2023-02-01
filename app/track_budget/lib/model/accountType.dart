class AccountType{

  int id;
  String name;
  String description;

  AccountType(this.id, this.name, this.description);

  @override
  String toString() {
    return 'AccountType{id: $id, name: $name, description: $description}';
  }
}