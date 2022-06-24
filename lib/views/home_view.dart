import 'package:bima_doctor_admin/api_provider/doctor_api.dart';
import 'package:bima_doctor_admin/app/app_constants.dart';
import 'package:bima_doctor_admin/model/doctor.dart';
import 'package:bima_doctor_admin/repository/doctors_repository.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
        appBar: AppBar(actions: const [Text("BIMA DOCTOR")]),
        body: asyncDoctorsList.when(
            data: (doctors) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return DoctorWidget(doctor: doctors[index]);
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
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            width: 60.0,
            height: 60.0,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        "https://upload.wikimedia.org/wikipedia/commons/9/91/Anil_Kapoor_at_%E2%80%9924%E2%80%99_game_launching_event.jpg")))),
      ),
      title: Text('${doctor.firstName}${doctor.lastName}'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start  ,
        children: [
          Text('${doctor.specialization}'),
          Text('${doctor.description}')
        ],
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }
}
