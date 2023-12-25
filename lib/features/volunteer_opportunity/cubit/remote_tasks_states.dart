abstract class RemoteTasksState {}

class RemoteTasksInitial extends RemoteTasksState {}

class RemoteTasksLoading extends RemoteTasksState {}

class RemoteTasksSuccess extends RemoteTasksState {}

class RemoteTasksFailure extends RemoteTasksState {
  final String error;

  RemoteTasksFailure(this.error);
}

class JoinRemoteTasksLoading extends RemoteTasksState {}

class JoinRemoteTasksSuccess extends RemoteTasksState {}

class JoinRemoteTasksFailure extends RemoteTasksState {
  final String error;

  JoinRemoteTasksFailure(this.error);
}
class leftRemoteTasksLoading extends RemoteTasksState {}

class leftRemoteTasksSuccess extends RemoteTasksState {}

class leftRemoteTasksFailure extends RemoteTasksState {
  final String error;

  leftRemoteTasksFailure(this.error);
}