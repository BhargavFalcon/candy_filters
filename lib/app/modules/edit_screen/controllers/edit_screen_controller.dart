import 'dart:io';
import 'dart:ui' as ui;

import 'package:candy_filters/constant/argumentConstant.dart';
import 'package:candy_filters/constant/sizeConstant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:saver_gallery/saver_gallery.dart';

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

  GlobalKey<OverRepaintBoundaryState> globalKey = GlobalKey();
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

  Future<void> downloadImage({required Uint8List image}) async {
    await Permission.photos.request();
    Permission.storage.request();

    String path = (Platform.isIOS)
        ? (await getDownloadsDirectory())!.path +
            "/CandyFilters/${DateTime.now().millisecondsSinceEpoch}.png"
        : '/storage/emulated/0/Download/CandyFilters/${DateTime.now().millisecondsSinceEpoch}.png';
    print(path);
    if (Directory("/storage/emulated/0/Download/CandyFilters/").existsSync()) {
      print("Directory exists");
    } else {
      if (Platform.isAndroid) {
        print("Directory not exists");
        Directory("/storage/emulated/0/Download/CandyFilters/")
            .createSync(recursive: true);
      }
    }

    String imageName =
        "CandyFilters_${DateTime.now().millisecondsSinceEpoch}.jpg";

    final result = await SaverGallery.saveImage(
      image,
      fileName: imageName,
      androidRelativePath: "Pictures/CandyFilters/",
      skipIfExists: true,
    );
    hideCircularDialog(Get.context!);
    Fluttertoast.showToast(
      msg: "Image saved successfully",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    print(result.toString());
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

class OverRepaintBoundary extends StatefulWidget {
  final Widget child;

  const OverRepaintBoundary({required Key key, required this.child})
      : super(key: key);

  @override
  OverRepaintBoundaryState createState() => OverRepaintBoundaryState();
}

class OverRepaintBoundaryState extends State<OverRepaintBoundary> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
