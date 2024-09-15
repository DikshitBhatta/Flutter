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
  JournalEditBloc _journalEditBloc;
  MoodIcons _moodIcons;
  Formatdates _formatdates;
  TextEditingController _noteController;
  @override
  void initState() {
    super.initState();
    _moodIcons = MoodIcons();
    _formatdates = Formatdates();
    _noteController = TextEditingController();
    _noteController.text = '';
  }

  @override
  void didChangeDepedencies() {
    super.didChangeDependencies();
    _journalEditBloc = JournalEditBlocProvider.of(context).journalEditBloc;
  }

  @override
  void dispose() {
    _noteController.dispose();
    _journalEditBloc.dispose();
    super.dispose();
  }

  Future<String> _selectDate(String selectedDate) async {
    DateTime _initialDate = DateTime.parse(selectedDate);
    final DateTime _pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now().subtract(Duration(days: 365)),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (_pickedDate != null) {
      selectedDate = DateTime(
        _pickedDate.year,
        _pickedDate.month,
        _pickedDate.day,
        _initialDate.hour,
        _initialDate.minute,
        _initialDate.second,
      ).toString();
    }
    return selectedDate;
  }

  void _addOrUpdateJournal() {
    _journalEditBloc.saveJournalChanged.add('Save');
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
        minimum: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              StreamBuilder(stream: stream, 
              builder: (BuildContext context,AsyncSnapshot snapshot){
                if(!snapshot.hasData){
                  return Container();
                }
                return TextButton(
                  onPressed: (){}, 
                  child: Row(children: <Widget>[
                    Icon( Icons.calendar_today,
                    size: 22.00,
                    color: Colors.black54,),
                    SizedBox(width: 16.00,),
                    Text(_formatdates.dateFormatShortMonthDayYear(snapshot.data),style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold),),
                    Icon(Icons.arrow_drop_down,
                    color: Colors.black54,),
                  ],),
                  onPressed() async{
                      FocusScope.of(context).requestFocus(FocusNode()); 
                      String _pickerDate = await _selectDate(snapshot.data); 
                      _journalEditBloc.dateEditChanged.add(_pickerDate);
                  } );
              }),
              StreamBuilder(
                stream: _journalEditBloc.moodEdit, 
                builder: (BuildContext context,AsyncSnapshot snapshot){
                  if(!snapshot.hasData){
                      return Container();
                  }
                  return DropdownButtonHideUnderline(child: DropdownButton<MoodIcons>(
                    value: _moodIcons.getMoodIconList()[
                      _moodIcons,
                      .getMoodIconList()
                      .indexWhere((icon) => icon.title == snapshot.data)
                    ],
                    onChanged: (selected){
                      _journalEditBloc.moodEditChanged.add(selected.title);
                    },
                    items: _moodIcons.getMoodIconList().map((MoodIcons selected){
                      return DropdownMenuItem<MoodIcons>(
                        value: selected,
                        child:Row(
                          children: <Widget>[
                            Transform(transform: Matrix4.identity()..rotateZ(
                              _moodIcons.getMoodRotation(selected.title)
                            ),
                            alignment: Alignment.center,
                            child: Icon(_moodIcons.getMoodIcon(selected.title),
                            color: _moodIcons.getMoodColor(selected.color)),
                            ),
                            SizedBox(width: 16.00,),
                            Text(selected.title),
                          ],
                        ), );
                    }).tolist(),
                  ),);

                }),
                StreamBuilder(
                stream: _journalEditBloc.noteEdit, 
                builder: (BuildContext build,AsyncSnapshot snapshot){
                  if (!snapshot.hasData) { return Container();
}
// Use the copyWith to make sure when you edit TextField the cursor does not bounce to the first character
_noteController.value = _noteController.value.copyWith(text: snapshot.data);
return TextField(
controller: _noteController,
textInputAction: TextInputAction.newline, textCapitalization: TextCapitalization.sentences, decoration: InputDecoration(
labelText: 'Note',
icon: Icon(Icons.subject), ),
maxLines: null,
onChanged: (note) => _journalEditBloc.noteEditChanged.add(note), );
                }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(onPressed: (){Navigator.pop(context);}, child: Text('Cancel'),style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.grey.shade100)),),
                    SizedBox(width: 8.00,),
                    TextButton(onPressed: (){_addOrUpdateJournal();}, child: Text("Save"),style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.lightGreen.shade100)),)
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
