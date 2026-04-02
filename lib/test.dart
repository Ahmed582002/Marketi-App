import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    // UserRepository userRepository = UserRepository(
    //   api: context.read<UserCubit>().userRepository.api,
    // );

    return Scaffold();
  }
}



// Center(
//         child: BlocConsumer<UserCubit, UserState>(
//           listener: (context, state) {},
//           builder: (context, state) {
//             return SizedBox(
//               height: 120,
//               width: 120,
//               child: context.read<UserCubit>().profilePic == null
//                   ? GestureDetector(
//                       onTap: () {
//                         ImagePicker()
//                             .pickImage(source: ImageSource.gallery)
//                             .then(
//                               (value) => context
//                                   .read<UserCubit>()
//                                   .uploadProfilePic(value!),
//                             );
//                       },
//                       child: Container(
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           border: Border.all(color: Colors.white, width: 2),
//                         ),
//                         child: CircleAvatar(
//                           radius: 60,
//                           child: Icon(Icons.camera_alt_sharp),
//                         ),
//                       ),
//                     )
//                   : CircleAvatar(
//                       radius: 60,
//                       backgroundImage: FileImage(
//                         File(context.read<UserCubit>().profilePic!.path),
//                       ),
//                     ),
//             );
//           },
//         ),
//       ),