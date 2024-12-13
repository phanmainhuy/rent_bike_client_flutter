import 'package:flutter/material.dart';
import 'package:rent_bike/scr/components/search_field.dart';
import 'package:provider/provider.dart';
import 'package:rent_bike/scr/models/vehicle_model.dart';
import 'package:rent_bike/scr/pages/vehicle_edit/edit_vehicle_page.dart';
import 'package:rent_bike/scr/pages/vehicle_list/vehicle_list_search_page.dart';
import 'package:rent_bike/scr/pages/vehicle_list/vehicle_provider.dart';
import 'package:rent_bike/scr/pages/vehicle_registration/vehicle_registration_page.dart';
import 'package:rent_bike/scr/resources/app_color.dart';
import 'package:rent_bike/scr/utils/constants.dart';

import 'package:tuple/tuple.dart';

class VehicleListPage1 extends StatelessWidget {
  const VehicleListPage1 ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VehicleProvider>(
      create: (context) => VehicleProvider(),
      child: const _VehicleListPage1(),

    );
  }
}

class _VehicleListPage1 extends StatefulWidget {
  const _VehicleListPage1 ({Key? key}) : super(key: key);

  @override
  _VehicleListPage1State createState() => _VehicleListPage1State();
}

class _VehicleListPage1State extends State<_VehicleListPage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: context.read<RegisterProvider>().scaffoldKey,
      appBar: AppBar(
        title: const Text("Vehicle List"),
        backgroundColor: AppColor.kPrimaryColor,
        actions: [_buildIcon(context)],
      ),
      body: Form(
        // key: context.read<EditCustomerProvider>().formKey,
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
                      // controller: context.read<UserrProvider>().searchCtr,
                      controller: context
                          .read<VehicleProvider>()
                          .searchCtr,

                      onSubmit: () =>
                          (_) {
                        context.read<VehicleProvider>().searchVehicle();


                        WidgetsBinding.instance!.addPostFrameCallback((_) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const VehicleListSearchPage(),
                              ));
                        });
                      }, onTap: () {  }, hint: 'Search',
                      readOnly: true,
                      // onTap: () => (_) {
                      //   // WidgetsBinding.instance!.addPostFrameCallback((ctx) {
                      //   //   Navigator.push(
                      //   //       context,
                      //   //       MaterialPageRoute(
                      //   //         builder: (context) =>
                      //   //         const CustomerListSearchPage(),
                      //   //       ));
                      //   // });
                      //   setState(() {
                      //     _buildCardUser;
                      //   });
                      //
                      // },

                      // onTap: (){},


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

              child: _buildCardUser,
            ),
          ],
        ),
      ),
    );
  }

  Widget get _buildCardUser =>
      Selector<VehicleProvider,
          Tuple2<List<VehicleModel>, bool>>(
          shouldRebuild: (v1, v2) => true,
          selector: (context, provider) =>
              Tuple2(provider.vehicle, provider.isLoadMore),
          builder: (context, value, _) =>
              Padding(
                // padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                padding: EdgeInsets.zero,
                child: Card(
                    elevation: 4.0,
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (info) {
                        if (info.metrics.pixels >=
                            info.metrics.maxScrollExtent) {
                          context.read<VehicleProvider>().onLoadMore();
                        }

                        return false;
                      },
                      child: ListView.separated(
                        itemCount: value.item1.length + (value.item2 ? 1 : 0),
                        separatorBuilder: (_, index) =>
                        const SizedBox(height: 15),
                        itemBuilder: (_, index) {
                          if (index == value.item1.length) {
                            return const Center(
                              child: SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }

                          return Dismissible(
                            key: UniqueKey(),
                            child: ListTile(

                              leading: SizedBox(
                                width: 80,
                                height: 80,
                                child: value.item1[index].image == null
                                    ? const Placeholder()
                                    : Image.network(
                                  "${Constants.urlImage}${value.item1[index]
                                      .image ?? ''}",
                                  width: 80,
                                ),
                              ),

                              title: Text(
                                value.item1[index].name ?? '',
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(children: [
                                    const Icon(Icons.motorcycle),
                                    const SizedBox(width: 5,),
                                    Text('Phone: ${value.item1[index].category ??
                                        ''}'
                                    ),
                                  ],),

                                  Row(children: [
                                    const Icon(Icons.wysiwyg),
                                    const SizedBox(width: 5,),
                                    Expanded(child: Text(
                                      'Email: ${value.item1[index].license_plate ??
                                          ''}',
                                      overflow: TextOverflow.clip, maxLines: 1,
                                      softWrap: false,),)

                                  ],),

                                  Row(children: [
                                    const Icon(Icons.attach_money_sharp),
                                    const SizedBox(width: 5,),
                                    Text('CMND: ${value.item1[index].rent_price ??
                                        ''}/ngày',)
                                  ],),

                                  Text(
                                    '${value.item1[index].status ?? ''}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400
                                    ),
                                  )
                                ],

                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  WidgetsBinding.instance!
                                      .addPostFrameCallback((_) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              EditVehiclePage(
                                                vehicle: value.item1[index],),

                                        ));
                                  });
                                },
                                icon: const Icon(
                                  Icons.navigate_next,
                                  // color: Colors.red,
                                ),
                              ),

                              onTap: () {
                                WidgetsBinding.instance!.addPostFrameCallback((
                                    _) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            EditVehiclePage(
                                              vehicle: value.item1[index],),
                                      ));
                                });
                              },
                            ),
                            onDismissed: (direction) {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) =>
                                    AlertDialog(
                                      title: Text(
                                          'Bạn muốn xóa phương tiện ${value
                                              .item1[index].name}?'),
                                      content: const Text(
                                          'Khi xoá sẽ không hoàn tác lại được'),
                                      actions: <Widget>[

                                        TextButton(
                                          onPressed: () {
                                            String? x = value.item1[index].name;
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                content: Text('Đã xóa $x')));
                                            // Remove the item from the data source.
                                            // _.read<VehicleProvider>().removeUser(
                                            //     value.item1[index].id!);
                                            value.item1.removeAt(index);
                                            setState(() {
                                              _buildCardUser;
                                            });
                                            Navigator.pop(context, 'OK');
                                          },
                                          child: const Text('OK'),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                          {
                                            setState(() {
                                              _buildCardUser;
                                            }),
                                            Navigator.pop(context, 'Cancel'),
                                          },
                                          child: const Text('Cancel'),
                                        ),
                                      ],
                                    ),
                              );
                            },
                            background: Container(
                              color: Colors.redAccent,
                              child: const Icon(
                                // Icons.done,
                                // color: Colors.blueGrey,
                                Icons.clear,
                                color: Colors.white,
                              ),
                            ),
                            secondaryBackground:
                            Container(
                              color: Colors.redAccent,
                              child: const Icon(
                                Icons.clear,
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                      ),
                    )),
              ));

}

Widget _buildIcon(BuildContext context) {
  return Row(
    children: [
      IconButton(
        icon: const Icon(Icons.refresh),
        onPressed: () {
          context.read<VehicleProvider>().refesh();

        },
      ),
      IconButton(
        icon: const Icon(Icons.electric_bike),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const VehicleRegistrationPage()),
          ).then((_) {
            // context.read<HomeProvider>().refreshCart();
          });
        },
      ),

    ],
  );
}