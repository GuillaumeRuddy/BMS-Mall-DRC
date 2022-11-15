import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class TextFieldCustom {
  String? title;
  String? placeHolder;
  bool ispass;
  String? msg;
  String? _value;
  var keyboard;
  var icone;

  TextFieldCustom(
      {this.title,
      this.placeHolder,
      this.ispass = false,
      this.keyboard = TextInputType.text,
      this.icone = Icons.account_circle,
      this.msg = "Champ obligatoire"});

  TextEditingController control = new TextEditingController();

  TextFormField textFormField() {
    return TextFormField(
      onChanged: (e) {
        _value = e;
      },
      validator: (e) => e!.isEmpty ? this.msg : null,
      obscureText: ispass,
      controller: control,
      keyboardType: keyboard,
      decoration: InputDecoration(
          hintText: this.placeHolder,
          filled: true,
          fillColor: Colors.white,
          labelText: this.title,
          prefixIcon: Icon(
            icone,
            color: Colors.blue,
          ),
          labelStyle:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.5),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.5),
            borderRadius: BorderRadius.circular(10.0),
          )),
    );
  }

  String? get value {
    return _value;
  }
}
