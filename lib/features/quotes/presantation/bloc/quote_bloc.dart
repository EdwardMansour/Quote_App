/* 
--Created by Edward Mansour-- Dec 4, 2022
*/
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/error/failures.dart';
import 'package:speeches/core/useCase/use_case.dart';
import 'package:speeches/features/quotes/data/models/quotes_model.dart';
import 'package:speeches/features/quotes/data/models/Exceptions/error_messages.dart';
import 'package:speeches/features/quotes/domain/useCases/get_random_quote.dart';

part 'quote_event.dart';
part 'quote_state.dart';

class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  final GetRandomQuoteUsecase getRandomQuote;

  QuoteBloc({required this.getRandomQuote}) : super(QuoteInitial()) {
    on<GetRandomQuote>((event, emit) => mapEventToState(emit));
  }

  void mapEventToState(Emitter<QuoteState> emit) async {
    emit(Loading());
    final value = await getRandomQuote.call(NoParams());
    _eitherSucceededOrErrorState(value, emit);
  }

  void _eitherSucceededOrErrorState(
    Either<Failure, List<QuotesModel>> failureOrQuote,
    Emitter<QuoteState> emit,
  ) async {
    failureOrQuote.fold(
      (failure) async => emit(Error(message: _mapFailureToMessage(failure))),
      (quote) async => emit(Succeded(model: quote)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return ErrorMessages.SERVER_FAILURE_MESSAGE;
      case TimeoutFailure:
        return ErrorMessages.TIMEOUT_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
