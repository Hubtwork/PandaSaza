import UIKit

func calcDateDiff(baseDateTimestamp: Double) -> String {
    let based_date: Date = Date(timeIntervalSince1970: floor(baseDateTimestamp))
    let now_date: Date = Date()
    let dateDiff = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: based_date, to: now_date)
    if dateDiff.month! > 1 { return String(format: "%d%@", (dateDiff.month!), "달 전") }
    else if dateDiff.day! > 7 { return String(format: "%d%@", (dateDiff.day!/7), "주 전") }
    else if dateDiff.day! > 0 { return String(format: "%d%@", dateDiff.day!, "일 전") }
    else if dateDiff.hour! > 0 { return String(format: "%d%@", dateDiff.hour!, "시간 전") }
    else if dateDiff.minute! > 0 { return String(format: "%d%@", dateDiff.minute!, "분 전") }
    else { return String(format: "%d%@", dateDiff.second!, "초 전") }
}

print(calcDateDiff(baseDateTimestamp: 1610029326))
