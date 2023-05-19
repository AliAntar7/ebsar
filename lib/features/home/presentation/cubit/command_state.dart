part of 'command_cubit.dart';

abstract class CommandState extends Equatable {
  const CommandState();
  @override
  List<Object> get props => [];
}


class WelcomeStartState extends CommandState {}
class CommandSearchLoading extends CommandState {}
class CommandSearchLoaded extends CommandState {}
class CommandSearchError extends CommandState {
  final String message;
  const CommandSearchError({required this.message});
}
class CommandPlay extends CommandState {}
class WelcomeEndState extends CommandState {}
class CategoryLoadingState extends CommandState {}
class CategoryLoadedState extends CommandState {}
class CategoryErrorState extends CommandState {
  final String message;
  const CategoryErrorState({required this.message});
}
class CommandInitial extends CommandState {}
class CommandLoading extends CommandState {}
class CommandBookLoading extends CommandState {}
class CommandLoaded extends CommandState {}
class CommandBookLoaded extends CommandState {}
class CategoryVoiceLoadingState extends CommandState {}
class CategoryVoiceLoadedState extends CommandState {}
class CommandStop extends CommandState {}
class CommandStopToSearch extends CommandState {}
class CommandError extends CommandState {
  final String message;
  const CommandError({required this.message});
}
