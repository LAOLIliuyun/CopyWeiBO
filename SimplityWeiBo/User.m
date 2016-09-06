//
//  User.m
//  SimplityWeiBo
//
//  Created by Macx on 16/8/10.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "User.h"
static User *user = nil;
@implementation User
+(id)shareUser{
    if (!user) {
        user = [User new];
    }return user;
}
+(NSDictionary *)modelCustomPropertyMapper{
    return @{@"uid":@"id",@"userClass":@"class",@"userDescription":@"description"};
}
@end

@implementation UserStatus

+(NSDictionary *)modelCustomPropertyMapper{
    return @{@"statusID":@"id"};
}

@end




