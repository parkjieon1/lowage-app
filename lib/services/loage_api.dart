import 'dart:async';

class LoAgeApi {
  LoAgeApi._();
  static final LoAgeApi instance = LoAgeApi._();

  // 1) 로그인 -------------------------------------------------
  Future<String> login({
    required String email,
    required String password,
  }) async {
    // TODO: 실제 API 연동
    await Future.delayed(const Duration(milliseconds: 800));
    if (email.isEmpty || password.isEmpty) {
      throw Exception('이메일/비밀번호를 입력하세요.');
    }
    // 더미 세션 토큰
    return 'dummy_session_token_${DateTime.now().millisecondsSinceEpoch}';
  }

  // 2) 회원가입 ----------------------------------------------
  Future<void> signup({
    required String nickname,
    required String email,
    required String password,
  }) async {
    // TODO: 실제 API 연동
    await Future.delayed(const Duration(milliseconds: 800));
    // 에러 없으면 그냥 통과
  }

  // 3) 신체나이 계산 -----------------------------------------
  Future<Map<String, dynamic>> computeLoAge({
    required String gender,
    required int sitUps,
    required double flexibility,
    required double jumpPower,
    required int recoveryHr,
  }) async {
    // TODO: 실제 lai_v6_quantile_engine.pkl 서비스와 연결
    await Future.delayed(const Duration(milliseconds: 800));

    // 더미 응답 (라벨 / 퍼센타일 / 취약 파트)
    return {
      'lo_age_label': '20대 중반',
      'percentile': 62,
      'weak_point': '유연성',
    };
  }

  // 4) 미션 시설 목록 (지도) ----------------------------------
  Future<List<Map<String, dynamic>>> fetchFacilities({
    required double lat,
    required double lng,
    double radiusKm = 2.0,
  }) async {
    // TODO: 실제 /mission/facilities 연동
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      {
        'id': 1,
        'name': '보라매 공원',
        'mission': '자전거 타기',
        'category': '심폐지구력',
        'lat': lat,
        'lng': lng,
      },
      {
        'id': 2,
        'name': '동네 공원 운동장',
        'mission': '계단 오르기',
        'category': '근지구력',
        'lat': lat + 0.001,
        'lng': lng + 0.001,
      },
    ];
  }

  // 5) 미션 완료 ----------------------------------------------
  Future<void> completeMission({
    required int missionId,
    required String reviewText,
  }) async {
    // TODO: 실제 /mission/complete 연동
    await Future.delayed(const Duration(milliseconds: 500));
  }

  // 6) 대시보드 요약 ------------------------------------------
  Future<Map<String, dynamic>> fetchDashboard() async {
    // TODO: 실제 /user/dashboard 연동
    await Future.delayed(const Duration(milliseconds: 500));
    return {
      'nickname': '킹왕짱',
      'lo_age_label': '20대 중반',
      'missions_done': 12,
      'wins': 3,
      'losses': 1,
    };
  }

  // 7) 또래 배틀 매칭/정보 -----------------------------------
  Future<Map<String, dynamic>> fetchCrewBattle() async {
    // TODO: /crew/match, /crew/opponent 연동
    await Future.delayed(const Duration(milliseconds: 500));
    return {
      'myCrew': '20대 중반 크루',
      'opponentCrew': '20대 중반 로우에이지 크루',
      'myScore': 5,
      'opponentScore': 4,
      'status': '이번 주 남은 시간 3일',
    };
  }
}
