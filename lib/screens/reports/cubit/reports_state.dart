part of 'reports_cubit.dart';

@immutable
sealed class ReportsState {}

final class ReportsInitial extends ReportsState {}

class ReportsLoading extends ReportsState {}

class ReportsLoaded extends ReportsState {
  final MySingleton singleton;
  ReportsLoaded({required this.singleton});
}

class ReportsEmpty extends ReportsState {}

class EmailSuccess extends ReportsState {}

class EmailFailed extends ReportsState {}
