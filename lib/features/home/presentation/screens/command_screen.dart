import 'package:ebsar/features/home/presentation/cubit/command_cubit.dart';
import 'package:ebsar/features/home/presentation/screens/categories__screen.dart';
import 'package:ebsar/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';


class CommandScreen extends StatelessWidget {
  CommandScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommandCubit, CommandState>(
      listener: (context, state) {
        var cubit = CommandCubit.get(context);
        if (state is CommandSearchLoaded) {
          if (cubit.book != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
            Future.delayed(const Duration(seconds: 1),(){
              cubit.playTTS();
            });
          }
        }
        if (state is CommandSearchError) {
          cubit.speechError(error: state.message);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        var cubit = CommandCubit.get(context);
        return GestureDetector(
          // make onTap function cancelable
          // onLongPress: () {
          //   print('long press');
          //   cubit.listen();
          // },
          // onLongPressCancel: () {
          //   print('long press cancel');
          //   cubit.stop();
          // },
          onLongPressDown: (LongPressDownDetails details) {
            print('long press down');
            cubit.listen();
          },
          onLongPressUp: () {
            print('long press up');
            cubit.stop();
          },
          // onTapDown: (TapDownDetails details) {
          //   print('tap down');
          //   cubit.listen();
          // },
          // onTapUp: (TapUpDetails details) {
          //   print('tap up');
          //   cubit.stop();
          // },
          onDoubleTap: () {
            cubit.stop();
            cubit.readCategoryName();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CategoriesScreen(),
              ),
            );
            print('double tapped');
          },
          child: Scaffold(
            //backgroundColor: Colors.blue[800],
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(cubit.text,
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 40,
                      ),
                    ),
                  ),
                  const SizedBox(height: 80,),
                  Lottie.asset(
                    cubit.isSearch ? 'assets/lotties/searching1.json' : 'assets/lotties/command.json',
                    height: 250,
                    width: 250,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
