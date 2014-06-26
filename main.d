/***
  Weather Notify
    The weather notification application with Livedoor Weather Web Service, which written in the D programming language.

  Licence: The Mit Licenst
  Author: alphaKAI (Twitter:@alpha_kai_NET)
  Copyright (C) alphaKAI 2014 http://alpha-kai-net.info

  Notice:
    This version is development snapshot.
  Compile And Run:
    Compile:
    $ dmd main.d lib/rssTools.d lib/jsonTools.d -L-lcurl
    Run:
    $ ./main
  */

import std.algorithm,
       std.net.curl,
       std.process,
       std.string,
       std.regex,
       std.stdio,
       std.json,
       std.path,
       std.file,
       std.conv,
       std.xml;

import lib.rssTools;
import lib.jsonTools;

class weatherNotify{
  RSSTools  rt = new RSSTools;
  jsonTools jt = new jsonTools;
  string[string][string] prefs;
  __gshared immutable rssUrl  = "http://weather.livedoor.com/forecast/rss/primary_area.xml";
  __gshared immutable baseUrl = "http://weather.livedoor.com/forecast/webservice/json/v1?city=";
  string settingJson;

  this(){
    (){//Build Place List
      if(!exists("resource/primary_area.xml"))
        if(!rt.saveRSS(rssUrl, [getcwd, "resource"].join("/")))
            throw new Error("Failed to save RSS as XML");
      string xml = cast(string)std.file.read("resource/primary_area.xml");
      std.xml.check(xml);
      auto doc = new DocumentParser(xml);

      doc.onStartTag["pref"] = (ElementParser xml){
        string currentPref = xml.tag.attr["title"];
        xml.onStartTag["city"] = (ElementParser xml){
          string city = cast(string)xml.tag.attr["title"];
          string id   = cast(string)xml.tag.attr["id"];
          prefs[currentPref][city] = id;
        };

        xml.parse();
      };
      doc.parse();
    }();

    settingJson = readSettingFile;
  }

  void placeLists(){
    foreach(key, pref; prefs)
      writeln(key, ":",pref);
    return;
  }

  bool sendNotify(string pref, string city){
    auto parsed = parseJSON(get(baseUrl ~ prefs[pref][city]));
    string notifyString = jt.getJsonData(parsed.object["description"], "text").split("\\n").map!(x => x ~= "\n").join.to!string;

    //system("notify-send \'" ~ notifyString ~ "\'");
    writeln(notifyString);
    return true;
  }

  private{
    string readSettingFile(){
      auto file = File("resource/setting.json", "r");
      string buf;

      foreach(line; file.byLine)
        buf = buf ~ cast(string)line;

      return buf;
    }
  }
}

unittest{
  weatherNotify wn = new weatherNotify;

  wn.sendNotify("福井県", "福井");
}
