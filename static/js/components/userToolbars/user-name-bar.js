define(function(){
    var html = "<span class='user-name-bar'><i></i><span>{{'你好！'+userData().name}}</span></span>";
    return {
        template:html,
        methods:{
        	userData:function(){
        		var info;
        		this.$dispatch('getUserData',function(data){
        			info = data.data;
        		});
        		return info;
        	}
        }

    }
});