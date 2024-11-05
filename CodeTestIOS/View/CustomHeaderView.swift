//
//  CustomHeaderView.swift
//  CodeTestIOS
//
//  Created by Max DU on 25/9/2024.
//
import UIKit

class CustomHeaderView: UIView {
    
    var section: Int = 0
    var tapAction: (() -> Void)?
    
    let lb_title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    let lb_desc: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    let tv_separator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        self.addSubview(lb_title)
        self.addSubview(lb_desc)
        self.addSubview(tv_separator)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(headerTapped))
        self.addGestureRecognizer(tapGesture)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            lb_title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            lb_title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            lb_title.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            
            lb_desc.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            lb_desc.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            lb_desc.topAnchor.constraint(equalTo: lb_title.bottomAnchor, constant: 4),
            lb_desc.bottomAnchor.constraint(equalTo: tv_separator.topAnchor, constant: -8),
            
            tv_separator.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            tv_separator.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            tv_separator.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tv_separator.heightAnchor.constraint(equalToConstant: 0.5)  
        ])
    }
    
    @objc private func headerTapped() {
        tapAction?()
    }
}
