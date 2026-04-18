#import "ToolBoxRootViewController.h"
#import <sys/utsname.h>

@implementation ToolBoxRootViewController {
    UITableView *_tableView;
    int _currentTab;
    NSArray *_hwData;
    NSArray *_toolNames;
    NSArray *_faIcons;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    _currentTab = 0;

    [self initData];
    [self setupHeader];
    [self setupTableView];
    [self setupTabBar];
}

- (void)initData {
    // 1. FULL DANH SÁCH IPHONE (Tra cứu tên thật)
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *code = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    NSDictionary *modelMap = @{
        @"iPhone10,3": @"iPhone X", @"iPhone10,6": @"iPhone X",
        @"iPhone11,2": @"iPhone XS", @"iPhone11,4": @"iPhone XS Max", @"iPhone11,8": @"iPhone XR",
        @"iPhone12,1": @"iPhone 11", @"iPhone12,3": @"iPhone 11 Pro", @"iPhone12,5": @"iPhone 11 Pro Max",
        @"iPhone13,1": @"iPhone 12 mini", @"iPhone13,2": @"iPhone 12", @"iPhone13,3": @"iPhone 12 Pro", @"iPhone13,4": @"iPhone 12 Pro Max",
        @"iPhone14,4": @"iPhone 13 mini", @"iPhone14,5": @"iPhone 13", @"iPhone14,2": @"iPhone 13 Pro", @"iPhone14,3": @"iPhone 13 Pro Max",
        @"iPhone15,2": @"iPhone 14 Pro", @"iPhone15,3": @"iPhone 14 Pro Max",
        @"iPhone16,1": @"iPhone 15 Pro", @"iPhone16,2": @"iPhone 15 Pro Max"
    };
    NSString *realName = modelMap[code] ?: [NSString stringWithFormat:@"iPhone (%@)", code];

    _hwData = @[
        @{@"t": @"DEVICE_MODEL", @"v": realName},
        @{@"t": @"FIRMWARE", @"v": [[UIDevice currentDevice] systemVersion]},
        @{@"t": @"IDENTIFIER", @"v": code},
        @{@"t": @"ADMIN", @"v": @"THIENNHAN_IOS"}
    ];

    // 2. FULL 30 PROTOCOLS
    _toolNames = @[
        @"DOWNLOAD_CA_CERT", @"DEPLOY_MOBILECONFIG", @"FPS_UNLOCK_MAX", @"GPU_RASTER_BOOST", 
        @"RAM_PURGE_CACHE", @"THERMAL_LIMIT_OFF", @"TOUCH_SENSITIVITY", @"IO_SCHEDULER_FIX", 
        @"BYPASS_DETECTION", @"ROOT_SIMULATOR", @"NETWORK_OPTIMIZE", @"DNS_FLUSH_RELOAD", 
        @"LOG_REMOVER_PRO", @"CACHE_WIPER_ULTRA", @"UI_RENDER_SMOOTH", @"CPU_CORE_UNLIMIT",
        @"VRAM_EXPANSION", @"BATTERY_HEALTH_FIX", @"DAEMON_TERMINATOR", @"SYSCALL_HOOK_X",
        @"DYNAMIC_ISLAND_FIX", @"HID_EVENT_BOOST", @"OPENGL_ES_TURBO", @"METAL_API_ACCEL",
        @"JIT_COMPILER_ON", @"SANDBOX_ESCAPE_V2", @"APP_BINARY_PATCH", @"MEMORY_SWAP_MOD",
        @"RESPRING_UI_PRO", @"FORCE_KERNEL_SYNC"
    ];

    // 3. FULL 30 ICONS FONT AWESOME (Solid)
    _faIcons = @[
        @"\uf019", @"\uf093", @"\uf0e7", @"\uf550", @"\uf538", @"\uf2c9", @"\uf11b", @"\uf0ad",
        @"\uf3ed", @"\uf121", @"\uf012", @"\uf021", @"\uf1da", @"\uf12d", @"\uf03e", @"\uf2db",
        @"\uf530", @"\uf240", @"\uf05e", @"\uf120", @"\uf10b", @"\uf11c", @"\uf108", @"\uf510",
        @"\uf121", @"\uf023", @"\uf1b3", @"\uf1c0", @"\uf011", @"\uf2f1"
    ];
}

- (void)setupHeader {
    UILabel *header = [[UILabel alloc] initWithFrame:CGRectMake(20, 60, 300, 60)];
    header.numberOfLines = 2;
    header.text = @"SYSTEM OVERRIDE\nDEVELOPER: THIENNHAN";
    header.font = [UIFont fontWithName:@"Courier-Bold" size:18];
    header.textColor = [UIColor cyanColor];
    [self.view addSubview:header];
}

- (void)setupTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 130, self.view.frame.size.width, self.view.frame.size.height-230) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorColor = [UIColor colorWithWhite:0.2 alpha:1];
    [self.view addSubview:_tableView];
}

- (void)setupTabBar {
    UIView *bar = [[UIView alloc] initWithFrame:CGRectMake(20, self.view.frame.size.height-80, self.view.frame.size.width-40, 60)];
    bar.backgroundColor = [UIColor colorWithWhite:0.1 alpha:1];
    bar.layer.cornerRadius = 30;
    bar.layer.borderColor = [UIColor cyanColor].CGColor;
    bar.layer.borderWidth = 1;
    [self.view addSubview:bar];

    for(int i=0; i<2; i++) {
        UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
        b.frame = CGRectMake(i*(bar.frame.size.width/2), 0, bar.frame.size.width/2, 60);
        [b setTitle:(i==0?@"DEVICE":@"PROTOCOLS") forState:UIControlStateNormal];
        b.tag = i;
        [b addTarget:self action:@selector(tabSwitch:) forControlEvents:UIControlEventTouchUpInside];
        [bar addSubview:b];
    }
}

- (void)tabSwitch:(UIButton *)s { _currentTab = (int)s.tag; [_tableView reloadData]; }

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)s {
    return (_currentTab == 0) ? _hwData.count : _toolNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)ip {
    UITableViewCell *c = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    c.backgroundColor = [UIColor colorWithWhite:0.05 alpha:1];
    c.textLabel.textColor = [UIColor whiteColor];
    c.detailTextLabel.textColor = [UIColor cyanColor];

    if (_currentTab == 0) {
        c.textLabel.text = _hwData[ip.row][@"t"];
        c.detailTextLabel.text = _hwData[ip.row][@"v"];
        c.textLabel.font = [UIFont fontWithName:@"Courier" size:14];
    } else {
        c.textLabel.text = [NSString stringWithFormat:@"%@  %@", _faIcons[ip.row], _toolNames[ip.row]];
        // Thử nạp FontAwesome từ file ttf
        UIFont *faFont = [UIFont fontWithName:@"FontAwesome5Free-Solid" size:14];
        c.textLabel.font = faFont ?: [UIFont fontWithName:@"Courier" size:14];
        c.detailTextLabel.text = @"[READY]";
    }
    return c;
}

- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)ip {
    if (_currentTab == 1) {
        if (ip.row == 0) [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://thiennhan.com/ca.crt"]];
        if (ip.row == 1) [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://thiennhan.com/boost.mobileconfig"]];
        NSLog(@"[ThienNhan] Running Protocol: %@", _toolNames[ip.row]);
    }
    [tv deselectRowAtIndexPath:ip animated:YES];
}

@end
