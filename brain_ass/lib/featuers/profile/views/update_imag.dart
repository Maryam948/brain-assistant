import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/featuers/profile/cubit/profile_cubit.dart';
import 'package:untitled3/widgets/screenunits.dart';

class UpdateImage extends StatefulWidget {
  static const String routeName = '/update_image';
  const UpdateImage({super.key});

  @override
  State<UpdateImage> createState() => _UpdateImageState();
}

class _UpdateImageState extends State<UpdateImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize.initial(context);
    String image = (ModalRoute.of(context)!.settings.arguments as String?) ?? '';

    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is UpdateProfileImageSuccess) {
            Navigator.pop(context);
          } else if (state is UpdateProfileImageError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          final cubit = BlocProvider.of<ProfileCubit>(context);
          final isLoading = state is UpdateProfileImageLoading;

          return Stack(
            children: [
              Scaffold(
                appBar: AppBar(
                  actions: [
                    IconButton(
                      onPressed: isLoading
                          ? null
                          : () {
                              cubit.UpdateImageProfile();
                            },
                      icon: const Icon(Icons.edit),
                    ),
                  ],
                ),
                body: Center(
                  child: GestureDetector(
                    onTap: isLoading
                        ? null
                        : () {
                            cubit.pickImage();
                          },
                    child: CircleAvatar(
                      radius: ScreenSize.width / 2,
                      backgroundImage: cubit.profileImge != null
                          ? FileImage(cubit.profileImge!) as ImageProvider
                          : (image.isNotEmpty
                              ? NetworkImage(image)
                              : const AssetImage('Assets/profile.jpg'))
                              as ImageProvider,
                    ),
                  ),
                ),
              ),
              if (isLoading)
                Container(
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}