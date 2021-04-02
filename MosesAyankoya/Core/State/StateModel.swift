

import Foundation


protocol IStateModel {
    associatedtype T
    var state : State<T> { get set }
}

struct StateModel <E> : IStateModel {
    typealias T = E
    var state: State<E>
}

struct List<T> {
    var list = [T]()
}
