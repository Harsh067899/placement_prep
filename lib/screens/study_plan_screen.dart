import 'package:flutter/material.dart';
import '../widgets/task_card.dart';

class StudyPlanScreen extends StatefulWidget {
  const StudyPlanScreen({Key? key}) : super(key: key);

  @override
  State<StudyPlanScreen> createState() => _StudyPlanScreenState();
}

class _StudyPlanScreenState extends State<StudyPlanScreen> {
  int _selectedDayIndex = 0;
  final List<String> _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  final List<String> _dates = ['15', '16', '17', '18', '19', '20', '21'];
  
  final List<List<Map<String, dynamic>>> _studyTasks = [
    // Monday
    [
      {
        'time': '08:00 - 09:00',
        'title': 'Math Revision',
        'description': 'Review calculus concepts for upcoming test',
        'isCompleted': false,
      },
      {
        'time': '13:00 - 14:00',
        'title': 'Physics Problem Set',
        'description': 'Complete problems 1-10 from Chapter 5',
        'isCompleted': true,
      },
      {
        'time': '16:00 - 17:30',
        'title': 'CS Project Work',
        'description': 'Work on database implementation',
        'isCompleted': false,
      },
    ],
    // Tuesday
    [
      {
        'time': '08:00 - 09:00',
        'title': 'Chemistry Reading',
        'description': 'Read Chapter 7 on Organic Chemistry',
        'isCompleted': false,
      },
      {
        'time': '13:00 - 14:00',
        'title': 'English Essay',
        'description': 'Write first draft of comparative essay',
        'isCompleted': false,
      },
    ],
    // Wednesday
    [
      {
        'time': '08:00 - 09:00',
        'title': 'Math Practice',
        'description': 'Practice integration problems',
        'isCompleted': false,
      },
      {
        'time': '13:00 - 14:00',
        'title': 'History Notes',
        'description': 'Summarize lecture notes on World War II',
        'isCompleted': false,
      },
    ],
    // Thursday
    [
      {
        'time': '08:00 - 09:00',
        'title': 'Physics Lab Prep',
        'description': 'Review lab procedure for tomorrow',
        'isCompleted': false,
      },
      {
        'time': '13:00 - 14:00',
        'title': 'CS Reading',
        'description': 'Read article on machine learning algorithms',
        'isCompleted': false,
      },
    ],
    // Friday
    [
      {
        'time': '08:00 - 09:00',
        'title': 'Chemistry Lab Report',
        'description': 'Complete analysis section of lab report',
        'isCompleted': false,
      },
      {
        'time': '13:00 - 14:00',
        'title': 'English Reading',
        'description': 'Read Chapters 5-7 of assigned novel',
        'isCompleted': false,
      },
    ],
    // Saturday
    [
      {
        'time': '10:00 - 12:00',
        'title': 'Weekly Review',
        'description': 'Review all subjects and identify weak areas',
        'isCompleted': false,
      },
      {
        'time': '14:00 - 16:00',
        'title': 'Math & Physics Practice',
        'description': 'Work on practice problems for both subjects',
        'isCompleted': false,
      },
    ],
    // Sunday
    [
      {
        'time': '11:00 - 13:00',
        'title': 'Week Planning',
        'description': 'Plan study schedule for next week',
        'isCompleted': false,
      },
      {
        'time': '15:00 - 17:00',
        'title': 'Reading & Notes',
        'description': 'Prepare reading materials for upcoming classes',
        'isCompleted': false,
      },
    ],
  ];

  void _toggleTaskCompletion(int taskIndex) {
    setState(() {
      _studyTasks[_selectedDayIndex][taskIndex]['isCompleted'] = 
          !_studyTasks[_selectedDayIndex][taskIndex]['isCompleted'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Study Plan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month),
            onPressed: () {
              // Calendar view action
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Date Selector
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                7,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDayIndex = index;
                    });
                  },
                  child: Container(
                    width: 40,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: _selectedDayIndex == index
                          ? Theme.of(context).colorScheme.primary
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _days[index],
                          style: TextStyle(
                            color: _selectedDayIndex == index
                                ? Colors.white
                                : Colors.grey[600],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: _selectedDayIndex == index
                                ? Colors.white
                                : Theme.of(context).colorScheme.primary.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            _dates[index],
                            style: TextStyle(
                              color: _selectedDayIndex == index
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          // Study Tasks
          Expanded(
            child: _studyTasks[_selectedDayIndex].isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.event_note,
                          size: 80,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No study tasks for this day',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _studyTasks[_selectedDayIndex].length,
                    itemBuilder: (context, index) {
                      final task = _studyTasks[_selectedDayIndex][index];
                      return TaskCard(
                        time: task['time'],
                        title: task['title'],
                        description: task['description'],
                        isCompleted: task['isCompleted'],
                        onToggle: () => _toggleTaskCompletion(index),
                      );
                    },
                  ),
          ),
          
          // Add Task Button
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: ElevatedButton.icon(
              onPressed: () {
                // Add task action
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Study Task'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

