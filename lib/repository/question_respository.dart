import 'dart:convert';
import 'package:fastic/model/models.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

///
/// Repository class for questions
///
class QuestionRepository {
  /// Fetch questions form Remote config
  /// Convert string from remote config to List of Questions objects
  ///
  static Future<List<Question>> fetchQuestions() async {
    try {
      final RemoteConfig remoteConfig = await RemoteConfig.instance;
      remoteConfig.setConfigSettings(RemoteConfigSettings(debugMode: true));
      await remoteConfig.fetch(expiration: const Duration(seconds: 0));
      await remoteConfig.activateFetched();
      final questionsStr = remoteConfig.getString('questions');
      List l = json.decode(questionsStr);
      List<Map<String, dynamic>> q = List<Map<String, dynamic>>.from(l);
      List<Question> questionList = q.map((q) => Question.fromJson(q)).toList();
      return questionList;
    } on FetchThrottledException catch (exception) {
      print(exception);
      return [];
    } catch (exception) {
      print('Unable to fetch remote config.');
      return [];
    }
  }
}
