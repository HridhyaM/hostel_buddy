import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:get/get.dart';
import 'package:hostel_buddy/app/routes/app_routes.dart'; // <-- import this


class BookingPage extends StatefulWidget {
    final Map<String, dynamic> registrationData;

    const BookingPage({super.key, required this.registrationData});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  String selectedOption = '';



  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Stack(
        children: [
          // Background Layers
          Column(
            children: [
              Expanded(flex: 1, child: Container(color: Colors.white)),
              Expanded(flex: 1, child: Container(color: const Color(0xff1A5D1A))),
            ],
          ),

          // Content
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  // Logo
                  Image.asset(
                    'assets/images/splash_img.png',
                    height: 100,
                  ),

                  const SizedBox(height: 20),

                  // Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xffE8F3E3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.notifications, size: 18),
                            SizedBox(width: 5),
                            Text(
                              "Advance amount  Rs 2500/-",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "Advance amount is refundable.",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Divider(
                          thickness: 2,
                          color: Colors.green,
                          endIndent: 150,
                        ),
                        const SizedBox(height: 10),

                        const Text("Monthly Rent with Food"),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedOption = 'with_food';
                            });
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: selectedOption == 'with_food'
                                  ? Colors.yellow
                                  : Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.black),
                            ),
                            child: const Text(
                              "Rs.7500/-",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        const Text("Monthly Rent without Food"),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedOption = 'without_food';
                            });
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: selectedOption == 'without_food'
                                  ? Colors.yellow
                                  : Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.black),
                            ),
                            child: const Text(
                              "Rs.5000/-",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 120), // For bottom button space
                ],
              ),
            ),
          ),

          // Bottom Button
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                // onPressed: () {
                //   if (selectedOption.isEmpty) {
                //     ScaffoldMessenger.of(context).showSnackBar(
                //       const SnackBar(
                //           content: Text('Please Select A Rent option')),
                //     );
                //   } else {
                //     ScaffoldMessenger.of(context).showSnackBar(
                //       const SnackBar(
                //           content: Text('We will let you know the status')),
                //     );
                //   }
                // },
             onPressed: () async {
  if (selectedOption.isEmpty) {
    Flushbar(
      message: "Please Select A Rent option",
      backgroundColor: Colors.redAccent,
      duration: const Duration(seconds: 2),
      flushbarPosition: FlushbarPosition.TOP,
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      icon: const Icon(Icons.warning, color: Colors.white),
    ).show(context);
    return;
  }

  final fullData = {
 ...widget.registrationData,

    "rentOption": selectedOption,
    "bookingTimestamp": FieldValue.serverTimestamp(),
  };

  try {
    await FirebaseFirestore.instance.collection("bookings").add(fullData);

    await Flushbar(
      message: "Booking Submitted Successfully!",
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 2),
      flushbarPosition: FlushbarPosition.TOP,
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      icon: const Icon(Icons.check_circle, color: Colors.white),
    ).show(context);

    // Show status message after successful booking
    await Flushbar(
      message: "We will let you know the status",
      backgroundColor: Colors.blueGrey,
      duration: const Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      icon: const Icon(Icons.info, color: Colors.white),
    ).show(context);
     Get.toNamed(AppRoutes.thanks); 

   

} catch (e) {
  String errorMessage = "An unknown error occurred.";

  if (e is FirebaseException) {
    errorMessage = e.message ?? e.code; // Get the actual Firebase message
  } else {
    errorMessage = e.toString();
  }

  Flushbar(
    message: "Failed to Submit: $errorMessage",
    backgroundColor: Colors.red,
    duration: const Duration(seconds: 2),
    flushbarPosition: FlushbarPosition.TOP,
    margin: const EdgeInsets.all(8),
    borderRadius: BorderRadius.circular(8),
    icon: const Icon(Icons.error, color: Colors.white),
  ).show(context);
 
}

},




                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Submit",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
