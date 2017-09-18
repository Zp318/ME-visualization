define(["app/userToolbars/user-info-bar" , "app/userToolbars/user-setting-bar",
        "app/userToolbars/user-name-bar" , "app/userToolbars/user-loginOut-bar",
        "app/modal/modal"],
    function(userInfoBar,userSettingBar,userNameBar,userLoginOutBar,modal){
    var html = "<div class='headContainer'>"+
        "<div class='leftTools'>"+
        "<user-info-bar></user-info-bar><user-setting-bar :class='{active:settingshow}'></user-setting-bar>"+
        "</div>"+
        "<div id='appLogo'></div>"+
        "<div class='rightTools'>"+
        "<user-name-bar></user-name-bar><user-loginOut-bar></user-loginOut-bar>"+
        "</div>"+
        "<modal v-if='showModal' transition='fadeInBig'></modal>"+
        "</div>";

    return {
        template:html,
        data:function(){
          return {
              showModal:false
          }
        },
        props:["settingshow"],
        components:{
          "user-info-bar": userInfoBar,
          "user-setting-bar": userSettingBar,
          "user-name-bar": userNameBar,
          "user-loginout-bar": userLoginOutBar,
          "modal":modal
        },
        events:{
            showModalFunc:function(){
                this.showModal = !this.showModal
            }
        }
    }
});