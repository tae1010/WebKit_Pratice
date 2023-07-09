//
//  SampleAPIViewController.swift
//  WebKit_Pratice
//
//  Created by 손인호 on 2023/06/05.
//

import Foundation
import UIKit
import Moya
import AVFoundation

class SampleAPIViewController: UIViewController {
    
    let provider = MoyaProvider<NetworkTarget>()
    
    var userArray = [Users]()
    
    let userTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(UserCell.self, forCellReuseIdentifier: "UserCell")
        return tableView
    }()
    
    let createButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("생성", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .blue
        btn.addTarget(self, action: #selector(tapSameButton), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userTableView.delegate = self
        userTableView.dataSource = self
        setUI()
        
        readUserAPI { result in
            switch result {
            case .success(let htmlString):
                // HTML 문자열을 사용하여 필요한 작업 수행
                print(htmlString)
            case .failure(let error):
                // 오류 처리
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    @objc func tapSameButton() {
        createUserAPI()
    }
    
    func readUserAPI(completion: @escaping (Result<[Users], Error>) -> Void) {
        provider.request(.getUsers) { result in
            switch result {
            case .success(let response):
                do {
                    let htmlString = try response.map([Users].self)
                    completion(.success(htmlString))
                    self.userArray = htmlString
                    
                    self.userTableView.reloadData()
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func createUserAPI() {
        let newUser = Users(id: 1231223, name: randomString(length: 5), email: "\(randomString(length: 5))@example.com", gender: .male, status: .active)
        provider.request(.createUser(requestData: newUser)) { result in
            switch result {
            case let .success(response):
                do {
                    let createdUser = try response.map(Users.self)
                    print(createdUser)
                    self.userArray.append(createdUser)
                    DispatchQueue.main.async {
                        self.userTableView.reloadData()
                    }
                    
                } catch {
                    print("Error: \(error)")
                }
            case let .failure(error):
                print("Network Error: \(error)")
            }
        }
    }
    
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map { _ in letters.randomElement()! })
    }


    
}

extension SampleAPIViewController {
    func setUI() {
        view.addSubview(userTableView)
        view.addSubview(createButton)
        setLayout()
    }
    
    func setLayout() {
        userTableView.translatesAutoresizingMaskIntoConstraints = false
        createButton.translatesAutoresizingMaskIntoConstraints = false
        
        userTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        userTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        userTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        userTableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7).isActive = true
        
        createButton.topAnchor.constraint(equalTo: userTableView.bottomAnchor, constant: 20).isActive = true
        createButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        createButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension SampleAPIViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? UserCell else { return UITableViewCell() }
        
        cell.email.text = "이메일 : \(userArray[indexPath.row].email)"
        cell.name.text = "이름 : \(userArray[indexPath.row].name)"
        cell.gender.text = "성별 : \(userArray[indexPath.row].gender.rawValue)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        TTSManager.shared.play(userArray[indexPath.row].name)
    }
}
