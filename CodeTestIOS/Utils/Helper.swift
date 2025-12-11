//
//  Helper.swift
//  CodeTestIOS
//
//  Created by WNPD_MA004 on 11/12/2025.
//

import Foundation
import UIKit

class Helper {
    static let shared = Helper()
    private init() {}

    func splitPhoneString(_ text: String) -> NSAttributedString {
        let pattern = "(Dial)\\s*<font color='(#[0-9A-Fa-f]{6})'>(\\d+)</font>"

        let nsString = text as NSString
           let fullRange = NSRange(location: 0, length: nsString.length)
           let attributedResult = NSMutableAttributedString(string: text)

           do {
               let regex = try NSRegularExpression(pattern: pattern, options: [])
               guard let match = regex.firstMatch(in: text, options: [], range: fullRange) else {
                   // No match → return plain attributed string of original text
                   return attributedResult
               }

               // Extract parts
               let dialRange   = match.range(at: 1)
               let colorRange  = match.range(at: 2)
               let numberRange = match.range(at: 3)

               let dial   = nsString.substring(with: dialRange)   // "Dial"
               let color  = nsString.substring(with: colorRange)  // "#C85204"
               let number = nsString.substring(with: numberRange) // "29986899"

               print("splitPhoneString Dial: \(dial)")
               print("splitPhoneString Color: \(color)")
               print("splitPhoneString Number: \(number)")

               let output = "\(dial) \(number)"
               let result = NSMutableAttributedString(string: output)

               let numberStart = (dial as NSString).length + 1 // +1 for the space
               let numberLength = (number as NSString).length
               let numberAttrRange = NSRange(location: numberStart, length: numberLength)

               let uiColor = UIColor(hex: color)
               result.addAttribute(.foregroundColor, value: uiColor, range: numberAttrRange)
               return result
           } catch {
               print("splitPhoneString Error: \(error)")
               // On error, still return something usable
               return attributedResult
           }
    }

    func URLhandler(_ myURL: String) {
        if let url = URL(string: myURL) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
                    if success {
                        print("success")
                    } else {
                        print("fail")
                    }
                })
            } else {
                print("device may not support")
            }
        } else {
            print("invalid format")
        }
    }

}
