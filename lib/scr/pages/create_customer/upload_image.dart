import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:rent_bike/scr/models/user_model.dart';
import 'package:rent_bike/scr/pages/create_customer/create_customer_page.dart';
import 'package:rent_bike/scr/pages/customer_list/customer_list_page.dart';
import 'package:rent_bike/scr/utils/constants.dart';
import 'package:async/async.dart';

class MyUpload extends StatefulWidget {
  final UserModel? userModel;
  const MyUpload({Key? key, required this.userModel}) : super(key: key);

  @override
  _MyUploadState createState() => _MyUploadState();
}

class _MyUploadState extends State<MyUpload> {
  /// Variables
  File? imageFile;

  /// Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload hình ảnh"),
        backgroundColor: Colors.green,
      ),
      body: Container(
        child: imageFile == null
            ? Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.greenAccent)),
                      onPressed: () {
                        _getFromGallery();
                      },
                      child: const Text("Chọn từ thư viện"),
                    ),
                    // Container(
                    //   height: 40.0,
                    // ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.lightGreenAccent)),
                      onPressed: () {
                        _getFromCamera();
                      },
                      child: const Text("Chọn từ camera"),
                    )
                  ],
                ),
              )
            : Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 300,
                        height: 300,
                        child: Container(
                          child: Center(
                            child: Image.file(
                              imageFile!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 35,
                    width: 150,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.greenAccent),
                      ),
                      onPressed: () {
                        _getFromGallery();
                      },
                      child: const Text("Chọn từ thư viện"),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 35,
                    width: 150,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.lightGreenAccent),
                      ),
                      onPressed: () {
                        _getFromCamera();
                      },
                      child: const Text("Chọn từ camera"),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 35,
                    width: 150,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.greenAccent)),
                      onPressed: () {
                        // final Map<String, dynamic> imgdata = {
                        //   'image': imageFile
                        // };
                        // postData(imgdata);
                        String url =
                            "http://${Constants.ip}:3000/api/users/setavatar/${widget.userModel?.id}";
                        uploadImageHTTP(imageFile, url);
                        WidgetsBinding.instance!.addPostFrameCallback((_) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CustomerListPage(),
                              ));
                        });
                      },
                      child: const Text("Lưu"),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  /// Get from gallery
  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  // Future postData(Map<String, dynamic> body) async {
  //   var dio = Dio();
  //   try {
  //     FormData formData = FormData.fromMap(body);
  //     Response response = await dio.post(url,
  //         data: formData,
  //         options: Options(headers: {
  //           "accept": "*/*",
  //           "Authorization": "Bearer accresstoken",
  //           "Content-Type": "multipart/form-data"
  //         }));
  //     return response.data;
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // // post a image
  //http ok!
  Future<String?> uploadImageHTTP(file, url) async {
    var request = http.MultipartRequest('PATCH', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('image', file.path));
    // request.fields[''] = 'asd';
    var res = await request.send();
    if (res.statusCode == 200) {
      print('Uploaded!');
    }
    return res.reasonPhrase;
  }
  // //dio
  // Future<String?> _upload(File file) async {
  //   // String fileName = file.path.split('/').last;
  //   //
  //   // FormData data = FormData.fromMap({
  //   //   "image": await MultipartFile.fromFile(
  //   //     file.path,
  //   //     filename: fileName,
  //   //   ),
  //   // });
  //   //
  //   Dio dio = new Dio();
  //   //
  //   // dio.post(url, data: data)
  //   //     .then((response) => print(response))
  //   //     .catchError((error) => print(error));
  //   var formData = FormData.fromMap({
  //     // 'name': 'wendux',
  //     // 'age': 25,
  //     'image': await MultipartFile.fromFile(file.path, filename: imageFile!.path),
  //     // 'files': [
  //     //   await MultipartFile.fromFile('./text1.txt', filename: 'text1.txt'),
  //     //   await MultipartFile.fromFile('./text2.txt', filename: 'text2.txt'),
  //     // ]
  //   });
  //   var response = await dio.post(url, data: formData);
  //   dio.post(url, data: formData);
  // }

}
