<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
    <head>
        <title>page slider by jquery</title>
        <meta charset="utf-8">
        <style>          
            * {margin: 0; padding: 0;}
            html {height:100%;}
            body {height:100%;}
            .www{position: relative;    height: 500px;}
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
        </style>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
        <script>
            console.log(window.innerWidth);
            console.log(window.outerWidth);
            var currentIndex = 0,
                outIndex = 0,
                $in = null,
                $out = null,
                $pageList = null,
                documentWidth = 0,
                documentHeight = 0;         
            $(document).ready(function() {
                init();
                initPage();
                initEvent();
            })          
            function init() {
                $pageList = $(".page");
                documentWidth = $(".www").outerWidth();
                documentHeight = $(".www").outerHeight();               
                alert(documentWidth);
            }
            function initPage() {               
                $pageList.eq(currentIndex).addClass("current-page");                
            }
            function initEvent() {
                $("li a").click(function(){                 
                    var direction = $(this).parent().attr("data-direction");
                    if(direction=="prev")
                        prevPage();
                    else 
                        nextPage();
                })  
            }   
            function nextPage(){                
                // 1. in, out 인덱스 구하기
                outIndex = currentIndex;
                currentIndex++;
                if(currentIndex >= $pageList.length){
                    currentIndex = 0;
                }
                // 2. in, out 요소 구하기
                $in = $pageList.eq(currentIndex);           
                $out = $pageList.eq(outIndex);
                // 3. in 요소 등장 위치 초기화               
                $in.css({left:documentWidth});
                // 4. in 요소 활성화             
                $in.addClass("current-page");               
                // 5. in 요소 애니메이션   
                $in.stop().animate({left:0},600);
                //6. out 요소 애니메이션                                                                                    
                $out.stop().animate({left:-documentWidth},{
                    duration:600,
                    complete:function(){//7. out 애니메이션 종료 후 out요소 비활성화
                        $(this).removeClass("current-page");
                    }
                })              
            }           
            function prevPage(){
                // 1. in, out 인덱스 구하기
                outIndex = currentIndex;
                currentIndex--;
                if(currentIndex < 0) currentIndex = 4;
                // 2. in, out 요소 구하기
                $in = $pageList.eq(currentIndex);
                $out = $pageList.eq(outIndex);
                // 3. in 요소 등장 위치 초기화 
                $in.css({left:-documentWidth});
                // 4. in 요소 활성화
                $in.addClass("current-page");
                // 5. in 요소 애니메이션
                $in.stop().animate({left:0},600);
                //6. out 요소 애니메이션
                $out.stop().animate({left:documentWidth},{
                    duration:600,
                    complete:function(){//7. out 애니메이션 종료 후 out요소 비활성화
                        $(this).removeClass("current-page");
                    }
                });                                                     
            }           
        </script>
    </head>
    <body>
    <div class="www">
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
            <li data-direction="prev"><a href ="#">prev</a></li>
            <li data-direction="next"><a href ="#">next</a></li>            
        </ul>
       </div>
    </body>
</html>