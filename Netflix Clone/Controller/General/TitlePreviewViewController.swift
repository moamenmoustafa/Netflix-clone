//
//  TitlePreviewViewController.swift
//  Netflix Clone
//
//  Created by Moamen on 11/04/2024.
//

import UIKit
import WebKit

class TitlePreviewViewController: UIViewController {
    
    private let overviewLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "This is the best movie ever to watch as a kid!"
        label.font = .systemFont(ofSize: 18 , weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    private let downloadButton : UIButton = {
        let button = UIButton()
        button.setTitle("Download", for: .normal)
        button.backgroundColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        
        return button
    }()
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22 , weight: .bold)
        label.text = "Harry Potter"

        return label
    }()
    private let webView : WKWebView = {
        let web = WKWebView()
        web.translatesAutoresizingMaskIntoConstraints = false
        return web
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(titleLabel)
        view.addSubview(webView)
        view.addSubview(overviewLabel)
        view.addSubview(downloadButton)
        configureConstraints()
    }

    private func configureConstraints(){
        let webViewConstraints = [
            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 200)
        ]
        let titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 20),
            titleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20),
        ]
    
        let overviewLabelConstraints = [
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor ,constant:  15),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            
        ]
        let downloadButtonConstraints = [
            downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 25),
            downloadButton.widthAnchor.constraint(equalToConstant: 140),
            downloadButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(downloadButtonConstraints)
        NSLayoutConstraint.activate(overviewLabelConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(webViewConstraints)
    }
    
    
    public func configurate(with model : TitlePreviewViewModel){
        titleLabel.text = model.title
        overviewLabel.text = model.titleOverview
        
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeView.id.videoId)") else {return}
        webView.load(URLRequest(url: url))

    }
}
