class GetUser{
  final String uid;
  GetUser({required this.uid});
}

class UserData{
  final String uid;
  final String name;
  final String quote;
  final String importance;
  final int reputation;
  UserData({required this.uid,required this.name,required this.importance,required this.quote, required this.reputation});
}