Sky sky;
Cloudscape[] clouds;
int cloudsTotal = 1;
Palette palette;
CurrentDate currentDate = new CurrentDate();

void setup() {
  size(1080, 1080);
  colorMode(HSB, 360, 100, 100, 100);
  smooth(4);
  noStroke();
  palette = new Palette();
  sky = new Sky();
  // clouds = new Cirrocumulus();
  clouds = new Cumulus[cloudsTotal];
  for (int i = 0; i < cloudsTotal; i++) {
    clouds[i] = new Cumulus();
  }
}

void draw() {
  sky.display();
  for (int i = 0; i < cloudsTotal; i++) {
    clouds[i].display();
  }
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
  
