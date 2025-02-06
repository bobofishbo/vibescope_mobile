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

struct Group: Decodable, Identifiable {
    let id: Int
    let group_name: String
    let user_id_1: UUID
    let user_id_2: UUID
    let user_id_3: UUID
    let user_id_4: UUID
}
