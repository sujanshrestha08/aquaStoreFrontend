import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: const Text("About Us"),
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
                  image: AssetImage('assets/images/aboutus.jpg'),
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
                    "   About Us",
                    style: TextStyle(
                      color: Colors.green[900],
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "         Aqua Store is a service operated by Aqua Services Private Limited belonging from the parent organization AquaStore Group. Aqua Store is established in February 2020 with an aim to cater premium home saloon service.",
                      style: TextStyle(
                        color: Colors.green[900],
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        "         We take pride in beign the first specialized online based home saloon service provider in Nepalese market with a vision of connecting Beauty Parlor services to wide range of Nepalese female customers at the comfort of being at their home.",
                        style: TextStyle(
                          color: Colors.green[900],
                          fontSize: 18,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        "         Our core value lies in satisfying our customer base by overcoming their expecations in terms of quality of services within a reasonable price range.",
                        style: TextStyle(
                          color: Colors.green[900],
                          fontSize: 18,
                        )),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
