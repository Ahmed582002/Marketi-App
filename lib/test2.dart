// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:store/cubit/user_cubit.dart';
// import 'package:store/navbar.dart';
// import 'package:store/repositories/user_repository.dart';

// class Test2 extends StatefulWidget {
//   const Test2({super.key});

//   @override
//   State<Test2> createState() => _Test2State();
// }

// class _Test2State extends State<Test2> {
//   UserRepository userRepository = UserRepository(
//       api: context.read<UserCubit>().userRepository.api,
//     );
//   int currentIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: CustomBottomNavBar(
//         currentIndex: currentIndex,
//         onTap: (index) {
//           setState(() {
//             currentIndex = index;
//           });
//         },
//       ),
//       body: BlocConsumer<UserCubit, UserState>(
//         listener: (context, state) {},
//         builder: (context, state) {
//           return Center(
//             child: ElevatedButton(
//               onPressed: () async {
//                 await userRepository
//                     .signIn(
//                       email: "ahmedragab0680@gmail.com",
//                       password: "Ahmed1234@",
//                     )
//                     .then(
//                       (value) => value.fold(
//                         (errMessage) => print("error: $errMessage"),
//                         (signInModel) => print("token: ${signInModel.token}"),
//                       ),
//                     );
//               },
//               child: const Text('Test'),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
