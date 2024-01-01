// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userr.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Userr _$UserrFromJson(Map<String, dynamic> json) => Userr(
      id: json['id'] as String,
      imageUrl: json['imageUrl'] as String,
      points: json['points'] as int,
      public: json['public'] as bool,
      rank: json['rank'] as int,
      rfidtag: json['rfidtag'] as String,
      username: json['username'] as String,
      name: json['name'] as String,
      rfidpass: json['rfidpass'] as int,
    );

Map<String, dynamic> _$UserrToJson(Userr instance) => <String, dynamic>{
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'points': instance.points,
      'public': instance.public,
      'rank': instance.rank,
      'rfidtag': instance.rfidtag,
      'username': instance.username,
      'name': instance.name,
      'rfidpass': instance.rfidpass,
    };
