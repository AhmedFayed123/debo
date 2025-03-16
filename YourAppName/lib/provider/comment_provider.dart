import 'package:flutter/material.dart';
import '../model/successmodel.dart';
import '../webservice/apiservices.dart';
import '../utils/utils.dart';

class CommentProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  bool _loading = false;
  bool get loading => _loading;

  List<String> _comments = [];
  List<String> get comments => _comments;

  setLoading(bool isLoading) {
    _loading = isLoading;
    notifyListeners();
  }

  Future<void> addComment(int videoId, String comment, int videoType, int subVideoType) async {
    if (comment.isEmpty) return;

    printLog("Adding comment: $comment for videoId: $videoId");

    setLoading(true);
    try {
      SuccessModel response = await _apiService.addComment(
        videoId: videoId,
        comment: comment,
        videoType: videoType,
        subVideoType: subVideoType,
      );

      if (response.status == 200) {
        _comments.add(comment);
        notifyListeners();
      }
    } catch (e) {
      printLog("Comment error: $e");
    } finally {
      setLoading(false);
    }
  }

  void clearProvider() {
    _loading = false;
    _comments.clear();
    notifyListeners();
  }
}
