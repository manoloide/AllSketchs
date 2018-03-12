
import codeanticode.gsvideo.*;
GSCapture video;
PImage anterior;
boolean mirror;
ArrayList bubblesLocation;
ArrayList bubblesStep;
int bubbleSize;
int maxBubbleCount;
int maxBubbleStep;
float explosionThreshold;
PImage bubbleImage;



void setup()
{
  // Set the window size
  size(640, 480);
  frameRate(10);

  //video
  video = new GSCapture(this, width, height);
  video.start();

  //fotogramas
  anterior = createImage(video.width, video.height, RGB);
  mirror = true;
  bubblesLocation = new ArrayList();
  bubblesStep = new ArrayList();
  bubbleSize = 100;
  maxBubbleCount = 30;
  maxBubbleStep = 8;
  explosionThreshold = 10;

  //image

  bubbleImage = loadImage("bubble.png");
}

//////////////////////////////////////////////////////////////////////////////////

void stop()
{
  video.stop();
  super.stop();
}

//////////////////////////////////////////////////////////////////////////////////

void draw()
{
  // Calculate the movement image from the webcam's feed

  PImage mImage = processMotionImage();

  // Draw the RGB image in accordance with the mirror's choice

  /*
  if(mirror)
   background(mirrorImage(video));
   else
   background(video);
   */

  background((mirror) ? mirrorImage(video) : video);

  // Draw the motion image on window

  /*
  if(mImage != null)
   background(mImage);
   */

  // If there is a valid motion image ...

  if (mImage != null)
  {
    // Add bubbles as needed

    createBubbles();

    // Check if there are bubbles exploded

    checkForExplosions(mImage);
  }

  // Display the bubbles on the window

  showBubbles();

  // Make the bubbles fall

  moveBubbles();
}

//////////////////////////////////////////////////////////////////////////////////

/**
 * Make all the bubbles fall according its own steps
 */

void moveBubbles()
{
  // Walk thru all the bubbles ...

  for (int i=0; i<bubblesLocation.size(); i++)
  {
    // Get the location of the current bubble

    PVector bLoc = (PVector)bubblesLocation.get(i);

    // Get the step size for the current bubble

    PVector bStp = (PVector)bubblesStep.get(i);

    // Modify the Y coordinate of the bubble's position according its step

    bLoc.y = bLoc.y + bStp.y;
  }
}

//////////////////////////////////////////////////////////////////////////////////

/**
 * Display all bubbles on the window
 */

void showBubbles()
{
  // Walk thru all the bubbles ...

  for (int i=0; i<bubblesLocation.size(); i++)
  {
    // Get the location of the current bubble

    PVector bLoc = (PVector)bubblesLocation.get(i);

    // Draw the current bubble (rectangle)

    // rect(bLoc.x, bLoc.y, bubbleSize, bubbleSize);

    // Draw the current bubble (image)

    image(bubbleImage, bLoc.x, bLoc.y, bubbleSize, bubbleSize);
  }
}

//////////////////////////////////////////////////////////////////////////////////

/**
 * Make explode the bubbles touched by user's movement
 *
 * @param    motion image
 */

void checkForExplosions(PImage mImage)
{
  // Walk thru all the bubbles ...

  for (int i=0; i<bubblesLocation.size(); i++)
  {
    // Get the location of the current bubble

    PVector bLoc = (PVector)bubblesLocation.get(i);

    // Calculate the amount of 'hit' (user's movement)
    // over the current bubble

    int amount = checkForHit(mImage, bLoc, bubbleSize);

    // Explode the current bubble according the explosion threshold
    // or if it has fallen out of the window

    if (amount >= bubbleSize * bubbleSize * explosionThreshold / 100 || bLoc.y > mImage.height)
    {
      // Explode a bubble consists in remove it's location

      bubblesLocation.remove(i);

      // And remove it's step value

      bubblesStep.remove(i);

      // Update the index to consider the "next" bubble

      i --;
    }
  }
}

//////////////////////////////////////////////////////////////////////////////////

/**
 * Calculate the amount of "hit" (movement) over the specified area
 *
 * @param    motion image
 * @param    location (x,y) of the specified area
 * @param    diameter or full size of the area (squared)
 * @return   amount of "motion pixels" under the selected area
 */

int checkForHit(PImage mImage, PVector location, int size) {
  // "motion pixels" counter

  int count = 0;

  // Origin point for the specified area

  int x = int(location.x);

  int y = int(location.y);

  // Pick every pixel under the specified area

  for (int px=x; px<x+size; px++)
  {
    for (int py=y; py<y+size; py++)
    {
      // Guarantee that the specified area is not outside the window

      if (px < mImage.width && px > 0 && py < mImage.height && py > 0)
      {
        // Check the color of the current pixel to determine if
        // it is "white" enough (threshold) to be checked as motion

        if (brightness(mImage.get(px, py)) > 127)
          count ++;
      }
    }
  }

  // Return the number of "white" (motion) pixels found

  return count;
}

