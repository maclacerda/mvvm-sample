//
//  LoginViewController.swift
//  MVVM-Sample
//
//  Created by Marcos Lacerda on 31/10/18.
//  Copyright © 2018 Marcos Lacerda. All rights reserved.
//

import UIKit

protocol LoginDelegate {
    func loginSuccess(_ user: User)
    func loginError(_ error: String)
}

class LoginViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var messageLabel: UILabel!
    
    // MARK: - Properties
    var viewModel: LoginViewModel!
    
    fileprivate var state: ViewState = .normal {
        didSet {
            self.setupView()
        }
    }
    
    // MARK: - Initializers
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        viewModel = LoginViewModel(with: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewModel = LoginViewModel(with: self)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        
        self.state = .normal
    }
    
    // MARK: - UI
    fileprivate func initUI() {
        // Apply the customizations
        guard let navigationController = self.navigationController else { return }
        
        navigationController.navigationBar.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 18, weight: .black)]
    }
    
    fileprivate func setupView() {
        switch state {
        case .loading:
            self.messageLabel.text = ""
            activityIndicator.startAnimating()
            break
            
        case .error:
            activityIndicator.stopAnimating()
            break
            
        default:
            self.messageLabel.text = ""
            activityIndicator.stopAnimating()
            break
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Hides keyboard if user hit screen
        self.view.endEditing(true)
    }
    
    // MARK: - Navigation
    fileprivate func showArticlesList(_ user: User) {
        // Redirect user to articles
        guard let articlesController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ArticlesController") as? UINavigationController else { return }
        
        appdelegate.changeRootViewController(articlesController)
        
        // Send user logged data to Articles list
        if let articlesList = articlesController.viewControllers.first as? ArticlesViewController {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                articlesList.loggedUser = user
            }
        }
    }
    
    // MARK: - Actions
    @IBAction fileprivate func loginButtonClick() {
        self.state = .loading
        
        DispatchQueue.main.async {
            self.viewModel.login(with: self.emailField.text!, password: self.passwordField.text!)
        }
    }
    
}

extension LoginViewController: LoginDelegate {
    
    func loginSuccess(_ user: User) {
        DispatchQueue.main.async {
            self.state = .normal
            self.showArticlesList(user)
        }
        
        // print user data or save credentials or any other things
        print(user.email)
    }
    
    func loginError(_ error: String) {
        self.state = .normal
        
        // Show user alert with error here
        self.messageLabel.text = error
    }
    
}
