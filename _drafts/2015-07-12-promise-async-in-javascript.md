---
layout: post
title:      promise-async-in-javascript
date:       2015-07-12 12:32:00
summary:    In this tutorial, we will show you how to use create a Java project with Maven, imports it into the Eclipse IDE, and package the Java project into a jar file
category:   javaScript
comments:   true
tags:       maven
permalink:  /promise-async-in-javascript.html
---



Delay 5s rồi log ra console chữ HELLO WORLD ?? Nhu the nao

{% highlight javascript %}

setTimeout(function() {
    console.log('HELLO WORLD');
}, 5000);

{% endhighlight %}


Nhẹ nhàng hơn cả đẩy xe hàng, ok?

Quiz nhỡ:

Delay 5s rồi log ra console chữ HELLO
Rồi 3s sau đó log ra chữ WORLD
Rồi 1s sau đó log ra chữ Rikky Handsome?

{% highlight javascript %}
setTimeout(function() {
    console.log('HELLO');
    setTimeout(function() {
        console.log("WORLD");
        setTimeout(function(){
            console.log('Rikky Handsome');
        }, 1000)
    }, 3000)
}, 5000);
{% endhighlight %}



Quiz to: LÀM THẾ NÀO VIẾT ASYNC CHO ĐẸP ?
Async là một tác vụ của máy tính mà nó sẽ được hoàn thành trong TƯƠNG LAI GẦN. Async có thể giản lược về 3 trạng thái cơ bản: PENDING, SUCCESS, FAILED.

Khi một async task bắt đầu được thực hiện, nó PHẢI ở trạng thái PENDING.
Sau khi thực hiện xong task, async PHẢI chuyển về 1 trong 2 trạng thái: SUCCESS hoặc là FAILED.
Sau khi đã chuyển về trạng thái SUCCESS hoặc là FAILED, async đó KHÔNG ĐƯỢC PHÉP thay đổi trạng thái nữa.

Async KHÁC Event, nhưng có thể dùng event để phát sự kiện chuyển trạng thái của async. Khi đó, event chuyển trạng thái chỉ được trigger 1 lần.

Đây là bộ nguyên tắc bất di bất dịch mà theo như HIỂU BIẾT của mình về async. OK không?

OKAY, BÂY GIỜ QUAY LẠI VẤN ĐỀ ASYNC XẤU XÍ CỦA JAVASCRIPT
Cách Javascript xử lý các tác vụ async có một vấn đề: Sự ràng buộc giữa task handler và task. Ờ thì nôm na ra là:

setTimeout Là task

function() { console.log('Hello World'); } là task handler.

Hai cái này vẫn đang phải viết chung vào 1 chỗ:


{% highlight javascript %}
setTimeout(function() {
    console.log('Hello World');
}, 5000);
{% endhighlight %}


Vấn đề sẽ ngay lập tức bị phát sinh, nếu bản thân task handler lại là 1 task khác:
{% highlight javascript %}

setTimeout(function() {
    console.log('HELLO');
    setTimeout(function() {
        console.log("WORLD");
        setTimeout(function(){
            console.log('Rikky Handsome');
        }, 1000)
    }, 3000)
}, 5000);

{% endhighlight %}



Code, nhìn từ góc độ thẩm mỹ thôi nhé, đã xấu bỏ xừ. Các callback function lồng nhau được gọi là hiện tượng: Callback Hell hay Pyramid of Doom.

Nhìn từ góc độ thiết kế, cách viết này sẽ có nguy cơ dẫn đến sự vi phạm những design-pattern căn bản.
Cụ thể nhé:
Nếu mình muốn viết một đoạn mã lấy dữ liệu từ db và trả ra http response:


{% highlight javascript %}
exports.showData = function(request, response) {
    db.getData(function(data) {
        response.json(data);
    });
}
{% endhighlight %}


Điểm mấu chốt nằm ở chỗ, db là object làm việc với database, response là object của http-server. Nhưng bây giờ, db đã phải phụ thuộc hoàn toàn vào response. Điều này vi phạm tư tưởng single response trong thiết kế hệ thống.

