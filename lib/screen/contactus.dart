import 'package:flutter/material.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: const Text("Contact Us"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
                  image: AssetImage('assets/images/contactus.png'),
                ),
              ),
            ),
            Divider(
              color: Colors.green[900],
              thickness: 10,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "   Contact Us",
                    style: TextStyle(
                      color: Colors.green[900],
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.green[900],
              thickness: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Aqua Store Private Limited",
                style: TextStyle(
                  color: Colors.green[900],
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Address - Kathmandu, Nepal",
                  style: TextStyle(
                    color: Colors.green[900],
                    fontSize: 18,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Call - 1234567890 / 0987654321",
                  style: TextStyle(
                    color: Colors.blue[900],
                    fontSize: 18,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Email - info@aquastorepltm.com.np",
                  style: TextStyle(
                    color: Colors.green[900],
                    fontSize: 18,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Webiste - www.aquaStore.com",
                  style: TextStyle(
                    color: Colors.green[900],
                    fontSize: 18,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
