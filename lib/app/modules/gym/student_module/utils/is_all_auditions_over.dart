

isAllAuditionsOver(List<dynamic> auditions ){
  for(int i =0; i <auditions.length; i++){
    if(auditions[i]['didPass'] == null){
      return false;
    }
  }
  return true;
}