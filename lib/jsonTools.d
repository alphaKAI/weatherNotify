module lib.jsonTools;
import std.string,
       std.conv,
       std.regex,
       std.json;

class jsonTools{
  string getJsonData(JSONValue parsedJson, string key){
    return parsedJson.object[key].to!string.replace(regex("\"", "g") ,"");
  }
  string removeList(string base, string[] list){
    string buf = base;
    foreach(elem; list){
      buf = buf.removechars(elem);
    }
    return buf;
  }
}
