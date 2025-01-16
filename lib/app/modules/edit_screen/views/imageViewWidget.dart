import 'package:candy_filters/app/modules/edit_screen/controllers/edit_screen_controller.dart';
import 'package:candy_filters/constant/image_constants.dart';
import 'package:candy_filters/constant/sizeConstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageViewWidget extends StatefulWidget {
  final TextEditingController title;
  final void Function()? onTap;
  final bool isSelect;
  final RxDouble? fontSize;

  ImageViewWidget({
    required this.title,
    required this.onTap,
    required this.isSelect,
    this.fontSize,
  });

  @override
  State<ImageViewWidget> createState() => _ImageViewWidgetState();
}

class _ImageViewWidgetState extends State<ImageViewWidget> {
  double rotationAngle = 0.0;

  double _scaleX = 1; // Scale for horizontal flip
  double _scaleY = 1; // Scale for vertical flip
  double _imageWidth = 75; // Initial width
  double _imageHeight = 75; // Initial height
  Offset _dragStart = Offset.zero;

  EditScreenController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotationAngle,
      child: Stack(
        children: [
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.diagonal3Values(_scaleX, _scaleY, 1),
            child: Container(
              width: _imageWidth,
              height: _imageHeight,
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: (widget.isSelect)
                    ? Border.all(color: Colors.white, width: 1.5)
                    : null,
              ),
              child: Image.asset(
                widget.title.text,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
          if (widget.isSelect)
            Positioned(
              top: 0,
              left: 0,
              child: InkWell(
                onTap: widget.onTap,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    AppImage.close,
                    height: MySize.getHeight(25),
                    width: MySize.getHeight(25),
                  ),
                ),
              ),
            ),
          if (widget.isSelect)
            Positioned(
              right: 0,
              top: 0,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _scaleX *= -1; // Flip horizontally
                  });
                },
                child: Image.asset(
                  AppImage.flip,
                  height: MySize.getHeight(25),
                  width: MySize.getHeight(25),
                ),
              ),
            ),
          // Change height and width of image
          if (widget.isSelect)
            Positioned(
              bottom: 0,
              left: 0,
              child: GestureDetector(
                onPanStart: (details) {
                  _dragStart = details.localPosition;
                },
                onPanUpdate: (details) {
                  setState(() {
                    final dx = details.localPosition.dx - _dragStart.dx;
                    final dy = details.localPosition.dy - _dragStart.dy;

                    _imageWidth = (_imageWidth + dx).clamp(10, 400);
                    _imageHeight = (_imageHeight + dy).clamp(10, 400);

                    _dragStart = details.localPosition;
                  });
                },
                child: Image.asset(
                  AppImage.resize,
                  height: MySize.getHeight(25),
                  width: MySize.getHeight(25),
                ),
              ),
            ),
          if (widget.isSelect)
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onPanStart: (details) {},
                onPanUpdate: (details) {
                  setState(() {
                    rotationAngle += details.delta.dx * 0.01;
                  });
                },
                child: Image.asset(
                  AppImage.rotate_scale,
                  height: MySize.getHeight(25),
                  width: MySize.getHeight(25),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
