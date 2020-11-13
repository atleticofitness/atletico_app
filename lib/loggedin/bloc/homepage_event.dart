part of 'homepage_bloc.dart';

abstract class HomepageEvent extends Equatable {
  const HomepageEvent();

  @override
  List<Object> get props => [];
}

class HomepageUserEvent extends HomepageEvent {
  const HomepageUserEvent();

  Future<Token> loadToken() async {
    var box = await Hive.openBox('token');
    return Token.fromJson(box.getAt(0));
  }

  Future<User> getUser(Token token) async {
    User user = await getCurrentUser(token);
    return user;
  }

  @override
  List<Object> get props => [];
}
