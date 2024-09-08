import 'package:flutter/material.dart';
import 'package:journalapp/classes/database.dart';
import 'dart:math';
import 'package:intl/intl.dart';

class Editentry extends StatefulWidget {
  @override
  final bool? add;
  final int? index;
  final JournalEdit journalEdit;
  const Editentry({Key? key, this.add, this.index, required this.journalEdit})
      : super(key: key);
  _EditentryState createState() => _EditentryState();
}

class _EditentryState extends State<Editentry> {
  JournalEdit? _journalEdit;
  String? _title;
  DateTime? _selectedDate;
  TextEditingController _moodcontroller = TextEditingController();
  TextEditingController _notecontroller = TextEditingController();
  FocusNode _moodnode = FocusNode();
  FocusNode _notenode = FocusNode();

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

  void dispose() {
    _moodcontroller.dispose();
    _notecontroller.dispose();
    _moodnode.dispose();
    _notenode.dispose();
    super.dispose();
  }

  Future<DateTime> _selectDate(DateTime selectedDate) async {
    DateTime _initialDate = selectedDate;
    final DateTime? _pickeddate = await showDatePicker(
      context: context,
      initialDate: _initialDate,
      firstDate: DateTime.now().subtract(Duration(days: 360)),
      lastDate: DateTime.now().add(
        Duration(days: 360),
      ),
    );
    if (_pickeddate != null) {
      selectedDate = DateTime(
          _pickeddate.year,
          _pickeddate.month,
          _initialDate.day,
          _initialDate.hour,
          _initialDate.minute,
          _initialDate.second);
    }
    return selectedDate;
  }

  Widget build(BuildContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$_title Entry'),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.00),
          child: Column(
            children: <Widget>[
              TextButton(
                onPressed: () async {
                  FocusScope.of(context).requestFocus(
                      FocusNode()); //dismiss the keyboard if any TextField wdget has focus.
                  DateTime _pickeddate = await _selectedDate!;
                  setState(() {
                    _selectedDate = _pickeddate;
                  });
                },
                child: Padding(
                  padding: EdgeInsets.all(0.00),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.calendar_today,
                        size: 24,
                        color: Colors.black54,
                      ),
                      SizedBox(
                        width: 16.00,
                      ),
                      Text(
                        DateFormat.yMMMEd().format(_selectedDate!),
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black54,
                        ),
                        onPressed: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          DateTime? _pickdate = await showDatePicker(
                            context: context,
                            initialDate: _selectedDate ?? DateTime.now(),
                            firstDate:
                                DateTime.now().subtract(Duration(days: 360)),
                            lastDate: DateTime.now().add(Duration(days: 360)),
                          );
                          if (_pickdate != null && _pickdate != _selectedDate) {
                            setState(() {
                              _selectedDate = _pickdate;
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
                decoration: InputDecoration(
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
                decoration: InputDecoration(
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
                    child: Text('Cancel'),
                    style: ButtonStyle(
                        textStyle: WidgetStatePropertyAll(
                            TextStyle(color: Colors.grey.shade100))),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  TextButton(
                    onPressed: () {
                      _journalEdit!.action = 'Save';
                      String? _id = widget.add!
                          ? Random().nextInt(9999).toString()
                          : _journalEdit!.journal.id;
                      _journalEdit!.journal = Journal(
                        id: _id,
                        date: _selectedDate.toString(),
                        mood: _moodcontroller.text,
                        note: _notecontroller.text,
                      );

                      Navigator.pop(context, _journalEdit);
                    },
                    child: Text('Save'),
                    style: ButtonStyle(
                        textStyle: WidgetStatePropertyAll(
                            TextStyle(color: Colors.lightGreen.shade100))),
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
