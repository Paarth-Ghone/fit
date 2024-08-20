import 'package:flutter/material.dart';

class ExerciseTutorialPage extends StatefulWidget {
  @override
  _ExerciseTutorialPageState createState() => _ExerciseTutorialPageState();
}

class _ExerciseTutorialPageState extends State<ExerciseTutorialPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> exercises = [
    {
      'name': 'Push-Up',
      'steps': '1. Start in a plank position.\n2. Lower your body until your chest nearly touches the floor.\n3. Push yourself back up to the starting position.',
      'safety': 'Keep your body straight and avoid sagging your hips.'
    },
    {
      'name': 'Squat',
      'steps': '1. Stand with feet shoulder-width apart.\n2. Lower your body as if sitting in a chair.\n3. Push through your heels to return to standing.',
      'safety': 'Keep your knees aligned with your toes and avoid rounding your back.'
    },
    {
      'name': 'Lunge',
      'steps': '1. Step forward with one leg.\n2. Lower your hips until both knees are bent at 90 degrees.\n3. Push through your front heel to return to standing.',
      'safety': 'Keep your front knee directly above your ankle and your back knee just above the ground.'
    },
  ];

  List<Map<String, String>> filteredExercises = [];

  @override
  void initState() {
    super.initState();
    filteredExercises = exercises;
  }

  void _filterExercises(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredExercises = exercises;
      });
    } else {
      setState(() {
        filteredExercises = exercises
            .where((exercise) =>
            exercise['name']!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise Tutorials'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search the exercise',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (query) {
                _filterExercises(query);
              },
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: filteredExercises.length,
                itemBuilder: (context, index) {
                  final exercise = filteredExercises[index];
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            exercise['name']!,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Steps:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            exercise['steps']!,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Safety Tips:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            exercise['safety']!,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}