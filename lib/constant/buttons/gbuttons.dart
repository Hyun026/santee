import 'package:flutter/material.dart';
import 'package:sante_en_poche/constant/colors/colors.dart';

class ButtonItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isActive;
  final VoidCallback onPressed;

  ButtonItem({
    required this.icon,
    required this.text,
    this.isActive = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(icon, color: isActive ? Colors.blue : Colors.grey, size: 20),
              const SizedBox(width: 5),
              Text(
                text,
                style: TextStyle(
                  color: isActive ? MyColors.navy : Colors.grey,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          if (isActive)
            Container(
              margin: const EdgeInsets.only(top: 5),
              width: 65,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
            ),
        ],
      ),
    );
  }
}


class Gbuttons extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onButtonPressed;

  const Gbuttons({
    super.key,
    required this.selectedIndex,
    required this.onButtonPressed,
  });

  @override
  State<Gbuttons> createState() => _GbuttonsState();
}

class _GbuttonsState extends State<Gbuttons> {
  @override
  Widget build(BuildContext context) {
    return Container(

      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ButtonItem(
            icon: Icons.density_small,
            text: "Tout",
            isActive: widget.selectedIndex == 3,
            onPressed: () => widget.onButtonPressed(3),
          ),
          ButtonItem(
            icon: Icons.videocam,
            text: "En ligne",
            isActive: widget.selectedIndex == 0,
            onPressed: () => widget.onButtonPressed(0),
          ),
          ButtonItem(
            icon: Icons.place,
            text: "À Masahaty",
            isActive: widget.selectedIndex == 1,
            onPressed: () => widget.onButtonPressed(1),
          ),
          ButtonItem(
            icon: Icons.home,
            text: "À Domicile",
            isActive: widget.selectedIndex == 2,
            onPressed: () => widget.onButtonPressed(2),
          ),
        ],
      ),
    );
  }
}