Chưa kể đến, rất có thể db là một thư viện do một nhóm deverloper phát triển độc lập với nhóm xây dựng http server. Để nhóm xây dựng http-server sử dụng được db cần có tài liệu mô tả về hàmgetData xem callback function sau đó sẽ nhận được những parameter nào, thậm chí là structure của chúng. Điều này làm giảm đáng kể tốc độ phát triển dự án.

ASYNC INTERFACE – PROMISE
PROMISE – chính xác hơn là Promise/A+ là một bản đặc tả về kết quả của một tác vụ ASYNC, nó đã trở thành một tiêu chuẩn, một INTERFACE để xây dựng những tác vụ Async. Nó giúp bóc tách async task và task handler ra khỏi nhau, những async task như vậy được gọi là những deferred, và kết quả của deferred là promise.

Sau đây là một số đặc tả quan trọng:

Một thenable là một Javascript object có chứa method then(), method then() này nhận 2 tham số fullfill và reject theo đúng thứ tự. Cả 2 tham số này đều là những callback function.
Ví dụ:

{% highlight javascript %}
aThenable.then(function(value){
     // onFullfill
}, function(error){
    // onReject
})
{% endhighlight %}





Một promise là một thenable thoả mãn:
Có chỉ có thể có 1 trong 3 trạng thái sau tại một thời điểm: pending, fullfill, reject
NGAY tại thời điểm được khởi tạo, promise phải mang trạng thái pending
Khi async task được thực hiện thành công, promise phải chuyển từ trạng thái pending sang trạng thái fullfill, tại thời điểm đó, callback onFullfill phải được thực hiện, onFullfillchỉ nhận 1 và chỉ một tham số, đại diện cho kết quả của async task.
Khi async task được THỰC HIỆN XONG, NHƯNG KHÔNG THÀNH CÔNG, promise phải chuyển từ trạng thái pending sang trạng thái reject, tại thời điểm đó, callback onReject phải được thực hiện, onReject chỉ nhận 1 và chỉ 1 tham số, đại diện cho thông báo lỗi do async task trả về.
Khi promise đã ở trại thái fullfill hoặc reject, promise đó KHÔNG thay đổi trạng thái.
Khi một promise có onFullfill hoặc onReject trả về một thenable, thì hàm then của promise đó sẽ trả ra một promise mới – (Promise Chaining)
Khi một promise có onFullfill hoặc onReject trả về một value không phải thenable, thì hàm then của promise đó sẽ trả ra một promise mới mà nó sẽ có luôn trạng tháifullfill với value chính là value không phải thenable – (Promise Pipelining)



Chú ý:

Hàm then() có thể gọi được nhiều lần.




{% highlight javascript %}
aPromise.then(onFullfill1, onReject1);
aPromise.then(onFullfill2, onReject2);
...
aPromise.then(onFullfillN, onRejectN);
{% endhighlight %}



Khi đó, nếu aPromise chuyển về fullfill hoặc reject, TẤT CẢ các callback tương ứng đều được thực hiện;

Promise có thể chaining (Liên hoàn) – Chú ý 2 cái đặc tả cuối cùng:



{% highlight javascript %}
chainingPromise.then(function() {
    /// asyncTask fullfill
    /// start running a new async task
    return aNewPromise
}, function() {
    ///
})

.then(function () {
    // The new async task done.
}, function() {
    ///
});

{% endhighlight %}


Promise KHÔNG PHẢI là async task, mà là đại diện của KẾT QUẢ khi async task được thực hiện xong. Nó nên được hiểu là Value, chứ không phải Action

{% highlight javascript %}

var promise = asyncTask(); //  promise  -carries result; asyncTask() -performs task

// Get the value that the promise is carrying
promise.then(function(result) {
     console.log('Oh! The result is: %', result.toString());
});
{% endhighlight %}



Phù phù! Nhức đầu chưa??? Đấy mới chỉ là những đặc tả cơ bản :))))
Cơ mà, chỉ cần bạn giữ 1 tư tưởng duy nhất trong đầu:

