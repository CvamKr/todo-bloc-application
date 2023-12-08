
import 'package:flutter/material.dart';

import '../blocs/todos_bloc/todos_event.dart';

class FilterButton extends StatelessWidget {
  final VisibilityFilter filter;
  final VoidCallback onPressed;
  final String text;
  final bool isSelected;

  const FilterButton({
    super.key,
    required this.filter,
    required this.onPressed,
    required this.text,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: isSelected
            ? MaterialStateProperty.all(Theme.of(context).primaryColorDark)
            : null,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.white : Theme.of(context).primaryColorDark,
        ),
      ),
    );
  }
}
