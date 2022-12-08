/* 
--Created by Edward Mansour-- Dec 5, 2022
*/
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import '../../../../mock/mock_reader.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:speeches/core/error/failures.dart';
import 'package:speeches/core/error/exceptions.dart';
import 'package:speeches/features/quotes/data/models/quotes_model.dart';
import 'package:speeches/features/quotes/data/repositories/quote_repository_impl.dart';
import 'package:speeches/features/quotes/data/dataSources/quotes_local_data_source.dart';
import 'package:speeches/features/quotes/data/dataSources/quotes_remote_data_source.dart';

import 'quote_repository_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<QuotesRemoteDataSource>(as: #MockRemoteDataSource),
  MockSpec<QuotesLocalDataSource>(as: #MockLocalDataSource)
])
void main() {
  late QuoteRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();

    repository = QuoteRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  group('getRandomQuote group', () {
    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        final quotesList = [quotesModel];

        when(mockRemoteDataSource.getRandomQuote())
            .thenAnswer((_) async => quotesList);

        final result = await repository.getRandomQuote();
        //!/ assert
        verify(mockRemoteDataSource.getRandomQuote());
        expect(result, equals(Right<Failure, List<QuotesModel>>(quotesList)));
      },
    );

    test(
      'should cache the data locally when the call to remote data source is successful',
      () async {
        when(mockRemoteDataSource.getRandomQuote())
            .thenAnswer((_) async => [quotesModel]);

        await repository.getRandomQuote();

        ///! assert
        verify(mockRemoteDataSource.getRandomQuote());
      },
    );

    test(
      'should return server failure when the call to remote data source is unsuccessful',
      () async {
        when(mockRemoteDataSource.getRandomQuote())
            .thenThrow(ServerException());

        ///! assert
        expect(
            await repository.getRandomQuote(), equals(Left(ServerFailure())));
      },
    );
  });
}
