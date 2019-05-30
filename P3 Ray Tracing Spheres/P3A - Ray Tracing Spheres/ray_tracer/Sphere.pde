public class Sphere extends Shape{
  
  public Vector origin;
  public float radius;
  public Material material;
  
  public Sphere(Vector origin, float radius, Material material) {
    this.origin = origin;
    this.radius = radius;
    this.material = material;
  }
  
  public Sphere(Vector origin, float radius) {
    this(origin, radius, new Material());
  }
  
  public Sphere(Vector origin) {
    this(origin, 1.0);
  }
  
  public Sphere(float radius) {
    this(new Vector(), radius);
  }
  
  public Sphere() {
    this(1.0);
  }
  
  public Vector getOrigin() {
    return this.origin;
  }
  
  public float getRadius() {
    return this.radius;
  }
  
  public Material getMaterial() {
    return this.material;
  }
  
  public void setOrigin(Vector origin) {
    this.origin = origin;
  }
  
  public void setRadius(float radius) {
    this.radius = radius;
  }
  
  public void setMaterial(Material material) {
    this.material = material;
  }
  
  public float intersect(Ray ray) {
    float a = ray.getDirection().dotProduct(ray.getDirection());
    float b = 2*(ray.getOrigin().subtractVector(this.origin).dotProduct(ray.getDirection()));
    float c = ray.getOrigin().subtractVector(this.origin).dotProduct(ray.getOrigin().subtractVector(this.origin)) - this.radius*this.radius;
    float d = (b*b) - (4*a*c);
    if (d >= 0.0) {
      //println("A: " + a + "   \t B: " + b + "\t C: " + c + "\t Discriminant: " + d);
      float t = min((-b + sqrt(d))/(2*a),(-b - sqrt(d))/(2*a));
      if (t>0.0) {
        //println("t is: " + t);
        return t;
      } else {
        return 0.0;
      }
    } else {
      return 0.0;
    }
  }
  
  public String toString() {
    String s = "Sphere origin: " + this.origin.toString() +
                      "radius: " + this.radius +
                    "material: " + this.material.toString() + "\n";
    return s;
  }
}
