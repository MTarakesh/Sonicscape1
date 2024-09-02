import 'package:flutter/material.dart';

class ForgetPasswordWidget extends StatelessWidget {
  const ForgetPasswordWidget({
    required this.btnIcon,
    required this.title,
    required this. subtitle,
    required this. onTap,

    Key?key,
  });
 final IconData btnIcon;
 final String title,subtitle;
 final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
    child:Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius:  BorderRadius.circular(10),
        color:Colors.grey,
        
      ),
      child: Row(
        children: [
          Icon(btnIcon,size:60),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,style: Theme.of(context).textTheme.titleLarge),
              Text(subtitle,style: Theme.of(context).textTheme.bodyMedium),
            ],
          )
        ],
      ),
    ),
    );
  }
}