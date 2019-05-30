public class Vector {
  
  public float x;
  public float y;
  public float z;
  
  public Vector(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;
  }
  
  public Vector(float n) {
    this(n, n, n);
  }
  
  public Vector() {
    this(0.0);
  }
  
  public float getX() {
    return this.x;
  }
  
  public float getY() {
    return this.y;
  }
  
  public float getZ() {
    return this.z;
  }
  
  public void setX(float x) {
    this.x = x;
  }
  
  public void setY(float y) {
    this.y = y;
  }
  
  public void setZ(float z) {
    this.z = z;
  }
  
  public Vector addVector(Vector v) {
    float dx = v.getX() + this.x;
    float dy = v.getY() + this.y;
    float dz = v.getZ() + this.z;
    return new Vector(dx, dy, dz);
  }
  
  public Vector subtractVector(Vector v) {
    float dx = this.x - v.getX();
    float dy = this.y - v.getY();
    float dz = this.z - v.getZ();
    return new Vector(dx, dy, dz);
  }
  
  public Vector scalarMultiply(float n) {
    float dx = n * this.getX();
    float dy = n * this.getY();
    float dz = n * this.getZ();
    return new Vector(dx, dy, dz);
  }
  
  public float dotProduct(Vector v) {
    float dx = v.getX() * this.x;
    float dy = v.getY() * this.y;
    float dz = v.getZ() * this.z;
    float dotProduct = dx+dy+dz;
    return dotProduct;
  }
  
  public float dotProduct(float n) {
    float dx = this.x * n;
    float dy = this.y * n;
    float dz = this.z * n;
    float dotProduct = dx+dy+dz;
    return dotProduct;
  }
  
  public Vector crossProduct(Vector v) {
    float dx = v.getZ()*this.y - v.getY()*this.z;
    float dy = v.getX()*this.z - v.getZ()*this.x;
    float dz = v.getY()*this.x - v.getX()*this.y;
    return new Vector(dx, dy, dz);
  }
  
  public float getMagnitude() {
    float magnitude = sqrt(this.x*this.x + this.y*this.y + this.z*this.z);
    return magnitude;
  }
  
  public Vector getNormal() {
    float magnitude = this.getMagnitude();
    float newX = this.x/magnitude;
    float newY = this.y/magnitude;
    float newZ = this.z/magnitude;
    Vector normal = new Vector(newX, newY, newZ);
    return normal;
  }
  
  public String toString() {
    String s = "Vector x:" + this.x +
                   "\t y:" + this.y +
                   "\t z:" + this.z + "\n";
    return s;
  }
}
