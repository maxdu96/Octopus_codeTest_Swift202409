//
//  ViewController.swift
//  CodeTestIOS
//
//  Created by Max DU on 25/9/2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    
    var banksData: [Bank] = []
    
    let recommendedText = Constant.recommendedString
    let moreText = Constant.moreString
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadBanks()
    }
    
    fileprivate func setupUI() {
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    fileprivate func loadBanks() {
        do {
            let banksResponse = try JSONDecoder().decode(BanksModel.self, from: jsonData)
            banksData = banksResponse.banks
            tableview.reloadData()
            print(banksData)
        } catch {
            print("Failed to decode JSON: \(error)")
        }
    }
    
    
    func splitPhoneString(_ text: String) -> NSAttributedString? {
        let pattern = "(Dial)\\s*<font color='(#[0-9A-Fa-f]{6})'>(\\d+)</font>"
        
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let nsString = text as NSString
            let results = regex.matches(in: text, options: [], range: NSRange(location: 0, length: nsString.length))
            
            if let match = results.first {
                let dial = nsString.substring(with: match.range(at: 1))
                let color = nsString.substring(with: match.range(at: 2))
                let number = nsString.substring(with: match.range(at: 3))
                let attributedString = NSMutableAttributedString(string: "\(dial) \(number)")
                print("Dial: \(dial)")
                print("Color: \(color)")
                print("Number: \(number)")
                
                attributedString.addAttribute(.foregroundColor, value: UIColor(hex: color), range: NSRange(location: dial.count + 1, length: number.count))
                
                
                return attributedString
                
            } else {
                //                    print("No match found")
                return nil
            }
        } catch {
            print("Error creating regex: \(error)")
            return nil
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

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        return banksData.count
        return banksData[section].isExpanded
        ? banksData[section].actions.more.count + banksData[section].actions.recommended.count
        : 0
    }
    
    func getPhoneType(_ type: String) -> Bool {
        if type == "phone" {
            return true
        }else {
            return false
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.selectionStyle = .none
        
        let bankActions = banksData[indexPath.section].actions
        //        print("indexpath S", indexPath.section)
        //        print("indexpath R", indexPath.row)
        
        let totalRecommended = bankActions.recommended.count
        let totalMore = bankActions.more.count
        var isPhoneType = false
        var titleText = ""
        
        if indexPath.row == 0 && totalRecommended > 0 {
            cell.tv_typeBar.isHidden = false
            cell.lb_typeBar.text = recommendedText
            let phoneType = bankActions.recommended[indexPath.row].type
            isPhoneType = getPhoneType(phoneType)
            titleText = bankActions.recommended[indexPath.row].titleEn
            
        } else if indexPath.row == totalRecommended && totalMore > 0 {
            cell.tv_typeBar.isHidden = false
            cell.lb_typeBar.text = moreText
            let moreIndex = indexPath.row - totalRecommended
            let phoneType = bankActions.more[moreIndex].type
            isPhoneType = getPhoneType(phoneType)
            titleText = bankActions.more[moreIndex].titleEn
        } else {
            cell.tv_typeBar.isHidden = true
            if indexPath.row < totalRecommended {
                let phoneType = bankActions.recommended[indexPath.row].type
                isPhoneType = getPhoneType(phoneType)
                titleText = bankActions.recommended[indexPath.row].titleEn
            } else {
                let moreIndex = indexPath.row - totalRecommended
                let phoneType = bankActions.more[moreIndex].type
                isPhoneType = getPhoneType(phoneType)
                titleText = bankActions.more[moreIndex].titleEn
            }
        }
        
        if (isPhoneType){
            cell.lb_text.attributedText = splitPhoneString(titleText)
        }else {
            cell.lb_text.text = titleText
        }
        
        
        return cell
        
    }
    
    func redirectAction(urlEn: String, type: String) {
        print("urlEn: \(urlEn), type: \(type)")
        //               if type == "link" {
        
        //               } else if type == "phone" {
        //                   URLhandler(urlEn)
        //               }
        URLhandler(urlEn)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.deselectRow(at: indexPath, animated: false)
        
        let bankActions = banksData[indexPath.section].actions
        
        let allActions = bankActions.recommended + bankActions.more
        
        guard indexPath.row < allActions.count else {
            return
        }
        
        let selectedAction = allActions[indexPath.row]
        redirectAction(urlEn: selectedAction.urlEn, type: selectedAction.type)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = CustomHeaderView()
        header.lb_title.text = banksData[section].nameEn
        header.lb_desc.text = banksData[section].descEn
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
        //                   for (index, _) in banksData.enumerated() {
        //                       if index != section {
        //                           banksData[index].isExpanded = false
        //                       }
        //                   }
        //
        //                   tableview.beginUpdates()
        //                   tableview.reloadSections(IndexSet(integersIn: 0..<banksData.count), with: .automatic)
        //                   tableview.endUpdates()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return banksData.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 54.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

