//
//  ViewController.swift
//  CodeTestIOS
//
//  Created by Max DU on 25/9/2024.
//

import UIKit

// Hard code example JSON data
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


class ViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!

    var banksData: [Bank] = []

    let helper = Helper.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadBanks()
    }

    fileprivate func setupUI() {
        tableview.delegate = self
        tableview.dataSource = self

        tableview.register(CustomHeaderView.nib, forHeaderFooterViewReuseIdentifier: CustomHeaderView.identifier)
    }

    fileprivate func loadBanks() {
        do {
            let banksResponse = try JSONDecoder().decode(BanksModel.self, from: jsonData)
            banksData = banksResponse.banks
            tableview.reloadData()
            print("func loadBanks() banksData: ", banksData)
        } catch {
            print("Failed to decode JSON: \(error)")
        }
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return banksData[section].isExpanded
        ? banksData[section].actions.more.count + banksData[section].actions.recommended.count
        : 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell

        let bankActions = banksData[indexPath.section].actions
        cell.configure(data: bankActions, indexPath: indexPath)

        return cell
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.deselectRow(at: indexPath, animated: false)

        let bankActions = banksData[indexPath.section].actions
        let allActions = bankActions.recommended + bankActions.more

        guard indexPath.row < allActions.count else {
            return
        }

        let selectedAction = allActions[indexPath.row]
        helper.URLhandler(selectedAction.urlEn)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: CustomHeaderView.identifier) as! CustomHeaderView

        let data = banksData[section]
        header.configure(data)

        header.tapAction = { [weak self] in
            self?.headerTapped(section: section)
        }
        return header
    }

    private func headerTapped(section: Int) {
        print("Header tapped in section: \(section)")
        let isExpanded = banksData[section].isExpanded
        banksData[section].isExpanded = !isExpanded

        tableview.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)

        // Can set when anther cell clicked close your before cell
        //        for (index, _) in banksData.enumerated() {
        //            if index != section {
        //                banksData[index].isExpanded = false
        //            }
        //        }
        //
        //        tableview.beginUpdates()
        //        tableview.reloadSections(IndexSet(integersIn: 0..<banksData.count), with: .automatic)
        //        tableview.endUpdates()

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return banksData.count
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableView.bounds.height / 9.0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}

