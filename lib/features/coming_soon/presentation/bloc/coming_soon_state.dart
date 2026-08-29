import 'package:equatable/equatable.dart';
import '../../../dashboard/data/models/movie_model.dart';

abstract class ComingSoonState extends Equatable {
  const ComingSoonState();

  @override
  List<Object?> get props => [];
}

class ComingSoonInitial extends ComingSoonState {}

class ComingSoonLoading extends ComingSoonState {}

class ComingSoonLoaded extends ComingSoonState {
  final List<MovieModel> movies;

  const ComingSoonLoaded({required this.movies});

  @override
  List<Object?> get props => [movies];
}

class ComingSoonEmpty extends ComingSoonState {
  final String message;

  const ComingSoonEmpty({this.message = 'No upcoming movies found.'});

  @override
  List<Object?> get props => [message];
}

class ComingSoonError extends ComingSoonState {
  final String message;

  const ComingSoonError({required this.message});

  @override
  List<Object?> get props => [message];
}
