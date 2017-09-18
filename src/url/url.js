
// 生产地址
var basePath = "/static/mockJson/";
var versionBase=basePath+'version/';
var projectBase=basePath+'project/';
var url={

  // 版本管理初始化
  versionBath:{
  	// 初始化和查询
  	versionUrl:versionBase+'versiontableinit.json',
  	// 添加
  	versionaddUrl:versionBase+'versionadd.json',
  	//修改
  	versioneditUrl:versionBase+'versionmodify.json',
  	// 删除
  	versiondelUrl:versionBase+'VersionDel.json',
    versiondownUrl:versionBase+'versiondownload.json',
  },
  projectBath:{
    // 初始化
    projectInitUrl:projectBase+'projectInit.json',
    // 查询
    projectqueryUrl:projectBase+'projectquery.json',
    // 模拟
    projectexUrl:projectBase+'projectex.json'
  }
}

//真实地址

// var versionRelBase=basePath+"project/";
// var projectBase=basePath+"node/";
// var url={

//    // 版本管理初始化
//   versionBath:{
//     // 初始化和查询
//     versionUrl:versionRelBase+'query',
//     // 添加
//     versionaddUrl:versionRelBase+'add',
//     //修改
//     versioneditUrl:versionRelBase+'modify',
//     // 删除
//     versiondelUrl:versionRelBase+'delete',
//     // 下载
//     versiondownUrl:versionRelBase+'download',
//   },
//    projectBath:{
//     //初始化
//      projectInitUrl:versionRelBase+'queryAll',
//      // 查询
//      projectqueryUrl:projectBase+'query'
//   }
// }

export default url;