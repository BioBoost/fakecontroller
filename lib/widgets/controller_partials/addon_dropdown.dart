import 'package:bug_mobile_controller/bug/addon.dart';
import 'package:flutter/material.dart';

class AddonDropdown extends StatefulWidget {
  AddonDropdown(this.addons, this.onSelectionChanged);

  final List<Addon> addons;
  final ValueChanged<Addon> onSelectionChanged;

  @override
  _AddonDropdownState createState() => new _AddonDropdownState(addons, onSelectionChanged);
}

class _AddonDropdownState extends State<AddonDropdown> {
  _AddonDropdownState(this.addons, this.onSelectionChanged);

  final List<Addon> addons;
  final ValueChanged<Addon> onSelectionChanged;
  Addon _selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      child: DropdownButton<String>(
        value: _selected?.id,
        onChanged: (selected) {
          setState(() {
            _selected = addons.firstWhere((addon) => addon.id == selected, orElse: () => null);
            onSelectionChanged(_selected);
          });
        },
        hint: new Text("Addon ..."),
        items: addons.map<DropdownMenuItem<String>>((Addon addon) {
          return DropdownMenuItem<String>(
            value: addon.id,
            child: Text(addon.name,
              style: new TextStyle(
                color: Colors.black,
                fontSize: 15.0
              )
            ),
          );
        }).toList(),
      ),
    );
  }
}







