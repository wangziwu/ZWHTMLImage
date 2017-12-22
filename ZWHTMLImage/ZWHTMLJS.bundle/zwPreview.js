// 通知 iPhone UIWebView 加载 url 对应的资源
//PhoneGap处理方式
function loadURL(url) {
    var iFrame;
    iFrame = document.createElement("iframe");
    iFrame.setAttribute("src", url);
    iFrame.setAttribute("style", "display:none;");
    iFrame.setAttribute("height", "0px");
    iFrame.setAttribute("width", "0px");
    iFrame.setAttribute("frameborder", "0");
    document.body.appendChild(iFrame);
    // 发起请求后这个 iFrame 就没用了，所以把它从 dom 上移除掉
    iFrame.parentNode.removeChild(iFrame);
    iFrame = null;
}
function zwPreviewImageClickAction(){
    var imgs=document.getElementsByTagName('img');
    var length=imgs.length;
    var allSrc='';
    for(var i=0;i<length;i++){
        var img=imgs[i];
        var imaSrc = '';
        if (img.src.length){
            imaSrc = img.src;
        }else{
            imaSrc = img.getAttribute('data-original-src');
        }
        if (allSrc.length) {
            allSrc = allSrc+'^^^'+imaSrc;
        }else{
            allSrc = imaSrc;
        }
    }
    for(var i=0;i<length;i++){
        var img=imgs[i];
        img.onclick=function(){
//            window.location.href='zw-image-preview:'+allSrc + '###'+this.src;
            loadURL("zw-image-preview:"+allSrc+ '###'+this.src);
        }
    }
}
zwPreviewImageClickAction();
