// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fire_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FireUser _$FireUserFromJson(Map<String, dynamic> json) => FireUser(
      displayName: json['displayName'] as String?,
      email: json['email'] as String?,
      isAnonymous: json['isAnonymous'] as bool?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      phoneNumber: json['phoneNumber'] as String?,
      photoURL: json['photoURL'] as String?,
      providerData: json['providerData'] as List<dynamic>?,
      refreshToken: json['refreshToken'] as String?,
      tenantId: json['tenantId'] as String?,
      uid: json['uid'] as String?,
    )..emailVerified = json['emailVerified'] as bool?;

Map<String, dynamic> _$FireUserToJson(FireUser instance) => <String, dynamic>{
      'displayName': instance.displayName,
      'email': instance.email,
      'emailVerified': instance.emailVerified,
      'isAnonymous': instance.isAnonymous,
      'metadata': instance.metadata,
      'phoneNumber': instance.phoneNumber,
      'photoURL': instance.photoURL,
      'providerData': instance.providerData,
      'refreshToken': instance.refreshToken,
      'tenantId': instance.tenantId,
      'uid': instance.uid,
    };
