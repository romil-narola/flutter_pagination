import 'package:flutter/material.dart';

class CustomPagination extends StatelessWidget {
  final int currentPageIndex;
  final int totalPages;
  final int totalCount;
  final int rowsPerPage;
  final int startIndex;
  final int endIndex;
  final bool isTablet;
  final bool isMobile;
  final List<int> availableRowsPerPage;
  final ValueChanged<int> onPageChanged;
  final ValueChanged<int> onRowsPerPageChanged;

  const CustomPagination({
    super.key,
    required this.currentPageIndex,
    required this.totalPages,
    required this.totalCount,
    required this.rowsPerPage,
    required this.startIndex,
    required this.endIndex,
    required this.availableRowsPerPage,
    required this.isTablet,
    required this.isMobile,
    required this.onPageChanged,
    required this.onRowsPerPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final Color paginationColor = Colors.grey.shade200;
    final Color secondaryColor = Colors.blue;
    final Color tableDividerColor = Colors.grey.shade300;
    final Color greyColor = Colors.grey;
    final TextStyle smallGreyText =
        Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey);

    int buttonCount = totalPages > 7 ? 7 : totalPages;
    int start = currentPageIndex - 3;
    if (start < 0) start = 0;
    if (start + buttonCount > totalPages) start = totalPages - buttonCount;
    if (start < 0) start = 0;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: paginationColor,
        border: Border.all(color: tableDividerColor),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3),
        child: Row(
          mainAxisAlignment: !isTablet && !isMobile
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.center,
          children: [
            Flexible(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.first_page, size: 20),
                      onPressed:
                          currentPageIndex > 0 ? () => onPageChanged(0) : null,
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_left, size: 20),
                      onPressed: currentPageIndex > 0
                          ? () => onPageChanged(currentPageIndex - 1)
                          : null,
                    ),
                    ...List.generate(buttonCount, (i) {
                      int index = start + i;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: index == currentPageIndex
                                ? secondaryColor
                                : paginationColor,
                            foregroundColor: index == currentPageIndex
                                ? Colors.white
                                : Colors.black,
                            minimumSize: const Size(36, 36),
                            padding: EdgeInsets.zero,
                          ),
                          onPressed: () => onPageChanged(index),
                          child: Text('${index + 1}'),
                        ),
                      );
                    }),
                    IconButton(
                      icon: const Icon(Icons.chevron_right, size: 20),
                      onPressed: currentPageIndex < totalPages - 1
                          ? () => onPageChanged(currentPageIndex + 1)
                          : null,
                    ),
                    IconButton(
                      icon: const Icon(Icons.last_page, size: 20),
                      onPressed: currentPageIndex < totalPages - 1
                          ? () => onPageChanged(totalPages - 1)
                          : null,
                    ),
                    const SizedBox(width: 30),
                    if (!isTablet && !isMobile)
                      Text(
                        'Showing $startIndex to $endIndex of $totalCount records',
                        style: smallGreyText,
                      ),
                  ],
                ),
              ),
            ),
            if (!isTablet && !isMobile)
              Row(
                children: [
                  Text('Rows per page:', style: smallGreyText),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: greyColor),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: DropdownButton<int>(
                      padding: const EdgeInsets.all(2),
                      value: rowsPerPage,
                      isDense: true,
                      style: smallGreyText,
                      underline: const SizedBox(),
                      items: availableRowsPerPage.map((count) {
                        return DropdownMenuItem<int>(
                          value: count,
                          child: Text('$count'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          onRowsPerPageChanged(value);
                        }
                      },
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
