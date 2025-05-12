import 'package:flutter/material.dart';
import '../constants/theme.dart';

class FloatingSearchBar extends StatefulWidget {
  const FloatingSearchBar({super.key});

  @override
  State<FloatingSearchBar> createState() => _FloatingSearchBarState();
}

class _FloatingSearchBarState extends State<FloatingSearchBar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isExpanded = false;
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _textController.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
        _focusNode.requestFocus();
      } else {
        _controller.reverse();
        _focusNode.unfocus();
        _textController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 16,
      right: 16,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: _isExpanded ? MediaQuery.of(context).size.width - 32 : 56,
        height: 56,
        decoration: BoxDecoration(
          color: _isExpanded ? AppTheme.surfaceDark : AppTheme.goldenYellow,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(28),
            onTap: _isExpanded ? null : _toggleSearch,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _isExpanded
                  ? Row(
                      children: [
                        const SizedBox(width: 16),
                        Icon(
                          Icons.search,
                          color: AppTheme.goldenYellow,
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: _textController,
                            focusNode: _focusNode,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Search for food, restaurants...',
                              hintStyle: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 16,
                              ),
                              border: InputBorder.none,
                              isDense: true,
                            ),
                            onSubmitted: (value) {
                              // TODO: Implement search
                              _toggleSearch();
                            },
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: _toggleSearch,
                        ),
                      ],
                    )
                  : const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 28,
                    ),
            ),
          ),
        ),
      ),
    );
  }
} 