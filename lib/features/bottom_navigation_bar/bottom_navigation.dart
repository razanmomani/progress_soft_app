// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:progress_soft_app/core/helper/colors.dart';
// import 'package:progress_soft_app/core/widgets/general/custom_on_will_pop.dart';
// import 'package:progress_soft_app/features/home/view/home.dart';
// import 'package:progress_soft_app/features/post_profile/view/post_profile_view.dart';
// import 'package:progress_soft_app/features/profile/view/profile_screen.dart';
//
// class ScreenBottomNavigations extends StatefulWidget {
//   ScreenBottomNavigations({
//     super.key,
//   });
//
//   @override
//   State<ScreenBottomNavigations> createState() =>
//       _ScreenBottomNavigationsState();
// }
//
// final pages = [
//   HomeScreen(),
//   ProfileScreens(),
//   PostProfileView(),
// ];
//
// class _ScreenBottomNavigationsState extends State<ScreenBottomNavigations> {
//   int page = 0;
//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: false,
//       onPopInvoked: (_) => onPopInvoked(context),
//       child: Scaffold(
//         bottomNavigationBar: CurvedNavigationBar(
//           index: 0,
//           backgroundColor: AColors.textWhite,
//
//           items: const <Widget>[
//             Icon(
//               Icons.home_outlined,
//               color: Colors.white,
//             ),
//             Icon(
//               Icons.person,
//               color: Colors.white,
//             ),
//             Icon(
//               Icons.account_box_outlined,
//               color: Colors.white,
//             )
//           ],
//           color: AColors.primary,
//           //   buttonBackgroundColor: AColors.textWhite.withOpacity(0.5),
//           animationCurve: Curves.easeInOut,
//           animationDuration: const Duration(milliseconds: 600),
//           onTap: (index) {
//             setState(() {
//               page = index;
//             });
//           },
//           letIndexChange: (index) => true,
//         ),
//         //backgroundColor: Colors.black12.withOpacity(0.05),
//         backgroundColor: AColors.textWhite,
//         body: pages[page],
//       ),
//     );
//   }
// }

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_soft_app/core/helper/colors.dart';
import 'package:progress_soft_app/core/widgets/general/custom_on_will_pop.dart';
import 'package:progress_soft_app/features/bottom_navigation_bar/cubit/screen_bottom_nav_cubit.dart';
import 'package:progress_soft_app/features/home/view/home.dart';
import 'package:progress_soft_app/features/profile/view/profile_screen.dart';

class ScreenBottomNavigations extends StatelessWidget {
  const ScreenBottomNavigations({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeScreen(),
      ProfileScreens(),
    ];
    return BlocProvider(
      create: (_) => BottomNavCubit(),
      child: PopScope(
        canPop: false,
        onPopInvoked: (_) => onPopInvoked(context),
        child: Scaffold(
          bottomNavigationBar: BlocBuilder<BottomNavCubit, int>(
            builder: (context, currentIndex) {
              return CurvedNavigationBar(
                index: currentIndex,
                backgroundColor: AColors.textWhite,
                items: const <Widget>[
                  Icon(
                    Icons.home_outlined,
                    color: Colors.white,
                  ),
                  Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ],
                color: AColors.primary,
                animationCurve: Curves.easeInOut,
                animationDuration: const Duration(milliseconds: 600),
                onTap: (index) {
                  context.read<BottomNavCubit>().changePage(index);
                },
              );
            },
          ),
          backgroundColor: AColors.textWhite,
          body: BlocBuilder<BottomNavCubit, int>(
            builder: (context, currentIndex) {
              return pages[currentIndex];
            },
          ),
        ),
      ),
    );
  }
}


















// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:progress_soft_app/core/helper/colors.dart';
// import 'package:progress_soft_app/core/widgets/general/custom_on_will_pop.dart';
// import 'package:progress_soft_app/features/home/view/home.dart';
// import 'package:progress_soft_app/features/profile/view/profile_screen.dart';
//
// class ScreenBottomNavigations extends StatefulWidget {
//   const ScreenBottomNavigations({
//     super.key,
//   });
//
//   @override
//   State<ScreenBottomNavigations> createState() =>
//       _ScreenBottomNavigationsState();
// }
//
// class _ScreenBottomNavigationsState extends State<ScreenBottomNavigations> {
//   int page = 0;
//
//   late final List<Widget> pages;
//
//   @override
//   void initState() {
//     super.initState();
//     pages = [
//       HomeScreen(),
//       ProfileScreens(),
//     ];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: false,
//       onPopInvoked: (_) => onPopInvoked(context),
//       child: Scaffold(
//         bottomNavigationBar: CurvedNavigationBar(
//           index: 0,
//           backgroundColor: AColors.textWhite,
//           items: const <Widget>[
//             Icon(
//               Icons.home_outlined,
//               color: Colors.white,
//             ),
//             Icon(
//               Icons.person,
//               color: Colors.white,
//             ),
//           ],
//           color: AColors.primary,
//           animationCurve: Curves.easeInOut,
//           animationDuration: const Duration(milliseconds: 600),
//           onTap: (index) {
//             setState(() {
//               page = index;
//             });
//           },
//           letIndexChange: (index) => true,
//         ),
//         backgroundColor: AColors.textWhite,
//         body: pages[page],
//       ),
//     );
//   }
// }
//
