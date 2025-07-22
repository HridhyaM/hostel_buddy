import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';


class BookingPage extends StatefulWidget {
  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  bool withFood = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xff99C0DF),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                            colors: [
                              Color(0xFF002E47),
                              Color(0xFF1B506D),
                              Color(0xFF0F547B),
                              Color(0xFF01334F),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                ),
                 child: Image.asset(
                        'assets/images/splash_img.png',
                        height: 100,
                        width: double.infinity,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                        Container(
                          height: 306,
                          width: 365,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF002E47),
                            Color(0xFF1B506D),
                            Color(0xFF0F547B),
                            Color(0xFF01334F),
                          ],
                        ),
                      ),
                        
                child: Column(
                //   mainAxisSize: MainAxisSize.min,
                  children: [
               
                     Align(
                      alignment: Alignment.centerLeft,
                      child: 
          
          
          
                          Row(
                            children: [
                              Icon(Icons.person,size: 30,color: Colors.white,),
                              Text(
                                ' Personal Details',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 25,
                                  
                                ),
                              ),
                            ],
                          ),
                     
                    ),
                    SizedBox(
                      height: 20,
                    ),
          
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildToggleButton("Without Food", false),
                      buildToggleButton("With Food", true),
                    ],
                  ),
          
                  const SizedBox(height: 20),
              
                //     // Price
                    Container(
                      width: 150,
                 padding: EdgeInsets.all(5),
             
                      decoration: BoxDecoration(
                    color: Color(0xff014A83),
                         border: Border.all(
                color: Colors.white, // Border color
                width: 1.5,           // Border width
              ),
              borderRadius: BorderRadius.circular(10)
                      ),
                      child: Text(
                        textAlign: TextAlign.center,
                        withFood ? "5000" : "4000",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                const SizedBox(height: 16),
              
                //     // Book Now Button
                    SizedBox(
                      height: 43,
                      width: 151,
                      child: ElevatedButton(
                        onPressed: () {
                       launchGPayPayment();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                              side: BorderSide(
          color: Colors.black, // Border color
          width: 1.5,         // Border width
        ),
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                        ),
                        child: const Text("Book Now",style: TextStyle(
                          color: Colors.white,
                      
                        ),),
                      ),
                    ),
                    const SizedBox(height: 12),
              
                    // Back Button
                 
              
          
                  ],
                 ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
          
                           Container(
                            width: 150,
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.5,
                                color: Color(0xffDFF2FF)
                              )
                            ),
                             child: TextButton(
                              
                                                 onPressed: () {
                                                   Get.back();
                                                 },
                                                 child: const Text("Back"),
                                               ),
                           ),

                                     // Submit Button
                    const SizedBox(height: 20),
             Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: (){},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(
                            color: Color(0xFFB0B0B0), // Light black/grey border
                            width: 1.5,
                          ),
                        ),
                      ),
                      child: const Text(
                        'Next Step',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black, // Optional: Make text dark for contrast
                        ),
                      ),
                    ),
                  ),
                ),

            ],
          ),
        ),
      ),
    );
  }

  Widget buildToggleButton(String label, bool value) {
    return GestureDetector(
      onTap: () => setState(() => withFood = value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        
        decoration: BoxDecoration(
          color: withFood == value ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
           border: Border.all(
      color: Colors.white, // Border color
      width: 1.5,           // Border width
    ),
        ),
        child: Row(
          children: [
            Icon(
              value ? Icons.restaurant : Icons.no_meals,
              size: 20,
              color: withFood == value ? Colors.black : Colors.white,
            ),
            const SizedBox(width: 5),
            Text(
              label,
              style: TextStyle(
                color: withFood == value ? Colors.black : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
 
Future<void> launchGPayPayment() async {
  final amount = withFood ? "5000" : "4000";
  final upiId = "hridhyamm007@oksbi"; 
  final name = Uri.encodeComponent("Hostel Buddy");
  final note = Uri.encodeComponent("PG Booking");

  final uriString =
      "upi://pay?pa=$upiId&pn=$name&tn=$note&am=$amount&cu=INR";

  final uri = Uri.parse(uriString);

  try {
    final launched = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );

    if (!launched) {
      Get.snackbar("Error", "Could not launch UPI app",
          snackPosition: SnackPosition.BOTTOM);
    }
  } catch (e) {
    Get.snackbar("Error", "No UPI app available",
        snackPosition: SnackPosition.BOTTOM);
  }
}


}
