import 'package:ebsar/features/home/presentation/cubit/command_cubit.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommandCubit, CommandState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = CommandCubit.get(context);
        return WillPopScope(
          onWillPop: () async {
            cubit.dispose();
            return true;
          },
          child: Scaffold(
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(cubit.book!.image!.bookImage! ?? ""),
                  fit: BoxFit.cover,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 20,
                  sigmaY: 20,
                ),
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.black.withOpacity(0.1),
                  child: SafeArea(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 20,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                  size: 35,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  cubit.dispose();
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.account_circle,
                                  color: Colors.white,
                                  size: 35,
                                ),
                                onPressed: () {
                                  // Navigator.of(context).push(
                                  //   MaterialPageRoute(
                                  //     builder: (context) => const Profile(),
                                  //   ),
                                  // );
                                },
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            bottom: 20,
                          ),
                          height: MediaQuery.of(context).size.height * 0.32,
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 25,
                                      offset: const Offset(8, 8),
                                      spreadRadius: 3,
                                    ),
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 25,
                                      offset: const Offset(-8, -8),
                                      spreadRadius: 3,
                                    )
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    cubit.book!.image!.bookImage! ?? "",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Container(
                                height: double.infinity,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.black.withOpacity(0.3),
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.3),
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          cubit.book!.name! ?? "",
                          style: const TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Color(0xfffff8ee),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50),
                              ),
                            ),
                            padding: const EdgeInsets.only(
                              left: 30,
                              right: 30,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Slider(
                                      value: cubit.position.inSeconds.toDouble(),
                                      max: cubit.duration.inSeconds.toDouble(),
                                      min: 0,
                                      onChanged: (value) {
                                        cubit.audioPlayer.seek(
                                            Duration(seconds: value.toInt()));
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            "${cubit.position.inMinutes.toString().padLeft(2, '0')}:${cubit.position.inSeconds.remainder(60).toString().padLeft(2, '0')}"),
                                        Text(
                                            "${cubit.duration.inMinutes.toString().padLeft(2, '0')}:${cubit.duration.inSeconds.remainder(60).toString().padLeft(2, '0')}"),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.menu,
                                        color: Colors.grey,
                                        size: 32,
                                      ),
                                      onPressed: () {},
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.skip_previous,
                                        color: Colors.grey,
                                        size: 38,
                                      ),
                                      onPressed: () {},
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(
                                        bottom: 16,
                                        right: 15,
                                      ),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.blue,
                                      ),
                                      child: IconButton(
                                        onPressed: () {
                                          if (cubit.isPlaying) {
                                            cubit.audioPlayer.pause();
                                            cubit.isPlaying = false;
                                            print(cubit.isPlaying);
                                          } else {
                                            cubit.audioPlayer.resume();
                                            cubit.isPlaying = true;
                                            print(cubit.isPlaying);
                                          }
                                        },
                                        icon: Icon(
                                          cubit.isPlaying
                                              ? Icons.play_arrow
                                              : Icons.pause,
                                          color: Colors.white,
                                          size: 48,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.skip_next,
                                        color: Colors.grey,
                                        size: 38,
                                      ),
                                      onPressed: () {},
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.more_horiz,
                                        color: Colors.grey,
                                        size: 32,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
