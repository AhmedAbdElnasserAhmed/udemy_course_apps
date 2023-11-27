import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:udemy_flutter_dart/shared/components/components.dart';
import 'package:udemy_flutter_dart/shared/cubit/states.dart';
import '../../shared/cubit/cubit.dart';

// 1. create database
// 2. create tables
// 3. open database
// 4. insert to database
// 5. get from database
// 6. update in database
// 7. delete from database

class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  DatabaseHelper data = DatabaseHelper();

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  HomeLayout({super.key});

  // @override
  // void initState() {
  //   super.initState();
  //
  //   data.createDatabase();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state)
        {
          if (state is AppInsertDatabaseState) Navigator.pop(context);
        },
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);

          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(
                cubit.titles[cubit.currentIndex],
              ),
            ),
            body: ConditionalBuilder(
              condition: state is! AppGetDatabaseLoadingState,
              builder: (context) => cubit.screens[cubit.currentIndex],
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: ()
              {
                if (cubit.isBottomSheetShown) {
                  //error show here in ! sine. unhandled null operator exception.
                  if (formKey.currentState!.validate())
                  {
                    cubit.insertToDatabase(
                      title: titleController.text,
                      time: timeController.text,
                      date: dateController.text,
                    );
                    // data.insertToDatabase(
                    //   title: titleController.text,
                    //   time: timeController.text,
                    //   date: dateController.text,
                    // ).then((value) {
                    //   data.getDataFromDatabase(data.database).then((value) {
                    //     Navigator.pop(context);
                    //
                    //     // setState(() {
                    //     //   isBottomSheetShown = false;
                    //     //   fabIcon = Icons.edit;
                    //     //
                    //     //   tasks = value;
                    //     //   print(tasks);
                    //     //   // if (kDebugMode) {
                    //     //   //   print(tasks[0]);
                    //     //   //   print(tasks[0]['title']);
                    //     //   //   print(tasks[0]['time']);
                    //     //   // }
                    //     //
                    //     // });
                    //   });
                    // });
                  }
                } else {
                  scaffoldKey.currentState
                      ?.showBottomSheet(
                        (context) => Container(
                          padding: const EdgeInsets.all(
                            20.0,
                          ),
                          color: Colors.white,
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                defaultFormField(
                                  controller: titleController,
                                  type: TextInputType.text,
                                  validate: (value)
                                  {
                                    if (value!.isEmpty)
                                    {
                                      return 'title must not be empty';
                                    }
                                    return null;
                                  },
                                  label: 'Task Title',
                                  prefix: Icons.title,
                                ),
                                // TextFormField(
                                //   controller: titleController,
                                //   keyboardType: TextInputType.text,
                                //   validator: (value) {
                                //     if (value!.isEmpty) {
                                //       return 'title must not be empty';
                                //     }
                                //     return null;
                                //   },
                                //   decoration: const InputDecoration(
                                //     labelText: 'Task Title',
                                //     border: OutlineInputBorder(),
                                //     prefixIcon: Icon(
                                //       Icons.title,
                                //     ),
                                //   ),
                                // ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                defaultFormField(
                                  controller: timeController,
                                  type: TextInputType.datetime,
                                  onTap: () {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      timeController.text =
                                          value!.format(context).toString();
                                      if (kDebugMode) {
                                        print(value.format(context));
                                      }
                                    }).catchError((error) {
                                      if (kDebugMode) {
                                        print('Error In showClockPicker');
                                      }
                                    });
                                  },
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return 'time must not be empty';
                                    }
                                    return null;
                                  },
                                  label: 'Task Time',
                                  prefix: Icons.watch_later_outlined,
                                ),
                                // TextFormField(
                                //   controller: timeController,
                                //   keyboardType: TextInputType.datetime,
                                //   onTap: () {
                                //     showTimePicker(
                                //       context: context,
                                //       initialTime: TimeOfDay.now(),
                                //     ).then((value) {
                                //       timeController.text =
                                //           value!.format(context).toString();
                                //       if (kDebugMode) {
                                //         print(value.format(context));
                                //       }
                                //     }).catchError((error) {
                                //       if (kDebugMode) {
                                //         print('Error In showClockPicker');
                                //       }
                                //     });
                                //   },
                                //   validator: (value) {
                                //     if (value!.isEmpty) {
                                //       return 'time must not be empty';
                                //     }
                                //     return null;
                                //   },
                                //   decoration: const InputDecoration(
                                //     labelText: 'Task Time',
                                //     border: OutlineInputBorder(),
                                //     prefixIcon: Icon(
                                //       Icons.watch_later_outlined,
                                //     ),
                                //   ),
                                // ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                defaultFormField(
                                  controller: dateController,
                                  type: TextInputType.datetime,
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse('2024-01-01'),
                                    ).then((value) {
                                      dateController.text = DateFormat()
                                          .add_yMMMd()
                                          .format(value!);
                                    }).catchError((error) {
                                      if (kDebugMode) {
                                        print('Error In showDatePicker');
                                      }
                                    });
                                  },
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return 'date must not be empty';
                                    }
                                    return null;
                                  },
                                  label: 'Task Date',
                                  prefix: Icons.calendar_month,
                                ),
                                // TextFormField(
                                //   controller: dateController,
                                //   keyboardType: TextInputType.datetime,
                                //   onTap: () {
                                //     showDatePicker(
                                //       context: context,
                                //       initialDate: DateTime.now(),
                                //       firstDate: DateTime.now(),
                                //       lastDate: DateTime.parse('2024-01-01'),
                                //     ).then((value) {
                                //       dateController.text = DateFormat()
                                //           .add_yMMMd()
                                //           .format(value!);
                                //     }).catchError((error) {
                                //       if (kDebugMode) {
                                //         print('Error In showDatePicker');
                                //       }
                                //     });
                                //   },
                                //   validator: (value) {
                                //     if (value!.isEmpty) {
                                //       return 'date must not be empty';
                                //     }
                                //     return null;
                                //   },
                                //   decoration: const InputDecoration(
                                //     labelText: 'Task Date',
                                //     border: OutlineInputBorder(),
                                //     prefixIcon: Icon(
                                //       Icons.calendar_month,
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                        elevation: 20.0,
                      )
                      .closed
                      .then((value) {
                    cubit.changeBottomSheetState(
                        isShow: false, icon: Icons.edit);
                  });
                  //   async {
                  //    try
                  //    {
                  //      var name = await getName();
                  //      print(name);
                  //      print('Osama');
                  //
                  //      throw('some error!!!!!!');
                  //    } catch(error)
                  //    {
                  //      print('error ${error.toString()}');
                  //    }
                  //
                  // data.insertToDatabase();
                  //
                  // getName().then((value) {
                  //   if (kDebugMode) {
                  //     print(value);
                  //   }
                  //   if (kDebugMode) {
                  //     print('Osama');
                  //   }
                  //   throw ('some error happens!!!!');
                  // }).catchError((error) {
                  //   if (kDebugMode) {
                  //     print('error is ${error.toString()}');
                  //   }
                  // });
                  cubit.changeBottomSheetState(isShow: true, icon: Icons.add);
                }
              },
              child: Icon(
                cubit.fabIcon,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.menu,
                  ),
                  label: 'Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.check_circle_outline,
                  ),
                  label: 'Done',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.archive_outlined,
                  ),
                  label: 'Archived',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

//Instance of 'Future<String>'

// Future<String> getName() async
// {
//   return 'Ahmed Abd El Nasser';
// }

class DatabaseHelper {}
