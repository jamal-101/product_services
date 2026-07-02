// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:product_service/config/route/app_route.dart';
// import 'package:product_service/utils/constants/app_color.dart';
//
// class EditProfileScreen extends StatelessWidget {
//   const EditProfileScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         surfaceTintColor: Colors.white,
//         elevation: 0,
//         centerTitle: false,
//         leading: Padding(
//           padding: EdgeInsets.only(left: 16.w, top: 8.h, bottom: 8.h),
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.grey.shade50,
//               borderRadius: BorderRadius.circular(12.r),
//               border: Border.all(color: Colors.grey.shade100),
//             ),
//             child: IconButton(
//               icon: const Icon(Icons.arrow_back, color: Colors.black, size: 20),
//               onPressed: () => Navigator.pop(context),
//             ),
//           ),
//         ),
//         title: Text(
//           "Edit Profile",
//           style: GoogleFonts.montserrat(
//             color: Colors.black,
//             fontSize: 18.sp,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
//         child: Column(
//           children: [
//             // প্রোফাইল ছবি
//             Center(
//               child: Stack(
//                 children: [
//                   CircleAvatar(
//                     radius: 50.r,
//                     backgroundImage: const AssetImage(
//                       'assets/images/profile.png',
//                     ),
//                   ),
//                   Positioned(
//                     bottom: 0,
//                     right: 0,
//                     child: Container(
//                       padding: EdgeInsets.all(6.r),
//                       decoration: const BoxDecoration(
//                         color: Color(0xFF27AE60),
//                         shape: BoxShape.circle,
//                         border: Border.fromBorderSide(
//                           BorderSide(color: Colors.white, width: 2),
//                         ),
//                       ),
//                       child: Icon(
//                         Icons.camera_alt,
//                         color: Colors.white,
//                         size: 16.sp,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 12.h),
//             Text(
//               "Tap to change profile photo",
//               style: GoogleFonts.montserrat(
//                 color: Colors.grey.shade600,
//                 fontSize: 12.sp,
//               ),
//             ),
//             SizedBox(height: 25.h),
//
//             // কার্ড কন্টেইনার
//             Container(
//               padding: EdgeInsets.all(15.w),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20.r),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.05),
//                     blurRadius: 10,
//                     offset: const Offset(0, 5),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   _buildTextField(
//                     "Full Name",
//                     "Sazzad Chowdhury",
//                     Icons.person_outline,
//                   ),
//                   _buildTextField(
//                     "Email Address",
//                     "sarah.j@email.com",
//                     Icons.email_outlined,
//                   ),
//                   _buildTextField(
//                     "Phone Number",
//                     "+1 (555) 123-4567",
//                     Icons.phone_outlined,
//                   ),
//                   _buildAddressSection(),
//                 ],
//               ),
//             ),
//             SizedBox(height: 30.h),
//
//             // সেভ বাটন
//             SizedBox(
//               width: double.infinity,
//               height: 55.h,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF27AE60),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15.r),
//                   ),
//                 ),
//                 onPressed: () {
//                   Get.toNamed(AppRoutes.accountScreen);
//                 },
//                 child: Text(
//                   "Save Changes",
//                   style: GoogleFonts.montserrat(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16.sp,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20.h),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextField(String label, String hint, IconData icon) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Icon(icon, size: 16.sp, color: Colors.orange.shade800),
//             SizedBox(width: 8.w),
//             Text(
//               label,
//               style: GoogleFonts.montserrat(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 13.sp,
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 8.h),
//         TextField(
//           decoration: InputDecoration(
//             hintText: hint,
//             contentPadding: EdgeInsets.symmetric(
//               horizontal: 15.w,
//               vertical: 15.h,
//             ),
//             filled: true,
//             fillColor: Colors.grey.shade50,
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12.r),
//               borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12.r),
//               borderSide: const BorderSide(
//                 color: Color(0xFF27AE60),
//                 width: 1.5,
//               ),
//             ),
//           ),
//         ),
//         SizedBox(height: 15.h),
//       ],
//     );
//   }
//
//   Widget _buildAddressSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Icon(
//               Icons.location_on_outlined,
//               size: 16.sp,
//               color: Colors.orange.shade800,
//             ),
//             SizedBox(width: 8.w),
//             Text(
//               "Address",
//               style: GoogleFonts.montserrat(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 14.sp,
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 8.h),
//         Text(
//           "Country",
//           style: GoogleFonts.montserrat(
//             fontSize: 14.sp,
//             color: Color(0xFF7A818F),
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         SizedBox(height: 5.h),
//         DropdownButtonFormField<String>(
//           decoration: InputDecoration(
//             contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
//             filled: true,
//             fillColor: Colors.grey.shade50,
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12.r),
//               borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12.r),
//               borderSide: const BorderSide(
//                 color: Color(0xFF27AE60),
//                 width: 1.5,
//               ),
//             ),
//           ),
//           hint: Text(
//             "Select your City",
//             style: GoogleFonts.montserrat(fontSize: 14.sp),
//           ),
//           items: ["Dhaka", "Chittagong"]
//               .map((city) => DropdownMenuItem(value: city, child: Text(city)))
//               .toList(),
//           onChanged: (v) {},
//         ),
//         SizedBox(height: 10.h),
//         Text(
//           "Postal Code",
//           style: GoogleFonts.montserrat(
//             fontSize: 14.sp,
//             color: Color(0xFF7A818F),
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         SizedBox(height: 5.h),
//         TextField(
//           decoration: InputDecoration(
//             hintText: "Enter your postal code",
//             contentPadding: EdgeInsets.symmetric(
//               horizontal: 15.w,
//               vertical: 15.h,
//             ),
//             filled: true,
//             fillColor: Colors.grey.shade50,
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12.r),
//               borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12.r),
//               borderSide: const BorderSide(
//                 color: Color(0xFF27AE60),
//                 width: 1.5,
//               ),
//             ),
//           ),
//         ),
//         SizedBox(height: 10.h),
//         Text(
//           "Streat Address",
//           style: GoogleFonts.montserrat(
//             fontSize: 14.sp,
//             color: Color(0xFF7A818F),
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         SizedBox(height: 5.h),
//         TextField(
//           maxLines: 2,
//           decoration: InputDecoration(
//             hintText: "e.g House 12, Road 5, Block B",
//             contentPadding: EdgeInsets.all(15.w),
//             filled: true,
//             fillColor: Colors.grey.shade50,
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12.r),
//               borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12.r),
//               borderSide: const BorderSide(
//                 color: Color(0xFF27AE60),
//                 width: 1.5,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_service/config/route/app_route.dart';
import 'package:product_service/utils/constants/app_string.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _postalController = TextEditingController();
  final _streetController = TextEditingController();

  final RxnString _selectedCity = RxnString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w, top: 8.h, bottom: 8.h),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey.shade100),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: Text(
          AppString.editeProfile,
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50.r,
                      backgroundImage: const AssetImage(
                        'assets/images/profile.png',
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(6.r),
                        decoration: const BoxDecoration(
                          color: Color(0xFF27AE60),
                          shape: BoxShape.circle,
                          border: Border.fromBorderSide(
                            BorderSide(color: Colors.white, width: 2),
                          ),
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 16.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                AppString.tapToChange,
                style: GoogleFonts.montserrat(
                  color: Colors.grey.shade600,
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(height: 25.h),
              Container(
                padding: EdgeInsets.all(15.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildTextField(
                      label: "Full Name",
                      hint: "Enter your full name",
                      icon: Icons.person_outline,
                      controller: _nameController,
                    ),
                    _buildTextField(
                      label: "Email Address",
                      hint: "Enter your email",
                      icon: Icons.email_outlined,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      isEmail: true,
                    ),
                    _buildTextField(
                      label: "Phone Number",
                      hint: "Enter your phone number",
                      icon: Icons.phone_outlined,
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                    ),
                    _buildAddressSection(),
                  ],
                ),
              ),
              SizedBox(height: 30.h),

              // সেভ বাটন
              SizedBox(
                width: double.infinity,
                height: 55.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF27AE60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                  ),
                  onPressed: () {
                    // ভ্যালিডেশন চেক
                    if (_formKey.currentState!.validate()) {
                      Get.toNamed(AppRoutes.accountScreen);
                    } else {
                      Get.snackbar(
                        "Error",
                        "Please fill all the required fields",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.redAccent,
                        colorText: Colors.white,
                      );
                    }
                  },
                  child: Text(
                    "Save Changes",
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    bool isEmail = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16.sp, color: Colors.orange.shade800),
            SizedBox(width: 8.w),
            RichText(
              text: TextSpan(
                text: label,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.sp,
                  color: Colors.black,
                ),
                children: const [
                  TextSpan(text: ' *', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return "$label is required";
            }
            if (isEmail && !GetUtils.isEmail(value.trim())) {
              return "Enter a valid email address";
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: hint,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 15.h,
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
            errorStyle: GoogleFonts.montserrat(fontSize: 11.sp, color: Colors.red),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
                color: Color(0xFF27AE60),
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
          ),
        ),
        SizedBox(height: 15.h),
      ],
    );
  }

  Widget _buildAddressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 16.sp,
              color: Colors.orange.shade800,
            ),
            SizedBox(width: 8.w),
            Text(
             AppString.address,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 13.sp,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        RichText(
          text: TextSpan(
            text: AppString.city,
            style: GoogleFonts.montserrat(fontSize: 11.sp, color: Colors.grey),
            children: const [
              TextSpan(text: ' *', style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
        SizedBox(height: 5.h),
        Obx(
              () => DropdownButtonFormField<String>(
            value: _selectedCity.value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return ;
              }
              return null;
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
              filled: true,
              fillColor: Colors.grey.shade50,
              errorStyle: GoogleFonts.montserrat(fontSize: 11.sp, color: Colors.red),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(
                  color: Color(0xFF27AE60),
                  width: 1.5,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(color: Colors.red, width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(color: Colors.red, width: 1.5),
              ),
            ),
            hint: Text(
              AppString.selectYourCity,
              style: GoogleFonts.montserrat(fontSize: 14.sp),
            ),
            items: ["Dhaka", "Chittagong"]
                .map((city) => DropdownMenuItem(value: city, child: Text(city)))
                .toList(),
            onChanged: (v) {
              _selectedCity.value = v;
            },
          ),
        ),
        SizedBox(height: 10.h),
        RichText(
          text: TextSpan(
            text: AppString.postalCode,
            style: GoogleFonts.montserrat(fontSize: 11.sp, color: Colors.grey),
            children: const [
              TextSpan(text: ' *', style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
        SizedBox(height: 5.h),
        TextFormField(
          controller: _postalController,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return "Postal Code is required";
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: AppString.enterYourPostal,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 15.h,
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
            errorStyle: GoogleFonts.montserrat(fontSize: 11.sp, color: Colors.red),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
                color: Color(0xFF27AE60),
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        RichText(
          text: TextSpan(
            text: AppString.streetAddress,
            style: GoogleFonts.montserrat(fontSize: 11.sp, color: Colors.grey),
            children: const [
              TextSpan(text: ' *', style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
        SizedBox(height: 5.h),
        TextFormField(
          controller: _streetController,
          maxLines: 2,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return "Street Address is required";
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: "e.g House 12, Road 5, Block B",
            contentPadding: EdgeInsets.all(15.w),
            filled: true,
            fillColor: Colors.grey.shade50,
            errorStyle: GoogleFonts.montserrat(fontSize: 11.sp, color: Colors.red),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
                color: Color(0xFF27AE60),
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}