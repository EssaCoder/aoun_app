import 'package:aoun/data/models/pilgrim.dart';
import 'package:aoun/data/network/data_response.dart';
import 'package:aoun/data/providers/auth_provider.dart';
import 'package:aoun/data/providers/pilgrims_provider.dart';
import 'package:provider/provider.dart';

import '/views/shared/assets_variables.dart';
import '/views/shared/button_widget.dart';
import '/views/shared/shared_components.dart';
import '/views/shared/shared_values.dart';
import '/views/shared/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddPilgrims extends StatefulWidget {
  const AddPilgrims({Key? key, this.pilgrim}) : super(key: key);
  final Pilgrim? pilgrim;
  @override
  State<AddPilgrims> createState() => _AddPilgrimsState();
}

class _AddPilgrimsState extends State<AddPilgrims> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController name;
  late TextEditingController address;
  late TextEditingController phone;
  late TextEditingController supervisorPhone;
  late TextEditingController healthStatus;
  late TextEditingController healthProblem;

  late PilgrimsProvider provider;
  @override
  void initState() {
    provider = Provider.of<PilgrimsProvider>(context, listen: false);
    name = TextEditingController(text: widget.pilgrim?.name);
    address = TextEditingController(text: widget.pilgrim?.address);
    phone = TextEditingController(text: widget.pilgrim?.phone);
    supervisorPhone =
        TextEditingController(text: widget.pilgrim?.supervisorPhone);
    healthStatus = TextEditingController(text: widget.pilgrim?.healthStatus);
    healthProblem = TextEditingController(text: widget.pilgrim?.healthProblem);
    super.initState();
  }

  @override
  void dispose() {
    name.dispose();
    address.dispose();
    phone.dispose();
    supervisorPhone.dispose();
    healthStatus.dispose();
    healthProblem.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      body: Column(
        children: [
          SharedComponents.appBar(title: "Create QR Code"),
          Expanded(
              child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const SizedBox(height: SharedValues.padding * 3),
                SizedBox(
                  width: 100,
                  height: 100,
                  child: SvgPicture.asset(AssetsVariable.addDocument,
                      fit: BoxFit.scaleDown),
                ),
                const SizedBox(height: SharedValues.padding * 2),
                Padding(
                  padding: const EdgeInsets.all(SharedValues.padding),
                  child: TextFieldWidget(
                      controller: name,
                      hintText: "Full Name",
                      validator: (value) {
                        if (value != null && value.isNotEmpty) {
                          return null;
                        }
                        return "This field is required";
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(SharedValues.padding),
                  child: TextFieldWidget(
                      controller: address,
                      hintText: "Address",
                      validator: (value) {
                        if (value != null && value.isNotEmpty) {
                          return null;
                        }
                        return "This field is required";
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(SharedValues.padding),
                  child: TextFieldWidget(
                      controller: phone,
                      hintText: "Phone",
                      validator: (value) {
                        if (value != null && value.isNotEmpty) {
                          return null;
                        }
                        return "This field is required";
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(SharedValues.padding),
                  child: TextFieldWidget(
                      controller: supervisorPhone,
                      hintText: "Supervisor Phone",
                      validator: (value) {
                        if (value != null && value.isNotEmpty) {
                          return null;
                        }
                        return "This field is required";
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(SharedValues.padding),
                  child: TextFieldWidget(
                      controller: healthStatus,
                      hintText: "Health Status",
                      validator: (value) {
                        if (value != null && value.isNotEmpty) {
                          return null;
                        }
                        return "This field is required";
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(SharedValues.padding),
                  child: TextFieldWidget(
                    controller: healthProblem,
                    hintText: "Health Problem",
                    textInputAction: TextInputAction.none,
                    obscureText: true,
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        return null;
                      }
                      return "This field is required";
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(SharedValues.padding),
                  child: ButtonWidget(
                    minWidth: double.infinity,
                    onPressed: () async {
                      final user =
                          Provider.of<AuthProvider>(context, listen: false)
                              .user;
                      Pilgrim pilgrim = Pilgrim(
                          id: widget.pilgrim?.id??DateTime.now().millisecondsSinceEpoch,
                          name: name.text,
                          address: address.text,
                          phone: phone.text,
                          supervisorPhone: supervisorPhone.text,
                          healthStatus: healthStatus.text,
                          healthProblem: healthProblem.text,
                          userID: user!.id);
                      Result result;
                      if (widget.pilgrim == null) {
                        result = await provider.setPilgrim(pilgrim);
                      } else {
                        result = await provider.updatePilgrim(pilgrim);
                      }
                      if (result is Success) {
                        // ignore: use_build_context_synchronously
                        SharedComponents.showSnackBar(
                            context, widget.pilgrim == null?"Pilgrim added success":"Pilgrim edit success");
                      } else {
                        // ignore: use_build_context_synchronously
                        SharedComponents.showSnackBar(
                            // ignore: use_build_context_synchronously
                            context,
                            "Error occurred !!",
                            backgroundColor:
                                // ignore: use_build_context_synchronously
                                Theme.of(context).colorScheme.error);
                      }
                    },
                    child: Text(
                      widget.pilgrim == null ? "Create" : "Edit",
                      style: Theme.of(context).textTheme.button,
                    ),
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    ));
  }
}
