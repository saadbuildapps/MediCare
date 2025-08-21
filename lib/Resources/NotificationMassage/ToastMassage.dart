// // import 'package:fluttertoast/fluttertoast.dart';
// // import '../Paths/imports.dart';

// // class Toastmassage {
// //   // ✅ Success Toast
// //   static SuccessToast(msg) {
// //     Fluttertoast.showToast(
// //       msg: "✅  $msg", // icon + message
// //       toastLength: Toast.LENGTH_LONG,
// //       gravity: ToastGravity.TOP,
// //       timeInSecForIosWeb: 3,
// //       backgroundColor: MyColor.green,
// //       textColor: Colors.white,
// //       fontSize: 16.5,
// //       webPosition: "center",
// //     );
// //   }
// //   //   static SuccessToast(msg) {
// // //     Fluttertoast.showToast(
// // //         msg: msg,
// // //         toastLength: Toast.LENGTH_LONG,
// // //         gravity: ToastGravity.TOP,
// // //         timeInSecForIosWeb: 3,
// // //         backgroundColor: MyColor.green,
// // //         textColor: Colors.white,
// // //         fontSize: 16.0,
// // //         webPosition: "center");
// // //   }

// //   // ✅ Error Toast
// //   static ErrorToast(error) {
// //     Fluttertoast.showToast(
// //       msg: "❌  $error",
// //       toastLength: Toast.LENGTH_LONG,
// //       gravity: ToastGravity.TOP,
// //       timeInSecForIosWeb: 3,
// //       backgroundColor: MyColor.red,
// //       textColor: Colors.white,
// //       fontSize: 16.5,
// //       webPosition: "center",
// //     );
// //   }

// // //   // ✅ General / Info Toast
// // static GeneralToast(msg) {
// //   Fluttertoast.showToast(
// //     msg: "ℹ️  $msg",
// //     toastLength: Toast.LENGTH_LONG,
// //     gravity: ToastGravity.TOP,
// //     timeInSecForIosWeb: 3,
// //     backgroundColor: MyColor.purple,
// //     textColor: Colors.white,
// //     fontSize: 16.5,
// //     webPosition: "center",
// //   );
// // }
// // }

// // import 'package:fluttertoast/fluttertoast.dart';
// // import '../Paths/imports.dart';

// // class Toastmassage {
// //   static SuccessToast(msg) {
// //     Fluttertoast.showToast(
// //         msg: msg,
// //         toastLength: Toast.LENGTH_LONG,
// //         gravity: ToastGravity.TOP,
// //         timeInSecForIosWeb: 3,
// //         backgroundColor: MyColor.green,
// //         textColor: Colors.white,
// //         fontSize: 16.0,
// //         webPosition: "center");
// //   }

// //   static ErrorToast(error) {
// //     Fluttertoast.showToast(
// //         msg: error,
// //         toastLength: Toast.LENGTH_LONG,
// //         gravity: ToastGravity.TOP,
// //         timeInSecForIosWeb: 3,
// //         backgroundColor: MyColor.red,
// //         textColor: Colors.white,
// //         fontSize: 16.0,
// //         webPosition: "center");
// //   }

// //   static GeneralToast(msg) {
// //     Fluttertoast.showToast(
// //         msg: msg,
// //         toastLength: Toast.LENGTH_LONG,
// //         gravity: ToastGravity.TOP,
// //         timeInSecForIosWeb: 3,
// //         backgroundColor: MyColor.purple,
// //         textColor: Colors.white,
// //         fontSize: 16.0,
// //         webPosition: "center");
// //   }
// // }

// // import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import '../Paths/imports.dart'; // make sure MyColor is properly defined here

// class Toastmassage {
//   // Success Toast
//   static SuccessToast(String msg) {
//     Fluttertoast.showToast(
//       msg: "✔️ $msg", // added check mark emoji
//       toastLength: Toast.LENGTH_LONG,
//       gravity: ToastGravity.TOP,
//       timeInSecForIosWeb: 3,
//       backgroundColor: Colors.black,
//       textColor: Colors.white,
//       fontSize: 16.0,
//       webPosition: "center",
//     );
//   }

//   // Error Toast
//   static ErrorToast(Object? error) {
//     Fluttertoast.showToast(
//       msg: "❌ ${error.toString()}", // added cross mark emoji
//       toastLength: Toast.LENGTH_LONG,
//       gravity: ToastGravity.TOP,
//       timeInSecForIosWeb: 3,
//       backgroundColor: MyColor.red,
//       textColor: Colors.white,
//       fontSize: 16.0,
//       webPosition: "center",
//     );
//   }

//   // General Info Toast
//   static GeneralToast(String msg) {
//     Fluttertoast.showToast(
//       msg: "ℹ️ $msg", // info emoji
//       toastLength: Toast.LENGTH_LONG,
//       gravity: ToastGravity.TOP,
//       timeInSecForIosWeb: 3,
//       backgroundColor: MyColor.purple,
//       textColor: Colors.white,
//       fontSize: 16.0,
//       webPosition: "center",
//     );
//   }

//   // Warning Toast
//   static WarningToast(String msg) {
//     Fluttertoast.showToast(
//       msg: "⚠️ $msg", // warning emoji
//       toastLength: Toast.LENGTH_LONG,
//       gravity: ToastGravity.TOP,
//       timeInSecForIosWeb: 3,
//       backgroundColor: Colors.orange,
//       textColor: Colors.white,
//       fontSize: 16.0,
//       webPosition: "center",
//     );
//   }
// }


import 'package:flutter/material.dart';

class Toastmassage {
  static void _showToast(BuildContext context, String message,
      {required Color backgroundColor, required IconData icon}) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 50,
        left: MediaQuery.of(context).size.width * 0.1,
        right: MediaQuery.of(context).size.width * 0.1,
        child: Material(
          color: Colors.transparent,
          elevation: 6, // ✅ shadow/elevation
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  spreadRadius: 2,
                  offset: Offset(2, 4),
                )
              ],
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.white), // ✅ real white icon
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    // auto-remove after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }

  // ✅ Success Toast
  static void SuccessToast(BuildContext context, String msg) {
    _showToast(
      context,
      msg,
      backgroundColor: Colors.black,
      icon: Icons.info, // white info icon
    );
  }

  // ✅ Error Toast
  static void ErrorToast(BuildContext context, Object? error) {
    _showToast(
      context,
      error.toString(),
      backgroundColor: Colors.red,
      icon: Icons.error,
    );
  }

  // ✅ General Toast
  static void GeneralToast(BuildContext context, String msg) {
    _showToast(
      context,
      msg,
      backgroundColor: Colors.teal,
      icon: Icons.info_outline,
    );
  }

  // ✅ Warning Toast
  static void WarningToast(BuildContext context, String msg) {
    _showToast(
      context,
      msg,
      backgroundColor: Colors.orange,
      icon: Icons.warning,
    );
  }
}
