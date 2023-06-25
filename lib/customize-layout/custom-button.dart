import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  CustomButton({
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: 8.0,
            bottom: 8.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: Colors.amber,
                child: Icon(
                  icon,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                text,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                ),
              )
            ],
          ),
        ));
  }
}
