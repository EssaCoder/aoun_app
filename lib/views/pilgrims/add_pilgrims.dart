import 'package:aoun/views/shared/assets_variables.dart';
import 'package:aoun/views/shared/button_widget.dart';
import 'package:aoun/views/shared/shared_components.dart';
import 'package:aoun/views/shared/shared_values.dart';
import 'package:aoun/views/shared/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddPilgrims extends StatefulWidget {
  const AddPilgrims({Key? key}) : super(key: key);

  @override
  State<AddPilgrims> createState() => _AddPilgrimsState();
}

class _AddPilgrimsState extends State<AddPilgrims> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController fullName;
  late TextEditingController address;
  late TextEditingController phone;
  late TextEditingController supervisorPhone;
  late TextEditingController healthStatus;
  late TextEditingController healthProblem;
  @override
  void initState() {
    fullName = TextEditingController();
    address = TextEditingController();
    phone = TextEditingController();
    supervisorPhone = TextEditingController();
    healthStatus = TextEditingController();
    healthProblem = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    fullName.dispose();
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
                      controller: fullName,
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
                    onPressed: () async {},
                    child: Text(
                      "Create",
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
