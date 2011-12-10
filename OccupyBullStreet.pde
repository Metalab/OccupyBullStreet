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
import fullscreen.*;

FullScreen fs;

SimpleOpenNI  context;

PVector       neck_kinect;
PVector       neck;

ArrayList     students;
Bull        bull;

boolean     play;
boolean     dead;
boolean     usekinect;
ReadyBox    readyBox;

Timer         timer;
int           studentCount;

Road roadBg = new Road();

void setup() {
  usekinect = true;

  if (usekinect) {
    play = false;
  } else {
    play = true;
  }

  dead = false;
  neck_kinect = new PVector();
  neck = new PVector();
  students = new ArrayList();
  studentCount = 10;

  fs = new FullScreen(this);
  size(640, 480);

  if(usekinect) context = new SimpleOpenNI(this);

  readyBox = new ReadyBox();
  timer = new Timer(20000);

  for (int i = 0; i <= studentCount; i++) {
     students.add(new Student());
  }

  // enable depthMap generation 
  if(usekinect) context.enableDepth();

  // enable skeleton generation for all joints
  if(usekinect) context.enableUser(SimpleOpenNI.SKEL_PROFILE_UPPER);

  background(200,0,0);
  roadBg.setup("street.jpg");
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
  background(0, 0, 0);
  roadBg.draw();
  if(usekinect) context.update();

  if (play && !dead) {
    if(usekinect) drawSkeleton(1);
    bull.draw();
    text(timer.remainingTime()/1000, 15, 30);
    if (timer.isFinished()) {
      dead = true;
    }

    for (int i = students.size()-1; i >= 0; i--) {
      Student student = (Student) students.get(i);
      if(student.alive)student.draw();
       if(student.overlaps(bull)){
          student.alive=false;
      } else student.alive=true;
    }
  } else {
    readyBox.draw();
    if(context.isTrackingSkeleton(1)) {
      play = true;
      timer.start();
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

