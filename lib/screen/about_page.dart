import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Supervisor Section
            Text(
              'Supervisor',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 10),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      AssetImage('assets/supervisor.jpg'), // Supervisor image
                ),
                title: Text(
                  'Md. Tahzib Ul Islam',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Associate Professor\nDept. of CSE\nDIU',
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
              ),
            ),

            SizedBox(height: 20),

            // Student Developers Section
            Text(
              'Student Developers',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 10),

            // List of Developers
            Column(
              children: [
                _buildStudentCard(
                  name: 'Md Ariful Islam',
                  regNo: 'CS-E-86-20-114417',
                  rollNo: '19',
                  image: 'assets/ariful.jpg',
                ),
                _buildStudentCard(
                  name: 'Mim Biswas',
                  regNo: 'CS-E-86-20-114502',
                  rollNo: '33',
                  image: 'assets/mim.jpg',
                ),
                _buildStudentCard(
                  name: 'Md. Moshiur Rahman (TL)',
                  regNo: 'CS-E-86-20-114618',
                  rollNo: '59',
                  image: 'assets/moshiur.jpg',
                ),
                _buildStudentCard(
                  name: 'Abdul Hai',
                  regNo: 'CS-E-86-20-114618',
                  rollNo: '60',
                  image: 'assets/abdul.jpg',
                ),
                _buildStudentCard(
                  name: 'Salman Khan',
                  regNo: 'CS-E-78-19-110783',
                  rollNo: '64',
                  image: 'assets/salman.jpg',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Method to build a student card
  Widget _buildStudentCard({
    required String name,
    required String regNo,
    required String rollNo,
    required String image,
  }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(image), // Student image
        ),
        title: Text(
          name,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Reg No: $regNo\nRoll No: $rollNo',
          style: TextStyle(fontSize: 14, color: Colors.grey[700]),
        ),
      ),
    );
  }
}
