public class Material {
  
  public Color diffuse;
  public Color ambient;
  public Color specular;
  public float p;
  public float kRefl;
  
  public Material(Color diffuse, Color ambient, Color specular, float p, float kRefl) {
    this.diffuse = diffuse;
    this.ambient = ambient;
    this.specular = specular;
    this.p = p;
    this.kRefl = kRefl;
  }
  
  public Material() {
    this.diffuse = new Color();
    this.ambient = new Color();
    this.specular = new Color();
    this.p = 0.0;
    this.kRefl = 0.0;
  }
  
  public Color getDiffuse() {
    return this.diffuse;
  }
  
  public Color getAmbient() {
    return this.ambient;
  }
  
  public Color getSpecular() {
    return this.specular;
  }
  
  public float getP() {
    return this.p;
  }
  
  public float getKRefl() {
    return this.kRefl;
  }
  
  public void setDiffuse(Color diffuse) {
    this.diffuse = diffuse;
  }
  
  public void setAmbient(Color ambient) {
    this.ambient = ambient;
  }
  
  public void setSpecular(Color specular) {
    this.specular = specular;
  }
  
  public void setP(float p) {
    this.p = p;
  }
  
  public void setKRefl(float kRefl) {
    this.kRefl = kRefl;
  }
  
  public String toString() {
    String s = "Material Diffuse: " + this.diffuse.toString() +
                     "\t Ambient: " + this.ambient.toString() +
                    "\t Specular: " + this.specular.toString() +
           "\t Specular Exponent: " + this.p +
              "\t Reflectiveness: " + this.kRefl + "\n";
    return s;
  }
}
