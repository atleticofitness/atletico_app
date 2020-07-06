import 'package:atletico_app/util/constants.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart'
    show SerializationOptions, DeserializationOptions, CaseStyle;
import 'package:dio/dio.dart';

var dio = Dio(BaseOptions(baseUrl: atleticoURL));
var serializeOption =
    SerializationOptions(indent: '', caseStyle: CaseStyle.Snake);
var deserializeOption = DeserializationOptions(caseStyle: CaseStyle.Camel);
