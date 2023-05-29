
class RefreshTokenResponse{
  String accessCode;
  String refreshToken;
  String accessExpiresAt;
  String refreshExpiresAt;

  RefreshTokenResponse({required this.accessCode,required this.refreshToken,required this.accessExpiresAt,required this.refreshExpiresAt});

  RefreshTokenResponse.fromJson(Map<String,dynamic> json):
        accessCode=json["access"],
        refreshToken=json["refresh"],
        accessExpiresAt=json["access_expires_at"],
        refreshExpiresAt=json["refresh_expires_at"];

  toJson() => {
    "access":accessCode,
    "refresh":refreshToken,
    "access_expires_at":accessExpiresAt,
    "refresh_expires_at":refreshExpiresAt
  };
}