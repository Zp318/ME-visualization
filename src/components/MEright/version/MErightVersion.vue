<template>
	<div class="VersManage">
	  <div  class='formtab'>
		<div class="formheader">
			<el-row type="flex" >
			 <span  class="span">项目名称：</span> 
       <el-input class='searchName' v-model="projectName" size="small"></el-input>
			 <span  class="span">项目版本：</span> 
			 <el-input class='searchName' v-model="projectVersion" size="small"></el-input>

			 <span  class="span">开始时间：</span> 
			 <el-date-picker
		      v-model="startTime"
		      size="small"
		      type="date"
           @input="changeStart"
		      placeholder="选择日期"
		      :picker-options="startpickerOptions">
		    </el-date-picker>

		    <span class="span">结束时间：</span> 
			 <el-date-picker
		      v-model="endTime"
		       size="small"
		      type="date"
           @input="changeEnd"
		      placeholder="选择日期"
		      :picker-options="endpickerOptions">
		    </el-date-picker>
			 	<span  class="span">模糊匹配：</span>
			 	<el-checkbox v-model="fuzzyValue" class="elcheckbox" @change="isfuzzyMatch"></el-checkbox>
			  <el-button type="primary"  size="small" class="query elbutton" @click="search" >查 询</el-button>
			</el-row>
		</div>
		<div class="addDel">
		    <el-button type="primary"  size="small" class="elbutton" @click="handleaddVersion()"><i class="el-icon-plus"></i> 新 增</el-button>
       <el-button type="primary"  size="small" class="elbutton" @click="handleeditVersion()"><i class="el-icon-edit"></i>修 改</el-button>
       <el-button type="primary"  size="small" class="elbutton" @click="delVersion"><i class="el-icon-delete"></i>删 除</el-button>
       <el-button type="primary"  size="small" class="elbutton xiazai" @click="downloadVersion"><i class="el-icon-upload2
