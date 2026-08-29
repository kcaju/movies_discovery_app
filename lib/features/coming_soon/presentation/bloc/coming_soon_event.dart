import 'package:equatable/equatable.dart';

abstract class ComingSoonEvent extends Equatable {
  const ComingSoonEvent();

  @override
  List<Object?> get props => [];
}

class FetchComingSoonMoviesEvent extends ComingSoonEvent {
  final bool isRefresh;

  const FetchComingSoonMoviesEvent({this.isRefresh = false});

  @override
  List<Object?> get props => [isRefresh];
}
