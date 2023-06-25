import 'package:flutter/material.dart';
import 'package:my_dsa_app/database/exercise-groups.dart';
import 'package:my_dsa_app/exercise-page/exercise-view-page.dart';
import '../main.dart';

class ExercisePage extends StatefulWidget {
  ExercisePage({super.key});

  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  List<ExerciseGroup> groups = [];
  List<Exercise> exercises = [];

  final exerciseGroupProvider = ExerciseGroupProvider();
  final exerciseProvider = ExerciseProvider();

  @override
  void initState() {
    super.initState();
    // Retrieve groups and exercises from Supabase here
    // and populate the groups and exercises lists
    exerciseGroupProvider.fetchExerciseGroups().then((value) => {
          setState(
            () {
              groups = value;
              exerciseProvider.fetchExercises().then((value) => {
                    setState(
                      () {
                        exercises = value;

                        // Mapping data to create Expansion Panel List
                        StaticDBVariables.exercisesData = groups.map((group) {
                          final groupExercises = exercises
                              .where((exercise) => exercise.groupId == group.id)
                              .toList();
                          //print(groupExercises);
                          return Item(
                            headerValue: group.name,
                            expandedValue: groupExercises,
                            isExpanded: false,
                          );
                        }).toList();
                      },
                    )
                  });
            },
          )
        });
  }

  @override
  Widget build(BuildContext context) {
    return StaticDBVariables.exercisesData.isNotEmpty
        ? SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: ExpansionPanelList(
                elevation: 1,
                expandedHeaderPadding: EdgeInsets.all(0),
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    StaticDBVariables.exercisesData[index].isExpanded =
                        !isExpanded;
                  });
                },
                children: StaticDBVariables.exercisesData
                    .map<ExpansionPanel>((Item item) {
                  return ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        title: Text(item.headerValue),
                      );
                    },
                    body: ListTile(
                      title: Column(
                        children: item.expandedValue.map<Widget>((exercise) {
                          return GestureDetector(
                            onTap: () {
                              // Go to exercise screen
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ExerciseViewPage(
                                            id: exercise.id,
                                            name: exercise.name,
                                            groupName: item.headerValue,
                                            description: exercise.description,
                                            example: exercise.example,
                                            constraint: exercise.constraint,
                                            hint: exercise.hint,
                                            solution: exercise.solution,
                                          )));
                            },
                            child: Text(exercise.name),
                          );
                        }).toList(),
                      ),
                    ),
                    isExpanded: item.isExpanded,
                  );
                }).toList(),
              ),
            ),
          )
        : const Center(child: CircularProgressIndicator());
  }
}
