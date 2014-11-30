/***
  Weather Notify
    The weather notification application with Livedoor Weather Web Service, which written in the D programming language.

  Licence: The Mit Licenst
  Author: alphaKAI (Twitter:@alpha_kai_NET)
  Copyright (C) alphaKAI 2014 http://alpha-kai-net.info
  */
module lib.weatherNotify;
import lib.weather;
class weatherNotify{
  Weather weather;

  this(){
    weather = new Weather;
  }

  string sendNotify(string pref, string city){
    string returnString = weather.getWeather(pref, city);
    import std.stdio;
    returnString.writeln;
    return returnString;
  }
}
