import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class FoodItemCard extends StatefulWidget {
  final Image image;
  final String foodItemName;
  final dynamic callback;

  const FoodItemCard(
      {Key? key, required this.image, required this.foodItemName, required this.callback})
      : super(key: key);

  @override
  State<FoodItemCard> createState() => _FoodItemCardState();
}

class _FoodItemCardState extends State<FoodItemCard> {
  bool selected = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget.image,
            Text(
              widget.foodItemName,
              style: TextStyle(fontSize: 20),
            ),
            Checkbox(
                value: selected,
                onChanged: (value) {
                  setState(() {
                    selected = !selected;
                  });
                  widget.callback(widget.foodItemName, selected);
                })
          ],
        ),
      ),
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        boxShadow: [
          new BoxShadow(
            color: Color.fromARGB(255, 238, 237, 237),
            blurRadius: 10.0,
          ),
        ],
      ),
    );
  }
}
