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
      countdown.play();
    } else if (timer.remainingTime()/1000 < 0) {
      countdown.close();
    }

    text("TIME LEFT: " + int(timer.remainingTime()/1000), 15, 30);
  }
}
