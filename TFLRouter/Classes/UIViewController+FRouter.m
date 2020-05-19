//
//  UIViewController+FRouter.m
//  TFBlue
//
//  Created by 范力升 on 2020/4/20.
//  Copyright © 2020 erge. All rights reserved.
//

#import "UIViewController+FRouter.h"

@implementation UIViewController (FRouter)

#pragma 跳转普通vc
//直接跳转
- (void)openAppViewController:(NSString *)viewController
{
    //如果没得paramsModel 跳转默认为push
    UIViewController *vc = [UIViewController getTargetViewController:viewController];
    if (!vc) return;
    [self pushViewController:(id)vc animated:YES];
    
}

//直接跳转 带参数
- (void)openAppViewController:(NSString *)viewController params:(nonnull NSDictionary *)params
{
    //如果没得paramsModel 跳转默认为push
    UIViewController *vc = [UIViewController getTargetViewController:viewController];
    if (!vc) return;
    //设置参数
    [self setViewController:vc params:params];
    [self pushViewController:(id)vc animated:YES];
    
}

//自定义跳转
- (void)openAppViewController:(NSString *)viewController paramsModel:(FRouterParamsModel *)paramsModel
{
    UIViewController *vc = [UIViewController getTargetViewController:viewController];
     [self customPushViewController:vc paramsModel:paramsModel];
}

#pragma 跳转sb
- (void)openAppViewControllerWithStoryboardName:(NSString *)storyboardName identifier:(NSString *)identifier{
    UIViewController *vc = [UIViewController getViewControllerWithStoryboardName:storyboardName identifier:identifier];
    if (!vc) return;
    [self pushViewController:(id)vc animated:YES];
}

- (void)openAppViewControllerWithStoryboardName:(NSString *)storyboardName identifier:(NSString *)identifier params:(nonnull NSDictionary *)params{
    UIViewController *vc = [UIViewController getViewControllerWithStoryboardName:storyboardName identifier:identifier];
    if (!vc) return;
    [self setViewController:vc params:params];
    [self pushViewController:(id)vc animated:YES];
}

- (void)openAppViewControllerWithStoryboardName:(NSString *)storyboardName identifier:(NSString *)identifier paramsModel:(FRouterParamsModel *)paramsModel{
    UIViewController *vc = [UIViewController getViewControllerWithStoryboardName:storyboardName identifier:identifier];
    [self customPushViewController:vc paramsModel:paramsModel];
}

///自定义跳转
- (void)customPushViewController:(UIViewController *)viewController paramsModel:(FRouterParamsModel *)paramsModel{
    if (!viewController)return;
    
    //参数
    if (paramsModel.data!= nil) {
        [self setViewController:viewController params:paramsModel.data];
    }
    
    //跳转方式和动画参数
    bool animated = YES;
    animated = paramsModel.animated;
    
    //跳转
    if(paramsModel.jumpWay == JumpWay_PresentedViewController){
         [self presentViewController:viewController animated:animated completion:paramsModel.completion];
    }else{
        [self pushViewController:viewController animated:animated];
    }
}

//设置参数
- (void)setViewController:(UIViewController *)viewController params:(NSDictionary *)params{
    for (NSString *key in params) {
        id value = params[key];
        [viewController setValue:value forKey:key];
    }
}

//跳转判断空
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.navigationController == nil) {
        if (!([UIViewController jsd_findVisibleViewController].navigationController == nil)) {
            [[UIViewController jsd_findVisibleViewController].navigationController pushViewController:viewController animated:animated];
        }else{
            NSLog(@"导航控制器为nil======================%@",self);
        }
        
    }else{
        [[UIViewController jsd_findVisibleViewController].navigationController pushViewController:viewController animated:animated];
    }
}

#pragma present跳转
//presentView跳转控制器
- (void)presentViewController:(NSString * _Nonnull)viewController
                     animated:(BOOL)flag
                       params:(NSDictionary *__nullable)params
                   completion:(void (^__nullable)(void))completion{
    
    UIViewController *vc = [UIViewController getTargetViewController:viewController];
    if (!vc) {
        NSLog(@"跳转之前控制器生成失败");
        return;
    }
    [vc setViewController:vc params:params];
    [self presentViewController:vc animated:flag completion:completion];
}

- (void)presentrWithStoryboardName:(NSString * _Nonnull)storyboardName
                        identifier:(NSString * _Nonnull)identifier
                          animated:(BOOL)flag
                            params:(NSDictionary *__nullable)params
                        completion:(void (^__nullable)(void))completion{
    UIViewController *vc = [UIViewController getViewControllerWithStoryboardName:storyboardName identifier:identifier];
    if (!vc) {
        NSLog(@"跳转之前Storyboard控制器生成失败");
        return;
    }
    [vc setViewController:vc params:params];
    [self presentViewController:vc animated:flag completion:completion];
}

#pragma 获取控制器
//获取目标控制器
+ (UIViewController *)getTargetViewController:(NSString *)targetViewController
{
    if (targetViewController.length <= 0) return nil;

    Class targetClass = NSClassFromString(targetViewController);

    if (!targetClass) return nil;
    
    UIViewController * vc = [[targetClass alloc]init];
    if ([vc isKindOfClass:[UIViewController class]]) {
        
        return vc;
    }else{
        NSLog(@"传入路由控制器不是UIViewController或者不是FBViewController子类");
        return nil;
    }

}
#pragma 获取根控制器
+ (UIViewController *)jsd_getRootViewController{

    UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
    return window.rootViewController;
}

+ (UIViewController *)jsd_findVisibleViewController {
    
    UIViewController* currentViewController = [self jsd_getRootViewController];

    BOOL runLoopFind = YES;
    while (runLoopFind) {
        if (currentViewController.presentedViewController) {
            currentViewController = currentViewController.presentedViewController;
        } else {
            if ([currentViewController isKindOfClass:[UINavigationController class]]) {
                currentViewController = ((UINavigationController *)currentViewController).visibleViewController;
            } else if ([currentViewController isKindOfClass:[UITabBarController class]]) {
                currentViewController = ((UITabBarController* )currentViewController).selectedViewController;
            } else {
                break;
            }
        }
    }
    
    return currentViewController;
}

///获取StoryboardViewController
+ (UIViewController * )getViewControllerWithStoryboardName:(NSString *)storyboardName identifier:(NSString *)identifier{
     UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
     UIViewController  *vc = [storyboard instantiateViewControllerWithIdentifier:identifier];
     return vc;
}


@end
