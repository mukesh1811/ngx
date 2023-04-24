import 'package:flutter/material.dart';

import '../palatte.dart';

// class InputField extends StatefulWidget {
//   const InputField({
//     Key? key,
//     required this.hint,
//     required this.inputAction,
//   }) : super(key: key);
//   final String hint;
//   final TextInputAction inputAction;
//
//   @override
//   State<InputField> createState() => _InputFieldState();
// }
//
// class _InputFieldState extends State<InputField> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(4),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.pinkAccent[600]!.withOpacity(0.5),
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: TextField(
//           decoration: InputDecoration(
//             contentPadding: const EdgeInsets.symmetric(vertical: 20),
//             border: InputBorder.none,
//             hintText: hint,
//           ),
//           obscureText: false,
//           style: kBodyText,
//           textInputAction: inputAction,
//         ),
//       ),
//     );
//   }
// }

class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    required this.hint,
    required this.inputAction,
  }) : super(key: key);

  final String hint;
  final TextInputAction inputAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.pinkAccent[600]!.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: TextField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 20),
            border: InputBorder.none,
            hintText: hint,
          ),
          obscureText: false,
          style: kBodyText,
          textInputAction: inputAction,
        ),
      ),
    );
  }
}
