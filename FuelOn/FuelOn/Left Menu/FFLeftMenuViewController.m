//
//  FFLeftMenuViewController.m
//  FabFurnish
//
//  Created by Amit Kumar on 08/05/15.
//  Copyright (c) 2015 Bluerock eServices Pvt Ltd. All rights reserved.
//

#import "FFLeftMenuViewController.h"
#import "HomeViewController.h"

#import "RESideMenu.h"
#import "UIViewController+RESideMenu.h"


@interface FFLeftMenuViewController ()

@end

@implementation FFLeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    cellIdentifier = [self stringCellIdentifier];
//    [self addHeaderAndImage];
//    [self setDataModels];
//    [self customizeSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    [self customizeNavigation];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark- TableView Datasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"menuCell";
    
    UITableViewCell *leftMenuCell  = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
//    if (leftMenuCell == nil) {
//        leftMenuCell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//    }
    
    UIImageView *menuIcon = (UIImageView*)[leftMenuCell viewWithTag:120];
    UILabel *menuTitle = (UILabel*)[leftMenuCell viewWithTag:121];

    switch (indexPath.row)
    {
        case 0:
        {
            menuTitle.text = @"My Profile";
            //menuIcon.image = [UIImage imageNamed:@""];
        }
            break;
            
        case 1:
        {
            menuTitle.text = @"My Favourites";
            //menuIcon.image = [UIImage imageNamed:@""];
        }
            break;
            
        case 2:
        {
            menuTitle.text = @"Credit Cards/Payments";
            //menuIcon.image = [UIImage imageNamed:@""];
        }
            break;
        case 3:
        {
            menuTitle.text = @"Invite Friends";
            //menuIcon.image = [UIImage imageNamed:@""];
        }
            break;
        case 4:
        {
            menuTitle.text = @"Contact Us";
            //menuIcon.image = [UIImage imageNamed:@""];
        }
            break;
         
        case 5:
        {
            menuTitle.text = @"Help";
            //menuIcon.image = [UIImage imageNamed:@""];
        }
            break;

        default:
        {
            
        }
            break;
    }

    return leftMenuCell;
}


#pragma mark- TableView Delegate

/*- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
 if (self.isRoot) { // This case gets executed if root category
 
 FFLeftMenuCell *cell = (FFLeftMenuCell *)[tableView cellForRowAtIndexPath:indexPath];
 
 switch (indexPath.section) {
 case eSectionLeftMenuNew:
 {
 FFCategoriesNew *newC = [newData objectAtIndex:indexPath.row];
 [self openWebViewControllerWithData:newC.url header:newC.pageName];
 [self.sideMenuViewController hideMenuViewController];
 }
 break;
 
 case eSectionLeftMenuData:
 {
 FFCategoriesData *dataModel = [cell getModel];
 if ([cell haveSubMenu]) {
 NSArray *arrayData = ((FFCategoriesData *)[self.categoryData objectAtIndex:indexPath.row]).children;
 [self openSubMenuWithTitle:dataModel.name arrayData:arrayData];
 }
 else {
 // This case gets executed if root category has no submenus at all.
 
 // Sending event stats to Google Analytics
 [SharedUtility addAnalyticsEventWithScreen:@"CategoriesMenu"
 WithCategoryName:@"MainMenu"
 withActionName:@"Navigation"
 withLabelInfo:[NSString stringWithFormat:@"cat-name: %@",dataModel.name]];
 
 // data model must have a valid Product Catalog url.
 [self openCatalogueControllerWithData:dataModel.apiUrl];
 }
 }
 break;
 
 case eSectionLeftMenuOthers:
 {
 FFCategoriesOther *others = [othersData objectAtIndex:indexPath.row];
 [self openWebViewControllerWithData:others.url header:others.pageName]; // others data model must have a valid WebView layout type url.
 
 [self.sideMenuViewController hideMenuViewController];
 }
 break;
 
 case eSectionLeftMenuMore:
 {
 if (moreData.count) {
 [self openSubMenuWithTitle:@"More" arrayData:moreData];
 }
 }
 break;
 
 default:
 break;
 }
 }
 else { // SubMenu Case Execution
 
 FFLeftSubMenuCell *cell = (FFLeftSubMenuCell *)[tableView cellForRowAtIndexPath:indexPath];
 if ([[self.categoryData firstObject] isKindOfClass:[FFCategoriesChildren class]])
 {
 FFCategoriesChildren *dataModel = [cell getModel];
 if ([cell haveSubMenu]) {
 NSArray *arrayData = ((FFCategoriesData *)[self.categoryData objectAtIndex:indexPath.row]).children;
 [self openSubMenuWithTitle:dataModel.name arrayData:arrayData];
 }
 else { // Open the destined UI layout
 
 // Sending event stats to Google Analytics
 [SharedUtility addAnalyticsEventWithScreen:@"CategoriesMenu"
 WithCategoryName:@"MainMenu"
 withActionName:@"Navigation"
 withLabelInfo:[NSString stringWithFormat:@"cat-name: %@",dataModel.name]];
 
 if (   [dataModel.pageLayout isEqualToString:kFFFabIdeasLayout]
 || [dataModel.pageLayout isEqualToString:kFFFabAdviceLayout]
 || [dataModel.pageLayout isEqualToString:kFFCuratorsLayout]
 || [dataModel.pageLayout isEqualToString:kFFIdeaBookLayout] )  {
 //GOTO: D&I module
 [self openDesignInspirationWithDataModel:dataModel];
 }
 else  // data model must have a valid Product Catalog url.
 [self openCatalogueControllerWithData:dataModel.apiUrl];
 
 [self.sideMenuViewController hideMenuViewController];
 DDLogDebug(@"%@",dataModel);
 }
 }
 else if([[self.categoryData firstObject] isKindOfClass:[FFCategoriesMore class]]){
 FFCategoriesMore *more = [self.categoryData objectAtIndex:indexPath.row];
 
 // Sending event stats to Google Analytics
 [SharedUtility addAnalyticsEventWithScreen:@"CategoriesMenu"
 WithCategoryName:@"MainMenu"
 withActionName:@"Navigation"
 withLabelInfo:[NSString stringWithFormat:@"cat-name: %@",more.pageName]];
 
 [self openCatalogueControllerWithData:more.url]; // more data model must have a valid Product Catalog url.
 [self.sideMenuViewController hideMenuViewController];
 DDLogDebug(@"%@",more);
 }
 }
 }
 */

