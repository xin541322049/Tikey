;(function(){
    var mamture_progress = $('#mamture_progress');
    var progress_content = $('#progress_content');
    var l = 0;
    var _number = progress_content.attr('data-progress');
    var timer = null;
    var pro = 0;

    if ( _number < 200 ) {
        lad(_number, 200, '.progress-box-1',function(){
            $('.progress-box-1').append('<span>再消费'+(200-_number)+'元即可升级</span>');
        });
    };

    if ( _number >= 200 && _number < 1000  ) {
        lad(200, 200, '.progress-box-1', function(){
            mamture_progress.addClass('v1');
            lad(_number-200, 1000-200, '.progress-box-2',function(){
                $('.progress-box-2').addClass('active');
                $('.progress-box-2').append('<span>再消费'+(1000-_number)+'元即可升级</span>');
            });
        });
    };

    if ( _number >= 1000 && _number < 5000  ) {
        lad(200, 200, '.progress-box-1', function(){
            mamture_progress.addClass('v1')
            lad(1000, 1000, '.progress-box-2',function(){
                mamture_progress.addClass('v2');
                lad(_number-1000, 5000-1000, '.progress-box-3',function(){
                    $('.progress-box-3').addClass('active');
                    $('.progress-box-3').append('<span>再消费'+(5000-_number)+'元即可升级</span>');
                })
            });
        });
    };

    if ( _number >= 5000 && _number < 10000  ) {
        lad(200, 200, '.progress-box-1', function(){
            mamture_progress.addClass('v1')
            lad(1000, 1000, '.progress-box-2',function(){
                mamture_progress.addClass('v2')
                lad(5000, 5000, '.progress-box-3', function(){
                    mamture_progress.addClass('v3')
                    lad(_number-5000, 10000-5000, '.progress-box-4',function(){
                        $('.progress-box-4').addClass('active');
                        $('.progress-box-4').append('<span>再消费'+(10000-_number)+'元即可升级</span>');
                    })
                })
            });
        });
    };

    if ( _number >= 10000) {
        lad(200, 200, '.progress-box-1', function(){
            mamture_progress.addClass('v1')
            lad(1000, 1000, '.progress-box-2',function(){
                mamture_progress.addClass('v2')
                lad(5000, 5000, '.progress-box-3', function(){
                    mamture_progress.addClass('v3')
                    lad(10000, 10000, '.progress-box-4',function(){
                        mamture_progress.addClass('v4')
                        lad(_number-10000,10000000,'.progress-box-5')
                    })
                })
            });
        });
    };

    /*
     @number : 成长值
     @max : 最大值
     @callback : 回调方法
     */
    function lad(number, max, cls, callback){
        l = 0;
        timer = setInterval(function(){
            if ( number <= 200 ) {
                l++;
            }else if( number > 200 && number <= 1000 ){
                l+=5;
            }else if( number > 1000 && number <= 5000 ){
                l+=10;
            }else if( number > 5000 && number <= 10000 ){
                l+=20;
            }else{
                l+=30;
            };

            pro = (l/max)*100;				//100为  div的长度
            if ( l >= number ) {
                clearInterval(timer);
                if ( callback ) callback();   //回调
            };
            $(cls).css({
                width : pro+'px'
            })
        },1)
    }
})();