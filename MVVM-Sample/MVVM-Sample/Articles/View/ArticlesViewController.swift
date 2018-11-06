//
//  ArticlesViewController.swift
//  MVVM-Sample
//
//  Created by Marcos Lacerda on 06/11/18.
//  Copyright © 2018 Marcos Lacerda. All rights reserved.
//

import UIKit

protocol ArticlesDelegate {
    func loadSuccess()
    func loadingError(_ error: String)
}

class ArticlesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var loggedUser: User? {
        didSet {
            self.setupWelcomeMessage()
        }
    }
    
    fileprivate var state: ViewState = .normal {
        didSet {
            self.setupView()
        }
    }
    
    fileprivate var viewModel: ArticlesViewModel!
    fileprivate let datasource = ArticlesDataSource()

    // MARK: - Initializers
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        viewModel = ArticlesViewModel(with: self, datasource: datasource)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewModel = ArticlesViewModel(with: self, datasource: datasource)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.state = .loading
        viewModel.fetchArticles()
    }
    
    // MARK: - UI
    fileprivate func initUI() {
        // Apply the customizations
        guard let navigationController = self.navigationController else { return }
        
        navigationController.navigationBar.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 18, weight: .black)]
        
        self.title = "Articles"
        
        self.setupTableView()
    }
    
    fileprivate func setupView() {
        switch state {
        case .loading:
            self.messageLabel.text = ""
            self.tableView.isHidden = true
            self.activityIndicator.startAnimating()
            
            break
            
        case .error:
            self.activityIndicator.stopAnimating()
            self.tableView.isHidden = true
            break
            
        default:
            self.messageLabel.text = ""
            self.tableView.isHidden = false
            self.activityIndicator.stopAnimating()
            
            break
        }
    }
    
    fileprivate func setupTableView() {
        self.tableView.register(UINib(nibName: "ArticlesTableViewCell", bundle: nil), forCellReuseIdentifier: "ArticlesCell")
        self.tableView.estimatedRowHeight = 64
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.dataSource = datasource
    }
    
    fileprivate func setupWelcomeMessage() {
        self.title = "Welcome: \(loggedUser!.email)"
    }

}

extension ArticlesViewController: ArticlesDelegate {
    
    func loadSuccess() {
        self.state = .normal
        self.tableView.reloadData()
    }
    
    func loadingError(_ error: String) {
        self.messageLabel.text = error
        self.state = .error
    }
    
}
