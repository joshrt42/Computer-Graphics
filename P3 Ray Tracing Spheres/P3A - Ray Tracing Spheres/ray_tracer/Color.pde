

public class Color {

  public float r;
  public float g;
  public float b;
  
  public Color(float r, float g, float b) {
    this.r = r;
    this.g = g;
    this.b = b;
  }
  
  public Color(float n) {
    this(n, n, n);
  }
  
  public Color() {
    this(0);
  }
  
  public float getR() {
    return this.r;
  }
  
  public float getG() {
    return this.g;
  }
  
  public float getB() {
    return this.b;
  }
  
  public void setR(float r) {
    this.r = r;
  }
  
  public void setG(float g) {
    this.g = g;
  }
  
  public void setB(float b) {
    this.b = b;
  }
  
  public Color addColor(Color c) {
    float dr = this.r + c.r;
    float dg = this.g + c.g;
    float db = this.b + c.b;
    return new Color(dr, dg, db);
  }
  
  public Color divide(int num) {
    float dr = this.r / num;
    float dg = this.g / num;
    float db = this.b / num;
    return new Color(dr, dg, db);
  }
  
  public String toString() {
    String s = "Color red:" + this.r +
                  "\t green:" + this.g +
                  "\t blue:" + this.b + "\n";
    return s;
  }
}
