import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodify_mobile/presentation/bloc/change_password/change_pass_event.dart';
import 'package:moodify_mobile/presentation/bloc/change_password/change_pass_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc() : super(ChangePasswordInitial()) {
    on<ChangePasswordSubmitted>(_onChangePasswordSubmitted);
  }

  Future<void> _onChangePasswordSubmitted(
      ChangePasswordSubmitted event, Emitter<ChangePasswordState> emit) async {
    emit(ChangePasswordLoading());

    try {
      final credentials = await loadUserCredentials();
      final userId = credentials['userId'];
      final accessToken = credentials['accessToken'];
      print(userId);
      print(accessToken);

      if (userId == null) {
        emit(ChangePasswordFailure(errorMessage: "User ID not found"));
        return;
      }

      if (accessToken == null || accessToken.isEmpty) {
        emit(ChangePasswordFailure(errorMessage: "Access token not found"));
        return;
      }

      final response = await http
          .put(
            Uri.parse('http://sirw.my.id/users/$userId/password'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $accessToken',
              // Add any necessary authorization headers (if needed)
            },
            body: json.encode({
              'old_password': event.oldPassword,
              'new_password': event.newPassword,
            }),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        // Assuming the API returns success when the password change is successful
        emit(ChangePasswordSuccess());
      } else {
        // Handle different status codes or error responses
        final errorMessage = json.decode(response.body)['message'] ??
            'Failed to change password';
        emit(ChangePasswordFailure(errorMessage: errorMessage));
      }
    } catch (e) {
      emit(ChangePasswordFailure(errorMessage: e.toString()));
    }
  }
}

Future<Map<String, dynamic>> loadUserCredentials() async {
  final prefs = await SharedPreferences.getInstance();
  final userIdString = prefs.getString('user_id');
  final accessToken = prefs.getString('access_token');

  final userId = int.tryParse(userIdString ?? '');

  return {
    'userId': userId,
    'accessToken': accessToken,
  };
}
