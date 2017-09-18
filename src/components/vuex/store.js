import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'
import url from '../../url/url.js'
import global from '../global/global.js'

const option = {
	transformRequest: [function (data) {
		// 这个是通过querystring模块进行数据转换
		return querystring.stringify(data)
	}],
	headers: {
		'Content-Type': 'application/x-www-form-urlencoded;charset=utf-8'
	},
	credentials: 'same-origin'
};
Vue.use(Vuex)
var qs = require('qs');
const versionUrl=url.versionBath
const ProjectUrl=url.projectBath;
const state={
	// 遮罩层是否显式
	isMask:false,
	// 版本管理和资源管理交替展示
	isShow:true,
	// 版本管理表格初始化数据
	tableData:[],

	//首次展示
	isSrc:'https:www.baidu.com',
	// 总条数
	isTotal:0,
	//项目资源管理数据
	nameoptions:[],
    versionoptions:[],
    //项目资源管理表格数据
    projectTableData:[],
    listId:0,
    pathproject:'',
    valueName:'',
    valueVersion:'',
    fisrtParID:0,
    loadingMask:false,
    parentid:-1,
    totledata:[],
    selectid:-1
 
};
const getters={
	tableData:state=>state.tableData,
	isMask:state=>state.isMask,
    versionoptions:state=>state.versionoptions,
    projectTableData:state=>state.projectTableData,
    listId:state=>state.listId,
    fisrtParID:state=>state.fisrtParID,
    loadingMask:state=>state.loadingMask,
    parentid:state=>state.parentid,
    totledata:state=>state.totledata,
    selectid:state=>state.selectid

};
const mutations={
	// 遮罩层是否显式
	IS_MASK(state,data){
		state.isMask=data
	},
	//判断版本管理是否展示
	IS_SHOW(state,data){
		state.isShow=data
	},
	// 判断地址是否发生改变
	IS_SRC(state,data){
		state.isSrc=data
	},
	// 版本管理表格初始化数据
	TABLE_DATAB(state,data){
		state.tableData=data
	},
	// 总条数
	IS_TOTAL(state,data){
		state.isTotal=data;
	},
	//项目资源管理数据
	NAMEOPTIONS(state,data){
		state.nameoptions=data
	},
	VERSIONOPTIONS(state,data){
        state.versionoptions=data
	},
	PROJECTABLEDATE(state,data){
		state.projectTableData=data
	},
	LISTID(state,data){
		state.listId=data
	},
	PATHPROJECT(state,data){
		state.pathproject=data
	},
	VALUENAME(state,data){
		state.valueName=data
	},
	VALUEVERSION(state,data){
		state.valueVersion=data
	},
	RIRSTPARID(state,data){
		state.fisrtParID=data
	},
	LOADINGMASK(state,data){
	    state.loadingMask=data
	},
	PARENTID(state,data){
		state.parentid=data
	},
	TOTLEDATA(state,data){
		state.totledata=data
	},
	SELECTID(state,data){
		state.selectid=data
	},
	
	
};
// var type = 'POST';
var type = 'GET';
const actions={
	// 遮罩层是否显式
	setMask({commit},params){
     commit('IS_MASK',params);
	},
	// 版本管理是否展示
	setShow({commit},params){
	 commit('IS_SHOW',params);
	},

	// 判断地址是否发生改变
	setSrc({commit},params){
		commit('IS_SRC',params);
	},
	getloadMask({commit},params){
		commit('LOADINGMASK',params)
	},
	// 初始化请求版本管理数据
	getshowTable({commit}, params){
		 commit('LOADINGMASK',true)
		 axios({
		      method: type,
		      url: versionUrl.versionUrl,
		      data:params.params,
		    }).then(function(res){
		      let allData=res.data; 
		      if(allData.status[0].statusCode===200){
		      	  commit('LOADINGMASK',false)
		      	// 表格数据
		      	params.flag ? global.RequestRight(params.this,params.message) : '';
                commit('TABLE_DATAB',allData.node);
                // 总条数
                commit('IS_TOTAL',allData.page.totals);
		      }else{
		      	 global.RequestError(params.this,allData.status[0].mesText);
		      	   commit('LOADINGMASK',false)
		      }
		    }).catch(function(err){
		    	  commit('LOADINGMASK',false)
		        global.RequestError(params.this,"服务器异常，请稍后刷新");
		    })		    
	},

	//项目资源管理下拉框数据
	getNameOptions({commit},params){
		axios({
		    method: type,
		    url: ProjectUrl.projectInitUrl,
		    data:params.params,
		    // ...option
		}).then(function(res){
		         let allData=res.data;
		    
                    // 表格数据
	             let dict = {};
				 let optiondata = allData.node.filter(function(el) {
				  let key = el.projectName
				  let result = !dict[key]
				  dict[key] = true
				  return result
				  });

			    let opt = {};
	            allData.node.forEach(function(el,index){
                  if(!opt[el.projectName]){
					opt[el.projectName] = [el];
				}else{
					opt[el.projectName].push(el);
				}
			   });
			   if(allData.node.length>0){
			   	commit('NAMEOPTIONS',optiondata);
                commit('TOTLEDATA',allData.node)
                commit('VALUENAME',allData.node[0].projectName);
                commit('VALUEVERSION',allData.node[0].projectVersion);
                commit('VERSIONOPTIONS',opt[allData.node[0].projectName]);
                commit('LISTID',allData.node[0].listId);
			   }
          
		    }).catch(function(err){
		    	console.log("err",err)
		        global.RequestError(params.this,"服务器异常，请稍后刷新");
		    })	
	},
	// 改变options
	getVersion({commit},params){
		 commit('VERSIONOPTIONS',params);
	},
	getValuename({commit},params){
		commit('VALUENAME',params);
	},
	getValuenameoption({commit},params){
		commit('VALUEVERSION',params);
	},
	//改变listId
    getId({commit},params){
    	 commit('LISTID',params);
    },
	// 项目资源管理表格数据
	getprojectTableData({commit},params){
		commit('LOADINGMASK',true);
		 axios({
		      method: 'GET',
		      url:params.url,
		      params:params.params,
		      // headers: {'Content-Type': 'application/x-www-form-urlencoded;charset=utf-8' }
		    }).then(function(res){
		      var allData=res.data;
		      var  newData=[];
		      if(allData.status[0].statusCode===200){
		      	  commit('LOADINGMASK',false)
		       	 newData = allData.folder.concat(allData.file)
		      	// 表格数据
		      	 commit('SELECTID',newData[0].parentId);
                 commit('PROJECTABLEDATE',newData);
                 commit('PATHPROJECT',allData.path);  
		       }   
		    }).catch(function(err){
		        global.RequestError(params.this,"服务器异常，请稍后刷新");
		          commit('LOADINGMASK',false)
		    })
	}
	
};
export default new Vuex.Store({
  state,
  mutations,
  actions,
  getters
})