import 'package:aqua_store/admin/admin_home.dart';
import 'package:aqua_store/services/add_product.dart';
import 'package:aqua_store/services/update_product_api.dart';
import 'package:aqua_store/utils/configs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class UpdateProductUi extends StatefulWidget {
  final String id;
  final String name;
  // final String brand;
  final String category;
  final String description;
  final String stock;
  final String price;
  final String image;
  UpdateProductUi(
      {Key? key,
      required this.id,
      required this.name,
      // required this.brand,
      required this.category,
      required this.description,
      required this.stock,
      required this.price,
      required this.image})
      : super(key: key);

  @override
  State<UpdateProductUi> createState() => _UpdateProductUiState();
}

class _UpdateProductUiState extends State<UpdateProductUi> {
  // late File _image;
  // late File _image;
  String dropdownvalue = "Goldfish";

  var items = [
    'Goldfish',
    'Oscar',
    'Tetra',
    'Molly',
    'European anchovy',
  ];

  bool apiCallProcess = false;
  final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController brand = TextEditingController();
  final TextEditingController category = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController stock = TextEditingController();
  final TextEditingController price = TextEditingController();
  SizedBox _gap() {
    return const SizedBox(
      height: 20,
    );
  }

  File? image;

  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }

    final imageTemporary = File(image.path);
    setState(() {
      this.image = imageTemporary;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text("Update Product"),
        centerTitle: true,
        backgroundColor: Colors.green[900],
        elevation: 2,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(20),
              child: Form(
                key: globalFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      Icons.integration_instructions_outlined,
                      size: 80,
                      color: Colors.green[900],
                    ),
                    Text(
                      "Update below fields",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.green[900],
                      ),
                    ),

                    _gap(),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      // onSaved: (input) => email = input,
                      validator: (input) {
                        if (input == null || input.isEmpty) {
                          return "Please provide car model name";
                        } else {
                          null;
                        }
                      },
                      controller: name,
                      decoration: InputDecoration(
                        hintText: "Enter Fish Name",
                        labelText: "Old Fish Name - ${widget.name}",
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: const OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.water,

                          // color: Colors.black54,
                          color: Colors.green[900],
                          size: 30,
                        ),
                      ),
                    ),
                    _gap(),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(3)),
                      width: double.infinity,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.category_outlined,
                            size: 30,
                            color: Colors.green[900],
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "Category",
                            style: TextStyle(
                                fontSize: 17, color: Colors.grey[600]),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.green[50],
                                border:
                                    Border.all(color: Colors.green.shade900),
                                borderRadius: BorderRadius.circular(3)),
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: DropdownButton(
                              value: dropdownvalue,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: items.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownvalue = newValue!;
                                  print(dropdownvalue);
                                });
                              },
                              iconSize: 32,
                              underline: const SizedBox(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    _gap(),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      // onSaved: (input) => email = input,
                      validator: (input) {
                        if (input == null || input.isEmpty) {
                          return "Empty Description";
                        } else {
                          null;
                        }
                      },
                      controller: description,
                      decoration: InputDecoration(
                        labelText: "Description",
                        hintText: "Old Value - ${widget.description}",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.description_outlined,
                          color: Colors.green[900],
                          size: 30,
                        ),
                      ),
                    ),
                    _gap(),
                    TextFormField(
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.number,
                      // onSaved: (input) => email = input,
                      validator: (input) {
                        if (input == null || input.isEmpty) {
                          return "Please enter available fish";
                        } else {
                          null;
                        }
                      },
                      controller: stock,
                      decoration: InputDecoration(
                        labelText: "Total Available Fish",
                        hintText: widget.stock,
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.touch_app_outlined,
                          color: Colors.green[900],
                          size: 30,
                        ),
                      ),
                    ),
                    _gap(),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      // onSaved: (input) => email = input,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      validator: (input) {
                        if (input == null || input.isEmpty) {
                          return "Please Provide Price";
                        } else {
                          null;
                        }
                      },
                      // onSaved: (input) => _value = num.tryParse(input),
                      controller: price,
                      decoration: InputDecoration(
                        labelText: "Price",
                        hintText: widget.price,
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.attach_money_outlined,
                          color: Colors.green[900],
                          size: 30,
                        ),
                      ),
                    ),
                    // _gap(),
                    // ListTile(
                    //     leading: new Icon(Icons.photo_library),
                    //     title: new Text('Photo Library'),
                    //     onTap: () {
                    //       // Navigator.of(context).pop();
                    //     }),
                    _gap(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 250,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                Configs.mainURL + '/uploads/' + widget.image),
                          ),
                        ),
                      ),
                    ),
                    // image != null
                    //     ? Image.file(
                    //         image!,
                    //         width: 150,
                    //         height: 150,
                    //         fit: BoxFit.cover,
                    //       )
                    //     : ElevatedButton(
                    //         onPressed: () {
                    //           pickImage();
                    //         },
                    //         child: Column(
                    //           children: const [
                    //             Icon(Icons.photo_library),
                    //             Text('Photo Library'),
                    //           ],
                    //         ),
                    //       ),
                    // _gap(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 100),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green[800],
                          shape: const StadiumBorder(),
                          fixedSize:
                              const Size(double.maxFinite, double.infinity),
                          textStyle:
                              const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: () async {
                          if (apiCallProcess == false) {
                            if (validateAndSave()) {
                              setState(() {
                                apiCallProcess = true;
                              });
                            }
                            await putproduct(
                              name.text,
                              dropdownvalue.toString(),
                              description.text,
                              stock.text,
                              price.text,
                              // image!.path.toString(),
                              widget.image,
                              widget.id.toString(),
                              context,
                            ).then((value) => {
                                  setState(() {
                                    apiCallProcess = false;
                                  }),
                                  // if (value.isAdmin == false)
                                  // {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AdminHomePage()),
                                  ),
                                  Fluttertoast.showToast(
                                    msg:
                                        "Congratulations ! \n Product has been updated",
                                    toastLength: Toast.LENGTH_SHORT,
                                    fontSize: 20.0,
                                    timeInSecForIosWeb: 1,
                                    textColor: Colors.white,
                                    backgroundColor: Colors.green[800],
                                  ),
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           LoginScreen()),
                                  // ),
                                  // }
                                  // else if (value.message ==
                                  //     "User validation failed: name: Path `name` is required., email: Path `email` is required.")
                                  //   {
                                  //     Fluttertoast.showToast(
                                  //       msg:
                                  //           "Error ! \nPlease make sure every thing is correct.",
                                  //       toastLength: Toast.LENGTH_SHORT,
                                  //       fontSize: 20.0,
                                  //       timeInSecForIosWeb: 1,
                                  //       textColor: Colors.white,
                                  //       backgroundColor: Colors.red[800],
                                  //     )
                                  //   }
                                  // else if (value.message ==
                                  //     "User already Exists")
                                  //   {
                                  //     Fluttertoast.showToast(
                                  //       msg: "Error ! \nUser already Exists",
                                  //       toastLength: Toast.LENGTH_SHORT,
                                  //       fontSize: 20.0,
                                  //       timeInSecForIosWeb: 1,
                                  //       textColor: Colors.white,
                                  //       backgroundColor: Colors.red[800],
                                  //     )
                                  //   }
                                });
                          }
                        },
                        child: apiCallProcess == true
                            ? const CircularProgressIndicator(
                                backgroundColor: Colors.white,
                              )
                            : const Text(
                                "Update",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18.0,
                                ),
                              ),
                      ),
                    ),
                    _gap(),
                    // RichText(
                    //   text: TextSpan(
                    //     style: const TextStyle(
                    //       color: Colors.black,
                    //       fontSize: 13,
                    //     ),
                    //     children: [
                    //       const TextSpan(
                    //         text: "Already have an account? ",
                    //         style: TextStyle(fontSize: 12),
                    //       ),
                    //       TextSpan(
                    //         text: "Login",
                    //         style: TextStyle(
                    //           color: Colors.green[700],
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //         recognizer: TapGestureRecognizer()
                    //           ..onTap = () => Navigator.pop(context),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
