part of 'splash_cubit.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object?> get props => [];
}

class SplashInitial extends SplashState {}

class SplashPermissionDenied extends SplashState {}

class SplashNavigate extends SplashState {
  final AppFlow flow;
  const SplashNavigate(this.flow);
  @override
  List<Object?> get props => [flow];
}