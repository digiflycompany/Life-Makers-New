import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_makers/features/authentication/data/apis/api.dart';
import 'package:life_makers/features/volunteer_opportunity/cubit/suggestion_states.dart';
import 'package:life_makers/services/shared_preferences/preferences_helper.dart';

class SuggestionCubit extends Cubit<SuggestionState> {
  SuggestionCubit() : super(SuggestionInitial());
  PlatformFile? finalFile;
  String? finalText;
  Dio dio = Dio();

  Future<void> pickFile(String text) async {
    emit(FileUploadLoading());
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      
      if (result != null) {
        PlatformFile file = result.files.first;
        if (kDebugMode) {
          print('File picked: ${file.name}');
          print('File path: ${file.path}');
          print('File size: ${file.size}');
        }

        finalFile =file;
        finalText =text;
        emit(FileUploadSuccess());
        //await uploadFile(file: file,text: text);
      } else {
        emit(FileUploadFailure('Error Uploading File '));
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error picking file: $e');
      }
    }
  }
  Future<void> SubmitSuggestion () async {
    await uploadFile(file: finalFile,text: finalText);
  }
  void ResetStates(){
    emit(SuggestionInitial());
  }

  Future<void> uploadFile({String? text, PlatformFile? file}) async {
    emit(SuggestionLoading());
    try {
      String fileName = file!.path!.split('/').last;

      if (text != null) {
        //formData.fields.add(MapEntry('suggestion', text));
      }
      FormData formData = FormData.fromMap({
        'photo':await MultipartFile.fromFile(file.path!,filename: fileName)
      });
      formData.fields.add(MapEntry('suggestion', text!));
      if (kDebugMode) {
        print('$fileName');
      }
      Response response = await dio.post(EndPoints.suggestionsVolunteers, data: formData,
          options: Options(headers: {'Authorization': 'Bearer ${PreferencesHelper.getToken()}'})
      );
      if (response.statusCode == 200) {
        emit(SuggestionSuccess());
        if (kDebugMode) {
          print('Upload successful. Response: ${response.data}');
        }
      } else {
        emit(SuggestionFailure('Error Uploading image please try again'));
        if (kDebugMode) {
          print('Upload failed. HTTP Status Code: ${response.statusCode}');
        }
      }
        } catch (e) {
      emit(SuggestionFailure('Error Uploading image please try again'));
      if (kDebugMode) {
        print('Error uploading file: $e');
      }
    }
  }

}
