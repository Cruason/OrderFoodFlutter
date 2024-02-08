import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messanger/core/constants/constants.dart';
import 'package:messanger/features/messanger/presentation/bloc/chat_bloc/chat_bloc.dart';
import 'package:messanger/features/messanger/presentation/bloc/chat_bloc/chat_event.dart';
import 'package:messanger/features/messanger/presentation/bloc/chat_bloc/chat_state.dart';
import 'package:messanger/features/messanger/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:messanger/features/messanger/presentation/bloc/user_bloc/user_event.dart';
import 'package:messanger/features/messanger/presentation/bloc/user_bloc/user_state.dart';
import 'package:messanger/features/messanger/presentation/page/chat_page.dart';
import 'package:messanger/features/messanger/presentation/widget/auth_user_bar.dart';
import 'package:messanger/features/messanger/presentation/widget/chat_list.dart';
import 'package:messanger/features/messanger/presentation/widget/chat_list_bar.dart';
import 'package:messanger/features/messanger/presentation/widget/custom_dialog.dart';
import 'package:messanger/features/messanger/presentation/widget/drop_down.dart';

class ChatListPage extends StatelessWidget {
  final UserBloc userBloc;
  final ChatBloc chatBloc;

  const ChatListPage(
      {super.key, required this.userBloc, required this.chatBloc});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => userBloc),
      ],
      child: BlocBuilder(
        bloc: userBloc,
        builder: (BuildContext context, state) {
          if (state is UserErrorState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message ?? "Unknown error"),
                ),
              );
              userBloc.add(LogoutUserEvent());
            });
          }
          if (state is UserDoesNotExistState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message ?? "Unknown error"),
                ),
              );
              userBloc.add(LogoutUserEvent());
            });
          }
          return SafeArea(
            child: Column(
              children: [
                const SizedBox(
                  height: 14,
                ),
                (state is UserDidNotLoginState)
                    ? Expanded(
                        child: AuthUserBar(
                          registerUser: (userEntity) {
                            userBloc.add(RegisterUserEvent(userEntity));
                          },
                          loginUser: (phone) {
                            userBloc.add(LoginUserEvent(phone));
                          },
                        ),
                      )
                    : const SizedBox(),
                (state is UserSuccessState)
                    ? BlocBuilder(
                        bloc: chatBloc
                          ..add(GetChatsEvent(userId: userBloc.userEntity.id!)),
                        builder: (BuildContext context, state) {
                          if (state is ChatsErrorState) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text(state.message ?? "Unknown error"),
                                ),
                              );
                              chatBloc.add(GetChatsEvent(
                                  userId: userBloc.userEntity.id!));
                            });
                          }
                          if (state is NoUserForChatState) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text(state.message ?? "Unknown error"),
                                ),
                              );
                              chatBloc.add(GetChatsEvent(
                                  userId: userBloc.userEntity.id!));
                            });
                          }
                          return Expanded(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: ChatListBar(
                                    startChat: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            var phone = "";
                                            var color = ProfileColor.orange;
                                            return CustomDialog(
                                              widget: Column(
                                                children: [
                                                  CustomDropDown(color,
                                                      colorSelected:
                                                          (colorSelected) {
                                                    color = colorSelected;
                                                  }),
                                                  buildPhoneInput((newPhone) {
                                                    phone = newPhone;
                                                  }),
                                                ],
                                              ),
                                              onConfirm: () {
                                                chatBloc.add(AddChatEvent(
                                                    color: color,
                                                    userId:
                                                        userBloc.userEntity.id!,
                                                    phone: phone));
                                              },
                                            );
                                          });
                                    },
                                    logout: () {
                                      userBloc.add(LogoutUserEvent());
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                const Divider(
                                  thickness: 1,
                                  color: CustomColors.lightDivider,
                                ),
                                if (state is ChatsSuccessState)
                                  Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                        child: ChatList(
                                    chatList: state.chatList ?? [],
                                    userId: userBloc.userEntity.id!,
                                    onClick: (chatEntity) async {
                                        await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => ChatPage(
                                                      chatBloc: chatBloc,
                                                      chatEntity: chatEntity,
                                                      userId:
                                                          userBloc.userEntity.id!,
                                                    )));
                                        chatBloc.add(GetChatsEvent(
                                            userId: userBloc.userEntity.id!));
                                    },
                                  ),
                                      ))
                                else
                                  const SizedBox()
                              ],
                            ),
                          );
                        })
                    : const SizedBox()
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildPhoneInput(Function(String) phoneChange) {
    TextEditingController phoneController = TextEditingController();
    return TextField(
      onChanged: (val) {
        phoneChange(val);
      },
      controller: phoneController,
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        hintText: 'phone',
      ),
    );
  }
}
