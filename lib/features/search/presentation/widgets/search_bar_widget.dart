import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/debouncer.dart';

class SearchBarWidget extends StatefulWidget {
  final ValueChanged<String> onQueryChanged;
  final VoidCallback onClear;
  final String hintText;

  const SearchBarWidget({
    super.key,
    required this.onQueryChanged,
    required this.onClear,
    this.hintText = 'Search for a show, movie, genre, etc.',
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  late final TextEditingController _controller;
  late final Debouncer _debouncer;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _debouncer = Debouncer(milliseconds: AppConstants.searchDebounceMs);
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    final text = _controller.text;
    setState(() {
      _hasText = text.isNotEmpty;
    });

    _debouncer.run(() {
      widget.onQueryChanged(text);
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  void _clear() {
    _controller.clear();
    widget.onClear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
        color: Color(0xFF424242),
      ),
      child: TextField(
        controller: _controller,
        style: AppTypography.bodyLarge.copyWith(
          color: Colors.white,
          fontSize: 15,
        ),
        textInputAction: TextInputAction.search,
        cursorColor: AppColors.primary,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: AppTypography.bodyMedium.copyWith(
            color: const Color(0xFFC4C4C4),
            fontSize: 15,
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: Color(0xFFC4C4C4),
            size: 22,
          ),
          suffixIcon: _hasText
              ? IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Color(0xFFC4C4C4),
                    size: 22,
                  ),
                  onPressed: _clear,
                )
              : IconButton(
                  icon: const Icon(
                    Icons.mic,
                    color: Color(0xFFC4C4C4),
                    size: 22,
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Voice search activated (Mock)'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          filled: false,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
    );
  }
}
