class Lang{
   int id;
    String  lang ;
    String  description ;

    Lang(this.lang ,this.description );
    Lang.map(dynamic obj){
      this.lang = obj['lang'];
      this.description = obj['description'];
     // this.id = obj['id'];
    }
    String get _lang => lang;
    String get _description => description;
    int get _id => id;

    Map<String , dynamic> toMap(){
      var map = new Map<String , dynamic>();
      map['lang'] = _lang;
      map['description'] = _description;
      if(id != null){
        map['id'] = _id;
      }
      return map;
}

Lang.fromMap(Map<String , dynamic>map){
  this.lang = map['lang'];
  this.description = map['description'];
  this.id = map['id'];
}

}