/* 
--Created by Edward Mansour-- Dec 5, 2022
*/

import 'dart:convert';
import '../../../../mock/mock_reader.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:speeches/features/quotes/domain/entities/quote.dart';
import 'package:speeches/features/quotes/data/models/quotes_model.dart';

void main() {
  const quotesModel = QuotesModel(
    quote:
        "It is the mark of an educated mind to be able to entertain a thought without accepting it.",
    author: "Aristotle",
    html:
        "<blockquote>&ldquo;It is the mark of an educated mind to be able to entertain a thought without accepting it.&rdquo; &mdash; <footer>Aristotle</footer></blockquote>",
  );

  test(
    'should be a subclass of Quote entity',
    () async {
      ///! assert
      expect(quotesModel, isA<Quote>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model when the JSON is correct',
      () async {
        final decodedResponse = json.decode(reader('quote.json'));

        final responseList = List<QuotesModel>.from(
            decodedResponse.map((e) => QuotesModel.fromMap(e)));

        final result = responseList[0];

        ///! assert
        expect(result, quotesModel);
      },
    );

    test(
      'should return a valid model when the JSON quote field is number type',
      () async {
        final decodedResponse = json.decode(reader('quote_as_number.json'));

        final responseList = List<QuotesModel>.from(
            decodedResponse.map((e) => QuotesModel.fromMap(e)));

        final result = responseList[0];

        ///! assert
        expect(
            result,
            const QuotesModel(
              quote: "0",
              author: "Aristotle",
              html:
                  "<blockquote>&ldquo;It is the mark of an educated mind to be able to entertain a thought without accepting it.&rdquo; &mdash; <footer>Aristotle</footer></blockquote>",
            ));
      },
    );
  });

  group('toJson model', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        final result = quotesModel.toMap();

        final expectedMap = {
          "q":
              "It is the mark of an educated mind to be able to entertain a thought without accepting it.",
          "a": "Aristotle",
          "h":
              "<blockquote>&ldquo;It is the mark of an educated mind to be able to entertain a thought without accepting it.&rdquo; &mdash; <footer>Aristotle</footer></blockquote>",
        };

        ///! assert
        expect(result, expectedMap);
      },
    );
  });
}
