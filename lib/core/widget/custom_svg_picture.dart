import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../assets_path.dart';

import '../constants.dart';

class CustomPicture extends StatelessWidget {
  const CustomPicture(
      {required this.path,
      this.height,
      this.width,
      this.color,
      this.raduis,
      this.isLocal=true,
      this.isSVG = false,
      this.isLocalFile = false,
      this.withBorder = false,
      this.isCircleShape = false,
      this.fit = BoxFit.scaleDown,
      Key? key})
      : super(key: key);
  final String path;
  final double? height;
  final double? raduis;
  final bool isSVG;
  final bool isLocalFile;
  final bool isLocal;
  final bool isCircleShape;
  final bool withBorder;

  final double? width;
  final BoxFit fit;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return

      isLocalFile?
      Center(
    child:
    // withApectRatio
    //       ?

    SizedBox(
    width: width,
    height: height,
    child: Container(
    decoration: withBorder
    ? BoxDecoration(
    borderRadius: BorderRadius.circular(48.r),
    border:
    Border.all(color: Colors.blueAccent, width: 2))
        : null,
    child:
    isCircleShape?
    CircleAvatar(
    radius: width,
    child:

    ClipOval(child:
    SizedBox.fromSize(
    size: Size.fromRadius(width??0),
    child:
    FadeInImage(
    placeholder: AssetImage(AssetsPath.PNG_NoItemImage),
    imageErrorBuilder: (BuildContext context,
    Object exception, StackTrace? stackTrace) {
    return Image.asset(AssetsPath.PNG_NoItemImage);
    },
    image: path == null || path == ""
    ? AssetImage(AssetsPath.PNG_NoItemImage)
    as ImageProvider
        : FileImage(File(path)) as ImageProvider,
    fit: fit,
    ))
    ,),
    ):
    ClipRRect(

    borderRadius:

    BorderRadius.circular(raduis??14.r),
    child: FadeInImage(
    placeholder: AssetImage(AssetsPath.PNG_NoItemImage),
    imageErrorBuilder: (BuildContext context,
    Object exception, StackTrace? stackTrace) {
    return Image.asset(AssetsPath.PNG_NoItemImage);
    },
    image: path == null || path == ""
    ? AssetImage(AssetsPath.PNG_NoItemImage)
    as ImageProvider
        : FileImage(File(path)) as ImageProvider,
    fit: fit,
    )),
    ),
    )):
        isLocal
        ?
        //local
        Center(
            child:
                // withApectRatio
                //       ?

                SizedBox(
            width: width,
            height: height,
            child: isSVG
                ? ClipRRect(
                    borderRadius: isCircleShape
                        ? BorderRadius.circular(width ?? 0)
                        : BorderRadius.circular(raduis??14.r),
                    child: SvgPicture.asset(
                      path,
                      fit: fit,
                      width: width,
                      height: height,
                      color: color,
                    ))
                : Container(
                    decoration: withBorder
                        ? BoxDecoration(
                            borderRadius: BorderRadius.circular(48.r),
                            border:
                                Border.all(color: Colors.blueAccent, width: 2))
                        : null,
                    child:
                    isCircleShape?
                    CircleAvatar(
                      radius: width,
                      child:

                      ClipOval(child:
                      SizedBox.fromSize(
                          size: Size.fromRadius(width??0),
                           child:
                      FadeInImage(
                        placeholder: AssetImage(AssetsPath.PNG_NoItemImage),
                        imageErrorBuilder: (BuildContext context,
                            Object exception, StackTrace? stackTrace) {
                          return Image.asset(AssetsPath.PNG_NoItemImage);
                        },
                        image: path == null || path == ""
                            ? AssetImage(AssetsPath.PNG_NoItemImage)
                        as ImageProvider
                            : AssetImage(path) as ImageProvider,
                        fit: fit,
                      ))
                        ,),
                    ):
                    ClipRRect(

                        borderRadius:

                           BorderRadius.circular(raduis??14.r),
                        child: FadeInImage(
                          placeholder: AssetImage(AssetsPath.PNG_NoItemImage),
                          imageErrorBuilder: (BuildContext context,
                              Object exception, StackTrace? stackTrace) {
                            return Image.asset(AssetsPath.PNG_NoItemImage);
                          },
                          image: path == null || path == ""
                              ? AssetImage(AssetsPath.PNG_NoItemImage)
                                  as ImageProvider
                              : AssetImage(path) as ImageProvider,
                          fit: fit,
                        )),
                  ),
          ))
        : Center(
            child:
                // withApectRatio
                //       ?
                SizedBox(
            width: width,
            height: height,
            child: isSVG
                ? SvgPicture.network(
                    AppConfigurationsImageUrl + path,
                    fit: fit,
                    width: width,
                    height: height,
                    color: color,
                  )
                : ClipRRect(
                    borderRadius: isCircleShape
                        ? BorderRadius.circular(width ?? 0)
                        : BorderRadius.circular(raduis??14.r),
                    child: CachedNetworkImage(
                        width: width,
                        height: height ,
                        imageUrl:   AppConfigurationsImageUrl+path,
                        fit: fit,
                        // imageBuilder: (context, imageProvider) => Container(
                        //       decoration: BoxDecoration(
                        //         image: DecorationImage(
                        //             image: imageProvider,
                        //             fit: BoxFit.cover,
                        //             colorFilter: ColorFilter.mode(
                        //                 Colors.red, BlendMode.colorBurn)),
                        //       ),
                        //     ),
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
    SvgPicture.asset(AssetsPath.SVG_NoItemImage)),
                  ),
          ));
  }
}
