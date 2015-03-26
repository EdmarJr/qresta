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
          Future<InstanceMirror> futureAnnotationResource = getInstanceMirrorOfAnnotation(cm, Resource);
          futureAnnotationResource.then((annotationResource) {
            Future<ResourceMap> futureResourceMap = createNewResourceMap(cm, annotationResource.reflectee.adress);
            futureResourceMap.then((resourceMap) {
              print(resourceMap.adress);
              print(resourceMap.instanceMirror);
            });
          });
        }
      });
    });
  }

  void addResourceMap(ResourceMap resourceMap) {
    this.resources.add(resourceMap);
  }

  Future<InstanceMirror> getInstanceMirrorOfAnnotation(DeclarationMirror dm, Type annotation) {
    Completer<InstanceMirror> completer = new Completer();
    Future.forEach(dm.metadata, (md) {
      InstanceMirror metadata = md as InstanceMirror;
      if (metadata.type == reflectClass(annotation)) {
        completer.complete(metadata);
      }
    });
    return completer.future;
  }

  Future<ResourceMap> createNewResourceMap(ClassMirror classMirror, String adressResource) {
    Completer completer = new Completer();
    ResourceMap resourceMap = new ResourceMap(classMirror.newInstance(new Symbol(''), []), classMirror, adressResource, new List<HttpMethod>());

    Future.forEach(classMirror.instanceMembers.values, (methodMirror) {
      getInstanceMirrorOfAnnotation(methodMirror, Get).then((instanceMirror) {
        resourceMap.methodsHttp.add(new HttpMethod(Get, instanceMirror.reflectee.adress, methodMirror));
      });
      getInstanceMirrorOfAnnotation(methodMirror, Post).then((instanceMirror) {
        resourceMap.methodsHttp.add(new HttpMethod(Post, instanceMirror.reflectee.adress, methodMirror));
      });
    }).whenComplete(() {
      completer.complete(resourceMap);
    });
    return completer.future;
  }
}

class HttpMethod {
  Type type;
  String adress;
  MethodMirror methodMirror;
  HttpMethod(this.type, this.adress, this.methodMirror);
}

class ResourceMap {
  InstanceMirror instanceMirror;
  ClassMirror classMirror;
  String adress;
  List<HttpMethod> methodsHttp;
  ResourceMap(this.instanceMirror, this.classMirror, this.adress, this.methodsHttp);
}
