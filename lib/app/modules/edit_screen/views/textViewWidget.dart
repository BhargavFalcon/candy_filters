import 'package:candy_filters/app/modules/edit_screen/controllers/edit_screen_controller.dart';
import 'package:candy_filters/constant/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constant/image_constants.dart';
import '../../../../constant/sizeConstant.dart';

class TextViewWidget extends StatefulWidget {
  final TextEditingController title;
  final void Function()? onTap;
  final bool isSelect;
  final bool? showBackground;
  bool isEdit;
  final RxDouble? fontSize;
  final RxDouble? opacity;
  final RxString? fontFamily;
  final FocusNode? focusNode;
  final Rx<Color>? fontColor;
  TextViewWidget(
      {required this.title,
      required this.onTap,
      required this.isSelect,
      required this.isEdit,
      this.showBackground,
      this.focusNode,
      this.fontSize,
      this.opacity,
      this.fontFamily,
      this.fontColor});

  @override
  State<TextViewWidget> createState() => _TextViewWidgetState();
}

class _TextViewWidgetState extends State<TextViewWidget> {
  double rotationAngle = 0.0;
  EditScreenController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Transform.rotate(
          angle: rotationAngle,
          child: Stack(
            children: [
              Container(
                padding:
                    EdgeInsets.all((widget.showBackground ?? false) ? 4 : 0),
                color: (widget.showBackground ?? false)
                    ? appTheme.black.withValues(alpha: 0.5)
                    : null,
                child: Container(
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: (widget.isSelect)
                        ? Border.all(color: Colors.white, width: 1.5)
                        : null,
                  ),
                  child: (widget.isEdit)
                      ? SizedBox(
                          width: calculateTextWidth(
                            widget.title.text,
                            TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12 * widget.fontSize!.value,
                              color: widget.fontColor!.value
                                  .withOpacity(widget.opacity!.value),
                              fontFamily: widget.fontFamily!.value,
                            ),
                          ),
                          child: TextFormField(
                            focusNode: widget.focusNode,
                            autofocus: true,
                            controller: widget.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12 * widget.fontSize!.value,
                              color: widget.fontColor!.value
                                  .withOpacity(widget.opacity!.value),
                              fontFamily: widget.fontFamily!.value,
                            ),
                            maxLines: 5,
                            minLines: 1,
                            onChanged: (value) {
                              setState(() {});
                            },
                            decoration:
                                InputDecoration(border: InputBorder.none),
                            onEditingComplete: () {
                              widget.isEdit = false;
                              controller.stickerList.forEach(
                                (element) => element.isEdit = false.obs,
                              );

                              setState(() {});
                            },
                          ),
                        )
                      : Text(
                          """${widget.title.text}""",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12 * widget.fontSize!.value,
                            color: widget.fontColor!.value
                                .withOpacity(widget.opacity!.value),
                            fontFamily: widget.fontFamily!.value,
                          ),
                          overflow: TextOverflow.clip,
                        ),
                ),
              ),
              if (widget.isSelect)
                Positioned(
                  top: 0,
                  left: 0,
                  child: InkWell(
                    onTap: widget.onTap,
                    child: Image.asset(
                      AppImage.close,
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
                    onPanUpdate: (details) {
                      setState(() {
                        widget.fontSize!.value += details.delta.dy * 0.1;
                        if (widget.fontSize!.value < 2.0) {
                          widget.fontSize!.value = 2.0;
                        }
                        if (widget.fontSize!.value > 10.0) {
                          widget.fontSize!.value = 10.0;
                        }
                        rotationAngle += details.delta.dx * 0.01;
                      });
                    },
                    child: Image.asset(
                      AppImage.resize,
                      height: MySize.getHeight(25),
                      width: MySize.getHeight(25),
                    ),
                  ),
                ),
            ],
          ),
        ));
  }

  double calculateTextWidth(String text, TextStyle style) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();

    return textPainter.size.width + 10;
  }
}
