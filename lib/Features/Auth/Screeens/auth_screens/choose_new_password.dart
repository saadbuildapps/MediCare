import 'package:laza/Resources/Navigators/navigators.dart';
import 'package:laza/Resources/Paths/imports.dart';
import 'package:laza/Features/Home/screen/home_screen.dart';
import '../../../../Resources/MediaQuery/media_query.dart';

class ChoosePasswordScreen extends StatefulWidget {
  const ChoosePasswordScreen({super.key});

  @override
  State<ChoosePasswordScreen> createState() => _ChoosePasswordScreenState();
}

class _ChoosePasswordScreenState extends State<ChoosePasswordScreen> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final w = getScreenSize(context).width * (1 / 375);
    final h = getScreenSize(context).height * (1 / 812);

    return SafeArea(
      child:  Scaffold(
        body:  SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:  EdgeInsets.only(top: 45*h, left: 20, right: 20),
                child: Column(
                  children: [
                    const TopHeader(lable: 'New Password'),
                    SizedBox(height: 186*h,),

                    MyTextField(
                      title: 'Password',
                      controller: emailController,
                      hintText: 'Enter Password',
                      onchange: () {},
                    ),
                    SizedBox(height: 20*h,),
                    MyTextField(
                      title: 'Confirm Password',
                      controller: emailController,
                      hintText: 'Enter Password',
                      onchange: () {},
                    ),
                    SizedBox(height: 230*h,),
                    const  Text('Please write your new password ',
                      textAlign: TextAlign.center,
                      style:  TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: MyColor.textLight,
                      ),),
                  ],
                ),
              ),SizedBox(height: 25*h,),

            ],
          ),
        ),
        bottomNavigationBar:  BottomButtons(lable: 'Reset Password', ontap: (){
          NavigatorTo(context, const HomeScreen());
        }),
      ),
    );
  }
}
