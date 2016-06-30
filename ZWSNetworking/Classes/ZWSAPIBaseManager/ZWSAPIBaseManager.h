//
//  ZWSAPIBaseManager.h
//  Pods
//
//  Created by LOFT.LIFE.ZHENG on 16/5/13.
//
//

#import <Foundation/Foundation.h>
#import "ZWSURLResponse.h"

@class ZWSAPIBaseManager;

// 在调用成功之后的params字典里面，用这个key可以取出requestID
static NSString * const kZWSAPIBaseManagerRequestID = @"kZWSAPIBaseManagerRequestID";

// api回调
@protocol ZWSAPIManagerCallbackDelegate <NSObject>
@required
- (void)managerCallAPIDidSuccess:(ZWSAPIBaseManager *)manager;
- (void)managerCallAPIDidFailed :(ZWSAPIBaseManager *)manager;

@end


// 数据重组
/*
使用reformer的流程:
1.controller获得view的reformer
2.controller给获得的reformer提供一些辅助数据，如果没有辅助数据，这一步可以省略。
3.controller调用manager的 fetchDataWithReformer: 获得数据
4.将数据交给view

如何使用reformer:
ContentRefomer *reformer = self.topView.contentReformer;  //reformer是属于需求方的，此时的需求方是topView
reformer.contentParams = self.filter.params;              //如果不需要controller提供辅助数据的话，这步可不要
id data = [self.manager fetchDataWithReformer:reformer];
[self.view configWithData:data];
*/

/*
 比如同样的一个获取电话号码的逻辑，二手房，新房，租房调用的API不同，所以它们的manager和data都会不同。
 同一类业务逻辑（都是获取电话号码）应该写到一个reformer里面去的。这样后人定位业务逻辑相关代码的时候就非常方便了。
 
 代码样例：
 - (id)manager:(CTAPIBaseManager *)manager reformData:(NSDictionary *)data
 {
 if ([manager isKindOfClass:[xinfangManager class]]) {
 return [self xinfangPhoneNumberWithData:data];
 // 这是调用了派生后reformer子类自己实现的函数
 // reformer也可以有自己的属性，当进行业务逻辑需要一些外部的辅助数据的时候，
 // 外部使用者可以在使用reformer之前给reformer设置好属性，使得进行业务逻辑时，
 // reformer能够用得上必需的辅助数据。
 }
 
 if ([manager isKindOfClass:[zufangManager class]]) {
 return [self zufangPhoneNumberWithData:data];
 }
 
 if ([manager isKindOfClass:[ershoufangManager class]]) {
 return [self ershoufangPhoneNumberWithData:data];
 }
 }
 */
@protocol ZWSAPIManagerDataReformer <NSObject>
@required
- (id)manager:(ZWSAPIBaseManager *)manager reformData:(NSDictionary *)data;

@end


// 负责对返回数据或者api调用参数进行验证
/*
 使用场景：
 当我们确认一个api是否真正调用成功时，要看的不光是status，还有具体的数据内容是否为空。由于每个api中的内容对应的key都不一定一样，甚至于其数据结构也不一定一样，因此对每一个api的返回数据做判断是必要的，但又是难以组织的。
 为了解决这个问题，manager有一个自己的validator来做这些事情，一般情况下，manager的validator可以就是manager自身。
 
 1.有的时候可能多个api返回的数据内容的格式是一样的，那么他们就可以共用一个validator。
 2.有的时候api有修改，并导致了返回数据的改变。在以前要针对这个改变的数据来做验证，是需要在每一个接收api回调的地方都修改一下的。但是现在就可以只要在一个地方修改判断逻辑就可以了。
 3.有一种情况是manager调用api时使用的参数不一定是明文传递的，有可能是从某个变量或者跨越了好多层的对象中来获得参数，那么在调用api的最后一关会有一个参数验证，当参数不对时不访问api，同时自身的errorType将会变为CTAPIManagerErrorTypeParamsError。这个机制可以优化我们的app。
 4.特殊场景：租房发房，用户会被要求填很多参数，这些参数都有一定的规则，比如邮箱地址或是手机号码等等，我们可以在validator里判断邮箱或者电话是否符合规则，比如描述是否超过十个字。从而manager在调用API之前可以验证这些参数，通过manager的回调函数告知上层controller。避免无效的API请求。加快响应速度，也可以多个manager共用.
 ”
 
 所以不要以为这个params验证不重要。当调用API的参数是来自用户输入的时候，验证是很必要的。
 当调用API的参数不是来自用户输入的时候，这个方法可以写成直接返回true。反正哪天要真是参数错误，QA那一关肯定过不掉。
 不过我还是建议认真写完这个参数验证，这样能够省去将来代码维护者很多的时间。
 */
