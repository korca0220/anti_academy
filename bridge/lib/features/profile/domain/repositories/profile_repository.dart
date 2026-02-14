import '../entities/profile.dart';

abstract interface class ProfileRepository {
  /// User ID로 프로필 정보를 가져옵니다.
  /// 프로필이 없으면 null을 반환할 수도 있습니다.
  Future<Profile?> getProfile(String userId);
}
