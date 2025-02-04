//
//  Supabase.swift
//  vibescope_mobile_v1
//
//  Created by XIE BO on 2025/2/4.
//

import Supabase
import Foundation


let supabase = SupabaseClient(
  supabaseURL: URL(string: "https://uuyadwuwwbppwgepnsxt.supabase.co")!,
  supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InV1eWFkd3V3d2JwcHdnZXBuc3h0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzg2NDQ2NTAsImV4cCI6MjA1NDIyMDY1MH0.IPZCq76lC6elxz5BsuT0XBY5aqykyowZICm1QKOfibE"
)

struct Group: Decodable, Identifiable {
    let id: Int
    let group_name: String
    let user_id_1: UUID
    let user_id_2: UUID
    let user_id_3: UUID
    let user_id_4: UUID
    
    
}
