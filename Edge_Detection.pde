PImage bkimg;

color white = color(255);
color black = color(0);

void setup() {
  size(300, 300, P2D);
  surface.setResizable(true);
  selectInput("Select an image to process:", "imageSelected"); //sets bkimg in callback
  while(bkimg == null) {delay(100);} //wait for user to select an image
  surface.setSize(bkimg.width, bkimg.height);
  noLoop();
}

void imageSelected(File selection) {
  if (selection == null) {
    println("Window was closed or user hit cancel.");
    selectInput("Select an image to process:", "imageSelected"); //sets bkgnd in callback
  } else {
    bkimg = loadImage(selection.getAbsolutePath());
  }
}

boolean isDiffColor(color pxlA, color pxlB) {
  return ((abs(red(pxlA)-red(pxlB)) + abs(green(pxlA)-green(pxlB)) + abs(blue(pxlA)-blue(pxlB))) >= 255);
}

void draw() {
  image(bkimg, 0, 0);
  loadPixels();
  
  boolean[] edgeMapH = new boolean[width * height];
  boolean[] edgeMapV = new boolean[width * height];
  boolean[] edgeMapDR = new boolean[width * height];
  boolean[] edgeMapDL = new boolean[width * height];
  for(int i = 0; i < edgeMapH.length; i++) {
    edgeMapH[i] = false;
    edgeMapV[i] = false;
    edgeMapDR[i] = false;
    edgeMapDL[i] = false;
  }
  
  //horizontal edge check
  for(int i = 0; i < edgeMapH.length - 1; i++) {
    if(!edgeMapH[i]) {
      if(isDiffColor(pixels[i], pixels[i+1])) {
        edgeMapH[i] = true;
        edgeMapH[i+1] = true;
      }
    }
  }
  
  //vertical edge check
  for(int i = 0; i < edgeMapV.length - width; i++) {
    if(!edgeMapV[i]) {
      if(isDiffColor(pixels[i], pixels[i+width])) {
        edgeMapV[i] = true;
        edgeMapV[i+width] = true;
      }
    }
  }
  
  //diagonal down-right edge check
  for(int i = 0; i < edgeMapDR.length - width; i++) {
    if(!edgeMapDR[i]) {
      if(isDiffColor(pixels[i], pixels[i+width+1])) {
        edgeMapDR[i] = true;
        edgeMapDR[i+width+1] = true;
      }
    }
    if(i % width == width - 2) {
        i++;
    }
  }
  
  //diagonal down-left edge check
  for(int i = 0; i < edgeMapDL.length-width; i++) {
    if(i % width == 0) {
      i++;
    } else if(!edgeMapDL[i]) {
      if(isDiffColor(pixels[i], pixels[i+width-1])) {
        edgeMapDL[i] = true;
        edgeMapDL[i+width-1] = true;
      }
    }
  }
  
  for(int i = 0; i < edgeMapH.length; i++) {
    if(edgeMapH[i] || edgeMapV[i] || edgeMapDR[i] || edgeMapDL[i]) {pixels[i] = white;}
    else {pixels[i] = black;}
  }
  updatePixels();
}