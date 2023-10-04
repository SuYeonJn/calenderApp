
import 'package:flutter/material.dart';

class TeamMaker extends StatefulWidget {
  const TeamMaker({super.key});

  @override
  State<TeamMaker> createState() => _TeamMakerState();
}

GlobalKey<FormState> myFormKey = new GlobalKey();

class _TeamMakerState extends State<TeamMaker> {

  String teamName = '';

  List<String> addedFriendsList = [];

  void _showMultiSelect() async {
    // a list of selectable items
    // these items can be hard-coded or dynamically fetched from a database/API
    final List<String> friendsList = [
      'Flutter',
      'Node.js',
      'React Native',
      'Java',
      'Docker',
      'MySQL'
    ];

    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(
          items: friendsList,
          addedFriends: addedFriendsList,
        );
      },
    );

    // Update UI
    if (results != null) {
      setState(() {
        addedFriendsList = results;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('팀 만들기'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: 100,
                        height: 40,
                        child: TextField(
                          onChanged: (value) {
                            teamName = value;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: '팀 이름',
                          ),
                        )),
                    ElevatedButton(
                      onPressed: () {
                        // _teamData.collection('teams').add({
                        //   "name": teamName,
                        //   "addedFriends": addedFriendsList
                        // });
                        //
                        // Navigator.pop(context);
                      },
                      child: const Text('Complete'),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.people),
                            Text('팀원'),
                            SizedBox(width: 30),
                            Text(
                              '${addedFriendsList.length} 명',
                              style: TextStyle(color: Colors.redAccent),
                            ),
                          ],
                        ),
                        ElevatedButton(
                            onPressed: _showMultiSelect, child: Icon(Icons.add))
                      ],
                    ),
                  ),
                  Wrap(
                    children: addedFriendsList
                        .map((e) => Chip(
                      label: Text(e),
                    ))
                        .toList(),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MultiSelect extends StatefulWidget {
  final List<String> items;
  final List<String> addedFriends;
  const MultiSelect({Key? key, required this.items, required this.addedFriends})
      : super(key: key);

  @override
  State<MultiSelect> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  @override
  Widget build(BuildContext context) {
    final List<String> selectedItems = widget.addedFriends;

    void itemChange(String itemValue, bool isSelected) {
      setState(() {
        if (isSelected) {
          selectedItems.add(itemValue);
        } else {
          selectedItems.remove(itemValue);
        }
      });
    }

    // this function is called when the Cancel button is pressed
    void cancel() {
      Navigator.pop(context);
    }

// this function is called when the Submit button is tapped
    void submit() {
      Navigator.pop(context, selectedItems);
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('친구 추가'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListBody(
                  children: widget.items
                      .map((item) => CheckboxListTile(
                    value: selectedItems.contains(item),
                    title: Text(item),
                    controlAffinity: ListTileControlAffinity.trailing,
                    onChanged: (isChecked) =>
                        itemChange(item, isChecked!),
                  ))
                      .toList()),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: submit,
                    child: const Text('Submit'),
                  ),
                  TextButton(
                    onPressed: cancel,
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
