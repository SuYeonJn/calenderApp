import 'package:flutter/material.dart';
import 'teamMaker.dart';
import 'teamShedulePage.dart';
import 'dialog_builder.dart';

class TeamPage extends StatelessWidget {
  const TeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: FriendsList(),
    );
  }
}

class FriendsList extends StatefulWidget {
  const FriendsList({super.key});
  @override
  State<FriendsList> createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
  Map teamDialogContents = {
    'title': '팀 만들기',
    'contents': '팀을 만들어보세요!',
    'confirmBtn': '확인',
    'cancelBtn': '취소'
  };

  final List<String> teamList = <String>['Team1', 'Team2', 'Team3', 'Team4'];
  final List<String> exTeamList = <String>['Team1', 'Team2', 'Team3', 'Team4'];

  int tabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: TabBar(
            tabs: const [
              Tab(text: "Team"),
              Tab(text: "Ex-Teams"),
            ],
          ),
          body: TabBarView(children: <Widget>[
            ListsWidget(
              lists: teamList,
              subjective: '팀',
            ),
            ListsWidget(
              lists: exTeamList,
              subjective: '팀',
            ),
          ]),
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                test().dialogBuilder(
                    context,
                    teamDialogContents['title'],
                    teamDialogContents['contents'],
                    teamDialogContents['confirmBtn'],
                    teamDialogContents['cancelBtn'],
                    TeamMaker());
              },
              child: Icon(Icons.add))),
    );
  }
}

// ignore: must_be_immutable
class ListsWidget extends StatefulWidget {
  ListsWidget({super.key, required this.lists, this.subjective});

  final List<String> lists;
  var subjective;

  @override
  State<ListsWidget> createState() => _ListsWidgetState();
}

class _ListsWidgetState extends State<ListsWidget> {
  final TextEditingController _textEditingController = TextEditingController();
  var initIndex = 0;
  var searched_items = [];

  void search(String query) {
    var teamsList = widget.lists;

    if (query.isEmpty) {
      setState(() {
        searched_items = teamsList;
      });
    } else {
      setState(() {
        searched_items = teamsList
            .where((e) => e.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (initIndex == 0) {
      setState(() {
        searched_items = widget.lists;
      });
    }
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 10.0,
              ),
              SearchBar(
                controller: _textEditingController,
                onChanged: (value) {
                  setState(() {
                    initIndex = 1;
                  });
                  search(value);
                },
                leading: IconButton(
                    onPressed: () => {}, icon: const Icon(Icons.search)),
                hintText: '검색',
                constraints: const BoxConstraints(maxHeight: 45, maxWidth: 450),
              )
            ],
          ),
        ),
        Expanded(
          flex: 8,
          child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: searched_items.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Icon(Icons.person),
                  title: Text('${searched_items[index]}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TeamSchedule()),
                    );
                    ;
                  },
                );
              }),
        ),
      ],
    );
  }
}
