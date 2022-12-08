/* 
--Created by Edward Mansour-- Dec 4, 2022
*/
part of 'quote_bloc.dart';

@immutable
abstract class QuoteEvent extends Equatable {
  const QuoteEvent();

  @override
  List<Object> get props => [];
}

class GetRandomQuote extends QuoteEvent {}
