/*
 * (c) Sergei Cherepanov, 2012
 */
#import <Foundation/Foundation.h>

@interface NSDate (IHNDateCalculations)

- (NSDate *) monthsAgo:(NSInteger)months;
- (NSDate *) monthAgo;

- (NSDate *) daysAgo:(NSInteger)days;
- (NSDate *) dayAgo;


- (NSDate *) monthsAfter:(NSInteger)months;
- (NSDate *) monthAfter;

- (NSDate *) daysAfter:(NSInteger)days;
- (NSDate *) dayAfter;

@end
