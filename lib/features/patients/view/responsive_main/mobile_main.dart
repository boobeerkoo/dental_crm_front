import 'package:dental_crm_flutter_front/features/patients/patients.dart';
import 'package:dental_crm_flutter_front/features/patients/patients_bloc/patients_bloc.dart';
import 'package:dental_crm_flutter_front/repositories/patient/models/models.dart';
import 'package:dental_crm_flutter_front/repositories/patient/patient_repository.dart';
import 'package:dental_crm_flutter_front/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MobileMain extends StatefulWidget {
  const MobileMain({super.key});

  @override
  State<MobileMain> createState() => _MobileMainState();
}

class _MobileMainState extends State<MobileMain> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  PatientRepository patientRepository = PatientRepository();
  late PatientsBloc patientsBloc;

  List<Patient> searchResults = [];

  @override
  void initState() {
    super.initState();
    patientsBloc = PatientsBloc(patientRepository);
    patientsBloc.add(GetPatientsEvent());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Пацієнти'),
      ),
      drawer: const SideMenu(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 241, 240, 240),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: BlocBuilder<PatientsBloc, PatientsState>(
          bloc: patientsBloc,
          builder: (context, state) {
            return Column(
              children: [
                _buildSearchField(
                    state is PatientsLoadedState ? state.patients.items : []),
                const SizedBox(height: 20),
                Expanded(
                  child: state is PatientLoadingState
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : state is PatientErrorState
                          ? Center(
                              child: Text(state.errorMessage),
                            )
                          : state is PatientsLoadedState
                              ? _isSearching
                                  ? ListView.builder(
                                      itemCount: searchResults.length,
                                      itemBuilder: (context, index) {
                                        final patient = searchResults[index];
                                        return ListTile(
                                          leading: const CircleAvatar(
                                            backgroundImage: NetworkImage(
                                              'https://www.w3schools.com/howto/img_avatar.png',
                                            ),
                                          ),
                                          title: Text(patient.name),
                                          subtitle: Text(patient.phone1),
                                          trailing: const Icon(
                                              Icons.arrow_forward_ios),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PatientDataScreen(
                                                  patient: patient,
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    )
                                  : ListView.builder(
                                      itemCount: state.patients.items.length,
                                      itemBuilder: (context, index) {
                                        final patient =
                                            state.patients.items[index];
                                        return ListTile(
                                          leading: const CircleAvatar(
                                            backgroundImage: NetworkImage(
                                              'https://www.w3schools.com/howto/img_avatar.png',
                                            ),
                                          ),
                                          title: Text(patient.name),
                                          subtitle: Text(patient.phone1),
                                          trailing: const Icon(
                                              Icons.arrow_forward_ios),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PatientDataScreen(
                                                  patient: patient,
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    )
                              : const Center(
                                  child: Text('No data'),
                                ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/patients/add');
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildSearchField(List<Patient> patients) {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: 'Пошук',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: _isSearching
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  setState(() {
                    _searchController.clear();
                    _isSearching = false;
                    searchResults.clear();
                  });
                },
              )
            : null,
      ),
      onChanged: (value) {
        setState(() {
          _isSearching = value.isNotEmpty;
          if (_isSearching) {
            searchResults = patients.where((patient) {
              final name = patient.name.toLowerCase();
              final phone = patient.phone1.toLowerCase().replaceAll(' ', '');
              final query = value.toLowerCase();
              return name.contains(query) || phone.contains(query);
            }).toList();
          }
        });
      },
    );
  }
}
