import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_pagination/flutter_pagination.dart';

void main() {
  testWidgets('Pagination buttons render correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: CustomPagination(
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
    ));

    expect(find.byIcon(Icons.first_page), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
    expect(find.text('Rows per page:'), findsOneWidget);
  });
}
