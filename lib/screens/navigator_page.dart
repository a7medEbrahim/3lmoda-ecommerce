import 'package:almoda/core/app_images.dart';
import 'package:almoda/core/extensions.dart';
import 'package:almoda/screens/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class NavigatorPage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const NavigatorPage({
    super.key,
    required this.navigationShell,
  });

  void goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          AppIcons.logoIcon,
          colorFilter: context.colorS.primary.svgColor,
          width: 66.w,
          height: 22.h,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        // backgroundColor: Colors.white,
        backgroundColor: context.colorS.primary,
        currentIndex: navigationShell.currentIndex,
        onTap: goBranch,
        items: [
          BottomNavigationBarItem(
              icon: _buildIcon(
                  context: context,
                  assetName: AppIcons.homeBar,
                  isSelected: navigationShell.currentIndex == 0),
              label: ''),
          BottomNavigationBarItem(
              icon: _buildIcon(
                  context: context,
                  assetName: AppIcons.categoryBar,
                  isSelected: navigationShell.currentIndex == 1),
              label: ''),
          BottomNavigationBarItem(
              icon: _buildIcon(
                  context: context,
                  assetName: AppIcons.wishlistBar,
                  isSelected: navigationShell.currentIndex == 2),
              label: ''),
          BottomNavigationBarItem(
              icon: _buildIcon(
                  context: context,
                  assetName: AppIcons.profileBar,
                  isSelected: navigationShell.currentIndex == 3),
              label: ''),
        ],
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          final cubit = context.read<AuthCubit>();
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(17.0).w,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 13.h, horizontal: 24.w),
                              child: SvgPicture.asset(AppIcons.search),
                            ),
                            hintText: 'what do you search for?',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: Colors.white))),
                      ),
                    ),
                    SizedBox(width: 24.w),
                    SvgPicture.asset(AppIcons.cart)
                  ],
                ),
              ),
              Flexible(child: navigationShell),
            ],
          );
        },
      ),
    );
  }

  Widget _buildIcon(
      {required String assetName,
      required bool isSelected,
      required BuildContext context}) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: isSelected
          ? BoxDecoration(
              color: Colors.white,
              // border: Border.all(color: Colors.white, width: 2.0),
              borderRadius: BorderRadius.circular(100),
            )
          : null,
      child: SvgPicture.asset(
        assetName,
        width: isSelected ? 30 : 20,
        height: isSelected ? 30 : 20,
        color: isSelected ? context.colorS.primary : Colors.white,
      ),
    );
  }
}
