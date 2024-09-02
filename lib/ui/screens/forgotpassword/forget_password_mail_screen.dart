import 'package:SonicScape/ui/resources/strings.dart';
import 'package:SonicScape/ui/reusablewidgets/form_header_widget.dart';

import 'package:flutter/material.dart';

class ForgetPasswordMailScreen extends StatelessWidget{
  const ForgetPasswordMailScreen({Key?key}): super(key:key);

  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(height:20),
               FormHeaderwidget(
                 image: forgetPasswordImage,
                 title: forgetpasswordtitle,
                 subtitle: forgetpasswordsubtitle, 
                 crossAxisAlignment: CrossAxisAlignment.center,
                 heightBetween: 30,
                 textAlign: TextAlign.center,
          
                ),
                SizedBox(height: 20),
                Form(
                  child: Column(
                    children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        label:Text(email),
                        hintText: email,
                        prefixIcon: Icon(Icons.mail_outline_rounded),
                      ),
                    ),
                    SizedBox(height:20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        
                        onPressed: (){},
                        style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                     backgroundColor: Colors.black,
                     ),
                         child: Text(next.toUpperCase(),
                         style: TextStyle(color: Color.fromARGB(255, 249, 249, 249)),
             
                         
                         )),
                    ),
                ]
                ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}