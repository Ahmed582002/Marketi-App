import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/features/Presentation/view/widgets/custom_button.dart';
import 'package:store/features/Presentation/view/widgets/custom_profile_button.dart';
import 'package:store/features/Presentation/viewModel/cubit/home/cubit/profile_cubit.dart';
import 'package:store/features/Presentation/viewModel/cubit/home/state/profile_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final cubit = context.read<ProfileCubit>();

        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final user = state.user;

        if (user == null) {
          return const Center(child: Text("No user data"));
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView(
            children: [
              GestureDetector(
                onTap: () {
                  cubit.pickAndUploadImage();
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const CircleAvatar(
                    radius: 60,
                    child: Icon(Icons.camera_alt_sharp),
                  ),
                ),
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.02),

              Center(
                child: Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.02),

              Center(child: Text(user.email)),

              SizedBox(height: MediaQuery.of(context).size.height * 0.02),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 90),
                child: CustomButton(text: "Edit Profile", onPressed: () {}),
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.02),

              CustomProfileButton(text: "Cart History", onPressed: () {}),
              CustomProfileButton(text: "Language", onPressed: () {}),
              CustomProfileButton(text: "Settings", onPressed: () {}),

              SizedBox(height: MediaQuery.of(context).size.height * 0.04),

              GestureDetector(
                onTap: () {
                  // logout logic here
                },
                child: Text(
                  "Log Out",
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontSize: 16,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
