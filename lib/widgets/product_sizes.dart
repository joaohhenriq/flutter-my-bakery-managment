import 'package:flutter/material.dart';

class ProductSizes extends FormField<List> {
  ProductSizes({
    List initialValue,
    FormFieldSetter<List> onSaved,
    FormFieldValidator<List> validator,
  }) : super(
            initialValue: initialValue,
            onSaved: onSaved,
            validator: validator,
            builder: (state) {
              return SizedBox(
                height: 34,
                child: GridView(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  scrollDirection: Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.4),
                  children: state.value.map((s) {
                    return GestureDetector(
                      onLongPress: () {
                        state.didChange(state.value..remove(s));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[500],
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            border: Border.all(color: Colors.grey[700], width: 1)),
                        alignment: Alignment.center,
                        child: Text(
                          s,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  }).toList()
                    ..add(GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[500],
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            border: Border.all(color: Colors.grey[700], width: 1)),
                        alignment: Alignment.center,
                        child: Text(
                          "+",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )),
                ),
              );
            });
}
