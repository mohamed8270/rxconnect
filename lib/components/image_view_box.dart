// ignore_for_file: deprecated_member_use, avoid_print, use_build_context_synchronously, prefer_const_constructors

import 'dart:io';
import 'dart:typed_data';

import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxconnect/constants/theme.dart';
import 'package:http/http.dart' as http;
import 'package:rxconnect/database/medication_upload.dart';
import 'package:url_launcher/url_launcher.dart';

class ImageViewBox extends StatefulWidget {
  const ImageViewBox({
    super.key,
  });

  @override
  State<ImageViewBox> createState() => _ImageViewBoxState();
}

class _ImageViewBoxState extends State<ImageViewBox> {
  DatabaseHelper databaseHelper = Get.put(DatabaseHelper());

  // Get all persons data and appending
  List<Map<String, dynamic>> dataUpload = [];

  Future<void> allDataFunc() async {
    final allData = await databaseHelper.getalldetails();
    setState(() {
      dataUpload = allData;
    });
  }

  // Delete persons data
  Future<void> deleteperson(int id) async {
    await databaseHelper.deletedetails(id);
    allDataFunc();
  }

  Future<Uint8List?> downloadImage(String imageUrl) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        print("Failed to download image.");
        return null;
      }
    } catch (e) {
      print("Error downloading image: $e");
      return null;
    }
  }

  Future<File?> saveImageToExternalStorage(
      Uint8List imageData, String fileName) async {
    try {
      // Request permissions
      var status = await Permission.storage.request();
      if (status.isGranted) {
        final directoryPath =
            await ExternalPath.getExternalStoragePublicDirectory(
                ExternalPath.DIRECTORY_DOWNLOADS);
        final filePath = '$directoryPath/$fileName';
        final file = File(filePath);
        await file.writeAsBytes(imageData);
        print("File saved: $filePath");
        return file;
      } else {
        print("Storage permission denied.");
        return null;
      }
    } catch (e) {
      print("Error saving image: $e");
      return null;
    }
  }

  void downloadAndSaveImage(
      BuildContext context, String imageUrl, String fileName) async {
    final imageData = await downloadImage(imageUrl);
    if (imageData != null) {
      final file = await saveImageToExternalStorage(imageData, fileName);
      if (file != null) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Image saved to ${file.path}")));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Failed to save image")));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Failed to download image")));
    }
  }

  @override
  void initState() {
    super.initState();
    allDataFunc();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return SizedBox(
      height: screenSize.height * 0.18,
      width: screenSize.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dataUpload.length,
        itemBuilder: (context, index) {
          final data = dataUpload[index];
          return Padding(
            padding: const EdgeInsets.only(left: 10),
            child: InkWell(
              onLongPress: () {
                deleteperson(data['id']);
              },
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: screenSize.height * 0.2,
                width: screenSize.width * 0.45,
                decoration: BoxDecoration(
                  color: rwhite,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: rgrey, width: 1.3),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final Uri url = Uri.parse(data['image']);
                          if (!await launchUrl(url,
                              mode: LaunchMode.inAppBrowserView)) {
                            throw Exception('Could not launch $url');
                          }
                        },
                        child: Container(
                          height: screenSize.height * 0.1,
                          width: screenSize.width * 0.4,
                          decoration: BoxDecoration(
                            color: rgrey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                              image: NetworkImage(data['image'].toString()),
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.high,
                            ),
                          ),
                        ),
                      ),
                      const Gap(5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: screenSize.width * 0.3,
                                child: Text(
                                  data['name'].toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: rblack,
                                  ),
                                ),
                              ),
                              const Gap(2),
                              SizedBox(
                                width: screenSize.width * 0.3,
                                child: Text(
                                  data['hospital'].toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: rblack.withOpacity(0.4),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () => downloadAndSaveImage(
                              context,
                              data['image'],
                              "downloadedImage.jpg",
                            ),
                            child: SvgPicture.network(
                              'https://www.svgrepo.com/show/520695/download.svg',
                              height: 22,
                              width: 22,
                              color: rblack.withOpacity(0.3),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
