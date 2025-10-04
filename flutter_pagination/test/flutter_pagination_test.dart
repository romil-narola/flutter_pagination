import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pagination_plus/pagination_plus.dart';

void main() {
  /// Tests that the PaginationPlus widget renders correctly with basic elements.
  testWidgets('PaginationPlus renders buttons and labels',
      (WidgetTester tester) async {
    // Build the PaginationPlus widget inside a MaterialApp.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: PaginationPlus(
          currentPageIndex: 0,
          totalPages: 5,
          totalCount: 50,
          rowsPerPage: 10,
          startIndex: 1,
          endIndex: 10,
          availableRowsPerPage: const [5, 10, 20],
          isTablet: false,
          isMobile: false,
          onPageChanged: (_) {},
          onRowsPerPageChanged: (_) {},
        ),
      ),
    ));

    // Verify that pagination icons and page buttons exist.
    expect(find.byIcon(Icons.first_page), findsOneWidget);
    expect(find.byIcon(Icons.chevron_left), findsOneWidget);
    expect(find.byIcon(Icons.chevron_right), findsOneWidget);
    expect(find.byIcon(Icons.last_page), findsOneWidget);

    // Verify that the first page button is rendered.
    expect(find.text('1'), findsOneWidget);

    // Verify that the "Rows per page:" label is rendered.
    expect(find.text('Rows per page:'), findsOneWidget);

    // Verify that all available rows-per-page options exist in the dropdown.
    await tester.tap(find.byType(DropdownButton<int>));
    await tester.pumpAndSettle();
    expect(find.text('5'), findsOneWidget);
    expect(find.text('10'), findsOneWidget);
    expect(find.text('20'), findsOneWidget);
  });
}
