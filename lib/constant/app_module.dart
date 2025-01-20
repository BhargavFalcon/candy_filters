import '../main.dart';
import '../service/adService/ad_service.dart';

void setUp() {
  getIt.registerSingleton<AdService>(AdService());
}
