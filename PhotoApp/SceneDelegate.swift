//
//  SceneDelegate.swift
//  PhotoApp
//
//  Created by Youngjae Park on 10/24/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // 먼저 매개변수 scene을 통해 하나 이상의 Window를 관리할 수 있는 windowScene을 생성함
        guard let windowScene = (scene as? UIWindowScene) else { return }
        // 미리 선언되어있던 window 프로퍼티에 휴대폰의 크기를 가져와 window를 생성해 할당해줌
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        // window의 루트뷰에 실제로 앱 실행 시에 보여질 ViewController를 NavigationController의 루트뷰로 넣어줌
        window?.rootViewController = EnterEmailViewController()
        // 이 window가 실제로 보이도록 설정해줌
        window?.makeKeyAndVisible()
        // 만든 윈도우씬을 실제 윈도우 씬에 넣어줌
        window?.windowScene = windowScene
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

