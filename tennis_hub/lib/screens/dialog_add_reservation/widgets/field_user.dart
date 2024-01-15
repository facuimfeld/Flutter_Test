import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_hub/screens/dialog_add_reservation/blocs/bloc/bloc_court_bloc.dart';

class FieldUser extends StatefulWidget {
  TextEditingController user;
  FieldUser({required this.user});
  @override
  State<FieldUser> createState() => _FieldUserState();
}

class _FieldUserState extends State<FieldUser> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(15),
        height: 80,
        child: Center(
            child: TextFormField(
          controller: widget.user,
          validator: (val) {},
          //controller: dateSelectedController,
          decoration: const InputDecoration(
              icon: Icon(Icons.person), labelText: "Usuario"),
          readOnly: false,
          onTap: () async {},
        )));
  }
}
