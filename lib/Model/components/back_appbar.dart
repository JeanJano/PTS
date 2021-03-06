import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pts/Constant.dart';

class BackAppBar extends PreferredSize {
  final Widget title;
  final List<Widget> actions;
  //final Brightness brightness;
  final Widget leading;

  BackAppBar({
    this.title,
    this.actions,
    //this.brightness,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      //centerTitle: true,
      leading: leading != null
          ? leading
          : CupertinoButton(
              child: Icon(
                Icons.arrow_back_sharp,
                color: ICONCOLOR,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
      title: title,
      actions: actions,
      brightness: Brightness.light,
      //brightness: brightness != null ? brightness : Brightness.light,
    );
  }
}
