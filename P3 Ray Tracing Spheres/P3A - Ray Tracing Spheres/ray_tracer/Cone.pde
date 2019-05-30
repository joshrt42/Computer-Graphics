public class Cone extends Shape{

  public Vector origin;
  public float h;
  public float r;
  
  public Cone(Vector origin, float h, float r) {
    this.origin = origin;
    this.h = h;
    this.r = r;
  }
  
  public Cone(Vector origin) {
    this(origin, 1.0, 1.0);
  }
  
  public Cone(float h, float r) {
    this(new Vector(), h, r);
  }
  
  public Cone() {
    this(new Vector());
  }
  
  public Vector getOrigin() {
    return this.origin;
  }
  
  public float getHeight() {
    return this.h;
  }
  
  public float getRadius() {
    return this.r;
  }
  
  public void setOrigin(Vector origin) {
    this.origin = origin;
  }
  
  public void setHeight(float h) {
    this.h = h;
  }
  
  public void setRadius(float r) {
    this.r = r;
  }
  
  public float intersect(Ray ray) {
    return 0.0;
  }
  
  public String toString() {
    String s = "Cone origin: " + this.origin.toString() +
                 "\t height: " + this.h +
                 "\t radius: " + this.r + "\n";
    return s;
  }
}
