import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class CorsRequestData{
  const CorsRequestData({
    required this.method,
    required this.url,
    this.headers,
    this.body
  });
  final String method;
  final Uri url;
  final Map<String,String>? headers;
  final Uint8List? body;
  String generateJsonPayload(){
    Map<String,dynamic> payload= {"method":method, "url":url.toString()};
    if(headers!=null){
      payload['headers']=headers;
    }
    if(body!=null){
      payload['body']=base64Encode(body!);
    }
    return(json.encode(payload));
  }
}

class CorsRequests{
  const CorsRequests(this.proxyServer);
  final Uri proxyServer;
  Future<http.Response> request({
    required String method, 
    required Uri endpoint, 
    Map<String,String>? headers,
    Uint8List? body
    }) async {
      // Pack our actual request into a proxy request, and send it to our proxy server
      http.Response proxyResponse = await http.post(
        proxyServer,
        body:CorsRequestData(
          method: method,
          url: endpoint,
          headers: headers,
          body: body
        ).generateJsonPayload(),
        headers: {"Content-Type": "application/json"}
      );
      // Parse out the desired response, from the data field of our proxy response
      Map responseJson = jsonDecode(proxyResponse.body);
      http.Response response = http.Response(
        String.fromCharCodes(base64Decode(responseJson['data'])),
        responseJson['status'],
        headers: Map.castFrom<dynamic, dynamic, String, String>(responseJson['headers'])
      );
      return(response);
    }


  Future<http.Response> get(Uri url, {Map<String, String>? headers}){
    return(
      request(
        method:'GET',
        endpoint:url, 
        headers:headers
      )
    );
  }
  Future<http.Response> post(Uri url, {Map<String, String>? headers, Uint8List? body, Encoding? encoding,}){
    return(
      request(
        method:'POST',
        endpoint:url, 
        headers:headers,
        body:body
      )
    );
  }
  Future<http.Response> put(Uri url, {Map<String, String>? headers,Uint8List? body,Encoding? encoding,}){
    return(
      request(
        method:'PUT',
        endpoint:url, 
        headers:headers,
        body:body
      )
    );
  }
  Future<http.Response> delete(Uri url, {Map<String, String>? headers, Uint8List? body, Encoding? encoding,}){
    return(
      request(
        method:'DELETE',
        endpoint:url, 
        headers:headers,
        body:body
      )
    );
  }
}