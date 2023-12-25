import 'package:mobile/constants/network_constants.dart';
import 'package:mobile/data/models/dto/empty_response.dart';
import 'package:mobile/data/models/dto/game/multiple_game_dto_response.dart';
import 'package:mobile/data/models/dto/report/multiple_reports_dto.dart';
import 'package:mobile/data/models/game_model.dart';
import 'package:mobile/data/models/report_model.dart';
import 'package:mobile/data/models/service_response.dart';
import 'package:mobile/data/services/base_service.dart';

class AdminService {
  static const String serverUrl = NetworkConstants.BASE_LOCAL_URL;

  final BaseNetworkService service = BaseNetworkService();

  static List<Game> gameList = [
      Game(
        gameId: 1,
        description:
            "The Witcher 3: Wild Hunt, CD Projekt RED tarafından geliştirilen ve yayımlanan aksiyon rol yapma oyunudur. The Witcher serisinin üçüncü oyunu olan yapım, The Witcher 2: Assassins of Kings'in devamı niteliğindedir. Oyun, 19 Mayıs 2015'te Microsoft Windows, PlayStation 4 ve Xbox One için piyasaya sürülmüştür. Nintendo Switch sürümü 15 Ekim 2019'da yayımlanmıştır. Oyun, 2015 yılında 250'den fazla yılın oyun ödülünü kazanmıştır.",
        title: "Witcher 3",
        gamePicture:
            "https://image.api.playstation.com/vulcan/ap/rnd/202211/0711/kh4MUIuMmHlktOHar3lVl6rY.png",
        genres: ["Adventure, Role-playing(RPG)"],
        developers: "CD Projekt RED",
        releaseYear: 2015,
        platforms:
            [" Xbox One, PlayStation 4, PlayStation 5, PC (Microsoft Windows), Nintendo Switch, Xbox Series X|S"],
        playerNumber: "Single Player",
        universe: "Fantasy",
        mechanics: "Third-person",
      ),
      Game(
        gameId: 2,
        description:
            "League of Legends (kısaca LoL), Riot Games tarafından geliştirilen ve yayımlanan video oyunu. Microsoft Windows ve macOS işletim sistemlerinde çalışan oyun, tür olarak MOBA (Çok Oyunculu Çevrimiçi Savaş Arenası) olarak adlandırılmaktadır. 27 Ekim 2009'da piyasaya sürülen oyun, 2012 yılında en çok oynanan oyun unvanını aldı. 2014 yılında 67 milyon, 2016 yılında 100 milyon oyuncuya ulaştı. 2020 yılında 115 milyon oyuncuya ulaştı.",
        title: "League of Legends",
        gamePicture:
            "https://cdn.ntvspor.net/047bed7cbad44a3dae8bdd7b643ab253.jpg?crop=158,0,782,624&w=800&h=800&mode=crop",
        genres: ["MOBA", "Role-playing(RPG)", "Strategy"],
        developers: "Riot Games",
        releaseYear: 2009,
      ),
      Game(
        gameId: 3,
        description:
            "Call of Duty: WWII, Sledgehammer Games tarafından geliştirilen ve Activision tarafından yayımlanan birinci şahıs nişancı türündeki video oyunudur. Oyun, Call of Duty serisinin 14. oyunu olup 3 Kasım 2017 tarihinde Microsoft Windows, PlayStation 4 ve Xbox One için piyasaya sürüldü.",
        title: "Call of Duty: WWII",
        gamePicture:
            "https://upload.wikimedia.org/wikipedia/tr/8/85/Call_of_Duty_WIII_Kapak_Resmi.jpg",
        genres: ["Shooter"],
        developers: "Sledgehammer Games",
        releaseYear: 2017,
      ),
  ];

  Future<List<Game>> getPendingGames() async {
    if (NetworkConstants.useMockAdminData) {
      return getGameDataList();
    }

    ServiceResponse<MultipleGameAsDTO> response =
        await service.sendRequestSafe<EmptyResponse, MultipleGameAsDTO>(
      "/admin/pendingGames",
      null,
      MultipleGameAsDTO(),
      'GET',
    );

    if (response.success) {
      List<Game> games = response.responseConverted!.games!.map((e) => e.game!).toList();
      return games;
    } else {
      throw Exception('Failed to load games');
    }
  }

  Future<List<Game>> getEditedGames() async {
    if (NetworkConstants.useMockAdminData) {
      return getGameDataList();
    }

    ServiceResponse<MultipleGameAsDTO> response =
        await service.sendRequestSafe<EmptyResponse, MultipleGameAsDTO>(
      "/admin/editedGames",
      null,
      MultipleGameAsDTO(),
      'GET',
    );

    if (response.success) {
      List<Game> games = response.responseConverted!.games!.map((e) => e.game!).toList();
      return games;
    } else {
      throw Exception('Failed to load games');
    }
  }



