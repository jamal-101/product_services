import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';


class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFFAFAFA),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: false,
          // leading প্যাডিং এবং সাইজ অ্যাডজাস্ট করা হয়েছে
          leadingWidth: 56.w, // লিডিং এর জন্য নির্দিষ্ট উইডথ
          leading: Center(
            child: Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5EF), // ফিগমা কালার
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: IconButton(
                padding: EdgeInsets.zero, // আইকন যেন সেন্টারে থাকে
                icon: Icon(Icons.arrow_back, color: Colors.black, size: 20.sp),
                onPressed: () => Get.back(),
              ),
            ),
          ),
          title: Text(
            "Saved",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(70.h),
            child: Container(
              margin: EdgeInsets.all(16.w),
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F7F7),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: TabBar(
                dividerColor: Colors.transparent,
                indicatorPadding: EdgeInsets.symmetric(horizontal: -12.w),
                indicator: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                labelColor: Colors.black,
                unselectedLabelColor: const Color(0xFF7A818F),
                tabs: const [
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_bag, size: 18),
                        SizedBox(width: 8),
                        Text("Products Stores"),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.build, size: 18),
                        SizedBox(width: 8),
                        Text("Services Providers"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(children: [_buildStoreList(), _buildStoreList()]),
      ),
    );
  }

  Widget _buildStoreList() {
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 12.h),
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(width: 1.w,color: Color(0xFFECECF0))
          ),
          child: Row(
            children: [
              Container(
                width: 50.w,
                height: 50.w,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Store Name",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Category • Location",
                      style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.orange, size: 14.sp),
                      Text(" 4.9"),
                    ],
                  ),
                  Icon(Icons.bookmark, color: Colors.orange),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
