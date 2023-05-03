import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/validators/basic-form-validators.dart';
import 'package:prep50/widgets/app_back_icon.dart';
import 'package:prep50/widgets/app_button.dart';
import 'package:prep50/widgets/app_text_field.dart';
import 'package:prep50/widgets/app_toast.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

import '../../constants/string_data.dart';
import '../../utils/exceptions.dart';
import '../../view-models/edit_profile_screen_viewmodel.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AppToast? appToast;


  @override
  void initState() {
    super.initState();
    appToast=AppToast(context: context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      EditProfileScreenViewModel editProfileScreenViewModel = Provider.of<EditProfileScreenViewModel>(context,listen:false);
      editProfileScreenViewModel.loadUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Color(0xffffffff),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13.5,vertical: 15),
                  child: Row(
                    children: [
                      AppBackIcon(),
                      SizedBox(
                        width: 24,
                      ),
                      AppText.heading6S("Profile Settings"),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Consumer<EditProfileScreenViewModel>(
                builder: (context,editProfileScreenViewModel,child) {
                  return editProfileScreenViewModel.isLoadingUser?
                          _buildLoadingWidget():
                          _buildEditProfileWidget(editProfileScreenViewModel);
                }
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget component({
    String? title,
    String? hint,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.heading6("$title"),
          SizedBox(height: 6),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: AppText.textField("$hint"),
          ),
        ],
      ),
    );
  }

Widget  _buildEditProfileWidget(EditProfileScreenViewModel editProfileScreenViewModel) {
    phoneController = TextEditingController(text: editProfileScreenViewModel.user.phone);
    addressController = TextEditingController(text: editProfileScreenViewModel.user.address);
  final ProgressDialog progressDialog = ProgressDialog(context:context);
  return Form(
    key: _formKey,
    child: ListView(
      padding: EdgeInsets.all(0),
      children: [
        SizedBox(height: 20),
        Center(
          child: SizedBox(
            height: 100,
            width: 100,
            child: Stack(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  child: editProfileScreenViewModel.imageFile!=null?
                  CircleAvatar(backgroundImage: FileImage(
                    editProfileScreenViewModel.imageFile!,
                  ),):
                  editProfileScreenViewModel.user.photo.isEmpty?
                  CircleAvatar(
                    backgroundImage: AssetImage(
                      "assets/png/dummy_avatar.png",
                    ),
                  ):CircleAvatar(
                    backgroundImage: NetworkImage(
                      "$BASE_URL/${editProfileScreenViewModel.user.photo}",
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: ClipOval(
                    child: Container(
                      height: 40,
                      width: 40,
                      color: Colors.white,
                      child: Center(
                        child: ClipOval(
                          child: GestureDetector(
                            onTap: ()async{
                              final ImagePicker picker = ImagePicker();
                              final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                              if(image!=null){
                                File imageFile = File(image.path);
                                editProfileScreenViewModel.setImageFile(imageFile);
                              }
                            },
                            child: Container(
                              height: 32,
                              width: 32,
                              color: kPrimaryColor,
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        component(title: "Username", hint: "${editProfileScreenViewModel.user.username}"),
        component(title: "Email", hint: "${editProfileScreenViewModel.user.email}"),
        componentText(title: "Phone Number", hint: "${editProfileScreenViewModel.user.phone!.isNotEmpty?editProfileScreenViewModel.user.phone:"Enter your phone number"}",controller:phoneController,validator:phoneNumberValidator),
        componentText(title: "Address", hint: "${editProfileScreenViewModel.user.address.isNotEmpty?editProfileScreenViewModel.user.address:"Enter your address"}",controller:addressController,validator:addressValidator),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: AppText.heading6("Gender"),
        ),
        SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.white,
                  child: Row(
                    children: [
                      AppText.captionText(
                        "Male",
                        color: kMidBlackColor,
                      ),
                      Spacer(),
                      Radio(
                          value: "M",
                          groupValue: "${editProfileScreenViewModel.gender}",
                          onChanged: (dynamic v) {
                            editProfileScreenViewModel.gender=v.toString();
                          })
                    ],
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.white,
                  child: Row(
                    children: [
                      AppText.captionText(
                        "Female",
                        color: kMidBlackColor,
                      ),
                      Spacer(),
                      Radio(
                        value: "F",
                        groupValue: "${editProfileScreenViewModel.gender}",
                        onChanged: (dynamic v) {
                          editProfileScreenViewModel.gender=v.toString();
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10,),
        Center(
          child: AppButton(
            title: "Save",
            color: true,
            width: 197,
            onTap: ()async{
              if (_formKey.currentState!.validate()) {
                progressDialog.show(
                  max: 100,
                  msg: 'Posting Comment...',
                  msgColor: Colors.black,
                  progressValueColor: kPrimaryColor,
                  borderRadius: 10.0,
                  backgroundColor: Colors.white,
                  barrierDismissible: false,
                  elevation: 10.0,
                );
                try{
                  String phone = phoneController.text.isNotEmpty? phoneController.text :editProfileScreenViewModel.user.phone??"";
                  String gender = editProfileScreenViewModel.gender;
                  String address = addressController.text.isNotEmpty?addressController.text:editProfileScreenViewModel.user.address??"";
                  print(phone);
                  print(address);
                  await editProfileScreenViewModel.updateUserProfile(phone: phone, gender: gender, address: address);
                  progressDialog.close();
                  appToast?.showToast(message: "Profile updated successfully");

                }on ValidationException catch(e){
                  progressDialog.close();
                  appToast?.showToast(message: e.message);
                }catch(e){
                  progressDialog.close();
                  appToast?.showToast(message: e.toString().substring(11));
                }
              }
            },
          ),
        ),
        SizedBox(
          height: 60,
        )
      ],
    ),
  );
}

  Widget _buildLoadingWidget() {
    return Center(
      child: SizedBox(
        height: 30,
        width: 30,
        child: CircularProgressIndicator(),
      ),
    );
  }

 Widget componentText({required String title, required String hint, required TextEditingController controller, required String? Function(String? address) validator}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.heading6("$title"),
          SizedBox(height: 6),
          AppTextField(
              controller:controller,
              color: Colors.white,
              hText: hint,
              validator: validator,
          ),
        ],
      ),
    );
  }


}
