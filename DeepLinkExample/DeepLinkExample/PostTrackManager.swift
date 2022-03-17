//
//  PostTrackManager.swift
//  DeepLinkExample
//
//  Created by Hyeon on 2022/03/14.
//

import Foundation
import UIKit

enum PostTaskType {
    case showToast(message: String)
}

enum PostTaskTarget {
    case home
}

struct PostTask {
    let target: PostTaskTarget
    let task: PostTaskType
}

class PostTaskManager {

    private var postTasks = [PostTaskTarget: [PostTaskType]]()

    func register(postTask: PostTask) {
        guard postTasks[postTask.target] != nil else {
            postTasks[postTask.target] = [postTask.task]
            return
        }

        postTasks[postTask.target]?.append(postTask.task)
    }

    func postTasks(postTastTarget: PostTaskTarget) -> [PostTaskType]? {
        if isExist(taskTarget: postTastTarget) {
            return postTasks[postTastTarget]
        } else {
            return nil
        }
    }

    func removeAll() {
        postTasks.removeAll()
    }

    func remove(for input: PostTaskTarget) {
        postTasks[input]?.removeAll()
    }

    private func isExist(taskTarget: PostTaskTarget) -> Bool {
        return !(postTasks[taskTarget]?.isEmpty ?? true)
    }
}

