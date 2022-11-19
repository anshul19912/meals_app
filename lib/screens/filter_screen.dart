import 'package:flutter/material.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen(
      {Key? key, required this.saveFilters, required this.currentFilters})
      : super(key: key);

  final Function saveFilters;
  final Map<String, bool> currentFilters;
  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  void initState() {
    _glutenFree = widget.currentFilters['gluten']!;
    _lactoseFree = widget.currentFilters['lactose']!;
    _vegan = widget.currentFilters['vegan']!;
    _vegetarian = widget.currentFilters['vegetarian']!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MainDrawer(),
        appBar: AppBar(
          title: Text('Your Filters'),
          actions: [
            IconButton(
                onPressed: () {
                  final selectFilters = {
                    'gluten': _glutenFree,
                    'lactose': _lactoseFree,
                    'vegan': _vegan,
                    'vegetarian': _vegetarian,
                  };
                  widget.saveFilters(selectFilters);
                },
                icon: Icon(Icons.save))
          ],
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text('Adjust your meal selection'),
            ),
            Expanded(
                child: ListView(
              children: [
                SwitchListTile(
                    title: Text("Gluten-free"),
                    subtitle: Text('Only include gluten-free meals.'),
                    value: _glutenFree,
                    onChanged: (newValue) {
                      setState(() {
                        _glutenFree = newValue;
                      });
                    }),
                SwitchListTile(
                    title: Text("Lactose-free"),
                    subtitle: Text('Only include Lactose-free meals.'),
                    value: _lactoseFree,
                    onChanged: (newValue) {
                      setState(() {
                        _lactoseFree = newValue;
                      });
                    }),
                SwitchListTile(
                    title: Text("Vegetarian"),
                    subtitle: Text('Only include vegetarian meals.'),
                    value: _vegetarian,
                    onChanged: (newValue) {
                      setState(() {
                        _vegetarian = newValue;
                      });
                    }),
                SwitchListTile(
                    title: Text("Vega"),
                    subtitle: Text('Only include Vegan meals.'),
                    value: _vegan,
                    onChanged: (newValue) {
                      setState(() {
                        _vegan = newValue;
                      });
                    })
              ],
            ))
          ],
        ));
  }
}
