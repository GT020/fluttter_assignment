import 'package:bima_doctor_admin/app/app_constants.dart';
import 'package:bima_doctor_admin/model/doctor.dart';
import 'package:bima_doctor_admin/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final editBoolProvider = StateProvider.autoDispose<bool>((ref) => true);

class DoctorView extends ConsumerStatefulWidget {
  final Doctor doctor;

  const DoctorView({Key? key, required this.doctor}) : super(key: key);

  @override
  ConsumerState<DoctorView> createState() => _DoctorViewState();
}

class _DoctorViewState extends ConsumerState<DoctorView> {
  late final TextEditingController firstNameFieldController;
  late final TextEditingController lastNameFieldController;
  late final TextEditingController genderFieldController;
  late final TextEditingController phoneFieldController;
  late final TextEditingController heightFieldController;
  late final TextEditingController weightFieldController;
  late final TextEditingController bloodGroupFieldController;
  @override
  void initState() {
    super.initState();
    firstNameFieldController =
        TextEditingController(text: widget.doctor.firstName);
    lastNameFieldController =
        TextEditingController(text: widget.doctor.lastName);
    genderFieldController = TextEditingController(text: widget.doctor.gender);
    phoneFieldController =
        TextEditingController(text: widget.doctor.primaryContactNo);
    heightFieldController =
        TextEditingController(text: widget.doctor.height.toString());
    weightFieldController =
        TextEditingController(text: widget.doctor.weight.toString());
    bloodGroupFieldController =
        TextEditingController(text: widget.doctor.bloodGroup);
  }

  @override
  void dispose() {
    firstNameFieldController.dispose();
    lastNameFieldController.dispose();
    genderFieldController.dispose();
    phoneFieldController.dispose();
    heightFieldController.dispose();
    weightFieldController.dispose();
    bloodGroupFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final editBool = ref.watch(editBoolProvider);
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(300),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              color: primary,
              height: 250,
            ),
            Positioned(
              top: 100,
              child: Container(
                height: 150,
                width: width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 60,
              child: Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  shape: BoxShape.circle,
                  image: const DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        "https://upload.wikimedia.org/wikipedia/commons/9/91/Anil_Kapoor_at_%E2%80%9924%E2%80%99_game_launching_event.jpg"),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 150,
              child:
                  Text('${widget.doctor.firstName} ${widget.doctor.lastName}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: "Roboto",
                        fontStyle: FontStyle.normal,
                        fontSize: 20,
                      )),
            ),
            Positioned(
              bottom: 20,
              child: MaterialButton(
                onPressed: () {
                  ref.read(editBoolProvider.notifier).update((state) => !state);
                  if (ref.read(editBoolProvider)) {
                    print('gonna save edited');
                    final Doctor editedDoctor = widget.doctor.copyWith(
                        firstName: firstNameFieldController.text,
                        lastName: lastNameFieldController.text,
                        primaryContactNo: phoneFieldController.text,
                        height: int.parse(heightFieldController.text),
                        weight: int.parse(weightFieldController.text),
                        bloodGroup: bloodGroupFieldController.text);
                    ref
                        .read(doctorRepositoryProvider)
                        .savedEditedDoctor(editedDoctor);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 53, 131, 97),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    ref.read(editBoolProvider.notifier).state
                        ? 'Edit Profile'
                        : "Save",
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: "Roboto",
                      fontStyle: FontStyle.normal,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Wrap(
          children: [
            const Center(
              child: Text("PersonDetails",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Roboto Condensed",
                    fontStyle: FontStyle.normal,
                    fontSize: 30,
                  )),
            ),
            DocTextField(
                textEditingController: firstNameFieldController,
                readOnlyBool: editBool,
                title: "First Name"),
            DocTextField(
                textEditingController: lastNameFieldController,
                readOnlyBool: editBool,
                title: "Last Name"),
            DocTextField(
                textEditingController: genderFieldController,
                readOnlyBool: editBool,
                title: "Gender"),
            DocTextField(
                textEditingController: phoneFieldController,
                readOnlyBool: true,
                title: "Phone Number"),
            DocTextField(
                boxConstraints: const BoxConstraints(maxWidth: 90),
                textEditingController: weightFieldController,
                readOnlyBool: editBool,
                title: "Weight"),
            DocTextField(
                boxConstraints: const BoxConstraints(maxWidth: 90),
                textEditingController: heightFieldController,
                readOnlyBool: editBool,
                title: "Height"),
            DocTextField(
                boxConstraints: const BoxConstraints(maxWidth: 90),
                textEditingController: bloodGroupFieldController,
                readOnlyBool: editBool,
                title: "Blood Group"),
          ],
        ),
      ),
    );
  }
}

class DocTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool readOnlyBool;
  final String title;
  final BoxConstraints? boxConstraints;
  const DocTextField(
      {Key? key,
      required this.textEditingController,
      required this.readOnlyBool,
      required this.title,
      this.boxConstraints})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.fromLTRB(5, 20, 5, 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          style: const TextStyle(
            color: Colors.black,
            fontFamily: "Roboto",
            fontStyle: FontStyle.normal,
            fontSize: 20,
          ),
          readOnly: readOnlyBool,
          controller: textEditingController,
          decoration: InputDecoration(
            constraints: boxConstraints,
            border: const OutlineInputBorder(borderSide: BorderSide.none),
            labelText: title,
            labelStyle: const TextStyle(
              color: Colors.grey,
              fontFamily: "Roboto",
              fontStyle: FontStyle.normal,
              fontSize: 25,
            ),
          ),
        ),
      ),
    );
  }
}
