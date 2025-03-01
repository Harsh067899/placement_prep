import 'package:flutter/material.dart';

class TimetableVerificationScreen extends StatefulWidget {
  const TimetableVerificationScreen({Key? key}) : super(key: key);

  @override
  State<TimetableVerificationScreen> createState() => _TimetableVerificationScreenState();
}

class _TimetableVerificationScreenState extends State<TimetableVerificationScreen> {
  final List<Map<String, dynamic>> _extractedClasses = [
    {
      'day': 'Monday',
      'classes': [
        {'time': '09:00 - 10:30', 'subject': 'Mathematics', 'room': 'Room 101', 'isEdited': false},
        {'time': '11:00 - 12:30', 'subject': 'Physics', 'room': 'Lab 3', 'isEdited': false},
        {'time': '14:00 - 15:30', 'subject': 'Computer Science', 'room': 'Lab 5', 'isEdited': false},
      ]
    },
    {
      'day': 'Tuesday',
      'classes': [
        {'time': '09:00 - 10:30', 'subject': 'Chemistry', 'room': 'Lab 2', 'isEdited': false},
        {'time': '11:00 - 12:30', 'subject': 'English', 'room': 'Room 203', 'isEdited': false},
      ]
    },
    {
      'day': 'Wednesday',
      'classes': [
        {'time': '09:00 - 10:30', 'subject': 'Mathematics', 'room': 'Room 101', 'isEdited': false},
        {'time': '11:00 - 12:30', 'subject': 'History', 'room': 'Room 105', 'isEdited': false},
        {'time': '14:00 - 15:30', 'subject': 'Art', 'room': 'Studio 1', 'isEdited': false},
      ]
    },
    {
      'day': 'Thursday',
      'classes': [
        {'time': '09:00 - 10:30', 'subject': 'Physics', 'room': 'Lab 3', 'isEdited': false},
        {'time': '11:00 - 12:30', 'subject': 'Computer Science', 'room': 'Lab 5', 'isEdited': false},
      ]
    },
    {
      'day': 'Friday',
      'classes': [
        {'time': '09:00 - 10:30', 'subject': 'Chemistry', 'room': 'Lab 2', 'isEdited': false},
        {'time': '11:00 - 12:30', 'subject': 'English', 'room': 'Room 203', 'isEdited': false},
        {'time': '14:00 - 15:30', 'subject': 'Physical Education', 'room': 'Gym', 'isEdited': false},
      ]
    },
  ];

  void _editClass(int dayIndex, int classIndex) {
    final classData = _extractedClasses[dayIndex]['classes'][classIndex];
    
    showDialog(
      context: context,
      builder: (context) {
        String subject = classData['subject'];
        String time = classData['time'];
        String room = classData['room'];
        
        return AlertDialog(
          title: const Text('Edit Class'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Subject'),
                  controller: TextEditingController(text: subject),
                  onChanged: (value) => subject = value,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Time'),
                  controller: TextEditingController(text: time),
                  onChanged: (value) => time = value,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Room'),
                  controller: TextEditingController(text: room),
                  onChanged: (value) => room = value,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _extractedClasses[dayIndex]['classes'][classIndex] = {
                    'subject': subject,
                    'time': time,
                    'room': room,
                    'isEdited': true,
                  };
                });
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Timetable'),
      ),
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.green.withOpacity(0.1),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle_outline,
                  color: Colors.green[700],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Please verify the extracted timetable data. Tap on any class to edit if needed.',
                    style: TextStyle(
                      color: Colors.green[700],
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Timetable List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _extractedClasses.length,
              itemBuilder: (context, dayIndex) {
                final day = _extractedClasses[dayIndex];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        day['day'],
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ),
                    ...List.generate(
                      day['classes'].length,
                      (classIndex) {
                        final classData = day['classes'][classIndex];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color: classData['isEdited'] ? Colors.green : Colors.grey.shade200,
                              width: classData['isEdited'] ? 1.5 : 1,
                            ),
                          ),
                          child: InkWell(
                            onTap: () => _editClass(dayIndex, classIndex),
                            borderRadius: BorderRadius.circular(12),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      classData['time'],
                                      style: TextStyle(
                                        color: Theme.of(context).colorScheme.primary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          classData['subject'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          classData['room'],
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (classData['isEdited'])
                                    Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.1),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.edit,
                                        size: 16,
                                        color: Colors.green,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                );
              },
            ),
          ),
          
          // Confirm Button
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/study_plan');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Confirm & Generate Study Plan',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

