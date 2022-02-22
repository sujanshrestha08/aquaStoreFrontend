import 'package:aqua_store/services/cartservices.dart';
import 'package:aqua_store/services/product_service.dart';
import 'package:aqua_store/services/rent_api.dart';
import 'package:aqua_store/utils/time_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'cart.dart';

class ProductUserDetail extends StatefulWidget {
  final String id;
  final String name;
  final dynamic image;
  // final String brand;
  final String category;
  final int price;
  final String description;
  final String productid;
  final String stock;
  ProductUserDetail({
    Key? key,
    required this.id,
    required this.name,
    // required this.brand,
    required this.category,
    required this.price,
    required this.description,
    required this.productid,
    required this.image,
    required this.stock,
  }) : super(key: key);

  @override
  State<ProductUserDetail> createState() => _ProductUserDetailState();
}

class _ProductUserDetailState extends State<ProductUserDetail> {
  final address = TextEditingController();
  final city = TextEditingController();
  final postalCode = TextEditingController();
  final country = TextEditingController();
  TextEditingController dateInText = TextEditingController();
  TextEditingController dateOutText = TextEditingController();
  final GlobalKey<FormState> globalCompleteFormKey = GlobalKey<FormState>();

  DateTimeRange? dateRange;
  String getFrom() {
    if (dateRange == null) {
      return "Select Rent Date From";
    } else {
      return DateFormat("yyyy-MM-dd").format(dateRange!.start);
    }
  }

  String getTo() {
    if (dateRange == null) {
      return ("Until *");
    } else {
      return DateFormat("yyyy-MM-dd").format(dateRange!.end);
    }
  }

