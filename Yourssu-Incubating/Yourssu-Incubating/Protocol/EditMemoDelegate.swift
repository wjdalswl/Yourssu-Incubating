//
//  EditMemoDelegate.swift
//  Yourssu-Incubating
//
//  Created by 정민지 on 5/21/24.
//

protocol EditMemoDelegate: AnyObject {
    func didUpdateMemo(_ memo: MemoModel, atIndex: Int)
}
