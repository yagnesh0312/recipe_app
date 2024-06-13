import 'package:flutter/material.dart';

class AnimButton extends StatefulWidget {
  final String startMsg;
  final String endMsg;
  final IconData sIcon;
  final IconData eIcon;
  final Function? onPressed;
  const AnimButton(
      {super.key,
      required this.startMsg,
      required this.endMsg,
      required this.sIcon,
      required this.eIcon,
      this.onPressed,});

  @override
  State<AnimButton> createState() => _AnimButtonState();
}

class _AnimButtonState extends State<AnimButton> {
  List<Color> btncolor = [
    Color.fromARGB(255, 255, 255, 255),
    Color.fromARGB(255, 255, 255, 255)
  ];

  List<IconData> btnIcon = [Icons.shopping_cart_outlined, Icons.check];

  List<double> btnRadius = [10, 100];
  List<double> btnWidth = [50.0, 170.0].reversed.toList();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    btnIcon = [widget.sIcon, widget.eIcon];
    setState(() {});
  }
  validate(){
    pos = 1;
  }

  var pos = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onPressed == null) {
        } else {
          pos = 1;
          widget.onPressed!();
          print("hello");
          setState(() {});
        }
      },
      child: AnimatedContainer(
        curve: Curves.ease,
        height: 50,
        width: btnWidth[pos],
        padding: const EdgeInsets.all(10),
        duration: const Duration(milliseconds: 500),
        decoration: BoxDecoration(
            color: btncolor[pos],
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12, blurRadius: 10, offset: Offset(5, 5))
            ],
            borderRadius: BorderRadius.circular(btnRadius[pos])),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
      
            pos == 1
                ? Flexible(
                    child: Container(height: 20,width: 20,))
                : Flexible(
                    child: Text(
                    widget.startMsg,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black),
                  ))
          ],
        ),
      ),
    );
  }
}
