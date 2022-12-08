/* 
--Created by Edward Mansour-- Dec 5, 2022
*/
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:speeches/core/useCase/use_case.dart';
import 'package:speeches/features/quotes/domain/useCases/get_random_quote.dart';
import 'package:speeches/features/quotes/domain/repositories/quote_repository.dart';

import '../../../../mock/mock_reader.dart';
import 'get_random_quote_test.mocks.dart';

@GenerateNiceMocks([MockSpec<QuoteRepository>(as: #MockQuotesRepository)])
void main() {
  late GetRandomQuoteUsecase usecase;
  late MockQuotesRepository mockQuotesRepository;

  setUp(() {
    mockQuotesRepository = MockQuotesRepository();
    usecase = GetRandomQuoteUsecase(mockQuotesRepository);
  });

  test(
    'should get Random quote from the repository',
    () async {
      when(mockQuotesRepository.getRandomQuote())
          .thenAnswer((_) async => const Right([quotesModel]));

      final result = await usecase(NoParams());

      ///! assert
      expect(result, const Right([quotesModel]));
      verify(mockQuotesRepository.getRandomQuote());
      verifyNoMoreInteractions(mockQuotesRepository);
    },
  );
}
