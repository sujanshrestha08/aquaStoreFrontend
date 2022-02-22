import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Proceed extends StatefulWidget {
  Proceed({Key? key}) : super(key: key);

  @override
  State<Proceed> createState() => _ProceedState();
}

class _ProceedState extends State<Proceed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Checkout'),
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
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     fullscreenDialog: true,
            //     builder: (context) => Proceed(),
            //   ),
            // );
          },
          elevation: 5,
          icon: const Icon(Icons.done_all),
          label: const Text('Done.'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: InkWell(
          onTap: () {
            // showModalBottomSheet(
            //     isScrollControlled: true,
            //     context: context,
            //     builder: (context) {
            //       return Padding(
            //         padding: MediaQuery.of(context).viewInsets,
            //         child: SingleChildScrollView(
            //           child: Container(
            //             margin: const EdgeInsets.all(10),
            //             padding: EdgeInsets.all(10),
            //             child: Card(
            //               elevation: 5,
            //               child: Form(
            //                 key: globalCompleteFormKey,
            //                 child: Column(
            //                   mainAxisSize: MainAxisSize.max,
            //                   children: [
            //                     _gap(),
            //                     TextFormField(
            //                       keyboardType: TextInputType.text,
            //                       // onSaved: (input) => email = input,
            //                       validator: (input) {
            //                         if (input == null || input.isEmpty) {
            //                           return "Empty Address Field";
            //                         } else {
            //                           null;
            //                         }
            //                       },
            //                       // onSaved: (input) => _value = num.tryParse(input),
            //                       controller: address,
            //                       decoration: const InputDecoration(
            //                         labelText: "Street Address *",
            //                         hintStyle: TextStyle(color: Colors.grey),
            //                         border: OutlineInputBorder(),
            //                         prefixIcon: Icon(
            //                           Icons.location_on_outlined,
            //                           // color: Colors.black54,
            //                         ),
            //                       ),
            //                     ),
            //                     _gap(),
            //                     TextFormField(
            //                       keyboardType: TextInputType.text,
            //                       // onSaved: (input) => email = input,
            //                       validator: (input) {
            //                         if (input == null || input.isEmpty) {
            //                           return "Empty City ";
            //                         } else {
            //                           null;
            //                         }
            //                       },
            //                       // onSaved: (input) => _value = num.tryParse(input),
            //                       controller: city,
            //                       decoration: const InputDecoration(
            //                         labelText: "City *",
            //                         hintStyle: TextStyle(color: Colors.grey),
            //                         border: OutlineInputBorder(),
            //                         prefixIcon: Icon(
            //                           Icons.location_city_outlined,
            //                           // color: Colors.black54,
            //                         ),
            //                       ),
            //                     ),
            //                     _gap(),
            //                     TextFormField(
            //                       keyboardType: TextInputType.number,
            //                       // onSaved: (input) => email = input,
            //                       validator: (input) {
            //                         if (input == null || input.isEmpty) {
            //                           return "Please Provide Postal Code";
            //                         } else {
            //                           null;
            //                         }
            //                       },
            //                       // onSaved: (input) => _value = num.tryParse(input),
            //                       controller: postalCode,
            //                       decoration: const InputDecoration(
            //                         labelText: "Postal Code *",
            //                         hintStyle: TextStyle(color: Colors.grey),
            //                         border: OutlineInputBorder(),
            //                         prefixIcon: Icon(
            //                           Icons.qr_code_scanner_sharp,
            //                           // color: Colors.black54,
            //                         ),
            //                       ),
            //                     ),
            //                     _gap(),
            //                     TextFormField(
            //                       keyboardType: TextInputType.text,
            //                       // onSaved: (input) => email = input,
            //                       validator: (input) {
            //                         if (input == null || input.isEmpty) {
            //                           return "Empty Country";
            //                         } else {
            //                           null;
            //                         }
            //                       },
            //                       // onSaved: (input) => _value = num.tryParse(input),
            //                       controller: country,
            //                       decoration: const InputDecoration(
            //                         labelText: "Country *",
            //                         hintStyle: TextStyle(color: Colors.grey),
            //                         border: OutlineInputBorder(),
            //                         prefixIcon: Icon(
            //                           Icons.flag_outlined,
            //                           // color: Colors.black54,
            //                         ),
            //                       ),
            //                     ),
            //                     _gap(),
            //                     // ElevatedButton(
            //                     //   child: Row(
            //                     //     mainAxisAlignment:
            //                     //         MainAxisAlignment.center,
            //                     //     children: [
            //                     //       Icon(
            //                     //         Icons.calendar_today_outlined,
            //                     //         color: Colors.blue[900],
            //                     //       ),
            //                     //       const SizedBox(
            //                     //         width: 5,
            //                     //       ),
            //                     //       Text(
            //                     //         "${getFrom()} -> ${getTo()}",
            //                     //         style: TextStyle(
            //                     //             color: Colors.blue[900]),
            //                     //       ),
            //                     //     ],
            //                     //   ),
            //                     //   onPressed: () {
            //                     //     pickDateRange(context);
            //                     //   },
            //                     //   style: ElevatedButton.styleFrom(
            //                     //     primary: Colors.white,
            //                     //     shadowColor: Colors.blue[900],
            //                     //     elevation: 7,
            //                     //   ),
            //                     // ),
            //                     ElevatedButton(
            //                       onPressed: () {
            //                         for (int i = 0; i < value.lst.length; i++) {
            //                           rentProduct(
            //                             value.lst[i].name.toString(),
            //                             "image",
            //                             value.lst[i].productPrice.toString(),
            //                             value.lst[i].productId.toString(),
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
            //                                     msg: "Successfully Bought",
            //                                     toastLength: Toast.LENGTH_SHORT,
            //                                     fontSize: 20.0,
            //                                     timeInSecForIosWeb: 1,
            //                                     textColor: Colors.white,
            //                                     backgroundColor: Colors.green[800],
            //                                   );
            //                                 }),
            //                                 // }
            //                               });
            //                         }
            //                       },
            //                       child: const Text("Buy these Items"),
            //                       style: ElevatedButton.styleFrom(
            //                           primary: Colors.indigo[800],
            //                           textStyle: const TextStyle(
            //                               fontSize: 18,
            //                               fontWeight: FontWeight.bold)),
            //                     )
            //                   ],
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ),
            //       );
            //     });
          },
        ));
  }
}
