import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';

class DatabaseFileRoutines{
  Future<String> get _localPath async{
    final directory=await getApplicationDocumentsDirectory();
    return directory.path
  }
  Future<String> get _localFile async{
    final path=await _localPath;
    return File('$path/local_persistence.json');
  }

  Future<String> readJorunals() async{
    try{
      final file = await _localFile;
      if(!file.existsync){
        print('File does not exist: $')
      }
    }
  }

}