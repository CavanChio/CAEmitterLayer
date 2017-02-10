//
//  ViewController.m
//  CAEmitterLayer
//
//  Created by Cavan on 2017/2/10.
//  Copyright © 2017年 CavanZhao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) CAEmitterLayer *caELayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupEmitterLayer];
}

- (void)setupEmitterLayer {
    self.view.backgroundColor = [UIColor blackColor];
    //初始化发射源
    self.caELayer = [CAEmitterLayer layer];
    self.caELayer.emitterPosition = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height - 50);
    //发射源尺寸大小
    self.caELayer.emitterSize = CGSizeMake(50, 0);
    //发射源模式
    self.caELayer.emitterMode = kCAEmitterLayerOutline;
    //发射源的形状
    self.caELayer.emitterShape = kCAEmitterLayerLine;
    //渲染模式
    self.caELayer.renderMode = kCAEmitterLayerAdditive;
    //发射方向
    self.caELayer.velocity = 1;
    //随机产生粒子
    self.caELayer.seed = (arc4random() % 100) + 1;
    
    //初始化粒子
    CAEmitterCell *cell = [CAEmitterCell emitterCell];
    //速率
    cell.birthRate = 1.0;
    //发射角度
    cell.emissionRange = 0.11 * M_PI;
    //速度
    cell.velocity = 300;
    //范围
    cell.velocityRange = 150;
    // Y轴 加速度分量
    cell.yAcceleration = 75;
    //生命周期
    cell.lifetime = 2.04;
    //是个CGImageRef的对象,既粒子要展现的图片
    cell.contents = (id)[[UIImage imageNamed:@"FFRing"] CGImage];
    //缩放比例
    cell.scale = 0.2;
    //粒子的颜色
    cell.color = [[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0] CGColor];
    // 一个粒子的颜色green 能改变的范围
    cell.greenRange = 1.0;
    // 一个粒子的颜色red 能改变的范围
    cell.redRange = 1.0;
    // 一个粒子的颜色blue 能改变的范围
    cell.blueRange = 1.0;
    
    // 子旋转角度范围
    cell.spinRange = M_PI;
    
    // 爆炸
    CAEmitterCell *burst = [CAEmitterCell emitterCell];
    // 粒子产生系数
    burst.birthRate = 1.0;
    // 速度
    burst.velocity = 0;
    // 缩放比例
    burst.scale = 2.5;
    // shifting粒子red在生命周期内的改变速度
    burst.redSpeed = -1.5;
    // shifting粒子blue在生命周期内的改变速度
    burst.blueSpeed = +1.5;
    // shifting粒子green在生命周期内的改变速度
    burst.greenSpeed = +1.0;
    //生命周期
    burst.lifetime = 0.35;
    
    // 火花 and finally, the sparks
    CAEmitterCell *spark = [CAEmitterCell emitterCell];
    //粒子产生系数，默认为1.0
    spark.birthRate = 400;
    //速度
    spark.velocity = 125;
    // 360 deg//周围发射角度
    spark.emissionRange = 2 * M_PI;
    // gravity//y方向上的加速度分量
    spark.yAcceleration = 75;
    //粒子生命周期
    spark.lifetime = 3;
    //是个CGImageRef的对象,既粒子要展现的图片
    spark.contents = (id)[[UIImage imageNamed:@"FFTspark"] CGImage];
    //缩放比例速度
    spark.scaleSpeed = -0.2;
    //粒子green在生命周期内的改变速度
    spark.greenSpeed = -0.1;
    //粒子red在生命周期内的改变速度
    spark.redSpeed = 0.4;
    //粒子blue在生命周期内的改变速度
    spark.blueSpeed = -0.1;
    //粒子透明度在生命周期内的改变速度
    spark.alphaSpeed = -0.25;
    //子旋转角度
    spark.spin = 2* M_PI;
    //子旋转角度范围
    spark.spinRange = 2* M_PI;
    
    self.caELayer.emitterCells = [NSArray arrayWithObject:cell];
    cell.emitterCells = [NSArray arrayWithObjects:burst, nil];
    burst.emitterCells = [NSArray arrayWithObject:spark];
    [self.view.layer addSublayer:self.caELayer];
}


///**
// *  开始动画
// */
//- (void)animation {
//    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
//    if (self.selected) {
//        animation.values = @[@1.5 ,@0.8, @1.0,@1.2,@1.0];
//        animation.duration = 0.5;
//        [self startAnimate];
//    }else
//    {
//        animation.values = @[@0.8, @1.0];
//        animation.duration = 0.4;
//    }
//    animation.calculationMode = kCAAnimationCubic;
//    [self.layer addAnimation:animation forKey:@"transform.scale"];
//}
//
///**
// *  开始喷射
// */
//- (void)startAnimate {
//    //chareLayer开始时间
//    self.chargeLayer.beginTime = CACurrentMediaTime();
//    //chareLayer每秒喷射的80个
//    [self.chargeLayer setValue:@80 forKeyPath:@"emitterCells.charge.birthRate"];
//    //进入下一个动作
//    [self performSelector:@selector(explode) withObject:nil afterDelay:0.2];
//}
//
///**
// *  大量喷射
// */
//- (void)explode {
//    //让chareLayer每秒喷射的个数为0个
//    [self.chargeLayer setValue:@0 forKeyPath:@"emitterCells.charge.birthRate"];
//    //explosionLayer开始时间
//    self.explosionLayer.beginTime = CACurrentMediaTime();
//    //explosionLayer每秒喷射的2500个
//    [self.explosionLayer setValue:@2500 forKeyPath:@"emitterCells.explosion.birthRate"];
//    //停止喷射
//    [self performSelector:@selector(stop) withObject:nil afterDelay:0.1];
//}
//
///**
// *  停止喷射
// */
//- (void)stop {
//    //让chareLayer每秒喷射的个数为0个
//    [self.chargeLayer setValue:@0 forKeyPath:@"emitterCells.charge.birthRate"];
//    //explosionLayer每秒喷射的0个
//    [self.explosionLayer setValue:@0 forKeyPath:@"emitterCells.explosion.birthRate"];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
