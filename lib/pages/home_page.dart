// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rxconnect/components/card_container.dart';
import 'package:rxconnect/components/image_view_box.dart';
import 'package:rxconnect/components/title_text.dart';
import 'package:rxconnect/constants/theme.dart';
import 'package:rxconnect/controllers/cart_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CartController cartController = Get.put(CartController());

  List anesthesia = [];
  List medication = [];
  List analgesics = [];
  List infective = [];
  List antifungal = [];

  Future<void> readAnesthesia() async {
    final String response = await rootBundle.loadString('assets/data.json');
    final data = await json.decode(response);
    setState(() {
      anesthesia = data['Anesthesia'];
    });
  }

  Future<void> readMedication() async {
    final String response = await rootBundle.loadString('assets/data.json');
    final data = await json.decode(response);
    setState(() {
      medication = data['Medication and Sedation'];
    });
  }

  Future<void> readAnalgesics() async {
    final String response = await rootBundle.loadString('assets/data.json');
    final data = await json.decode(response);
    setState(() {
      analgesics = data[
          'Analgesics , Antipyretics, Nonsteroidal Anti-inflammatory Medicines'];
    });
  }

  Future<void> readInfective() async {
    final String response = await rootBundle.loadString('assets/data.json');
    final data = await json.decode(response);
    setState(() {
      infective = data['Anti-infective Medicines'];
    });
  }

  Future<void> readAntifungal() async {
    final String response = await rootBundle.loadString('assets/data.json');
    final data = await json.decode(response);
    setState(() {
      antifungal = data['Antifungal medicines'];
    });
  }

  String getIcon(medform) {
    switch (medform) {
      case 'Inhalation':
        return 'https://www.svgrepo.com/show/487541/lungs.svg';
      case 'Injection':
        return 'https://www.svgrepo.com/show/2381/injection.svg';
      case 'Syrup':
        return 'https://www.svgrepo.com/show/54481/syrup.svg';
      case 'Tablets':
        return 'https://www.svgrepo.com/show/421939/bottle-medical-medicine.svg';
      case 'Gel':
        return 'https://www.svgrepo.com/show/60041/gel.svg';
      default:
        return 'https://www.svgrepo.com/show/488991/help.svg';
    }
  }

  @override
  void initState() {
    super.initState();
    readAnesthesia();
    readMedication();
    readAnalgesics();
    readInfective();
    readAntifungal();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: rwhite,
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
          leading: Padding(
            padding: const EdgeInsets.all(12),
            child: SvgPicture.network(
              'https://www.svgrepo.com/show/345394/medicine-drug-health-medical-smartphone-pharmacy-tablet-2.svg',
              height: 12,
              width: 12,
              color: rgreen,
            ),
          ),
          title: Text(
            "RxConnect",
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: rblack,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: InkWell(
                onTap: () => Get.toNamed('cartpage'),
                child: SvgPicture.network(
                  'https://www.svgrepo.com/show/526873/cart.svg',
                  height: 28,
                  width: 28,
                  color: rgreen,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleText(
                txt: "Anesthesia",
              ),
              const Gap(5),
              SizedBox(
                height: screenSize.height * 0.3,
                width: screenSize.width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: anesthesia.length,
                  itemBuilder: (context, index) {
                    final anesthesiadata = anesthesia[index];
                    return CardContainer(
                      title: anesthesiadata['medname'].toString(),
                      dosage: anesthesiadata['meddosage'].toString(),
                      medform: anesthesiadata['medform'].toString(),
                      icn: getIcon(anesthesiadata['medform']),
                      imglink: anesthesiadata['image'].toString(),
                      meddes: anesthesiadata['medusage'].toString(),
                      click: () {
                        cartController.addItem(
                          anesthesiadata['_id'].toString(),
                          anesthesiadata['medname'].toString(),
                          anesthesiadata['image'].toString(),
                          anesthesiadata['meddosage'].toString(),
                          anesthesiadata['medform'].toString(),
                        );
                      },
                    );
                  },
                ),
              ),
              const Gap(15),
              const TitleText(
                txt: "Medication and Sedation",
              ),
              const Gap(5),
              SizedBox(
                height: screenSize.height * 0.3,
                width: screenSize.width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: medication.length,
                  itemBuilder: (context, index) {
                    final medicationiadata = medication[index];
                    return CardContainer(
                      title: medicationiadata['medname'].toString(),
                      dosage: medicationiadata['meddosage'].toString(),
                      medform: medicationiadata['medform'].toString(),
                      icn: getIcon(medicationiadata['medform']),
                      imglink: medicationiadata['image'].toString(),
                      meddes: medicationiadata['medusage'].toString(),
                      click: () {
                        cartController.addItem(
                          medicationiadata['_id'].toString(),
                          medicationiadata['medname'].toString(),
                          medicationiadata['image'].toString(),
                          medicationiadata['meddosage'].toString(),
                          medicationiadata['medform'].toString(),
                        );
                      },
                    );
                  },
                ),
              ),
              const Gap(15),
              const TitleText(
                txt: "Anti-inflammatory Medicines",
              ),
              const Gap(5),
              SizedBox(
                height: screenSize.height * 0.3,
                width: screenSize.width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: analgesics.length,
                  itemBuilder: (context, index) {
                    final analgesicsdata = analgesics[index];
                    return CardContainer(
                      title: analgesicsdata['medname'].toString(),
                      dosage: analgesicsdata['meddosage'].toString(),
                      medform: analgesicsdata['medform'].toString(),
                      icn: getIcon(analgesicsdata['medform']),
                      imglink: analgesicsdata['image'].toString(),
                      meddes: analgesicsdata['medusage'].toString(),
                      click: () {
                        cartController.addItem(
                          analgesicsdata['_id'].toString(),
                          analgesicsdata['medname'].toString(),
                          analgesicsdata['image'].toString(),
                          analgesicsdata['meddosage'].toString(),
                          analgesicsdata['medform'].toString(),
                        );
                      },
                    );
                  },
                ),
              ),
              const Gap(15),
              const TitleText(
                txt: "Anti-infective Medicines",
              ),
              const Gap(5),
              SizedBox(
                height: screenSize.height * 0.3,
                width: screenSize.width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: infective.length,
                  itemBuilder: (context, index) {
                    final infectivedata = infective[index];
                    return CardContainer(
                      title: infectivedata['medname'].toString(),
                      dosage: infectivedata['meddosage'].toString(),
                      medform: infectivedata['medform'].toString(),
                      icn: getIcon(infectivedata['medform']),
                      imglink: infectivedata['image'].toString(),
                      meddes: infectivedata['medusage'].toString(),
                      click: () {
                        cartController.addItem(
                          infectivedata['_id'].toString(),
                          infectivedata['medname'].toString(),
                          infectivedata['image'].toString(),
                          infectivedata['meddosage'].toString(),
                          infectivedata['medform'].toString(),
                        );
                      },
                    );
                  },
                ),
              ),
              const Gap(15),
              const TitleText(
                txt: "Antifungal medicines",
              ),
              const Gap(5),
              SizedBox(
                height: screenSize.height * 0.3,
                width: screenSize.width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: antifungal.length,
                  itemBuilder: (context, index) {
                    final antifungaldata = antifungal[index];
                    return CardContainer(
                      title: antifungaldata['medname'].toString(),
                      dosage: antifungaldata['meddosage'].toString(),
                      medform: antifungaldata['medform'].toString(),
                      icn: getIcon(antifungaldata['medform']),
                      imglink: antifungaldata['image'].toString(),
                      meddes: antifungaldata['medusage'].toString(),
                      click: () {
                        cartController.addItem(
                          antifungaldata['_id'].toString(),
                          antifungaldata['medname'].toString(),
                          antifungaldata['image'].toString(),
                          antifungaldata['meddosage'].toString(),
                          antifungaldata['medform'].toString(),
                        );
                      },
                    );
                  },
                ),
              ),
              const Gap(15),
              const TitleText(
                txt: "Prescriptions",
              ),
              const Gap(5),
              const ImageViewBox(),
              const Gap(30),
            ],
          ),
        ),
      ),
    );
  }
}
