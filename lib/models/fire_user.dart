import 'package:json_annotation/json_annotation.dart';

part 'fire_user.g.dart';

@JsonSerializable()
class FireUser {
    FireUser({
      required this.displayName,
      required this.email,
      required this.isAnonymous,
      required this.metadata,
      required this.phoneNumber,
      required this.photoURL,
      required this.providerData,
      required this.refreshToken,
      required this.tenantId,
      required this.uid,
    });

    String? displayName;
    String? email;
    bool? emailVerified;
    bool? isAnonymous;
    Map<String, dynamic>? metadata;
    String? phoneNumber; 
    String? photoURL; 
    List<dynamic>? providerData; 
    String? refreshToken; 
    String? tenantId;
    String? uid;


    factory FireUser.fromJson(Map<String, dynamic> json) => _$FireUserFromJson(json);
    Map<String, dynamic> toJson() => _$FireUserToJson(this);
}

