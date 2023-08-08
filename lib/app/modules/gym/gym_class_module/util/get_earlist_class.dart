
getEarlistClass(List<dynamic> classMasters) {
  // for(int i =0; i <classMasters.length; i++){
  //   var hour = classMasters[i]['currentClassDetail']['hourStart'].toString();
  //   var minute = classMasters[i]['currentClassDetail']['minStart'].toString();
  // }
  classMasters.sort((a,b){
    return getDateTimeString(a).compareTo(getDateTimeString(b));
  });

  // for(int i =0; i <classMasters.length; i++){
  //   var hour = classMasters[i]['currentClassDetail']['hourStart'].toString();
  //   var minute = classMasters[i]['currentClassDetail']['minStart'].toString();
  // }
  return classMasters;
}

getDateTimeString(dynamic classMaster){
  var hour = classMaster['currentClassDetail']['hourStart'].toString();
  var minute = classMaster['currentClassDetail']['minStart'].toString();
  if(minute.length ==1){
    minute = '0$minute';
  }
  final timeString = hour + minute;
  return int.parse(timeString);
}
