PImage bkimg;

void setup() {
  size(300, 300, P2D);
  surface.setResizable(true);
  selectInput("Select an image to process:", "imageSelected"); //sets bkgnd in callback
  while(bkimg == null) {delay(100);}
  surface.setSize(bkimg.width, bkimg.height);
}

void imageSelected(File selection) {
  if (selection == null) {
    println("Window was closed or user hit cancel.");
  } else {
    bkimg = loadImage(selection.getAbsolutePath());
  }
}

void draw() {
  image(bkimg, 0, 0);
}