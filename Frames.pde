// shamelessly taken from class example
// inspired by http://www.processing.org/learning/topics/animatedsprite.html

// Class to store images to be used as frames of an animation 
// Image files should all be named the same way, ending with a two digit number (from 00 to 99) 
// For example frame_00.gif, frame_01.gif, frame_02.gif, and so on... 
class Frames {

  // An array for storing the images (undefined size)
  PImage[] images;

  // Constructor
  // filePrefix - the beginning of the images' filenames (for example "frame_")
  // fileSuffix - the extension of the image files (for example "gif")
  // numFrames - how many image files to load
  Frames(String filePrefix, String fileSuffix, int numFrames) {
    // create the array to store the images
    images = new PImage[numFrames];                    
    for (int i = 0; i < numFrames; i++) {
      // compose each file's name
      // Use nf() to format 'i' into a two digits number
      String filename = filePrefix + nf(i, 2) + "." + fileSuffix;
      // load the image into the array
      images[i] = loadImage(filename);
    }
  }

  int size() {
    return images.length;
  }
  
}


