class GradientHybrid extends Gradient {
  ArrayList<Gradient> gradients = new ArrayList<Gradient>();
  
  GradientHybrid(int _width, int _height) {
    super(_width, _height);
  }
  
  void addGradient(Gradient gradient, float weight) {
    gradient.setWeight(weight);
    gradients.add(gradient);
  }
  
  float getGradientProgress(int i) {
    float progress = 0.0;
    if (gradients == null) {
      return progress; 
    }
    for (Gradient gradient : gradients) {
      progress += gradient.getGradientProgress(i) * gradient.weight;
    }
    return progress;
  }
}
