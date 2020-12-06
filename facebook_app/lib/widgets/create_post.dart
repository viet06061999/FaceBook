import 'package:facebook_app/viewmodel/home_view_model.dart';
import 'package:facebook_app/widgets/photo_grid.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
                      provide.uploadPost(content,pathImages: pathImages);
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
                    onTap: (){
                      ImagePicker().getImage(source: ImageSource.gallery).then((path) {
                        pathImages.add(path.path);
                      });
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
      return Visibility(visible: true, child: Image.network(pathImages[0]));
    } else if (pathImages.length % 2 == 0) {
      return Visibility(
        visible: pathImages.length > 0,
        child: PhotoGrid(
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
                  height: MediaQuery
                      .of(context)
                      .size
                      .height / 2,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width / 2 - 4,
                  child: Image.network(pathImages[0], fit: BoxFit.cover),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height / 4,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 2 - 4,
                      child: Image.network(pathImages[1], fit: BoxFit.cover),
                    ),
                  ),
                  Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height / 4,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 2 - 4,
                    child: Image.network(pathImages[2], fit: BoxFit.cover),
                  ),
                ],
              )
            ],
          )
      );
    }
  }
}
