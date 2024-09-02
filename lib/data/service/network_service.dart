import 'package:SonicScape/data/models/core_models/data_wrapper.dart';
import 'package:SonicScape/data/models/network_service_models/link_data.dart';
import 'package:SonicScape/data/models/network_service_models/machine_request.dart';
import 'package:SonicScape/data/models/network_service_models/analysis_data.dart';
import 'package:SonicScape/data/models/network_service_models/machine_data.dart';
import 'package:SonicScape/data/models/network_service_models/machine_issues.dart';
import 'package:SonicScape/data/models/network_service_models/reports_data.dart';
import 'package:SonicScape/data/models/network_service_models/update_issue_request.dart';
import 'package:SonicScape/data/models/network_service_models/vibration_temperature_data.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';


part 'network_service.g.dart';

@RestApi(
    baseUrl:
        'https://jpgg7kp57h.execute-api.ap-south-1.amazonaws.com/sonicscape')
abstract class NetworkService {
  factory NetworkService(Dio dio, {String baseUrl}) = _NetworkService;

  @GET("/organisations/{organisationId}/devices")
  Future<DataWrapper<MachineData>> fetchMachines(
      @Path('organisationId') String organisationId);

  @POST("/organisations/{organisationId}/devices")
  Future<DataWrapper<dynamic>> registerMachine(
      @Path('organisationId') String organisationId,
      @Body() MachineRequest machineRequest);

  @GET("/devices/{deviceId}/vibration/raw")
  Future<DataWrapper<VibrationTemperatureData>> fetchVibrationData(
      @Path() String deviceId,
      @Query('startDatetime') int startDateTime,
      @Query('endDatetime') int endDateTime);

  @GET("/devices/{deviceId}/vibration/analysis")
  Future<DataWrapper<AnalysisData>> fetchVibrationAnalysis(
      @Path() String deviceId,
      @Query('startDatetime') int startDateTime,
      @Query('endDatetime') int endDateTime);

  @GET("/devices/{deviceId}/vibration/csv")
  Future<DataWrapper<LinkData>> fetchVibrationCSVLink(
      @Path() String deviceId,
      @Query('startDatetime') int startDateTime,
      @Query('endDatetime') int endDateTime);

  @GET("/devices/{deviceId}/audio/analysis/image")
  Future<DataWrapper<LinkData>> fetchAudioImageLink(
      @Path() String deviceId,
      @Query('startDatetime') int startDateTime,
      @Query('endDatetime') int endDateTime);

  @GET("/devices/{deviceId}/audio/analysis")
  Future<DataWrapper<AnalysisData>> fetchAudioAnalysis(
      @Path() String deviceId,
      @Query('startDatetime') int startDateTime,
      @Query('endDatetime') int endDateTime);

  @GET("/devices/{deviceId}/vibtoaudio/analysis")
  Future<DataWrapper<AnalysisData>> fetchVibrationToAudioAnalysis(
      @Path() String deviceId,
      @Query('startDatetime') int startDateTime,
      @Query('endDatetime') int endDateTime);

  @GET("/devices/{deviceId}/issues/all")
  Future<DataWrapper<MachineIssues>> fetchIssues(
      @Path() String deviceId,
      @Query('startDatetime') int startDateTime,
      @Query('endDatetime') int endDateTime);

  @POST("/devices/issueId/{issueId}/issues/machineMasterResponse")
  Future<DataWrapper<void>> updateIssue(
      @Path() String issueId, @Body() UpdateIssueRequest request);

  @GET("/machines/{machineId}/report")
  Future<DataWrapper<ReportsData>> fetchReports(
      @Path() String machineId,
      @Query('startDatetime') int startDateTime,
      @Query('endDatetime') int endDateTime);
}
