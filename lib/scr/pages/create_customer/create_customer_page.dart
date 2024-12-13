
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rent_bike/scr/components/rounded_calendar_input_field.dart';
import 'package:rent_bike/scr/components/rounded_input_field.dart';
import 'package:rent_bike/scr/pages/create_customer/create_customer_provider.dart';
import 'package:rent_bike/scr/pages/create_customer/upload_image.dart';
import 'package:rent_bike/scr/pages/customer_list/customer_list_page.dart';
import 'package:rent_bike/scr/resources/app_color.dart';
import 'package:rent_bike/scr/resources/app_drawable.dart';
import 'package:rent_bike/scr/utils/constants.dart';
import 'package:rent_bike/scr/utils/validator.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

class CreateCustomerPage extends StatelessWidget {
  const CreateCustomerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (ctx){
          final provider = CreateCustomerProvider();

          provider.onCreateSuccess = () {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
              builder: (context) {
                return const CustomerListPage();
              },
            ), (predicate) => predicate.isFirst);
          };

          return provider;
        },
        child: const _CreateCustomerPage(),
    );
  }
}




class _CreateCustomerPage extends StatefulWidget {
  const _CreateCustomerPage({Key? key}) : super(key: key);

  @override
  _CreateCustomerPageState createState() => _CreateCustomerPageState();
}

class _CreateCustomerPageState extends State<_CreateCustomerPage> {
  File? imageFile;



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: context.read<CreateCustomerProvider>().scaffoldKey,

      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Create Customer"),
        backgroundColor: AppColor.kPrimaryColor,

      ),
      body: SafeArea(
        child: Form(
          key: context.read<CreateCustomerProvider>().formKey,
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 20),
                IconButton(
                  icon: imageFile == null ? Image.network("${Constants.urlImage}user1.png")
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
                    child: _buildEditForm(context),
                  ),
                ),
              ],
            ),
          ),
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
  Widget _buildEditForm(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildInputEditForm(context),
      ],
    );
  }

  _selectDate(BuildContext context) async {
    DateTime now = DateTime.now();
    int firstYear = now.year - 100;
    int lastYear = now.year - 18;
    DateTime selectedDate = DateTime(lastYear);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(firstYear),
      lastDate: DateTime(lastYear),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        String formattedDate = DateFormat('dd-MM-yyyy').format(picked);
        context.read<CreateCustomerProvider>().birthday.text = formattedDate;
      });
    }
  }


  Widget _buildInputEditForm(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Họ và tên khách hàng",
            textAlign: TextAlign.center,
            style: TextStyle(
              // fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.black),
          ),
          const SizedBox(height: 5,),
          SizedBox(
            width: 370,
            child: RoundedInputField(
              icon: Icons.person,
              hintText: "Họ và tên",
              controller: context.read<CreateCustomerProvider>().name,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Phải nhập họ và tên';
                }

                if (value.length < 6) {
                  return 'Họ và tên phải lớn hơn 6 kí tự';
                }

                return null;
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),

          const Text(
            "Ngày sinh",
            textAlign: TextAlign.center,
            style: TextStyle(
              // fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.black),
          ),
          const SizedBox(height: 5,),


          SizedBox(
            width: 370,
            child:
                 RoundedCalendarInputField(
                   icon: Icons.calendar_today,
                   hintText: "yyyy-mm-dd",
                   controller: context.read<CreateCustomerProvider>().birthday,
                   keyboardType: TextInputType.number,
                   onTap: () {
                     _selectDate(context);
                   },
                   validator: (value) {
                     if (value == null || value.isEmpty) {
                       return 'Vui lòng chọn ngày sinh';
                     }
                     return null;
                   },
                   onChange: (String value) {
                     _selectDate(context);
                 },
                 ),

          ),
          const SizedBox(
            height: 10,
          ),

          const Text(
            "Địa chỉ",
            textAlign: TextAlign.center,
            style: TextStyle(
              // fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.black),
          ),
          const SizedBox(height: 5,),

          SizedBox(
            width: 370,
            child: RoundedInputField(
              icon: Icons.location_on,
              hintText: "Địa chỉ",
              controller: context.read<CreateCustomerProvider>().address,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Phải nhập địa chỉ';
                }

                if (value.length < 7) {
                  return 'Địa chỉ phải lớn hơn 7 kí tự';
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
            "Số điện thoại",
            textAlign: TextAlign.center,
            style: TextStyle(
              // fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.black),
          ),
          const SizedBox(height: 5,),

          SizedBox(
            width: 370,
            child: RoundedInputField(
              icon: Icons.phone,
              length: 10,
              hintText: "Số điện thoại",
              controller: context.read<CreateCustomerProvider>().phone,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Phải nhập Số điện thoại';
                }

                if (value.length != 10) {
                  return 'Số điện thoại phải 10 kí tự';
                }

                return null;
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Email",
            textAlign: TextAlign.center,
            style: TextStyle(
              // fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.black),
          ),
          const SizedBox(height: 5,),

          SizedBox(
            width: 370,
            child: RoundedInputField(
              icon: Icons.email,
              hintText: "Email",
              controller: context.read<CreateCustomerProvider>().email,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Phải nhập Email';
                }
                if (!Validator.email(value)) {
                  return 'Địa chỉ email sai định dạng';
                }
                if (value.length < 6) {
                  return 'Email phải lớn hơn 6 kí tự';
                }

                return null;
              },
            ),
          ),

          const SizedBox(
            height: 10,
          ),
          const Text(
            "CMND",
            textAlign: TextAlign.center,
            style: TextStyle(
              // fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.black),
          ),
          const SizedBox(height: 5,),
          SizedBox(
            width: 370,
            child: RoundedInputField(
              icon: Icons.credit_card,
              controller: context.read<CreateCustomerProvider>().cmnd,
              hintText: "CMND",
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Phải nhập CMND';
                }

                if (value.length != 9 && value.length != 12) {
                  return 'CMND phải bằng 9 hoặc 12 kí tự';
                }

                return null;
              },
            ),
          ),
          // const SizedBox(height: 10,),
          // const Text(
          //   "Giới tính",
          //   textAlign: TextAlign.center,
          //   style: TextStyle(
          //     // fontWeight: FontWeight.bold,
          //       fontSize: 15,
          //       color: Colors.black),
          // ),
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
              child: Text("Tạo khách hàng".toUpperCase(),
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold,)),
              style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(15)),
                  foregroundColor:
                  MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor:
                  MaterialStateProperty.all<Color>(AppColor.kPrimaryColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(19.0),
                          side: const BorderSide(color: Colors.black)))),
              onPressed: () {
                  if(imageFile == null){
                    context.read<CreateCustomerProvider>().onSubmitNoFile();
                  }
                  else{
                    context.read<CreateCustomerProvider>().onSubmit(imageFile);
                  }
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
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold,)),
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
                      return const CustomerListPage();
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),

        ]);
  }


}
