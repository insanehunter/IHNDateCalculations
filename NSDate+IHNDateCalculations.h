/*
 * (c) Sergei Cherepanov, 2012
 */
#import <Foundation/Foundation.h>

@interface NSDate (IHNDateCalculations)

#pragma mark - Comparison
- (BOOL) isEarlierThan:(NSDate *)anotherDate;
- (BOOL) isEqualOrEarlierThan:(NSDate *)anotherDate;
- (BOOL) isLaterThan:(NSDate *)anotherDate;
- (BOOL) isEqualOrLaterThan:(NSDate *)anotherDate;


#pragma mark - Ago
- (NSDate *) monthsAgo:(NSInteger)months;
- (NSDate *) monthAgo;

- (NSDate *) daysAgo:(NSInteger)days;
- (NSDate *) dayAgo;


#pragma mark - After
- (NSDate *) monthsAfter:(NSInteger)months;
- (NSDate *) monthAfter;

- (NSDate *) daysAfter:(NSInteger)days;
- (NSDate *) dayAfter;

@end
