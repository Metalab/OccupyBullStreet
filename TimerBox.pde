class TimerBox {
  Timer timer;
  Minim minim;
  AudioPlayer countdown;

  TimerBox(Timer timer, Minim minim) {
    // this loads mysong.wav from the data folder
    countdown = minim.loadFile("clockwindup.mp3");
    this.timer = timer;
  }

  void draw() {
    if (timer.remainingTime()/1000 < 6) {
      playSound();
    }
    text("TIME LEFT: " + int(timer.remainingTime()/1000), 15, 30);
  }

  void playSound(){
    if(!countdown.isPlaying())countdown.loop();
  }

  void pauseSound(){
    countdown.pause();
  }
}
