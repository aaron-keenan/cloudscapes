class Sky {
  GradientLinear gradient;
  
  Sky() {
    gradient = new GradientLinear(width, height);
    //gradient.setGradientNoiseDetails(0.02, 0.03, 12, 0.5);
    //gradient.updatePixels();
  }
  
  void display() {
    gradient.display();
  }
}
