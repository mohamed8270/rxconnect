// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:rxconnect/components/image_picker_widget.dart';
import 'package:rxconnect/components/image_upload_widget.dart';
import 'package:rxconnect/constants/theme.dart';
import 'package:rxconnect/database/medication_upload.dart';
import 'package:rxconnect/interface/bottom_nav_bar.dart';
import 'package:rxconnect/interface/user_input.dart';
import 'package:rxconnect/models/recognization_response.dart';

class MedicationPage extends StatefulWidget {
  const MedicationPage({super.key});

  @override
  State<MedicationPage> createState() => _MedicationPageState();
}

class _MedicationPageState extends State<MedicationPage> {
  DatabaseHelper databaseHelper = Get.put(DatabaseHelper());
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController hospitalController = TextEditingController();

  DateTime? selectedDate;

  // Image Picker to package initilization
  late ImagePicker _picker;
  // Image Recognization reponse variable
  RecognizationResponse? _response;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Initialize image picker
    _picker = ImagePicker();
  }

  // Image obtain function
  Future<String?> obtainImage(ImageSource source) async {
    final file = await _picker.pickImage(source: source);
    return file?.path;
  }

  //Upload Image
  Future<String?> uploadImage(String imgPath) async {
    final cloudinary = CloudinaryPublic(
      'dmb6hkclb',
      'xii5qts7',
      cache: false,
    );

    try {
      final response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          imgPath,
          resourceType: CloudinaryResourceType.Image,
        ),
      );
      return response.secureUrl;
    } catch (e) {
      // print(e);
      Get.snackbar(
        'Error',
        '$e',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        colorText: rwhite,
      );
      return null;
    }
  }

  //image path
  void processImageandPath(String imgPath) async {
    setState(() {
      _response = RecognizationResponse(
        imgPath: imgPath,
      );
    });
  }

  Future<void> submitData() async {
    try {
      String? imgUrl;
      if (_response?.imgPath != null) {
        imgUrl = await uploadImage(_response!.imgPath);
        if (imgUrl == null) Exception('Failed to upload Image');
      }

      Map<String, dynamic> data = {
        'name': nameController.text,
        'date': dateController.text,
        'hospital': hospitalController.text,
        'image': imgUrl,
      };

      await databaseHelper.insertdetail(data);

      Get.to(const BottomNavBar());
    } catch (e) {
      throw Exception('Error while submitting data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: rwhite,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: Container(
        height: screenSize.height * 0.06,
        width: screenSize.width,
        decoration: const BoxDecoration(
          color: rgreen,
        ),
        child: FloatingActionButton(
          onPressed: () => submitData(),
          backgroundColor: rgreen,
          elevation: 0,
          child: Text(
            'Submit',
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: rwhite,
            ),
          ),
        ),
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: rgrey,
                  width: 0.5,
                ),
              ),
            ),
          ),
          centerTitle: false,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text(
            "Medications & Prescriptions",
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: rblack,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserInputWidget(
                height: screenSize.height * 0.055,
                width: screenSize.width * 0.95,
                icnLink: 'https://www.svgrepo.com/show/491095/user.svg',
                txt: 'Name',
                type: TextInputType.name,
                userController: nameController,
              ),
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => selectDate(context),
                    child: AbsorbPointer(
                      child: UserInputWidget(
                        height: screenSize.height * 0.055,
                        width: screenSize.width * 0.46,
                        icnLink:
                            'https://www.svgrepo.com/show/524350/calendar.svg',
                        txt: 'Date',
                        type: TextInputType.datetime,
                        userController: dateController,
                      ),
                    ),
                  ),
                  UserInputWidget(
                    height: screenSize.height * 0.055,
                    width: screenSize.width * 0.46,
                    icnLink: 'https://www.svgrepo.com/show/498097/hospital.svg',
                    txt: 'Hospital',
                    type: TextInputType.text,
                    userController: hospitalController,
                  ),
                ],
              ),
              const Gap(10),
              ImageUploadWidget(
                txt: _response == null ? "Upload Image" : "Change Image",
                onClick: () async {
                  showDialog(
                    context: context,
                    builder: (context) => imagePickAlert(
                      onCameraPressed: () async {
                        final imgpath = await obtainImage(ImageSource.camera);
                        if (imgpath == null) return;
                        processImageandPath(imgpath);
                        Get.back();
                      },
                      onGalleryPressed: () async {
                        final imgpath = await obtainImage(ImageSource.gallery);
                        if (imgpath == null) return;
                        processImageandPath(imgpath);
                        Get.back();
                      },
                    ),
                  );
                },
              ),
              _response == null
                  ? Text(
                      "**Please upload an image to submit as a proof**",
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Colors.red,
                      ),
                    )
                  : SizedBox(
                      height: screenSize.width,
                      width: screenSize.width,
                      child: Image.file(File(_response!.imgPath)),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