"></i>下载版本文件</el-button>
		</div>
		<!-- 表格部分 -->
		<div class="publicTable">
			  <el-table :data="$store.state.tableData" stripe class="eltable" @select="handleSelectionChange">
			            <el-table-column
						      type="selection"
						      width="55">
						</el-table-column>
				        <el-table-column  label="项目名称">
				        	<template scope="scope">
							    <span :title="scope.row.projectName" class="limitedWidth">{{scope.row.projectName}}</span>
							</template>	
				        </el-table-column>
				         <el-table-column  label="项目版本">
				        	<template scope="scope">
							    <span :title="scope.row.projectVersion" class="limitedWidth">{{scope.row.projectVersion}}</span>
							</template>	
				        </el-table-column>
				        <el-table-column  label="版本文件">
				        	<template scope="scope">
							    <span :title="scope.row.versionName" class="limitedWidth">{{scope.row.versionName}}</span>
							</template>	
				        </el-table-column>
				         <el-table-column  label="版本基础包">
				        	<template scope="scope">
							    <span :title="scope.row.basicName" class="limitedWidth">{{scope.row.basicName}}</span>
							</template>	
				        </el-table-column>
				        <el-table-column  label="操作者">
				        	<template scope="scope">
							    <span :title="scope.row.operatorName" class="limitedWidth">{{scope.row.operatorName}}</span>
							</template>	
				        </el-table-column>
				         <el-table-column  label="时间">
				        	<template scope="scope">
							    <span :title="scope.row.modifyTime" class="limitedWidth">{{scope.row.modifyTime}}</span>
							</template>	
				        </el-table-column>
			 </el-table>
			 <el-pagination
			   @size-change="handleSizeChange"
               @current-change="handleCurrentChange"
               :current-page="currentPage"
		       :page-sizes="[20, 30, 40]"
		       :page-size="pagesize"
		       layout="total, prev, pager, next, sizes, jumper"
		       :total="$store.state.isTotal">
			 </el-pagination>
		</div>
		<!-- 新增 -->
        <form class="addVersion"  id="formdata" v-if="addShow"  method="POST" enctype="multipart/form-data">
        	<div class="addTitle">
        		<span v-if="addVersionShow">添加项目名称</span>
        		<span v-else>修改项目名称</span>
        		<i @click="handaddClose">X</i>
        	</div>
        	<div class="addContent">
        	  <div class="nodemes">
	            <span>项目名称:</span>
	            <el-input class="addinput" v-model="addprojectName" size="small" :maxLength=32 @keyup.native="versionName(addprojectName)" v-if="addVersionShow" placeholder="请输入" name="projectName" ></el-input>
	            <el-input class="addinput" v-model="editprojectName" size="small" :maxLength=32 @keyup.native="versionName(editprojectName)" v-else placeholder="请输入"></el-input>
	          </div>
              <input type="hidden" v-if="addVersionShow" name="listId" value="-1"/>
              <input type="hidden" v-if="addVersionShow" name="versionName" :value="inputtxt"/>
              <input type="hidden" v-if="addVersionShow" name="basicName" :value="inputzip"/>
	          <div class="nodemes">
		             <span>项目版本:</span>
		             <el-input v-model="addprojectVersion" class="addinput" :maxLength=18 @keyup.native="versionName(addprojectVersion)"  v-if="addVersionShow" name="projectVersion" size="small" placeholder="请输入"></el-input>
                  
		             <el-input v-model="editprojectVersion" class="addinput" :maxLength=18 @keyup.native="versionName(editprojectVersion)" size="small"  v-else></el-input>
		      </div>
		        <div class="nodemes">
                <span>版本文件:</span> 
                <div class="noderight" :class="[addVersionShow ? '' : 'edit']">
                   <input class="upload" type="text" :value="inputtxt" v-if="addVersionShow" disabled>
                   <input class="upload" type="text" :value="editimgtxt" :title="editimgtxt" v-else disabled>
                  <a href="javascript:;" class="file" :style="addVersionShow ? 'cursor: pointer' : 'display:none' ">浏 览
                  <input  v-if="addVersionShow" type="file" name="multipartfile" @change="inputshowtext($event)" style="cursor: pointer">
                  <input  v-else type="file" name="multipartFile">
                 </a>
               </div> 
               <dl style="display: inline-block;color:red" v-if="addVersionShow && txtarr">此文件必须以.txt结尾</dl>
          </div>
          <div class="nodemes"> 
                <span>版本基础包:</span>
                <div class="noderight" :class="[addVersionShow ? '' : 'edit']">
                 <input class="upload" type="text" :value="inputzip" v-if="addVersionShow" disabled>
                 <input class="upload" type="text" :value="editimgzip" :title= "editimgzip" v-else disabled>
                 <a href="javascript:;" class="file" :style="addVersionShow ? 'cursor: pointer' : 'display:none' ">浏 览
                 <input  v-if="addVersionShow" type="file" name="multipartfile" @change="inputshowzip($event)" style="cursor: pointer">
                 <input  v-else type="file" name="multipartFile">
               </a>
               </div>
               <dl style="display: inline-block;color:red" v-if="addVersionShow && ziparr">此文件必须以.zip结尾</dl>
          </div>
        	</div>
        	<div class="addSure">
              <input type="submit"  @click="handleAddVersion('',$event)" v-if="addVersionShow" value="确定" class="submitsure" >
        		<button @click="handleEditVersionSure('',$event)" v-else>确定</button>
        		<button @click="handaddClose('',$event)">取消</button>
        	</div>
          </form>
          <!-- <iframe id="frame" name="iframe" style="display:none;"></iframe>   -->
        <!-- 下载版本 -->
        <div class='Download' v-if="loadShow">
        	<div class="downtitle">
        		<!-- <i @click="handdownClose">X</i>		 -->
             <span style="font-size: 0.12rem;color:#fff;margin: 0.08rem 0.2rem;display: inline-block;text-indent: 0.2rem">文件下载</span> 
        	</div>
        	<el-progress :percentage="downNum" class="elprogress"></el-progress>
        </div>
	 </div>
	</div>
