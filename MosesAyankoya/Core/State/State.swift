

import Foundation


enum State<T> {
    case none
    case loading
    case error(String)
    case noData
    case dataLoaded(T, String)
}
