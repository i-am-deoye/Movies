

import SwinjectStoryboard
import SwinjectAutoregistration


extension SwinjectStoryboard {
    
    @objc class func setupMovieListDI() {
        defaultContainer.autoregister(IMovieListViewModel.self,
                                      name: MovieListNameDependencies.IMovieListViewModel.rawValue,
                                      initializer: MovieListViewModel.init)
        
        defaultContainer.autoregister(IMovieListRemoteRepository.self,
                                      name: MovieListNameDependencies.IMovieListRemoteRepository.rawValue,
                                      initializer: MovieListRemoteRepository.init)
        
        defaultContainer.autoregister(IMovieListDataProvider.self,
                                      name: MovieListNameDependencies.IMovieListDataProvider.rawValue,
                                      initializer: MovieListDataProvider.init)
        
        defaultContainer.storyboardInitCompleted(MovieListViewController.self) { resolver, controller in
            
            let provider = resolver.resolve(IMovieListDataProvider.self, name: MovieListNameDependencies.IMovieListDataProvider.rawValue)!
            var viewModel = resolver.resolve(IMovieListViewModel.self, name: MovieListNameDependencies.IMovieListViewModel.rawValue)!
            
            let remoteRepository = resolver.resolve(IMovieListRemoteRepository.self, name: MovieListNameDependencies.IMovieListRemoteRepository.rawValue)!
            viewModel.remoteRepository = remoteRepository
            
            controller.viewModel = viewModel
            controller.provider = provider
            
        }
    }
    
}