  @override
  Widget build(BuildContext context) {
    final timeDate = Provider.of<TimeProvider>(context);
    DateTime selectedDateFrom = DateTime.now();
    DateTime selectedDateTo = DateTime.now().add(const Duration(days: 7));
    String durationFrom = timeDate.getDate((selectedDateFrom).toString());
    String durationTo = timeDate.getDate((selectedDateTo).toString());

    Future pickDateRange(BuildContext context) async {
      final initialDateRange = DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(const Duration(hours: 24 * 7)),
      );
      final newDateRange = await showDateRangePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5),
        initialDateRange: dateRange ?? initialDateRange,
      );
      if (newDateRange == null) return;
      setState(() {
        dateRange = newDateRange;
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: const Text("Fish Details"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => Cart(),
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart_outlined))
        ],
      ),
      body: Consumer<MyProduct>(
        builder: (context, product, child) {
          return SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(6),
              padding: const EdgeInsets.all(8),
              child: Card(
                elevation: 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          gap(),
                          Container(
                            height: 200,
                            color: Colors.amber,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                gap(),
                                Text("Car name: ${widget.name}",
                                    style: TextStyle(
                                      color: Colors.green[800],
                                      fontSize: 16,
                                    )),
                                // gap(),
                                // Text(
                                //   "Car Model: ${widget.brand}",
                                //   style: TextStyle(
                                //     color: Colors.green[800],
                                //     fontSize: 16,
                                //   ),
                                // ),
                                gap(),
                                Text("Category: ${widget.category}",
                                    style: TextStyle(
                                      color: Colors.green[800],
                                      fontSize: 16,
                                    )),
                                gap(),
                                Text("Price \$: ${widget.price}",
                                    style: TextStyle(
                                      color: Colors.green[800],
                                      fontSize: 16,
                                    )),
                                gap(),
                                Text("Description: ${widget.description}",
                                    style: TextStyle(
                                      color: Colors.green[800],
                                      fontSize: 16,
                                    )),
                                gap(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     showModalBottomSheet(
                    //         isScrollControlled: true,
                    //         context: context,
                    //         builder: (context) {
                    //           return Padding(
                    //             padding: MediaQuery.of(context).viewInsets,
                    //             child: SingleChildScrollView(
                    //               child: Container(
                    //                 margin: const EdgeInsets.all(10),
                    //                 padding: EdgeInsets.all(10),
                    //                 child: Form(
                    //                   key: globalCompleteFormKey,
                    //                   child: Column(
                    //                     mainAxisSize: MainAxisSize.max,
                    //                     children: [
                    //                       _gap(),
                    //                       TextFormField(
                    //                         keyboardType: TextInputType.text,
                    //                         // onSaved: (input) => email = input,
                    //                         validator: (input) {
                    //                           if (input == null ||
                    //                               input.isEmpty) {
                    //                             return "Empty Address Field";
                    //                           } else {
                    //                             null;
                    //                           }
                    //                         },
                    //                         // onSaved: (input) => _value = num.tryParse(input),
                    //                         controller: address,
                    //                         decoration: const InputDecoration(
                    //                           labelText: "Street Address *",
                    //                           hintStyle:
                    //                               TextStyle(color: Colors.grey),
                    //                           border: OutlineInputBorder(),
                    //                           prefixIcon: Icon(
                    //                             Icons.location_on_outlined,
                    //                             // color: Colors.black54,
                    //                           ),
                    //                         ),
                    //                       ),
                    //                       _gap(),
                    //                       TextFormField(
                    //                         keyboardType: TextInputType.text,
                    //                         // onSaved: (input) => email = input,
                    //                         validator: (input) {
                    //                           if (input == null ||
                    //                               input.isEmpty) {
                    //                             return "Empty City ";
                    //                           } else {
                    //                             null;
                    //                           }
                    //                         },
                    //                         // onSaved: (input) => _value = num.tryParse(input),
                    //                         controller: city,
                    //                         decoration: const InputDecoration(
                    //                           labelText: "City *",
                    //                           hintStyle:
                    //                               TextStyle(color: Colors.grey),
                    //                           border: OutlineInputBorder(),
                    //                           prefixIcon: Icon(
                    //                             Icons.location_city_outlined,
                    //                             // color: Colors.black54,
                    //                           ),
                    //                         ),
                    //                       ),
                    //                       _gap(),
                    //                       TextFormField(
                    //                         keyboardType: TextInputType.number,
                    //                         // onSaved: (input) => email = input,
                    //                         validator: (input) {
                    //                           if (input == null ||
                    //                               input.isEmpty) {
                    //                             return "Please Provide Postal Code";
                    //                           } else {
                    //                             null;
                    //                           }
                    //                         },
                    //                         // onSaved: (input) => _value = num.tryParse(input),
                    //                         controller: postalCode,
                    //                         decoration: const InputDecoration(
                    //                           labelText: "Postal Code *",
                    //                           hintStyle:
                    //                               TextStyle(color: Colors.grey),
                    //                           border: OutlineInputBorder(),
                    //                           prefixIcon: Icon(
                    //                             Icons.qr_code_scanner_sharp,
                    //                             // color: Colors.black54,
                    //                           ),
                    //                         ),
                    //                       ),
                    //                       _gap(),
                    //                       TextFormField(
                    //                         keyboardType: TextInputType.text,
                    //                         // onSaved: (input) => email = input,
                    //                         validator: (input) {
                    //                           if (input == null ||
                    //                               input.isEmpty) {
                    //                             return "Empty Country";
                    //                           } else {
                    //                             null;
                    //                           }
                    //                         },
                    //                         // onSaved: (input) => _value = num.tryParse(input),
                    //                         controller: country,
                    //                         decoration: const InputDecoration(
                    //                           labelText: "Country *",
                    //                           hintStyle:
                    //                               TextStyle(color: Colors.grey),
                    //                           border: OutlineInputBorder(),
                    //                           prefixIcon: Icon(
                    //                             Icons.flag_outlined,
                    //                             // color: Colors.black54,
                    //                           ),
                    //                         ),
                    //                       ),
                    //                       _gap(),
                    //                       ElevatedButton(
                    //                         child: Row(
                    //                           mainAxisAlignment:
                    //                               MainAxisAlignment.center,
                    //                           children: [
                    //                             Icon(
                    //                               Icons.calendar_today_outlined,
                    //                               color: Colors.green[900],
                    //                             ),
                    //                             const SizedBox(
                    //                               width: 5,
                    //                             ),
                    //                             Text(
                    //                               "${getFrom()} -> ${getTo()}",
                    //                               style: TextStyle(
                    //                                   color: Colors.green[900]),
                    //                             ),
                    //                           ],
                    //                         ),
                    //                         onPressed: () {
                    //                           pickDateRange(context);
                    //                         },
                    //                         style: ElevatedButton.styleFrom(
                    //                           primary: Colors.white,
                    //                           shadowColor: Colors.green[900],
                    //                           elevation: 7,
                    //                         ),
                    //                       ),
                    //                       ElevatedButton(
                    //                         onPressed: () {
                    //                           rentProduct(
                    //                             widget.name,
                    //                             "image",
                    //                             widget.price.toString(),
                    //                             widget.productid,
                    //                             address.text,
                    //                             city.text,
                    //                             postalCode.text,
                    //                             country.text,
                    //                             context,
                    //                           ).then((value) => {
                    //                                 setState(() {
                    //                                   Navigator.pop(context);
                    //                                   Navigator.pop(context);
                    //                                   Navigator.pop(context);
                    //                                   Fluttertoast.showToast(
                    //                                     msg:
                    //                                         "Successfully Rented",
                    //                                     toastLength:
                    //                                         Toast.LENGTH_SHORT,
                    //                                     fontSize: 20.0,
                    //                                     timeInSecForIosWeb: 1,
                    //                                     textColor: Colors.white,
                    //                                     backgroundColor:
                    //                                         Colors.green[800],
                    //                                   );
                    //                                 }),
                    //                                 // }
                    //                               });
                    //                         },
                    //                         child: const Text("Rent this car"),
                    //                         style: ElevatedButton.styleFrom(
                    //                             primary: Colors.green[800],
                    //                             textStyle: const TextStyle(
                    //                                 fontSize: 18,
                    //                                 fontWeight:
                    //                                     FontWeight.bold)),
                    //                       )
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),
                    //           );
                    //         });
                    //   },
                    //   child: const Text("Rent this Car."),
                    //   style: ElevatedButton.styleFrom(
                    //       primary: Colors.green[800],
                    //       textStyle: const TextStyle(
                    //           fontSize: 18, fontWeight: FontWeight.bold)),
                    // ),

                    gap(),
                    Consumer<CartProvider>(
                      builder: (context, value, _) {
                        return ElevatedButton.icon(
                          onPressed: () {
                            value.add(
                              widget.id.toString(),
                              widget.image,
                              widget.name,
                              widget.price,
                            );
                            Fluttertoast.showToast(
                              msg: "Successfully added to Cart",
                              toastLength: Toast.LENGTH_SHORT,
                              fontSize: 20.0,
                              timeInSecForIosWeb: 1,
                              textColor: Colors.white,
                              backgroundColor: Colors.green[800],
                            );
                          },
                          icon: Icon(
                            Icons.add,
                            color: Colors.red[50],
                            size: 30,
                          ),
                          label: const Text("Add to Cart"),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.green[800],
                              textStyle: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  SizedBox gap() {
    return SizedBox(
      height: 10,
    );
  }

  SizedBox _gap() {
    return const SizedBox(
      height: 20,
    );
  }
}
