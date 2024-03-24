part of 'reports_cubit.dart';

@immutable
sealed class ReportsState {}

final class ReportsInitial extends ReportsState {}

class ReportsLoading extends ReportsState {}

class ReportsLoaded extends ReportsState {
  final MySingleton singleton;
  ReportsLoaded({required this.singleton});
}

class EmailSuccess extends ReportsState {
  final String reportDetails;
  EmailSuccess(this.reportDetails);
}

class EmailFailed extends ReportsState {}
