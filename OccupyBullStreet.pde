/* --------------------------------------------------------------------------
 * SimpleOpenNI User Test
 * --------------------------------------------------------------------------
 * Processing Wrapper for the OpenNI/Kinect library
 * http://code.google.com/p/simple-openni
 * --------------------------------------------------------------------------
 * prog:  Max Rheiner / Interaction Design / zhdk / http://iad.zhdk.ch/
 * date:  02/16/2011 (m/d/y)
 * ----------------------------------------------------------------------------
 */

import SimpleOpenNI.*;

SimpleOpenNI  context;

PVector       neck_kinect;
PVector       neck;

ArrayList     students;

boolean       play;
boolean       dead;

ReadyBox      readyBox;

Timer         timer;

HighScore     score;

void setup() {
  
  play = true;
  dead = false;
  neck_kinect = new PVector();
  neck = new PVector();
  students = new ArrayList();
  context = new SimpleOpenNI(this);
  readyBox = new ReadyBox();
  timer = new Timer(20000);
  score = new HighScore();

  for (int i = 0; i <= 30; i++) {
    students.add(new Student());
  }

  // enable depthMap generation 
  context.enableDepth();

  // enable skeleton generation for all joints
  context.enableUser(SimpleOpenNI.SKEL_PROFILE_UPPER);

  background(200,0,0);

  smooth();
  
  size(context.depthWidth(), context.depthHeight()); 
}

void draw() {
  background(0, 0, 0);
  context.update();

  if (play && !dead) {
    drawSkeleton(1);
    text(timer.remainingTime()/1000, 15, 30);
    if (timer.isFinished()) {
      dead = true;
    }

    for (int i = students.size()-1; i >= 0; i--) {
      Student student = (Student) students.get(i);
      student.draw();
    }

    update();
  } else {
    readyBox.draw();

    if(context.isTrackingSkeleton(1)) {
      play = true;
      timer.start();
    }
  }
}

void update() {
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

  rectMode(CENTER);
  stroke(204, 102, 0);
  noFill();
  rect(neck.x, neck.y+100, 150, 200);
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

