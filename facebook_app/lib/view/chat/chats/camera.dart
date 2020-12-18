import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

// void main() => runApp(AccessCamera());

class AccessCamera extends StatefulWidget {
  @override
  _AccessCameraState createState() => _AccessCameraState();
}

class _AccessCameraState extends State<AccessCamera> {
  File imageFile;
  //
  Widget showImageIfAvailable() {
    return imageFile == null
        ? Text('Please pick an image')
        : Image.file(
      imageFile,
      height: 300.0,
      fit: BoxFit.cover,
      alignment: Alignment.topCenter,
    );
  }

  void getImage(ImageSource source) {
    //maxwidth : for not making image to be high resolution for preventing app from crash in some cases
    ImagePicker.pickImage(source: source, maxWidth: 400.0).then((File image) {
      setState(() {
        imageFile = image;
        //file path in memory
        print('hello $imageFile');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Color defaultColor = Theme.of(context).accentColor;
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text(''),
          ),
          body: Center(
            child: Container(
              width: 300.0,
              child: Column(
                children: <Widget>[
                  OutlineButton(
                    borderSide: BorderSide(
                      color: defaultColor,
                      width: 2.0,
                    ),
                    onPressed: () {
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.camera_alt,
                          color: defaultColor,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          'Add Camera Image',
                          style: TextStyle(
                            color: defaultColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  OutlineButton(
                    borderSide: BorderSide(
                      color: defaultColor,
                      width: 2.0,
                    ),
                    onPressed: () {
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.camera_alt,
                          color: defaultColor,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          'Choose from gallery',
                          style: TextStyle(
                            color: defaultColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  // showImageIfAvailable(),

                  //   showImageIfAvailable,
                ],
              ),
            ),
          )),
    );
    // getImage(ImageSource.camera);
    // showImageIfAvailable;
  }
}