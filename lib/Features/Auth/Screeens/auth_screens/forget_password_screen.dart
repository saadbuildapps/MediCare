

// import 'package:laza/Resources/Paths/imports.dart';

// import 'package:provider/provider.dart';
// import '../../../Providers/bottom_buttom_provider.dart';
// import '../../../Resources/MediaQuery/media_query.dart';
// import '../../../Resources/Paths/AssetsPath.dart';


// class ForgetPasswordScreen extends StatefulWidget {
//   const ForgetPasswordScreen({super.key});

//   @override
//   State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
// }

// class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
//   TextEditingController emailController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     final w = getScreenSize(context).width * (1 / 375);
//     final h = getScreenSize(context).height * (1 / 812);

//     return SafeArea(
//       child:  Scaffold(
//         body:  SingleChildScrollView(
//           physics: MediaQuery.of(context).viewInsets.bottom > 0 ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics()
//         ,
//           child: Column(
//             children: [
//               Padding(
//                 padding:  EdgeInsets.only(top: 45*h, left: 20, right: 20),
//                 child: Column(
//                   children: [
//                    const TopHeader(lable: 'Forgot Password'),
//                     SizedBox(height: 68*h,),
//                     SizedBox(
//                       height: 166,
//                         width: 255,
//                         child: Image.asset(PngImages.forget,fit: BoxFit.fill, ),),
//                     SizedBox(height: 80*h,),
//                     MyTextField(
//                       title: 'Email Address',
//                       controller: emailController,
//                       hintText: 'Enter Email',
//                       onchange: () {},
//                     ),
//                     SizedBox(height: 165*h,),
//                   const  Text('Please write your email to receive a\n confirmation code to set a new password. ',
//                       textAlign: TextAlign.center,
//                       style:  TextStyle(
//                         fontFamily: 'Inter',
//                         fontSize: 13,
//                         fontWeight: FontWeight.w400,
//                         color: MyColor.textLight,
//                       ),),
//                   ],
//                 ),
//               ),SizedBox(height: 25*h,),

//             ],
//           ),
//         ),
//         bottomNavigationBar:  BottomButtons(lable: 'Confirm Mail', ontap: (){
//           Provider.of<BottomButtomProvider>(context, listen:  false).startloading();
//         //  forgetPasswordAuth(emailController.text.toString(),context);
//         }),
//       ),
//     );
//   }
// }



import 'package:laza/Resources/NotificationMassage/ToastMassage.dart';
import 'package:laza/Resources/Paths/imports.dart';
import 'package:provider/provider.dart';
import '../../../../Providers/bottom_buttom_provider.dart';
import '../../../../Resources/MediaQuery/media_query.dart';
import '../../../../Resources/Paths/AssetsPath.dart';
import '../../forget_password_auth.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final w = getScreenSize(context).width * (1 / 375);
    final h = getScreenSize(context).height * (1 / 812);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: MediaQuery.of(context).viewInsets.bottom > 0
              ? const BouncingScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 45 * h, left: 20, right: 20),
                child: Column(
                  children: [
                    const TopHeader(lable: 'Forgot Password'),
                    SizedBox(height: 68 * h),
                    SizedBox(
                      height: 166,
                      width: 255,
                      child: Image.asset(
                        PngImages.forget,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(height: 80 * h),
                    MyTextField(
                      title: 'Email Address',
                      controller: emailController,
                      hintText: 'Enter Email',
                      onchange: () {},
                    ),
                    SizedBox(height: 165 * h),
                    const Text(
                      'Please write your email to receive a\n confirmation code to set a new password.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: MyColor.textLight,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25 * h),
            ],
          ),
        ),
        bottomNavigationBar: BottomButtons(
          lable: 'Confirm Mail',
          ontap: () {
            if (emailController.text.trim().isEmpty) {
              Toastmassage.ErrorToast(context,"Please enter your email");
              return;
            }
            Provider.of<BottomButtomProvider>(context, listen: false)
                .startloading();
            forgetPasswordAuth(emailController.text.trim(), context);
          },
        ),
      ),
    );
  }
}
