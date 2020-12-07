import 'dart:io';

import 'package:facebook_app/viewmodel/home_view_model.dart';
import 'package:facebook_app/widgets/photo_grid_offline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class CreatePostWidget extends StatefulWidget {
  final HomeProvide provide;

  CreatePostWidget({this.provide});

  @override
  State<StatefulWidget> createState() {
    return _CreatePostState(this.provide);
  }
}

class _CreatePostState extends State<CreatePostWidget> {
  String content = "";
  final HomeProvide provide;

  _CreatePostState(this.provide);

  List<String> pathImages = [];
  List<Asset> images = List<Asset>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.only(
          topLeft: const Radius.circular(10),
          topRight: const Radius.circular(10),
        ),
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: NetworkImage(provide.userEntity.avatar),
                      radius: 20.0,
                    ),
                    SizedBox(width: 7.0),
                    Text(
                        '${provide.userEntity.firstName} ${provide.userEntity.lastName}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17.0)),
                    SizedBox(height: 5.0),
                  ],
                ),
                TextButton(
                    onPressed: () {
                      provide.uploadPost(content, pathImages: pathImages);
                      Navigator.pop(context);
                    },
                    child: Text(
                      'ĐĂNG',
                      style: TextStyle(
                          fontSize: 20,
                          color: content.isEmpty ? Colors.grey : Colors.blue),
                    )),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          TextField(
            maxLines: null,
            minLines: 4,
            textInputAction: TextInputAction.next,
            style: TextStyle(fontSize: 18, color: Colors.black),
            onChanged: (text) {
              setState(() {
                content = text;
              });
            },
            decoration: InputDecoration(
                border: InputBorder.none, hintText: 'Bạn đang nghĩ gì?'),
          ),
          SizedBox(height: 10.0),
          buildImages(context),
          Divider(height: 30.0),
          Container(
            height: 40.0,
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent.withOpacity(0.25),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Center(
                child: GestureDetector(
                    onTap: () {
                      loadAssets();
                    },
                    child: Text('Tải ảnh lên',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0)))),
          ),
        ],
      ),
    );
  }

  Visibility buildImages(BuildContext context) {
    if (pathImages.length == 1) {
      return Visibility(
        visible: true,
        child: Container(
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.width - 10,
          child: Image.file(
            File(pathImages[0]),
            fit: BoxFit.cover,
          ),
        ),
      );
    } else if (pathImages.length % 2 == 0) {
      return Visibility(
        visible: pathImages.length > 0,
        child: PhotoGridOffline(
          imageUrls: pathImages,
          onImageClicked: (i) => print('Image $i was clicked!'),
          onExpandClicked: () => print('Expand Image was clicked'),
          maxImages: 4,
        ),
      );
    } else {
      return Visibility(
          visible: true,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: Image.file(
                    File(pathImages[0]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 6,
                      width: MediaQuery.of(context).size.width / 2.2,
                      child: Image.file(
                        File(pathImages[1]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 6,
                    width: MediaQuery.of(context).size.width / 2.2,
                    child: Image.file(
                      File(pathImages[2]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              )
            ],
          ));
    }
  }

  loadAssets() {
    String error = 'No Error Dectected';

    try {
      MultiImagePicker.pickImages(
        maxImages: 4,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      ).then((value) {
        for (int i = 0; i < value.length; i++) {
          FlutterAbsolutePath.getAbsolutePath(value[i].identifier)
              .then((value) => setState(() {
                    print(value);
                    pathImages.add(value);
                  }));
        }
      });
    } on Exception catch (e) {
      error = e.toString();
    }
    if (!mounted) return;
  }
}
