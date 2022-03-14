import 'package:candy_sorter/features/candy_sorter/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Settings extends ConsumerStatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends ConsumerState<Settings> {
  final _text = TextEditingController();
  bool _validate = false;
  List<Color> colors = [];
  Color pickedColor = Colors.blue;
  int selectedToDelete = -1;
  late int numberOfCandies;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    colors = ref.read(gameSettingsProvider).colors;
    _text.text = ref.read(gameSettingsProvider).numberOfCandies.toString();
    super.initState();
  }

  void changeColor(Color color) {
    print('changeColor to $color');
    setState(() => pickedColor = color);
  }

  showColorPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: pickedColor,
              onColorChanged: changeColor,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Save it'),
              onPressed: () {
                setState(() {
                  if (!colors.contains(pickedColor)) {
                    colors.add(pickedColor);
                  }
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black, opacity: 1.0),
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          setState(() {
            selectedToDelete = -1;
            FocusManager.instance.primaryFocus?.unfocus();
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
          child: LayoutBuilder(
            builder: (BuildContext context, constraints) {
              return Container(
                decoration: const BoxDecoration(color: Colors.transparent),
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Candies',
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      controller: _text,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      cursorHeight: 15.0,
                      maxLines: 1,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(5.0),
                        border: const OutlineInputBorder(),
                        errorText: _validate ? '' : null,
                        labelText: 'Number of candies',
                      ),
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Colors',
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          onPressed: colors.length < 6 ? showColorPicker : null,
                          icon: const Icon(Icons.plus_one),
                          padding: const EdgeInsets.all(0),
                          tooltip: "Add a new color",
                          disabledColor: Colors.black38,
                          color: Colors.blue,
                          splashColor: Colors.blue.shade100,
                          highlightColor: Colors.blue,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 55,
                      child: ListView.builder(
                        itemCount: colors.length,
                        itemBuilder: (BuildContext context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedToDelete = index;
                                });
                              },
                              child: Container(
                                height: 55,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: index == selectedToDelete
                                        ? colors[index].withOpacity(.4)
                                        : colors[index]),
                                width: 45.0,
                                child: index == selectedToDelete
                                    ? IconButton(
                                        onPressed: () {
                                          setState(() {
                                            colors.remove(colors[index]);
                                          });
                                        },
                                        splashColor:
                                            colors[index].withOpacity(.4),
                                        icon: Icon(
                                          Icons.delete_outline,
                                          color: Colors.black.withOpacity(.8),
                                        ),
                                      )
                                    : null,
                              ),
                            ),
                          );
                        },
                        // This next line does the trick.
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    const Spacer(),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_text.text.isEmpty || int.parse(_text.text) < 1) {
                            setState(() {
                              _validate = true;
                            });
                          } else {
                            ref.read(gameSettingsProvider).colors = colors;
                            ref.read(gameSettingsProvider).numberOfCandies =
                                int.parse(_text.text);
                            setState(() {
                              _validate = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Settings saved')),
                            );
                          }
                        },
                        child: const Text('Save'),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
