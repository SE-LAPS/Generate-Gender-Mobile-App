import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'pages/gender_info.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Gender Identification App',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _nameController = TextEditingController();
  GenderInfo? _genderInfo;
  String _avatarImage = 'assets/images/image2.png'; // Default image

  Future<GenderInfo?> _getGenderInfo(String name) async {
    const String baseUrl = "https://api.genderize.io/";
    try {
      final response = await Dio().get(baseUrl, queryParameters: {"name": name});
      return GenderInfo.fromJson(response.data);
    } catch (error) {
      print("Error: $error");
      return null;
    }
  }

  void _identifyGender() async {
    String name = _nameController.text.trim();
    if (name.isNotEmpty) {
      final genderInfo = await _getGenderInfo(name);
      setState(() {
        _genderInfo = genderInfo;
        if (_genderInfo!.gender == 'male') {
          _avatarImage = 'assets/images/image3.png';
        } else if (_genderInfo!.gender == 'female') {
          _avatarImage = 'assets/images/image4.png';
        } else {
          _avatarImage = 'assets/images/image2.png';
        }
      });
    } else {
      // If no name is entered, show the default image
      setState(() {
        _avatarImage = 'assets/images/image2.png';
        _genderInfo = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gender Identification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  _avatarImage,
                  height: 350,
                  width: 150,
                ),
                const SizedBox(height: 46),
                SizedBox(
                  width: 350,
                  height: 58,
                  child: Align(
                    alignment: Alignment.center,
                    child: TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Enter The Name',
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 48,
                    width: 200,
                    child: ElevatedButton(
                      onPressed: _identifyGender,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: const Text(
                        'Click Here',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                ),
                if (_genderInfo != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 16),
                      Text('Name: ${_genderInfo!.name}'),
                      RichText(
                        text: TextSpan(
                          text: 'Gender: ',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: '${_genderInfo!.gender}',
                              style: const TextStyle(
                                color: Colors.purple,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text('Probability: ${_genderInfo!.probability}'),
                      Text('Count: ${_genderInfo!.count}'),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