#pragma mark- Private Methods

//-(void) addHeaderAndImage{
//    //if (self.isRoot) {
//        arrayHeaderImage = [NSMutableArray new];
//        [arrayHeaderImage addObject:[UIImage imageNamed:@"Furniture"]];
//        [arrayHeaderImage addObject:[UIImage imageNamed:@"Solid"]];
//        [arrayHeaderImage addObject:[UIImage imageNamed:@"BedAndbath"]];
//        [arrayHeaderImage addObject:[UIImage imageNamed:@"Decor"]];
//        [arrayHeaderImage addObject:[UIImage imageNamed:@"Kitchen"]];
//        [arrayHeaderImage addObject:[UIImage imageNamed:@"Light"]];
//
//        arrayHeaderName = [NSMutableArray new];
//        [arrayHeaderName addObject:@"FURNITURE"];
//        [arrayHeaderName addObject:@"SOLID WOOD"];
//        [arrayHeaderName addObject:@"BED & BATH"];
//        [arrayHeaderName addObject:@"DÉCOR"];
//        [arrayHeaderName addObject:@"KITCHEN & DINING"];
//        [arrayHeaderName addObject:@"LIGHTING"];
//    //}
//}

/*- (NSString *)  stringCellIdentifier{
    if (self.isRoot) {
        return stringLeftMenuCell;
    }else{
        return stringLeftSubMenuCell;
    }
}
*/

//-(void) customizeSubviews{
//
//    // Set Gradient Layer.
//    [self.view addLeftMenuGradient];
//
//    // set title for Backbutton
//    [buttonBack setTitle:self.menuTitle forState:UIControlStateNormal];
//}

//-(void)customizeNavigation{
//    if (self.isRoot) {
//        // Set Navigation Bar
//        [self.navigationController setNavigationBarHidden:YES animated:YES];
//    }else{
//        // Set Navigation Bar
//        [self.navigationController setNavigationBarHidden:NO animated:YES];
//        
//        UIBarButtonItem *leftbtn = [[UIBarButtonItem alloc] init];
//        leftbtn.customView = buttonBack;
//        self.navigationItem.leftBarButtonItems = @[leftbtn];
//    }
//}



/*- (void)openDesignInspirationWithDataModel:(FFCategoriesChildren*)dataModel {
    
    HomeViewController *homeController = (HomeViewController*)[((UINavigationController*)self.sideMenuViewController.contentViewController) topViewController];
    [homeController pushToParticulerClass:dataModel.pageLayout withurl:dataModel.apiUrl header:[dataModel.name uppercaseString]];
}
*/


@end
