import 'package:flutter/material.dart';

class Toast {
  static void _buildOverLay(BuildContext context, String message, Color color) {
    OverlayEntry overlayEntry = OverlayEntry(builder: (context) {
      //外层使用Positioned进行定位，控制在Overlay中的位置
      return Positioned(
          top: MediaQuery.of(context).size.height * 0.8,
          child: Material(
            child: Container(
                color: Colors.transparent,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Container(
                  constraints: BoxConstraints(maxWidth: 200),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Text(
                    message,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: color),
                  ),
                )),
          ));
    });
    Overlay.of(context).insert(overlayEntry);
    Future.delayed(Duration(seconds: 3)).then((value) {
      overlayEntry.remove();
    });
  }

  static void showFailedMsg({BuildContext context, String message}) {
    _buildOverLay(
      context,
      message,
      Colors.red[300],
    );
  }

  static void showSuccessMsg({BuildContext context, String message}) {
    _buildOverLay(
      context,
      message,
      Colors.green[300],
    );
  }
}
