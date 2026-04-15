import 'package:equatable/equatable.dart';
import 'package:mobile_app/core/enums/request_status.dart';
import 'package:mobile_app/features/auth/domain/entities/auth_user_entity.dart';

class AuthState extends Equatable {
  final RequestStatus requestStatus;
  final bool isAuthenticated;
  final String? error;
  final AuthUserEntity? user;

  const AuthState({
    this.requestStatus = RequestStatus.initial,
    this.isAuthenticated = false,
    this.error,
    this.user,
  });

  AuthState copyWith({
    RequestStatus? requestStatus,
    bool? isAuthenticated,
    String? error,
    bool clearError = false,
    AuthUserEntity? user,
    bool clearUser = false,
  }) {
    return AuthState(
      requestStatus: requestStatus ?? this.requestStatus,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      error: clearError ? null : (error ?? this.error),
      user: clearUser ? null : (user ?? this.user),
    );
  }

  @override
  List<Object?> get props => [requestStatus, isAuthenticated, error, user];
}
