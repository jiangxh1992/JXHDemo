//
//  NSString+Extension.m
//  smh
//
//  Created by hj on 15/10/19.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
/**
 *  根据文字字体和最大尺寸计算文字宽高
 */

- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    // 获得系统版本
    if (IOS7) {
        NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
        return [self boundingRectWithSize:maxSize options:options attributes:attrs context:nil].size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        return [self sizeWithFont:font constrainedToSize:maxSize];
#pragma clang diagnostic pop
        
    }
}

- (CGSize)sizeWithFont:(UIFont *)font
{
    return [self sizeWithFont:font maxW:MAXFLOAT];
}

/**
 *  拼接文件名
 */
- (NSString *)fileNameAppend:(NSString *)appendString
{
    // 1 没有扩展名的文件名
    NSString *filename = [self stringByDeletingPathExtension];
    // 2 拼接
    filename = [filename stringByAppendingString:appendString];
    // 3 扩展名
    NSString *extension = [self pathExtension];
    // 4 新文件名
    if ([extension isEqualToString:@""])
    {
        return filename;
    }
    return [filename stringByAppendingPathExtension:extension];
}

/**
 *  plist文件在mainBundle中的路径
 */
+ (NSString *)pathForResource:(NSString *)resource
{
    if ([resource hasSuffix:@".plist"])
    {
        return [[NSBundle mainBundle] pathForResource:resource ofType:nil];
    }
    return [[NSBundle mainBundle] pathForResource:resource ofType:@"plist"];
}

/**
 *  去空格
 */
- (NSString *)trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

/**
 *  本地化文字
 */
- (NSString *)localizedString
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"zh-Hans" ofType:@"lproj"];
    NSBundle *languageBundle = [NSBundle bundleWithPath:path];
    return [languageBundle localizedStringForKey:self value:@"" table:nil];
    //return NSLocalizedString(self, nil);
}


/**
 *  手机号码验证
 */
- (BOOL)validateMobile
{
    NSString * MOBILE = @"^1\\d{10}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:self];
}

/**
 *  是否纯数字
 */
- (BOOL)validateNumber
{
    NSString *number = @"^[0-9]*$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", number];
    if ([regextestmobile evaluateWithObject:self] == YES)
    {
        return YES;
    }
    return NO;
}

/**
 * 功能:判断是否在地区码内
 * 参数:地区码
 */
- (BOOL)areaCode:(NSString *)code
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"北京" forKey:@"11"];
    [dic setObject:@"天津" forKey:@"12"];
    [dic setObject:@"河北" forKey:@"13"];
    [dic setObject:@"山西" forKey:@"14"];
    [dic setObject:@"内蒙古" forKey:@"15"];
    [dic setObject:@"辽宁" forKey:@"21"];
    [dic setObject:@"吉林" forKey:@"22"];
    [dic setObject:@"黑龙江" forKey:@"23"];
    [dic setObject:@"上海" forKey:@"31"];
    [dic setObject:@"江苏" forKey:@"32"];
    [dic setObject:@"浙江" forKey:@"33"];
    [dic setObject:@"安徽" forKey:@"34"];
    [dic setObject:@"福建" forKey:@"35"];
    [dic setObject:@"江西" forKey:@"36"];
    [dic setObject:@"山东" forKey:@"37"];
    [dic setObject:@"河南" forKey:@"41"];
    [dic setObject:@"湖北" forKey:@"42"];
    [dic setObject:@"湖南" forKey:@"43"];
    [dic setObject:@"广东" forKey:@"44"];
    [dic setObject:@"广西" forKey:@"45"];
    [dic setObject:@"海南" forKey:@"46"];
    [dic setObject:@"重庆" forKey:@"50"];
    [dic setObject:@"四川" forKey:@"51"];
    [dic setObject:@"贵州" forKey:@"52"];
    [dic setObject:@"云南" forKey:@"53"];
    [dic setObject:@"西藏" forKey:@"54"];
    [dic setObject:@"陕西" forKey:@"61"];
    [dic setObject:@"甘肃" forKey:@"62"];
    [dic setObject:@"青海" forKey:@"63"];
    [dic setObject:@"宁夏" forKey:@"64"];
    [dic setObject:@"新疆" forKey:@"65"];
    [dic setObject:@"台湾" forKey:@"71"];
    [dic setObject:@"香港" forKey:@"81"];
    [dic setObject:@"澳门" forKey:@"82"];
    [dic setObject:@"国外" forKey:@"91"];
    
    if ([dic objectForKey:code] == nil)
    {
        return NO;
    }
    
    return YES;
}

/**
 * 功能:验证身份证是否合法
 * 参数:输入的身份证号
 */
