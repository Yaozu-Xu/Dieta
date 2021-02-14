import 'package:flutter/material.dart';

class Toast {
  static void _buildOverLay(BuildContext context, String message, Color color) {
    final OverlayEntry overlayEntry =
        OverlayEntry(builder: (BuildContext context) {
      return Positioned(
          top: MediaQuery.of(context).size.height * 0.8,
          child: Material(
            child: Container(
                color: Colors.transparent,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 200),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
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
    Future<dynamic>.delayed(const Duration(seconds: 2)).then((dynamic value) {
      overlayEntry.remove();
    });
  }

  static void showFailedMsg(
      {@required BuildContext context, @required String message}) {
    _buildOverLay(
      context,
      message,
      Colors.red[300],
    );
  }

  static void showSuccessMsg(
      {@required BuildContext context, @required String message}) {
    _buildOverLay(
      context,
      message,
      Colors.green[300],
    );
  }
}
