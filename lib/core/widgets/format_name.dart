import 'package:life_makers/core/utils/extensions.dart';

String formatName(String name){

  if(name.contains(' ')){
    return '${name.split(' ').first[0].capitalize}${name.split(' ').last[0].capitalize}';
  }
  return '${name[0].capitalize}${name[1].capitalize}';
}