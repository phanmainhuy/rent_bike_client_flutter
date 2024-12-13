import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rent_bike/scr/components/search_field.dart';
import 'package:rent_bike/scr/models/rental_model.dart';
import 'package:rent_bike/scr/pages/vehicle_fee_list/vehicle_fee_list_provider.dart';
import 'package:rent_bike/scr/pages/vehicle_rental_registration/vehicle_rental_registration_page.dart';
import 'package:rent_bike/scr/resources/app_color.dart';
import 'package:rent_bike/scr/utils/constants.dart';
import 'package:rent_bike/scr/utils/format.dart';

class VehicleFeeListPage extends StatelessWidget {
  const VehicleFeeListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VehicleFeeListProvider>(
      create: (context) => VehicleFeeListProvider(),
      child: const _VehicleFeeListPage(),
    );
  }
}

class _VehicleFeeListPage extends StatefulWidget {
  const _VehicleFeeListPage({Key? key}) : super(key: key);

  @override
  _VehicleFeeListPageState createState() => _VehicleFeeListPageState();
}

class _VehicleFeeListPageState extends State<_VehicleFeeListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vehicle Fee List"),
        backgroundColor: AppColor.kPrimaryColor,
        actions: [_buildIcon(context)],
      ),
      body: Form(
        key: context.read<VehicleFeeListProvider>().formKey,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: SearchField(
                      controller:
                          context.read<VehicleFeeListProvider>().searchCtr,
                      // controller: ,

                      onSubmit: () => (_) {
                        context.read<VehicleFeeListProvider>().searchRental();
                        setState(() {
                          _buildSearchResult;
                        });
                      },
                      hint: 'Search rental',
                      onTap: () {},

                      readOnly: false,
                      onChange: (String value) {
                        context.read<VehicleFeeListProvider>().searchRental();
                        setState(() {
                          _buildSearchResult;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: _buildSearchResult,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () {
            context.read<VehicleFeeListProvider>().refesh();
          },
        ),
        IconButton(
          icon: const Icon(Icons.add_box_outlined),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const VehicleRentalRegistrationPage()),
            ).then((_) {
              // context.read<HomeProvider>().refreshCart();
            });
          },
        ),
      ],
    );
  }

  Widget get _buildSearchResult =>
      Selector<VehicleFeeListProvider, List<RentalModel>>(
        shouldRebuild: (v1, v2) => true,
        selector: (context, provider) => provider.listSearch,
        builder: (context, search, _) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
          child: Card(
            elevation: 4.0,
            child: ListView.separated(
                itemCount: search.length,
                separatorBuilder: (_, index) => const SizedBox(height: 15),
                itemBuilder: (_, index) => Dismissible(
                      key: UniqueKey(),
                      child: ListTile(
                        leading: SizedBox(
                          width: 80,
                          height: 80,
                          child: search[index].avatarCus == null
                              ? Placeholder()

                              : Image.network(
                                  "${Constants.urlImage}${search[index].avatarCus ?? 'no_image.png'}",
                                  width: 80,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                      'assets/images/others/no_image.png',
                                      width: 80);
                                },
                                ),

                        ),
                        title: Text(
                          search[index].nameCus ?? '',
                          style: const TextStyle(fontSize: 17),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.phone),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text('Phone: ${search[index].phoneCus ?? ''}'),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.verified_user),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                    'Number Register: ${search[index].numbRegister ?? ''}'),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.calendar_today),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Text(
                                    'Date Return: ${Format.dateTimeParse(search[index].returnDate  ?? '')}',
                                    overflow: TextOverflow.clip,
                                    maxLines: 1,
                                    softWrap: false,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.credit_card),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                    'Price: ${Format.moneyFormat(search[index].total!) ?? ''}')
                              ],
                            )
                          ],
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            WidgetsBinding.instance!.addPostFrameCallback((_) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        VehicleRentalRegistrationPage(),
                                  ));
                            });
                          },
                          icon: const Icon(
                            Icons.navigate_next,
                            // color: Colors.red,
                          ),
                        ),
                      ),
                      confirmDismiss: (direction) async {
                        if (direction == DismissDirection.endToStart) {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text(
                                  'Bạn muốn xóa khách hàng ${search[index].nameCus}?'),
                              content: const Text(
                                  'Khi xoá sẽ không hoàn tác lại được'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    String? x = search[index].nameCus;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Đã xóa $x')));
                                    // Remove the item from the data source.
                                    _
                                        .read<VehicleFeeListProvider>()
                                        .deleteRental(search[index].idRental!);
                                    search.removeAt(index);
                                    setState(() {
                                      _buildSearchResult;
                                    });
                                    Navigator.pop(context, 'OK');
                                  },
                                  child: const Text('OK'),
                                ),
                                TextButton(
                                  onPressed: () => {
                                    setState(() {
                                      _buildSearchResult;
                                    }),
                                    Navigator.pop(context, 'Cancel'),
                                  },
                                  child: const Text('Cancel'),
                                ),
                              ],
                            ),
                          );
                        } else {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text(
                                  'Khách hàng ${search[index].nameCus} muốn trả xe?'),
                              content: const Text(
                                  'Vui lòng xác nhận kỹ thông tin và chọn OK để trả xe'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    //handle
                                    String? x = search[index].nameCus;
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                        content: Text('Khách hàng $x đã trả xe thành công')));
                                    // Update state rental
                                    _.read<VehicleFeeListProvider>().returnVehicleRental(
                                        search[index].idRental!, search[index].numbRegister!);
                                    search.removeAt(index);
                                    setState(() {
                                      _buildSearchResult;
                                    });
                                    Navigator.pop(context, 'OK');
                                  },
                                  child: const Text('OK'),
                                ),
                                TextButton(
                                  onPressed: () => {
                                    setState(() {
                                      _buildSearchResult;
                                    }),
                                    Navigator.pop(context, 'Cancel'),
                                  },
                                  child: const Text('Cancel'),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      background: Container(
                        color: Colors.greenAccent,
                        child: Row(
                          children: const [
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.assignment_return_outlined,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Return vehicle',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      secondaryBackground: Container(
                        color: Colors.redAccent,
                        // alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Icon(
                              Icons.clear,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Delete rental',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                          ],
                        ),
                      ),
                    )),
          ),
        ),
      );
  Future<void> checkStatusCode(int status) async {
    String image;
    if (status == 404) {
      image = 'no_image.png';
    }
  }
}
