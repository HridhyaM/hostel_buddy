


import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_buddy/app/routes/app_routes.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart'; 

class RegistrationForm extends StatefulWidget {
  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final guardianController = TextEditingController();
  final guardianNumberController = TextEditingController();
  final addressController = TextEditingController();
  XFile? aadhaarImage;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
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

      // Navigate to booking page with arguments
      Get.toNamed(AppRoutes.booking, arguments: {
        "name": nameController.text,
        "phone": phoneController.text,
        "guardian": guardianController.text,
        "guardianNumber": guardianNumberController.text,
        "address": addressController.text,
        "aadhaarPath": aadhaarImage?.path,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(flex: 1, child: Container(color: Colors.white)),
              Expanded(flex: 1, child: Container(color: const Color(0xff1A5D1A))),
            ],
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Image.asset('assets/images/splash_img.png', height: 100),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xffE8F3E3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.person),
                              SizedBox(width: 8),
                              Text(
                                'Personal Details',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text("Name"),
                          const SizedBox(height: 10),
                          _buildField("Enter Your Name", nameController),
                          const SizedBox(height: 10),
                          Text("Number"),
                          const SizedBox(height: 10),
                          _buildField("Enter your Contact Number", phoneController, keyboardType: TextInputType.phone),
                          const SizedBox(height: 10),
                          Text("Guardian"),
                          const SizedBox(height: 10),
                          _buildField("Enter your Guardian Name", guardianController),
                          const SizedBox(height: 10),
                          Text("Number"),
                          const SizedBox(height: 10),
                          _buildField("Enter your Guardian Number", guardianNumberController, keyboardType: TextInputType.phone),
                          const SizedBox(height: 10),
                          Text("Address"),
                          const SizedBox(height: 10),
                          _buildField("Enter your Address", addressController),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.link_outlined),
                              SizedBox(width: 10),
                              Text(
                                'Aadhaar Upload',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          GestureDetector(
                            onTap: pickImage,
                            child: Container(
                              width: double.infinity,
                              height: 120,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: aadhaarImage == null
                                  ? Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Icon(Icons.cloud_upload, size: 40),
                                        Text("Upload Aadhaar Photo"),
                                      ],
                                    )
                                  : kIsWeb
                                      ? Image.network(
                                          aadhaarImage!.path,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.file(
                                          File(aadhaarImage!.path),
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
        Align(
  alignment: Alignment.bottomCenter,
  child: Padding(
    padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
    child: Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
      color: Color(0xffF52121),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        onPressed: handleSubmit,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          "Next Step",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  ),
),

        ],
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    final isPhoneField = keyboardType == TextInputType.phone;

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLength: isPhoneField ? 10 : null,
      inputFormatters: isPhoneField ? [FilteringTextInputFormatter.digitsOnly] : [],
      decoration: InputDecoration(
        labelText: label,
        counterText: "",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter $label';
        }
        if (isPhoneField && value.trim().length != 10) {
          return 'Phone number must be exactly 10 digits';
        }
        return null;
      },
    );
  }
}