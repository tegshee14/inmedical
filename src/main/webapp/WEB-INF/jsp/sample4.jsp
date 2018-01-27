<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <title>transition</title>
        <style>          
            #target {           
                display:block; 
                position:absolute;
                left:300px;
                width:100px;
                height:100px;
                outline:2px solid black;
                        transition  :all 2s ease-out;
                -webkit-transition  :all 2s ease-out;                   
                -moz-transition     :all 2s ease-out;
                -o-transition       :all 2s ease-out;    
            }
        </style>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
        <script>
            var $target=null;
            $(document).ready(function(){
                $target = $("#target");
                $("#color_transition").on("click",function(){
                    var color = $("#color").val();                  
                    $target.css({"background-color":color});                    
                });
                $("#pos_transition").on("click",function(){
                    var xpos = $("#xpos").val();
                    var ypos = $("#ypos").val();
                    $target.css({left:xpos+"px", top:ypos+"px"})
                });
            })
        </script>
    </head>
    <body>        
        <div id="target"></div>
        <input type="text" id="color" value="pink"><button id="color_transition">color transition</button><br />
        <input type="text" id="xpos" value="0" size="2"><input type="text" id="ypos" value="0" size="2"><button id="pos_transition">x y transition</button>     
    </body>
</html>