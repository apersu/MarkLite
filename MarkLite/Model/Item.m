//
//  Item.m
//  HtmlPlus
//
//  Created by zhubch on 15-4-1.
//  Copyright (c) 2015年 zhubch. All rights reserved.
//

#import "Item.h"

@implementation Item
{
    Item *last;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.children = [NSMutableArray array];
    }
    return self;
}

- (NSArray*)itemsCanReach
{
    NSMutableArray *ret = [NSMutableArray array];
    
    if (self.open) {
        for (Item *i in self.children) {
            [ret addObject:i];
            [ret addObjectsFromArray:i.itemsCanReach];
        }
    }
    
    return ret;
}

- (void)setParent:(Item *)parent
{
    _parent = parent;
    _deep = self.parent.deep + 1;
}

- (void)setName:(NSString *)name
{
    _name = name;
    _folder = ![name containsString:@"."];
}

- (void)addChild:(Item *)item
{
    if (last != nil && [item.name hasPrefix:last.name]) {
        [last addChild:item];
        return;
    }
    
    item.parent = self;
    [self.children addObject:item];
    last = item;
}

- (BOOL)isEqual:(Item *)object
{
    return [self.name isEqualToString:object.name];
}

- (void)removeFromParent
{
    [_parent.children removeObject:self];
    _parent = nil;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@:%@",self.name,self.children];
}

@end