<template>
 <div class="ResourceManage">
   <form action="" class='formtab'>
     <div class="formheader">
      <el-row type="flex" >
       <span  class="span">项目名称：</span> 
         <el-select v-model="$store.state.valueName" placeholder="请选择" class="select" size="small" value-key="nameoption"@change="changeselect">
          <el-option
           class='searchName'
             v-for="item in nameoptions"
            :key="item.projectVersion"
            :label="item.projectName"
            :value="item.projectName">
          </el-option>
        </el-select>
       <span  class="span">项目版本：</span> 
        <el-select v-model="$store.state.valueVersion" placeholder="请选择" class="select" size="small" value-key="versionoption"@change="versionchange">
          <el-option
           class='searchName'
            v-for="item in versionoptions"
            :key="item.projectName"
            :label="item.projectVersion"
            :value="item.listId">
          </el-option>
        </el-select>
        <el-button type="primary"  size="small" class="query elbutton" @click="queryOption()">查 询</el-button>
      </el-row>
     </div>
       <div class="pathBase">
       <span>{{"../"+pathproject}}</span>
       <p @click="backFirst()" class="button">返回上一级</p>
       </div>
   <!-- 表格部分 -->
    <div class="publicTable">

        <el-table  stripe class="eltable" :data="$store.state.projectTableData">
           <el-table-column  label="文件名">
              <template scope="scope" >
               <div   @dblclick="clickproject(scope.row.listId,scope.row.fileType,scope.row.parentId)" style="cursor: pointer;" > 
                  <i class="folder" :class="scope.row.fileType===1 ? 'icon-files-empty' : 'icon-folder-open' "></i>
                 <span :title="scope.row.fileName" class="limitedWidth namespan" v-if="scope.row.fileType===0 ? true : false">{{scope.row.fileName }}</span>
                   <span :title="scope.row.fileName" class="limitedWidth namespan" v-else>{{scope.row.fileName }}.{{scope.row.fileSuffix}}</span>
               </div>      
              </template> 
           </el-table-column>

             <el-table-column  label="文件MD5">
                  <template scope="scope">
                  <span :title="scope.row.fileMd5" class="limitedWidth">{{scope.row.fileMd5}}</span>
              </template> 
           </el-table-column>
              <el-table-column  label="文件版本">
                  <template scope="scope">
                  <span :title="scope.row.fileVersion" class="limitedWidth">{{scope.row.fileVersion}}</span>
              </template> 
           </el-table-column>
            <el-table-column  label="操作者">
                  <template scope="scope">
                  <span :title="scope.row.operator" class="limitedWidth">{{scope.row.operator}}</span>
              </template> 
           </el-table-column>
             <el-table-column  label="操作时间">
                  <template scope="scope">
                  <span :title="scope.row.modifyTime" class="limitedWidth">{{scope.row.modifyTime}}</span>
              </template> 
           </el-table-column>

       </el-table>
    </div>
  </form>
  </div>
</template>

<script>
import global from '../../global/global.js'
import url from '../../../url/url.js'
import { mapState } from 'vuex'
const ProjectUrl=url.projectBath;
var isChange=0;
 export default {
  data(){
    return {
        currentPage:1,
        pagesize:20,
        listId:this.$store.state.listId,
        parentId:-1,
        selectFlag:false,
        parArrId:[],
        optionFlag:true,
        optionid:-1,
        versionFlag:false
    }
  },
  computed:mapState(["nameoptions","versionoptions","pathproject","valueName","valueVersion","parentid","totledata"]),
   watch: {
     valueVersion(newval,oldval){
      if(oldval!==''&&oldval!==newval){
        this.optionFlag=true;
      }
    },
  },
  mounted(){
    let me=this;
      me.$nextTick(function(){
      me.$store.dispatch("getNameOptions",{"params":
       {
          "projectName":"",
          "projectVersion":""
       },
          "this":me
       }
      );
      setTimeout(function(){
        me.$store.dispatch("getprojectTableData",{
          "params":'',
          "url":ProjectUrl.projectqueryUrl+"/"+me.$store.state.listId+"/"+me.parentId,
          "this":me
        }
       )
      },1000);
     }); 
  },
  methods:{
    // 读取项目名称的值
    getNamechangeOptions(val){
      let me=this;
      me.$store.dispatch("getValuename",val)
      me.valueversion='';
      me.listId=val;
      let newArr=[];
      this.optionFlag=true;
      me.$store.dispatch("getValuenameoption",'')
      me.$store.state.totledata.map(function(v,i){
      if(val===v.projectName){     
         newArr.push(v)
      } 
     });
      me.$store.dispatch("getValuenameoption",newArr[0]);
      me.$store.dispatch("getId",newArr[0].listId);
      me.$store.dispatch("getVersion",newArr);
    },
    changeselect(val){
      isChange=1
      this.selectFlag ? this.getNamechangeOptions(val) : this.selectFlag = true
    },
    versionchange(val){
      if(isChange==0){
        this.versionFlag ? this.getversion(val) : this.versionFlag=true
      }
      isChange=0;
    },
    getversion(val){
      this.optionFlag=true;
      this.$store.dispatch("getId",val);
    },
    clickproject(listid,type,parentId){

      if(type===1) return;

      let me=this;
      me.optionFlag=false;
      me.optionid=listid
      me.parArrId.push(parentId);
      me.$store.dispatch("getprojectTableData",{
        "params":'',
        "url":ProjectUrl.projectqueryUrl+"/"+me.$store.state.listId+"/"+listid,
        "this":me
        }
      )
    },
    backFirst(){
       let me=this;
       me.parArrId.length===0 ? me.parentId=-1 : me.parentId= me.parArrId.pop();
       if(me.$store.state.nameoptions.length===0) return;
          me.$store.dispatch("getprojectTableData",{
          "params":'',
          "url":ProjectUrl.projectqueryUrl+"/"+me.$store.state.listId+"/"+me.parentId,
          "this":me
        }
      )
    },
   queryOption(){
       let me=this;
       let optId=this.optionFlag ?  -1 : me.$store.state.selectid;
       if(me.$store.state.nameoptions.length===0) return;
          me.$store.dispatch("getprojectTableData",{
          "params":'',
          "url":ProjectUrl.projectqueryUrl+"/"+me.$store.state.listId+"/"+optId,
          "this":me
       }
      );
    }
  }
 } 
</script>