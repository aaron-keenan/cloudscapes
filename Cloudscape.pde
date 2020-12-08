class Cloudscape {
  PImage image;
  
  void setAttributes() {}
  
  void makeImage() {
    image = createImage(width, height, ARGB);
    for (int i = 0; i < image.pixels.length; i++) {
      image.pixels[i] = color(0, 0, 100, getAlpha(i));
    }
  }
  
  void display() {
    image(image, 0, 0);
  }
  
  float getAlpha(int i) {
    return 0.0;
  }
}
