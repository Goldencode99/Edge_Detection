PImage bkimg;

void setup() {
  size(300, 300, P2D);
  surface.setResizable(true);
  selectInput("Select an image to process:", "imageSelected"); //sets bkgnd in callback
  while(bkimg == null) {delay(100);} //wait for user to select an image
  surface.setSize(bkimg.width, bkimg.height);
}

void imageSelected(File selection) {
  if (selection == null) {
    println("Window was closed or user hit cancel.");
    selectInput("Select an image to process:", "imageSelected"); //sets bkgnd in callback
  } else {
    bkimg = loadImage(selection.getAbsolutePath());
  }
}

int[][] getAdjacents(int x, int y) {
  int numAdj = 9;
  if(x==0 && y==0 || x==width-1 && y==0 || x==0 && y==height-1 || x==width-1 && y==height-1) {numAdj-=5;}
  else if(x==0 || y==0) {numAdj-=3;}
  else if(x==width-1 || y==height-1) {numAdj-=3;}
  
  int[][] adj = new int[numAdj][2];
  int n = 0;
  for(int xi = -1; xi <= 1; xi++) {
    for(int yi = -1; yi <= 1; yi++) {
      int adjX = x+xi;
      int adjY = y+yi;
      if(adjX>=0 && adjX<width && adjY>=0 && adjY<height) {
        adj[n][0] = adjX;
        adj[n][1] = adjY;
        n++;
      }
    }
  }
  
  return adj;
}

boolean isDiffColor(color pxlA, color pxlB) {
  return ((abs(red(pxlA)-red(pxlB)) + abs(green(pxlA)-green(pxlB)) + abs(blue(pxlA)-blue(pxlB))) >= 100);
}

void draw() {
  image(bkimg, 0, 0);
  loadPixels();
}