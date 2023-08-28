$(document).ready(function(){
	console.log("ready");
    $(".test").click(function(){//console.log($(this));
          if($(this)[0].value == "1"){//如果点击的对象原来是选中的，取消选中
              $(this).removeAttr("checked");
              $(this).val("0");
          }else{
              $(this).val("1");
          }
          
     });
    $(".test").each(function(){
        $(this).click(function(){
            console.log("value = "+$(this).val());
        });
    });
});