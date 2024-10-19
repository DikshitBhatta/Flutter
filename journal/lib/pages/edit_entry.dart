import 'package:flutter/material.dart';
import 'package:journal/blocs/journalentry_bloc.dart';
import 'package:journal/blocs/journalentrybloc_Provider.dart';
import 'package:journal/classes/mood_icon.dart';
import 'package:journal/classes/formatdates.dart';

class EditEntry extends StatefulWidget {
  const EditEntry({super.key});

  @override
  EditEntryState createState() => EditEntryState();
}

class EditEntryState extends State<EditEntry> {
  JournalEditBloc? _journalEditBloc;
  MoodIcons? _moodIcons;
  Formatdates? _formatdates;
  TextEditingController? _noteController;
  @override
  void initState() {
    super.initState();
    _moodIcons = const MoodIcons();
    _formatdates = Formatdates();
    _noteController = TextEditingController(text: '');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _journalEditBloc = JournalentryblocProvider.of(context).journalEditBloc;
    if (_journalEditBloc == null) {
      print("JournalEditBloc is null");
      return;
    }
  }

  @override
  void dispose() {
    _noteController!.dispose();
    _journalEditBloc!.dispose();
    super.dispose();
  }

  Future<String> _selectDate(String selectedDate) async {
    DateTime initialDate = DateTime.parse(selectedDate);
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (pickedDate != null) {
      selectedDate = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        initialDate.hour,
        initialDate.minute,
        initialDate.second,
      ).toString();
    }
    return selectedDate;
  }

  void _addOrUpdateJournal() {
    _journalEditBloc!.saveJournalChanged.add('Save');
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Entry',
          style: TextStyle(color: Colors.lightGreen.shade800),
        ),
        automaticallyImplyLeading: false,
        elevation: 0.0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.lightGreen, Colors.lightGreen.shade50],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              StreamBuilder(
                  stream: _journalEditBloc!.dateEdit,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    }
                    return TextButton(
                        child: Row(
                          children: <Widget>[
                            const Icon(
                              Icons.calendar_today,
                              size: 22.00,
                              color: Colors.black54,
                            ),
                            const SizedBox(
                              width: 16.00,
                            ),
                            Text(
                              _formatdates!
                                  .dateFormatShortMonthDayYear(snapshot.data)!,
                              style: const TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                        onPressed: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          String pickerDate = await _selectDate(snapshot.data);
                          _journalEditBloc!.dateEditChanged.add(pickerDate);
                        });
                  }),
              StreamBuilder(
                  stream: _journalEditBloc!.moodEdit,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData || _moodIcons == null) {
                      return Container();
                    }
                    int moodIndex = _moodIcons!
                        .getMoodIconList()
                        .indexWhere((icon) => icon.title == snapshot.data);
                    print(
                        'Mood Index: $moodIndex, Mood List Length: ${_moodIcons!.getMoodIconList().length}');
                    if (moodIndex == -1) {
                      moodIndex = 0; // Default to first mood if not found
                    } else if (moodIndex >=
                        _moodIcons!.getMoodIconList().length) {
                      moodIndex = _moodIcons!.getMoodIconList().length -
                          1; // Prevent out-of-bounds
                    }
                    IconData? moodIcon = _moodIcons!.getMoodIcon(snapshot.data);
                    Color? moodColor = _moodIcons!.getMoodColor(snapshot.data);
                    double? moodRotation =
                        _moodIcons!.getMoodRotation(snapshot.data);

                    if (moodIcon == null ||
                        moodColor == null ||
                        moodRotation == null) {
                      // Handle invalid mood
                      print('Invalid mood selected: ${snapshot.data}');
                      moodIcon = Icons.help; // Fallback icon
                      moodColor = Colors.grey; // Fallback color
                      moodRotation = 0.0; // Fallback rotation
                    }

                    return DropdownButtonHideUnderline(
                      child: DropdownButton<MoodIcons>(
                        value: _moodIcons!.getMoodIconList()[moodIndex],
                        onChanged: (selected) {
                          _journalEditBloc!.moodEditChanged
                              .add(selected!.title!);
                        },
                        items: _moodIcons!
                            .getMoodIconList()
                            .map((MoodIcons selected) {
                          return DropdownMenuItem<MoodIcons>(
                            value: selected,
                            child: Row(
                              children: <Widget>[
                                Transform(
                                  transform: Matrix4.identity()
                                    ..rotateZ(_moodIcons!
                                        .getMoodRotation(selected.title!)!),
                                  alignment: Alignment.center,
                                  child: Icon(
                                      _moodIcons!.getMoodIcon(selected.title!),
                                      color: _moodIcons!.getMoodColor(
                                          selected.color.toString())),
                                ),
                                const SizedBox(
                                  width: 16.00,
                                ),
                                Text(selected.title!),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  }),
              StreamBuilder(
                  stream: _journalEditBloc!.noteEdit,
                  builder: (BuildContext build, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    }
// Use the copyWith to make sure when you edit TextField the cursor does not bounce to the first character
                    _noteController!.value = _noteController!.value
                        .copyWith(text: snapshot.data ?? '');
                    return TextField(
                      controller: _noteController,
                      textInputAction: TextInputAction.newline,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                        labelText: 'Note',
                        icon: Icon(Icons.subject),
                      ),
                      maxLines: null,
                      onChanged: (note) =>
                          _journalEditBloc!.noteEditChanged.add(note),
                    );
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(Colors.grey.shade100)),
                    child: Text('Cancel'),
                  ),
                  const SizedBox(
                    width: 8.00,
                  ),
                  TextButton(
                    onPressed: () {
                      _addOrUpdateJournal();
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(Colors.lightGreen.shade100)),
                    child: Text("Save"),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
