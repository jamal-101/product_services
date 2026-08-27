// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:product_service/utils/constants/app_string.dart';
// import '../controller/edite_profile_controller.dart';
//
// class EditProfileScreen extends StatelessWidget {
//   const EditProfileScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(EditProfileController());
//
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           surfaceTintColor: Colors.white,
//           elevation: 0,
//           centerTitle: false,
//           leading: Padding(
//             padding: EdgeInsets.only(left: 16.w, top: 8.h, bottom: 8.h),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade50,
//                 borderRadius: BorderRadius.circular(12.r),
//                 border: Border.all(color: Colors.grey.shade100),
//               ),
//               child: IconButton(
//                 icon: const Icon(Icons.arrow_back, color: Colors.black, size: 20),
//                 onPressed: () => Navigator.pop(context),
//               ),
//             ),
//           ),
//           title: Text(
//             AppString.editeProfile,
//             style: GoogleFonts.montserrat(
//               color: Colors.black,
//               fontSize: 18.sp,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//         body: Obx(() => controller.isLoading.value
//             ? const Center(child: CircularProgressIndicator(color: Color(0xFF27AE60)))
//             : SingleChildScrollView(
//           padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
//           child: Form(
//             key: controller.formKey,
//             child: Column(
//               children: [
//                 Center(
//                   child: GestureDetector(
//                     onTap: () => controller.pickImage(),
//                     child: Stack(
//                       children: [
//                         Obx(() => CircleAvatar(
//                           radius: 50.r,
//                           backgroundImage: controller.selectedImage.value != null
//                               ? FileImage(controller.selectedImage.value!) as ImageProvider
//                               : (controller.profileImageUrl.value.isNotEmpty
//                               ? NetworkImage("http://10.10.7.10:5009${controller.profileImageUrl.value}") as ImageProvider
//                               : const AssetImage('assets/images/profile.png') as ImageProvider),
//                         )),
//                         Positioned(
//                           bottom: 0,
//                           right: 0,
//                           child: Container(
//                             padding: EdgeInsets.all(6.r),
//                             decoration: const BoxDecoration(
//                               color: Color(0xFF27AE60),
//                               shape: BoxShape.circle,
//                               border: Border.fromBorderSide(
//                                 BorderSide(color: Colors.white, width: 2),
//                               ),
//                             ),
//                             child: Icon(
//                               Icons.camera_alt,
//                               color: Colors.white,
//                               size: 16.sp,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 12.h),
//                 Text(
//                   AppString.tapToChange,
//                   style: GoogleFonts.montserrat(
//                     color: Colors.grey.shade600,
//                     fontSize: 12.sp,
//                   ),
//                 ),
//                 SizedBox(height: 25.h),
//
//                 // ইনপুট ফিল্ড কন্টেইনার
//                 Container(
//                   padding: EdgeInsets.all(15.w),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(20.r),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withValues(alpha: 0.05),
//                         blurRadius: 10,
//                         offset: const Offset(0, 5),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     children: [
//                       _buildTextField(
//                         label: "Full Name",
//                         hint: "Enter your full name",
//                         icon: Icons.person_outline,
//                         controller: controller.nameController,
//                       ),
//                       _buildTextField(
//                         label: "Email Address",
//                         hint: "Enter your email",
//                         icon: Icons.email_outlined,
//                         controller: controller.emailController,
//                         keyboardType: TextInputType.emailAddress,
//                         readOnly: true,
//                         isEmail: true,
//                       ),
//                       _buildTextField(
//                         label: "Phone Number",
//                         hint: "Enter your phone number",
//                         icon: Icons.phone_outlined,
//                         controller: controller.phoneController,
//                         keyboardType: TextInputType.phone,
//                       ),
//                       _buildAddressSection(controller),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 30.h),
//
//                 // সেভ বাটন
//                 SizedBox(
//                   width: double.infinity,
//                   height: 55.h,
//                   child: Obx(() => ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF27AE60),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15.r),
//                       ),
//                     ),
//                     onPressed: controller.isUpdateLoading.value
//                         ? null
//                         : () => controller.updateProfile(),
//                     child: controller.isUpdateLoading.value
//                         ? const CircularProgressIndicator(color: Colors.white)
//                         : Text(
//                       "Save Changes",
//                       style: GoogleFonts.montserrat(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16.sp,
//                       ),
//                     ),
//                   )),
//                 ),
//                 SizedBox(height: 20.h),
//               ],
//             ),
//           ),
//         ),
//         )
//         );
//     }
//
//   Widget _buildTextField({
//     required String label,
//     required String hint,
//     required IconData icon,
//     required TextEditingController controller,
//     TextInputType keyboardType = TextInputType.text,
//     bool isEmail = false,
//     bool readOnly = false,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Icon(icon, size: 16.sp, color: Colors.orange.shade800),
//             SizedBox(width: 8.w),
//             RichText(
//               text: TextSpan(
//                 text: label,
//                 style: GoogleFonts.montserrat(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 13.sp,
//                   color: Colors.black,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: readOnly ? '' : ' *',
//                     style: const TextStyle(color: Colors.red),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 8.h),
//         TextFormField(
//           controller: controller,
//           keyboardType: keyboardType,
//           readOnly: readOnly,
//           style: GoogleFonts.montserrat(
//             fontSize: 14.sp,
//             color: readOnly ? Colors.grey.shade600 : Colors.black,
//           ),
//           validator: (value) {
//             if (!readOnly && (value == null || value.trim().isEmpty)) {
//               return "$label is required";
//             }
//             if (isEmail && value != null && value.trim().isNotEmpty && !GetUtils.isEmail(value.trim())) {
//               return "Enter a valid email address";
//             }
//             return null;
//           },
//           decoration: InputDecoration(
//             hintText: hint,
//             contentPadding: EdgeInsets.symmetric(
//               horizontal: 15.w,
//               vertical: 15.h,
//             ),
//             filled: true,
//             fillColor: readOnly ? Colors.grey.shade200 : Colors.grey.shade50,
//             errorStyle: GoogleFonts.montserrat(fontSize: 11.sp, color: Colors.red),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12.r),
//               borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12.r),
//               borderSide: BorderSide(
//                 color: readOnly ? Colors.grey.shade300 : const Color(0xFF27AE60),
//                 width: 1.5,
//               ),
//             ),
//             errorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12.r),
//               borderSide: const BorderSide(color: Colors.red, width: 1),
//             ),
//             focusedErrorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12.r),
//               borderSide: const BorderSide(color: Colors.red, width: 1.5),
//             ),
//           ),
//         ),
//         SizedBox(height: 15.h),
//       ],
//     );
//   }
//
//   Widget _buildAddressSection(EditProfileController controller) {
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
//               AppString.address,
//               style: GoogleFonts.montserrat(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 13.sp,
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 8.h),
//
//         // City Field
//         RichText(
//           text: TextSpan(
//             text: AppString.city,
//             style: GoogleFonts.montserrat(fontSize: 11.sp, color: Colors.grey),
//             children: const [
//               TextSpan(text: ' *', style: TextStyle(color: Colors.red)),
//             ],
//           ),
//         ),
//         SizedBox(height: 5.h),
//         TextFormField(
//           controller: controller.cityController,
//           validator: (value) {
//             if (value == null || value.trim().isEmpty) {
//               return "City is required";
//             }
//             return null;
//           },
//           decoration: InputDecoration(
//             hintText: "Enter your city",
//             contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
//             filled: true,
//             fillColor: Colors.grey.shade50,
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12.r),
//               borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12.r),
//               borderSide: const BorderSide(color: Color(0xFF27AE60), width: 1.5),
//             ),
//           ),
//         ),
//         SizedBox(height: 10.h),
//
//         // Postal Code Field
//         RichText(
//           text: TextSpan(
//             text: AppString.postalCode,
//             style: GoogleFonts.montserrat(fontSize: 11.sp, color: Colors.grey),
//             children: const [
//               TextSpan(text: ' *', style: TextStyle(color: Colors.red)),
//             ],
//           ),
//         ),
//         SizedBox(height: 5.h),
//         TextFormField(
//           controller: controller.postalController,
//           keyboardType: TextInputType.number,
//           validator: (value) {
//             if (value == null || value.trim().isEmpty) {
//               return "Postal Code is required";
//             }
//             return null;
//           },
//           decoration: InputDecoration(
//             hintText: AppString.enterYourPostal,
//             contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
//             filled: true,
//             fillColor: Colors.grey.shade50,
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12.r),
//               borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12.r),
//               borderSide: const BorderSide(color: Color(0xFF27AE60), width: 1.5),
//             ),
//           ),
//         ),
//         SizedBox(height: 10.h),
//
//         // Street Address Field
//         RichText(
//           text: TextSpan(
//             text: AppString.streetAddress,
//             style: GoogleFonts.montserrat(fontSize: 11.sp, color: Colors.grey),
//             children: const [
//               TextSpan(text: ' *', style: TextStyle(color: Colors.red)),
//             ],
//           ),
//         ),
//         SizedBox(height: 5.h),
//         TextFormField(
//           controller: controller.streetController,
//           maxLines: 2,
//           validator: (value) {
//             if (value == null || value.trim().isEmpty) {
//               return "Street Address is required";
//             }
//             return null;
//           },
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
//               borderSide: const BorderSide(color: Color(0xFF27AE60), width: 1.5),
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
import 'package:product_service/utils/constants/app_string.dart';

