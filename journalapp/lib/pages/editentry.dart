import 'package:flutter/material.dart';
import 'package:journalapp/classes/database.dart';
import 'dart:math';
import 'package:intl/intl.dart';

class Editentry extends StatefulWidget {
  @override
  final bool? add;
  final int? index;
  final JournalEdit journalEdit;
  const Editentry({super.key, this.add, this.index, required this.journalEdit});
  @override
  _EditentryState createState() => _EditentryState();
}

class _EditentryState extends State<Editentry> {
  JournalEdit? _journalEdit;
  String? _title;
  DateTime? _selectedDate;
  final TextEditingController _moodcontroller = TextEditingController();
  final TextEditingController _notecontroller = TextEditingController();
  final FocusNode _moodnode = FocusNode();
  final FocusNode _notenode = FocusNode();

  @override
  void initState() {
    super.initState();
    _journalEdit =
        JournalEdit(action: 'Cancel', journal: widget.journalEdit.journal);
    _title = widget.add! ? 'Add' : "Edit";
    _journalEdit!.journal = widget.journalEdit.journal;
    if (widget.add!) {
      _selectedDate = DateTime.now();
      _moodcontroller.text = '';
      _notecontroller.text = '';
    } else {
      _selectedDate = widget.journalEdit.journal.date != null
          ? DateTime.parse(widget.journalEdit.journal.date!)
          : DateTime.now();
      _moodcontroller.text = _journalEdit!.journal.mood!;
      _notecontroller.text = _journalEdit!.journal.note!;
    }
  }

  @override
  void dispose() {
    _moodcontroller.dispose();
    _notecontroller.dispose();
    _moodnode.dispose();
    _notenode.dispose();
    super.dispose();
  }

  Future<DateTime> _selectDate(DateTime selectedDate) async {
    DateTime initialDate = selectedDate;
    final DateTime? pickeddate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now().subtract(const Duration(days: 360)),
      lastDate: DateTime.now().add(
        const Duration(days: 360),
      ),
    );
    if (pickeddate != null) {
      selectedDate = DateTime(
          pickeddate.year,
          pickeddate.month,
          initialDate.day,
          initialDate.hour,
          initialDate.minute,
          initialDate.second);
    }
    return selectedDate;
  }

  @override
  Widget build(BuildContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$_title Entry'),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.00),
          child: Column(
            children: <Widget>[
              TextButton(
                onPressed: () async {
                  FocusScope.of(context).requestFocus(
                      FocusNode()); //dismiss the keyboard if any TextField wdget has focus.
                  DateTime pickeddate = _selectedDate!;
                  setState(() {
                    _selectedDate = pickeddate;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(0.00),
                  child: Row(
                    children: <Widget>[
                      const Icon(
                        Icons.calendar_today,
                        size: 24,
                        color: Colors.black54,
                      ),
                      const SizedBox(
                        width: 16.00,
                      ),
                      Text(
                        DateFormat.yMMMEd().format(_selectedDate!),
                        style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black54,
                        ),
                        onPressed: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          DateTime? pickdate = await showDatePicker(
                            context: context,
                            initialDate: _selectedDate ?? DateTime.now(),
                            firstDate:
                                DateTime.now().subtract(const Duration(days: 360)),
                            lastDate: DateTime.now().add(const Duration(days: 360)),
                          );
                          if (pickdate != null && pickdate != _selectedDate) {
                            setState(() {
                              _selectedDate = pickdate;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              TextField(
                controller: _moodcontroller,
                autofocus: true,
                textInputAction: TextInputAction.next,
                focusNode: _moodnode,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'MOOD',
                  icon: Icon(Icons.mood),
                ),
                onSubmitted: (submitted) {
                  FocusScope.of(context).requestFocus(_notenode);
                },
              ),
              TextField(
                controller: _notecontroller,
                autofocus: true,
                textInputAction: TextInputAction.newline,
                focusNode: _notenode,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  labelText: 'note',
                  icon: Icon(Icons.subject),
                ),
                maxLines: null,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      _journalEdit!.action = 'Cancel';
                      Navigator.pop(context, _journalEdit);
                    },
                    style: ButtonStyle(
                        textStyle: WidgetStatePropertyAll(
                            TextStyle(color: Colors.grey.shade100))),
                    child: Text('Cancel'),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  TextButton(
                    onPressed: () {
                      _journalEdit!.action = 'Save';
                      String? id = widget.add!
                          ? Random().nextInt(9999).toString()
                          : _journalEdit!.journal.id;
                      _journalEdit!.journal = Journal(
                        id: id,
                        date: _selectedDate.toString(),
                        mood: _moodcontroller.text,
                        note: _notecontroller.text,
                      );

                      Navigator.pop(context, _journalEdit);
                    },
                    style: ButtonStyle(
                        textStyle: WidgetStatePropertyAll(
                            TextStyle(color: Colors.lightGreen.shade100))),
                    child: Text('Save'),
                  ),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
