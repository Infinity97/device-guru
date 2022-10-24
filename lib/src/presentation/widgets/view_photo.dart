import 'dart:io';
import 'dart:typed_data';

import 'package:device_guru/src/utils/theme/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:share_plus/share_plus.dart';

class ViewPhoto extends StatelessWidget {
  final File? imageFile;
  final String? imageUrl;

  ViewPhoto({Key? key, this.imageFile, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
//    return PhotoView(imageProvider: FileImage(imageFile),);
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            PhotoView(
              imageProvider: NetworkImage(imageUrl??"")
              // NetworkImage(imageUrl)
              //     : AssetImage("assets/nothing_to_see_here_binoculors.jpg")
              //     : FileImage(imageFile),
            ),
            Positioned(
              top: 25,
              left: 10,
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: ColorConstants.white,
                  size: 35,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Positioned(
              top: 25,
              right: 10,
              child: IconButton(
                icon: const Icon(
                  Icons.share_rounded,
                  color: ColorConstants.white,
                  size: 35,
                ),
                onPressed: (){print("Pressed Share Button");},
//                 onPressed: () async {
//                   List<String> list = [];
//                   final RenderObject box = context.findRenderObject()!;
//                   final directory = (await getExternalStorageDirectory())!.path;
//                   final documentDirectory =
//                       (await getExternalStorageDirectory())!.path;
//                   if (imageFile != null) {
//                     Uint8List pngBytes = await imageFile!.readAsBytes();
//                     File imgFile = new File('$directory/screenshot.png');
//                     imgFile.writeAsBytes(pngBytes);
//                     list.add('$directory/screenshot.png');
//                     Share.shareXFiles(list,
//                         subject: 'Share ScreenShot',
//                         text: 'Hello, check your share files!',
//                         sharePositionOrigin: box.(Offset.zero) & box.size);
//                   } else {
//                     if (Platform.isAndroid) {
//                       var url = imageUrl;
//                       var response = await get(url);
//                       String imageName = "something.png";
//                       print(documentDirectory);
//                       File imgFile = new File('$documentDirectory/$imageName');
//                       imgFile.writeAsBytesSync(response.bodyBytes);
//                       list.add('$documentDirectory/$imageName');
//                       Share.shareFiles(list,
//                           subject: 'URL File Share',
//                           text: 'Hello, check your share files!',
//                           sharePositionOrigin:
//                           box.localToGlobal(Offset.zero) & box.size);
//                     } else {
//                       //TODO: Does not work for IOS.
//                       Share.share('Hello, check your share files!',
//                           subject: 'URL File Share',
//                           sharePositionOrigin:
//                           box.localToGlobal(Offset.zero) & box.size);
//                     }
//                   }
// //                  List<String> paths = new List();
// //                  paths.add('/assets/google_logo.png');
// //                  Share.shareFiles(paths,text: "This is the google logo am sharing");
//                 },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ViewPhotoGallery extends StatefulWidget {
  final List<String>? imageUrlList;
  final PageController? pageController;
  final int? initialIndex;
  final Decoration? backgroundDecoration;

  ViewPhotoGallery(
      {this.imageUrlList, this.initialIndex, this.backgroundDecoration})
      : pageController = PageController(initialPage: initialIndex??0);

  @override
  _ViewPhotoGalleryState createState() => _ViewPhotoGalleryState();
}

class _ViewPhotoGalleryState extends State<ViewPhotoGallery> {
  int? currentIndex;

  @override
  void initState() {
    currentIndex = widget.initialIndex;
    super.initState();
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Container(),
      ),
      body: Container(
          child: PhotoViewGallery.builder(
            scrollPhysics: const BouncingScrollPhysics(),
            builder: (BuildContext context, int index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(widget.imageUrlList![index]),
                initialScale: PhotoViewComputedScale.contained * 0.8,
//              heroAttributes: HeroAttributes(tag: galleryItems[index].id),
              );
            },
            itemCount: widget.imageUrlList!.length,
            loadingBuilder: (context, event) => Center(
              child: Container(
                width: 20.0,
                height: 20.0,
                child: CircularProgressIndicator(
                  value: event == null
                      ? 0
                      : event.cumulativeBytesLoaded/10,
                ),
              ),
            ),
            backgroundDecoration: BoxDecoration(),
            pageController: widget.pageController,
            onPageChanged: onPageChanged,
          )),
    );
  }
}
