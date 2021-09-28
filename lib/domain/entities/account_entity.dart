
class AccountEntity {
  final String token;

  AccountEntity(this.token);

  factory AccountEntity.fromjson(Map json) => AccountEntity(json['accessToken']);
}