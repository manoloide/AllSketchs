class Filter {
  String name;
  String description, author, version;
  JSONObject json;
  String code;


  Filter(JSONObject json) {
    loadJSON(json);
  }

  void loadJSON(JSONObject json) {
    name = json.getString("name");
    description = json.getString("description");
    author = json.getString("author");
    version = json.getString("version");
    code = json.getString("code");
  }
  
  String getCode(){
     return code; 
  }
}

