import 'package:flutter/material.dart';

/// A customizable pagination widget for Flutter that displays page
/// buttons, navigation controls, and optional "rows per page" dropdown.
///
/// Supports responsive layouts for mobile, tablet, and desktop.
class PaginationPlus extends StatelessWidget {
  /// The current active page index (zero-based).dart pub upgrade --major-versions flutter_lints
  final int currentPageIndex;

  /// Total number of pages available.
  final int totalPages;

  /// Total number of records/items in the dataset.
  final int totalCount;

  /// Number of rows displayed per page.
  final int rowsPerPage;

  /// Index of the first item displayed on the current page (1-based).
  final int startIndex;

  /// Index of the last item displayed on the current page (1-based).
  final int endIndex;

  /// Flag to indicate if the layout is tablet-sized.
  final bool isTablet;

  /// Flag to indicate if the layout is mobile-sized.
  final bool isMobile;

  /// List of available rows-per-page options for the dropdown.
  final List<int> availableRowsPerPage;

  /// Callback triggered when the page is changed.
  final ValueChanged<int> onPageChanged;

  /// Callback triggered when the rows-per-page selection changes.
  final ValueChanged<int> onRowsPerPageChanged;

  /// Creates a [PaginationPlus] widget.
  ///
  /// All parameters are required to properly render the pagination controls.
  const PaginationPlus({
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
    const Color paginationColor = Color(0xFFF0F0F0);
    const Color secondaryColor = Color(0xFF704264);
    const Color tableDividerColor = Color(0xFFE0E0E0);
    const Color greyColor = Color(0xFFBABEC2);

    final TextStyle smallGreyText = TextStyle(
      fontSize: 14,
      color: Color(0xFF646464),
    );

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
