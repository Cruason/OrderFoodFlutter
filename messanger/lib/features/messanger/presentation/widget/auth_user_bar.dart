
import 'package:flutter/material.dart';
import 'package:messanger/features/messanger/domain/entity/user_entity.dart';
import 'package:messanger/features/messanger/presentation/widget/custom_dialog.dart';

class AuthUserBar extends StatefulWidget {
  final Function(UserEntity) registerUser;
  final Function(String) loginUser;

  const AuthUserBar(
      {super.key, required this.registerUser, required this.loginUser});

  @override
  State<AuthUserBar> createState() => _AuthUserBarState();
}

class _AuthUserBarState extends State<AuthUserBar> {
  late UserEntity userEntity;

  @override
  void initState() {
    userEntity = UserEntity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        TextButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return CustomDialog(
                  widget: Column(
                    children: [

                      buildRegister(
                        usernameChange: (usernameChange) {
                          setState(() {
                            userEntity =
                                userEntity.copyWith(username: usernameChange);
                          });
                        },
                        phoneChange: (phoneChange) {
                          setState(() {
                            userEntity =
                                userEntity.copyWith(phone: phoneChange);
                          });
                        },
                      )
                    ],
                  ),
                  onConfirm: () {
                    widget.registerUser(userEntity);
                  },
                );
              },
            );
          },
          child: Text("Зарегистрироваться"),
        ),
        const SizedBox(
          width: 16,
        ),
        TextButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  var phone ="";
                  return CustomDialog(
                    widget: buildLogin((newPhone){
                      phone = newPhone;
                    }),
                    onConfirm: () {
                      widget.loginUser(phone);
                    },
                  );
                });
          },
          child: Text("Войти"),
        ),
      ],
    );
  }

  Widget buildRegister({
    required Function(String) usernameChange,
    required Function(String) phoneChange,
  }) {
    TextEditingController userNameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    return Column(
      children: [
        TextField(
          onChanged: (val) {
            usernameChange(val);
          },
          controller: userNameController,
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            hintText: 'username',
          ),
        ),
        TextField(
          onChanged: (val) {
            phoneChange(val);
          },
          controller: phoneController,
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            hintText: 'phone',
          ),
        ),
      ],
    );
  }

  Widget buildLogin(Function(String) phoneChange) {
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
