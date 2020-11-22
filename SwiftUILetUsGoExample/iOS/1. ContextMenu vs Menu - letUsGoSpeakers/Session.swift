//
//  Session.swift
//  SwiftUILetUsGoExample (iOS)
//
//  Created by Fourenn on 2020/11/21.
//

import SwiftUI

struct Session: Identifiable {
  let id: Int
  let name: String
  let title: String
  let comment: String
  let time: String
  var isWatched: Bool = false
}

let letUsGo2020FallSessions: [Session] = [
  Session(id: 1, name: "유현식", title: "GoogleSheet로 .strings 파일 관리하기 (문구 수정 떠넘기기)", comment: "마스크 벗고 싶어요...", time: "13:10 ~ 13:40"),
  Session(id: 2, name: "안솔찬", title: "위젯과 앱클립에 대해서 만들면서 발생하는 다양한 상황", comment: "왜 벌써 11월이죠..?", time: "13:40 ~ 14:10"),
  Session(id: 3, name: "안정민", title: "DI container를 이용하여 레거시와 모듈화를 동시에 잡기", comment: "은행원 좋아요", time: "14:10 ~ 14:40"),
  Session(id: 4, name: "이현호", title: "빌드 버튼이 눌린다음에 무슨일이 일어나는 걸까?", comment: "노래하는 iOS개발자 입니다", time: "14:40 ~ 15:10"),
  Session(id: 5, name: "Fourenn", title: "Deprecated API로 보는 SwiftUI", comment: "SwiftUI 오픈 베타 종료!", time: "15:10 ~ 15:40", isWatched: true),
  Session(id: 6, name: "도미닉", title: "열거형!", comment: "안녕하세요 도미닉입니다", time: "15:40 ~ 16:00"),
  Session(id: 7, name: "곰튀김", title: "코드 삼분지계: 관심사에 따른 코드 분리", comment: "리얼리즘 프로그래머", time: "16:00 ~ 16:20")
]
