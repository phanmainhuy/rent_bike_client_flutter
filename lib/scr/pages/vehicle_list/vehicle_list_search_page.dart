import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent_bike/scr/components/search_field.dart';
import 'package:rent_bike/scr/models/vehicle_model.dart';
import 'package:rent_bike/scr/pages/vehicle_list/vehicle_provider.dart';
import 'package:rent_bike/scr/pages/vehicle_registration/vehicle_registration_page.dart';
import 'package:rent_bike/scr/resources/app_color.dart';

class VehicleListSearchPage extends StatelessWidget {
  const VehicleListSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VehicleProvider>(
      create: (context) => VehicleProvider(),
      child: const _VehicleListSearch(),
    );
  }
}

class _VehicleListSearch extends StatefulWidget {
  const _VehicleListSearch({Key? key}) : super(key: key);

  @override
  _VehicleListSearchState createState() => _VehicleListSearchState();
}

class _VehicleListSearchState extends State<_VehicleListSearch> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vehicle List Page"),
        backgroundColor: AppColor.kPrimaryColor,
        actions: [
          IconButton(
            icon: Icon (
              Icons.app_registration,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return VehicleRegistrationPage();
              },
              ),
              );
            },
          ),
        ],
      ),
      body: Form(
        key: context
            .read<VehicleProvider>()
            .formKey,
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
                      controller: context
                          .read<VehicleProvider>()
                          .searchCtr,
                      // controller: ,
                      onSubmit: () =>
                          (_) {
                        context.read<VehicleProvider>().searchVehicle();
                        setState(() {
                          _buildSearchResult;
                        });
                      }, hint: 'Search',
                      onTap: () {  },
                      readOnly: false,
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

  Widget get _buildSearchResult =>
      Selector<VehicleProvider, List<VehicleModel>>(
        shouldRebuild: (v1, v2) => true,
        selector: (context, provider) => provider.lstsearch_vehicle,
        builder: (context, search, _) =>
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 0.0, horizontal: 0.0),
              child: Card(
                elevation: 4.0,
                child: ListView.separated(
                    itemCount: search.length,
                    separatorBuilder: (_, index) => const SizedBox(height: 15),
                    itemBuilder: (_, index) {
                      return ListTile(
                        leading: SizedBox(
                          width: 80,
                          height: 80,
                          child: search[index].image == null
                              ? const Placeholder()
                              : Image.asset(
                            "assets/images/vehicle/${search[index].image ??
                                ''}",
                            width: 130,
                            height: 120,
                          ),
                        ),
                        title: Text(
                          search[index].name ?? '',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              const Icon(Icons.motorcycle),
                              const SizedBox(width: 5,),
                              Text('${search[index].category ?? ''}',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                            ],),

                            Row(children: [
                              const Icon(Icons.wysiwyg),
                              const SizedBox(width: 5,),
                              Text(
                                '${search[index].license_plate ?? ''}',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                            ],),

                            Row(children: [
                              const Icon(Icons.attach_money_sharp),
                              const SizedBox(width: 5,),
                              Text(
                                '${search[index].rent_price ?? ''}/ngày',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400
                                ),
                              )
                            ],),

                            Text(
                              '${search[index].status ?? ''}',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400
                              ),
                            )

                          ],
                        ),
                        trailing: Icon(Icons.navigate_next_rounded),
                      );
                    }
                ),
              ),
            ),
      );

// Widget _buildProgressIndicator() {
//   return new Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: new Center(
//       child: new Opacity(
//         opacity: _isLoading ? 1.0 : 00,
//         child: new CupertinoActivityIndicator(),
//       ),
//     ),
//   );
// }

}