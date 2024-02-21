
class NoteModel{
   int? _id;
  late String _title;
   String? _description="";
  late String _date;
   late int _priority;


   NoteModel(this._title, this._date, this._priority,[this._description=""]);

  NoteModel.withID(
      this._id, this._title, this._date, this._priority,[this._description=""]);



   int get priority => _priority;

  set priority(int newPriority) {
    if(newPriority >=1 && newPriority <= 2){
      _priority = newPriority;
    }
  }

  String get date => _date;

  set date(String value) {
    _date = value;
  }

  String? get description => _description;

  set description(String? value) {
    _description = value;
  }

  String get title => _title;

  set title(String value) {
    if(value.length<=255){
      _title = value;
    }
  }

  int? get id => _id;

  set id(int? value) {
    _id = value;
  }

  Map<String, dynamic>toMap(){
    var map=Map<String, dynamic>();
    if(_id!=null){
      map['id']=_id;
    }
    map['title']=_title;
    map['description']=_description;
    map['priority']=_priority;
    map['date']=_date;
return map;
}

   NoteModel.formMapObject(Map<String, dynamic> map){
    _id=map['id'];
    _title=map['title'];
    _description=map['description'];
    _priority=map['priority'];
    _date = map['date'] ?? "";;
}


}