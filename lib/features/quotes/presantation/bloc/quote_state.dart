/* 
--Created by Edward Mansour-- Dec 4, 2022
*/
part of 'quote_bloc.dart';

@immutable
abstract class QuoteState extends Equatable {
  const QuoteState();

  @override
  List<Object> get props => [];
}

class QuoteInitial extends QuoteState {}

class Loading extends QuoteState {}

class Succeded extends QuoteState {
  final List<QuotesModel>? model;

  const Succeded({required this.model});

  @override
  List<Object> get props => [model ?? []];
}

class Error extends QuoteState {
  final String message;

  const Error({required this.message});

  @override
  List<Object> get props => [message];
}
