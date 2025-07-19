import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_buddy/app/routes/app_routes.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;


class RegistrationForm extends StatefulWidget {
  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
XFile? aadhaarImage;


  Future<void> pickImage() async {
    final picker = ImagePicker();

    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Wrap(
              children: [
                ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text("Take a photo"),
                  onTap: () async {
                    final picked = await picker.pickImage(source: ImageSource.camera);
                    if (picked != null) {
                  setState(() => aadhaarImage = picked);
            
                    }
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo),
                  title: Text("Choose from gallery"),
                  onTap: () async {
                    final picked = await picker.pickImage(source: ImageSource.gallery);
                    if (picked != null) {
                    setState(() => aadhaarImage = picked);
            
                    }
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void handleSubmit() {
  if (_formKey.currentState!.validate()) {
    if (aadhaarImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please upload Aadhaar photo')),
      );
      return;
    }

    // Aadhaar is selected — show image (optional visual action, still unused here)
    kIsWeb
        ? Image.network(aadhaarImage!.path)
        : Image.file(File(aadhaarImage!.path));

    // Proceed to next step
    print("Name: ${nameController.text}");
    print("Phone: ${phoneController.text}");
    print("Aadhaar: ${aadhaarImage!.path}");

    Get.toNamed(AppRoutes.booking);
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff99C0DF),
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
                            margin: EdgeInsets.all(20),
                            height: 455,
                            width: double.infinity,
                        // padding: const EdgeInsets.all(20),
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
                        
             
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                            
                                      
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
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
                                height: 10,
                              ),
                               TextFormField(
                              controller: nameController,
                              validator: (value) => value == null || value.trim().isEmpty
                                  ? 'Please enter full name'
                                  : null,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person, color: Colors.white),
                                hintText: 'Full Name',
                                hintStyle: TextStyle(color: Colors.white70),
                                filled: false, // ❌ No background color
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.white, width: 1.5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.white, width: 2),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                              ),
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter phone number';
                                } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                                  return 'Enter a valid 10-digit phone number';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.phone, color: Colors.white),
                                hintText: 'Phone Number',
                                hintStyle: TextStyle(color: Colors.white70),
                                filled: false, // No background color
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.white, width: 1.5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.white, width: 2),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                              ),
                              style: TextStyle(color: Colors.white),
                            ),
                            
                               const SizedBox(height: 20),
                                          
                                          //         // Aadhaar Upload
                                            GestureDetector(
                              onTap: pickImage,
                              child: Container(
                                width: double.infinity,
                                height: 180, // Increased height
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.transparent, // Removed background color
                                  border: Border.all(color: Colors.white, width: 2), // White border
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: aadhaarImage == null
                                    ? Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: const [
                                          Icon(Icons.cloud_upload, size: 40, color: Colors.white),
                                          SizedBox(height: 10),
                                          Text(
                                            "Upload Aadhaar Photo",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      )
                                    : kIsWeb
                                        ? Image.network(
                                            aadhaarImage!.path,
                                            height: 120,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.file(
                                            File(aadhaarImage!.path),
                                            height: 120,
                                            fit: BoxFit.cover,
                                          ),
                              ),
                            ),
                            
                            
                                          
                            
                            
                              ],
                            ),
                          ),
                        ),
                      ),
              
              //         const SizedBox(height: 20),
              
              //         // Title
              //         const Align(
              //           alignment: Alignment.centerLeft,
              //           child: Text(
              //             'Personal Details',
              //             style: TextStyle(
              //               color: Colors.blueGrey,
              //               fontWeight: FontWeight.bold,
              //               fontSize: 16,
              //             ),
              //           ),
              //         ),
              //         const SizedBox(height: 10),
              
              //         // Full Name
                    
              //         const SizedBox(height: 10),
              
              //         // Phone Number
              //         TextFormField(
              //           controller: phoneController,
              //           keyboardType: TextInputType.phone,
              //           validator: (value) {
              //             if (value == null || value.trim().isEmpty) {
              //               return 'Please enter phone number';
              //             } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
              //               return 'Enter a valid 10-digit phone number';
              //             }
              //             return null;
              //           },
              //           decoration: InputDecoration(
              //             prefixIcon: Icon(Icons.phone),
              //             hintText: 'Phone Number',
              //             filled: true,
              //             fillColor: Colors.blue.shade50,
              //             border: OutlineInputBorder(
              //               borderRadius: BorderRadius.circular(12),
              //               borderSide: BorderSide.none,
              //             ),
              //           ),
              //         ),
              
              //         const SizedBox(height: 20),
              
              //         // Aadhaar Upload
              //       GestureDetector(
              //   onTap: pickImage,
              //   child: Container(
              //     width: double.infinity,
              //     padding: const EdgeInsets.all(16),
              //     decoration: BoxDecoration(
              //       color: Colors.blue.shade100,
              //       borderRadius: BorderRadius.circular(12),
              //     ),
              //     child: aadhaarImage == null
              // ? Column(
              //     children: const [
              //       Icon(Icons.cloud_upload, size: 40),
              //       SizedBox(height: 10),
              //       Text("Upload Aadhaar Photo"),
              //     ],
              //   )
              // : kIsWeb
              //     ? Image.network(
              //         aadhaarImage!.path,
              //         height: 120,
              //         fit: BoxFit.cover,
              //       )
              //     : Image.file(
              //         File(aadhaarImage!.path),
              //         height: 120,
              //         fit: BoxFit.cover,
              //       ),
              //   ),
              // ),
              
              
              //         const SizedBox(height: 20),
              
              //         // Next Step
              //         SizedBox(
              //           width: double.infinity,
              //           child: ElevatedButton(
              //             onPressed: handleSubmit,
              //             style: ElevatedButton.styleFrom(
              //               backgroundColor: Color(0xFF01334F),
              //               padding: const EdgeInsets.symmetric(vertical: 14),
              //               shape: RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.circular(8),
              //               ),
              //             ),
              //             child: const Text(
              //               'Next Step',
              //               style: TextStyle(fontSize: 16),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: handleSubmit,
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
}
