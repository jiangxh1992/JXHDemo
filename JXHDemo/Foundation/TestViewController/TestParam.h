//
//  TestParam.h
//  JXHDemo
//
//  Created by 919575700@qq.com on 12/13/15.
//  Copyright © 2015 Jiangxh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestParam : NSObject

@property (nonatomic, copy)NSString *hospital;
@property (nonatomic, copy)NSString *doctorNumber;
/**
 *  疾病的id
 */
@property (nonatomic, copy)NSString *diseaseId;

/**
 *  疾病名称
 */
@property (nonatomic, copy)NSString *diseaseName;

/**
 *  患者id
 */
@property (nonatomic, copy)NSString *patientId;

/**
 *  更改后的分组id
 */
@property (nonatomic, copy)NSString *selectedDiseaseId;

@end
