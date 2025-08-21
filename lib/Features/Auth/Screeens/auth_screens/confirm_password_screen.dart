import 'dart:async';


import 'package:laza/Providers/timer_provider.dart';
import 'package:laza/Resources/Navigators/navigators.dart';
import 'package:laza/Resources/Paths/imports.dart';

import 'package:provider/provider.dart';
import '../../../../Resources/MediaQuery/media_query.dart';
import '../../../../Resources/Paths/AssetsPath.dart';


import 'choose_new_password.dart';


class ConfirmPasswordScreen extends StatefulWidget {
  const ConfirmPasswordScreen({super.key});

  @override
  State<ConfirmPasswordScreen> createState() => _ConfirmPasswordScreenState();
}

class _ConfirmPasswordScreenState extends State<ConfirmPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print('build');
    final w = getScreenSize(context).width * (1 / 375);
    final h = getScreenSize(context).height * (1 / 812);
    final timer = Provider.of<TimerProvider>(context , listen: false);

    return SafeArea(
      child:  Scaffold(
        body:  SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:  EdgeInsets.only(top: 45*h, left: 20, right: 20),
                child: Column(
                  children: [
                    const TopHeader(lable: 'Forgot Password'),
                    SizedBox(height: 68*h,),
                    SizedBox(
                      height: 166,
                      width: 255,
                      child: Image.asset(PngImages.forget,fit: BoxFit.fill, ),),
                    SizedBox(height: 80*h,),
                    SizedBox(
                      height: 99,
                      width: 335,
                      child :OtpTextField(
                        // margin: EdgeInsets.zero,
                        numberOfFields: 4,
                        fieldHeight: 98,
                        borderColor: MyColor.textLight,
                        showFieldAsBox: true,
                        onSubmit: (val){
                          NavigatorTo(context, const ChoosePasswordScreen());

                        },

                      )),
                    SizedBox(height: 165*h,),

                        Consumer<TimerProvider>(
                          builder: (context, value,child){
                          return   Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('00:${value.time.toString()}',
                                textAlign: TextAlign.center,
                                style:  const TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: MyColor.textBlack,
                                ),),
                              const Text(' resend confirmation code.',
                                  textAlign: TextAlign.center,
                                  style:  TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: MyColor.textLight,
                                  ),),
                            ],
                          );
                          },

                        ),
                      ],
                    ),),
              SizedBox(height: 25*h,),

                  ],
                ),
              ),
bottomNavigationBar: BottomButtons(lable: 'Confirm Mail', ontap: (){
  callDecrement();
}),
          ),
    );
  }
final int _time = 20;
  callDecrement(){
    Timer.periodic(const Duration(seconds: 1), (timer){
      final provider = Provider.of<TimerProvider>(context, listen: false);
      provider.decrement();


    });
  }
}
