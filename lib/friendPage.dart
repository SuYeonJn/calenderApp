import 'package:date_range_form_field/date_range_form_field.dart';
import 'teamMaker.dart';
import 'package:from_to_time_picker/from_to_time_picker.dart';

import 'package:flutter/material.dart';
import 'dialog_builder.dart';

//달력 ui 만들기(스케줄 추가 페이지),
//initialize와 return 전의 공간 차이, void, function 등과 변수들 차이, initstate, dispose 함수 의미
//파이어베이스 read, create, 설명 추가, 리팩토링

class FriendsPage extends StatelessWidget {
  const FriendsPage({super.key});

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

Map friendsDialogContents = {
  'title': '친구 추가하기',
  'contents': '친구 추가한 후 스케줄을 추가하세요!',
  'confirmBtn': '확인',
  'cancelBtn': '취소'
};

class _FriendsListState extends State<FriendsList> {
  final List<String> friendsList = <String>[
    'friend1',
    'friend2',
    'friend3',
    'friend4'
  ];
  var searched_items = ['friend1', 'friend2', 'friend3', 'friend4'];

  void search(String query) {
    if (query.isEmpty) {
      setState(() {
        searched_items = friendsList;
      });
    } else {
      setState(() {
        searched_items = friendsList
            .where((e) => e.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("친구 리스트"),
        ),
        body: Column(
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
                      search(value);
                    },
                    leading: IconButton(
                        onPressed: () => {}, icon: const Icon(Icons.search)),
                    hintText: '검색',
                    constraints:
                    const BoxConstraints(maxHeight: 45, maxWidth: 450),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListsWidget(
                lists: searched_items,
                subjective: '팀',
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              test().dialogBuilder(
                  context,
                  friendsDialogContents['title'],
                  friendsDialogContents['contents'],
                  friendsDialogContents['confirmBtn'],
                  friendsDialogContents['cancelBtn'],
                  TeamMaker()); // 친구 추가 페이지로 바꿔야 함
            },
            child: Icon(Icons.add)),
      ),
    );
  }
}

// ignore: must_be_immutable
class ListsWidget extends StatefulWidget {
  ListsWidget({super.key, required this.lists, this.subjective});

  final lists;
  var subjective;

  @override
  State<ListsWidget> createState() => _ListsWidgetState();
}

class _ListsWidgetState extends State<ListsWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: widget.lists.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Icon(Icons.person),
            title: Text('${widget.lists[index]}'),
            onTap: () {
              print('${widget.lists[index]} selected');
            },
          );
        });
  }
}
