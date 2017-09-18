define(function(){
    var html = "<span @click.stop='info' class='user-loginOut-bar'></span>";
    return {
        template:html,
        methods:{
            info:function(){
                window.location.href="/portal/j_security_logout";
            },
            setting:function(){
                console.log(this);
            }
        }

    }
});