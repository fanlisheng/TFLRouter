//
//  FRouterParamsModel.m
//  TFBlue
//
//  Created by 范力升 on 2020/4/20.
//  Copyright © 2020 erge. All rights reserved.
//

#import "FRouterParamsModel.h"

@interface FRouterParamsModel()

@end

@implementation FRouterParamsModel

- (instancetype)initWithData:(NSDictionary *)data jumpWay:(JumpWay)jumpWay animated:(BOOL)animated completion:(void (^ __nullable)(void))completion{
    self = [super init];
    if (self) {
        _data = data;
        _jumpWay = jumpWay;
        _animated = animated;
        _completion = completion;
    }
    return self;
}

@end
