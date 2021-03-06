import 'package:crc_version_1/app_localization.dart';
import 'package:crc_version_1/controller/login_controller.dart';
import 'package:crc_version_1/helper/global.dart';
import 'package:crc_version_1/helper/myTheme.dart';
import 'package:crc_version_1/view/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LogIn extends StatelessWidget {

  LoginController loginController = Get.put(LoginController());
  final formGlobalKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Obx((){
          return SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              //height: MediaQuery.of(context).size.height *0.92,
              child: loginController.loading.value ?
              Container(
                child: Lottie.asset('assets/images/Animation.json'),
              )
                  : Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _header(context),
                  AnimatedSwitcher(
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      return ScaleTransition(scale: animation, child: child);
                    },
                    duration: const Duration(milliseconds: 250),
                    child: !loginController.sign_up_option.value ? _inputInfo(context) :  _signUpOptions(context),
                  ),
                  const SizedBox(height: 10,),
                  _visiAsGuest(context),
                  _signUpButton(context),
                ],
              )
            ),
          );
        }),
      ),
    );
  }
  _visiAsGuest(BuildContext context){
    return GestureDetector(
      onTap: (){
        Get.offAll(()=>Home());
      },
      child: Container(
          padding: const EdgeInsets.only(bottom:10,top: 15),
          child: AnimatedSwitcher(
            duration: const  Duration(milliseconds: 500),
            child:
            Text(App_Localization.of(context).translate('visit_as_guest'),style: Theme.of(context).textTheme.bodyText2,)
          )
      ),
    );
  }

  _header(context){
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /**Logo*/
            Global.lang_code == 'en'
                ? MyTheme.isDarkTheme.value
                ? Container(
             // width: MediaQuery.of(context).size.width * 0.4,
              height: 100,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/logo_dark.png')
                  )
              ),
            )
                : Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/logo_light.png')
                  )
              ),
            )
                : Image.asset('assets/images/lines.png'),
            /**Lines*/
            Global.lang_code == 'en'
                ? Image.asset('assets/images/lines.png')
            : Container(
              //width: MediaQuery.of(context).size.width * 0.4,
              height: 100,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/logo_light.png')
                  )
              ),
            )
          ],
        ),
      const SizedBox(height: 0),
      /**Car image*/
        Container(
          width: MediaQuery.of(context).size.width*0.8,
          height: MediaQuery.of(context).size.height*0.3,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/car.png')
              )
          ),
        ),
      ],
    );
  }

  _inputInfo(context){
    return Form(
      key: formGlobalKey,
      child: Container(
        //height: MediaQuery.of(context).size.height * 0.34,
        child: Column(
          children: [
            Container(
             width: MediaQuery.of(context).size.width * 0.9,
              //height: 90,
              child: TextFormField(
                style: Theme.of(context).textTheme.headline3,
                controller: loginController.username,
                validator: (email) {
                  if (email!.isEmpty) {
                    return App_Localization.of(context).translate('username_cannot_be_empty');
                  }
                  return null;
                },
                decoration: InputDecoration(
                  errorStyle: const TextStyle(color: Colors.red,fontWeight: FontWeight.bold),
                  prefixIcon:
                  Icon(Icons.person, color: Theme.of(context).primaryColor),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(width: 1, color:Theme.of(context).dividerColor),
                  ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 1, color:Theme.of(context).dividerColor)
                  ),
                  labelStyle: Theme.of(context).textTheme.bodyText2,
                  labelText: App_Localization.of(context).translate('username'),
                  hintText: App_Localization.of(context).translate('enter_your_username'),
                  hintStyle: Theme.of(context).textTheme.headline4,
                ),
                keyboardType: TextInputType.text,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              //height: 90,
              child: TextFormField(
                  style: Theme.of(context).textTheme.headline3,
                  obscureText: !loginController.showPassword.value ? true : false,
                  obscuringCharacter: '*',
                  controller: loginController.password,
                  validator: (pass) {
                    if(pass!.isEmpty){
                      return App_Localization.of(context).translate('password_empty');
                    }
                    else if (pass.length < 6) {
                      return App_Localization.of(context).translate('password_length');
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),
                    prefixIcon:
                    Icon(Icons.vpn_key, color: Theme.of(context).primaryColor),
                    suffixIcon: !loginController.showPassword.value
                        ? GestureDetector(
                      onTap: (){
                        loginController.showPassword.value = !loginController.showPassword.value;
                      },
                        child: Icon(Icons.visibility_outlined, color: Theme.of(context).primaryColor))
                        : GestureDetector(
                      onTap: (){
                        loginController.showPassword.value = !loginController.showPassword.value;

                      },
                      child:  Icon(Icons.visibility_off_outlined, color: Theme.of(context).primaryColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Theme.of(context).dividerColor),
                    ),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Theme.of(context).dividerColor)),
                    labelStyle:Theme.of(context).textTheme.bodyText2,
                    labelText: App_Localization.of(context).translate('password'),
                    hintText: App_Localization.of(context).translate('enter_your_password'),
                    hintStyle: Theme.of(context).textTheme.headline4,
                  ),
                  keyboardType: TextInputType.visiblePassword),
            ),
            const SizedBox(height: 50),
            Container(
              height: 55,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(5)),
              child: TextButton(
                onPressed: () async {
                  if(formGlobalKey.currentState!.validate()){
                    loginController.submite(context);
                  }else{
                    print('false');
                  }
                },
                child:  Text(
                  App_Localization.of(context).translate('login'),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _signUpButton(context){
    return GestureDetector(
      onTap: (){
        loginController.sign_up_option.value = !loginController.sign_up_option.value;
      },
      child: Container(
        padding: const EdgeInsets.only(bottom: 20),
        child: AnimatedSwitcher(
          duration: const  Duration(milliseconds: 500),
          child: !loginController.sign_up_option.value ?
          Text(App_Localization.of(context).translate('contact_us_to_sign_up'),style: Theme.of(context).textTheme.bodyText2,)
              : Text(App_Localization.of(context).translate('return_to_login'),style: Theme.of(context).textTheme.bodyText2),
        )
      ),
    );
  }

  _signUpOptions(context){
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      child: Column(
        children: [
          Bounce(
            duration: (const Duration(milliseconds: 90)),
            onPressed: (){
              loginController.whatsAppButton(context);
            },
            child: Container(
              height: 55,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.whatsapp,color: Colors.white,),
                  SizedBox(width: 10),
                  Text(
                    App_Localization.of(context).translate('call_us_whatsapp'),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20,),
          Bounce(
            duration: const Duration(milliseconds: 90),
            onPressed: (){
              loginController.phoneButton();
            },
            child: Container(
              height: 55,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.call,color: Colors.white,),
                  const SizedBox(width: 10),
                  Text(
                    App_Localization.of(context).translate('call_us'),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}