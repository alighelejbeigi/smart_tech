import 'package:get/get.dart';
import 'package:smart_tech/smart_tech.dart';

class DataController extends GetxController {
  final _smartTechPlugin = SmartTech();

  final displayValue = 'Ready'.obs;
  final statusMessage = 'برای دریافت داده، روی دکمه‌ها کلیک کنید.'.obs;
  final isLoading = false.obs;

  final RxInt rebuildCount = 0.obs;

  @override
  void onInit() {
    super.onInit();

    rebuildCount.value = 1;
  }

  Future<void> loadRandomData() async {
    isLoading.value = true;
    statusMessage.value = 'در حال درخواست عدد تصادفی...';

    try {
      final data = await _smartTechPlugin.getNativeData();
      if (data != null && data['randomNumber'] != null) {
        displayValue.value = data['randomNumber']!.toString();
        statusMessage.value = 'عدد تصادفی دریافت شد.';
      } else {
        statusMessage.value = 'خطا: داده‌ای دریافت نشد.';
      }
    } catch (e) {
      statusMessage.value = 'خطا در Native: $e';
      displayValue.value = 'ERROR';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadFixedData() async {
    isLoading.value = true;
    statusMessage.value = 'در حال درخواست عدد ثابت...';

    try {
      final data = await _smartTechPlugin.getNativeData();
      if (data != null && data['fixedValue'] != null) {
        displayValue.value = data['fixedValue']!.toString();
        statusMessage.value = 'عدد ثابت ۱۰۰ دریافت شد.';
      } else {
        statusMessage.value = 'خطا: داده‌ای دریافت نشد.';
      }
    } catch (e) {
      statusMessage.value = 'خطا در Native: $e';
      displayValue.value = 'ERROR';
    } finally {
      isLoading.value = false;
    }
  }
}
