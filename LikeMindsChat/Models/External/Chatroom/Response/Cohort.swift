//
//  Cohort.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 11/01/24.
//

import Foundation

class Cohort {
    private var id: Int?
    private var totalMembers: Int?
    private var name: String?
    private var members: [Member]?
    
    private init(id: Int?, totalMembers: Int?, name: String?, members: [Member]?) {
        self.id = id
        self.totalMembers = totalMembers
        self.name = name
        self.members = members
    }
    
    class Builder {
        private var id: Int?
        private var totalMembers: Int?
        private var name: String?
        private var members: [Member]?
        
        func id(_ id: Int?) -> Builder {
            self.id = id
            return self
        }
        
        func totalMembers(_ totalMembers: Int?) -> Builder {
            self.totalMembers = totalMembers
            return self
        }
        
        func name(_ name: String?) -> Builder {
            self.name = name
            return self
        }
        
        func members(_ members: [Member]?) -> Builder {
            self.members = members
            return self
        }
        
        func build() -> Cohort {
            return Cohort(id: id, totalMembers: totalMembers, name: name, members: members)
        }
    }
    
    func toBuilder() -> Builder {
        return Builder()
            .id(id)
            .totalMembers(totalMembers)
            .name(name)
            .members(members)
    }
}
