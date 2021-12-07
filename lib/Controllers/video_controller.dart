// import 'dart:async';
//
// import 'package:get/get.dart';
//
//
// class VideoController extends GetxController{
//   // var isLoading = true.obs;
//   // var categoryList = <Category>[].obs;
//   RxList<Category> categoryList = <Category>[].obs;
//   // @override
//   // void onInit(){
//   //   fetchCategories();
//   //   super.onInit();
//   //
//   //
//   // }
//   //
//   // @override
//   // void onClose(){
//   //   super.onClose();
//   // }
//   Timer? timer;
//
//   @override
//   void onInit() {
//     fetchCategories();
//     super.onInit();
//     timer = Timer.periodic(Duration(seconds: 8), (Timer t) => fetchCategories());
//   }
//
//   @override
//   void dispose() {
//     timer?.cancel();
//     super.dispose();
//   }
//
//   void fetchCategories() async{
//     try {
//       // isLoading(true);
//       var categories = await API().getCategories();
//       if(categories != null){
//         categoryList.value = categories;
//       }
//     } finally {
//       // isLoading(false);
//     }
//   }
//
// }