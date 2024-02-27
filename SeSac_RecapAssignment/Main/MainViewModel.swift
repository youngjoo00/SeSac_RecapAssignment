//
//  MainViewModel.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 2/26/24.
//

import Foundation

class MainViewModel {
    
    var inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    var inputSearchListData: Observable<String?> = Observable("")
    var inputDeleteButtonTapped: Observable<Int?> = Observable(nil)
    var inputSearchListAllDeleteTapped: Observable<Void?> = Observable(nil)
    var inputSearchBarSearchButtonTapped: Observable<String?> = Observable(nil)
    var inputDidSelectRowAt: Observable<Int?> = Observable(nil)
    
    var outputNickname = Observable("")
    var outputSearchList: Observable<[String]> = Observable([])
    
    init() {
        transform()
    }
    
    private func transform() {
        
        inputViewDidLoadTrigger.bind { _ in
            self.fetchNickname()
            self.fetchSearchList()
        }
        
        inputSearchListData.bind { value in
            guard let value = value else { return }
            var searchList = UserDefaults.standard.array(forKey: "searchList") as? [String] ?? [String]()
            searchList.append(value)
            UserDefaults.standard.set(searchList, forKey: "searchList")
        }

        inputDeleteButtonTapped.bind { value in
            guard let value else { return }
            self.outputSearchList.value.remove(at: value)
        }
        
        inputSearchListAllDeleteTapped.bind { _ in
            self.outputSearchList.value = []
        }
        
        inputSearchBarSearchButtonTapped.bind { value in
            guard let value else { return }
            self.outputSearchList.value.insert(value, at: 0)
        }
        
        inputDidSelectRowAt.bind { value in
            guard let value else { return }
            self.updateRecentSearch(row: value)
        }
    }
    
    private func fetchNickname() {
        guard let nickname = UserDefaults.standard.string(forKey: "userNickname") else { return }
        self.outputNickname.value = nickname
    }
    
    private func fetchSearchList() {
        guard let list: [String] = UserDefaults.standard.array(forKey: "searchList") as? [String] else { return }
        print(#function)
        self.outputSearchList.value = list
    }
    
    private func updateRecentSearch(row: Int) {
        let data = self.outputSearchList.value[row]
        self.outputSearchList.value.remove(at: row)
        self.outputSearchList.value.insert(data, at: 0)
    }
    
}
