import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rent_bike/scr/components/rounded_calendar_input_field.dart';
import 'package:rent_bike/scr/components/rounded_click_field.dart';
import 'package:rent_bike/scr/components/rounded_input_field.dart';
import 'package:rent_bike/scr/components/rounded_input_field_tap.dart';
import 'package:rent_bike/scr/models/vehicle_model.dart';
import 'package:rent_bike/scr/pages/vehicle_fee_list/vehicle_fee_list_page.dart';
import 'package:rent_bike/scr/pages/vehicle_rental_registration/rental_registration_provider.dart';
import 'package:rent_bike/scr/resources/app_color.dart';
import 'package:rent_bike/scr/utils/validator.dart';

import '../../utils/format.dart';

class VehicleRentalRegistrationPage extends StatelessWidget {
  const VehicleRentalRegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) {
        final provider = RentalRegistrationProvider();

        provider.onCreateSuccess = () {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
            builder: (context) {
              return const VehicleFeeListPage();
            },
          ), (predicate) => predicate.isFirst);
        };

        return provider;
      },
      child: const _VehicleRentalRegistrationPage(),
    );
  }
}

class _VehicleRentalRegistrationPage extends StatefulWidget {
  const _VehicleRentalRegistrationPage({Key? key}) : super(key: key);

  @override
  _VehicleRentalRegistrationPageState createState() =>
      _VehicleRentalRegistrationPageState();
}

