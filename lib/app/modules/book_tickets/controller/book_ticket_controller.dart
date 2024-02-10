
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class BookTicketController extends GetxController{

  File? imageFile;
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController idCardController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  bool isPaid = false;

  void setIsPaid(bool isPaid) {
    this.isPaid = isPaid;
    update();
  }

  void clearFormData(){
    nameController.clear();
    surnameController.clear();
    phoneNumberController.clear();
    dobController.clear();
    idCardController.clear();
    imageFile = null;
    update();
  }

  @override
  void onClose() {
    clearFormData();
    setIsPaid(false);
    super.onClose();
  }

}