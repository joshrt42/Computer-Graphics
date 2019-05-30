public class Ray {

  public Vector origin;
  public Vector direction;
  
  public Ray(Vector origin, Vector direction) {
    this.origin = origin;
    this.direction = direction;
  }
  
  public Ray(Vector direction) {
    this(new Vector(0.0, 0.0, 0.0), direction);
  }
  
  public Ray() {
    this(new Vector(1.0, 1.0, 1.0));
  }
  
  public Vector getOrigin() {
    return this.origin;
  }
  
  public Vector getDirection() {
    return this.direction;
  }
  
  public void setOrigin(Vector origin) {
    this.origin = origin;
  }
  
  public void setDirection(Vector direction) {
    this.direction = direction;
  }
  
  public String toString() {
    String s = "Ray Origin: " + this.origin.toString() +
             "\t Direction: " + this.direction.toString() + "\n";
    return s;
  }
}