Promise là kết quả của Async
Như thế là ok thôi.

Nào, thử quay lại cái Quiz nhỡ:


{% highlight javascript %}
deferredTimeout(500)

.then(function(){
    console.log('Hello');
})

.then(function() {
    return deferredTimeout(300);
})

.then(function() {
    console.log('World');
})

.then(function() {
    return deferredTimeout(100);
})


.then(function() {
    console.log('Rikky Handsome');
});
{% endhighlight %}



Xinh chưa :relaxed:

Vâng, đây chính là một ví dụ về ASYNC WATERFALL hay Consequence Async ạ

PROMISE IMPLEMENTATIONS
Bạn sẽ hỏi:

Mày lôi ở đâu ra hàm deferredTimeout() thế?
Trả lời luôn: Bịa ra đấy, không có đâu =)))

Bạn nên chú ý, Promise/A+ chỉ là đặc tả, nó mô tả một mô hình, một khuôn mẫu. Còn việc implement nó? Đã có rất nhiều thư viện :D. Và bây giờ là một vài gương mặt sáng giá.

JQUERY
Từ bản 1.7.0, jQuery đã implement mô hình promise.

Không tin hả? Thử cái này xem:


{% highlight javascript %}
$.get('/my/url').then(function(data) {
     console.log(data);
});
{% endhighlight %}


Công việc async duy nhất của jQuery phải làm chính là ajax. Và toàn bộ ajax của jQuery 1.7 đã được viết lại theo cách này.

Ngoài ra, jQuery cũng hỗ trợ bạn tự xây dựng ra các promise của riêng mình thông qua object jQuery.Deferred() – check it out: http://api.jquery.com/category/deferred-object/

Ví dụ nhé:

{% highlight javascript %}
var wait = function(milisec) {
     var deferred = $.Deferred();
     setTimeout(deferred.resolve, milisec);
     return deferred.promise();
};

wait(500).then(function() {
     console.log('Rikky is F**king awesome!');
});
{% endhighlight %}


Nhá, deferredTimeout() đây nhá.

Q
Q là một thư viện có thể dùng cho cả Client/Node.JS;
Q được nhiều người biết đến vì nó chính là 1 built-in service của AngularJS ($q);
Q implement rất tốt spec của Promise/A+
Q hỗ trợ xây dựng một deferred khá dễ dàng:


{% highlight javascript %}
var wait = function(milisec){
    var defer = Q.defer();
    setTimeout(defer.resolve, milisec);
    return defer.promise;
};
{% endhighlight %}



Ngoài ra, ta còn có when cũng rất đáng chú ý.
Parse.com – một PaaS và IaaS rất nổi tiếng hiện nay, SDK của nó cũng support Promise để viết JavascriptClient và CloudCode.
Với ES6 spec, tương lai, promise sẽ được native support cho javascript. Cool!

Q? Vậy Async library của NodeJS là gì?
A: Chỉ là một cách tiếp cận khác đến xử lý async task. Được phát triển bởi developer tên là Caolan. Nó không phải là tiêu chuẩn, càng không phải là Cách lập trình Async. Tuy vậy, Caolan là một developer xuất sắc, anh cũng chính là cha đẻ của nodeunit. Mình tôn trọng thư viện và cách tiếp cận vấn đề của anh. Nhưng mình sẽ chỉ quan tâm đến Promise, vì nó là cách tiếp cận chính thống, được cộng đồng công nhận từ lâu.



ỨNG DỤNG PROMISE TRONG THỰC TẾ
Promise như là contract cho các tác vụ async:

Design by Contract là một phương pháp phát triển phần mềm theo nguyên tắc: Sử dụng một hệ thống Interface/Đặc tả để định nghĩa (Bằng Lập Trình) các điểm ghép nối giữa các thành phần của phần mềm. Nó được xây dựng khi coi một thành phần sẽ là:

