// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userr.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Userr _$UserrFromJson(Map<String, dynamic> json) => Userr(
      id: json['id'] as String,
      imageUrl: json['imageUrl'] as String,
      points: json['points'] as int,
      rank: json['rank'] as String,
      rfidtag: json['rfidtag'] as String,
      username: json['username'] as String,
    );

Map<String, dynamic> _$UserrToJson(Userr instance) => <String, dynamic>{
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'points': instance.points,
      'rank': instance.rank,
      'rfidtag': instance.rfidtag,
      'username': instance.username,
    };
