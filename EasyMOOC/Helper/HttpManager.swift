//
//  HttpManager.swift
//  EasyMOOC
//
//  Created by 高存折 on 17/3/3.
//  Copyright © 2017年 高存折. All rights reserved.
//

import Foundation
import Alamofire
import LeanCloud

struct HttpManager {
    
    //MARK: - Login and Register
    static func login(userName:String,userPwd:String,completion:@escaping (String) -> Void) {
        
        LCUser.logIn(username: userName, password: userPwd) { (result) in
            switch result {
            case .success(let user):
                //将当前登录用户保存在全局变量中
                Constant.currentUser = UserInfo.init(withObject: user)
                Constant.lcuser = user
                completion("success")
                break
            case .failure(let err):
                completion(err.reason ?? "fail")
            }
        }
    }

    static func register(userName:String,userPwd:String,identity:String, completion:@escaping (String) -> Void) {
        let registerUser = LCUser()
        registerUser.username = LCString(userName)
        registerUser.password = LCString(userPwd)
        let userIdentity = identity
        registerUser.set("identity", value: userIdentity)
        
        switch registerUser.signUp() {
        case .success:
            completion("success")
            break
        case .failure(_):
            completion("fail")
            break
        }
    }
    
    //MARK: - Image
    static func fetchImage(url:String, completion:@escaping (UIImage?) -> Void) {
        let imageURL = URL(string: url)
        let request  =  try! URLRequest(url: imageURL!, method: .get)
        
        Alamofire.request(request).response { (response) in
            
            let image = UIImage(data: response.data!)
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
    
    //MARK: - Course Related
    static func fetchCourses(catagoryName:String, completion:@escaping ([Course]) -> Void) {
        let typeQuery  = LCQuery(className: "Course")
        typeQuery.whereKey("type", .matchedSubstring(catagoryName))
        
        typeQuery.find { result in
            switch result {
            case .success(let searchResult):
                var courses = [Course]()
                for result in searchResult {
                    let course = Course.init(withObject: result)
                    courses.append(course)
                }
                completion(courses)
            case .failure(let error):
                print("search fail : \(error.reason)")
            }
        }
    }
    
    static func fetchCourses(relationKey: String, completion:@escaping ([Course]) -> Void) {
        let mycourses = Constant.lcuser?.relationForKey(relationKey)
        mycourses?.query.find() { result in
            if result.isSuccess {
                var courses = [Course]()
                for object in result.objects! {
                    let course = Course(withObject: object)
                    courses.append(course)
                }
                completion(courses)
            }else {
                Constant.aler(with: "你还未加入任何课程", title: "")
            }
        }
    }
    
    static func searchCourses(searchText:String, completion:@escaping ([Course]) -> Void) {
        let courseNameQuery = LCQuery(className: "Course")
        courseNameQuery.whereKey("courseName", .matchedSubstring(searchText))
        let universityQuery = LCQuery(className: "Course")
        universityQuery.whereKey("university", .matchedSubstring(searchText))
        let courseQuery = LCQuery(className: "Course")
        courseQuery.whereKey("coureseName", .matchedSubstring(searchText))
        let teacherQuery = LCQuery(className: "Course")
        teacherQuery.whereKey("teacher", .matchedSubstring(searchText))
        let typeQuery  = LCQuery(className: "Course")
        typeQuery.whereKey("type", .matchedSubstring(searchText))
        
        let query = courseNameQuery.or(universityQuery).or(courseQuery).or(teacherQuery).or(typeQuery)
        query.find { result in
            switch result {
            case .success(let searchResult):
                var courses = [Course]()
                for result in searchResult {
                    let course = Course.init(withObject: result)
                    courses.append(course)
                }
                completion(courses)
            case .failure(let error):
                print("search fail : \(error.reason)")
            }
        }
    }
    
    static func fetchCourse(courseName:String,completion:@escaping (Course) -> Void) {
        let courseQuery = LCQuery(className: "Course")
        courseQuery.whereKey("courseName", .matchedSubstring(courseName))
        
        courseQuery.find { result in
            switch result {
            case .success(let reusltCourse) :
                let course = Course.init(withObject: reusltCourse[0])
                completion(course)
            case .failure(let err):
                print("search fail : \(err.reason)")
            }
        }
    }
    
    static func createCourse(course: Course, completion: @escaping (String) -> Void) {
        let courseToUpload = LCObject(className: "Course")
        courseToUpload.set("courseName", value: course.courseName)
        courseToUpload.set("teacher", value: course.teacherName)
        courseToUpload.set("university", value: course.collegeName)
        courseToUpload.set("type", value: course.type)
        courseToUpload.set("info", value: course.info)
        
        courseToUpload.save { (result) in
            switch result {
                case .success:
                    Constant.lcuser?.insertRelation("myCourses", object: courseToUpload)
                    _ = Constant.lcuser?.save()
                    completion("success")
                case .failure(let error):
                    Constant.aler(with: "创建课程失败: \(error)", title: "")
            }
        }
    }
    
    //MARK: - Forum Related
    static func fectchQuestion(completion:@escaping ([Question]) -> Void) {
        let query = LCQuery(className: "Question")
        query.whereKey("createdAt", .descending)
        query.find { result in
            switch result {
                case .success(let results):
                    var questions = [Question]()
                    for questionObject in results {
                        let question = Question(with: questionObject)
                        questions.append(question)
                    }
                    completion(questions)
                case .failure(let error):
                    Constant.aler(with: "fetch question fail: \(error)", title: "")
            }
        }
    }
    
    static func searchQuestions(searchText:String, completion:@escaping ([Question]) -> Void) {
        let titleQuery = LCQuery(className: "Question")
        titleQuery.whereKey("title", .matchedSubstring(searchText))
        let detailQuery = LCQuery(className: "Question")
        detailQuery.whereKey("detail", .matchedSubstring(searchText))
        
        let query = titleQuery.or(detailQuery)
        query.find { result in
            switch result {
            case .success(let searchResult):
                var questions = [Question]()
                for result in searchResult {
                    let question = Question.init(with: result)
                    questions.append(question)
                }
                completion(questions)
            case .failure(let error):
                print("search fail : \(error.reason)")
            }
        }
    }
    
    static func createQuestion(question: Question, completion: @escaping (String) -> Void) {
        let newQuestion = LCObject(className: "Question")
        newQuestion.set("title", value: question.title)
        newQuestion.set("detail", value: question.detail)
        newQuestion.set("time", value: question.time)
        newQuestion.set("userName", value: question.userName)

        newQuestion.save { (result) in
            switch result {
            case .success:
                completion("success")
                Constant.aler(with: "问题已提交，正等待回答", title: "")
            case .failure(let error):
                Constant.aler(with: "创建课程失败: \(error)", title: "")
            }
        }
    }
    
    static func fetchAnswer(question: Question, completion: @escaping ([Answer]) -> Void) {
        
        guard let objectID = question.objectID else {return}
        
        let questionObject = LCObject(className: "Question", objectId: objectID)
        let query = questionObject.relationForKey("answers").query
        query.whereKey("createdAt", .descending)
        query.find() { result in
            if result.isSuccess {
                var answers = [Answer]()
                for object in result.objects! {
                    let answer = Answer(with: object)
                    answers.append(answer)
                }
                completion(answers)
            }else {
                
            }
        }
    }
    
    
}
