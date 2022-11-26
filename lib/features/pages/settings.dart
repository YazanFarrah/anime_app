// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class Settings extends StatefulWidget {
//   const Settings({Key? key}) : super(key: key);

//   @override
//   _SettingsState createState() => _SettingsState();
// }

// class _SettingsState extends State<Settings> {
//   final scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         automaticallyImplyLeading: false,
//         title: const Align(
//           alignment: AlignmentDirectional(0, 0),
//           child: Text(
//             'Privacy & Settings',
//             textAlign: TextAlign.start,
//             style: TextStyle(
//               color: Color(0xFF2E99C7),
//               fontSize: 22,
//             ),
//           ),
//         ),
//         centerTitle: false,
//         elevation: 2,
//       ),
//       body: SafeArea(
//         child: GestureDetector(
//           onTap: () => FocusScope.of(context).unfocus(),
//           child: Column(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisSize: MainAxisSize.max,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Icon(
//                     Icons.location_history,
//                     color: Colors.black,
//                     size: 25,
//                   ),
//                   Text(
//                     'Manage my account',
//                     style: TextStyle(
//                       fontFamily: 'Poppins',
//                       color: Colors.grey,
//                       fontSize: 22,
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisSize: MainAxisSize.max,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.lock_outline,
//                     color: Colors.black,
//                     size: 25,
//                   ),
//                   Align(
//                     alignment: AlignmentDirectional(0, 0),
//                     child: Text(
//                       'Privacy and safety',
//                       style: TextStyle(
//                         fontFamily: 'Poppins',
//                         color: Color(0xFF2E99C7),
//                         fontSize: 22,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisSize: MainAxisSize.max,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Icon(
//                     Icons.language_outlined,
//                     color: Colors.black,
//                     size: 25,
//                   ),
//                   Align(
//                     alignment: AlignmentDirectional(-0.8, 0),
//                     child: Text(
//                       'Language',
//                       style: TextStyle(
//                         fontFamily: 'Poppins',
//                         color: Color(0xFF2E99C7),
//                         fontSize: 22,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisSize: MainAxisSize.max,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Icon(
//                     Icons.wb_sunny_outlined,
//                     color: Colors.black,
//                     size: 25,
//                   ),
//                   Align(
//                     alignment: AlignmentDirectional(-0.8, 0),
//                     child: Text(
//                       'Dark mode',
//                       style: TextStyle(
//                         fontFamily: 'Poppins',
//                         color: Color(0xFF2E99C7),
//                         fontSize: 22,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisSize: MainAxisSize.max,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Icon(
//                     Icons.ios_share,
//                     color: Colors.black,
//                     size: 25,
//                   ),
//                   Align(
//                     alignment: AlignmentDirectional(-0.8, 0),
//                     child: Text(
//                       'Share profile',
//                       style: TextStyle(
//                         fontFamily: 'Poppins',
//                         color: Color(0xFF2E99C7),
//                         fontSize: 22,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Divider(
//                 color: Colors.grey,
//               ),
//               Text(
//                 'Support',
//                 style: TextStyle(
//                   fontFamily: 'Poppins',
//                   color: Color(0xFF2E99C7),
//                   fontSize: 22,
//                 ),
//               ),
//               Row(
//                 mainAxisSize: MainAxisSize.max,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Icon(
//                     Icons.outlined_flag_rounded,
//                     color: Colors.black,
//                     size: 25,
//                   ),
//                   Align(
//                     alignment: AlignmentDirectional(-0.8, 0),
//                     child: Text(
//                       'Report a problem',
//                       style: TextStyle(
//                         fontFamily: 'Poppins',
//                         color: Color(0xFF2E99C7),
//                         fontSize: 22,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisSize: MainAxisSize.max,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Icon(
//                     Icons.help_outline,
//                     color: Colors.black,
//                     size: 25,
//                   ),
//                   Align(
//                     alignment: AlignmentDirectional(-0.8, 0),
//                     child: Text(
//                       'Help',
//                       style: TextStyle(
//                         fontFamily: 'Poppins',
//                         color: Color(0xFF2E99C7),
//                         fontSize: 22,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisSize: MainAxisSize.max,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Icon(
//                     Icons.info_outline,
//                     color: Colors.black,
//                     size: 25,
//                   ),
//                   Align(
//                     alignment: AlignmentDirectional(-0.8, 0),
//                     child: Text(
//                       'About',
//                       style: TextStyle(
//                         fontFamily: 'Poppins',
//                         color: Color(0xFF2E99C7),
//                         fontSize: 22,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Divider(
//                 color: Colors.grey,
//               ),
//               Text(
//                 'Login',
//                 style: TextStyle(
//                   fontFamily: 'Poppins',
//                   color: Color(0xFF2E99C7),
//                   fontSize: 22,
//                 ),
//               ),
//               Row(
//                 mainAxisSize: MainAxisSize.max,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Align(
//                     alignment: AlignmentDirectional(-0.8, 0),
//                     child: Text(
//                       'Log out',
//                       style: TextStyle(
//                         fontFamily: 'Poppins',
//                         color: Color(0xFF2E99C7),
//                         fontSize: 22,
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: 40,
//                     height: 40,
//                     clipBehavior: Clip.antiAlias,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                     ),
//                     child: Image.network(
//                       'https://picsum.photos/seed/939/600',
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () {},
//                     icon: Icon(Icons.arrow_forward_ios_sharp),
//                   )
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
