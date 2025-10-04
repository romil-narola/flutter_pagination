import 'package:flutter/material.dart';
import 'package:flutter_pagination/flutter_pagination.dart';

void main() {
  runApp(const Pagination());
}

class Pagination extends StatefulWidget {
  const Pagination({super.key});

  @override
  State<Pagination> createState() => _PaginationState();
}

class _PaginationState extends State<Pagination> {
  int currentPage = 0;
  int rowsPerPage = 10;

  @override
  Widget build(BuildContext context) {
    int totalRecords = 95;
    int totalPages = (totalRecords / rowsPerPage).ceil();
    int startIndex = (currentPage * rowsPerPage) + 1;
    int endIndex = ((currentPage + 1) * rowsPerPage);
    if (endIndex > totalRecords) endIndex = totalRecords;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter Pagination Example')),
        body: Column(
          children: [
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
            CustomPagination(
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
