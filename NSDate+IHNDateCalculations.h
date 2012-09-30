/*
 * (c) Sergei Cherepanov, 2012
 */
#import <Foundation/Foundation.h>

@interface NSDate (IHNDateCalculations)

- (NSDate *) monthsAgo:(NSInteger)months;
- (NSDate *) monthAgo;

@end
