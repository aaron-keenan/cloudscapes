class Sky {
  GradientHybrid gradient;
  
  Sky() {
    gradient = new GradientHybrid(width, height);
    gradient.addGradient(new GradientLinear(width, height), 0.92);
    GradientNoise noise = new GradientNoise(width, height);
    noise.setGradientNoiseDetails(0.006, 0.009, 12, 0.5);
    gradient.addGradient(noise, 0.08);
    gradient.updatePixels();
  }
  
  void display() {
    gradient.display();
  }
}
