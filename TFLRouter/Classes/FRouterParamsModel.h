//
//  FRouterParamsModel.h
//  TFBlue
//
//  Created by 范力升 on 2020/4/20.
//  Copyright © 2020 erge. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum : NSUInteger {
    JumpWay_PushViewController,
    JumpWay_PresentedViewController,
} JumpWay;
NS_ASSUME_NONNULL_BEGIN

@interface FRouterParamsModel : NSObject
@property (nonatomic , strong ,readonly)  NSDictionary * data;
@property (nonatomic , assign ,readonly)  JumpWay jumpWay;
@property (nonatomic , assign ,readonly)  BOOL animated;
@property (nonatomic , copy ,readonly)  void (^completion)(void);
/// 便利构造
/// @param data 参数
/// @param jumpWay 跳转方式
/// @param animated 动画
/// @param completion PresentedViewController 完成的回调
- (instancetype)initWithData:(NSDictionary *_Nonnull)data jumpWay:(JumpWay )jumpWay animated:(BOOL)animated completion:(void (^ __nullable)(void))completion;
@end

NS_ASSUME_NONNULL_END
