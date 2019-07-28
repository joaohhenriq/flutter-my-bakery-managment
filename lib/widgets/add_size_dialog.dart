import 'package:flutter/material.dart';

class AddSizeDialog extends StatelessWidget {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: _controller,
            ),
            Container(
              alignment: Alignment.centerRight,
              child: FlatButton(
                child: Text("Add"),
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pop(_controller.text);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
