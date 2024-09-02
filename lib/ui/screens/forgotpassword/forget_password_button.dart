import 'package:SonicScape/ui/resources/strings.dart';
import 'package:SonicScape/ui/screens/forgotpassword/forget_password_mail_screen.dart';
import 'package:SonicScape/ui/screens/forgotpassword/forget_passwordmode_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ForgetPasswordScreen {
   static Future<dynamic> BuildShowModelBottomSheet(BuildContext context) {
    return showModalBottomSheet(context: context, 
            builder: (context)=>Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(forgetpasswordtitle,style: Theme.of(context).textTheme.bodyLarge),
                  Text(forgetpasswordsubtitle,style: Theme.of(context).textTheme.bodySmall),
                  const SizedBox(height: 20),
                  ForgetPasswordWidget(
                    onTap: (){
                      Navigator.pop(context);
                      Get.to(()=> ForgetPasswordMailScreen()); 
                      },
                    btnIcon: Icons.mail_outline_rounded,
                    title: email,
                    subtitle: resetviaemail,
                    
                  ),
                  SizedBox(height: 20),
                ]
                ),
            ),
            );
  }
}
