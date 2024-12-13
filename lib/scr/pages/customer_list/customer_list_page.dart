import 'package:flutter/material.dart';
import 'package:rent_bike/scr/components/search_field.dart';
import 'package:provider/provider.dart';
import 'package:rent_bike/scr/models/user_model.dart';
import 'package:rent_bike/scr/pages/create_customer/create_customer_page.dart';
import 'package:rent_bike/scr/pages/customer_list/customer_search_page.dart';
import 'package:rent_bike/scr/pages/customer_list/user_provider.dart';
import 'package:rent_bike/scr/pages/edit_customer/edit_customer_page.dart';
import 'package:rent_bike/scr/resources/app_color.dart';
import 'package:rent_bike/scr/utils/constants.dart';
import 'package:tuple/tuple.dart';

class CustomerListPage extends StatelessWidget {
  const CustomerListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserProvider>(
      create: (context) => UserProvider(),
      child: const _CustomerListPage(),
    );
  }
}

class _CustomerListPage extends StatefulWidget {
  const _CustomerListPage({Key? key}) : super(key: key);

  @override
  _CustomerListPageState createState() => _CustomerListPageState();
}

class _CustomerListPageState extends State<_CustomerListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: context.read<RegisterProvider>().scaffoldKey,
      appBar: AppBar(
        title: const Text("Customer List"),
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
                      controller: context.read<UserProvider>().searchCtr,

                      onSubmit: () => (_) {
                        // context.read<UserProvider>().searchUser();
                        //
                        //
                        // WidgetsBinding.instance!.addPostFrameCallback((_) {
                        //   Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (context) =>
                        //         const CustomerListSearchPage(),
                        //       ));
                        // });
                      },
                      onTap: () {
                        context.read<UserProvider>().searchUser();
                        WidgetsBinding.instance!.addPostFrameCallback((_) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const CustomerListSearchPage(),
                              ));
                        });
                      },
                      hint: 'Search user',
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

  Widget get _buildCardUser => Selector<UserProvider,
          Tuple2<List<UserModel>, bool>>(
      shouldRebuild: (v1, v2) => true,
      selector: (context, provider) =>
          Tuple2(provider.users, provider.isLoadMore),
      builder: (context, value, _) => Padding(
            // padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
            padding: EdgeInsets.zero,
            child: Card(
                elevation: 4.0,
                child: NotificationListener<ScrollNotification>(
                  onNotification: (info) {
                    if (info.metrics.pixels >= info.metrics.maxScrollExtent) {
                      context.read<UserProvider>().onLoadMore();
                    }

                    return false;
                  },
                  child: ListView.separated(
                    itemCount: value.item1.length + (value.item2 ? 1 : 0),
                    separatorBuilder: (_, index) => const SizedBox(height: 15),
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
                            child: value.item1[index].avatar == null
                                ? const Placeholder()
                                : Image.network(
                                    "${Constants.urlImage}${value.item1[index].avatar ?? ''}",
                                    width: 80,
                                  ),
                          ),
                          title: Text(
                            value.item1[index].name ?? '',
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
                                  Text(
                                      'Phone: ${value.item1[index].mobile ?? ''}'),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.email),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Email: ${value.item1[index].email ?? ''}',
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
                                  Text('CMND: ${value.item1[index].cmnd ?? ''}')
                                ],
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
                                      builder: (context) => EditCustomerPage(
                                        users: value.item1[index],
                                      ),
                                    ));
                              });
                            },
                            icon: const Icon(
                              Icons.navigate_next,
                              // color: Colors.red,
                            ),
                          ),
                          onTap: () {
                            WidgetsBinding.instance!.addPostFrameCallback((_) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditCustomerPage(
                                      users: value.item1[index],
                                    ),
                                  ));
                            });
                          },
                        ),
                        onDismissed: (direction) {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text(
                                  'Bạn muốn xóa khách hàng ${value.item1[index].name}?'),
                              content: const Text(
                                  'Khi xoá sẽ không hoàn tác lại được'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    String? x = value.item1[index].name;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Đã xóa $x')));
                                    // Remove the item from the data source.
                                    _
                                        .read<UserProvider>()
                                        .removeUser(value.item1[index].id!);
                                    value.item1.removeAt(index);
                                    setState(() {
                                      _buildCardUser;
                                    });
                                    Navigator.pop(context, 'OK');
                                  },
                                  child: const Text('OK'),
                                ),
                                TextButton(
                                  onPressed: () => {
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
                          color: Colors.blue,
                          child: const Icon(
                            Icons.done,
                            color: Colors.white,
                          ),
                        ),
                        secondaryBackground: Container(
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

// Widget get _search => Selector<UserProvider, List<UserModel>>(
//     shouldRebuild: (v1, v2) => true,
//     selector: (context, provider) => provider.search,
//     builder: (context, search, _)=> ,
//
//
// );

Widget _buildIcon(BuildContext context) {
  return Row(
    children: [
      IconButton(
        icon: const Icon(Icons.refresh),
        onPressed: () {
          context.read<UserProvider>().refesh();
        },
      ),
      IconButton(
        icon: const Icon(Icons.person_add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CreateCustomerPage()),
          ).then((_) {
            // context.read<HomeProvider>().refreshCart();
          });
        },
      ),
    ],
  );
}
//
// Widget get _buildCheckOutTile =>
//     Selector<UserProvider, bool>(
//       selector: (context, provider) => provider.checkoutColor,
//       builder: (context, checkoutColor, _) =>
//           ListTile(
//             selected: checkoutColor,
//             onTap: () {
//               // context.read<UserProvider>().selectCheckOutTile();
//               Navigator.of(context)
//                   .push(MaterialPageRoute(
//                   builder: (ctx) => const CreateCustomerPage()))
//                   .then((_) {
//                 // context.read<UserProvider>().refreshCart();
//               });
//             },
//             leading: const Icon(Icons.person_add),
//             title: const Text("Create Customer"),
//           ),
//     );