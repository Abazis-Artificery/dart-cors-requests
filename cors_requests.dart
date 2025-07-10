import 'dart:convert';
import 'package:http/http.dart' as http;

class CorsRequests{
  const CorsRequests(this.proxyServer);
  static const String headerField = "Target-Url";
  final Uri proxyServer;
  Future<http.Response> get(Uri url, {Map<String, String>? headers}){
    if(headers == null){
      headers = {headerField:url.toString()};
    }
    else{
      headers[headerField]=url.toString();
    }
    return(http.get(proxyServer, headers:headers));
  }
  Future<http.Response> post(Uri url, {Map<String, String>? headers, Object? body, Encoding? encoding,}){
    if(headers == null){
      headers = {headerField:url.toString()};
    }
    else{
      headers[headerField]=url.toString();
    }
    return(http.post(proxyServer, headers:headers, body:body, encoding:encoding));
  }
  Future<http.Response> put(Uri url, {Map<String, String>? headers,Object? body,Encoding? encoding,}){
    if(headers == null){
      headers = {headerField:url.toString()};
    }
    else{
      headers[headerField]=url.toString();
    }
    return(http.put(proxyServer, headers:headers, body:body, encoding:encoding));
  }
  Future<http.Response> delete(Uri url, {Map<String, String>? headers,Object? body,Encoding? encoding,}){
    if(headers == null){
      headers = {headerField:url.toString()};
    }
    else{
      headers[headerField]=url.toString();
    }
    return(http.delete(proxyServer, headers:headers, body:body, encoding:encoding));
  }
}