Nhà cung cấp, sẽ cung cấp thư viện, các API để có thể thực hiện một công việc nào đó nếu như nó được chia sẻ đủ thông tin. Và nó CAM KẾT thực hiện công việc đó.

Một thành phần khác là Khách hàng sử dụng thư viện và API của Nhà cung cấp để thực hiện công việc của mình. Khách hàng đồng thời CAM KẾT việc chia sẻ đủ thông tin cho Nhà cung cấp.

Contract là sự cam kết giữa Nhà cung cấp và Khách Hàng.

Thông thường, Khách hàng và Nhà cung cấp không cần biết đối tác của mình là ai, chỉ cần biết đối tác sẽ thực hiện cam kết của mình, nhờ thế, Nhà cung cấp và Khách hàng có thể được xây dựng độc lập, không phụ thuộc lẫn nhau.

RẤT LÀ AGILE =))
Trong quá trình phát triển dự án bằng Javascript, rất nhiều trường hợp, bên Nhà cung cấp là sẽ phải thực hiện một công việc async. Khi đó, ta thường sử dụng promise như là contract.

Ví dụ:
Bạn đang viết một module xử lý Authenticate, khi đó, code của controller/middleware của bạn chính là Khách Hàng. Nó sử dụng Nhà Cung Cấp là một dịch vụ Authenticator thông quausername và password và trả lại một userIdentity nào đó:

{% highlight javascript %}
module.exports = function(request, response) {
    ///
   Authenticator.check(request.body.username, response.body.password);
   /// 
}
{% endhighlight %}


Vấn đề là việc check này, trong hầu hết các trường hợp là tác vụ async (như query đến database chẳng hạn); Nên ta cần có 1 promise để define contract – Authenticator.check(username, password) Phải return 1 promise đại diện cho kết quả login.
Và thế là ta đã có đoạn code sau:

{% highlight javascript %}
module.exports = function(request, response) {
   ///
   Authenticator.check(request.body.username, response.body.password)
   // Interesting things here:
   .then(function(userIdentity) {
       response.send('Hello ' + userIdentity); // Kiểu kiểu thế
   }, function(authErrorMessage) {
      response.status(401).send(authErrorMessage);
   });
   /// 
}

{% endhighlight %}


Okay, thế có gì hot?
HOT là bạn thực sự không cần biết Authenticator thực chất là object nào.

{% highlight javascript %}
var InnerSystemAuthenticator = function () {
     /// 
     this.check = function(u, p) {
           var loginDefer = Q.defer;
           db.find({username: u, password: p}, function(error, found) {
               if(error) {
                    defer.reject(error);
               }
               if (!found) {
                    defer.reject('Authentication Failed');
               } else {
                    defer.resolve(found.id);
               }
           });
           return loginDefer.promise;
     };
};

{% endhighlight %}



{% highlight javascript %}
var FacebookAuthenticator = function() {
      this.check = function (u, p) {
            // ... blah
            return fbAuthPromise;
      };
};
{% endhighlight %}




{% highlight javascript %}
var GoogleAuthenticator = function() {
    this.check = function (u, p) {
            // ... blah
            return googleAuthPromise;
      };
};
{% endhighlight %}

Và bây giờ, với chỉ một promise contract đơn giản, bạn đã có thể cùng một lúc tích hợp cả 3 service Authenticate: DB, Facebook, Google.

Và 100 năm nữa, khi tập đoàn Rikky phát triển dịch vụ xác thực thông qua username là DNA và password là vân tay của user. Bạn vẫn tích hợp được nó vào dự án của bạn. Cheer!



Promise như là tầng abstract của async
Quay lại vụ Authenticate, nếu bạn đang chỉ muốn viết unittest cho controller/middleware xem Nếu user authenticate failed có đúng http status 401 được bắn ra hay không? bạn làm như nào:

{% highlight javascript %}
var AlwaysFailedMockAuthenticator = {
    check: function(u, p) {
         var failedAuthDefer = Q.defer();
         failedAuthDefer.reject('Just Kidding! Test for fun!');
         return failedAuthDefer.promise;
    }
};
{% endhighlight %}

