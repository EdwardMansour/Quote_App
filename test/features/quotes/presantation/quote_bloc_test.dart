/* 
--Created by Edward Mansour-- Dec 5, 2022
*/
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import '../../../mock/mock_reader.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:speeches/core/error/failures.dart';
import 'package:speeches/core/useCase/use_case.dart';
import 'package:speeches/features/quotes/presantation/bloc/bloc.dart';
import 'package:speeches/features/quotes/domain/useCases/get_random_quote.dart';
import 'package:speeches/features/quotes/data/models/Exceptions/error_messages.dart';

import 'quote_bloc_test.mocks.dart';

@GenerateNiceMocks(
    [MockSpec<GetRandomQuoteUsecase>(as: #MockRandomQuoteUsecase)])
void main() {
  late QuoteBloc bloc;
  late MockRandomQuoteUsecase mockGetRandomQuoteUsecase;

  setUp(() {
    mockGetRandomQuoteUsecase = MockRandomQuoteUsecase();
    bloc = QuoteBloc(getRandomQuote: mockGetRandomQuoteUsecase);
  });

  group('GetRandomQuoteUsecase', () {
    test(
      'initial state shloud be QuoteInitial',
      () async {
        await expectLater(bloc.state, QuoteInitial());
      },
    );
    test(
      'should get data from the random use case',
      () async {
        when(mockGetRandomQuoteUsecase(any))
            .thenAnswer((_) async => const Right([quotesModel]));

        bloc.add(GetRandomQuote());
        await untilCalled(mockGetRandomQuoteUsecase(any));

        ///! assert
        verify(mockGetRandomQuoteUsecase(NoParams()));
      },
    );

    blocTest<QuoteBloc, QuoteState>(
      'should emit [Loading, Succeded] when data is gotten successfully',
      setUp: () {
        when(mockGetRandomQuoteUsecase(any))
            .thenAnswer((_) async => const Right([quotesModel]));
      },
      build: () => bloc,
      act: (bloc) => bloc.add(GetRandomQuote()),
      wait: const Duration(seconds: 2),

      ///! assert
      expect: () => [
        Loading(),
        const Succeded(model: [quotesModel]),
      ],
    );

    blocTest<QuoteBloc, QuoteState>(
      'should emit [Loading, Error] when getting data fails',
      setUp: () => when(mockGetRandomQuoteUsecase(any))
          .thenAnswer((_) async => Left(ServerFailure())),
      build: () => bloc,
      act: (bloc) => bloc.add(GetRandomQuote()),
      wait: const Duration(seconds: 2),

      ///! assert
      expect: () => [
        Loading(),
        const Error(message: ErrorMessages.SERVER_FAILURE_MESSAGE),
      ],
    );

    blocTest<QuoteBloc, QuoteState>(
      'should emit [Loading, Error] with a proper message for the error when getting session timeout',
      setUp: () => when(mockGetRandomQuoteUsecase(any))
          .thenAnswer((_) async => Left(TimeoutFailure())),
      build: () => bloc,
      act: (bloc) => bloc.add(GetRandomQuote()),
      wait: const Duration(seconds: 2),

      ///! assert
      expect: () => [
        Loading(),
        const Error(message: ErrorMessages.TIMEOUT_MESSAGE),
      ],
    );
  });
}
