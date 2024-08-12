import 'package:flutter/material.dart';

class SelectionItem {
  String text;
  IconData? leftIcon;
  IconData? rightIcon;
  bool isSelected;

  SelectionItem({
    required this.text,
    this.leftIcon,
    this.rightIcon,
    this.isSelected = false,
  });
}

/// A widget that allows grouped selection with single or multiple choices.
class GroupedSelection extends StatefulWidget {
  /// If true, allows multiple selection. Defaults to false.
  final bool multiple;

  /// Number of columns in the grid. Defaults to 1.
  final int columnCount;

  /// List of items to be displayed.
  final List<SelectionItem> items;

  /// Callback function that is called when the selection changes.
  final ValueChanged<List<SelectionItem>>? onSelectionChanged;

  const GroupedSelection({
    super.key,
    required this.items,
    this.multiple = false,
    this.columnCount = 1,
    this.onSelectionChanged,
  });

  @override
  State<StatefulWidget> createState() {
    return GroupedSelectionState();
  }
}

class GroupedSelectionState extends State<GroupedSelection> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    double aspectRatio = widget.columnCount == 1 ? 5.5 : 3.0;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.columnCount,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: aspectRatio,
      ),
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        final item = widget.items[index];
        return _buildSelectionItem(item, index);
      },
    );
  }

  Widget _buildSelectionItem(SelectionItem item, int index) {
    return InkWell(
      onTap: () {
        _handleSelection(item);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: item.isSelected ? const Color(0xFFE94057) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xc7c7c7ff),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            item.leftIcon != null
                ? Icon(
                    item.leftIcon,
                    color: _getIconColor(item.isSelected),
                  )
                : Container(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  item.text,
                  style: TextStyle(
                    color: _getTextColor(item.isSelected),
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            _setupRightIcon(item),
          ],
        ),
      ),
    );
  }

  void _handleSelection(SelectionItem selectedItem) {
    setState(() {
      if (widget.multiple) {
        selectedItem.isSelected = !selectedItem.isSelected;
      } else {
        for (var item in widget.items) {
          item.isSelected = item == selectedItem;
        }
      }
    });

    if (widget.onSelectionChanged != null) {
      widget.onSelectionChanged!(
          widget.items.where((item) => item.isSelected).toList());
    }
  }

  Color _getIconColor(bool isSelected) {
    return isSelected ? Colors.white : const Color(0xFFE94057);
  }

  Color _getTextColor(bool isSelected) {
    return isSelected ? const Color(0xFFFFFFFF) : const Color(0xFF000000);
  }

  _setupRightIcon(SelectionItem item) {
    if (item.enableRightIcon && item.rightIcon != null && item.isSelected) {
      return Icon(
        item.rightIcon,
        color: _getIconColor(item.isSelected),
      );
    }

    if (item.enableRightIcon && item.rightIcon == null && item.isSelected) {
      return Icon(
        Icons.check,
        color: _getIconColor(item.isSelected),
      );
    }

    return Container();
  }
}
