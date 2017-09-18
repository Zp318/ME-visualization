define(["jquery"],function($){
    var html = "<div class='panelTitle'>" +
        "<span class='No'>{{index+1 < 10? '0'+(index+1) : (index+1)}}</span>" +
        "<span class='subTitle'>{{titledata['name'].split('|')[1] || titledata['name'].split('|')[0]}}</span>" +
        "<span class='title'>{{titledata['name'].split('|')[0]}}</span>" +
        "</div>";
    return{
        template:html,
        props:["titledata","index"]
    }
});