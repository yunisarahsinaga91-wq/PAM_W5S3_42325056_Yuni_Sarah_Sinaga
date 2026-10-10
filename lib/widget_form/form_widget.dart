import 'package:flutter/material.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({super.key});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  bool isOn = false;
  String selected = 'Flutter';
  final List<String> dropdownList = ['Flutter', 'Dart', 'Java', 'Scala', 'Python'];
  String selectedGender = 'Female';
  String sex = 'female';
  bool isChecked = false;

  final TextEditingController textController =
      TextEditingController(text: 'Yuni Sarah Sinaga');
  final TextEditingController birthDateController =
      TextEditingController(text: '2006-10-22');

  @override
  void dispose() {
    textController.dispose();
    birthDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PAM Minggu 5 - Form')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              maxLength: 21,
              controller: textController,
              decoration: const InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(color: Colors.blueGrey),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey),
                ),
                helperText: "What's your name?",
              ),
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Flexible(child: Text('Your Favorite Language:')),
                const SizedBox(width: 8),
                DropdownButton<String>(
                  value: selected,
                  icon: const Icon(Icons.arrow_downward),
                  items: dropdownList
                      .map((language) => DropdownMenuItem<String>(
                            value: language,
                            child: Text(language),
                          ))
                      .toList(),
                  onChanged: (String? value) {
                    if (value != null) {
                      setState(() => selected = value);
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedGender,
              decoration: const InputDecoration(
                labelText: 'Gender',
                helperText: 'Your gender',
              ),
              items: const [
                DropdownMenuItem(value: 'Female', child: Text('Female')),
                DropdownMenuItem(value: 'Male', child: Text('Male')),
              ],
              onChanged: (String? value) {
                if (value != null) {
                  setState(() => selectedGender = value);
                }
              },
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text('Connect Instagram'),
                const SizedBox(width: 8),
                Switch(
                  value: isOn,
                  onChanged: (value) => setState(() => isOn = value),
                ),
                Text(isOn ? 'On' : 'Off'),
              ],
            ),
            Row(
              children: [
                const Text('Gender:'),
                const SizedBox(width: 8),
                Radio<String>(
                  value: 'male',
                  groupValue: sex,
                  onChanged: (value) {
                    if (value != null) setState(() => sex = value);
                  },
                ),
                const Text('Male'),
                const SizedBox(width: 8),
                Radio<String>(
                  value: 'female',
                  groupValue: sex,
                  onChanged: (value) {
                    if (value != null) setState(() => sex = value);
                  },
                ),
                const Text('Female'),
              ],
            ),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              value: isChecked,
              activeColor: Colors.blue,
              title: const Text(
                'Agree Term & Conditions',
                style: TextStyle(decoration: TextDecoration.underline),
              ),
              onChanged: (value) {
                if (value != null) setState(() => isChecked = value);
              },
            ),
            InkWell(
              onTap: () async {
                final DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime(2006, 10, 22),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                debugPrint('pickedDate: $pickedDate');
                if (pickedDate != null && mounted) {
                  birthDateController.text =
                      pickedDate.toIso8601String().split('T')[0];
                  setState(() {});
                }
              },
              child: IgnorePointer(
                child: TextFormField(
                  controller: birthDateController,
                  decoration: const InputDecoration(
                    labelText: 'Birth date',
                    suffixIcon: Icon(Icons.date_range),
                    helperText: "What's your birth date?",
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Current selection: $selectedGender • ${sex == 'female' ? 'Female' : 'Male'}'
              ' • Instagram ${isOn ? 'connected' : 'not connected'}'
              ' • Terms ${isChecked ? 'accepted' : 'not accepted'}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
