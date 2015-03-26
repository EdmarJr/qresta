part of qresta.base;

typedef void ActionIfHasAnnotation(InstanceMirror metadata);
typedef void CallbackCreateResourceMap(ResourceMap resourceMap);

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
          hasAnnotationResource(cm, Resource, (metadata) => createNewResourceMap(cm, metadata.reflectee.adress, addResourceMap));
        }
      });
    });
  }

  void addResourceMap(ResourceMap resourceMap) {
    this.resources.add(resourceMap);
  }

  void hasAnnotationResource(DeclarationMirror dm, Type annotation, ActionIfHasAnnotation callback) {
    dm.metadata.forEach((md) {
      InstanceMirror metadata = md as InstanceMirror;
      if (metadata.type == reflectClass(annotation)) {
        callback(metadata);
      }
      print(resources);
    });
  }

  void createNewResourceMap(ClassMirror classMirror, String adressResource, CallbackCreateResourceMap) {
    classMirror.instanceMembers.forEach((symbol, methodMirror) {

      hasAnnotationResource(methodMirror, Get, (metadata) {

      });

    });
  }
}



class ResourceMap {
  InstanceMirror instanceMirror;
  ClassMirror classMirror;
  String adress;
  List<HttpMethod> methodsHttp;
  ResourceMap(this.instanceMirror, this.classMirror, this.adress, this.methodsHttp);
}

class HttpMethod {
  String name;
  HttpMethod(this.name);}
