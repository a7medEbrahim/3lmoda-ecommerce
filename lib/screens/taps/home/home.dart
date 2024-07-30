import 'package:almoda/core/app_images.dart';
import 'package:almoda/core/extensions.dart';
import 'package:almoda/core/text_style.dart';
import 'package:almoda/screens/taps/home/categories_cubit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoriesCubit()..getAllCategory(),
      child: BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, state) {
          final cubit = context.read<CategoriesCubit>();

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    viewportFraction: 1.0,
                    autoPlay: true,
                    initialPage: 0,
                  ),
                  items: [AppImages.ads3, AppImages.ads2, AppImages.ads1]
                      .map((image) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Image.asset(
                          image,
                        );
                      },
                    );
                  }).toList(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Categories',
                        style: Poppins.w500.getStyle(
                            fontSize: 18, color: context.colorS.primary),
                      ),
                      InkWell(
                        child: Text(
                          'view all',
                          style: Poppins.w400
                              .getStyle(fontSize: 12, color: Colors.black54),
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  height: 240.h, // Define a fixed height for the GridView
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: .75, //
                    ),
                    itemCount: cubit.categories.length,
                    itemBuilder: (context, index) {
                      final category = cubit.categories[index];
                      return Column(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              category.image,
                            ),
                            radius: 40.0,
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            category.name,
                            style: Poppins.w400.getStyle(fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
