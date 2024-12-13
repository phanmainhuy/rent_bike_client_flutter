import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:rent_bike/scr/components/rounded_calendar_input_field.dart';
import 'package:rent_bike/scr/components/rounded_input_field.dart';
import 'package:rent_bike/scr/models/user_model.dart';
import 'package:rent_bike/scr/pages/create_customer/upload_image.dart';
import 'package:rent_bike/scr/pages/customer_list/customer_list_page.dart';
import 'package:rent_bike/scr/pages/edit_customer/edit_customer_provider.dart';
import 'package:rent_bike/scr/resources/app_color.dart';
import 'package:rent_bike/scr/utils/constants.dart';
import 'package:http/http.dart' as http;

class EditCustomerPage extends StatelessWidget {
  final UserModel ?users;
  const EditCustomerPage({Key? key,  required this.users
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditCustomerProvider>(
        create: (ctx){

          final provider = EditCustomerProvider(users!.id ?? 1);


          provider.onEditSuccess = () {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
              builder: (context) {
                return const CustomerListPage();
              },
            ), (predicate) => predicate.isFirst);
          };

          return provider;
        },

        child: _EditCustomerPage(user: users!,));
  }
}


class _EditCustomerPage extends StatefulWidget {
  UserModel ?user;
   _EditCustomerPage({Key? key, required this.user}) : super(key: key);

  @override
  State<_EditCustomerPage> createState() => _EditCustomerPageState();
}

class _EditCustomerPageState extends State<_EditCustomerPage> {

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Edit Customer ${widget.user!.name ?? ''}'),
        backgroundColor: AppColor.kPrimaryColor,

      ),
      key: context.read<EditCustomerProvider>().formKey,
      body: SafeArea(
        child: Form(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 5),
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
  Widget _buildEditForm(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            // AppDrawable.user(width: size.width * 0.25),

              IconButton(
                icon:  widget.user?.avatar == null ?  const Placeholder()
                  : Image.network(
                "${Constants.urlImage}${widget.user!.avatar ?? ''}",
                width: 150,
              ),
                iconSize: 150,
                onPressed: () {
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                         MyUpload(
                          userModel: widget.user,
                        ),
                      ));
                });
              },

              ),

          ],
        ),
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
        String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
        context.read<EditCustomerProvider>().birthdayCtr.text = formattedDate;
      });
    }
  }
  Widget _buildInputEditForm(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          const SizedBox(
            height: 30,
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
              controller: context.read<EditCustomerProvider>().nameCtr,
              icon: Icons.person,
              hintText: "Họ và tên",
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
            child: RoundedCalendarInputField(
              icon: Icons.calendar_today,
              hintText: "Ngày sinh",
              controller: context.read<EditCustomerProvider>().birthdayCtr,

              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng chọn ngày sinh';
                }
                return null;
              },
              onTap: () {
                _selectDate(context);
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
              controller: context.read<EditCustomerProvider>().addressCtr,
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
              controller: context.read<EditCustomerProvider>().phoneCtr,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Phải nhập so dien thoai';
                }

                if (value.length < 6) {
                  return 'so dien thoai phải lớn hơn 10 kí tự';
                }

                return null;
              },
            ),
          ),
          // const SizedBox(
          //   height: 10,
          // ),
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
              controller: context.read<EditCustomerProvider>().emailCtr,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Phải nhập Email';
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
              icon: Icons.message,
              hintText: "CMND",
              controller: context.read<EditCustomerProvider>().cmndCtr,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Phải nhập CMND';
                }

                if (value.length != 6 || value.length != 12) {
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
              child: Text("Sửa thông tin".toUpperCase(),
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
                context.read<EditCustomerProvider>().onSubmit(widget.user!.id ?? 1);

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
                      MaterialStateProperty.all<Color>(Colors.orangeAccent),
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
          const SizedBox(
            height: 50,
          ),
        ]);
  }


}
