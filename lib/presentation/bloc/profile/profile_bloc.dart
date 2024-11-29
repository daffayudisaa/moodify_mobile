import 'package:bloc/bloc.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitialState()) {
    // Register event handlers
    on<LoadProfileEvent>((event, emit) async {
      // Simulasi pengambilan data dari API atau database
      emit(ProfileLoadedState(
        firstName: 'Mita',
        lastName: 'Paramita',
        email: 'mitaparam@gmail.com',
        gender: 'Female',
        birthDate: DateTime(1999, 12, 31),
      ));
    });

    on<UpdateProfileEvent>((event, emit) {
      emit(ProfileLoadedState(
        firstName: event.firstName,
        lastName: event.lastName,
        email: event.email,
        gender: event.gender,
        birthDate: event.birthDate,
      ));
    });
  }
}
