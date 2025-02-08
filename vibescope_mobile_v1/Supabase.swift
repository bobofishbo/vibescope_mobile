//
//  Supabase.swift
//  vibescope_mobile_v1
//
//  Created by XIE BO on 2025/2/4.
//

import Supabase
import Foundation


let supabase = SupabaseClient(
    supabaseURL: Secrets.supabaseURL,
    supabaseKey: Secrets.supabaseKey
)

struct UserGroup: Decodable, Identifiable {
    let id: Int
    let group_name: String
    let user_id_1: UUID
    let user_id_2: UUID
    let user_id_3: UUID
    let user_id_4: UUID
}


struct HomeUserInfo: Decodable {
    let user_name: String       // ✅ Your username
    let group_name: String      // ✅ Your group name
    let other_members: [String] // ✅ Array of the other 3 group members
}
