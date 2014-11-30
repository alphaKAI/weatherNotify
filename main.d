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

import lib.weatherNotify,
       lib.weather;

void main(){
  weatherNotify wn = new weatherNotify;

  wn.sendNotify("福井県", "福井");
  wn.sendNotify("東京都", "東京");
}
