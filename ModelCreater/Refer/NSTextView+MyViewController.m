//
//  NSTextView+MyViewController.m
//  AutoCode
//
//  Created by Sundear on 2017/8/22.
//  Copyright © 2017年 xiexin. All rights reserved.
//
#define TabWidth @"TabWidth"


#import "NSTextView+MyViewController.h"

@implementation NSTextView (MyViewController)


- (NSDictionary *)defaultTextAttributes:(BOOL)forRichText {
    static NSParagraphStyle *defaultRichParaStyle = nil;
    NSMutableDictionary *textAttributes = [[NSMutableDictionary alloc] initWithCapacity:2];
    if (forRichText) {
        [textAttributes setObject:[NSFont userFontOfSize:0.0] forKey:NSFontAttributeName];
        if (defaultRichParaStyle == nil) {  // We do this once...
            NSInteger cnt;
            NSString *measurementUnits = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleMeasurementUnits"];
            CGFloat tabInterval = ([@"Centimeters" isEqual:measurementUnits]) ? (72.0 / 2.54) : (72.0 / 2.0);  // Every cm or half inch
            NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
            [paraStyle setTabStops:[NSArray array]];    // This first clears all tab stops
            for (cnt = 0; cnt < 12; cnt++) {    // Add 12 tab stops, at desired intervals...
                NSTextTab *tabStop = [[NSTextTab alloc] initWithType:NSLeftTabStopType location:tabInterval * (cnt + 1)];
                [paraStyle addTabStop:tabStop];

            }
            defaultRichParaStyle = [paraStyle copy];
        }
        [textAttributes setObject:defaultRichParaStyle forKey:NSParagraphStyleAttributeName];
    } else {
        NSFont *plainFont = [NSFont userFixedPitchFontOfSize:0.0];
        NSInteger tabWidth = [[NSUserDefaults standardUserDefaults] integerForKey:TabWidth];
        CGFloat charWidth = [@" " sizeWithAttributes:[NSDictionary dictionaryWithObject:plainFont forKey:NSFontAttributeName]].width;
        if (charWidth == 0) charWidth = [[plainFont screenFontWithRenderingMode:NSFontDefaultRenderingMode] maximumAdvancement].width;

        // Now use a default paragraph style, but with the tab width adjusted
        NSMutableParagraphStyle *mStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        [mStyle setTabStops:[NSArray array]];
        [mStyle setDefaultTabInterval:(charWidth * tabWidth)];
        [textAttributes setObject:[mStyle copy] forKey:NSParagraphStyleAttributeName];

        // Also set the font
        [textAttributes setObject:plainFont forKey:NSFontAttributeName];
    }
    return textAttributes;
}

/* Used when converting to plain text
 */
- (void)removeAttachments {
    NSTextStorage *attrString = [self textStorage];
    NSUInteger loc = 0;
    NSUInteger end = [attrString length];
    [attrString beginEditing];
    while (loc < end) { /* Run through the string in terms of attachment runs */
        NSRange attachmentRange;    /* Attachment attribute run */
        NSTextAttachment *attachment = [attrString attribute:NSAttachmentAttributeName atIndex:loc longestEffectiveRange:&attachmentRange inRange:NSMakeRange(loc, end-loc)];
        if (attachment) {   /* If there is an attachment and it is on an attachment character, remove the character */
            unichar ch = [[attrString string] characterAtIndex:loc];
            if (ch == NSAttachmentCharacter) {
                if ([self shouldChangeTextInRange:NSMakeRange(loc, 1) replacementString:@""]) {
                    [attrString replaceCharactersInRange:NSMakeRange(loc, 1) withString:@""];
                    [self didChangeText];
                }
                end = [attrString length];  /* New length */
            }
            else loc++; /* Just skip over the current character... */
        }
        else loc = NSMaxRange(attachmentRange);
    }
    [attrString endEditing];
}

- (void)setRichText:(BOOL)flag {
    NSDictionary *textAttributes;

    BOOL isRichText = flag;

    if (!isRichText) [self removeAttachments];

    [self setRichText:isRichText];
    [self setUsesRuler:isRichText];    /* If NO, this correctly gets rid
                                               of the ruler if it was up */
    if (isRichText && NO)
        [self setRulerVisible:YES];    /* Show ruler if rich, and desired */
    [self setImportsGraphics:isRichText];

    textAttributes = [self defaultTextAttributes:isRichText];

    if ([[self textStorage] length]) {
        [[self textStorage] setAttributes:textAttributes range: NSMakeRange(0,[[self textStorage] length])];
    }
    [self setTypingAttributes:textAttributes];
}
@end
