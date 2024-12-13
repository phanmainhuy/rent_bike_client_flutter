

import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rent_bike/scr/components/rounded_input_field.dart';
import 'package:rent_bike/scr/pages/vehicle_list/vehicle_list_page_1.dart';
import 'package:rent_bike/scr/resources/app_color.dart';
import 'package:rent_bike/scr/utils/constants.dart';
import 'vehicle_registration_provider.dart';

class VehicleRegistrationPage extends StatelessWidget {
  const VehicleRegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx){
        final provider = VehicleRegistrationProvider();

        provider.onCreateSuccess = () {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
            builder: (context) {
              return const VehicleListPage1();
            },
          ), (predicate) => predicate.isFirst);
        };

        return provider;
      },
      child: const _VehicleRegistrationPage(),
    );
  }
}
class _VehicleRegistrationPage extends StatefulWidget {
  const _VehicleRegistrationPage({Key? key}) : super(key: key);

  @override
  _VehicleRegistrationPageState createState() => _VehicleRegistrationPageState();
}

class _VehicleRegistrationPageState extends State<_VehicleRegistrationPage> {
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: context.read<VehicleRegistrationProvider>().scaffoldKey,

      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Create Vehicle"),
        backgroundColor: AppColor.kPrimaryColor,
      ),
      body: SafeArea(
        child: Form(
          key: context.read<VehicleRegistrationProvider>().formKey,
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 20),
                IconButton(
                  icon: imageFile == null ? Image.network("${Constants.urlImage}vehicle1.png")
                      :
                  // Image.network("${Constants.urlImage}user2.png" ,width: size.width * 0.25),
                  Image.file(
                    imageFile!,
                    fit: BoxFit.cover,
                  ),

                  iconSize: 150,
                  onPressed: () {
                    _getFromGallery();
                    // WidgetsBinding.instance!.addPostFrameCallback((_) {
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) =>
                    //          // const MyUpload(
                    //          //   userModel: null,
                    //          // ),
                    //         const CustomerListPage(),
                    //       ));
                    //
                    // });
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (_) => const MultiUploadImage()),
                    // )
                    //     .then((_) {
                    //   // context.read<HomeProvider>().UploadImage();
                    // });


                  },
                ),
                const SizedBox(height: 5),
                InkWell(
                  onTap: () {
                    _getFromCamera();
                  },
                  child: const Text("Chọn từ camera"),
                ),
                const SizedBox(height: 5),
                // InkWell(
                //   onTap: () {
                //     _getFromGallery();
                //   },
                //   child: const Text("Chọn từ thư viện"),
                // ),

                Expanded(
                  child: SingleChildScrollView(
                    child: _buildInputEditForm(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

    );

  }
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

  String radioButtonItem = "Còn trống";
  int id=1;

  Widget _buildInputEditForm(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: 40,
          ),

          const Text(
            "Tên phương tiện",
            textAlign: TextAlign.center,
            style: TextStyle(
              // fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Colors.black),
          ),
          const SizedBox(height: 5,),
          SizedBox(
            width: 370,
            child: RoundedInputField(
              icon: Icons.person,
              hintText: "Ví dụ: Honda Vison, Yamaha Sirius,...",
              controller: context.read<VehicleRegistrationProvider>().name,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Phải nhập tên phương tiện';
                }

                if (value.length < 6) {
                  return 'Tên phương tiện phải lớn hơn 6 kí tự';
                }

                return null;
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),

          const Text(
            "Số xe",
            textAlign: TextAlign.center,
            style: TextStyle(
              // fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Colors.black),
          ),
          const SizedBox(height: 5,),

          SizedBox(
            width: 370,
            child: RoundedInputField(
              icon: Icons.wysiwyg,
              hintText: "Ví dụ: 86C174130, 54B277889,...",
              controller: context.read<VehicleRegistrationProvider>().license_plate,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Phải nhập số xe ';
                }

                if ((value.length != 8) ||(value.length != 9)) {
                  return 'Số xe đã nhập không hợp lệ';
                }

                return null;
              },
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          const Text(
            "Loại xe",
            textAlign: TextAlign.center,
            style: TextStyle(
              // fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Colors.black),
          ),
          const SizedBox(height: 5,),

          SizedBox(
            width: 370,
            child: RoundedInputField(
              icon: Icons.motorcycle,
              hintText: "Ví dụ: Xe ga, Xe số, Xe côn",
              controller: context.read<VehicleRegistrationProvider>().category,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Phải nhập loại xe';
                }

                if ((value.length != "Xe ga") || (value.length != "Xe số") || (value.length != "Xe côn") ) {
                  return 'Loại xe không hợp lệ';
                }
                return null;
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(height: 5,),

          const Text(
            "Giá cho thuê",
            textAlign: TextAlign.center,
            style: TextStyle(
              // fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Colors.black),
          ),
          const SizedBox(height: 5,),

          SizedBox(
            width: 370,
            child: RoundedInputField(
              icon: Icons.attach_money_sharp,
              hintText: "Ví dụ: 200000, 190000,...",
              controller: context.read<VehicleRegistrationProvider>().rent_price,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Phải nhập giá thuê';
                }
              return null;
              },
            ),
          ),

          const SizedBox(
            height: 10,
          ),
          const Text(
            "Số đăng kí",
            textAlign: TextAlign.center,
            style: TextStyle(
              // fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Colors.black),
          ),
          const SizedBox(height: 5,),
          SizedBox(
            width: 370,
            child: RoundedInputField(
              icon: Icons.format_list_numbered,
              controller: context.read<VehicleRegistrationProvider>().numb_regist,
              hintText: "Ví dụ: 123,124,...",
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Phải nhập CMND';
                }
                return null;
              },
            ),
          ),

          const SizedBox(
            height: 10,
          ),
          const Text(
            "Số quản lí",
            textAlign: TextAlign.center,
            style: TextStyle(
              // fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Colors.black),
          ),
          const SizedBox(height: 5,),
          SizedBox(
            width: 370,
            child: RoundedInputField(
              icon: Icons.format_list_numbered,
              controller: context.read<VehicleRegistrationProvider>().numb_manage,
              hintText: "Ví dụ: 123,124,...",
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Phải nhập CMND';
                }
                return null;
              },
            ),
          ),

          const SizedBox(
            height: 10,
          ),
          const Text(
            "Trạng thái",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 17,
                color: Colors.black),
          ),
          const SizedBox(height: 5,),
          SizedBox(
            width: 370,
            child:Row (
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Radio(
                  value: 1,
                  groupValue: id,
                  onChanged: (val) {
                    setState(() {
                      radioButtonItem = 'Còn trống';
                      id = 1;
                    });
                  },
                  activeColor: AppColor.kPrimaryColor,
                ),
                Text(
                  'Còn trống',
                  style: new TextStyle(fontSize: 17.0),
                ),

                Radio(
                  value: 2,
                  groupValue: id,
                  onChanged: (val) {
                    setState(() {
                      radioButtonItem = 'Đã thuê';
                      id = 2;
                    });
                  },
                  activeColor: AppColor.kPrimaryColor,
                ),
                Text(
                  'Đã thuê',
                  style: new TextStyle(
                    fontSize: 17.0,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 10,
          ),
          const Text(
            "Màu xe",
            textAlign: TextAlign.center,
            style: TextStyle(
              // fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Colors.black),
          ),
          const SizedBox(height: 5,),
          SizedBox(
            width: 370,
            child: RoundedInputField(
              icon: Icons.apps,
              controller: context.read<VehicleRegistrationProvider>().color,
              hintText: "Ví dụ: Xanh- Trắng, Xám- Đen,...",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Phải nhập màu xe';
                }
                return null;
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Giá xe",
            textAlign: TextAlign.center,
            style: TextStyle(
              // fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Colors.black),
          ),
          const SizedBox(height: 5,),
          SizedBox(
            width: 370,
            child: RoundedInputField(
              icon: Icons.attach_money_sharp,
              controller: context.read<VehicleRegistrationProvider>().price,
              hintText: "Ví dụ: 17000000, 49000000,...",
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Phải nhập giá trị xe';
                }

                return null;
              },
            ),
          ),
          const SizedBox(
            width: 370,
            // child:
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            width: 370,
            height: 50,
            child: ElevatedButton(
              child: Text("Tạo phương tiện ".toUpperCase(),
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold,)),
              style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(15)),
                  foregroundColor:
                  MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor:
                  MaterialStateProperty.all<Color>(AppColor.kPrimaryColor,),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(19.0),
                          side: const BorderSide(color: Colors.black)))),
              onPressed: () {

                if(imageFile == null){
                  context.read<VehicleRegistrationProvider>().onSubmitNoFile();
                }
                else{
                  context.read<VehicleRegistrationProvider>().onSubmit(imageFile);
                }
                Navigator.pop(
                    context,
                    MaterialPageRoute(
                    builder: (context) {
                  return const VehicleListPage1();
                },
                ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 370,
            height: 50,
            child: ElevatedButton(
              child: Text("Hủy bỏ".toUpperCase(),
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold,)),
              style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(15)),
                  foregroundColor:
                  MaterialStateProperty.all<Color>(Colors.black),
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(19.0),
                          side: const BorderSide(color: Colors.black)))),
              onPressed: () {
                Navigator.pop(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const VehicleListPage1();
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
        ]
    );
  }
}

