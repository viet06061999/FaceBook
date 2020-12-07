// import 'package:facebook_app/data/model/post.dart';
// import 'package:facebook_app/viewmodel/home_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// class CreateCommentWidget extends StatefulWidget {
//   final HomeProvide provide;
//   final Post post;
//
//   CreateCommentWidget({this.post, this.provide});
//
//   @override
//   State<StatefulWidget> createState() {
//     return _CreateCommentState(this.post, this.provide);
//   }
// }
//
// class _CreateCommentState extends State<CreateCommentWidget> {
//   String content = "";
//   final HomeProvide provide;
//   final Post post;
//
//   _CreateCommentState(this.post, this.provide);
//   List<String> comments = [];
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.9,
//       decoration: new BoxDecoration(
//         color: Colors.white,
//         borderRadius: new BorderRadius.only(
//           topLeft: const Radius.circular(10),
//           topRight: const Radius.circular(10),
//         ),
//       ),
//       padding: EdgeInsets.all(20),
//       child: Column(
//         children: <Widget>[
//           Container(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: <Widget>[
//                     CircleAvatar(
//                       backgroundImage: NetworkImage(provide.userEntity.avatar),
//                       radius: 20.0,
//                     ),
//                     SizedBox(width: 7.0),
//                     Text(
//                         '${provide.userEntity.firstName} ${provide.userEntity.lastName}',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 17.0)),
//                     SizedBox(height: 5.0),
//                   ],
//                 ),
//                 TextButton(
//                     onPressed: () {
//                       provide.uploadPost(content,pathImages: pathImages);
//                       Navigator.pop(context);
//                     },
//                     child: Text(
//                       'ĐĂNG',
//                       style: TextStyle(
//                           fontSize: 20,
//                           color: content.isEmpty ? Colors.grey : Colors.blue),
//                     )),
//               ],
//             ),
//           ),
//           SizedBox(height: 20.0),
//           TextField(
//             maxLines: null,
//             minLines: 4,
//             textInputAction: TextInputAction.next,
//             style: TextStyle(fontSize: 18, color: Colors.black),
//             onChanged: (text) {
//               setState(() {
//                 content = text;
//               });
//             },
//             decoration: InputDecoration(
//                 border: InputBorder.none, hintText: 'Bạn đang nghĩ gì?'),
//           ),
//           SizedBox(height: 10.0),
//           Divider(height: 30.0),
//           Container(
//             height: 40.0,
//             decoration: BoxDecoration(
//               color: Colors.lightBlueAccent.withOpacity(0.25),
//               borderRadius: BorderRadius.circular(5.0),
//             ),
//             child: Center(
//                 child: GestureDetector(
//                     onTap: (){
//                       ImagePicker().getImage(source: ImageSource.gallery).then((path) {
//                         pathImages.add(path.path);
//                       });
//                     },
//                     child: Text('Tải ảnh lên',
//                         style: TextStyle(
//                             color: Colors.blue,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16.0)))),
//           ),
//         ],
//       ),
//     );
//   }
// }
