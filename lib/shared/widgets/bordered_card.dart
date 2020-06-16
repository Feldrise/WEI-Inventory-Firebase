import 'package:flutter/material.dart';
import 'package:wei_inventory_firebase/utils/colors_utils.dart';

enum CardBorderSide { top, left }

class BorderedCard extends StatelessWidget {
  final Widget child;
  final CardBorderSide borderSide;

  final Color color;

  const BorderedCard({Key key, this.borderSide = CardBorderSide.top, this.color, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(
          left: BorderSide(
            color: borderSide == CardBorderSide.left ? color ?? randomMaterialColor() : Theme.of(context).cardColor,
            width: borderSide == CardBorderSide.left ? 5 : 0,
          ),
          top: BorderSide(
            color: borderSide == CardBorderSide.top ? color ?? randomMaterialColor() : Theme.of(context).cardColor,
            width: borderSide == CardBorderSide.top ? 5 : 0,
          ),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 20.0, // has the effect of softening the shadow
            spreadRadius: 3.0, // has the effect of extending the shadow
            offset: Offset(
              0.0, // horizontal
              5.0, // vertical
            ),
          )
        ],
      ),
      child: child,
    );
  }

}