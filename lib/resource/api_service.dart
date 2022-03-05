import 'package:dio/dio.dart' hide Headers;
import 'package:netflix_clone/models/movie/details_model.dart';
import 'package:netflix_clone/models/movie/now_palying_model.dart';
import 'package:netflix_clone/models/movie/videos_model.dart';
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

  //now playing
  @GET("movie/now_playing")
  @Headers(<String, dynamic>{"content-type": "application/json"})
  @FormUrlEncoded()
  Future<NowPlayingModel> getNowPlaying(
      @Query("api_key") String apiKey,
      @Query("language") String language,
      @Query("page") String page,
      );

  //popular
  @GET("movie/popular")
  @Headers(<String, dynamic>{"content-type": "application/json"})
  @FormUrlEncoded()
  Future<NowPlayingModel> getPopular(
      @Query("api_key") String apiKey,
      @Query("language") String language,
      @Query("page") String page,
      );

  //top_rated
  @GET("movie/top_rated")
  @Headers(<String, dynamic>{"content-type": "application/json"})
  @FormUrlEncoded()
  Future<NowPlayingModel> getTopRated(
      @Query("api_key") String apiKey,
      @Query("language") String language,
      @Query("page") String page,
      );

  //upcoming
  @GET("movie/upcoming")
  @Headers(<String, dynamic>{"content-type": "application/json"})
  @FormUrlEncoded()
  Future<NowPlayingModel> getUpcoming(
      @Query("api_key") String apiKey,
      @Query("language") String language,
      @Query("page") String page,
      );

  //get details
  @GET("movie/{movieId}")
  @Headers(<String, dynamic>{"content-type": "application/json"})
  @FormUrlEncoded()
  Future<DetailsModel> getDetails(
      @Path("movieId") String movieId,
      @Query("api_key") String apiKey,
      @Query("language") String language,
      );

  //get videos
  @GET("movie/{movieId}/videos")
  @Headers(<String, dynamic>{"content-type": "application/json"})
  @FormUrlEncoded()
  Future<VideosModel> getVideos(
      @Path("movieId") String movieId,
      @Query("api_key") String apiKey,
      @Query("language") String language,
      );

  //get similar
  @GET("movie/{movieId}/similar")
  @Headers(<String, dynamic>{"content-type": "application/json"})
  @FormUrlEncoded()
  Future<NowPlayingModel> getSimilar(
      @Path("movieId") String movieId,
      @Query("api_key") String apiKey,
      @Query("language") String language,
      @Query("page") String page,
      );


}