class _VehicleRentalRegistrationPageState
    extends State<_VehicleRentalRegistrationPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: context.read<RentalRegistrationProvider>().scaffoldKey,
      appBar: AppBar(
        backgroundColor: AppColor.kPrimaryColor,
        title: const Text("Vehicle Rental Registration"),
      ),
      body: Form(
        key: context.read<RentalRegistrationProvider>().formKey,
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  child: _buildForm(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DateTime? ngaymuon;

  _selectRentDate(BuildContext context) async {
    DateTime now = DateTime.now();
    int firstYear = now.year + 100;
    DateTime lastYear = now;
    DateTime selectedDate = now;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: lastYear,
      lastDate: DateTime(firstYear),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        ngaymuon = picked;
        String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
        context.read<RentalRegistrationProvider>().rentDate.text =
            formattedDate;
        context.read<RentalRegistrationProvider>().returnDate.text = '';
      });
    }
  }

  _selectReturnDate(BuildContext context) async {
    DateTime now = DateTime.now();
    int firstYear = now.year + 100; //cuối
    // DateTime rent = DateFormat("yyyy-MM-dd").parse(context.read<RentalRegistrationProvider>().rentDate.text);
    // var inputRent = DateTime.parse(rent.toString());
    // DateTime lastYear = inputRent;//đầu
    DateTime selectedDate = ngaymuon!;
    DateTime lastYear = ngaymuon!;
    // print(lastYear);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: lastYear,
      lastDate: DateTime(firstYear),
    );
    if (picked == selectedDate && picked != null) {
      selectedDate = picked;
      String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      context.read<RentalRegistrationProvider>().returnDate.text = formattedDate;
      context.read<RentalRegistrationProvider>().daysLeft.text = '1 ngày';

    }
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
        context.read<RentalRegistrationProvider>().returnDate.text = formattedDate;
        // int rt = picked.day;
        // int r = ngaymuon!.day;
        // int dayLeft = rt - r;
        // print('ngay con lai: $dayLeft');
        // context.read<RentalRegistrationProvider>().daysLeft.text = '$dayLeft ngày';
        int dayLeft = Format.daysBetween(ngaymuon!, picked) +1;
        context.read<RentalRegistrationProvider>().dayLeft = dayLeft;
        context.read<RentalRegistrationProvider>().daysLeft.text = '$dayLeft ngày';
      });
    }
  }

  Widget _buildForm(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildInputForm(context),
      ],
    );
  }

  Widget _buildInputForm(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Số xe",
            textAlign: TextAlign.center,
            style: TextStyle(
                // fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.black),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            width: 370,
            // child: DropdownSearch<VehicleModel>(
            //     // popupProps: PopupProps.menu(
            //     //   showSelectedItems: true,
            //     //   disabledItemFn: (String s) => s.startsWith('I'),
            //     // ),
            //     showSearchBox: true,
            //     mode: Mode.MENU,
            //     dropdownSearchDecoration: InputDecoration(
            //       focusColor: Colors.black,
            //       labelText: "Số xe",
            //       hintText: "Vui lòng chọn số xe",
            //     ),
            //   // asyncItems: context.read<RentalRegistrationProvider>().vehicle[index].name,
            //
            //     onChanged: print,
            //   //   selectedItem: ,
            //   // validator: (String? item) {
            //   //   if (item == null)
            //   //     return "Required field";
            //   //   else if (item == "Brazil")
            //   //     return "Invalid item";
            //   //   else
            //   //     return null;
            //   // },
            //   ),
            //
            //
            // ),
            child: RoundedInputFieldTap(
              icon: Icons.motorcycle_sharp,
              hintText: "Số xe",
              controller: context.read<RentalRegistrationProvider>().numbBike,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Phải nhập số xe';
                }

                if (value.length < 6) {
                  return 'Số xe phải lớn hơn 6 kí tự';
                }

                return null;
              },
              onSubmit: (String value) {
                if(value.length <= 0){
                  return;
                }
                if (value.length > 0)
                  {
                    context.read<RentalRegistrationProvider>().getVehicleByNumber();
                    // context.read<RentalRegistrationProvider>().rentPrice.text = 's';
                  }
              },
              onChange: (value) {
                Future.delayed(const Duration(seconds: 1));
                  context.read<RentalRegistrationProvider>().getVehicleByNumber();
                  // context.read<RentalRegistrationProvider>().nameBike.text =
                  // 'no data';
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Tên xe",
            textAlign: TextAlign.center,
            style: TextStyle(
                // fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.black),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            width: 370,
            child: RoundedClickField(
              icon: Icons.motorcycle_sharp,
              hintText: "Tên xe",
              controller: context.read<RentalRegistrationProvider>().nameBike,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Phải nhập số xe';
                }

                if (value.length < 6) {
                  return 'Số xe phải lớn hơn 6 kí tự';
                }
                if (value == 'Xe đã được cho thuê'){
                  return 'Xe đã được cho thuê';
                }
                if (value == 'Xe đang được sửa chữa')
                {
                  return 'Xe đang được sửa chữa';
                }
                return null;
              },
              readOnly: true,
              color: AppColor.kFontColor,
            ),
          ),
          const SizedBox(
            height: 20,
          ),

          const Text(
            "Số điện thoại khách hàng",
            textAlign: TextAlign.center,
            style: TextStyle(
                // fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.black),
          ),
          const SizedBox(
            height: 5,
          ),

          SizedBox(
            width: 370,
            child: RoundedInputFieldTap(
              icon: Icons.phone,
              hintText: "Số điện thoại",
              length: 10,
              controller: context.read<RentalRegistrationProvider>().numbCus,
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
              onChange: (value) {
                Future.delayed(const Duration(seconds: 1));
                if (value.length == 10) {
                  context.read<RentalRegistrationProvider>().getUserByMobile();
                } else {
                  Future.delayed(const Duration(seconds: 5));
                  context.read<RentalRegistrationProvider>().nameCus.text =
                  'no data';
                }
              },
              onSubmit: (value) {
                if (value.length == 10) {
                  context.read<RentalRegistrationProvider>().getUserByMobile();
                } else {
                  context.read<RentalRegistrationProvider>().nameCus.text =
                      'no data';
                }
              },
            ),
          ),
          // const SizedBox(
          //   height: 20,
          // ),

          const Text(
            "Tên khách hàng",
            textAlign: TextAlign.center,
            style: TextStyle(
                // fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.black),
          ),
          const SizedBox(
            height: 5,
          ),

          SizedBox(
            width: 370,
            child: RoundedClickField(
              icon: Icons.account_circle,
              color: AppColor.kFontColor,
              readOnly: true,
              hintText: "Tên khách hàng",
              controller: context.read<RentalRegistrationProvider>().nameCus,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Chưa có tên khách hàng';
                }
                if (value == 'Không tìm thấy người dùng'){
                  return 'Không tìm thấy người dùng';
                }
                if (value == 'no data'){
                  return 'Không tìm thấy người dùng';
                }
                return null;
              },
            ),
          ),

          const SizedBox(
            height: 20,
          ),

          SizedBox(
            width: 370,
            child: Row(
              children: [
                SizedBox(
                  width: 220,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Giá cho thuê",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      RoundedClickField(
                        icon: Icons.attach_money,
                        color: AppColor.kFontColor,
                        readOnly: true,
                        hintText: 'Giá thuê',
                        controller: context
                            .read<RentalRegistrationProvider>()
                            .rentPrice,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng chọn xe';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 140,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Số ngày thuê",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                // fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      RoundedClickField(
                        hintText: "Ngày",
                        controller:
                            context.read<RentalRegistrationProvider>().daysLeft,
                        keyboardType: TextInputType.phone,
                        icon: Icons.access_time_outlined,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng chọn ngày thuê';
                          }
                          return null;
                        },
                        readOnly: true,
                        color: AppColor.kFontColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 20,
          ),
          const Text(
            "Ngày thuê",
            textAlign: TextAlign.center,
            style: TextStyle(
                // fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.black),
          ),
          const SizedBox(
            height: 5,
          ),

          SizedBox(
            width: 370,
            child: RoundedCalendarInputField(
              icon: Icons.calendar_today,
              hintText: "yyyy-mm-dd",
              controller: context.read<RentalRegistrationProvider>().rentDate,
              keyboardType: TextInputType.number,
              onTap: () {
                _selectRentDate(context);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng chọn ngày thuê';
                }
                return null;
              },
              onChange: (String value) {
                // _selectRentDate(context);
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),

          const Text(
            "Ngày trả",
            textAlign: TextAlign.center,
            style: TextStyle(
                // fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.black),
          ),
          const SizedBox(
            height: 5,
          ),

          //return date
          SizedBox(
            width: 370,
            child: RoundedCalendarInputField(
              icon: Icons.calendar_today,
              hintText: "yyyy-mm-dd",
              controller: context.read<RentalRegistrationProvider>().returnDate,
              keyboardType: TextInputType.number,
              onTap: () {
                _selectReturnDate(context);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng chọn ngày trả';
                }
                return null;
              },
              onChange: (String value) {
                _selectReturnDate(context);
              },
            ),
          ),

          // const SizedBox(
          //   width: 370,
          // ),
          const SizedBox(
            height: 30,
          ),

          SizedBox(
            width: 370,
            height: 50,
            child: ElevatedButton(
              child: Text("Thuê xe".toUpperCase(),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  )),
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
                context.read<RentalRegistrationProvider>().onSubmitRental();
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
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  )),
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
                      return const VehicleFeeListPage();
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
