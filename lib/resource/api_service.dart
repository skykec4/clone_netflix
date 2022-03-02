import 'package:dio/dio.dart' hide Headers;
import 'package:netflix_clone/models/movie/now_palying_model.dart';
import 'package:netflix_clone/util/constant.dart';

// import 'package:dio_flutter_transformer/dio_flutter_transformer.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: Constant.apiBaseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  static ApiService create() {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
//     dio.transformer = FlutterTransformer();
    dio.options = BaseOptions(receiveTimeout: 30000, connectTimeout: 30000);
    return ApiService(dio);
  }

  //현재 상영작
  @GET("movie/now_playing")
  @Headers(<String, dynamic>{"content-type": "application/json"})
  @FormUrlEncoded()
  Future<NowPlayingModel> getNowPlaying(
      @Query("api_key") String apiKey,
      @Query("language") String language,
      @Query("page") String page,
      );
}
