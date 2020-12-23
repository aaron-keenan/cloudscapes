class Sky {
  GradientHybrid gradient;
  
  Sky() {
    gradient = new GradientHybrid(width, height);
    gradient.addGradient(new GradientLinear(width, height));
    gradient.addGradient(new GradientNoise(width, height));
    //gradient.setGradientNoiseDetails(0.02, 0.03, 12, 0.5);
    //gradient.updatePixels();
  }
  
  void display() {
    gradient.display();
  }
}
