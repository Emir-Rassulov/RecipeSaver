//
//  OTPViewModel.swift
//  Food
//
//  Created by Emir Rassulov on 04/02/2024.
//


import SwiftUI
import FirebaseAuth
import Firebase
import FirebaseFirestore

class OTPViewModel: ObservableObject {
    @Published var number: String = ""
    @Published var code: String = ""

    @Published var otpText: String = ""
    @Published var otpFields: [String] = Array(repeating: "", count: 6) {
        didSet {
            for index in 0..<6 {
                if otpFields[index].count == 6 {
                    otpText = otpFields[index]
                    otpFields[0] = ""

                    for item in otpText.enumerated() {
                        otpFields[item.offset] = String(item.element)
                    }
                }
            }
        }
    }

    @Published var showAlert: Bool = false
    @Published var errorMsg: String = ""

    @Published var verificationCode: String = ""

    @Published var isLoading: Bool = false

    @Published var navigationTag: String?
    @AppStorage("log_status") var log_status = false

    func sendOTP(completion: @escaping (Result<String, Error>) -> Void) {
        if isLoading { return }
        Task {
            do {
                isLoading = true
                let result = try await PhoneAuthProvider.provider().verifyPhoneNumber("+\(code)\(number)", uiDelegate: nil)

                UserDefaults.standard.set(result, forKey: "authVerificationID")

                DispatchQueue.main.async {
                    self.isLoading = false
                    self.verificationCode = result
                    completion(.success(result))
                }
            } catch {
                handleError(error: error.localizedDescription)
                completion(.failure(error))
            }
        }
    }

    func handleError(error: String) {
        DispatchQueue.main.async {
            self.isLoading = false
            self.errorMsg = error
            self.showAlert.toggle()
        }
    }

    func verifyOTP(completion: @escaping (Result<Void, Error>) -> Void) {
        Task {
            do {
                guard !isLoading else { return }
                isLoading = true
                otpText = otpFields.joined()

                guard let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") else {
                    print("Verification ID not found.")
                    return
                }

                let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: otpText)
                let result = try await Auth.auth().signIn(with: credential)

                DispatchQueue.main.async {
                    self.isLoading = false
                    self.log_status = true
                    completion(.success(()))
                }
            } catch {
                handleError(error: error.localizedDescription)
                completion(.failure(error))
            }
        }
    }

    func resendOTP(completion: @escaping (Result<String, Error>) -> Void) {
        if isLoading { return }
        Task {
            do {
                isLoading = true
                let result = try await PhoneAuthProvider.provider().verifyPhoneNumber("+\(code)\(number)", uiDelegate: nil)

                UserDefaults.standard.set(result, forKey: "authVerificationID")

                DispatchQueue.main.async {
                    self.isLoading = false
                    self.verificationCode = result
                    completion(.success(result))
                }
            } catch {
                handleError(error: error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
}
