//
//  CustomHeaderView.swift
//  CodeTestIOS
//
//  Created by Max DU on 25/9/2024.
//
import UIKit

class CustomHeaderView: UITableViewHeaderFooterView {
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }

    @IBOutlet weak var lb_title: UILabel!
    @IBOutlet weak var lb_desc: UILabel!
    @IBOutlet weak var tv_separator: UIView!

    var section: Int = 0
    var tapAction: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    private func setupView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(headerTapped))
        self.addGestureRecognizer(tapGesture)

        lb_title.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        lb_title.textColor = .black

        lb_desc.font = UIFont.systemFont(ofSize: 15)
        lb_desc.textColor = .black

        tv_separator.backgroundColor = .lightGray
    }

    func configure(_ data: Bank) {
        lb_title.text = data.nameEn
        lb_desc.text = data.descEn
    }

    @objc private func headerTapped() {
        tapAction?()
    }
}
