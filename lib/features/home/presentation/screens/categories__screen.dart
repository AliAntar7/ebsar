import 'package:ebsar/core/constants/app_string.dart';
import 'package:ebsar/features/home/presentation/cubit/command_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommandCubit, CommandState>(
      builder: (context, state) {
        var cubit = CommandCubit.get(context);
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              elevation: 1,
              title: const Text(
                AppString.categories,
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: cubit.categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 16 / 15,
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      //print(categoriesName[index]);
                    },
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://ebsar.website/public/uploads/books_images/qwt_eladatt.jpg'),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.3)
                                ],
                                stops: const [0.6, 0.9],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            cubit.categories[index].name!,
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline4
                                ?.copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
