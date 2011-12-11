/* --------------------------------------------------------------------------
 * Occupy Bull Street
 * --------------------------------------------------------------------------
 * Metalab Game Dev Weekend
 * https://github.com/Metalab/OccupyBullStreet
 * --------------------------------------------------------------------------
 * prog:  Benjamin Fritsch / Kristin Albert / Jayme "The Bear" Cochrane
 * date:  12/09/2011 (m/d/y)
 * ----------------------------------------------------------------------------
 */

import SimpleOpenNI.*;
import fullscreen.*;
import ddf.minim.*;

FullScreen    fs;

SimpleOpenNI  context;

PVector       neck_kinect;
PVector       neck;

ArrayList     students;
Bull          bull;

boolean       play;
boolean       dead;
boolean       usekinect;
ReadyBox      readyBox;

ScoreBox      scoreBox;

TimerBox      timerBox;
Timer         timer;
Minim         minim;

int           studentCount;
int           studentSpeed;

PImage        titleImg;

Road roadBg = new Road();

PFont         font;
int           level;
int           playerId;

AudioPlayer   protestersSong;

void setup() {
  usekinect = false;

  play = false;
  dead = true;
  neck_kinect = new PVector();
  neck = new PVector();
  students = new ArrayList();
  studentCount = 2;
  studentSpeed = 2;

  fs = new FullScreen(this);
  size(640, 480);

  if(usekinect) context = new SimpleOpenNI(this);

  scoreBox = new ScoreBox();
  readyBox = new ReadyBox();
  minim = new Minim(this);
  timer = new Timer(30000);
  timerBox = new TimerBox(timer, minim);
  level = 1;
  protestersSong = minim.loadFile("protesters.mp3");


  for (int i = 0; i <= studentCount-1; i++) {
     students.add(new Student(studentSpeed));
  }

  // enable depthMap generation 
  if(usekinect) context.enableDepth();

  // enable skeleton generation for all joints
  if(usekinect) context.enableUser(SimpleOpenNI.SKEL_PROFILE_UPPER);

  titleImg = loadImage("title.jpg");
  roadBg.setup("street.jpg");

  font = createFont("din", 24);
  textFont(font);

  smooth();

  if(usekinect) {
    size(context.depthWidth(), context.depthHeight());
  } else {
    bull = new Bull(width/2, height-100);
  }
  // enter fullscreen mode
  //fs.enter();
}

void draw() {
  // draw background
  background(0, 0, 0);
  roadBg.draw();

  if(usekinect) context.update();

  //start game
  if (play && !dead) {
    if(usekinect) drawSkeleton(playerId);

    //end of game
    if (timer.isFinished()) {
      dead = true;
      protestersSong.pause();
      protestersSong.rewind();
      timerBox.pauseSound();
    }

    //keep track of level/difficulty
    if(timer.passedTime()/1000>=level*5) {
      level ++;
      studentCount += 2;
      studentSpeed += 2;
    }

    //generate students
    if(students.size()<studentCount){
      students.add(new Student(studentSpeed));
    }

    //keep track of students on screen
    //draw students
    for (int i = students.size()-1; i >= 0; i--) {
      Student student = (Student) students.get(i);
      if(student.isOutsideScreen()){
        students.remove(i);
        continue;
      }

      if(student.alive) {
        if(student.overlaps(bull)) {
          scoreBox.scoreFuckYeah();
          student.die();
        }
      }

      student.draw();
    }

    //draw bull
    bull.draw();
    scoreBox.draw();
    timerBox.draw();

  } else {
      image(titleImg, 0, 0);
      if (scoreBox.hasScoredYet) scoreBox.draw();
      readyBox.draw();
      if (usekinect) {

        IntVector userList = new IntVector();
        context.getUsers(userList);

        for (int i = int(userList.size())-1; i >= 0; i--) {

          int userId = userList.get(i);
          if(context.isTrackingSkeleton(userId)) {
            playerId = userId;
            play = true;
            dead = false;
            timer.start();
            protestersSong.loop();
          }
        }
      }
    }

  update();
}

void update() {
  roadBg.update();

  for (int i = students.size()-1; i >= 0; i--) {
    Student student = (Student) students.get(i);
    student.update();
  }
}

// draw the skeleton with the selected joints
void drawSkeleton(int userId) {
  // to get the 3d joint data
  context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_NECK, neck_kinect);
  context.convertRealWorldToProjective(neck_kinect, neck);

  if (bull == null) {
    bull = new Bull(neck.x, neck.y);
  }

  float distanceToMiddle = width/2 - neck.x;

  bull.setPosition(neck.x - distanceToMiddle*-2, neck.y+100);
}

// backup keyboard controls
void keyPressed() {
  switch(keyCode) {
    case UP:
      if(bull.y >= 0) {
        bull.setPosition(bull.x, bull.y -= 15);
      }
      break;
    case DOWN:
      if(bull.y <= height) {
        bull.setPosition(bull.x, bull.y += 15);
      }
      break;
    case LEFT:
      if(bull.x >= 0) {
        bull.setPosition(bull.x -= 15, bull.y);
      }
      break;
    case RIGHT:
      if(bull.x <= width) {
        bull.setPosition(bull.x += 15, bull.y);
      }
      break;
    case ENTER:
      if(dead && !usekinect){
        timer.start();
        scoreBox.clear();
        protestersSong.loop();
        dead=false;
        play=true;
      }
      break;
  }
}

// -----------------------------------------------------------------
// SimpleOpenNI events

void onNewUser(int userId) {
  println("onNewUser - userId: " + userId);
  println("  start pose detection");
  
  readyBox.move();
  if (userId == 1) {
    context.startPoseDetection("Psi", userId);
  }
}

void onLostUser(int userId) {
  println("onLostUser - userId: " + userId);
}

void onStartCalibration(int userId) {
  println("onStartCalibration - userId: " + userId);
}

void onEndCalibration(int userId, boolean successfull) {
  println("onEndCalibration - userId: " + userId + ", successfull: " + successfull);

  if (successfull) {
    readyBox.ready();

    println("  User calibrated !!!");
    context.startTrackingSkeleton(userId); 
  } else {
    println("  Failed to calibrate user !!!");
    println("  Start pose detection");
    context.startPoseDetection("Psi",userId);
  }
}

void onStartPose(String pose,int userId) {
  println("onStartPose - userId: " + userId + ", pose: " + pose);
  println(" stop pose detection");

  context.stopPoseDetection(userId); 
  context.requestCalibrationSkeleton(userId, true);
}

void onEndPose(String pose,int userId) {
  println("onEndPose - userId: " + userId + ", pose: " + pose);
}

