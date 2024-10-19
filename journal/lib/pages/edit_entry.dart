import 'package:flutter/material.dart';
import 'package:journal/blocs/journalentry_bloc.dart';
import 'package:journal/blocs/journalentrybloc_Provider.dart';
import 'package:journal/classes/mood_icon.dart';
import 'package:journal/classes/formatdates.dart';

class EditEntry extends StatefulWidget {
  const EditEntry({super.key});

  @override
  _EditEntryState createState() => _EditEntryState();
}

class _EditEntryState extends State<EditEntry> {
  JournalEditBloc? _journalEditBloc;
  MoodIcons? _moodIcons;
  Formatdates? _formatdates;
  TextEditingController? _noteController;
  @override
  void initState() {
    super.initState();
    _moodIcons = const MoodIcons();
    _formatdates = Formatdates();
    _noteController = TextEditingController();
    _noteController!.text = '';
  }

  @override
  void didChangeDepedencies() {
    super.didChangeDependencies();
    _journalEditBloc = JournalentryblocProvider.of(context).journalEditBloc;
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
                    if (!snapshot.hasData) {
                      return Container();
                    }
                    return DropdownButtonHideUnderline(
                      child: DropdownButton<MoodIcons>(
                        value: _moodIcons!.getMoodIconList()[_moodIcons!
                            .getMoodIconList()
                            .indexWhere((icon) => icon.title == snapshot.data)],
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
                                          selected.color.toString())!),
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
                    _noteController!.value =
                        _noteController!.value.copyWith(text: snapshot.data);
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
