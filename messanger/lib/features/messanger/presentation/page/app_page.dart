import 'package:flutter/material.dart';
import 'package:messanger/features/messanger/di/injection_container.dart';
import 'package:messanger/features/messanger/presentation/bloc/chat_bloc/chat_bloc.dart';
import 'package:messanger/features/messanger/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:messanger/features/messanger/presentation/page/chat_list_page.dart';

class AppPage extends StatefulWidget {
  final UserBloc userOneBloc = di();
  final UserBloc userTwoBloc = di();
  final ChatBloc chatOneBloc = di();
  final ChatBloc chatTwoBloc = di();

  AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  late int index;

  @override
  void initState() {
    index = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: "chat"),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: "chat"),
          ],
          onTap: (ind) {
            setState(() {
              index = ind;
            });
          },
        ),
        body: IndexedStack(
          index: index,
          children: [
            ChatListPage(userBloc: widget.userOneBloc, chatBloc: widget.chatOneBloc,),
            ChatListPage(userBloc: widget.userTwoBloc, chatBloc: widget.chatTwoBloc,),
          ],
        ));
  }
}
