import 'package:yourappname/model/episodebyseasonmodel.dart';
import 'package:yourappname/webservice/apiservices.dart';
import 'package:flutter/material.dart';
import 'package:yourappname/utils/utils.dart';

class EpisodeProvider extends ChangeNotifier {
  EpisodeBySeasonModel episodeBySeasonModel = EpisodeBySeasonModel();
  List<Result> episodeList = []; // قائمة الحلقات المعروضة

  bool loading = false;
  bool loadMore = false;
  int? totalRows, totalPage, currentPage;
  bool? isMorePage;

  // يتم تعيين حالة التحميل
  setLoading(bool isLoading) {
    loading = isLoading;
    notifyListeners();
  }

  // جلب الحلقات بناءً على الموسم
  Future<void> getEpisodeBySeason(seasonId, showId, int pageNo) async {
    print("🔹 Start fetching episodes...");

    // إذا كانت الصفحة 1، قم بتفريغ قائمة الحلقات
    if (pageNo == 1) {
      episodeList.clear();
    }

    loading = true;
    notifyListeners();

    // استدعاء API لجلب الحلقات
    episodeBySeasonModel = await ApiService().episodeBySeason(seasonId, showId, pageNo);

    print("✅ API response received!");

    // التحقق من استجابة الـ API
    if (episodeBySeasonModel.status == 200) {
      setPagination(
        episodeBySeasonModel.totalRows,
        episodeBySeasonModel.totalPage,
        episodeBySeasonModel.currentPage,
        episodeBySeasonModel.morePage,
      );

      // التحقق إذا كانت هناك حلقات جديدة
      if (episodeBySeasonModel.result != null && episodeBySeasonModel.result!.isNotEmpty) {
        List<Result> newEpisodes = episodeBySeasonModel.result!;

        // عكس ترتيب الحلقات الجديدة ليكون التصاعدي
        newEpisodes = newEpisodes.reversed.toList();

        // في حالة كان الصفحة الحالية هي الصفحة الأخيرة، يتم تعيين الحلقات الجديدة
        if (pageNo == totalPage) {
          episodeList = newEpisodes;
        } else {
          // إذا لم تكن الصفحة الأخيرة، يتم إضافة الحلقات الجديدة في بداية القائمة
          episodeList.insertAll(0, newEpisodes);
        }

        print("🎬 Episodes loaded: ${episodeList.length}");

        await setLoadMore(false);
      } else {
        print("⚠ No episodes found!");
        await setLoadMore(false);
      }
    } else {
      print("❌ API call failed!");
      await setLoadMore(false);
    }

    loading = false;
    notifyListeners();
    print("🔻 Finished loading episodes.");
  }

  // تعيين حالة تحميل المزيد
  setLoadMore(bool loadMore) {
    printLog("setLoadMore loadMore :=> $loadMore");
    this.loadMore = loadMore;
    notifyListeners();
  }

  // مسح البيانات القديمة
  clearOldData() {
    episodeList.clear();
    notifyListeners();
  }

  // تعيين بيانات الـ pagination
  setPagination(int? totalRows, int? totalPage, int? currentPage, bool? morePage) {
    printLog("setPagination currentPage :==> $currentPage");
    printLog("setPagination totalRows :====> $totalRows");
    printLog("setPagination totalPage :====> $totalPage");
    printLog("setPagination morePage :=====> $morePage");
    this.currentPage = currentPage;
    this.totalRows = totalRows;
    this.totalPage = totalPage;
    isMorePage = morePage;
    notifyListeners();
  }

  // مسح بيانات الـ provider
  clearProvider() {
    printLog("<================ clearProvider ================>");
    episodeBySeasonModel = EpisodeBySeasonModel();
    loadMore = false;
    totalRows = null;
    totalPage = null;
    currentPage = null;
    isMorePage = null;
  }
}