</template>
<script>
import format from '../../global/DateExtend.js'
import global from '../../global/global.js'
import url from '../../../url/url.js'
const versionUrl=url.versionBath
 export default {
  data(){
    return {
     urlType:'POST',
     // urlType:'GET',
     varShow:true,
     projectName:'',
     projectVersion:'',
     // 增加版本
     addVersionShow:true,
     addprojectName:'',
     addprojectVersion:'',
     // 修改项目
     editVersionShow:true,
     edit:'修改',
     editprojectName:'',
     editprojectVersion:'',
     startTime:(new Date()).format("YYYY-MM-DD"),
     endTime:(new Date()).format("YYYY-MM-DD"),
     startpickerOptions: {
          disabledDate(time) {
            return time.getTime() > Date.now();
          }
        },
     endpickerOptions: {
          disabledDate(time) {
            return time.getTime() > Date.now();
          }
        },
     add:"添加",
     fuzzyValue:true,
     fuzzyMatch:1,
     currentPage:1,
     pagesize:15,
     addShow:false,
     fileList:[],
     imgurl:'',
     addimgtxt:'',
     addimgzip:'',
     editimgtxt:'',
     editimgzip:'',
     imgurlarr:[],
     // 选中修改数量
     selectChecked:0,
     listId:0,
     delId:0,
     loadShow:false,
     downNum:50,
     multipleSelection:[],
     timer:null,
      inputtxt:'',
     inputzip:'',
    addUrl:versionUrl.versionaddUrl,
    txtarr:false,
     ziparr:false
    }
  },
  computed:{

  },

  created(){ 
  },
  mounted(){
  	this.$nextTick(function(){
		this.$store.dispatch('getshowTable',{ "params":
     {
    "page":[{"perPageNum":this.pagesize,"curPage":1}],
    "node":[{"projectName":this.projectName.replace(/\s/g, ""),"projectVersion":this.projectVersion.replace(/\s/g, ""),"beginTime":(new Date(this.startTime)).format("YYYY-MM-DD:00:00:00"),"endTime":(new Date(this.endTime)).format("YYYY-MM-DD:23:59:59"),"fuzzyMatch":this.fuzzyMatch}]
      },
    "this":this,
    "flag":false,
    "message":''
     }); 
	  });
  },
  methods:{
  	// 打开添加项目面板
  	handleaddVersion(){
	 	  this.addVersionShow=true;
	 	  this.editVersionShow=false;
	 	  this.addShow=true;
	  	this.addprojectName='';
      this.addprojectVersion='';
      this.imgurl='';
      this.inputzip='';
      this.inputtxt='';
  	 	this.$store.dispatch('setMask',true);
  	 },
  	//添加项目确定
    handleAddVersion(ms, event){
       if (event) event.preventDefault()
    	var me=this;
    	if(this.addprojectName==="" || this.addprojectVersion==="") {
      global.RequestError(this,"项目名称版本名称以及文件不能为空");
    	return;
    	}
    	if(me.addprojectName==me.addprojectVersion){
    	global.RequestError(this,"项目名称 版本名称不能重复");
    	return;
    	}
      if(me.inputtxt.replace(/\s/g, "")===""){
          global.RequestError(this,"版本文件不能为空");
          return;
      }
      if(me.inputzip.replace(/\s/g, "")===""){
          global.RequestError(this,"版本基础包不能为空");
           return;
      }
      if(me.txtarr){
        return
      }
      if(me.ziparr){
         return
      }
      let isTime=this.proofTime();
        if(!isTime){
          global.RequestError(this,"开始时间不能大于结束时间");
         return 
      };
    	me.addShow=false;
    	me.$store.dispatch('setMask',false);
      let form=document.getElementById("formdata");
      me.$store.dispatch('getloadMask',true); 
      let formdata = new FormData(form);
        $.ajax({
        url: me.addUrl,
        type: 'POST',
        cache: false,  
        data: formdata,
        processData: false,
        contentType: false
      }).done(function(res) { 
        if(res.status[0].statusCode===201){   
        global.RequestRight(me,res.status[0].mesText);
          me.$store.dispatch('getshowTable',{ 
          "this":me,
          "url":versionUrl.versionUrl,
          "flag":false,
          "message":'',
          "params": {
            "page":[{"perPageNum":me.pagesize,"curPage":1}],
            "node":[{"projectName":me.projectName.replace(/\s/g, ""),"projectVersion":me.projectVersion.replace(/\s/g, ""),"beginTime":(new Date(me.startTime)).format("YYYY-MM-DD:00:00:00"),"endTime":(new Date(me.endTime)).format("YYYY-MM-DD:23:59:59"),"fuzzyMatch":me.fuzzyMatch}]
             }
           });
          me.$store.dispatch('getloadMask',false);
          return;
        }
        global.RequestError(me,res.status[0].mesText);
         me.$store.dispatch('getloadMask',false);
      })
      .fail(function() {
        global.RequestError(me,"服务器异常，请稍后刷新");
         me.$store.dispatch('getloadMask',false);
      }) 
      },
  	//打开 修改项目面板
  	handleeditVersion(){
  	 	if(this.selectChecked===0){
  	 		 global.RequestError(this,"请选择需要修改的一项");
  	 		 return
  	 	}
  	 	if(this.selectChecked>1){
  	 		 global.RequestError(this,"只能修改一项，请重新选择");
  	 		 return
  	 	}
      this.addUrl='';
  	 	this.addVersionShow=false;
  	 	this.editVersionShow=true;
  	 	this.addShow=true;
  	 	this.addprojectName='';
      this.addprojectVersion='';
      this.inputzip='';
      this.inputtxt='';
  	 	this.$store.dispatch('setMask',true);
  	},
  	// 修改项目确认
  	handleEditVersionSure(ms, event){
     
      if (event) event.preventDefault()
  	 	let me=this;
    	if(me.editprojectName==="" || me.editprojectVersion==="") {
      global.RequestError(this,"项目名称版本名称以及文件不能为空");
    	return;
    	}
    	if(me.editprojectName==me.editprojectVersion){
    	global.RequestError(this,"项目名称 版本名称不能重复");
    	return;
    	}
      let isTime=this.proofTime();
        if(!isTime){
          global.RequestError(this,"开始时间不能大于结束时间");
         return 
      };
       me.addShow=false;
      me.$store.dispatch('setMask',false);
      let param= {
        "listId":me.listId,
        "projectName":me.editprojectName,
        "projectVersion":me.editprojectVersion,
        "versionName": me.editimgtxt,
        "basicName": me.editimgzip    
      };
       let axios=global.axiosPost(me,versionUrl.versioneditUrl,param);
       me.$store.dispatch('getloadMask',true);
       axios.then(function(res){   
       let allData=res.data;
        if(allData.status[0].statusCode===201){
           me.$store.dispatch('getloadMask',false);
           global.RequestRight(me,allData.status[0].mesText);
           me.$store.dispatch('getshowTable',{ 
          "this":me,
          "url":versionUrl.versionUrl,
          "flag":false,
          "message":'',
          "params": {
            "page":[{"perPageNum":me.pagesize,"curPage":1}],
            "node":[{"projectName":me.projectName.replace(/\s/g, ""),"projectVersion":me.projectVersion.replace(/\s/g, ""),"beginTime":(new Date(me.startTime)).format("YYYY-MM-DD:00:00:00"),"endTime":(new Date(me.endTime)).format("YYYY-MM-DD:23:59:59"),"fuzzyMatch":me.fuzzyMatch}]
             }
           }) 
            return;
        }
         me.$store.dispatch('getloadMask',false);
         global.RequestError(me,allData.status[0].mesText);
      });
       axios.catch(function(err){
         global.RequestError(me,"服务器异常，请稍后刷新");
          me.$store.dispatch('getloadMask',false);
      }) 
  	 },
  	// 关闭添加修改面板
    handaddClose(ms, event){
       if (event) event.preventDefault()
      this.addShow=false;
      this.$store.dispatch('setMask',false);
     },
  	// 删除项目
  	delVersion(){
  	 	var me=this;
  	 	if(me.selectChecked===0){
  	 		 global.RequestError(me,"请选择需要删除的一项");
  	 		 return
  	 	}
  	 	if(me.selectChecked>1){
  	 		 global.RequestError(me,"只能删除一项，请重新选择");
  	 		 return
  	 	}
        let isTime=this.proofTime();
        if(!isTime){
          global.RequestError(this,"开始时间不能大于结束时间");
         return 
        }
      let param={"recordId":me.listId};
       me.$store.dispatch('getloadMask',true)
      let promise =global.PostAjax(versionUrl.versiondelUrl, param);
       promise.done( (res) => {  
        if(res.status[0].statusCode===201){
           me.$store.dispatch('getloadMask',false);
           me.$alert(res.status[0].mesText, '提示', {
             confirmButtonText: '确定',
             type:'success',
             beforeClose: (action, instance, done) =>{                         
             me.$store.dispatch('getshowTable',{ "params":{
            "page":[{"perPageNum":me.pagesize,"curPage":1}],
            "node":[{"projectName":me.projectName.replace(/\s/g, ""),"projectVersion":me.projectVersion.replace(/\s/g, ""),"beginTime":(new Date(me.startTime)).format("YYYY-MM-DD:00:00:00"),"endTime":(new Date(me.endTime)).format("YYYY-MM-DD:23:59:59"),"fuzzyMatch":this.fuzzyMatch}]
              },
            "this":me
             })
                setTimeout(() => {done()},100);
            }
          },(response)=>{
             me.$store.dispatch('getloadMask',false);
             global.RequestError(me,res.status[0].mesText);
         });       
        }else{
            me.$store.dispatch('getloadMask',false);
           global.RequestError(me,res.status[0].mesText);
        }    
       });
       promise.fail((err) => {
               let message = '服务器繁忙,请稍后刷新';
               RequestError(me,message);
                me.$store.dispatch('getloadMask',false);
            })
  	 },
  	 // 下载该版本文件
  	// 下载项目
  	downloadVersion(){
  	 	var me=this;
      me.$store.dispatch('setMask',true);
  	 	if(me.selectChecked===0){
  	 		 global.RequestError(me,"请选择需要下载的一项");
  	 		 me.$store.dispatch('setMask',false);
  	 		 return
  	 	}
  	 	if(this.selectChecked>1){
  	 		 global.RequestError(me,"只能下载一项，请重新选择");
  	 		  me.$store.dispatch('setMask',false);
  	 		 return
  	 	}
      clearInterval(me.timer);
  	 	me.loadShow=true;
      me.downNum=0
      me.setIntervalTime();
      let downloadUrl=versionUrl.versiondownUrl+'/'+me.listId;
      window.open(downloadUrl,"_self");
  	 },
  	// 关闭下载面板
  	handdownClose(){
      var me=this;
      clearInterval(me.timer);
      me.downNum=0;
  	 	me.loadShow=false;
  	 	me.$store.dispatch('setMask',false);
  	},

    // 处理选型
    handleSelectionChange(selection, row){
    	if(selection.length>0){
      	this.selectChecked=selection.length;
      	this.listId=selection[0].listId;
      	this.editimgtxt=selection[0].versionName;
        this.editimgzip=selection[0].basicName;
        this.editprojectName=selection[0].projectName;
        this.editprojectVersion=selection[0].projectVersion;
        this.imgurl=selection[0].versionName+','+selection[0].basicName;
    	}else{
          this.selectChecked=0
        }
     },
  	// 改变每页条数
  	handleSizeChange(val) { 
        let isTime=this.proofTime();
        if(!isTime){
          global.RequestError(this,"开始时间不能大于结束时间");
         return 
        }
       this.pagesize = val;
       if(this.currentPage!==1){
        this.currentPage = 1;
      }else{
    	  this.$store.dispatch('getshowTable',{ "params":
        {
        "page":[{"perPageNum":this.pagesize,"curPage":1}],
        "node":[{"projectName":this.projectName.replace(/\s/g, ""),"projectVersion":this.projectVersion.replace(/\s/g, ""),"beginTime":(new Date(this.startTime)).format("YYYY-MM-DD:00:00:00"),"endTime":(new Date(this.endTime)).format("YYYY-MM-DD:23:59:59"),"fuzzyMatch":this.fuzzyMatch}]
         },
        "this":this,
        "flag":false,
        "message":'',
         }); 
       }  
    },
    // 改变当前页
    handleCurrentChange(val) {
        let isTime=this.proofTime();
        if(!isTime){
          global.RequestError(this,"开始时间不能大于结束时间");
         return 
        }
        this.currentPage = val;
        this.$store.dispatch('getshowTable',{ "params":
        {
        "page":[{"perPageNum":this.pagesize,"curPage":this.currentPage}],
        "node":[{"projectName":this.projectName.replace(/\s/g, ""),"projectVersion":this.projectVersion.replace(/\s/g, ""),"beginTime":(new Date(this.startTime)).format("YYYY-MM-DD:00:00:00"),"endTime":(new Date(this.endTime)).format("YYYY-MM-DD:23:59:59"),"fuzzyMatch":this.fuzzyMatch}]
         },
        "this":this,
        "flag":false,
        "message":'',
         }); 
    },
    // 校验名称
    versionName(val){ 
     switch(val){
     	 case this.addprojectName:
     	 this.addprojectName=this.addprojectName.replace(/[^\a-\z\A-\Z0-9\u4E00-\u9FA5\_]/g,'');
     	 break;
     	 case this.addprojectVersion:
     	 this.addprojectVersion=this.addprojectVersion.replace(/[^\a-\z\A-\Z0-9\u4E00-\u9FA5\_.]/g,'');
     	 break;
     	 case this.editprojectName:
     	 this.editprojectName=this.editprojectName.replace(/[^\a-\z\A-\Z0-9\u4E00-\u9FA5\_]/g,'');
     	 break;
     	case this.editprojectVersion:
     	 this.editprojectVersion=this.editprojectVersion.replace(/[^\a-\z\A-\Z0-9\u4E00-\u9FA5\_.]/g,'');
     	 break;
     	 default:return '';
     	 break
     }   	
	},
	//查询
    search:function(){
        let isTime=this.proofTime();
        if(!isTime){
          global.RequestError(this,"开始时间不能大于结束时间");
         return 
        }
      if(this.fuzzyMatch===1){
        this.$store.dispatch('getshowTable',{ "params":
        {
        "page":[{"perPageNum":this.pagesize,"curPage":1}],
        "node":[{"projectName":this.projectName.replace(/\s/g, ""),"projectVersion":this.projectVersion.replace(/\s/g, ""),"beginTime":(new Date(this.startTime)).format("YYYY-MM-DD:00:00:00"),"endTime":(new Date(this.endTime)).format("YYYY-MM-DD:23:59:59"),"fuzzyMatch":this.fuzzyMatch}]
         },
         "this":this,
         "flag":true,
         "message":'查询成功'
         }); 
       }else{
       	if(this.projectName.replace(/\s/g, "")==='' || this.projectVersion.replace(/\s/g, "")==='' || this.startTime==='' || this.endTime===''){
           global.RequestError(this,"请输入详细信息");
       		return
       	}
        this.$store.dispatch('getshowTable',{ "params":
        {
        "page":[{"perPageNum":this.pagesize,"curPage":1}],
        "node":[{"projectName":this.projectName.replace(/\s/g, ""),"projectVersion":this.projectVersion.replace(/\s/g, ""),"beginTime":(new Date(this.startTime)).format("YYYY-MM-DD:00:00:00"),"endTime":(new Date(this.endTime)).format("YYYY-MM-DD:23:59:59"),"fuzzyMatch":this.fuzzyMatch}]
         },
        "this":this,
        "flag":true,
        "message":'查询成功'
         }); 
       }
		      			                 
    },
    // 设置是否模糊匹配
    isfuzzyMatch(event){
   	 if(event.target.checked){
      this.fuzzyMatch=1;
      return;
   	 }
     this.fuzzyMatch=0;
    },
    setIntervalTime(){
    let me=this;
    let i=10
    clearInterval(me.timer);
     me.timer = setInterval(function(){
     i+=1;
        me.downNum  += i; 
        if(me.downNum>95 && me.downNum<100) {me.downNum = 100}  
          if(me.downNum == 100){
            clearInterval(me.timer);
            me.loadShow=false;
            me.$store.dispatch('setMask',false);
           }         
         }, 500);
   },
   inputshowtext(e){
    let me=this;
    let text=e.target.files[0].name;
    let arr=[];
    arr=e.target.files[0].name.split(".")
   if(arr[arr.length-1]!=="txt"){
       me.txtarr=true
   }else{
       me.txtarr=false
   }
     me.inputtxt=text
     me.imgurl=me.inputzip+' '+me.inputtxt;
    },
    inputshowzip(e){
    let me=this;
    let text=e.target.files[0].name;
    let arr=[];
    arr=e.target.files[0].name.split(".")
     if(arr[arr.length-1]!=="zip"){
       me.ziparr=true
   }else{
       me.ziparr=false
   }
     me.inputzip=text
     me.imgurl=me.inputzip+' '+me.inputtxt
    },
    changeStart(val){
      let me= this;
      me.startTime=new Date(val).format("YYYY-MM-DD")
    },
    changeEnd(val){
       let me= this;
       me.endTime=new Date(val).format("YYYY-MM-DD")
    },
    proofTime(){
     let flag=true;
     let Sdate=new Date(this.startTime).format("YYYY-MM-DD");
     let Edate=new Date(this.endTime).format("YYYY-MM-DD");
     let SdateTo=(new Date(Sdate)).getTime()/1000;
     let EdateTo=(new Date(Edate)).getTime()/1000;
     if(SdateTo-EdateTo>0){
        flag= false
     }else{
        flag=true;
     }
      return flag;
     }
  }
 } 
</script>