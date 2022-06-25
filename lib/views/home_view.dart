import 'package:bima_doctor_admin/app/route_constants.dart';
import 'package:bima_doctor_admin/model/doctor.dart';
import 'package:bima_doctor_admin/repository/doctors_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final doctorRepositoryProvider = Provider(
  (ref) {
    return DoctorsRepositoryImpl();
  },
);
final doctorListProvider = FutureProvider((ref) async {
  List<Doctor> doctors =
      await ref.read(doctorRepositoryProvider).getAllDoctors();
  return doctors;
});

class HomeView extends ConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncDoctorsList = ref.watch(doctorListProvider);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
          title: const Text("BIMA DOCTOR",
              style: TextStyle(
                color: Color.fromARGB(255, 0, 92, 167),
                fontFamily: "Roboto Condensed",
                fontStyle: FontStyle.normal,
                fontSize: 30,
              )),
        ),
        body: asyncDoctorsList.when(
            data: (doctors) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoute.doctorRoute,
                            arguments: doctors[index]);
                      },
                      child: DoctorWidget(doctor: doctors[index]));
                },
                itemCount: doctors.length,
              );
            },
            error: (e, s) => Text(e.toString()),
            loading: () => const CircularProgressIndicator()));
  }
}

class DoctorWidget extends StatelessWidget {
  final Doctor doctor;
  const DoctorWidget({Key? key, required this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                width: 60.0,
                height: 90.0,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            "https://upload.wikimedia.org/wikipedia/commons/9/91/Anil_Kapoor_at_%E2%80%9924%E2%80%99_game_launching_event.jpg")))),
          ),
          title: Text('${doctor.firstName}${doctor.lastName}',
              style: const TextStyle(
                color: Color.fromARGB(255, 30, 153, 210),
                fontFamily: "Roboto",
                fontStyle: FontStyle.normal,
                fontSize: 20,
              )),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${doctor.specialization}',
                  style: const TextStyle(
                    color: Colors.lightBlue,
                    fontFamily: "Roboto Condensed",
                    fontStyle: FontStyle.normal,
                    fontSize: 15,
                  )),
              Text(
                '${doctor.description}',
                maxLines: 2,
              ),
            ],
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
        const Divider(
          height: 2,
          thickness: 1,
        )
      ],
    );
  }
}
