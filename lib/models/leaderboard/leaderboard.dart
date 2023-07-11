import 'package:json_annotation/json_annotation.dart';

part 'leaderboard.g.dart';

@JsonSerializable()
class Leaderboard {
    Leaderboard({
      required this.docid,
      required this.userid,
      required this.imageUrl,
      required this.points,
      required this.username,
    });

    String docid;
    String imageUrl;
    int points;  
    String username; 
    String userid; 


    factory Leaderboard.fromJson(Map<String, dynamic> json) => _$LeaderboardFromJson(json);
    Map<String, dynamic> toJson() => _$LeaderboardToJson(this);
}

