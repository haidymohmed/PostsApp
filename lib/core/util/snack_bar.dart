import 'package:flutter/material.dart';
class SnackBarMessage {
  static success({context , message}){
    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              message,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),
            )
        )
    );
  }

  static fail({context, message}){
    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              message,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),
            )
        )
    );
  }
}
