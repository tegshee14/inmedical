<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
    <head>
        <title>page changing by css3 animation</title>
        <meta charset="utf-8">
        <style>         
            * {margin: 0; padding: 0;}
            html {height:100%;}
            body {height:100%;}
            .wrapper {
                width:100%; height:100%;
                position:relative;              
                overflow:hidden;                
                -webkit-perspective: 1200px;
            }           
            .content {
                width:100%; height:100%;
                position: absolute;
                -webkit-transform-style: preserve-3d;
            }
            .page {
                width :100%; height:100%;
                position: absolute;
                left:0; top:0;
                visibility:hidden;
                z-index:1;              
                display:-webkit-box;
                -webkit-box-orient:horizontal;
                -webkit-box-align:center;
                -webkit-box-pack:center;            
            }
            .page.current-page {visibility:visible;}
            .page-1 {background-color:#0ac2d2;}
            .page-2 {background-color:#7bb7fa;}
            .page-3 {background-color:#60d7a9;}
            .page-4 {background-color:#fdc162;}
            .page-5 {background-color:#ff0000;}         
            .nav {
                list-style: none;
                position: fixed;
                left:0; top:0;
                z-index:200;
            }
            .nav li {height:40px;}
            .nav li:hover {background:#ccc;}
            .nav li a {height:100%;}
            .page-moveFromLeft {-webkit-animation: moveFromLeft 0.6s ease both;}
            @-webkit-keyframes moveFromLeft {from { -webkit-transform: translateX(-100%); }}
            .page-moveFromRight {-webkit-animation: moveFromRight .6s ease both;}
            @-webkit-keyframes moveFromRight {from { -webkit-transform: translateX(100%); }}
            .page-moveFromBottom {-webkit-animation: moveFromBottom 0.6s ease both;}
            @-webkit-keyframes moveFromBottom {from { -webkit-transform: translateY(100%); }}
            .page-moveFromTop {-webkit-animation: moveFromTop .6s ease both;}
            @-webkit-keyframes moveFromTop {from { -webkit-transform: translateY(-100%); }}
            .page-moveToLeft {-webkit-animation: moveToLeft .6s ease both;}
            @-webkit-keyframes moveToLeft {to {-webkit-transform: translateX(-100%); }}
            .page-moveToRight {-webkit-animation: moveToRight .6s ease both;}
            @-webkit-keyframes moveToRight {to { -webkit-transform: translateX(100%); }}
            .page-moveToBottom {-webkit-animation: moveToBottom .6s ease both;}
            @-webkit-keyframes moveToBottom {to {-webkit-transform: translateY(100%); }}
            .page-moveToTop {-webkit-animation: moveToTop .6s ease both;}
            @-webkit-keyframes moveToTop {to { -webkit-transform: translateY(-100%); }}
        </style>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
        <script>
            var outIndex = 0;
            var currentIndex = 0;
            var $pageList = null;
            var $inPage = null;
            var $outPage = null;
            var documentWidth = 0;
            var documentHeight = 0;         
            $(document).ready(function() {
                init();
                initPage();
                initEvent();
            })          
            function init() {
                $pageList = $(".page");
                documentWidth = $("body").outerWidth();
                documentHeight = $("body").outerHeight();               
            }
            function initPage() {               
                $pageList.eq(0).addClass("current-page");               
            }
            function initEvent() {
                $("li a").click(function(){                 
                    var transition = $(this).parent().attr("data-transition");
                    switch(transition){
                        case "moveFromLeftToRight":
                            moveFromLeftToRight();
                            break;                          
                        case "moveFromRightToLeft" :
                            moveFromRightToLeft();
                            break;                          
                        case "moveFromBottomToTop" :
                            moveFromBottomToTop();
                            break;                          
                        case "moveFromTopToBottom" :
                            moveFromTopToBottom();
                            break;                          
                    }                   
                })  
            }   
            function nextPage(){
                // 1. in, out 인덱스 구하기
                outIndex = currentIndex;
                currentIndex++;
                if(currentIndex >= $pageList.length) currentIndex = 0;
                // 2. in, out 요소 구하기
                $inPage = $pageList.eq(currentIndex);           
                $outPage = $pageList.eq(outIndex);              
                return{
                    $inPage:$inPage,
                    $outPage:$outPage
                }
            }
            function prevPage(){
                // 1. in, out 인덱스 구하기
                var outIndex = currentIndex;
                currentIndex--;
                if(currentIndex < 0) currentIndex = $pageList.length-1;
                // 2. in, out 요소 구하기
                $inPage = $pageList.eq(currentIndex);           
                $outPage = $pageList.eq(outIndex);              
                return{
                    $inPage:$inPage,
                    $outPage:$outPage
                }
            }
            function moveFromLeftToRight(){
                transition("prev", "page-moveToRight", "page-moveFromLeft");
            }           
            function moveFromRightToLeft(){
                transition("next", "page-moveToLeft", "page-moveFromRight");
            }
            function moveFromBottomToTop(){
                transition("next", "page-moveToTop", "page-moveFromBottom");
            }
            function moveFromTopToBottom(){
                transition("prev", "page-moveToBottom", "page-moveFromTop");
            }
            function transition(direction, outAnimation, inAnimation){
                var info = null;
                if(direction =="next"){
                    info = nextPage();
                }else{
                    info = prevPage();
                }
                // 3. in 요소 등장 위치 초기화, 4. in 요소 활성화, 5. in 요소 애니메이션
                info.$inPage.addClass("current-page "+inAnimation);
                info.$inPage.one("webkitAnimationEnd", function(){
                    $(this).removeClass(inAnimation);// $(this)를 $inPage로 하면 안됨 
                });
                // 6. out 요소 애니메이션
                info.$outPage.addClass(outAnimation);
                info.$outPage.one("webkitAnimationEnd", function(){
                    $(this).removeClass("current-page "+outAnimation);// $(this)를 $outPage 하면 안됨
                });
            }           
        </script>
    </head>
    <body>
        <div class="wrapper">
            <div class="content">
                <div class="page page-1"><h1>1</h1></div>
                <div class="page page-2"><h1>2</h1></div>
                <div class="page page-3"><h1>3</h1></div>
                <div class="page page-4"><h1>4</h1></div>
                <div class="page page-5"><h1>5</h1></div>
            </div>
        </div>
        <ul class="nav">
            <li data-transition="moveFromLeftToRight"><a href ="#">MOVE FROM LEFT / TO RIGHT(왼쪽에서 오른쪽으로 )</a> </li>
            <li  data-transition="moveFromRightToLeft"><a href ="#" >MOVE FROM RIGHT / TO LEFT(오른쪽에서 왼쪽으로)</a></li>
            <li  data-transition="moveFromBottomToTop"><a href ="#" >MOVE  FROM BOTTOM / TO TOP(아래에서 위로)</a></li>
            <li  data-transition="moveFromTopToBottom"><a href ="#" >MOVE FROM TOP / TO BOTTOM(위에서 아래로)</a>   </li>     
        </ul>
    </body>
</html>