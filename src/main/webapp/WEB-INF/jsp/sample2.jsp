<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
    <head>
        <title>page slider 3d animation</title>
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
            .top-page {z-index:100;}
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
            .page-moveToLeft {-webkit-animation: moveToLeft 0.6s ease both;}
            @-webkit-keyframes moveToLeft {to {-webkit-transform: translateX(-100%); }}
            .page-moveToRight {-webkit-animation: moveToRight .6s ease both;}
            @-webkit-keyframes moveToRight {to { -webkit-transform: translateX(100%); }}
            .page-moveToBottom {-webkit-animation: moveToBottom .6s ease both;}
            @-webkit-keyframes moveToBottom {to {-webkit-transform: translateY(100%); }}
            .page-moveToTop {-webkit-animation: moveToTop .6s ease both;}
            @-webkit-keyframes moveToTop {to { -webkit-transform: translateY(-100%); }}
            .page-fade {-webkit-animation:fade 0.6s ease both;}
            @-webkit-keyframes fade {to { opacity:0.3; }}
            .page-aniDelay {-webkit-animation-delay:0.3s !important;}
            .page-glueLeft {-webkit-transform-origin: 0% 50%; -webkit-animation:glueLeft 0.8s ease both;}
            @-webkit-keyframes glueLeft {
                0% { }
                40% { -webkit-transform: rotateY(20deg); opacity: .8; -webkit-animation-timing-function: ease-out; }
                100% { -webkit-transform: scale(0.8) translateZ(-200px); opacity:0; }
            }
            .page-glueRight {-webkit-transform-origin: 100% 50%; -webkit-animation:glueRight 0.8s ease both;}
            @-webkit-keyframes glueRight {
                0% { }
                40% { -webkit-transform: rotateY(-20deg); opacity: .8; -webkit-animation-timing-function: ease-out; }
                100% { -webkit-transform: scale(0.8) translateZ(-200px); opacity:0; }
            }
            .page-glueTop {-webkit-transform-origin: 50%  0%; -webkit-animation:glueTop 0.8s ease both;}
            @-webkit-keyframes glueTop {
                0% { }
                40% { -webkit-transform: rotateX(-20deg); opacity: .8; -webkit-animation-timing-function: ease-out; }
                100% { -webkit-transform: scale(0.8) translateZ(-200px); opacity:0; }
            }
            .page-glueBottom {-webkit-transform-origin: 50%  100%; -webkit-animation:glueBottom 0.8s ease both;}
            @-webkit-keyframes glueBottom {
                0% { }
                40% { -webkit-transform: rotateX(20deg); opacity: .8; -webkit-animation-timing-function: ease-out; }
                100% { -webkit-transform: scale(0.8) translateZ(-200px); opacity:0; }
            }
        </style>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
        <script>
            var currentIndex = 0;
            var $pageList = null;
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
                $pageList.eq(0).addClass("current-page top-page");              
            }
            function initEvent() {
                $(".nav li a").click(function(e) {
                    e.preventDefault();
                    var direction = $(this).parent().attr("data-pageDirection");
                    var outAnimation = $(this).parent().attr("data-pageOut");
                    var inAnimation = $(this).parent().attr("data-pageIn");
                    transition(direction, outAnimation, inAnimation);
                })
            }
            function nextPage(){
                // 1. in, out 인덱스 구하기
                var outIndex = currentIndex;
                currentIndex++;
                if(currentIndex>=$pageList.length) currentIndex=0;
                // 2. in, out 요소 구하기
                var $inPage = $pageList.eq(currentIndex);           
                var $outPage = $pageList.eq(outIndex);          
                return {
                    "$outPage":$outPage,
                    "$inPage":$inPage
                }
            }
            function prevPage(){
                // 1. in, out 인덱스 구하기
                var outIndex = currentIndex;
                currentIndex--;
                if(currentIndex<0) currentIndex=$pageList.length-1;
                // 2. in, out 요소 구하기
                var $inPage = $pageList.eq(currentIndex);           
                var $outPage = $pageList.eq(outIndex);      
                return {
                    "$outPage":$outPage,
                    "$inPage":$inPage
                }               
            }           
            function transition(direction, outAnimation, inAnimation){              
                var info = null;
                if(direction=="next")
                    info = nextPage();
                else
                    info = prevPage();
                // 사라지는 애니메이션
                info.$outPage.addClass(outAnimation);
                info.$outPage.one("webkitAnimationEnd", function(){
                    $(this).removeClass("current-page "+outAnimation);
                });
                // 나타나는 애니메이션               
                info.$inPage.addClass("current-page "+inAnimation);
                info.$inPage.one("webkitAnimationEnd", function(){
                    $(this).removeClass(inAnimation);
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
            <li  data-pageDirection="next" data-pageOut="page-glueLeft" data-pageIn="page-moveFromRight top-page page-aniDelay" >
                <a href ="#">GLUE LEFT / FROM RIGHT </a>
            </li>
            <li  data-pageDirection="prev" data-pageOut="page-glueRight" data-pageIn="page-moveFromLeft  top-page page-aniDelay" >
                <a href ="#" >GLUE RIGHT / FROM LEFT</a>
            </li>
            <li  data-pageDirection="next" data-pageOut="page-glueTop" data-pageIn="page-moveFromBottom top-page page-aniDelay" >
                <a href ="#" >GLUE TOP / FROM BOTTOM</a>
            </li>
            <li  data-pageDirection="prev" data-pageOut="page-glueBottom" data-pageIn="page-moveFromTop top-page page-aniDelay" >
                <a href ="#" >GLUE BOTTOM / FROM TOP</a>
            </li>
        </ul>
    </body>
</html>