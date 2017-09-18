requirejs.config({
    baseUrl: 'js/lib',
    paths: {
        app: '../components',
        jquery: './jquery',
        vue:"./vue"
    }
});
require(["vue","jquery","app/index/head","app/index/body","app/index/foot"],function(Vue,$,head,body,foot){
    var swapItems = function(arr, index1, index2) {
        arr[index1] = arr.splice(index2, 1, arr[index1])[0];
        var sort = arr[index1].sortKey;
        arr[index1].sortKey = arr[index2].sortKey;
        arr[index2].sortKey = sort;
        $.ajax({
        	url:"/portal/menuSet/modUserMenuSet.json",
        	type:"post",
        	dataType:"json",
        	data:{
        		list:[arr[index1],arr[index2]]
        	}
        });
        return arr;
    };
    window.iframe_load = function(target,event){
    	var ifm= target;   
    	var id = $(target).attr("id");
    	
    	//if(!document.frames[id] || $(target).contents().get(0).title.test(""))
    	var subWeb = document.frames ? document.frames[id].document : ifm.contentDocument; 
    	
    	if(ifm != null && subWeb != null) {
    	   /*ifm.height = subWeb.body.scrollHeight;
    	   ifm.width = subWeb.body.scrollWidth;*/
    	   if(/404/.test($(target).contents().get(0).title) || /404/.test($(target).contents().get(0).body.outerText)){
    		   $(target).attr("src","/portal/static/file404.html")
    	   };
    	} 
		
	}
    var isCheckPass = true;
    var url="";
    var userData;
	 $.ajax({
        type:'post',
        data:"",
        url: "/portal/login/loginCheck.json",
        dataType: 'json',
        async:false,
        success:function(){
        	 $.ajax({async:false,url:"/portal/initData.json",success:function(json){
        		 userData = json;
             }});
        	 
        	 $.ajax({async:false,type:"post",data:{userId:"-1"},url:"/portal/listSystem.json",success:function(json){
        		 listSystemData = json;
        		 
        		//要显示就删除这个代码
                 listSystemData.data = listSystemData.data.filter(function(v,i){
                 	return v.flowId != "10";
                 });
             }});
        },
        error:function (ex) {
            if (ex.status == 401) {
               isCheckPass = false;
               var loginLocation  = decodeURI(ex.getResponseHeader("Login-Location"));
               var url =loginLocation + "&excutor="+encodeURIComponent('javascript:alert(\'error\')')+"&failure=" + encodeURIComponent('javascript:window.location.href="/portal/login/loginCheck.json"');
               window.location.href=url;
            }
        }
	 }
	);
   if(!isCheckPass)return;
   var vm =  new Vue({
        el:"#app",
        data:{
            styleSheet:{
                minHeight:($(window).height() - 80*2) + "px"
            },
            settingshow:false,
            data: userData.data.menus[0].children
            	/*[
                {title:"四川省行权案件运行数据统计",subTitle:"数据报告",img:"testImg/test1.png",itemView:true}
                ,{title:"我的报表",subTitle:"我的报表",img:"testImg/test2.png",itemView:true}
                ,{title:"我的告警",subTitle:"我的告警",img:"testImg/test3.png",itemView:false}
                ,{title:"快捷访问",subTitle:"快捷访问",img:"testImg/test4.png",itemView:true}
                ,{title:"最近访问",subTitle:"浏览历史",img:"testImg/test5.png",itemView:true}
                ,{title:"流程监控",subTitle:"流程监控",img:"testImg/test6.png",itemView:true}
                ,{title:"平台使用",subTitle:"平台使用",img:"testImg/test7.png",itemView:true}]*/
        },
        events:{
        	getUserData:function(cb){
        		cb.call(this,userData);
        	},
        	getListSystemData:function(cb){
        		cb.call(this,listSystemData)
        	},
            settingBox:function(flag){
                if(flag == 1){
                    this.settingshow = !this.settingshow;
                }else{
                    this.settingshow = false;
                }
            },
            toolTop:function($index){
                if($index == 0){
                    return;
                }
                var ary = this.data;
                var sortMap = [];
            	$(ary).each(function(i,v){
            		sortMap.push(v.sortKey);
            	});
            	var minSort = Math.min.apply(Math,sortMap);
            	ary[$index].sortKey = minSort - 1;
                $.ajax({
                	url:"/portal/menuSet/modUserMenuSet.json",
                	type:"post",
                	dataType:"json",
                	data:{
                		list:[ary[$index]]
                	}
                })
                ary.unshift(ary[$index]);
                ary.splice($index+1,1);
            },
            toolView:function($index){
            	console.log(2);
                this.data[$index].isEnable = !!this.data[$index].isEnable ? 0 : 1;
                var ary = [];
                ary.push(this.data[$index])
                $.ajax({
                	url:"/portal/menuSet/modUserMenuSet.json",
                	type:"post",
                	dataType:"json",
                	data:{
                		list:ary
                	}
                })
            },
            toolUp:function($index){
                if($index < 1){
                    return;
                }
                var i = -1;
                while(this.data[$index+i] && !this.data[$index+i].isEnable){
                    i--;
                }
                swapItems(this.data,$index,$index+i);
            },
            toolDown:function($index){
                if($index >= this.data.length - 1 ){
                    return;
                }
                var i = 1;
                while(this.data[$index+i] && !this.data[$index+i].isEnable){
                    i++;
                }
                swapItems(this.data,$index,$index+i);
            }
        },
        components:{
            appHead:head,
            appBody:body,
            appFoot:foot
        },
        attached:function(){
            loadingHide();
        }
    });
});