import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent_bike/scr/components/search_field.dart';
import 'package:rent_bike/scr/models/user_model.dart';
import 'package:rent_bike/scr/pages/customer_list/user_provider.dart';
import 'package:rent_bike/scr/pages/edit_customer/edit_customer_page.dart';
import 'package:rent_bike/scr/utils/constants.dart';

class CustomerListSearchPage extends StatelessWidget {
  const CustomerListSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserProvider>(
      create: (context) => UserProvider(),
      child: const _CustomerListSearch(),
    );
  }
}

class _CustomerListSearch extends StatefulWidget {
  const _CustomerListSearch({Key? key}) : super(key: key);

  @override
  _CustomerListSearchState createState() => _CustomerListSearchState();
}

class _CustomerListSearchState extends State<_CustomerListSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Customer"),
        backgroundColor: Colors.green,
      ),
      body: Form(
        key: context.read<UserProvider>().formKey,
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
                      controller: context.read<UserProvider>().searchCtr,
                      // controller: ,

                      onSubmit: () => (_) {
                        context.read<UserProvider>().searchUser();
                        setState(() {
                          _buildSearchResult;
                        });
                      },
                      hint: 'Search user',
                      onTap: () {},
                      onChange: (String value) {
                        context.read<UserProvider>().searchUser();
                      },
                      readOnly: false,
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
              child: _buildSearchResult,
            ),
          ],
        ),
      ),
    );
  }
}

Widget get _buildSearchResult => Selector<UserProvider, List<UserModel>>(
      shouldRebuild: (v1, v2) => true,
      selector: (context, provider) => provider.lstsearch,
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
                        child: search[index].avatar == null
                            ? const Placeholder()
                            : Image.network(
                                "${Constants.urlImage}${search[index].avatar ?? ''}",
                                width: 80,
                              ),
                      ),
                      title: Text(
                        search[index].name ?? '',
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
                              Text('Phone: ${search[index].mobile ?? ''}'),
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
                                  'Email: ${search[index].email ?? ''}',
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
                              Text('CMND: ${search[index].cmnd ?? ''}')
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
                                  builder: (context) => EditCustomerPage(
                                    users: search[index],
                                  ),
                                ));
                          });
                        },
                        icon: const Icon(
                          Icons.navigate_next,
                          // color: Colors.red,
                        ),
                      ),
                    ),
                    onDismissed: (direction) {
                      //show a snackbar.
                      String? x = search[index].name;

                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text('Đã xóa $x')));
                      // Remove the item from the data source.
                      context
                          .read<UserProvider>()
                          .removeUser(search[index].id!);
                      search.removeAt(index);
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
                    secondaryBackground: Container(
                      color: Colors.redAccent,
                      child: const Icon(
                        Icons.clear,
                        color: Colors.white,
                      ),
                    ),
                  )),
        ),
      ),
    );