  static List<Game> getGameDataList() {
    return gameList;
  }

  Future<bool> approveGame(int gameid) async {
    final response =
        await service.sendRequestSafe<EmptyResponse, EmptyResponse>(
      "/admin/approveGame/$gameid",
      null,
      EmptyResponse(),
      'PUT',
    );
    if (response.success) {
      return true;
    } else {
      throw Exception('Failed to approve game');
    }
  }

  Future<bool> rejectGame(int gameid) async {
    final response =
        await service.sendRequestSafe<EmptyResponse, EmptyResponse>(
      "/admin/rejectGame/$gameid",
      null,
      EmptyResponse(),
      'PUT',
    );
    if (response.success) {
      return true;
    } else {
      throw Exception('Failed to reject game');
    }
  }

  Future<List<Report>> getPostReports() async {

    ServiceResponse<MultipleReportDTO> response =
        await service.sendRequestSafe<EmptyResponse, MultipleReportDTO>(
      "/admin/all-post-reports",
      null,
      MultipleReportDTO(),
      'GET',
    );

    if (response.success) {
      List<Report> reports = response.responseConverted!.reports!.map((e) => e.report!).toList();
      return reports;
    } else {
      throw Exception('Failed to load post reports');
    }
  }

  Future<List<Report>> getGameReports() async {

    ServiceResponse<MultipleReportDTO> response =
        await service.sendRequestSafe<EmptyResponse, MultipleReportDTO>(
      "/admin/reportedGames",
      null,
      MultipleReportDTO(),
      'GET',
    );

    if (response.success) {
      List<Report> reports = response.responseConverted!.reports!.map((e) => e.report!).toList();
      return reports;
    } else {
      throw Exception('Failed to load game reports');
    }
  }

  Future<List<Report>> getLFGReports() async {

    ServiceResponse<MultipleReportDTO> response =
        await service.sendRequestSafe<EmptyResponse, MultipleReportDTO>(
      "/admin/reportedLFGs",
      null,
      MultipleReportDTO(),
      'GET',
    );

    if (response.success) {
      List<Report> reports = response.responseConverted!.reports!.map((e) => e.report!).toList();
      return reports;
    } else {
      throw Exception('Failed to load lfg reports');
    }
  }

  Future<List<Report>> getCommentReports() async {

    ServiceResponse<MultipleReportDTO> response =
        await service.sendRequestSafe<EmptyResponse, MultipleReportDTO>(
      "/admin/reportedLFGs",
      null,
      MultipleReportDTO(),
      'GET',
    );

    if (response.success) {
      List<Report> reports = response.responseConverted!.reports!.map((e) => e.report!).toList();
      return reports;
    } else {
      throw Exception('Failed to load comment reports');
    }
  }

  Future<bool> deletePost(int postid) async {
    final response =
        await service.sendRequestSafe<EmptyResponse, EmptyResponse>(
      "/admin/delete/post/$postid",
      null,
      EmptyResponse(),
      'PUT',
    );
    if (response.success) {
      return true;
    } else {
      throw Exception('Failed to delete post');
    }
  }

  Future<bool> deleteGame(int gameid) async {
    final response =
        await service.sendRequestSafe<EmptyResponse, EmptyResponse>(
      "/admin/delete/game/$gameid",
      null,
      EmptyResponse(),
      'PUT',
    );
    if (response.success) {
      return true;
    } else {
      throw Exception('Failed to delete game');
    }
  }

  Future<bool> cancelPost(int postid) async {
    final response =
        await service.sendRequestSafe<EmptyResponse, EmptyResponse>(
      "/admin/cancel/post/$postid",
      null,
      EmptyResponse(),
      'PUT',
    );
    if (response.success) {
      return true;
    } else {
      throw Exception('Failed to cancel post');
    }
  }

  Future<bool> cancelGame(int gameid) async {
    final response =
        await service.sendRequestSafe<EmptyResponse, EmptyResponse>(
      "/admin/cancel/game/$gameid",
      null,
      EmptyResponse(),
      'PUT',
    );
    if (response.success) {
      return true;
    } else {
      throw Exception('Failed to cancel game');
    }
  }

  Future<bool> banUserPost(int postid) async {
    final response =
        await service.sendRequestSafe<EmptyResponse, EmptyResponse>(
      "/admin/banUser/post/$postid",
      null,
      EmptyResponse(),
      'PUT',
    );
    if (response.success) {
      return true;
    } else {
      throw Exception('Failed to ban user of post');
    }
  }

  Future<bool> banUserGame(int gameid) async {
    final response =
        await service.sendRequestSafe<EmptyResponse, EmptyResponse>(
      "/admin/banUser/game/$gameid",
      null,
      EmptyResponse(),
      'PUT',
    );
    if (response.success) {
      return true;
    } else {
      throw Exception('Failed to ban user of game');
    }
  }
}