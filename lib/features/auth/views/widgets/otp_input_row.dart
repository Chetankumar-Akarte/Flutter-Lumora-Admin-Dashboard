import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_typography.dart';

class OtpInputRow extends StatefulWidget {
  final List<String> digits;
  final ValueChanged<int> onDigitChanged;
  final Function(int, String) onDigitUpdated;
  final ValueChanged<String> onPaste;
  final VoidCallback? onCompleted;

  const OtpInputRow({
    super.key,
    required this.digits,
    required this.onDigitChanged,
    required this.onDigitUpdated,
    required this.onPaste,
    this.onCompleted,
  });

  @override
  State<OtpInputRow> createState() => _OtpInputRowState();
}

class _OtpInputRowState extends State<OtpInputRow> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(6, (i) {
      final text = i < widget.digits.length ? widget.digits[i] : '';
      return TextEditingController(text: text);
    });
    _focusNodes = List.generate(6, (_) => FocusNode());
  }

  @override
  void didUpdateWidget(covariant OtpInputRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    for (int i = 0; i < 6; i++) {
      final newText = i < widget.digits.length ? widget.digits[i] : '';
      if (_controllers[i].text != newText) {
        _controllers[i].text = newText;
      }
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onChanged(int index, String value) {
    // Handle paste of multiple characters
    if (value.length > 1) {
      widget.onPaste(value);
      // Focus last filled or last node
      final fillCount = value.replaceAll(RegExp(r'\D'), '').length;
      final targetIndex = (fillCount - 1).clamp(0, 5);
      _focusNodes[targetIndex].requestFocus();
      if (fillCount >= 6) {
        widget.onCompleted?.call();
      }
      return;
    }

    widget.onDigitUpdated(index, value);

    if (value.isNotEmpty) {
      if (index < 5) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
        widget.onCompleted?.call();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(6, (index) {
        return SizedBox(
          width: 48,
          height: 56,
          child: KeyboardListener(
            focusNode: FocusNode(),
            onKeyEvent: (event) {
              if (event is KeyDownEvent &&
                  event.logicalKey == LogicalKeyboardKey.backspace &&
                  _controllers[index].text.isEmpty &&
                  index > 0) {
                _focusNodes[index - 1].requestFocus();
              }
            },
            child: TextFormField(
              controller: _controllers[index],
              focusNode: _focusNodes[index],
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.center,
              maxLength: 1,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: AppTypography.num(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.onSurface,
              ),
              decoration: InputDecoration(
                counterText: '',
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                filled: true,
                fillColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                border: OutlineInputBorder(
                  borderRadius: AppDimensions.rMd,
                  borderSide: BorderSide(
                    color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: AppDimensions.rMd,
                  borderSide: BorderSide(
                    color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: AppDimensions.rMd,
                  borderSide: const BorderSide(
                    color: AppColors.brand,
                    width: 2,
                  ),
                ),
              ),
              onChanged: (val) => _onChanged(index, val),
            ),
          ),
        );
      }),
    );
  }
}
