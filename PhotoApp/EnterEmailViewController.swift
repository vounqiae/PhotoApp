//
//  EnterEmailViewController.swift
//  PhotoApp
//
//  Created by Youngjae Park on 10/24/23.
//

import UIKit

final class EnterEmailViewController: UIViewController {
    
    // MARK: - 배경 이미지

    // 배경 이미지 생성
    private let imageView: UIImageView = {
        let view = UIImageView(image: .freddieMercury)
        view.contentMode = .scaleAspectFill
        view.layer.opacity = 0.7
        view.clipsToBounds = true
        return view
    }()
    
    // 배경 그라데이션
    private let gradientLayer = CAGradientLayer()
    
    let colors: [CGColor] = [
        .init(red: 0, green: 0, blue: 0, alpha: 1),
       .init(red: 0, green: 0, blue: 0, alpha: 0)
    ]
    
    // MARK: - 로고
    private let imageLogoView: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "logo1")
        view.layer.cornerRadius = 50
        view.clipsToBounds = true
        return view
    }()
    
    // MARK: - 로고 슬로건
    private let textLogoLabel: UILabel = {
       let label = UILabel()
        label.text = "The app slogan is written here."
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - enter email text view
    private lazy var emailTextFieldView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 23
        view.clipsToBounds = true
        view.addSubview(emailTextField)
        view.addSubview(emailInfoLabel)
        return view
    }()
    
    // "이메일주소 또는 전화번호" 안내문구
    private var emailInfoLabel: UILabel = {
       let label = UILabel()
        label.text =  "Email"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    // 이메일 입력 필드
    private lazy var emailTextField: UITextField = {
       var tf = UITextField()
        tf.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        tf.frame.size.height = 48
        tf.backgroundColor = .clear
        tf.textColor = .white
        tf.tintColor = .white
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.keyboardType = .emailAddress
        tf.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        return tf
    }()

    
    // MARK: - enter password text view
    private lazy var passwordTextFieldView: UIView = {
        let view = UIView()
        view.frame.size.height = 48
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 23
        view.clipsToBounds = true
        view.addSubview(passwordTextField)
        view.addSubview(passwordInfoLabel)
        view.addSubview(passwordSecureButton)
        return view
    }()
    
    // "비밀번호" 안내문구
    private var passwordInfoLabel: UILabel = {
       let label = UILabel()
        label.text = "Password"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    // 비밀번호 입력 필드
    private let passwordTextField: UITextField = {
       let tf = UITextField()
        tf.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        tf.frame.size.height = 48
        tf.backgroundColor = .clear
        tf.textColor = .white
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.isSecureTextEntry = true
        tf.clearsOnBeginEditing = false
        tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        return tf
    }()
    
    // 비밀번호 가리기 기능 "표시"버튼
    private let passwordSecureButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("SHOW", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .light)
        button.addTarget(self, action: #selector(passwordSecureModeSetting), for: .touchUpInside)
        return button
    }()
    
    // MARK: - login button
    private let loginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.layer.borderWidth = 1
        button.setTitle("Sign In", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.isEnabled = false
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var stackView: UIStackView = {
       let st = UIStackView(arrangedSubviews: [emailTextFieldView,passwordTextFieldView,loginButton])
        st.spacing = 18
        st.axis = .vertical
        st.distribution = .fillEqually
        st.alignment = .fill
        return st
    }()

    // 비밀번호 재설정 버튼
    private let passwordResetButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("Forgot your password?", for: .normal)
        button.titleLabel?.font = UIFont.italicSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    // 3개의 각 텍스트필드 및 로그인 버튼의 높이 설정
    private let textViewHeight: CGFloat = 48
    
    // 오토레이아웃 향후 변경을 위한 변수 (애니메이션)
    lazy var emailInfoLabelCenterYConstraint = emailInfoLabel.centerYAnchor.constraint(equalTo: emailTextFieldView.centerYAnchor)
    lazy var passwordInfoLabelCenterYConstraint = passwordInfoLabel.centerYAnchor.constraint(equalTo: passwordTextFieldView.centerYAnchor)
    
    // MARK: - view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        imageView.frame = view.bounds
        
        gradientLayer.frame = view.bounds
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0.3, 0.7, 0.9]
        
        makeUI()
    }
    
    func makeUI() {
        view.addSubview(imageView)
        view.layer.addSublayer(gradientLayer)
        view.addSubview(stackView)
        view.addSubview(passwordResetButton)
        view.addSubview(textLogoLabel)
        view.addSubview(imageLogoView)
        
        emailInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordSecureButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        passwordResetButton.translatesAutoresizingMaskIntoConstraints = false
        textLogoLabel.translatesAutoresizingMaskIntoConstraints = false
        imageLogoView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emailInfoLabel.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 25),
            emailInfoLabel.trailingAnchor.constraint(equalTo: emailTextFieldView.trailingAnchor, constant: 25),
            emailInfoLabelCenterYConstraint,
            
            emailTextField.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 25),
            emailTextField.trailingAnchor.constraint(equalTo: emailTextFieldView.trailingAnchor, constant: 25),
            emailTextField.topAnchor.constraint(equalTo: emailTextFieldView.topAnchor, constant: 15),
            emailTextField.bottomAnchor.constraint(equalTo: emailTextFieldView.bottomAnchor, constant: 2),
            
            passwordInfoLabel.leadingAnchor.constraint(equalTo: passwordTextFieldView.leadingAnchor, constant: 25),
            passwordInfoLabel.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: 25),
            passwordInfoLabelCenterYConstraint,
            
            passwordTextField.topAnchor.constraint(equalTo: passwordTextFieldView.topAnchor, constant: 15),
            passwordTextField.bottomAnchor.constraint(equalTo: passwordTextFieldView.bottomAnchor, constant: 2),
            passwordTextField.leadingAnchor.constraint(equalTo: passwordTextFieldView.leadingAnchor, constant: 25),
            passwordTextField.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: 25),
            
            passwordSecureButton.topAnchor.constraint(equalTo: passwordTextFieldView.topAnchor, constant: 15),
            passwordSecureButton.bottomAnchor.constraint(equalTo: passwordTextFieldView.bottomAnchor, constant: -15),
            passwordSecureButton.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: -25),
            
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            stackView.heightAnchor.constraint(equalToConstant: textViewHeight*3 + 36),
            
            passwordResetButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            passwordResetButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            passwordResetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            passwordResetButton.heightAnchor.constraint(equalToConstant: textViewHeight),

            textLogoLabel.topAnchor.constraint(equalTo: emailTextFieldView.topAnchor, constant: -150),
            textLogoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textLogoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            imageLogoView.bottomAnchor.constraint(equalTo: textLogoLabel.topAnchor, constant: -30),
            imageLogoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageLogoView.widthAnchor.constraint(equalToConstant: 100),
            imageLogoView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc func passwordSecureModeSetting() {
        passwordTextField.isSecureTextEntry.toggle()
    }
    
   
    // 코드로 화면 이동
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        let mainVC = MainViewController()
//        mainVC.modalPresentationStyle = .fullScreen // 풀스크린으로 변경하는 코드
        present(mainVC, animated: true, completion: nil)
        print("로그인 버튼이 눌렸습니다.")
    }
    
    @objc func resetButtonTapped() {

        let alert = UIAlertController(title: "Forgot your password?", message: "Change your password.", preferredStyle: .actionSheet)
        
        let success = UIAlertAction(title: "Yes", style: .default) { action in
            print("확인버튼이 눌렸습니다.")
        }
        
        let cancel = UIAlertAction(title: "No", style: .cancel) { cancel in
            print("취소버튼이 눌렸습니다.")
        }
        
        alert.addAction(success)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension EnterEmailViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == emailTextField {
            emailTextFieldView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            emailInfoLabel.font = UIFont.systemFont(ofSize: 11)
            // 오토레이아웃 업데이트
            emailInfoLabelCenterYConstraint.constant = -13
        }
        
        if textField == passwordTextField {
            passwordTextFieldView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            passwordInfoLabel.font = UIFont.systemFont(ofSize: 11)
            // 오토레이아웃 업데이트
            passwordInfoLabelCenterYConstraint.constant = -13
        }
        
        UIView.animate(withDuration: 0.3) {
            self.stackView.layoutIfNeeded()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    
        if textField == emailTextField {
            emailTextFieldView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            // 빈칸이면 원래로 되돌리기
            if emailTextField.text == "" {
                emailInfoLabel.font = UIFont.systemFont(ofSize: 18)
                emailInfoLabelCenterYConstraint.constant = 0
            }
        }
        if textField == passwordTextField {
            passwordTextFieldView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            // 빈칸이면 원래로 되돌리기
            if passwordTextField.text == "" {
                passwordInfoLabel.font = UIFont.systemFont(ofSize: 18)
                passwordInfoLabelCenterYConstraint.constant = 0
            }
        }
        
        UIView.animate(withDuration: 0.3) {
            self.stackView.layoutIfNeeded()
        }
        
    }
    
    @objc func textFieldEditingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        guard
            let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty
        else {
            loginButton.backgroundColor = .clear
            loginButton.isEnabled = false
            return
        }
        loginButton.backgroundColor = #colorLiteral(red: 1, green: 0.7189354203, blue: 0.4186914091, alpha: 1)

        loginButton.layer.cornerRadius = 23
        loginButton.isEnabled = true
        loginButton.titleLabel?.textColor = .black
    }
    
}