**RẤT LÀ TDD :kissing_closed_eyes: **


Promise như là KẾT QUẢ của async
Nếu 1 ngày đẹp trời, bạn phát hiện ra, việc gì mình phải thực hiện nhiều lần query đến cái data dở hơi, 100 năm mới thay đổi 1 lần.

{% highlight javascript %}
   db.findCurrentCentury().then( // blah blah);
{% endhighlight %}


Thì hãy làm như sau:


{% highlight javascript %}
var CurrentCenturyProvider = function() {
    //
    var cached = null;

    this.get = function() {
        if (!cached) {
            return db.findCurrentCentury().then(function(currentCentury) {
                cached = currentCentury;
                return currentCentury;
            });
        } else {
            var cachedPromise = Q.defer();
            q.resolve(cached);
            return q.promise;
        }
    };
}


var centuryProvider = new CurrentCenturyProvider();

centuryProvider.get().then( // blah blah);

{% endhighlight %}


RẤT LÀ PERFORMANCE :blush:
Promise như là kết quả của một cái gì đó – có thể là Async

Một ngày đẹp trời, bạn sẽ nhận ra rằng Sync cũng là Async, một trường hợp đặc biệt của Async thì đúng hơn. Nếu thế, hãy cứ coi như task của bạn sẽ chấp nhận 1 promise đi. Nó rất hữu ích khi bạn xây dựng 1 thư viện mà bạn không biết chính xác input của bạn có phải Async hay không.



{% highlight javascript %}
// Nào thì jQuery 1 tý nào:
var inputTextAutoComplete = function (listOfSuggestion) {
     // Wrap luôn listOfSuggestion bởi 1 promise:
     var suggestionPromise = jQuery.when(listOfSuggestion);

     suggestionPromise.then(function() {
         /// Show the AutoComplete
     });
};

inputTextAutoComplete(['Rikky', 'Is', 'Awesome']);
inputTextAutoComplete($.get('/keywords'));
{% endhighlight %}


RẤT LÀ TINH TẾ =)))))))
Promise thay thế cho những event chỉ được trigger 1 lần:

Như mình đã nói, promise và những event chỉ được trigger 1 lần có thể hoán đổi cho nhau, ví dụ như onload/ready event của jQuery:




{% highlight javascript %}
var whenLoaded = function() {
    var deferred = $.Deferred();
    $(document).ready(function(event) {
        deferred.resolve(event);
    });
    return deferred.promise();
};
///
var pageLoadedPromise = whenLoaded();
pageLoadedPromise.then(function(event) {
    console.log('Woo hoo! Page Loaded');
});

pageLoadedPromise.then(function(){
    // whatever!
});

{% endhighlight %}


Hay thậm chí bạn có thể viết lazy load cho Javascript:




{% highlight javascript %}
var lazyLoadJavascript = function(uri) {
       var deferred = $.Deffered();
       $.getScript(uri, function() {
            deferred.resolve();
      });
      return deferred.promise();
};

var myScriptPromise = lazyLoadJavascript('path/to/my/script.js');
myScriptPromise.then(function() {
     console.log('Woo hoo! Script loaded');
});

{% endhighlight %}



hay thậm chí là:




{% highlight javascript %}
var myModulePromise = loadModule('path/to/file.html', 'path/to/file.js', 'path/to/file.css');

myModule.then(function() {
     /// whatever :D
});
{% endhighlight %}




KẾT
Có rất nhiều cách để bạn sử dụng promise, nó gúp Async chẳng gì là phức tạp, hết cả callback lồng nhau. Code của bạn sẽ trở nên hay ho và nguy hiểm hơn nhiều.
Ngoài các cách implement trên, bạn còn có thể dùng nó để điều khiển chuyển động. Kiểu: moveLeft().then(moveUp).then(moveDown).then(moveRight) –> Rất là chóng mặt s-(
Nào? Bây giờ hiểu biết của mình như thế OK chưa?
–> Rất là hiểu biết

