Cloudscape clouds;
Sky sky;
// sunrise / cyan / sahara / twilight / random
ColourProfile colourProfile = new ColourProfile("evening");
CurrentDate currentDate = new CurrentDate();

void setup() {
  size(1080, 1080);
  colorMode(HSB, 360, 100, 100, 100);
  smooth(4);
  noStroke();
  sky = new Sky();
  // clouds = new Cirrocumulus();
  clouds = new Cumulus();
}

void draw() {
  sky.display();
  clouds.display();
}

void mouseClicked() {
  save("output/cloudscapes-"+currentDate.toString()+".png");
}

int getPixelX(int i) {
  return i % width;
}

int getPixelY(int i) {
  return floor(i / width);
}

PVector getPixelVector(int i) {
  return new PVector(getPixelX(i), getPixelY(i));
}
  
