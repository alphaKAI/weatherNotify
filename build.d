import std.stdio,
       std.file,
       std.process,
       std.array,
       std.algorithm;

void main(){
  if(!std.file.exists("resource/primary_area.xml"))
    throw new Error("File Not Found - primary_area.xml");
  string[] listC = ["lib/jsonTools.d",
                   "lib/rssTools.d",
                   "lib/weather.d",
                   "lib/weatherNotify.d",
                   "main.d"];
  string option  = "-L-lcurl";
  string[] listO;
  listO.length = listC.length;
  foreach(i, x; listC){
    string[] y;
    if(x.find("/")){
      y.length = 2;
      y = x.split("/")[x.split("/").length - 1].split(".");
    } else {
      y.length = 2;
      y = x.split(".");
    }
    y[1] = "o";
    listO[i] = y.join(".");
  }

  foreach(e; listC){
    string buildCMD =  "dmd -c " ~  e;
    writeln("[compile] ", buildCMD);
    system(buildCMD);
    writeln("Success");
  }

  string linkCMD = "dmd " ~ listO.reverse.join(" ") ~  " " ~ option;
  writeln("[link] ", linkCMD);
  system(linkCMD);

  foreach(e; listO){
    string clearCMD = "rm " ~ e;
    writeln("[clear] ", clearCMD);
    system(clearCMD);
  }
}
