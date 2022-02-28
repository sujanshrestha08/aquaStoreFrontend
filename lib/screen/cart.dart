import 'package:aqua_store/screen/proceedtopay.dart';
import 'package:aqua_store/services/cartservices.dart';
import 'package:aqua_store/services/rent_api.dart';
import 'package:aqua_store/utils/configs.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

void notify() async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
        id: 1,
        channelKey: 'key1',
        title: 'Fish has been bought',
        notificationLayout: NotificationLayout.BigPicture,
        bigPicture:
            'https://media.istockphoto.com/photos/freshwater-aquarium-in-pseudosea-style-aquascape-and-aquadesign-of-picture-id1152579000?k=20&m=1152579000&s=612x612&w=0&h=tBBlC4WwNpJw19fWE5U6czZWNK4YTS2lx_RiQY4Yi_o='),
  );
}

class _CartState extends State<Cart> {
  TextEditingController address = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController postalCode = TextEditingController();
  TextEditingController country = TextEditingController();
  final GlobalKey<FormState> globalCompleteFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CartProvider>(builder: (context, value, child) {
        if (value.lst.isEmpty == true) {
          return Scaffold(
              appBar: AppBar(
                title: const Text('Cart'),
                centerTitle: true,
                backgroundColor: Colors.green[800],
              ),
              body: const Center(
                child: Text("Empty Cart"),
              ));
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Cart'),
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Provider.of<CartProvider>(context, listen: false).lst.clear();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.green[800],
            ),
            floatingActionButton: FloatingActionButton.extended(
              backgroundColor: Colors.green[800],
              onPressed: () async {
                await showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: MediaQuery.of(context).viewInsets,
                      child: SingleChildScrollView(
                          child: Container(
                              padding: EdgeInsets.all(15),
                              child: Form(
                                key: globalCompleteFormKey,
                                child: Card(
                                    child: Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.text,
                                      validator: (input) {
                                        if (input == null || input.isEmpty) {
                                          return "Empty Address Field";
                                        } else {
                                          Container();
                                        }
                                      },
                                      // onSaved: (input) => _value = num.tryParse(input),
                                      controller: address,
                                      decoration: const InputDecoration(
                                        labelText: "Street Address *",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: OutlineInputBorder(),
                                        prefixIcon: Icon(
                                          Icons.location_on_outlined,
                                          // color: Colors.black54,
                                        ),
                                      ),
                                    ),
                                    // _gap(),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.text,
                                      // onSaved: (input) => email = input,
                                      validator: (input) {
                                        if (input == null || input.isEmpty) {
                                          return "Empty City ";
                                        } else {
                                          Container();
                                        }
                                      },
                                      // onSaved: (input) => _value = num.tryParse(input),
                                      controller: city,
                                      decoration: const InputDecoration(
                                        labelText: "City *",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: OutlineInputBorder(),
                                        prefixIcon: Icon(
                                          Icons.location_city_outlined,
                                          // color: Colors.black54,
                                        ),
                                      ),
                                    ),
                                    // _gap(),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.number,
                                      // onSaved: (input) => email = input,
                                      validator: (input) {
                                        if (input == null || input.isEmpty) {
                                          return "Please Provide Postal Code";
                                        } else {
                                          Container();
                                        }
                                      },
                                      // onSaved: (input) => _value = num.tryParse(input),
                                      controller: postalCode,
                                      decoration: const InputDecoration(
                                        labelText: "Postal Code *",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: OutlineInputBorder(),
                                        prefixIcon: Icon(
                                          Icons.qr_code_scanner_sharp,
                                          // color: Colors.black54,
                                        ),
                                      ),
                                    ),
                                    // _gap(),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.text,
                                      // onSaved: (input) => email = input,
                                      validator: (input) {
                                        if (input == null || input.isEmpty) {
                                          return "Empty Country";
                                        } else {
                                          Container();
                                        }
                                      },
                                      controller: country,
                                      decoration: const InputDecoration(
                                        labelText: "Country *",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: OutlineInputBorder(),
                                        prefixIcon: Icon(
                                          Icons.flag_outlined,
                                          // color: Colors.black54,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        await rentProduct(
                                          // value.lst[i].name.toString(),
                                          // "image",
                                          // value.lst[i].productPrice.toString(),
                                          // value.lst[i].productId.toString(),
                                          address.text,
                                          city.text,
                                          postalCode.text,
                                          country.text,
                                          context,
                                          data: value.lst,
                                        ).then((value) => {
                                              setState(() {
                                                Provider.of<CartProvider>(
                                                        context,
                                                        listen: false)
                                                    .lst
                                                    .clear();
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              }),
                                            });
                                      },
                                      child: const Text("Buy these Items"),
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.indigo[800],
                                          textStyle: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                    )
                                  ],
                                )),
                              ))),
                    );
                  },
                );
              },
              elevation: 5,
              icon: const Icon(Icons.done_all),
              label: const Text('Check Out'),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: value.lst.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Dismissible(
                            key: UniqueKey(),
                            direction: DismissDirection.horizontal,
                            background: Container(
                              color: Colors.red,
                            ),
                            onDismissed: (direction) {
                              value.del(
                                index,
                              );
                            },
                            child: Card(
                              elevation: 5,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 120,
                                        width: 140,
                                        decoration: BoxDecoration(
                                          color: Colors.purple.shade100,
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                "${Configs.mainURL}"
                                                "/"
                                                "${value.lst[index].image}"),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 160,
                                              child: Text(
                                                value.lst[index].name
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.purple[600],
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            Text(
                                              "\$ Rs. ${value.lst[index].productPrice}",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.purple[600]),
                                              textAlign: TextAlign.left,
                                            ),
                                            // Text(
                                            //   "Duration: ${value.lst[index].duration}",
                                            //   style: TextStyle(
                                            //       fontSize: 14,
                                            //       color: Colors.purple[600]),
                                            //   textAlign: TextAlign.left,
                                            // ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ],
                ),
              ),
            ),
          );
        }
      }),
    );
  }

  _gap() {
    SizedBox(
      height: 10,
    );
  }
}
