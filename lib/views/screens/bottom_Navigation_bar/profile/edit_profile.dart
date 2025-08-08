import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_plo/controller/auth/auth.dart';
import 'package:my_plo/controller/home/home_controller.dart';

import 'package:my_plo/views/widgets/button.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();

  XFile? _image;
  final picker = ImagePicker();
  void bottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height / 6.5,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),

            child: Row(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Camera"),
                        IconButton(
                          onPressed: () {
                            _imageFrom(ImageSource.camera);
                          },
                          icon: Icon(Icons.add_a_photo),
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Gallery"),
                        IconButton(
                          onPressed: () {
                            _imageFrom(ImageSource.gallery);
                          },
                          icon: Icon(Icons.photo),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showReportDialog(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    final TextEditingController _newpasswordcontroller =
        TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Change Password",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 225, 225, 225),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    controller: _controller,

                    decoration: InputDecoration(
                      label: Text("Current Password"),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),

                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 225, 225, 225),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    controller: _newpasswordcontroller,
                    decoration: InputDecoration(
                      label: Text("New Password"),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),

                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 225, 225, 225),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      label: Text("Confirm Password"),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),

                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),

                      child: Text("Cancel"),
                      onPressed: () => Navigator.pop(context),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        AuthController authController =
                            Provider.of<AuthController>(context, listen: false);
                        Map changepassword = {
                          "currentPassword": _controller.text.trim(),
                          "newPassword": _newpasswordcontroller.text.trim(),
                        };
                        authController.changeProfilePassword(
                          changepassword,
                          context,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text("Submit"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _imageFrom(ImageSource source) async {
    final XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }

  void onTapp() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color.fromARGB(255, 159, 159, 159)),
              ),
              child: IconButton(
                iconSize: 20,
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios_rounded),
              ),
            ),
          ],
        ),
        title: Text("Edit Profile"),
      ),
      body: ListView(
        children: [
          SizedBox(height: 20),
          Column(
            children: [
              Stack(
                children: [
                  _image != null
                      ? Container(
                          height: 50,
                          width: 50,

                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: FileImage(File(_image!.path)),
                              fit: BoxFit.cover,
                            ),
                            shape: BoxShape.circle,
                            color: Colors.amber,
                          ),
                        )
                      // CircleAvatar(
                      //     radius: 40,
                      //     backgroundImage: FileImage(File(_image!.path)),
                      //   )
                      : CircleAvatar(
                          backgroundImage: AssetImage(
                            "assets/images/profile.jpg",
                          ),
                          radius: 50,
                        ),

                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () => bottomSheet(),
                      child: Container(
                        height: 40,
                        width: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.amber,
                        ),
                        child: Icon(Icons.mode_edit_outline, size: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Focus(
                    child: TextFormField(
                      decoration: InputDecoration(
                        label: Text("Name"),
                        fillColor: const Color.fromARGB(255, 223, 223, 223),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter the Name";
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Focus(
                    child: TextFormField(
                      decoration: InputDecoration(
                        label: Text("Email"),
                        fillColor: const Color.fromARGB(255, 223, 223, 223),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || !value.contains('@')) {
                          return "Enter Valid Email";
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Change Password",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Focus(
                    child: TextFormField(
                      decoration: InputDecoration(
                        label: Text("Current Password"),
                        fillColor: const Color.fromARGB(255, 223, 223, 223),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter the Current Password";
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Focus(
                    child: TextFormField(
                      decoration: InputDecoration(
                        label: Text("New Password"),
                        fillColor: const Color.fromARGB(255, 223, 223, 223),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter the New Password";
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Focus(
                    child: TextFormField(
                      decoration: InputDecoration(
                        label: Text("Confirm Password"),
                        fillColor: const Color.fromARGB(255, 223, 223, 223),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter the confirm Password";
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      _showReportDialog(context);
                    },
                    child: Text(
                      "Change Password",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Button.buildButton("Update", onTapp),
                  SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Delete Account",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // GestureDetector(
                  //   onTap: () {},
                  //   child: Container(
                  //     height: 60,
                  //     width: double.infinity,
                  //     decoration: BoxDecoration(
                  //       shape: BoxShape.rectangle,
                  //       borderRadius: BorderRadius.circular(25),
                  //       gradient: LinearGradient(
                  //         colors: [Colors.blue, Colors.purple],
                  //       ),
                  //     ),
                  //     child: Center(
                  //       child: Text(
                  //         "Update",
                  //         style: TextStyle(
                  //           color: Colors.white,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
