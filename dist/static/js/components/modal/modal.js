define(function(){
    var html = "<div class='modal-box'>" +
            "<div class='menu-wrap'>" +
	            "<ul>"+
        			"<template v-for='i of getData().length/3'>"+
        			    "<li>"+
        			       "<template v-for='item of getData().slice(i*3,i*3+3)'>"+
        			       		"<div @click='openHref(item.accessUrl)' class='{{icons[item[\"flowId\"]]}}'><div><i></i><a>{{item.name}}</a></div></div>"+
        			       "</template>"+
        			    "</li>"+
        			"</template>"+
            	"</ul>"+
            "</div>" +
            "<div @click.stop='closeModal' class='modal-close'></div>"+
        "</div>";
    return {
        template:html,
        data:function(){
        	return {
        		icons:{
        			'03':"vp",
        			'04':"imp",
        			'05':"esp",
        			'06':"dialog",
        			'07':"bmp",
        			'02':"mwp",
        			'10':"mwp",
        		}
        	}
        },
        methods:{
        	openHref:function(href){
        		var newWindow = window.open("_blank");
        		newWindow.location = href;
        	},
            closeModal:function(){
                this.$dispatch("showModalFunc");
            },
            getData:function(){
            	var data = "";
            	this.$dispatch('getListSystemData',function(res){
            		data = res.data || {}
            	});
            	return data;
            }
        }
    }
});