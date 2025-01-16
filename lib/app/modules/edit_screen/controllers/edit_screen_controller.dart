import 'dart:ui' as ui;

import 'package:candy_filters/constant/argumentConstant.dart';
import 'package:candy_filters/constant/sizeConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../constant/image_constants.dart';

class EditScreenController extends GetxController {
  RxString profilePhoto = "".obs;
  RxBool isStickerVisible = false.obs;
  RxBool isKeyBordHide = false.obs;
  RxInt stickerIndex = 0.obs;
  RxBool isFontsVisible = false.obs;
  RxBool isColorVisible = false.obs;
  ScrollController scrollController = ScrollController();
  RxList<TextListModel> stickerList = RxList<TextListModel>([]);
  List<StickerModel> emojiList = [
    StickerModel(char: "A", numberOfStickers: 123),
    StickerModel(char: "B", numberOfStickers: 34),
    StickerModel(char: "C", numberOfStickers: 10),
    StickerModel(char: "D", numberOfStickers: 24),
    StickerModel(char: "E", numberOfStickers: 44),
    StickerModel(char: "F", numberOfStickers: 55),
    StickerModel(char: "G", numberOfStickers: 46),
    StickerModel(char: "H", numberOfStickers: 26),
    StickerModel(char: "I", numberOfStickers: 49),
    StickerModel(char: "J", numberOfStickers: 58),
    StickerModel(char: "K", numberOfStickers: 61),
    StickerModel(char: "L", numberOfStickers: 51),
    StickerModel(char: "M", numberOfStickers: 20),
    StickerModel(char: "N", numberOfStickers: 36),
    StickerModel(char: "O", numberOfStickers: 38),
    StickerModel(char: "P", numberOfStickers: 15),
    StickerModel(char: "Q", numberOfStickers: 46),
    StickerModel(char: "R", numberOfStickers: 18),
    StickerModel(char: "S", numberOfStickers: 46),
    StickerModel(char: "T", numberOfStickers: 52),
    StickerModel(char: "U", numberOfStickers: 18),
    StickerModel(char: "V", numberOfStickers: 72),
  ];
  List<String> fontFamilyNames = [
    'AdventurerBlack',
    'AileronsTypeFace',
    'Arciform',
    'Athene',
    'Balloon',
    'Bangers',
    'BoulevardSaintDenis',
    'BreakBold',
    'BreakRegular',
    'BreakSemibold',
    'ChampagneLimousines',
    'ChampagneLimousinesBold',
    'Cookie',
    'EliantoRegular',
    'ExodusDemoRegular',
    'ExodusDemoSharpen',
    'ExodusDemoShino',
    'ExodusDemoStencil',
    'ExodusDemoStriped',
    'IntroHeadRBase',
    'IntroRustGBase2Line',
    'IntroScriptR_H2Base',
    'KittenFat',
    'KittenSlantMonoline',
    'KittenSwash',
    'KolikoBold',
    'KolikoLight',
    'KolikoRegular',
    'LakesightPersonalUseOnly',
    'LeoscarSansSerif',
    'LeoscarSerif',
    'LiyaScriptOne',
    'LuckiestGuy',
    'LuxiaRegular',
    'NemoNightmares',
    'PainterPersonalUseOnly',
    'Precious',
    'ShadedLarch',
    'VictorianLTE',
    'WildYouthRegular',
  ];
  ui.Image? image;
  List<FocusNode> focusNodes = List.generate(22, (index) => FocusNode());
  @override
  void onInit() {
    if (Get.arguments != null) {
      profilePhoto.value = Get.arguments[ArgumentConstant.pickImage];
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadImage();
    });

    super.onInit();
  }

  Future<void> loadImage() async {
    final imageData =
        await DefaultAssetBundle.of(Get.context!).load(AppImage.colorBar);
    image = await decodeImageFromList(imageData.buffer.asUint8List());
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> pickColor({
    required ui.Image image,
    required Offset position,
    required Size widgetSize,
  }) async {
    final double scaleX = image.width / MySize.safeWidth!;
    final double scaleY = image.height / widgetSize.height;

    final int pixelX = (position.dx * scaleX).toInt();
    final int pixelY = (position.dy * scaleY).toInt();

    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.rawRgba);
    if (byteData == null) return;

    final int pixelIndex = (pixelY * image.width + pixelX) * 4;
    if (pixelIndex > 0) {
      final int r = byteData.getUint8(pixelIndex);
      final int g = byteData.getUint8(pixelIndex + 1);
      final int b = byteData.getUint8(pixelIndex + 2);
      final int a = byteData.getUint8(pixelIndex + 3);

      int index =
          stickerList.indexWhere((element) => element.isSelected!.isTrue);
      stickerList[index].fontColor!.value = Color.fromARGB(a, r, g, b);
    }
  }
}

class StickerModel {
  String? char;
  int? numberOfStickers;

  StickerModel({this.char, this.numberOfStickers});
}

class TextListModel {
  TextEditingController? title;
  RxBool? isSelected;
  RxBool? isEdit;
  RxString? uid;
  bool? isImage;
  FocusNode? focusNode;
  Rx<Offset>? offset;
  RxDouble? rotationAngle;
  RxDouble? fontSize;
  RxDouble? opacity;
  RxString? fontFamily;
  bool? showBackground;
  Rx<Color>? fontColor;
  TextListModel({
    this.title,
    this.isSelected,
    this.isEdit,
    this.uid,
    this.isImage,
    this.offset,
    this.focusNode,
    this.rotationAngle,
    this.fontSize,
    this.opacity,
    this.fontFamily,
    this.showBackground,
    this.fontColor,
  });
}
