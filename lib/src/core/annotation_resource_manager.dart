part of qresta.base;

typedef void ActionIfHasAnnotationResource(String adress);

class AnnotationResourceManager {

  List<ResourceMap> resources = new List<ResourceMap>();

  void initialize() {
    generateResources();
  }
  
  void generateResources() {
    MirrorSystem mirrorSystem = currentMirrorSystem();
    mirrorSystem.libraries.forEach((lk, l) {
      l.declarations.forEach((dk, d) {
        if (d is ClassMirror) {
          ClassMirror cm = d as ClassMirror;
          hasAnnotationResource(cm, (adress) => resources.add(new ResourceMap(cm.newInstance(const Symbol(''), []), cm, adress, "get")));
        }
      });
    });
  }

  void hasAnnotationResource(ClassMirror cm, ActionIfHasAnnotationResource callback) {
    cm.metadata.forEach((md) {
      InstanceMirror metadata = md as InstanceMirror;
      if (metadata.type == reflectClass(Resource)) {
        callback(metadata.reflectee.adress);
      }
      print(resources);
    });
  }
}



class ResourceMap {
  InstanceMirror instanceMirror;
  ClassMirror classMirror;
  String endereco;
  String operacao;
  ResourceMap(this.instanceMirror, this.classMirror, this.endereco, this.operacao);
  String toString() {
    return "$instanceMirror $classMirror $endereco $operacao";
  }
}
