import 'package:flutter/cupertino.dart';

class MyPageView extends StatefulWidget {
  final int currentPage;
  final List<Widget> children;
  const MyPageView({@required this.currentPage, @required this.children})
      : assert(currentPage != null && currentPage >= 0),
        assert(children.length >= 0 && children != null);

  @override
  _MyPageViewState createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  List<int> _renderedPages = [0];

  @override
  void didUpdateWidget(MyPageView oldWidget) {
    
    super.didUpdateWidget(oldWidget);
    print('new page ${widget.currentPage}');
    if(!_renderedPages.contains(widget.currentPage)){
      setState(() {
        _renderedPages.add(widget.currentPage);
      }); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IndexedStack(
        children: List.generate(widget.children.length, (index){
          return _renderedPages.contains(index) ? widget.children[index] : Container();
        }),
        index: widget.currentPage,
      ),
    );
  }
}
