//
//  ViewModel.swift
//  Aisle_Test
//
//  Created by Ayush Kumar Singh on 23/08/23.
//

import Foundation

class viewModel {
    
    func phoneNumberPostRequest(phoneNumber: String, completion: @escaping (Bool) -> ()) {
        // Prepare the URL
        guard let url = URL(string: "https://app.aisle.co/V1/users/phone_number_login") else {
            print("Invalid URL")
            return
        }
        
        // Prepare the request body
        
        let requestBody = ["number": phoneNumber]
        guard let jsonData = try? JSONSerialization.data(withJSONObject: requestBody) else {
            print("Failed to serialize JSON")
            return
        }
        
        // Prepare the URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Create URLSessionDataTask
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            if let data = data {
                do {
                    // Decode the response
                    let decoder = JSONDecoder()
                    let loginResponse = try decoder.decode(phoneNumberLoginRequest.self, from: data)
                    
                    // Handle the response
                    completion(loginResponse.status)
                    
                } catch {
                    print("Error decoding response: \(error)")
                }
            }
        }
        
        // Start the data task
        task.resume()
    }
    
    func verifyOTPPostRequest(phoneNumber:String, OTP: String, completion: @escaping(String?) -> ()) {
        
        // Prepare the URL
        guard let url = URL(string: "https://app.aisle.co/V1/users/verify_otp") else {
            print("Invalid URL")
            return
        }
        
        // Prepare the request body
        
        let requestBody = ["number": phoneNumber, "otp": OTP]
        guard let jsonData = try? JSONSerialization.data(withJSONObject: requestBody) else {
            print("Failed to serialize JSON")
            return
        }
        
        // Prepare the URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Create URLSessionDataTask
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            if let data = data {
                do {
                    // Decode the response
                    let decoder = JSONDecoder()
                    let OTPResponse = try decoder.decode(OTPVerifyRequest.self, from: data)
                    
                    // Handle the response
                    completion(OTPResponse.token)
                    
                } catch {
                    print("Error decoding response: \(error)")
                }
            }
        }
        
        // Start the data task
        task.resume()
        
    }
    
    func notesGetRequest(token: String, completion: @escaping (NotesResponseModel) -> ()) {
        
        guard let url = URL(string: "https://app.aisle.co/V1/users/test_profile_list") else {
                    return
                }
                
                // Create a URL request with headers
                var request = URLRequest(url: url)
                request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                
                // Create a URLSession task to fetch data
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    if let error = error {
                        print("Error: \(error)")
                        return
                    }
                    
                    if let data = data {
                        do {
                            // Decode JSON response using Codable
                            let decoder = JSONDecoder()
                            let notes = try decoder.decode(NotesResponseModel.self, from: data)
                            // Handle the 'notes' data here
                            completion(notes)
                         //   print("Notes: \(notes)")
                        } catch {
                            print("Decoding error: \(error)")
                        }
                    }
                }
                
                // Start the URLSession task
                task.resume()
            }
        
    }

