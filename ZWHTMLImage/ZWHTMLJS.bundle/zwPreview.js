function zwPreviewImageClickAction(){
    var imgs=document.getElementsByTagName('img');
    var length=imgs.length;
    var allSrc='';
    for(var i=0;i<length;i++){
        var img=imgs[i];
        if (allSrc.length) {
            allSrc = allSrc+'^^^'+img.src;
        }else{
            allSrc = img.src;
        }
    }
    for(var i=0;i<length;i++){
        var img=imgs[i];
        img.onclick=function(){
            window.location.href='zw-image-preview:'+allSrc + '###'+this.src;
        }
    }
}
zwPreviewImageClickAction();
