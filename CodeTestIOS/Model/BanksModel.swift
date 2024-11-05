//
//  BanksModel.swift
//  CodeTestIOS
//
//  Created by Max DU on 25/9/2024.
//

import Foundation

struct BanksModel: Codable {
    let banks: [Bank]
}

struct Bank: Codable {
    let nameEn: String
    let descEn: String?
    let actions: Actions
    var isExpanded: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case nameEn
        case descEn
        case actions
        case isExpanded 
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        nameEn = try container.decode(String.self, forKey: .nameEn)
        descEn = try? container.decode(String.self, forKey: .descEn)
        actions = try container.decode(Actions.self, forKey: .actions)
        isExpanded = try container.decodeIfPresent(Bool.self, forKey: .isExpanded) ?? false // Default value
    }
}

struct Actions: Codable {
    let recommended: [Action]
    let more: [Action]
}

struct Action: Codable {
    let titleEn: String
    let type: String
    let urlEn: String
}

// Example JSON Parsing

let jsonData = """
{
    "banks": [{
            "nameEn": "China Construction Bank (Asia)",
            "descEn": "Complete via bank app",
            "actions": {
                "recommended": [{
                    "titleEn": "Via Bank App",
                    "type": "link",
                    "urlEn": "https://www.octopus.com.hk/landingpage"
                }],
                "more": [{
                    "titleEn": "Download AAVS Application Form",
                    "type": "link",
                    "urlEn": "http://www.asia.ccb.com/hongkong_tc/doc/personal/credit_cards/CCBA_OAAVS.pdf"
                }]
            }
        },
        {
            "nameEn": "ICBC (Asia)",
            "descEn": "Complete via bank app",
            "actions": {
                "recommended": [{
                    "titleEn": "Via Bank App",
                    "type": "link",
                    "urlEn": "com.icbc.icbcasia://launch"
                }],
                "more": [{
                    "titleEn": "Download AAVS Application Form",
                    "type": "link",
                    "urlEn": "https://v.icbc.com.cn/userfiles/Resources/ICBC/haiwai/Asia/download/EN/2020/OctopusFormE_apr2020.pdf"
                }]
            }
        },
        {
            "nameEn": "HSBC",
            "actions": {
                "recommended": [{
                    "titleEn": "Via Bank App",
                    "type": "link",
                    "urlEn": "com.icbc.icbcasia://launch"
                }],
                "more": [{
                        "titleEn": "Via Online Bank Service",
                        "type": "link",
                        "urlEn": "https://www.hsbc.com.hk/octopus-aavs-apply/"
                    },
                    {
                        "titleEn": "Dial <font color='#C85204'>22333000</font>",
                        "type": "phone",
                        "urlEn": "tel:22333000"
                    },
                    {
                        "titleEn": "Download AAVS Application Form",
                        "type": "link",
                        "urlEn": "https://www.hsbc.com.hk/content/dam/hsbc/hk/docs/credit-cards/aavs-appform.pdf"
                    }
                ]
            }
        },
        {
            "nameEn": "Hang Seng Bank",
            "actions": {
                "recommended": [{
                        "titleEn": "Via Bank App",
                        "type": "link",
                        "urlEn": "com.icbc.icbcasia://launch"
                    },
                    {
                        "titleEn": "Dial <font color='#C85204'>29986899</font>",
                        "type": "phone",
                        "urlEn": "tel:29986899"
                    }
                ],
                "more": [{
                        "titleEn": "Via Online Bank Service",
                        "type": "link",
                        "urlEn": "https://e-banking2.hangseng.com/en-hk/online/card/other-related-services/octopus/#/landing"
                    },
                    {
                        "titleEn": "Download AAVS Application Form",
                        "type": "link",
                        "urlEn": "https://www.hangseng.com/content/dam/hase/en_hk/personal/pdf/aavs_form_eng.pdf"
                    }
                ]
            }
        },
        {
            "nameEn": "China Construction Bank (Asia)1",
            "descEn": "Complete via bank app1",
            "actions": {
                "recommended": [{
                    "titleEn": "Via Bank App1",
                    "type": "link",
                    "urlEn": "https://www.octopus.com.hk/landingpage"
                }],
                "more": [{
                    "titleEn": "Download AAVS Application Form1",
                    "type": "link",
                    "urlEn": "http://www.asia.ccb.com/hongkong_tc/doc/personal/credit_cards/CCBA_OAAVS.pdf"
                }]
            }
        },
        {
            "nameEn": "China Construction Bank (Asia)2",
            "descEn": "Complete via bank app2",
            "actions": {
                "recommended": [{
                    "titleEn": "Via Bank App2",
                    "type": "link",
                    "urlEn": "https://www.octopus.com.hk/landingpage"
                }],
                "more": [{
                    "titleEn": "Download AAVS Application Form2",
                    "type": "link",
                    "urlEn": "http://www.asia.ccb.com/hongkong_tc/doc/personal/credit_cards/CCBA_OAAVS.pdf"
                }]
            }
        },
        {
            "nameEn": "China Construction Bank (Asia)3",
            "descEn": "Complete via bank app3",
            "actions": {
                "recommended": [{
                    "titleEn": "Via Bank App3",
                    "type": "link",
                    "urlEn": "https://www.octopus.com.hk/landingpage"
                }],
                "more": [{
                    "titleEn": "Download AAVS Application Form3",
                    "type": "link",
                    "urlEn": "http://www.asia.ccb.com/hongkong_tc/doc/personal/credit_cards/CCBA_OAAVS.pdf"
                }]
            }
        },
        {
            "nameEn": "China Construction Bank (Asia)4",
            "descEn": "Complete via bank app4",
            "actions": {
                "recommended": [{
                    "titleEn": "Via Bank App4",
                    "type": "link",
                    "urlEn": "https://www.octopus.com.hk/landingpage"
                }],
                "more": [{
                    "titleEn": "Download AAVS Application Form4",
                    "type": "link",
                    "urlEn": "http://www.asia.ccb.com/hongkong_tc/doc/personal/credit_cards/CCBA_OAAVS.pdf"
                }]
            }
        },
        {
            "nameEn": "China Construction Bank (Asia)5",
            "descEn": "Complete via bank app5",
            "actions": {
                "recommended": [{
                    "titleEn": "Via Bank App5",
                    "type": "link",
                    "urlEn": "https://www.octopus.com.hk/landingpage"
                }],
                "more": [{
                    "titleEn": "Download AAVS Application Form5",
                    "type": "link",
                    "urlEn": "http://www.asia.ccb.com/hongkong_tc/doc/personal/credit_cards/CCBA_OAAVS.pdf"
                }]
            }
        }
    ]
}
""".data(using: .utf8)!

