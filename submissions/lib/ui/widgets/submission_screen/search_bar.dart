import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({
    required this.onSearch,
    required this.onChanged,
    super.key,
  });

  final VoidCallback onSearch;
  final Function(String) onChanged;

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final _inputController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _inputController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        Flexible(
          child: TextFormField(
            controller: _inputController,
            maxLines: 1,
            style: textTheme.bodyMedium,
            focusNode: _focusNode,
            onChanged: widget.onChanged,
            decoration: InputDecoration(
              hintText: 'Search submissions',
              suffixIcon: _focusNode.hasFocus
                  ? IconButton(
                      onPressed: () {
                        _inputController.clear();
                        widget.onChanged('');
                        _focusNode.unfocus();
                      },
                      icon: Icon(
                        Icons.close_rounded,
                        color: colorScheme.onSurface.withValues(alpha: 0.75),
                      ),
                    )
                  : const SizedBox.shrink(),
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
                borderSide: BorderSide(
                  color: colorScheme.onSurface.withValues(alpha: 0.75),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
                borderSide: BorderSide(color: colorScheme.primary, width: 2.0),
              ),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            widget.onSearch();
          },
          style: ButtonStyle(
            padding: WidgetStateProperty.all<EdgeInsets>(
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
            ),
            shape: WidgetStateProperty.all(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
            ),
            backgroundColor: WidgetStateProperty.all<Color>(
              colorScheme.primary,
            ),
          ),
          child: Icon(
            Icons.search_rounded,
            color: colorScheme.onPrimary,
            size: textTheme.titleLarge!.fontSize,
          ),
        ),
      ],
    );
  }
}