@protocol ZWSAPIManagerValidator <NSObject>
@required
- (BOOL)manager:(ZWSAPIBaseManager *)manager isCorrectWithCallbackData:(NSDictionary *)data;
- (BOOL)manager:(ZWSAPIBaseManager *)manager isCorrectWithParamsData  :(NSDictionary *)data;

@end


// 获取API调用的参数
@protocol ZWSAPIManagerParamSource <NSObject>
@required
- (NSDictionary *)paramsForApi:(ZWSAPIBaseManager *)manager;

@end

/*
 当产品要求返回数据不正确或者为空的时候显示一套UI，请求超时和网络不通的时候显示另一套UI时，使用这个enum来决定使用哪种UI.
 不应该在回调数据验证函数里面设置这些值，事实上，在任何派生的子类里面你都不应该自己设置manager的这个状态，baseManager已经帮你搞定了。
 */
typedef NS_ENUM (NSUInteger, ZWSAPIManagerErrorType){
    ZWSAPIManagerErrorTypeDefault,       // 未发起API请求前，manager的默认状态。
    ZWSAPIManagerErrorTypeSuccess,       // API请求成功且返回数据正确。
    ZWSAPIManagerErrorTypeNoContent,     // API请求成功但返回数据不正确，即数据验证函数返回值为NO。
    ZWSAPIManagerErrorTypeParamsError,   // 参数错误，此时manager不会调用API，因为参数验证是在调用API之前做的。
    ZWSAPIManagerErrorTypeTimeout,       // 请求超时。ZWSApiProxy设置的是20秒超时。
    ZWSAPIManagerErrorTypeNoNetWork      // 网络不通。在调用API之前会判断一下当前网络是否通畅，这个也是在调用API之前验证的，跟上面超时的状态是有区别的。
};


typedef NS_ENUM (NSUInteger, ZWSAPIManagerRequestType){
    ZWSAPIManagerRequestTypeGet,
    ZWSAPIManagerRequestTypePost,
    ZWSAPIManagerRequestTypePut,
    ZWSAPIManagerRequestTypeDelete
};


// ZWSAPIBaseManager的派生类须符合的protocal
@protocol ZWSAPIManager <NSObject>
@required
- (NSString *)methodName;
- (NSString *)serviceType;
- (ZWSAPIManagerRequestType)requestType;
- (BOOL)shouldCache;

@optional
- (void)cleanData;
- (NSDictionary *)reformParams:(NSDictionary *)params;
- (NSInteger)loadDataWithParams:(NSDictionary *)params;
- (BOOL)shouldLoadFromNative;


@end


// 拦截器
@protocol ZWSAPIManagerInterceptor <NSObject>
@optional
- (BOOL)manager:(ZWSAPIBaseManager *)manager beforePerformSuccessWithResponse:(ZWSURLResponse *)response;
- (void)manager:(ZWSAPIBaseManager *)manager afterPerformSuccessWithResponse:(ZWSURLResponse *)response;

- (BOOL)manager:(ZWSAPIBaseManager *)manager beforePerformFailWithResponse:(ZWSURLResponse *)response;
- (void)manager:(ZWSAPIBaseManager *)manager afterPerformFailWithResponse:(ZWSURLResponse *)response;