import '../controller/edite_profile_controller.dart';


class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditProfileController());

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
          key: controller.formKey,
          child: Column(
            children: [
              // প্রোফাইল ছবি সেকশন
              Center(
                child: GestureDetector(
                  onTap: () => controller.pickImage(),
                  child: Stack(
                    children: [
                      Obx(() => CircleAvatar(
                        radius: 50.r,
                        backgroundImage: controller.selectedImage.value != null
                            ? FileImage(controller.selectedImage.value!) as ImageProvider
                            : (controller.profileImageUrl.value.isNotEmpty
                            ? NetworkImage("http://10.10.7.10:5009${controller.profileImageUrl.value}") as ImageProvider
                            : const AssetImage('assets/images/profile.png') as ImageProvider),
                      )),
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

              // ইনপুট ফিল্ড কন্টেইনার
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
                      controller: controller.nameController,
                    ),
                    _buildTextField(
                      label: "Email Address",
                      hint: "Enter your email",
                      icon: Icons.email_outlined,
                      controller: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                      readOnly: true,
                      isEmail: true,
                    ),
                    _buildTextField(
                      label: "Phone Number",
                      hint: "Enter your phone number",
                      icon: Icons.phone_outlined,
                      controller: controller.phoneController,
                      keyboardType: TextInputType.phone,
                    ),
                    _buildAddressSection(controller),
                  ],
                ),
              ),
              SizedBox(height: 30.h),

              // সেভ বাটন
              SizedBox(
                width: double.infinity,
                height: 55.h,
                child: Obx(() => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF27AE60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                  ),
                  onPressed: controller.isUpdateLoading.value
                      ? null
                      : () => controller.updateProfile(),
                  child: controller.isUpdateLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                    "Save Changes",
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                )),
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
    bool readOnly = false,
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
                children: [
                  TextSpan(
                    text: readOnly ? '' : ' *',
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          readOnly: readOnly,
          style: GoogleFonts.montserrat(
            fontSize: 14.sp,
            color: readOnly ? Colors.grey.shade600 : Colors.black,
          ),
          validator: (value) {
            if (!readOnly && (value == null || value.trim().isEmpty)) {
              return "$label is required";
            }
            if (isEmail && value != null && value.trim().isNotEmpty && !GetUtils.isEmail(value.trim())) {
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
            fillColor: readOnly ? Colors.grey.shade200 : Colors.grey.shade50,
            errorStyle: GoogleFonts.montserrat(fontSize: 11.sp, color: Colors.red),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: readOnly ? Colors.grey.shade300 : const Color(0xFF27AE60),
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

  Widget _buildAddressSection(EditProfileController controller) {
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

        // City Field
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
        TextFormField(
          controller: controller.cityController,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return "City is required";
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: "Enter your city",
            contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            filled: true,
            fillColor: Colors.grey.shade50,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFF27AE60), width: 1.5),
            ),
          ),
        ),
        SizedBox(height: 10.h),

        // Postal Code Field
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
          controller: controller.postalController,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return "Postal Code is required";
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: AppString.enterYourPostal,
            contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            filled: true,
            fillColor: Colors.grey.shade50,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFF27AE60), width: 1.5),
            ),
          ),
        ),
        SizedBox(height: 10.h),

        // Street Address Field
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
          controller: controller.streetController,
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
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFF27AE60), width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}