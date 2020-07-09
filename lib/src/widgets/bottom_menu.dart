import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class BottomMenu extends StatelessWidget {
  final List<BottomMenuItem> items;
  final int currentPage;
  final void Function(int) onChange;

  BottomMenu({this.items, this.currentPage, this.onChange})
      : assert(items != null && items.length > 0),
        assert(currentPage >= 0 && currentPage != null);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: SafeArea(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(items.length, (index) {
                final bool isActive = index == currentPage;
                final BottomMenuItem item = items[index];
                return Expanded(
                  child: Container(
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            child: Icon(item.icon,
                                color: isActive ? Colors.black : Colors.grey),
                          ),
                          SizedBox(height: 2),
                          Text(
                            item.label,
                            style: TextStyle(
                                fontSize: 12,
                                color: isActive ? Colors.black : Colors.grey),
                          )
                        ],
                      ),
                      onPressed: () => onChange(index),
                    ),
                  ),
                );
              })),
        ));
  }
}

class BottomMenuItem {
  final IconData icon;
  final String label;
  final Widget content;
  BottomMenuItem({ @required this.icon,@required this.label,@required this.content});
}
