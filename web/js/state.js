;(function(){
    var mamture_progress = $('#mamture_progress');
    var progress_content = $('#progress_content');
    var l = 0;
    var _number = progress_content.attr('data-progress');
    var timer = null;
    var pro = 0;

    if ( _number >= 1 && _number < 2  ) {
        lad(1, 1, '.progress-box-1', function(){
            mamture_progress.addClass('v1');
            lad(_number-1, 2-1, '.progress-box-2',function(){
                $('.progress-box-2').addClass('active');
            });
        });
    };

    if ( _number >= 2 && _number < 3  ) {
        lad(1, 1, '.progress-box-1', function(){
            mamture_progress.addClass('v1')
            lad(2, 2, '.progress-box-2',function(){
                mamture_progress.addClass('v2');
                lad(_number-2, 3-2, '.progress-box-3',function(){
                    $('.progress-box-3').addClass('active');
                })
            });
        });
    };

    if ( _number >= 3 && _number < 4  ) {
        lad(1, 1, '.progress-box-1', function(){
            mamture_progress.addClass('v1')
            lad(2, 2, '.progress-box-2',function(){
                mamture_progress.addClass('v2')
                lad(3, 3, '.progress-box-3', function(){
                    mamture_progress.addClass('v3')
                    lad(_number-3, 4-3, '.progress-box-4',function(){
                        $('.progress-box-4').addClass('active');
                    })
                })
            });
        });
    };

    if ( _number >= 4) {
        lad(1, 1, '.progress-box-1', function(){
            mamture_progress.addClass('v1')
            lad(2, 2, '.progress-box-2',function(){
                mamture_progress.addClass('v2')
                lad(3, 3, '.progress-box-3', function(){
                    mamture_progress.addClass('v3')
                    lad(4, 4, '.progress-box-4',function(){
                        mamture_progress.addClass('v4')
                        lad(_number-4,6,'.progress-box-5')
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
            if ( number <= 1 ) {
                l++;
            }else if( number > 1 && number <= 2 ){
                l+=5;
            }else if( number > 2 && number <= 3 ){
                l+=10;
            }else if( number > 3 && number <= 4 ){
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