// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class CustomerListDesign extends StatefulWidget {
//   const CustomerListDesign({Key? key}) : super(key: key);
//
//   @override
//   _CustomerListState createState() => _CustomerListState();
// }
//
// class _CustomerListState extends State<CustomerListDesign> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Customer List"),
//         backgroundColor: Colors.green,
//       ),
//       body: Column(
//         children: [
//           const SizedBox(height: 10,),
//           //const SearchField(),
//           Expanded(
//
//             child:
//             _buildCard(),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// Widget _buildCard() {
//   return Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
//     child: Card(
//       elevation: 4.0,
//       child: ListView(
//         children: [
//           const SizedBox(height: 15,),
//           ListTile(
//             leading: Image.asset("assets/images/users/avatar.png"),
//             title: const Text("Phan Mai Nhu Y",style: TextStyle(fontSize: 17),),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: const [
//                 Text('Phone: '+'094846240'),
//                 Text('Email: '+'baotiantu@gmail.com'),
//                 Text('CMND: '+'215935846')
//               ],
//             ),
//             trailing: GestureDetector(
//               child: const Icon(
//                 Icons.navigate_next,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//           const SizedBox(height: 15,),
//           ListTile(
//             leading: Image.asset("assets/images/users/doctor.png"),
//             title: const Text("Tran Quoc Tuan",style: TextStyle(fontSize: 17),),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: const [
//                 Text('Phone: '+'094846241'),
//                 Text('Email: '+'tuan@gmail.com'),
//                 Text('CMND: '+'215935856')
//               ],
//             ),
//             trailing: GestureDetector(
//               child: const Icon(
//                 Icons.navigate_next,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//           const SizedBox(height: 15,),
//           ListTile(
//             leading: Image.asset("assets/images/users/hacker.png"),
//             title: const Text("Nguyen Le Thanh",style: TextStyle(fontSize: 17),),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: const [
//                 Text('Phone: '+'094846244'),
//                 Text('Email: '+'thanh@gmail.com'),
//                 Text('CMND: '+'215935846')
//               ],
//             ),
//             trailing: GestureDetector(
//               child: const Icon(
//                 Icons.navigate_next,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//           const SizedBox(height: 15,),
//           ListTile(
//             leading: Image.asset("assets/images/users/user1.png"),
//             title: const Text("Ngo Nguyen Linh Hao",style: TextStyle(fontSize: 17),),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: const [
//                 Text('Phone: '+'0379059969'),
//                 Text('Email: '+'haonguyenngo@gmail.com'),
//                 Text('CMND: '+'215935846')
//               ],
//             ),
//             trailing: GestureDetector(
//               child: const Icon(
//                 Icons.navigate_next,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//           const SizedBox(height: 15,),
//           ListTile(
//             leading: Image.asset("assets/images/users/businessman.png"),
//             title: const Text("Tran Quoc Toan",style: TextStyle(fontSize: 17),),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: const [
//                 Text('Phone: '+'094846223'),
//                 Text('Email: '+'toan@gmail.com'),
//                 Text('CMND: '+'215935846')
//               ],
//             ),
//             trailing: GestureDetector(
//               child: const Icon(
//                 Icons.navigate_next,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//           const SizedBox(height: 15,),
//           ListTile(
//             leading: Image.asset("assets/images/users/boy.png"),
//             title: const Text("Vu Van Tuy",style: TextStyle(fontSize: 17),),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: const [
//                 Text('Phone: '+'094846240'),
//                 Text('Email: '+'tuy@gmail.com'),
//                 Text('CMND: '+'215935846')
//               ],
//             ),
//             trailing: GestureDetector(
//               child: const Icon(
//                 Icons.navigate_next,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//           const SizedBox(height: 15,),
//           ListTile(
//             leading: Image.asset("assets/images/users/wizard.png"),
//             title: const Text("Le Thi Thanh Lam",style: TextStyle(fontSize: 17),),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: const [
//                 Text('Phone: '+'094846240'),
//                 Text('Email: '+'lam@gmail.com'),
//                 Text('CMND: '+'215935846')
//               ],
//             ),
//             trailing: GestureDetector(
//               child: const Icon(
//                 Icons.navigate_next,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//           const SizedBox(height: 15,),
//           ListTile(
//             leading: Image.asset("assets/images/users/gamer.png"),
//             title: const Text("Tran Quoc Tuan",style: TextStyle(fontSize: 17),),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: const [
//                 Text('Phone: '+'094846240'),
//                 Text('Email: '+'tuan@gmail.com'),
//                 Text('CMND: '+'215935846')
//               ],
//             ),
//             trailing: GestureDetector(
//               child: const Icon(
//                 Icons.navigate_next,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//           const SizedBox(height: 15,),
//           ListTile(
//             leading: Image.asset("assets/images/users/magician.png"),
//             title: const Text("Tran Thi Kim Xuan",style: TextStyle(fontSize: 17),),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: const [
//                 Text('Phone: '+'094846240'),
//                 Text('Email: '+'xuan@gmail.com'),
//                 Text('CMND: '+'215935846')
//               ],
//             ),
//             trailing: GestureDetector(
//               child: const Icon(
//                 Icons.navigate_next,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//           const SizedBox(height: 15,),
//           ListTile(
//             leading: Image.asset("assets/images/users/profile.png"),
//             title: const Text("Phan Manh Quynh",style: TextStyle(fontSize: 17),),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: const [
//                 Text('Phone: '+'094846240'),
//                 Text('Email: '+'baotiantu@gmail.com'),
//                 Text('CMND: '+'215935846')
//               ],
//             ),
//             trailing: GestureDetector(
//               child: const Icon(
//                 Icons.navigate_next,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//           const SizedBox(height: 15,),
//           ListTile(
//             leading: Image.asset("assets/images/users/male-teacher.png"),
//             title: const Text("Tran Quoc Thien",style: TextStyle(fontSize: 17),),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: const [
//                 Text('Phone: '+'094846240'),
//                 Text('Email: '+'baotiantu@gmail.com'),
//                 Text('CMND: '+'215935846')
//               ],
//             ),
//             trailing: GestureDetector(
//               child: const Icon(
//                 Icons.navigate_next,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//
//         ],
//       ),
//     ),
//   );
// }
