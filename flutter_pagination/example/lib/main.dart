import 'package:flutter/material.dart';
import 'package:pagination_plus/pagination_plus.dart';

/// Entry point of the Flutter app.
void main() {
  runApp(const Pagination());
}

/// Example Flutter app demonstrating the usage of [PaginationPlus] widget.
class Pagination extends StatefulWidget {
  const Pagination({super.key});

  @override
  State<Pagination> createState() => _PaginationState();
}

class _PaginationState extends State<Pagination> {
  /// Current active page index (zero-based).
  int currentPage = 0;

  /// Number of rows displayed per page.
  int rowsPerPage = 10;

  @override
  Widget build(BuildContext context) {
    // Total number of items/records in the dataset.
    int totalRecords = 95;

    // Calculate total pages based on rows per page.
    int totalPages = (totalRecords / rowsPerPage).ceil();

    // Calculate start and end indices for the current page.
    int startIndex = (currentPage * rowsPerPage) + 1;
    int endIndex = ((currentPage + 1) * rowsPerPage);
    if (endIndex > totalRecords) endIndex = totalRecords;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter Pagination Example')),
        body: Column(
          children: [
            // Display current page items in a ListView.
            Expanded(
              child: ListView.builder(
                itemCount: endIndex - startIndex + 1,
                itemBuilder: (_, i) {
                  return ListTile(
                    title: Text('Item ${startIndex + i}'),
                  );
                },
              ),
            ),

            // PaginationPlus widget for navigating pages.
            PaginationPlus(
              currentPageIndex: currentPage,
              totalPages: totalPages,
              totalCount: totalRecords,
              rowsPerPage: rowsPerPage,
              startIndex: startIndex,
              endIndex: endIndex,
              availableRowsPerPage: const [5, 10, 20, 50],
              isTablet: false,
              isMobile: false,
              onPageChanged: (page) => setState(() => currentPage = page),
              onRowsPerPageChanged: (rows) =>
                  setState(() => rowsPerPage = rows),
            ),
          ],
        ),
      ),
    );
  }
}
