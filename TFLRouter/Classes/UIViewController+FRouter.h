//
//  UIViewController+FRouter.h
//  TFBlue
//
//  Created by 范力升 on 2020/4/20.
//  Copyright © 2020 erge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FRouterParamsModel.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (FRouter)

#pragma 获取控制器
+ (UIViewController * )getViewControllerWithStoryboardName:(NSString *)storyboardName identifier:(NSString *)identifier;
/// 根据名字获取控制器
/// @param targetViewController 目标控制器的民资
+ (UIViewController *)getTargetViewController:(NSString *)targetViewController;
+ (UIViewController *)jsd_findVisibleViewController;

#pragma 跳转
/// 方式 :push 动画 :YES
///@param viewController 目标控制器名字
- (void)openAppViewController:(NSString * _Nonnull)viewController;

/// 方式 :push
/// 动画 :YES
/// @param viewController 目标控制器名字
/// @param params 目标控制器的参数
- (void)openAppViewController:(NSString * _Nonnull)viewController params:(NSDictionary *_Nonnull)params;


/// 自定义跳转
/// @param viewController 目标控制器
/// @param paramsModel 跳转的参数、方式、动画、回调
- (void)openAppViewController:(NSString * _Nonnull)viewController paramsModel:(FRouterParamsModel * _Nonnull)paramsModel;

/// 方式 :push
/// 动画 :YES
/// @param storyboardName 控制器名字
/// @param identifier Storyboard中ViewController标识
- (void)openAppViewControllerWithStoryboardName:(NSString *)storyboardName identifier:(NSString * _Nonnull)identifier;

/// 方式 :push
/// 动画 :YES
/// @param storyboardName 控制器名字
/// @param identifier Storyboard中ViewController标识
/// @param params 目标控制器的参数
- (void)openAppViewControllerWithStoryboardName:(NSString * _Nonnull)storyboardName identifier:(NSString * _Nonnull)identifier params:(NSDictionary * _Nonnull)params;

/// 方式 :push
/// 动画 :YES
/// @param storyboardName 控制器名字
/// @param paramsModel 跳转的参数、方式、动画、回调
- (void)openAppViewControllerWithStoryboardName:(NSString * _Nonnull)storyboardName identifier:(NSString * _Nonnull)identifier paramsModel:(FRouterParamsModel * _Nonnull)paramsModel;



/// present跳转
/// @param viewController 目标控制器名字
/// @param flag 动画
/// @param params 参数
/// @param completion 完成回调
- (void)presentViewController:(NSString * _Nonnull)viewController
                     animated:(BOOL)flag
                       params:(NSDictionary *  __nullable)params
                   completion:(void (^__nullable)(void))completion;

/// present跳转
/// @param storyboardName storyboardName
/// @param identifier 标控制器标识
/// @param flag 动画
/// @param params 参数
/// @param completion 完成回调
- (void)presentrWithStoryboardName:(NSString * _Nonnull)storyboardName
                        identifier:(NSString * _Nonnull)identifier
                          animated:(BOOL)flag
                            params:(NSDictionary * __nullable)params
                        completion:(void (^__nullable)(void))completion;

@end

NS_ASSUME_NONNULL_END
