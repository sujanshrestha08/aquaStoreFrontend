import 'dart:async';

import 'package:aqua_store/admin/search_page.dart';
import 'package:aqua_store/admin/view_my_order.dart';
import 'package:aqua_store/model/product.dart';
import 'package:aqua_store/screen/contactus.dart';
import 'package:aqua_store/screen/faq.dart';
import 'package:aqua_store/screen/login_screen.dart';
import 'package:aqua_store/screen/productuserdetail.dart';
import 'package:aqua_store/screen/searchuserpage.dart';
import 'package:aqua_store/services/product_service.dart';
import 'package:aqua_store/utils/configs.dart';
import 'package:aqua_store/utils/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:sensors_plus/sensors_plus.dart';

import 'aboutus.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<double>? _accelerometerValues;

  final _streamSubscriptions = <StreamSubscription<dynamic>>[];

  @override
  void initState() {
    super.initState();
    Provider.of<MyProduct>(context, listen: false).getproduct(context);

    _streamSubscriptions.add(
      accelerometerEvents.listen(
        (AccelerometerEvent event) {
          setState(() {
            _accelerometerValues = <double>[event.x, event.y, event.z];

            print(_accelerometerValues);

            if (event.x >= 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchUserPage()),
              );
            }
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  late List<ProductElement>? products;
  String query = '';
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final accelerometer =
        _accelerometerValues?.map((double v) => v.toStringAsFixed(1)).toList();
    return Scaffold(
      // bottomNavigationBar: BottomAppBar(
      //   // color: Colors.transparent,
      //   child: Container(
      //     height: 30.0,
      //   ),
      // ),
      // floatingActionButton: FloatingActionButton.extended(
      //   elevation: 5,
      //   icon: const Icon(Icons.add),
      //   label: const Text('Add Product'),
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => AddProductUi()),
      //     );
      //   },
      //   backgroundColor: Colors.green[800],
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      drawer: Drawer(
        child: ListView(
          shrinkWrap: true,
          children: [
            DrawerHeader(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/welcome.jpg'))),
                child: Stack(children: const [
                  Positioned(
                    bottom: 12.0,
                    left: 16.0,
                    child: Text(
                      "Welcome To Aqua Store",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ])

                // child: CircleAvatar(
                //   backgroundColor: Colors.grey,
                //   radius: 200,
                //   child: Container(
                //     decoration: BoxDecoration(
                //       shape: BoxShape.circle,
                //       color: Colors.grey,
                //       border: Border.all(
                //           color: const Color(0xfff06127),
                //           style: BorderStyle.solid),
                //       image: DecorationImage(
                //         fit: BoxFit.cover,
                //       image: details.userModel.data?.avatarImageUrl != null
                //           ? NetworkImage(details.userModel.data?.avatarImageUrl)
                //           : const AssetImage('assets/icons/neesumLogo.png')
                //               as ImageProvider,
                //       ),
                //     ),
                //   ),
                // ),
                ),
            // TextButton(
            //   style: TextButton.styleFrom(
            //     // backgroundColor: const Color(0xfff06127),
            //     padding: const EdgeInsets.all(10),
            //     primary: Colors.white,
            //     textStyle: const TextStyle(fontSize: 15),
            //   ),
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (BuildContext context) => ViewAdminOrders()),
            //     );
            //   },
            //   child: const Text(
            //     "View All Orders",
            //     style: TextStyle(color: Colors.black),
            //   ),
            // ),
            // const Divider(),
            Divider(
              color: Colors.green.shade900,
              thickness: 1,
            ),
            TextButton(
              style: TextButton.styleFrom(
                // backgroundColor: const Color(0xfff06127),
                padding: const EdgeInsets.all(10),
                primary: Colors.white,
                textStyle: const TextStyle(fontSize: 15),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => ViewMyOrder()),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.remove_red_eye_outlined,
                    color: Colors.green[800],
                  ),
                  Text(
                    "View My Order",
                    style: TextStyle(
                      color: Colors.green[900],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.green.shade900,
              thickness: 1,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 18),
              color: Colors.white,
              child: TextButton(
                style: TextButton.styleFrom(
                  // backgroundColor: const Color(0xfff06127),
                  padding: const EdgeInsets.all(10),
                  primary: Colors.white,
                  textStyle: const TextStyle(fontSize: 15),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => AboutUs()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.remove_red_eye_sharp,
                      color: Colors.greenAccent[700],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "About Us",
                      style: TextStyle(
                          color: Colors.green[900],
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.green.shade900,
              thickness: 1,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 18),
              color: Colors.white,
              child: TextButton(
                style: TextButton.styleFrom(
                  // backgroundColor: const Color(0xfff06127),
                  padding: const EdgeInsets.all(10),
                  primary: Colors.white,
                  textStyle: const TextStyle(fontSize: 15),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => ContactUs()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.contact_mail_outlined,
                      color: Colors.greenAccent[700],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Contact Us",
                      style: TextStyle(
                          color: Colors.green[900],
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.green.shade900,
              thickness: 1,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 18),
              color: Colors.white,
              child: TextButton(
                style: TextButton.styleFrom(
                  // backgroundColor: const Color(0xfff06127),
                  padding: const EdgeInsets.all(10),
                  primary: Colors.white,
                  textStyle: const TextStyle(fontSize: 15),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (BuildContext context) => FAQ()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.repeat_one,
                      color: Colors.greenAccent[700],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "FAQs",
                      style: TextStyle(
                          color: Colors.green[900],
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            // TextButton(
            //   style: TextButton.styleFrom(
            //     // backgroundColor: const Color(0xfff06127),
            //     padding: const EdgeInsets.all(10),
            //     primary: Colors.white,
            //     textStyle: const TextStyle(fontSize: 15),
            //   ),
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (BuildContext context) => ViewMyOrder()),
            //     );
            //   },
            //   child: Text(
            //     "View My Order",
            //     style: TextStyle(
            //       color: Colors.green[900],
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
            Divider(
              color: Colors.green.shade900,
              thickness: 1,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green[900],
                  padding: const EdgeInsets.all(15),
                  primary: Colors.white,
                  textStyle: const TextStyle(fontSize: 15),
                ),
                onPressed: () {
                  SharedServices.logout();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => LoginScreen()),
                    (route) => false,
                  );
                  Fluttertoast.showToast(
                    msg: "Successfully Logged Out",
                    toastLength: Toast.LENGTH_LONG,
                    fontSize: 12,
                    textColor: Colors.black,
                    backgroundColor: Colors.grey[100],
                  );
                },
                child: const Text("Logout"),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: const Text("Aqua Store"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchUserPage()),
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        // physics: const BouncingScrollPhysics(),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                Colors.green.shade400,
                Colors.green.shade50,
              ])),
          child: Consumer<MyProduct>(builder: (context, product, child) {
            print(product);
            if (product.value?.isEmpty == true) {
              return Center(
                  child: Container(
                      margin: const EdgeInsets.all(20),
                      child: const Text("Empty")));
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 150,
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(2),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/images/homepage.jpg'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      color: Colors.green[900],
                      width: double.infinity,
                      height: 30,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          "Available Fishes",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 15, right: 15, bottom: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50)),
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 2.0,
                            mainAxisSpacing: 2.0,
                          ),
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: product.value?.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GridTile(
                              child: InkWell(
                                onTap: () {
                                  {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProductUserDetail(
                                                id: (product.value?[index].id)
                                                    .toString(),
                                                name:
                                                    (product.value?[index].name)
                                                        .toString(),
                                                image: (product
                                                    .value?[index].image),
                                                category: (product
                                                        .value?[index].category)
                                                    .toString(),
                                                price: (product
                                                        .value?[index].price)!
                                                    .toInt(),
                                                description: (product
                                                        .value?[index]
                                                        .description)
                                                    .toString(),
                                                productid:
                                                    (product.value?[index].id)
                                                        .toString(),
                                                stock: ((product.value?[index]
                                                        .countInStock)
                                                    .toString()),
                                              )),
                                    );
                                  }
                                },
                                child: Card(
                                  elevation: 10,
                                  child: Container(
                                    height: 130,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.purple.shade100,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(Configs.mainURL +
                                            'uploads' +
                                            product.value![index].image
                                                .toString()),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              footer: Column(
                                children: [
                                  Text((product.value?[index].name).toString(),
                                      style: TextStyle(
                                          color: Colors.green[800],
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  space(),
                                  Text(
                                      "\$: ${(product.value?[index].price).toString()}",
                                      style: TextStyle(
                                          color: Colors.red[600],
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  space(),
                                ],
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              );
            }
          }),
        ),
      ),
    );
  }

  SizedBox space() {
    return const SizedBox(
      height: 5,
    );
  }

  // Widget searchProduct() => Search(
  //       text: query,
  //       hintText: "Search...",
  //       onChanged: product,
  //     );

  // Future product(String query) async {
  //   final products = await getProduct(query, context);
  //   if (!mounted) return;
  //   setState(() {
  //     this.query = query;
  //     this.products = products;
  //   });
  // }
}
