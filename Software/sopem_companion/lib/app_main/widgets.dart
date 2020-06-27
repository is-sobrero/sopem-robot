// Copyright 2020 I.S. "A. Sobrero". All rights reserved.
// Use of this source code is governed by the GPL 3.0 license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SoPEMAppBar extends PreferredSize {
  final int status;
  final double height;

  SoPEMAppBar({
    Key key,
    @required this.status,
    this.height = kToolbarHeight
  }) : assert(status != null),
        super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).scaffoldBackgroundColor.computeLuminance() > 0.5)
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    else
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    Color backgroundState = Colors.green;
    if (status == -1) backgroundState = Colors.yellow;
    if (status == 1) backgroundState = Colors.red;
    Color foregroundState = backgroundState.computeLuminance() > 0.5 ?
    Colors.black : Colors.white;
    String textState = "Connesso";
    if (status == 1) textState = "Errore";
    if (status == -1) textState = "Connessione";
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(left: 15, right: 15),
        alignment: Alignment.center,
        height: preferredSize.height,
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "SoPEM",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "Companion",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: backgroundState,
                  boxShadow: [
                    BoxShadow(
                      color: backgroundState.withOpacity(0.2),
                      blurRadius: 20,
                      spreadRadius: 10
                    )
                  ]
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    textState,
                    style: TextStyle(
                      color: foregroundState,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}