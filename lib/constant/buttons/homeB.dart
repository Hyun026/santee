import 'package:flutter/material.dart';

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
              Icon(icon, color: Colors.white,size: 10,),
              const SizedBox(width: 5),
              Text(
                text,
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
            ],
          ),
          if (isActive)
            Container(
              margin: const EdgeInsets.only(top: 5),
              width: 65, 
              height: 5,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
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


class ButtonRow extends StatefulWidget {
  @override
  _ButtonRowState createState() => _ButtonRowState();
}

class _ButtonRowState extends State<ButtonRow> {
  int _selectedIndex = 0;

  void _onButtonPressed(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
     
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ButtonItem(icon: Icons.density_small, text: "Tout", 
           isActive: _selectedIndex == 3,
          onPressed: () => _onButtonPressed(3),
          ),
          ButtonItem(
            icon: Icons.videocam,
            text: "En ligne",
            isActive: _selectedIndex == 0,
            onPressed: () => _onButtonPressed(0),
          ),
          ButtonItem(
            icon: Icons.place,
            text: "À Masahaty",
            isActive: _selectedIndex == 1,
            onPressed: () => _onButtonPressed(1),
          ),
          ButtonItem(
            icon: Icons.home,
            text: "À Domicile",
            isActive: _selectedIndex == 2,
            onPressed: () => _onButtonPressed(2),
          ),
        ],
      ),
    );
  }
}