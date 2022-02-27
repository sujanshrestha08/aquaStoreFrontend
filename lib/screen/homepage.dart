import 'package:aqua_store/admin/search_page.dart';
import 'package:aqua_store/admin/view_my_order.dart';
import 'package:aqua_store/model/product.dart';
import 'package:aqua_store/screen/login_screen.dart';
import 'package:aqua_store/screen/productuserdetail.dart';
import 'package:aqua_store/screen/searchuserpage.dart';
import 'package:aqua_store/services/product_service.dart';
import 'package:aqua_store/utils/configs.dart';
import 'package:aqua_store/utils/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<MyProduct>(context, listen: false).getproduct(context);
  }

  late List<ProductElement>? products;
  String query = '';
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                      "Hello Admin",
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
              child: Text(
                "View My Order",
                style: TextStyle(color: Colors.green[900]),
              ),
            ),
            const Divider(),
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
            if (product.value?.isEmpty == true) {
              return Center(
                  child: Container(
                      margin: const EdgeInsets.all(20),
                      child: const Text("Empty")));
            } else {
              return SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(15),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(50)),
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
                                      builder: (context) => ProductUserDetail(
                                            id: (product.value?[index].id)
                                                .toString(),
                                            name: (product.value?[index].name)
                                                .toString(),
                                            image:
                                                (product.value?[index].image),
                                            category:
                                                (product.value?[index].category)
                                                    .toString(),
                                            price:
                                                (product.value?[index].price)!
                                                    .toInt(),
                                            description: (product
                                                    .value?[index].description)
                                                .toString(),
                                            productid:
                                                (product.value?[index].id)
                                                    .toString(),
                                            stock: ((product
                                                    .value?[index].countInStock)
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
                                  image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(Configs.mainURL +
                                        "/uploads/image-1644522312628.png"),
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
