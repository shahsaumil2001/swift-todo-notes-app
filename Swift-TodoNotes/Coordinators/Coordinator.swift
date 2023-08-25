//
//  Coordinator.swift
//  Swift-TodoNotes
//
//  Created by Saumil Shah on 23/08/23.
//

import UIKit

protocol Coordinator {
    var rootNavigationController: UINavigationController { get set }
    func start()
}

extension Coordinator {
    func pushViewController(_ viewController: UIViewController?, animated: Bool = true) {
        guard let controller = viewController else { return }

        rootNavigationController.pushViewController(controller, animated: animated)
    }

    func popViewController(animated: Bool = true) {
        rootNavigationController.popViewController(animated: animated)
    }

    func popToRootViewController(animated: Bool = true) {
        rootNavigationController.popToRootViewController(animated: animated)
    }

    func presentViewController(_ viewController: UIViewController?, animated: Bool = true) {
        guard let controller = viewController else { return }

        rootNavigationController.present(controller, animated: animated)
    }

    func setViewController(_ viewController: UIViewController?, animated _: Bool = true) {
        guard let controller = viewController else { return }

        rootNavigationController.setViewControllers([controller], animated: true)
    }

    func dismissViewController(animated: Bool = true, completion: Action? = nil) {
        rootNavigationController.dismiss(animated: animated, completion: completion)
    }
}
