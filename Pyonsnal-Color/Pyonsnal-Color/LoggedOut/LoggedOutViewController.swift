//
//  LoggedOutViewController.swift
//  Pyonsnal-Color
//
//  Created by 김진우 on 2023/05/28.
//

import KakaoSDKUser
import UIKit
import ModernRIBs
import AuthenticationServices

protocol LoggedOutPresentableListener: AnyObject {
    func didTapAppleLoginButton()
    func requestKakaoLogin()
}

final class LoggedOutViewController:
    UIViewController,
    LoggedOutPresentable,
    LoggedOutViewControllable {

    // MARK: - Interface
    weak var listener: LoggedOutPresentableListener?

    // MARK: - UI Component
    private let loginButtonStackView: UIStackView = {
        let stackView: UIStackView = .init()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
        return stackView
    }()
    
    private let appleLoginButton = ASAuthorizationAppleIDButton()

    private let kakaoLoginButton: UIButton = {
        let button: UIButton = .init()
        button.layer.cornerRadius = 8
        button.backgroundColor = .systemBrown
        button.setTitle("🍈 Kakao Login", for: .normal)
        button.setTitleColor(.systemYellow, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        return button
    }()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureLayout()
        configureAction()
    }

    // MARK: - Private Method
    private func configureUI() {
        view.backgroundColor = .green
    }
    
    private func configureLayout() {
        view.addSubview(loginButtonStackView)

        loginButtonStackView.addArrangedSubview(appleLoginButton)
        loginButtonStackView.addArrangedSubview(kakaoLoginButton)

        NSLayoutConstraint.activate([
            loginButtonStackView.widthAnchor.constraint(equalToConstant: 220),
            loginButtonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButtonStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func configureAction() {
        appleLoginButton.addTarget(
            self,
            action: #selector(didTapAppleLoginButton),
            for: .touchUpInside)
        
        kakaoLoginButton.addTarget(
            self,
            action: #selector(didTapKakaoLoginButton),
            for: .touchUpInside
        )
    }
    
    @objc
    private func didTapAppleLoginButton() {
        listener?.didTapAppleLoginButton()
    }
    
    @objc
    private func didTapKakaoLoginButton() {
        listener?.requestKakaoLogin()
    }

}



