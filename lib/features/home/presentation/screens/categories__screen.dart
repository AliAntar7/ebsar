import 'package:ebsar/core/constants/app_string.dart';
import 'package:ebsar/features/home/presentation/cubit/command_cubit.dart';
import 'package:ebsar/features/home/presentation/screens/books_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);
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
          child: GestureDetector(
            onDoubleTap: () {
              cubit.listenToNameCategory();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BooksScreen(),
                ),
              );
              print('double tapped');
            },
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                appBar: AppBar(
                  elevation: 1,
                  title: const Text(
                    AppString.categories,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: cubit.categories.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              // cubit.getBooksByCategory(
                              //     cubit.categories[index].id);
                            },
                            title: Text(
                              '${cubit.categories[index].name}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