-(BOOL) validateIdentityCard
{
    //判断位数
    if ([self length] != 15 && [self length] != 18) {
        return NO;
    }
    NSString *carid = self;
    
    long lSumQT =0;
    
    //加权因子
    int R[] ={7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };
    
    //校验码
    unsigned char sChecker[11]={'1','0','X', '9', '8', '7', '6', '5', '4', '3', '2'};
    
    
    //将15位身份证号转换成18位
    NSMutableString *mString = [NSMutableString stringWithString:self];
    
    if ([self length] == 15)
    {
        [mString insertString:@"19" atIndex:6];
        long p = 0;
        
        const char *pid = [mString UTF8String];
        
        for (int i=0; i<=16; i++)
        {
            p += (pid[i]-48) * R[i];
        }
        
        int o = p%11;
        NSString *string_content = [NSString stringWithFormat:@"%c",sChecker[o]];
        [mString insertString:string_content atIndex:[mString length]];
        carid = mString;
    }
    
    //判断地区码
    NSString * sProvince = [carid substringToIndex:2];
    
    if (![self areaCode:sProvince])
    {
        return NO;
    }
    
    //判断年月日是否有效
    //年份
    int strYear = [[carid substringWithRange:NSMakeRange(6,4)] intValue];
    //月份
    int strMonth = [[carid substringWithRange:NSMakeRange(10,2)] intValue];
    //日
    int strDay = [[carid substringWithRange:NSMakeRange(12,2)] intValue];
    
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeZone:localZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d 12:01:01",strYear,strMonth,strDay]];
    if (date == nil) {
        return NO;
    }
    const char *PaperId  = [carid UTF8String];
    
    //检验长度
    if( 18 != strlen(PaperId)) return -1;
    
    //校验数字
    for (int i=0; i<18; i++)
    {
        if ( !isdigit(PaperId[i]) && !(('X' == PaperId[i] || 'x' == PaperId[i]) && 17 == i) )
        {
            return NO;
        }
    }
    
    //验证最末的校验码
    for (int i=0; i<=16; i++)
    {
        lSumQT += (PaperId[i]-48) * R[i];
    }
    
    if (sChecker[lSumQT%11] != PaperId[17] )
    {
        return NO;
    }
    return YES;
}

/**
 *  NSString转json字符串
 */
+ (NSString *)jsonStringWithString:(NSString *)string
{
    return [NSString stringWithFormat:@"\"%@\"",
            [[string stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"] stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""]
            ];
}

/**
 *  NSArray转json字符串
 */
+ (NSString *)jsonStringWithArray:(NSArray *)array
{
    NSMutableString *reString = [NSMutableString string];
    [reString appendString:@"["];
    NSMutableArray *values = [NSMutableArray array];
    for (id valueObj in array)
    {
        NSString *value = [NSString jsonStringWithObject:valueObj];
        if (value)
        {
            [values addObject:[NSString stringWithFormat:@"%@",value]];
        }
    }
    [reString appendFormat:@"%@",[values componentsJoinedByString:@","]];
    [reString appendString:@"]"];
    return reString;
}

/**
 *  NSDictionary转json字符串
 */
+ (NSString *)jsonStringWithDictionary:(NSDictionary *)dictionary
{
    NSArray *keys = [dictionary allKeys];
    NSMutableString *reString = [NSMutableString string];
    [reString appendString:@"{"];
    NSMutableArray *keyValues = [NSMutableArray array];
    for (int i = 0; i < [keys count]; i++)
    {
        NSString *name = [keys objectAtIndex:i];
        id valueObj = [dictionary objectForKey:name];
        NSString *value = [NSString jsonStringWithObject:valueObj];
        if (value)
        {
            [keyValues addObject:[NSString stringWithFormat:@"\"%@\":%@",name,value]];
        }
    }
    [reString appendFormat:@"%@",[keyValues componentsJoinedByString:@","]];
    [reString appendString:@"}"];
    return reString;
}

/**
 *  NSObject转json字符串
 */
+ (NSString *)jsonStringWithObject:(id)object
{
    NSString *value = nil;
    if (!object)
    {
        return value;
    }
    if ([object isKindOfClass:[NSString class]])
    {
        value = [NSString jsonStringWithString:object];
    }
    else if([object isKindOfClass:[NSDictionary class]])
    {
        value = [NSString jsonStringWithDictionary:object];
    }
    else if([object isKindOfClass:[NSArray class]])
    {
        value = [NSString jsonStringWithArray:object];
    }
    else if([object isKindOfClass:[NSNumber class]])
    {
        value = [NSString jsonStringWithString:[object description]];
    }
    return value;
}

/**
 *  根据区号返回城市名称
 */
- (NSString *)cityName
{
    NSArray *cityArray = [NSArray arrayWithContentsOfFile:[NSString pathForResource:@"city"]];
    
    for (NSDictionary *dict in cityArray)
    {
        NSArray *cities = dict[@"cities"];
        for (NSDictionary *d in cities)
        {
            NSString *city = d[@"city"];
            NSString *code = d[@"code"];
            
            if ([code isEqualToString:self])
            {
                if ([city isEqualToString:dict[@"province"]])
                {
                    return dict[@"province"];
                }
                return [NSString stringWithFormat:@"%@ %@",dict[@"province"],city];
            }
        }
    }
    
    return @"未知";
}

@end