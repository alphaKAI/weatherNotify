module lib.rssTools;
import std.net.curl,
       std.string,
       std.file;

class RSSTools{
  string getRSS(string url){
    string data;
    return data;
  }
  bool saveRSS(string url, string tpath = getcwd){
    string name = (){
      string[] tmp = url.split("/");
      if(tmp is [])
        throw new Exception("Error");
      return tmp[$ - 1];
    }();
    string cdir = tpath ~ "/" ~name;
    download(url, cdir);
    
    if(!exists(cdir))
      return false;

    return true;
  }
}
