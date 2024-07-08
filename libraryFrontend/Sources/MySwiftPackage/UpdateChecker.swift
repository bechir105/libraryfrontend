import Foundation

public class UpdateChecker {
    public static let shared = UpdateChecker()
    
    private init() {}
    
    public func checkForUpdates(completion: @escaping (Result<UpdateInfo, Error>) -> Void) {
        guard let url = URL(string: "https://librarybackend-vtqc.onrender.com/checkForUpdates") else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1, userInfo: nil)))
                return
            }
            do {
                let updateInfo = try JSONDecoder().decode(UpdateInfo.self, from: data)
                completion(.success(updateInfo))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
