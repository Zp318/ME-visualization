/**
 * 错误的提示框
 * @param {[type]}   _this    [description]
 * @param {[type]}   message  [description]
 * @param {Function} callback [description]
 */
function RequestError(_this,message,callback){
  _this.$confirm(message,'提示',{
        confirmButonText:'确认',
        showCancelButton:false,
        type:'error',
    }).then( ()=> {
      if(callback !== undefined){
        callback();
      }
    }).catch( () =>{
      if(callback !== undefined){
        callback();
      }
    });
}
/**
 * 正确的提示框
 * @param {[type]}   _this    [description]
 * @param {[type]}   message  [description]
 * @param {Function} callback [description]
 */
function RequestRight(_this,succmessage,failmessage,callback){
    _this.$alert(succmessage, '提示', {
       confirmButtonText: '确定',
       type:'success',
       beforeClose: (action, instance, done) =>{   
          if(action === 'confirm'){
              callback;
           }
          setTimeout(() => {done()},100);                       
        }
      },(response)=>{
          global.RequestError(_this,failmessage);
      });
}
/**
 * 去除数组重复
 * [getArray description]
 * @param  {[type]} arr [description]
 * @return {[type]}     [description]
 */
function getArray(arr) {
    var hash = {};
    var len = arr.length;
    var result = [];

    for (var i = 0; i < len; i++){
        if (!hash[arr[i]]){
            hash[arr[i]] = true;
            result.push(arr[i]);
        }
    }
    return result;
}
/**
 * [axio的封装]
 * @param  {[type]}   _this    [调用组件]
 * @param  {[type]}   type     [请求方式]
 * @param  {[type]}   url      [请求地址]
 * @param  {[type]}   data     [请求参数]
 * @param  {Function} callback [成功回调]
 * @return {[type]}            [description]
 */

function ajax(_this,type,url,data,num,callback){
    console.log("0000000",data);
    if(type==="GET"){
        _this.$axios({
              method: type,
              url:url,
              params:data,
              // headers: {'Content-Type': 'application/x-www-form-urlencoded;charset=utf-8' }
            }).then(function(res){
               
                    _this.$alert('成功', '提示', {
                     confirmButtonText: '确定',
                     type:'success',
                     beforeClose: (action, instance, done) =>{                         
                         callback;
                         setTimeout(() => {done()},100);
                      }
                    });               
                           
            }).catch(function(err){
                RequestError(_this,"服务器异常，请稍后刷新");
     })
    }else{
       _this.$axios({
              method: type,
              url:url,
              data:data,
            }).then(function(res){
              console.log("4444",res.data.status[0].mesText)
                if(res.data.status[0].statusCode===num){
                    _this.$alert(res.data.status[0].mesText, '提示', {
                     confirmButtonText: '确定',
                     type:'success',
                     beforeClose: (action, instance, done) =>{                         
                         callback;
                         setTimeout(() => {done()},100);
                      }
                    });               
                }else{
                RequestError(_this,res.data.status[0].mesText);
                }            
            }).catch(function(err){
                RequestError(_this,"服务器异常，请稍后刷新");
     })
    }
  
}
/**
 * [axiosPost description] axio POST请求封装
 * @param  {[type]} _this [组件本身]
 * @param  {[type]} url   [发送地址]
 * @param  {[type]} data  [传递参数]
 * @return {[type]}       [description]
 */
function axiosPost(_this,url,data){
let axiospost = _this.$axios({
   method:'POST',
   url:url,
   data:data,
   // ...option
 });
 return axiospost
}
/**
 * [axiosPost description] axio GET请求封装
  * @param  {[type]} _this [组件本身]
 * @param  {[type]} url   [发送地址]
 * @param  {[type]} data  [传递参数]
 * @return {[type]}       [description]
 */
function axiosGet(_this,url,data){
 let axiosget = _this.$axios({
   method:'GET',
   url:url,
   params:data,
   headers: {'Content-Type': 'application/x-www-form-urlencoded;charset=utf-8' },
 });
 return axiosget
}


let sendType='POST'
function PostAjax(url, param){
  let ajaxObj = $.ajax({
    url: url,
    type: sendType,
    data: JSON.stringify(param),
    //data: param,
    // contentType: "application/json",
    datatype: 'json',
    headers: {
      'Content-Type':'application/json;charset=UTF-8'
    }
  });
  return ajaxObj;
};

function GetAjax  (url){
  let ajaxObj = $.ajax({
    url: url,
    type: 'GET',
    datatype: 'json',
    headers: {
      'Content-Type':'application/json;charset=UTF-8'
    }
  });
  return ajaxObj;
};
export default{
  RequestError,
    getArray,
    ajax,
    PostAjax,
    GetAjax,
    RequestRight,
    axiosPost,
    axiosGet
}
