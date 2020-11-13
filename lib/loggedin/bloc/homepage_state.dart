part of 'homepage_bloc.dart';

abstract class HomepageState extends Equatable {
  const HomepageState();

  @override
  List<Object> get props => [];
}

class HomepageInitial extends HomepageState {}

class HomepageFormState extends HomepageState {
  final bool isInitial;
  final Token token;
  final User user;

  const HomepageFormState({this.isInitial, this.token, this.user});

  HomepageFormState copyWith({bool isInitial, Token token, User user}) =>
      HomepageFormState(
          isInitial: isInitial ?? this.isInitial,
          token: token ?? this.token,
          user: user ?? this.user);
}