//////////////////////////////////////////////////////////////////////////////////

/**
 * Create a new bubble if possible with a random location and step size
 */

void createBubbles()
{
  // Check if the bubbles quota is full

  if (bubblesLocation.size() == maxBubbleCount)
    return;

  // Create a new location storage for the new bubble

  PVector bLoc = new PVector();

  // Set the random location for the new bubble

  bLoc.x = random(0, video.width - bubbleSize);
  bLoc.y = 0;

  // Create a new step storage for the new bubble

  PVector bStp = new PVector();

  // Set the random step size for the new bubble

  bStp.x = 0;
  bStp.y = random(1, maxBubbleStep);

  // Add the new bubble's location

  bubblesLocation.add(bLoc);

  // Add the new bubble's step size

  bubblesStep.add(bStp);
}

//////////////////////////////////////////////////////////////////////////////////

/**
 * Create a new motion image based on a new image read from the webcam
 */

PImage processMotionImage()
{
  // Movement image reference

    PImage mImage = null;

  // Check if there is video feed available

  if (video.available())
  {
    // Update the read from the webcam's feed

    video.read();

    // Get the movement image based on the comparison between
    // current image and the previous one

    mImage = getMotionImage(video, anterior, mirror);
  }

  // Return the motion image calculated before

  return mImage;
}

//////////////////////////////////////////////////////////////////////////////////

/**
 * Get the movement image based on the comparison between the current image and the previous one
 *
 * @param    current RGB image
 * @param    previous RGB image
 * @param    flag to mirror the result image
 * @return   movement image (B/W normalized)
 */

PImage getMotionImage(PImage video, PImage anterior, boolean mirror)
{
  // Reserve space for the current image storage

  PImage currFrame = createImage(video.width, video.height, RGB);

  // Create a copy of the current image to create the movement image
  // and not alter the displayed image

  currFrame.copy(video, 0, 0, video.width, video.height, 
  0, 0, video.width, video.height);

  // Reserve space for the movement image storage

  PImage mImage = createImage(video.width, video.height, RGB);

  // Load the pixels of the current image in the pixels array

  currFrame.loadPixels();

  // Load the pixels of the previous image in the pixels array

  anterior.loadPixels();

  // Check every pixel of the current image comparing it with the
  // corresponding pixel on the previous image to determine the
  // movement

  for (int x=0; x<currFrame.width; x++)
  {
    for (int y=0; y<currFrame.height; y++)
    {
      // Get the corresponding index in the pixel's array based on the
      // (x,y) coordinate analyzed

      int index = x + y * currFrame.width;

      // If it needs to be mirrored invert the x-position

      int indexTarget = index;

      if (mirror)
        index = (currFrame.width - x - 1) + y * currFrame.width;

      // Get the color of the pixel in the selected position from the
      // current and previous images

      color current  = currFrame.pixels[index];
      color previous = anterior.pixels[index];

      // Get the "distance" between the RGB colors of the pixel in
      // both images

      float diff = dist(red  (current), 
      green(current), 
      blue (current), 
      red  (previous), 
      green(previous), 
      blue (previous));

      // Normalize by threshold: it's movement (white) if the difference is higher
      // than a specific value, lower than that it's still (black)

      mImage.pixels[indexTarget] = (diff > 50) ? color(255) : color(0);
    }
  }

  // Store the current image as the previous image for the next iteration

  anterior.copy(currFrame, 0, 0, video.width, video.height, 
  0, 0, video.width, video.height);

  anterior.updatePixels();

  // Return the movement image created before

  return mImage;
}

//////////////////////////////////////////////////////////////////////////////////

/**
 * Calculates the mirror image based in an original one
 *
 * @param    source RGB image to be mirrored
 * @return   mirror image of the original one
 */

PImage mirrorImage (PImage source)
{
  // Create new storage for the result RGB image

    PImage response = createImage(source.width, source.height, RGB);

  // Load the pixels data from the source and destination images

  source.loadPixels();

  response.loadPixels();

  // Walk thru each pixel of the source image

  for (int x=0; x<source.width; x++)
  {
    for (int y=0; y<source.height; y++)
    {
      // Calculate the inverted X (loc) for the current X

      int loc = (source.width - x - 1) + y * source.width;

      // Get the color (brightness for B/W images) for
      // the inverted-X pixel

      color c = source.pixels[loc];

      // Store the inverted-X pixel color information
      // on the destination image

      response.pixels[x + y * source.width] = c;
    }
  }

  // Return the result image with the pixels inverted
  // over the x axis

  return response;
}

//////////////////////////////////////////////////////////////////////////////////