- (BOOL)manager:(ZWSAPIBaseManager *)manager shouldCallAPIWithParams:(NSDictionary *)params;
- (void)manager:(ZWSAPIBaseManager *)manager afterCallingAPIWithParams:(NSDictionary *)params;

@end


@interface ZWSAPIBaseManager : NSObject

@property (nonatomic, weak) id <ZWSAPIManagerCallbackDelegate> delegate;
@property (nonatomic, weak) id <ZWSAPIManagerParamSource> paramSource;
@property (nonatomic, weak) id <ZWSAPIManagerValidator> validator;
@property (nonatomic, weak) id <ZWSAPIManagerInterceptor> interceptor;
@property (nonatomic, weak) NSObject <ZWSAPIManager> *child; // 里面会调用到NSObject的方法，所以这里不用id

/*
 baseManager是不会去设置errorMessage的，派生的子类manager可能需要给controller提供错误信息。
 所以为了统一外部调用的入口，设置了这个变量。
 派生的子类需要通过extension来在保证errorMessage在对外只读的情况下使派生的manager子类对errorMessage具有写权限。
 */
@property (nonatomic, copy, readonly) NSString *errorMessage;
@property (nonatomic, assign, readonly) ZWSAPIManagerErrorType errorType;
@property (nonatomic, strong) ZWSURLResponse *response;

@property (nonatomic, assign, readonly) BOOL isReachable;
@property (nonatomic, assign, readonly) BOOL isLoading;


- (id)fetchDataWithReformer:(id<ZWSAPIManagerDataReformer>)reformer;

// 尽量使用loadData这个方法,这个方法会通过param source来获得参数，这使得参数的生成逻辑位于controller中的固定位置
- (NSInteger)loadData;

- (void)cancelAllRequests;
- (void)cancelRequestWithRequestId:(NSInteger)requestId;

// 拦截器方法，继承之后需要调用一下super
- (BOOL)beforePerformSuccessWithResponse:(ZWSURLResponse *)response;
- (void)afterPerformSuccessWithResponse:(ZWSURLResponse *)response;

- (BOOL)beforePerformFailWithResponse:(ZWSURLResponse *)response;
- (void)afterPerformFailWithResponse:(ZWSURLResponse *)response;

- (BOOL)shouldCallAPIWithParams:(NSDictionary *)params;
- (void)afterCallingAPIWithParams:(NSDictionary *)params;

/*
 用于给继承的类做重载，在调用API之前额外添加一些参数,但不应该在这个函数里面修改已有的参数。
 子类中覆盖这个函数的时候就不需要调用[super reformParams:params]了
 ZWSAPIBaseManager会先调用这个函数，然后才会调用到 id<ZWSAPIManagerValidator> 中的 manager:isCorrectWithParamsData:
 所以这里返回的参数字典还是会被后面的验证函数去验证的。
 
 假设同一个翻页Manager，ManagerA的paramSource提供page_size=15参数，ManagerB的paramSource提供page_size=2参数
 如果在这个函数里面将page_size改成10，那么最终调用API的时候，page_size就变成10了。然而外面却觉察不到这一点，因此这个函数要慎用。
 
 这个函数的适用场景：
 当两类数据走的是同一个API时，为了避免不必要的判断，我们将这一个API当作两个API来处理。
 那么在传递参数要求不同的返回时，可以在这里给返回参数指定类型。
 
 具体请参考AJKHDXFLoupanCategoryRecommendSamePriceAPIManager和AJKHDXFLoupanCategoryRecommendSameAreaAPIManager
 */
- (NSDictionary *)reformParams:(NSDictionary *)params;
- (void)cleanData;
- (BOOL)shouldCache;

- (void)successedOnCallingAPI:(ZWSURLResponse *)response;
- (void)failedOnCallingAPI:(ZWSURLResponse *)response withErrorType:(ZWSAPIManagerErrorType)errorType;

@end







