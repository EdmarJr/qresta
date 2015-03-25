

part of qresta.base;



class FrontController {
  void manterRequisicao(HttpRequest request) {
    request.response.write('Hello, Welcome to Dart');
    request.response.close();
  }
}