import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  final String? label;
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool isPassword;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final bool enabled;
  final TextInputAction? textInputAction;
  final VoidCallback? onFieldSubmitted;

  const AppTextField({
    super.key,
    this.label,
    this.hintText,
    this.controller,
    this.validator,
    this.keyboardType,
    this.isPassword = false,
    this.initialValue,
    this.onChanged,
    this.enabled = true,
    this.textInputAction,
    this.onFieldSubmitted,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         // Label
//         if (widget.label != null) ...[
//           Text(
//             widget.label!,
//             style: theme.textTheme.labelLarge?.copyWith(
//               fontWeight: FontWeight.w500,
//               color: Colors.grey.shade700,
//             ),
//           ),
//           const SizedBox(height: 6),
//         ],

//         // TextFormField - Let it fully inherit from theme
//         TextFormField(
//           controller: widget.controller,
//           initialValue: widget.initialValue,
//           onChanged: widget.onChanged,
//           validator: widget.validator,
//           keyboardType: widget.keyboardType,
//           obscureText: _obscureText,
//           enabled: widget.enabled,
//           textInputAction: widget.textInputAction,
//           onFieldSubmitted: widget.onFieldSubmitted != null 
//               ? (_) => widget.onFieldSubmitted!() 
//               : null,
//           style: theme.textTheme.bodyLarge,
//           decoration: InputDecoration(
//             hintText: widget.hintText,
//             hintStyle: TextStyle(color: Colors.grey.shade500),
//             floatingLabelBehavior: FloatingLabelBehavior.auto,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
//             ),
//             suffixIcon: widget.isPassword
//                 ? IconButton(
//                     icon: Icon(
//                       _obscureText ? Icons.visibility_off : Icons.visibility,
//                       color: Colors.grey,
//                     ),
//                     onPressed: _togglePasswordVisibility,
//                     splashRadius: 20,
//                   )
//                 : null,
//             contentPadding: const EdgeInsets.symmetric(
//               horizontal: 16,
//               vertical: 18,
//             ),
//             filled: true,
//             fillColor: Colors.white,
//           ),
//         ),
//       ],
//     );
//   }
// }
@override
Widget build(BuildContext context) {
  final theme = Theme.of(context);

  // 1. REMOVE the Column and the 'if (widget.label != null) Text(...)'
  return TextFormField(
    controller: widget.controller,
    initialValue: widget.initialValue,
    onChanged: widget.onChanged,
    validator: widget.validator,
    keyboardType: widget.keyboardType,
    obscureText: _obscureText,
    enabled: widget.enabled,
    textInputAction: widget.textInputAction,
    onFieldSubmitted: widget.onFieldSubmitted != null 
        ? (_) => widget.onFieldSubmitted!() 
        : null,
    style: theme.textTheme.bodyLarge,
    decoration: InputDecoration(
      // 2. Add the labelText here - THIS makes it float
      labelText: widget.label,
      labelStyle: TextStyle(color: Colors.grey.shade600),
      // Styling when the field is active
      floatingLabelStyle: TextStyle(
        color: Colors.grey.shade800,
        fontWeight: FontWeight.bold,
      ),
      
      hintText: widget.hintText,
      hintStyle: TextStyle(color: Colors.grey.shade400),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      
      // 3. Update borders to be consistent
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        // Use primary color on focus to make it pop
        borderSide: BorderSide(color: Colors.black, width: 2),
      ),
      
      suffixIcon: widget.isPassword
          ? IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: _togglePasswordVisibility,
              splashRadius: 20,
            )
          : null,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 18,
      ),
      filled: true,
      fillColor: Colors.white,
    ),
  );
}
}