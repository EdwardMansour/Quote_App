/* 
--Created by Edward Mansour-- Dec 7, 2022
*/

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:speeches/main.dart';

void main() {
  testWidgets('Check home page widgets', (WidgetTester tester) async {
    //! Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    ///! find the button
    find.byType(TextButton);
    //! Verify that the page contain an app bar Quote text.
    expect(find.text('Quotes'), findsOneWidget);
    //! Verify that the quote app start with Quote unavailable text.
    expect(find.text('Quote unavailable!'), findsOneWidget);
    //! Verify that the quote app not including any of the below texts.
    expect(find.text('Empty'), findsNothing);
    expect(find.text('Get Your Quote'), findsOneWidget);
  });
}
