import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swagapp/modules/common/ui/popup_delete_photo_verify.dart';

import '../../../generated/l10n.dart';
import '../utils/palette.dart';

class MultiImageSlide extends StatefulWidget {
  MultiImageSlide(
      {Key? key, required this.imgList, this.addPhoto, this.onRemove})
      : super(key: key);

  List<XFile> imgList;
  Function()? addPhoto;
  Function(int)? onRemove;
  @override
  State<MultiImageSlide> createState() => _MultiImageSlideState();
}

class _MultiImageSlideState extends State<MultiImageSlide> {
  late final PageController pageController;
  int pageNo = 0;
  int lastLen = 0;
  int currentLen = 0;
  @override
  void initState() {
    pageController = PageController(initialPage: 0, viewportFraction: 1);
    lastLen = widget.imgList.length;

    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 400,
          child: PageView.builder(
            physics: const ClampingScrollPhysics(),
            controller: pageController,
            onPageChanged: (index) {
              pageNo = index;
              setState(() {});
            },
            itemBuilder: (_, index) {
              return AnimatedBuilder(
                animation: pageController,
                builder: (ctx, child) {
                  return child!;
                },
                child: (index < widget.imgList.length)
                    ? GestureDetector(
                        onTap: () {},
                        onPanDown: (d) {},
                        onPanCancel: () {},
                        child: SizedBox(
                          height: 260,
                          child: Stack(children: [
                            Positioned.fill(
                              child: ClipRRect(
                                child: Image.file(
                                  File(widget.imgList[index].path),
                                  fit: BoxFit.cover,
                                  height: 250,
                                  width: 250,
                                ),
                              ),
                            ),
                          ]),
                        ),
                      )
                    : Stack(
                        children: [
                          ClipRRect(
                              child: Image.asset(
                            "assets/images/bagAddList.png",
                            fit: BoxFit.cover,
                            height: 500,
                          )),
                          Positioned.fill(
                            top: 60,
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Text(S.of(context).list_item_for_sale,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .copyWith(
                                          letterSpacing: 1,
                                          fontWeight: FontWeight.w300,
                                          fontFamily: "Knockout",
                                          fontSize: 30,
                                          color: Palette
                                              .current.primaryNeonGreen)),
                            ),
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () {
                                  widget.addPhoto!();
                                },
                                child: Center(
                                  child: Container(
                                      height: 60,
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Palette
                                                  .current.primaryNeonGreen),
                                          color: Palette.current.blackSmoke),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/icons/camera.png",
                                            height: 20,
                                            width: 20,
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Text(S.of(context).add_photos,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                      fontFamily: "Knockout",
                                                      fontSize: 25,
                                                      letterSpacing: 1,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Palette
                                                          .current.white)),
                                        ],
                                      )),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              );
            },
            itemCount: widget.onRemove != null
                ? (widget.imgList.length == 6)
                    ? 6
                    : widget.imgList.length + 1
                : widget.imgList.length,
          ),
        ),
        const SizedBox(
          height: 12.0,
        ),
        Visibility(
          visible: widget.onRemove != null &&
              pageNo + 1 != widget.imgList.length + 1,
          child: Positioned(
            right: 5,
            bottom: 5,
            child: IconButton(
              iconSize: 30,
              color: Palette.current.primaryNeonGreen,
              onPressed: () {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return PopUpDeletePhotoVerify(removePhoto: (bool delete) {
                        if (delete) {
                          setState(() {
                            widget.onRemove!(pageNo);
                            pageController.animateToPage(
                              0,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOutCirc,
                            );
                          });
                        }
                      });
                    });
              },
              icon: Image.asset(
                "assets/icons/x.png",
                scale: 3,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 15,
          left: MediaQuery.of(context).size.width / 2.6,
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.only(top: 6, bottom: 6, left: 8, right: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Palette.current.blackSmoke,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      widget.onRemove != null
                          ? widget.imgList.length + 1
                          : widget.imgList.length, (index) {
                    setState(() {
                      currentLen = widget.imgList.length - 1;
                    });
                    if (currentLen > lastLen) {
                      setState(() {
                        lastLen = currentLen;
                        pageController.animateToPage(
                          currentLen,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOutCirc,
                        );
                      });
                    }
                    return (index != widget.imgList.length)
                        ? GestureDetector(
                            child: Container(
                              margin: const EdgeInsets.all(2.0),
                              child: Icon(
                                Icons.circle,
                                size: 12.0,
                                color: pageNo == index
                                    ? Palette.current.primaryNeonGreen
                                    : Palette.current.grey,
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 18,
                              height: 13,
                              color: Colors.transparent,
                              margin: const EdgeInsets.symmetric(
                                vertical: 0,
                                horizontal: 0,
                              ),
                              child: ImageIcon(
                                color: pageNo == index
                                    ? Palette.current.primaryNeonGreen
                                    : Palette.current.grey,
                                const AssetImage('assets/icons/camera.png'),
                                size: 20,
                              ),
                            ),
                          );
                  }),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
