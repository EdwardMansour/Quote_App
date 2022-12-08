/* 
--Created by Edward Mansour-- Dec 5, 2022
*/
import 'dart:convert';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import '../../../../mock/mock_reader.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:speeches/core/error/exceptions.dart';
import 'package:speeches/features/quotes/data/models/quotes_model.dart';
import 'package:speeches/features/quotes/data/dataSources/quotes_remote_data_source.dart';

import 'quotes_remote_data_source_test.mocks.dart';

@GenerateNiceMocks([MockSpec<http.Client>(as: #MockHttpClient)])
void main() {
  late QuotesRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = QuotesRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(
      Uri.parse("https://zenquotes.io/api/random"),
    )).thenAnswer((_) async => http.Response(reader('quote.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(Uri.parse("https://zenquotes.io/api/random")))
        .thenAnswer((_) async => http.Response("Something went wrong", 404));
  }

  group('getRandomQuote on success story', () {
    final responseList = List<QuotesModel>.from(
        json.decode(reader('quote.json')).map((e) => QuotesModel.fromMap(e)));

    test(
      'should perform a GET request on a URL',
      () async {
        setUpMockHttpClientSuccess200();

        await dataSource.getRandomQuote();

        ///! assert
        verify(mockHttpClient.get(
          Uri.https("zenquotes.io", "/api/random"),
        ));
      },
    );

    test(
      'should return getRandomQuote when the response code is 200 (success)',
      () async {
        setUpMockHttpClientSuccess200();

        final result = await dataSource.getRandomQuote();

        ///! assert
        expect(result, equals(responseList));
      },
    );
  });
  group('getRandomQuote on failure story', () {
    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        setUpMockHttpClientFailure404();

        final call = dataSource.getRandomQuote;

        ///! assert
        expect(call(), throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });
}
